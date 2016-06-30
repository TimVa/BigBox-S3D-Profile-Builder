<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="waitForBed30">0</xsl:param>
    
    <xsl:include href="scripts/Sequence_Builder.xsl"/>

    <xsl:variable name="version">BigBox Hybrid-Pro</xsl:variable>
    <xsl:variable name="SetValues">
        <xsl:call-template name="SetValuesSingle">
            <xsl:with-param name="stepsE">417.5</xsl:with-param>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="DockSequence">
        <xsl:call-template name="DockSequence">
            <xsl:with-param name="dockX">95</xsl:with-param>
            <xsl:with-param name="dockY">235</xsl:with-param>
            <xsl:with-param name="dockYpre">200</xsl:with-param>
        </xsl:call-template>
    </xsl:variable>    
    <xsl:variable name="UndockSequence">
        <xsl:call-template name="UndockSequence">
            <xsl:with-param name="undockX">105</xsl:with-param>
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
        <printExtruders/>
    </xsl:template>

    <xsl:template match="strokeXoverride">
        <strokeXoverride>
            <xsl:value-of select="'300'"/>
        </strokeXoverride>
    </xsl:template>

    <xsl:template match="extruder">
        <xsl:if test="@name = 'Extruder 0 (left)'">
            <xsl:copy>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>

    <xsl:template match="temperatureController">
        <xsl:if test="@name = 'Extruder 0 (left)'">
            <xsl:copy>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:copy>
        </xsl:if>
        <xsl:if test="@name = 'Heated Bed'">
            <xsl:copy>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>

    <xsl:template match="extruder/@name | temperatureController/@name">
        <xsl:attribute name="name">
            <xsl:choose>
                <xsl:when test="../@name = 'Extruder 0 (left)'">
                    <xsl:value-of select="'Extruder'"/>
                </xsl:when>
                <xsl:when test="../@name = 'Heated Bed'">
                    <xsl:value-of select="'Heated Bed'"/>
                </xsl:when>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="startingGcode">
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

    <xsl:template match="endingGcode">
        <endingGcode>
            <xsl:value-of
                select="replace(translate(unparsed-text('scripts/End_Script_Start_Sequence.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"/>
            <xsl:value-of select="$DockSequence"/>
            <xsl:value-of
                select="translate(unparsed-text('scripts/Purge_Sequence_T0.gcode'), '&#xD;&#xA;', ',')"/>
            <xsl:choose>
                <xsl:when test="$waitForBed30=0">
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Single.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                    />                            
                </xsl:when>
                <xsl:when test="$waitForBed30=1">
                    <xsl:value-of
                        select="replace(translate(unparsed-text('scripts/End_Script_End_Sequence_Single_Wait_For_Bed_30.gcode'), '&#xD;&#xA;', ','), '\[Version\]', $version)"
                    />                            
                </xsl:when>
            </xsl:choose>
        </endingGcode>
    </xsl:template>

    <xsl:template
        match="autoConfigureMaterial[contains(@name, 'right') and contains(@name, 'left')]">
        <!-- omit in output -->
    </xsl:template>

    <xsl:template match="autoConfigureExtruders">
        <!-- omit in output -->
    </xsl:template>
</xsl:stylesheet>
