<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:include href="scripts/Sequence_Builder.xsl"/>

    <xsl:variable name="version">BigBox Dual</xsl:variable>
    <xsl:variable name="SetValues">
        <xsl:call-template name="SetValuesSingle">
            <xsl:with-param name="stepsE">304</xsl:with-param>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="DockSequence">
        <xsl:call-template name="DockSequence">
            <xsl:with-param name="dockX">70</xsl:with-param>
            <xsl:with-param name="dockY">240</xsl:with-param>
            <xsl:with-param name="dockYpre">200</xsl:with-param>
        </xsl:call-template>
    </xsl:variable>    
    <xsl:variable name="UndockSequence">
        <xsl:call-template name="UndockSequence">
            <xsl:with-param name="undockX">80</xsl:with-param>
            <xsl:with-param name="undockY">240</xsl:with-param>
            <xsl:with-param name="undockYpost">200</xsl:with-param>
        </xsl:call-template>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:result-document href="profiles/{$version}.fff">
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

    <xsl:template match="profile/startingGcode">
        <startingGcode>
            <xsl:value-of
                select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_T0.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
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
    </xsl:template>

    <xsl:template match="autoConfigureExtruders/startingGcode">
        <xsl:choose>
            <xsl:when test="contains(../@name, 'Both')">
                <startingGcode>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_T0+T1.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
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
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_T0.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
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
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/Start_Script_Start_Sequence_T1.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
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
                select="translate(unparsed-text('scripts/Purge_Sequence_T0.gcode'), '&#xD;&#xA;', ',')"/>
            <xsl:value-of
                select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
            />
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
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                    />
                </endingGcode>
            </xsl:when>
            <xsl:when test="contains(../@name, 'left')">
                <endingGcode>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_Start_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                    <xsl:value-of select="$DockSequence"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Purge_Sequence_T0.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                    />
                </endingGcode>
            </xsl:when>
            <xsl:when test="contains(../@name, 'right')">
                <endingGcode>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_Start_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
                    <xsl:value-of select="$DockSequence"/>
                    <xsl:value-of
                        select="translate(unparsed-text('scripts/Purge_Sequence_T1.gcode'), '&#xD;&#xA;', ',')"/>
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Dual.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                    />
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

</xsl:stylesheet>
