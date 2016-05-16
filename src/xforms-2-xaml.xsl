<?xml version="1.0" encoding="UTF-8"?>

<!--
	Document   : xforms-2-xaml.xsl
	Created on : 29. dubna 2016, 0:50
	Author     : Marek Cepcek, Riva Nathans Kepych, Jakub Horniak, add your name here
	Description:
		Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                version="2.0">
	<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />
        
        
        <!-- XForms namespace uri-->
        <xsl:variable name="xf-namespace-uri">http://www.w3.org/2002/xforms</xsl:variable>
        <!-- XAML namespace uri-->
        <xsl:variable name="xaml-namespace-uri">http://schemas.microsoft.com/winfx/2006/xaml/presentation</xsl:variable>
        
	<xsl:template match="/">
            <!-- x:Class="Resources.MainWindow" keeping this here just in case. -->
		<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
                        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
                        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
                        xmlns:local="clr-namespace:XAML_loader"
                        mc:Ignorable="d"
                        Title="MainWindow" Height="400" Width="600"> 

            <WrapPanel Orientation="Vertical"> 
				<!-- select form elements using namespace and element names-->
				<xsl:apply-templates select="//*[namespace-uri()= $xf-namespace-uri
                                                            and (local-name()='input'
                                                            or local-name()='secret'
                                                            or local-name()='textarea'
                                                            or local-name()='output'
                                                            or local-name()='select'
                                                            or local-name()='select1'
                                                            or local-name()='trigger')]"/>
			</WrapPanel>

		</Window>
	</xsl:template>

	<!-- templates to apply to form elements: should determine what
	type the element is and transform it to its equivalent in XAML -->
        
    <!-- template for input element -->
    <xsl:template match="//*[local-name()='input' and namespace-uri()=$xf-namespace-uri]">
        <!--without the namespace attr. the output element has a xmlns="" attr.
        which would cause an exception loading it in the xaml loader. -->
        <xsl:element name="Label" namespace="{$xaml-namespace-uri}">
            <xsl:attribute name="Content">
                <xsl:value-of select="./*[local-name()='label']" />
            </xsl:attribute>   
        </xsl:element>
        
        <xsl:element name="TextBox" namespace="{$xaml-namespace-uri}">             
            <xsl:choose>
                <!-- test if there is a nonempty ref attr in the xforms input element -->                     
                <xsl:when test="./ boolean(@ref) and (@ref != '')">
                    <xsl:attribute name="x:Name">
                        <xsl:value-of select="./@ref"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <!-- empty name attr. would cause an exception loading it in the xaml loader -->
                </xsl:otherwise>
            </xsl:choose>                                    
        </xsl:element>
	</xsl:template>

    <!-- template for secret element -->
    <xsl:template match="//*[local-name()='secret' and namespace-uri()=$xf-namespace-uri]">
        <!--without the namespace attr. the output element has a xmlns="" attr.
        which would cause an exception loading it in the xaml loader. -->
        <xsl:element name="Label" namespace="{$xaml-namespace-uri}">
            <xsl:attribute name="Content">
                <xsl:value-of select="./*[local-name()='label']" />
            </xsl:attribute>   
        </xsl:element>
        
        <xsl:element name="PasswordBox" namespace="{$xaml-namespace-uri}">             
            <xsl:choose>
                <!-- test if there is a nonempty ref attr in the xforms input element -->                     
                <xsl:when test="./ boolean(@ref) and (@ref != '')">
                    <xsl:attribute name="x:Name">
                        <xsl:value-of select="./@ref"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <!-- empty name attr. would cause an exception loading it in the xaml loader -->
                </xsl:otherwise>
            </xsl:choose>                                    
        </xsl:element>
    </xsl:template>

    <!-- template for trigger element -->
    <xsl:template match="//*[local-name()='trigger' and namespace-uri()=$xf-namespace-uri]">
        <!--without the namespace attr. the output element has a xmlns="" attr.
        which would cause an exception loading it in the xaml loader. -->
        <xsl:element name="Button" namespace="{$xaml-namespace-uri}">
            <xsl:attribute name="Content">
                <xsl:value-of select="./*[local-name()='label']" />
            </xsl:attribute>            
            <xsl:choose>
                <!-- test if there is a nonempty ref attr in the xforms input element -->                     
                <xsl:when test="./ boolean(@ref) and (@ref != '')">
                    <xsl:attribute name="x:Name">
                        <xsl:value-of select="./@ref"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <!-- empty name attr. would cause an exception loading it in the xaml loader -->
                </xsl:otherwise>
            </xsl:choose>                                    
        </xsl:element>
    </xsl:template>

    <!-- TO DO template for textarea element -->

    <!-- TO DO template for output element -->

    <!-- TO DO template for select element -->
    
    <!-- TO DO template for select1 element -->
        
</xsl:stylesheet>
