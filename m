From: "Roberts, William C" <william.c.roberts@intel.com>
To: "'seandroid-list@tycho.nsa.gov'" <seandroid-list@tycho.nsa.gov>,
 "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>, "'sds@tycho.nsa.gov'"
 <sds@tycho.nsa.gov>
Subject: RE: unlocked stdio
Date: Wed, 21 Sep 2016 19:57:08 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD0E4E2@ORSMSX103.amr.corp.intel.com>
Content-Type: multipart/alternative;
 boundary="_000_476DC76E7D1DF2438D32BFADF679FC561CD0E4E2ORSMSX103amrcor_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_476DC76E7D1DF2438D32BFADF679FC561CD0E4E2ORSMSX103amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Correction, it's just fgets_unlocked, it appears to support the others.

From: Roberts, William C
Sent: Wednesday, September 21, 2016 12:53 PM
To: 'seandroid-list@tycho.nsa.gov' <seandroid-list@tycho.nsa.gov>; 'selinux=
@tycho.nsa.gov' <selinux@tycho.nsa.gov>; 'sds@tycho.nsa.gov' <sds@tycho.nsa=
.gov>
Subject: unlocked stdio

What was the purpose of using unlocked stdio in libselinux? Bionic doesn't =
support it, is it really necessary?

Bill


--_000_476DC76E7D1DF2438D32BFADF679FC561CD0E4E2ORSMSX103amrcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Correction, it&#8217;s=
 just fgets_unlocked, it appears to support the others.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><a name=3D"_____replyseparator"></a><b>From:</b> Rob=
erts, William C
<br>
<b>Sent:</b> Wednesday, September 21, 2016 12:53 PM<br>
<b>To:</b> 'seandroid-list@tycho.nsa.gov' &lt;seandroid-list@tycho.nsa.gov&=
gt;; 'selinux@tycho.nsa.gov' &lt;selinux@tycho.nsa.gov&gt;; 'sds@tycho.nsa.=
gov' &lt;sds@tycho.nsa.gov&gt;<br>
<b>Subject:</b> unlocked stdio<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">What was the purpose of using unlocked stdio in libs=
elinux? Bionic doesn&#8217;t support it, is it really necessary?<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Bill<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_476DC76E7D1DF2438D32BFADF679FC561CD0E4E2ORSMSX103amrcor_--
