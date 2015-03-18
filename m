Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2I2UPb7029716
 for <selinux@tycho.nsa.gov>; Tue, 17 Mar 2015 22:30:25 -0400
From: kuangjiou <kuangjiou@huawei.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Got some problem when using the type_transition, look for some
 helps! thank you!
Date: Wed, 18 Mar 2015 02:22:44 +0000
Message-ID: <60ABE64B4BE4AC45964F1A967BA76CB201569BC3@szxeml522-mbx.china.huawei.com>
Content-Type: multipart/alternative;
 boundary="_000_60ABE64B4BE4AC45964F1A967BA76CB201569BC3szxeml522mbxchi_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_60ABE64B4BE4AC45964F1A967BA76CB201569BC3szxeml522mbxchi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,everyone!

I am try to use the new features of the type_transition that can support to=
 determine the type of the new file by the name of this new file,And when I
use the type_transisiton in my own policy module like this:

type_transition unconfined_t dentry_t:file file_t myfile;

I got the error: 'syntax error' at token 'myfile' on line 1195:

It seems like didn't support the fifth parameter 'myfile', And I am using t=
he checkmodule (version 2.3) to compile my policy module, but I am not sure
the the version of the linux kernel (Linux nkgcinwslx00671 2.6.32.12-0.7-de=
fault #1 SMP 2010-05-20 11:14:20 +0200 x86_64 x86_64 x86_64 GNU/Linux) is
new enough to support this features.(I think the compiling should have noth=
ing to do with the kernel?)

so, could anybody give me some suggestions to resolve this problem? I am  l=
ooking  forward to your replies! Thank you very much!


Sylar

--_000_60ABE64B4BE4AC45964F1A967BA76CB201569BC3szxeml522mbxchi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@\5B8B\4F53";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello,everyone!<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I am try to use the new feature=
s of the type_transition that can support to determine the type of the new =
file by the name of this new file,And when I
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">use the type_transisiton in my =
own policy module like this:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">type_transition unconfined_t de=
ntry_t:file file_t myfile;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I got the error: 'syntax error'=
 at token 'myfile' on line 1195:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">It seems like didn't support th=
e fifth parameter 'myfile', And I am using the checkmodule (version 2.3) to=
 compile my policy module, but I am not sure
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">the the version of the linux ke=
rnel (Linux nkgcinwslx00671 2.6.32.12-0.7-default #1 SMP 2010-05-20 11:14:2=
0 &#43;0200 x86_64 x86_64 x86_64 GNU/Linux) is
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">new enough to support this feat=
ures.(I think the compiling should have nothing to do with the kernel?)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">so, could anybody give me some =
suggestions to resolve this problem? I am&nbsp; looking&nbsp; forward to yo=
ur replies! Thank you very much!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sylar<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_60ABE64B4BE4AC45964F1A967BA76CB201569BC3szxeml522mbxchi_--
