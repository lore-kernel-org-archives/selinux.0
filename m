Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2GEERO7018510
 for <selinux@tycho.nsa.gov>; Mon, 16 Mar 2015 10:14:27 -0400
From: "Minear, Spencer" <Spencer_Minear@mcafee.com>
To: "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>
Subject: SE Linux savvy union FS?
Date: Mon, 16 Mar 2015 14:13:09 +0000
Message-ID: <81524047c6794563a02a332aef65fd96@MIVEXUSR1N02.corpzone.internalzone.com>
Content-Type: multipart/alternative;
 boundary="_000_81524047c6794563a02a332aef65fd96MIVEXUSR1N02corpzoneint_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_81524047c6794563a02a332aef65fd96MIVEXUSR1N02corpzoneint_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am looking for a union file system that can provide copy on write when ov=
erlaid on a SE Linux labeled read only  squash file system, that will provi=
de the ability to manage the SE Linux file contexts using the same rules us=
ed when building the original SE Linux labeled squash file system.



I've found a number of pages on the topic of union file systems related to =
Linux.  However many appear to be out of data and none lead to a solution t=
o my question.   I found at least one page that suggests that what I'm look=
ing for has been or can be done, but I never found any specifics that sugge=
sted how to actually do it, and again it may have been out of date relative=
 to the facilities that I am using.



So my questions are:



1.       Does this capability exists?

2.       Are there some how-to examples that show how to do it?



FYI, I am using a Debian distribution so information on that distribution o=
f Linux would be most useful.



Thanks for any and all pointers that you may be able to provide.



Spencer Minear

--_000_81524047c6794563a02a332aef65fd96MIVEXUSR1N02corpzoneint_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1148977713;
	mso-list-type:hybrid;
	mso-list-template-ids:-1475978958 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">I am looking for a union file system that can pro=
vide copy on write when overlaid on a SE Linux labeled read only &nbsp;squa=
sh file system, that will provide the ability to manage the SE Linux file c=
ontexts using the same rules used when
 building the original SE Linux labeled squash file system. <o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">I've found a number of pages on the topic of unio=
n file systems related to Linux.&nbsp; However many appear to be out of dat=
a and none lead to a solution to my question. &nbsp;&nbsp;I found at least =
one page that suggests that what I'm looking for
 has been or can be done, but I never found any specifics that suggested ho=
w to actually do it, and again it may have been out of date relative to the=
 facilities that I am using.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">So my questions are:<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText" style=3D"margin-left:.5in;text-indent:-.25in;mso-=
list:l0 level1 lfo1">
<![if !supportLists]><span style=3D"mso-list:Ignore">1.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Does this capability exists?<o:p></o:p></p>
<p class=3D"MsoPlainText" style=3D"margin-left:.5in;text-indent:-.25in;mso-=
list:l0 level1 lfo1">
<![if !supportLists]><span style=3D"mso-list:Ignore">2.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Are there some how-to examples that show how to do =
it?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">FYI, I am using a Debian distribution so informat=
ion on that distribution of Linux would be most useful.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks for any and all pointers that you may be a=
ble to provide.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Spencer Minear<o:p></o:p></p>
</div>
</body>
</html>

--_000_81524047c6794563a02a332aef65fd96MIVEXUSR1N02corpzoneint_--
