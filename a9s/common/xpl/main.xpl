<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" 
  xmlns:tr="http://transpect.io"
  version="1.0" 
  name="main">
  
  <p:input port="source">
    <p:document href="http://this.transpect.io/conf/conf.xml"/>
  </p:input>
  
  <p:output port="result"/>
  
  <p:option name="file"/>
  <p:option name="debug" select="'yes'"/>
  <p:option name="debug-dir-uri" select="'debug'"/>
  <p:option name="status-dir-uri" select="'status'"/>
  
  <p:import href="http://transpect.io/cascade/xpl/paths.xpl"/>
  <p:import href="http://transpect.io/xproc-util/file-uri/xpl/file-uri.xpl"/>
  
  <p:sink/>
  
  <tr:file-uri name="normalize-filename">
    <p:with-option name="filename" select="$file"/>
  </tr:file-uri>
  
  <p:sink/>
  
  <p:load name="load-paths-xsl">
    <p:with-option name="href" select="/tr:conf/@paths-xsl-uri">
      <p:pipe port="source" step="main"/>
    </p:with-option>
  </p:load>
  
  <tr:paths>
    <p:with-option name="file" select="/c:result/@local-href">
      <p:pipe port="result" step="normalize-filename"/>
    </p:with-option>
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="status-dir-uri" select="$status-dir-uri"/>
    <p:input port="stylesheet">
      <p:pipe port="result" step="load-paths-xsl"/>
    </p:input>
    <p:input port="conf">
      <p:pipe port="source" step="main"/>
    </p:input>
    <p:input port="params">
      <p:empty/>
    </p:input> 
  </tr:paths>
  
</p:declare-step>