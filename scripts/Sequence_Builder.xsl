<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:template name="DockSequence">
        <xsl:param name="dockX"/>
        <xsl:param name="dockY"/>
        <xsl:param name="dockYpre"/>

        <xsl:variable name="DockSequence"
            select="translate(unparsed-text('Dock_Sequence.gcode'), '&#xD;&#xA;', ',')"/>

        <xsl:value-of
            select="replace(replace(replace($DockSequence, '%dockX%', $dockX), '%dockY%', $dockY), '%dockYpre%', $dockYpre)"
        />
    </xsl:template>

    <xsl:template name="UndockSequence">
        <xsl:param name="undockX"/>
        <xsl:param name="undockY"/>
        <xsl:param name="undockYpost"/>

        <xsl:variable name="UndockSequence"
            select="translate(unparsed-text('Undock_Sequence.gcode'), '&#xD;&#xA;', ',')"/>

        <xsl:value-of
            select="replace(replace(replace($UndockSequence, '%undockX%', $undockX), '%undockY%', $undockY), '%undockYpost%', $undockYpost)"
        />
    </xsl:template>

    <xsl:template name="SetValuesDual">
        <xsl:param name="offsetX"/>
        <xsl:param name="offsetY"/>
        <xsl:param name="stepsE"></xsl:param>
        
        <xsl:value-of select="';set values,'"/>
        <xsl:value-of select="concat(';M92 E', $stepsE, ' ; adjust steps per mm for your filament,')"/>
        <xsl:value-of select="concat('M218 T1 X', $offsetX, ' Y', $offsetY, ' ; set extruder 1 offset,,')"/>
    </xsl:template>
    
    <xsl:template name="SetValuesSingle">
        <xsl:param name="stepsE"></xsl:param>
        
        <xsl:value-of select="';set values,'"/>
        <xsl:value-of select="concat(';M92 E', $stepsE, ' ; adjust steps per mm for your filament,,')"/>
    </xsl:template>

</xsl:stylesheet>
