<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:template
        match="autoConfigureMaterial[@name = 'Colorfabb PLA/PHA']/temperatureController[@name = 'Heated Bed']/setpoint[@layer = '1']/@temperature">
        <xsl:attribute name="temperature">
            <xsl:choose>
                <xsl:when test="$PEIPlate = 1">
                    <xsl:value-of select="'55'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <xsl:template
        match="autoConfigureMaterial[@name = 'Colorfabb XT']/temperatureController[@name = 'Heated Bed']/setpoint[@layer = '1']/@temperature">
        <xsl:attribute name="temperature">
            <xsl:choose>
                <xsl:when test="$PEIPlate = 1">
                    <xsl:value-of select="'80'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <xsl:template
        match="autoConfigureMaterial[@name = 'spoolWorks Edge']/temperatureController[@name = 'Heated Bed']/setpoint[@layer = '1']/@temperature">
        <xsl:attribute name="temperature">
            <xsl:choose>
                <xsl:when test="$PEIPlate = 1">
                    <xsl:value-of select="'85'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

</xsl:stylesheet>
