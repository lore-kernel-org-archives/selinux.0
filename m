From: "Ed Street" <edstreet@street-tek.com>
To: "SELinux" <SELinux@tycho.nsa.gov>, "Russell Coker" <russell@coker.com.au>
Subject: apache under debian
Date: Mon, 31 May 2004 13:43:30 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00A1_01C44715.430CBC90"
Message-Id: <20040531174331.874163A404E@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00A1_01C44715.430CBC90
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit

Hello,

 

To be able to read the /var/www/ directory I had to add the following line.

 

#http stuff

allow httpd_t var_t:file { getattr read };

 

Yet /var/www is this.

 

drwxrwxrwx  www-data www-data system_u:object_r:httpd_sys_content_t www

 

does this mean we need some additional rules for apache?

 

Ed


---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.692 / Virus Database: 453 - Release Date: 5/28/2004
 

------=_NextPart_000_00A1_01C44715.430CBC90
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DWindows-1252">


<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>To be able to read the /var/www/ directory I had to =
add the
following line.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>#http stuff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>allow httpd_t var_t:file { getattr read =
};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Yet /var/www is this.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>drwxrwxrwx&nbsp; www-data www-data
system_u:object_r:httpd_sys_content_t www<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>does this mean we need some additional rules for =
apache?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ed<o:p></o:p></span></font></p>

</div>

</body>

</html>
<BR>

<P><FONT SIZE=3D2>---<BR>
<BR>
Checked by AVG anti-virus system (http://www.grisoft.com).<BR>
Version: 6.0.692 / Virus Database: 453 - Release Date: 5/28/2004<BR>
</FONT> </P>

------=_NextPart_000_00A1_01C44715.430CBC90--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
