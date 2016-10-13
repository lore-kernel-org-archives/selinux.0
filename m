Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9DJSaD2011183
 for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2016 15:28:36 -0400
From: "Roberts, William C" <william.c.roberts@intel.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: speeding up nodups_specs, need large fc file.
Date: Thu, 13 Oct 2016 19:28:31 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD17F73@ORSMSX103.amr.corp.intel.com>
Content-Type: multipart/alternative;
 boundary="_000_476DC76E7D1DF2438D32BFADF679FC561CD17F73ORSMSX103amrcor_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_476DC76E7D1DF2438D32BFADF679FC561CD17F73ORSMSX103amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I was looking back at my speedup patch for nodups specs...
http://marc.info/?l=3Dselinux&m=3D147249024230263&w=3D2

I was testing before with a large, generated file_context file. I was wonde=
ring what would be a good source for
A desktop version of a file_contexts (textual preference as I can run sefco=
ntext_compile on it) file as well as a binary
policy file....

Should I just use refpolicy?

Bill

--_000_476DC76E7D1DF2438D32BFADF679FC561CD17F73ORSMSX103amrcor_
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
<p class=3D"MsoNormal">I was looking back at my speedup patch for nodups sp=
ecs&#8230;<o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"http://marc.info/?l=3Dselinux&amp;m=3D147=
249024230263&amp;w=3D2">http://marc.info/?l=3Dselinux&amp;m=3D1472490242302=
63&amp;w=3D2</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I was testing before with a large, generated file_co=
ntext file. I was wondering what would be a good source for<o:p></o:p></p>
<p class=3D"MsoNormal">A desktop version of a file_contexts (textual prefer=
ence as I can run sefcontext_compile on it) file as well as a binary<o:p></=
o:p></p>
<p class=3D"MsoNormal">policy file&#8230;.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Should I just use refpolicy?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Bill<o:p></o:p></p>
</div>
</body>
</html>

--_000_476DC76E7D1DF2438D32BFADF679FC561CD17F73ORSMSX103amrcor_--
