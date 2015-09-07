Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t87E6QGN021312
 for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2015 10:06:29 -0400
From: kuangjiou <kuangjiou@huawei.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: got some problems with the type_transition rules
Date: Mon, 7 Sep 2015 11:22:26 +0000
Message-ID: <60ABE64B4BE4AC45964F1A967BA76CB201F75356@SZXEMI502-MBS.china.huawei.com>
Content-Type: multipart/alternative;
 boundary="_000_60ABE64B4BE4AC45964F1A967BA76CB201F75356SZXEMI502MBSchi_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_60ABE64B4BE4AC45964F1A967BA76CB201F75356SZXEMI502MBSchi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,everyone!

I am trying to use the optional file name feature in type_transition rules =
, And I test it in my OS (with kernel 3.0.76 and selinux userspace 2.1.0 ),


1.       I add the type_tansition rule in my policy like this : filetrans_p=
attern(unconfined_t,tpm_dentry_t,stmfile_lst_t,file,"123"), It can be compi=
led and installed successfully



But , every files that I creat in the tpm_dentry_t dentry , I will get the =
stmfile_lst_t type, not just the file named 123



2.       I add two type_tansition rules in my policy like this :
filetrans_pattern(unconfined_t,tpm_dentry_t,stmfile_lst_t,file,"123")

filetrans_pattern(unconfined_t,tpm_dentry_t,trust_log_t,file,"456")



It can be conpiled successfully, But got some error when install




libsepol.expand_terule_helper: conflicting TE rule for (unconfined_t, tpm_d=
entry_t:file):  old was stmfile_lst_t, new is trust_log_t
libsepol.expand_module: Error during expand
libsemanage.semanage_expand_sandbox: Expand module failed

semodule:  Failed!




Can anyone help me with this problem, Thank you!


pS: I got the selinux userspace 2.1.0 from here

https://github.com/SELinuxProject/selinux/wiki/Releases



--_000_60ABE64B4BE4AC45964F1A967BA76CB201F75356SZXEMI502MBSchi_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
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
/* List Definitions */
@list l0
	{mso-list-id:235167623;
	mso-list-type:hybrid;
	mso-list-template-ids:-633541196 164294450 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
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
<p class=3D"MsoNormal"><span lang=3D"EN-US">I am trying to use the optional=
 file name feature in type_transition rules , And I test it in my OS (with =
kernel 3.0.76 and selinux userspace 2.1.0 ),
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo1">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">I add the type_tansitio=
n rule in my policy like this : filetrans_pattern(unconfined_t,tpm_dentry_t=
,stmfile_lst_t,file,&quot;123&quot;), It can be compiled and installed succ=
essfully<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US">But , every files that I creat in the tpm_dentry_t den=
try , I will get the stmfile_lst_t type, not just the file named 123<o:p></=
o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo1">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">2=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">I add two type_tansitio=
n rules in my policy like this :<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:18.0pt"><span lang=3D"EN-US">fi=
letrans_pattern(unconfined_t,tpm_dentry_t,stmfile_lst_t,file,&quot;123&quot=
;)<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US">filetrans_pattern(unconfined_t,tpm_dentry_t,trust_log_=
t,file,&quot;456&quot;)<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US">It can be conpiled successfully, But got some error wh=
en install<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:18.0pt"><span lang=3D"EN-US">li=
bsepol.expand_terule_helper: conflicting TE rule for (unconfined_t, tpm_den=
try_t:file):&nbsp; old was stmfile_lst_t, new is trust_log_t<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"text-indent:18.0pt"><span lang=3D"EN-US">li=
bsepol.expand_module: Error during expand<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:18.0pt"><span lang=3D"EN-US">li=
bsemanage.semanage_expand_sandbox: Expand module failed<o:p></o:p></span></=
p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US">semodule:&nbsp; Failed!<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Can anyone help me with this pr=
oblem, Thank you!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US">pS: I got the selinux userspace 2.1.0 from here<o:p></=
o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US">https://github.com/SELinuxProject/selinux/wiki/Release=
s<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:0cm">=
<span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_60ABE64B4BE4AC45964F1A967BA76CB201F75356SZXEMI502MBSchi_--
