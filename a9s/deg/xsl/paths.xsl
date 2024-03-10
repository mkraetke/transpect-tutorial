<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:tr="http://transpect.io"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <xsl:import href="http://transpect.io/cascade/xsl/paths.xsl"/>
  <xsl:param name="filenames" as="xs:string?"/>

	<xsl:variable name="regex" select="'^(\w+)_(\d{4,6}|\d{3}-\d{5})_.+$'" as="xs:string"/>
  
  <!-- e.g. publisher_55555_random-text.docx -->
  
  <xsl:function name="tr:parse-file-name" as="attribute(*)*">
    <xsl:param name="filename" as="xs:string?"/>
    <xsl:variable name="basename" select="tr:basename($filename)" as="xs:string"/>
    <xsl:variable name="ext" select="tr:ext($filename)" as="xs:string"/>
    <xsl:attribute name="ext" select="$ext"/>
    <xsl:attribute name="base" select="$basename"/>
    <xsl:analyze-string select="$basename" regex="{$regex}">
      <xsl:matching-substring>
        <xsl:attribute name="publisher" select="regex-group(1)"/>
        <xsl:attribute name="production-line" select="regex-group(4)"/>
        <xsl:attribute name="work" select="."/>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:attribute name="work" select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:function>
  
</xsl:stylesheet>
