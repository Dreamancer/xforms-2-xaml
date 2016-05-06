<?xml version="1.0" encoding="UTF-8"?>

<!--
	Document   : xforms-2-xaml.xsl
	Created on : 29. dubna 2016, 0:50
	Author     : Marek Cepcek
	Description:
		Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" encoding="utf-8" indent="yes" />

	<xsl:template match="/">
		<Window x:Class = "FirstStepDemo.MainWindow"
		xmlns = "http://schemas.microsoft.com/winfx/2006/xaml/presentation"
		xmlns:x = "http://schemas.microsoft.com/winfx/2006/xaml"
		xmlns:d = "http://schemas.microsoft.com/expression/blend/2008"
		xmlns:mc = "http://schemas.openxmlformats.org/markup-compatibility/2006" 
		xmlns:local = "clr-namespace:FirstStepDemo" 
		mc:Ignorable = "d" Title = "MainWindow" Height = "350" Width = "604"> 

			<Grid></Grid> 

		</Window> 
	</xsl:template>

</xsl:stylesheet>
