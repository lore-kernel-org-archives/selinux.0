From: "Roberts, William C" <william.c.roberts@intel.com>
To: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "Selinux@tycho.nsa.gov" <Selinux@tycho.nsa.gov>
Subject: executing off of a fusefs
Date: Thu, 9 Jul 2015 23:04:48 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560102C611@ORSMSX103.amr.corp.intel.com>
Content-Type: multipart/alternative;
 boundary="_000_476DC76E7D1DF2438D32BFADF679FC560102C611ORSMSX103amrcor_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_476DC76E7D1DF2438D32BFADF679FC560102C611ORSMSX103amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have this problem on Android, but it's SELinux general. I'd like to get s=
ome info from those in the know.
If you wanted to be able to execute files off of fuse and have the kernel h=
andle the transition, would it be as simple as having the file system retur=
n the getxattr call for the security label?

--_000_476DC76E7D1DF2438D32BFADF679FC560102C611ORSMSX103amrcor_
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
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoNormal">I have this problem on Android, but it&#8217;s SELin=
ux general. I&#8217;d like to get some info from those in the know.<o:p></o=
:p></p>
<p class=3D"MsoNormal">If you wanted to be able to execute files off of fus=
e and have the kernel handle the transition, would it be as simple as havin=
g the file system return the getxattr call for the security label?<o:p></o:=
p></p>
</div>
</body>
</html>

--_000_476DC76E7D1DF2438D32BFADF679FC560102C611ORSMSX103amrcor_--
