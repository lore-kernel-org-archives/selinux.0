Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8N1dtgo014812
 for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2014 21:39:56 -0400
From: kuangjiou <kuangjiou@huawei.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: problem about making selinux userspace
Date: Tue, 23 Sep 2014 01:39:37 +0000
Message-ID: <60ABE64B4BE4AC45964F1A967BA76CB2BBCF4F@SZXEML507-MBX.china.huawei.com>
Content-Type: multipart/alternative;
 boundary="_000_60ABE64B4BE4AC45964F1A967BA76CB2BBCF4FSZXEML507MBXchina_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_60ABE64B4BE4AC45964F1A967BA76CB2BBCF4FSZXEML507MBXchina_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

i have some problems when make selinux userspace (version: selinux-20140826=
-rc1) in 64-bit sles 11 sp1(the version of kernel is  2.6.32).
I get the error messeges below when I run " make LIBDIR=3D/usr/lib64 SHLIBD=
IR=3D/lib64 install install-pywrap relabel "
can anyone help out with this problem? thanks!

cc1: error: unrecognized command line option "-Wbuiltin-macro-redefined"
cc1: error: unrecognized command line option "-Wmudflap"
cc1: error: unrecognized command line option "-Wpacked-bitfield-compat"
cc1: error: unrecognized command line option "-Wsync-nand"
cc1: error: unrecognized command line option "-Wcpp"
cc1: error: unrecognized command line option "-Wdouble-promotion"
cc1: error: unrecognized command line option "-Wsuggest-attribute=3Dconst"
cc1: error: unrecognized command line option "-Wsuggest-attribute=3Dnoretur=
n"
cc1: error: unrecognized command line option "-Wsuggest-attribute=3Dpure"
cc1: error: unrecognized command line option "-Wtrampolines"
cc1: error: unrecognized command line option "-Wjump-misses-init"
cc1: error: unrecognized command line option "-Wframe-larger-than=3D32768"
cc1: error: unrecognized command line option "-Wno-suggest-attribute=3Dpure=
"
cc1: error: unrecognized command line option "-Wno-suggest-attribute=3Dcons=
t"
make[2]: *** [avc.o] Error 1
make[2]: Leaving directory `/home/selinux-20140826-rc1/libselinux/src'
make[1]: *** [install-pywrap] Error 2
make[1]: Leaving directory `/home/selinux-20140826-rc1/libselinux'
make: *** [install-pywrap] Error 1

--_000_60ABE64B4BE4AC45964F1A967BA76CB2BBCF4FSZXEML507MBXchina_
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
<p class=3D"MsoNormal"><span lang=3D"EN-US">i have some problems when make =
selinux userspace (version: selinux-20140826-rc1) in 64-bit sles 11 sp1(the=
 version of kernel is&nbsp; 2.6.32).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I get the error messeges below =
when I run &quot; make LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64 install instal=
l-pywrap relabel &quot;&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">can anyone help out with this p=
roblem? thanks!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wbuiltin-macro-redefined&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wmudflap&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wpacked-bitfield-compat&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wsync-nand&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wcpp&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wdouble-promotion&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wsuggest-attribute=3Dconst&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wsuggest-attribute=3Dnoreturn&quot;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wsuggest-attribute=3Dpure&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wtrampolines&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wjump-misses-init&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wframe-larger-than=3D32768&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wno-suggest-attribute=3Dpure&quot;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">cc1: error: unrecognized comman=
d line option &quot;-Wno-suggest-attribute=3Dconst&quot;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">make[2]: *** [avc.o] Error 1<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">make[2]: Leaving directory `/ho=
me/selinux-20140826-rc1/libselinux/src'<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">make[1]: *** [install-pywrap] E=
rror 2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">make[1]: Leaving directory `/ho=
me/selinux-20140826-rc1/libselinux'<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">make: *** [install-pywrap] Erro=
r 1<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_60ABE64B4BE4AC45964F1A967BA76CB2BBCF4FSZXEML507MBXchina_--
