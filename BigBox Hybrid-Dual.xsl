<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="Leveling">ABL</xsl:param>
    <xsl:param name="PEIPlate">0</xsl:param>

    <xsl:include href="scripts/PEIPlateTemps.xsl"/>
    <xsl:include href="scripts/Sequence_Builder.xsl"/>

    <xsl:variable name="version">BigBox Hybrid-Dual</xsl:variable>
    <xsl:variable name="SetValues">
        <xsl:call-template name="SetValuesDual">
            <xsl:with-param name="offsetX">38</xsl:with-param>
            <xsl:with-param name="offsetY">0</xsl:with-param>
            <xsl:with-param name="stepsE">417.5</xsl:with-param>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="DockSequence">
        <xsl:call-template name="DockSequence">
            <xsl:with-param name="dockX">70</xsl:with-param>
            <xsl:with-param name="dockY">235</xsl:with-param>
            <xsl:with-param name="dockYpre">200</xsl:with-param>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="UndockSequence">
        <xsl:call-template name="UndockSequence">
            <xsl:with-param name="undockX">80</xsl:with-param>
            <xsl:with-param name="undockY">235</xsl:with-param>
            <xsl:with-param name="undockYpost">200</xsl:with-param>
        </xsl:call-template>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:result-document href="./profiles/{$version}.fff">
            <xsl:apply-templates/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="profile/@name">
        <xsl:attribute name="name">
            <xsl:value-of select="$version"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="profile/@version">
        <xsl:attribute name="version">
            <xsl:value-of
                select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01] [H1]:[m01]:[s01]')"
            />
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="printExtruders">
        <printExtruders>
            <xsl:value-of select="'Extruder 1 (right) only'"/>
        </printExtruders>
    </xsl:template>

    <xsl:template
        match="profile/primaryExtruder | profile/raftExtruder | profile/skirtExtruder | profile/infillExtruder | profile/supportExtruder">
        <xsl:element name="{local-name()}">
            <xsl:value-of select="'1'"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="strokeXoverride">
        <strokeXoverride>
            <xsl:value-of select="'300'"/>
        </strokeXoverride>
    </xsl:template>

    <xsl:template match="profile/startingGcode">
        <startingGcode>
            <xsl:choose>
                <xsl:when test="$Leveling = 'ABL'">
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_ABL_T1.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                </xsl:when>
                <xsl:when test="$Leveling = 'MBL'">
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_MBL_T1.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                </xsl:when>
            </xsl:choose>
            <xsl:value-of select="$SetValues"/>
            <xsl:value-of select="$DockSequence"/>
            <xsl:value-of
                select="translate(unparsed-text('scripts/Heat_Sequence_T1.gcode'), '&#xD;&#xA;', ',')"/>
            <xsl:value-of
                select="translate(unparsed-text('scripts/Prime_Sequence_T1.gcode'), '&#xD;&#xA;', ',')"/>
            <xsl:value-of select="$UndockSequence"/>
            <xsl:value-of
                select="replace(translate(unparsed-text('scripts/Start_Script_End_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
            />
        </startingGcode>
    </xsl:template>

    <xsl:template match="autoConfigureExtruders/startingGcode">
        <xsl:choose>
            <xsl:when test="contains(../@name, 'Both')">
                <startingGcode>
                    <xsl:choose>
                        <xsl:when test="$Leveling = 'ABL'">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_ABL_T0+T1.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                        </xsl:when>
                        <xsl:when test="$Leveling = 'MBL'">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_MBL_T0+T1.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:value-of select="$SetValues"/>
                    <xsl:value-of select="$DockSequence"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Heat_Sequence_T0+T1.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:value-of select="$UndockSequence"/>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/Start_Script_End_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                    />
                </startingGcode>
            </xsl:when>
            <xsl:when test="contains(../@name, 'left')">
                <startingGcode>
                    <xsl:choose>
                        <xsl:when test="$Leveling = 'ABL'">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_ABL_T0.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                        </xsl:when>
                        <xsl:when test="$Leveling = 'MBL'">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_MBL_T0.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:value-of select="$SetValues"/>
                    <xsl:value-of select="$DockSequence"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Heat_Sequence_T0.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Prime_Sequence_T0.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:value-of select="$UndockSequence"/>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/Start_Script_End_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                    />
                </startingGcode>
            </xsl:when>
            <xsl:when test="contains(../@name, 'right')">
                <startingGcode>
                    <xsl:choose>
                        <xsl:when test="$Leveling = 'ABL'">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_ABL_T1.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                        </xsl:when>
                        <xsl:when test="$Leveling = 'MBL'">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_MBL_T1.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:value-of select="$SetValues"/>
                    <xsl:value-of select="$DockSequence"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Heat_Sequence_T1.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Prime_Sequence_T1.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:value-of select="$UndockSequence"/>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/Start_Script_End_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                    />
                </startingGcode>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="profile/endingGcode">
        <endingGcode>
            <xsl:value-of
                select="replace(translate(unparsed-text('scripts/End_Script_Start_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
            <xsl:value-of select="$DockSequence"/>
            <xsl:value-of
                select="translate(unparsed-text('scripts/Purge_Sequence_T1.gcode'), '&#xD;&#xA;', ',')"/>
            <xsl:choose>
                <xsl:when test="$PEIPlate = 0">
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                    />
                </xsl:when>
                <xsl:when test="$PEIPlate = 1">
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual_Wait_For_Bed_30.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                    />
                </xsl:when>
            </xsl:choose>
        </endingGcode>
    </xsl:template>

    <xsl:template match="autoConfigureExtruders/endingGcode">
        <xsl:choose>
            <xsl:when test="contains(../@name, 'Both')">
                <endingGcode>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_Start_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                    <xsl:value-of select="$DockSequence"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Purge_Sequence_T0.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Purge_Sequence_T1.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:choose>
                        <xsl:when test="$PEIPlate = 0">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                            />
                        </xsl:when>
                        <xsl:when test="$PEIPlate = 1">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual_Wait_For_Bed_30.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                            />
                        </xsl:when>
                    </xsl:choose>
                </endingGcode>
            </xsl:when>
            <xsl:when test="contains(../@name, 'left')">
                <endingGcode>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_Start_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                    <xsl:value-of select="$DockSequence"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Purge_Sequence_T0.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:choose>
                        <xsl:when test="$PEIPlate = 0">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                            />
                        </xsl:when>
                        <xsl:when test="$PEIPlate = 1">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual_Wait_For_Bed_30.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                            />
                        </xsl:when>
                    </xsl:choose>
                </endingGcode>
            </xsl:when>
            <xsl:when test="contains(../@name, 'right')">
                <endingGcode>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_Start_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                    <xsl:value-of select="$DockSequence"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Purge_Sequence_T1.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:choose>
                        <xsl:when test="$PEIPlate = 0">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                            />
                        </xsl:when>
                        <xsl:when test="$PEIPlate = 1">
                            <xsl:value-of
                                select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual_Wait_For_Bed_30.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                            />
                        </xsl:when>
                    </xsl:choose>
                </endingGcode>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template
        match="autoConfigureExtruders/toolChangeGcode[contains(../@name, 'Oozeless/Ram purge')]">
        <toolChangeGcode>
            <xsl:value-of
                select="replace(translate(unparsed-text('scripts/Tool_Change_Script_Start_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
            <xsl:value-of select="$DockSequence"/>
            <xsl:value-of
                select="translate(unparsed-text('scripts/Tool_Change_Ram_Purge_Sequence.gcode'), '&#xD;&#xA;', ',')"/>
            <xsl:value-of select="$UndockSequence"/>
            <xsl:value-of
                select="replace(translate(unparsed-text('scripts/Tool_Change_Script_End_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
            />
        </toolChangeGcode>
    </xsl:template>

    <xsl:template
        match="autoConfigureMaterial/@name[contains(../@name, 'right') and contains(../@name, 'left')]">
        <xsl:attribute name="name">
            <xsl:value-of
                select="replace(replace(replace(../@name, 'right', 'xxx'), 'left', 'right'), 'xxx', 'left')"
            />
        </xsl:attribute>
    </xsl:template>

    <xsl:template
        match="autoConfigureExtruders/primaryExtruder | autoConfigureExtruders/raftExtruder | autoConfigureExtruders/skirtExtruder | autoConfigureExtruders/infillExtruder | autoConfigureExtruders/supportExtruder">
        <xsl:choose>
            <xsl:when test="contains(../@name, 'Both') and . = '0'">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="'1'"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="contains(../@name, 'Both') and . = '1'">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="'0'"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
