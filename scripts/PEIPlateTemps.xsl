<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- Colorfabb PLA/PHA -->
    <xsl:template
        match="autoConfigureMaterial[@name = 'Colorfabb PLA/PHA']/temperatureController[starts-with(@name, 'Extruder')]/setpoint">
        <xsl:choose>
            <xsl:when test="$PEIPlate = 1">
                <xsl:element name="setpoint">
                    <xsl:attribute name="layer">
                        <xsl:value-of select="'1'"/>
                    </xsl:attribute>
                    <xsl:attribute name="temperature">
                        <xsl:value-of select="'200'"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="setpoint">
                    <xsl:attribute name="layer">
                        <xsl:value-of select="'3'"/>
                    </xsl:attribute>
                    <xsl:attribute name="temperature">
                        <xsl:value-of select="'190'"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template
        match="autoConfigureMaterial[@name = 'Colorfabb PLA/PHA']/temperatureController[@name = 'Heated Bed']/setpoint">
        <xsl:choose>
            <xsl:when test="$PEIPlate = 1">
                <xsl:element name="setpoint">
                    <xsl:attribute name="layer">
                        <xsl:value-of select="'1'"/>
                    </xsl:attribute>
                    <xsl:attribute name="temperature">
                        <xsl:value-of select="'62'"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="setpoint">
                    <xsl:attribute name="layer">
                        <xsl:value-of select="'3'"/>
                    </xsl:attribute>
                    <xsl:attribute name="temperature">
                        <xsl:value-of select="'55'"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Colorfabb XT -->
    <xsl:template
        match="autoConfigureMaterial[@name = 'Colorfabb XT']/temperatureController[@name = 'Heated Bed']/setpoint[@layer = '1']/@temperature">
        <xsl:choose>
            <xsl:when test="$PEIPlate = 1">
                <xsl:element name="setpoint">
                    <xsl:attribute name="layer">
                        <xsl:value-of select="'1'"/>
                    </xsl:attribute>
                    <xsl:attribute name="temperature">
                        <xsl:value-of select="'80'"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="setpoint">
                    <xsl:attribute name="layer">
                        <xsl:value-of select="'3'"/>
                    </xsl:attribute>
                    <xsl:attribute name="temperature">
                        <xsl:value-of select="'70'"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- spoolWorks Edge -->
    <xsl:template
        match="autoConfigureMaterial[@name = 'spoolWorks Edge']/temperatureController[@name = 'Heated Bed']">
        <xsl:choose>
            <xsl:when test="$PEIPlate = 1">
                <xsl:element name="setpoint">
                    <xsl:attribute name="layer">
                        <xsl:value-of select="'1'"/>
                    </xsl:attribute>
                    <xsl:attribute name="temperature">
                        <xsl:value-of select="'85'"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:element name="setpoint">
                    <xsl:attribute name="layer">
                        <xsl:value-of select="'3'"/>
                    </xsl:attribute>
                    <xsl:attribute name="temperature">
                        <xsl:value-of select="'75'"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
