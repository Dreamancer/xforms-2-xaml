<?xml version="1.0" encoding="UTF-8"?>

<!--
	Document   : xforms-2-xaml.xsl
	Created on : 29. dubna 2016, 0:50
	Author     : Marek Cepcek, Riva Nathans Kepych, add your name here
	Description:
		Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                version="2.0">
	<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />
        
        
        <!-- XForms namespace uri-->
        <xsl:variable name="xf-namespace-uri">http://www.w3.org/2002/xforms</xsl:variable>
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
			 <!-- examples of how to make form elements in XAML: delete later -->

				<!-- XAML: example button -->
				<Button x:Name="button_name" Content="button"/>

				<!-- XAML: example checkbox -->
				<CheckBox x:Name="checkbox_name" Content="checkbox"/>

				<!-- XAML: example date -->
				<Calendar x:Name="calendar_name" SelectionMode="MultipleRange"/>  

				<!-- XAML: example password -->
				<PasswordBox x:Name="password_name"/>

				<!-- XAML: example textbox -->
				<TextBox x:Name="textbox_name"/>

				<!-- XAML: example read-only text -->
				<TextBlock>some read-only text</TextBlock>

				<!-- actual project code here -->

				<!-- select form elements using namespace -->
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
		<!-- process element here -->
            <xsl:element name="Label" namespace="{$xaml-namespace-uri}">
                <xsl:attribute name="Content">
                    <xsl:value-of select="./*[local-name()='label']" />
                </xsl:attribute>   
            </xsl:element>
            <xsl:element name="TextBox" namespace="{$xaml-namespace-uri}">             
                    <xsl:choose>
                        <xsl:when test="./@ref != ''">
                            <xsl:attribute name="x:Name">
                            <xsl:value-of select="./@ref"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                
            </xsl:element>
	</xsl:template>

</xsl:stylesheet>
