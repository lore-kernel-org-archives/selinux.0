Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA6Cm8F3025636
 for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2014 07:48:08 -0500
From: kuangjiou <kuangjiou@huawei.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Got  Segmentation fault when use  avc_context_to_sid() funtion!!
 can anyone help me? (there is some mistakes in my last emeil ,sorry! )
Date: Thu, 6 Nov 2014 12:47:56 +0000
Message-ID: <60ABE64B4BE4AC45964F1A967BA76CB2BBE012@SZXEML507-MBX.china.huawei.com>
Content-Type: multipart/alternative;
 boundary="_000_60ABE64B4BE4AC45964F1A967BA76CB2BBE012SZXEML507MBXchina_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_60ABE64B4BE4AC45964F1A967BA76CB2BBE012SZXEML507MBXchina_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,everyone!
I am learning how to use the selinux userspace apps recent.And I got Segmen=
tation fault when I use the  avc_context_to_sid() funtion, dose anyone know=
 how to resolve this problem? Thank you very much!

The following is my testing code with avc_context_to_sid()  funtion

#include <selinux/selinux.h>
#include <selinux/avc.h>
#include <stdlib.h>
#include <stdio.h>

int main()
{
         const char *scon =3D "system_u:object_r:unconfined_t";
         security_id_t sid;
         avc_context_to_sid(scon, &sid);

         return 0;
}

Sylar

--_000_60ABE64B4BE4AC45964F1A967BA76CB2BBE012SZXEML507MBXchina_
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
<p class=3D"MsoNormal"><span lang=3D"EN-US">I am learning how to use the se=
linux userspace apps recent.And I got Segmentation fault when I use the&nbs=
p; avc_context_to_sid() funtion, dose anyone know how to resolve this probl=
em? Thank you very much!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The following is my testing cod=
e with avc_context_to_sid() &nbsp;funtion<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#include &lt;selinux/selinux.h&=
gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#include &lt;selinux/avc.h&gt;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#include &lt;stdlib.h&gt;<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#include &lt;stdio.h&gt;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">int main()<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">{<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; const char *scon =3D &quot;system_u:object_r:unconfined_t=
&quot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; security_id_t sid; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; avc_context_to_sid(scon, &amp;sid);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sylar<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_60ABE64B4BE4AC45964F1A967BA76CB2BBE012SZXEML507MBXchina_--
