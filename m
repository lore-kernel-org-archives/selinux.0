From: "sMoTo" <smoto@gmx.de>
To: <SELinux@tycho.nsa.gov>
Subject: Question concerning proftpd exploit
Date: Thu, 6 Nov 2003 13:42:17 +0100
Message-ID: <000001c3a463$6d510650$02000a0a@lady>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C3A46B.CF156E50"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C3A46B.CF156E50
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,
 
I have created a SELinux System running a vulnerable proftpd daemon (see
http://xforce.iss.net/xforce/alerts/id/154). My ps listing in enforcing
mode looks like this:
 
PID CONTEXT                                  COMMAND
    1 system_u:system_r:init_t                 init
    2 system_u:system_r:kernel_t               [keventd]
    3 system_u:system_r:kernel_t               [ksoftirqd_CPU0]
    4 system_u:system_r:kernel_t               [kswapd]
    5 system_u:system_r:kernel_t               [bdflush]
    6 system_u:system_r:kernel_t               [kupdated]
    9 system_u:system_r:kernel_t               [kjournald]
  828 system_u:system_r:syslogd_t              syslogd -m 0
  832 system_u:system_r:klogd_t                klogd -x
  869 system_u:system_r:ftpd_t                 proftpd: (accepting
connections)
  878 system_u:system_r:sshd_t                 /usr/sbin/sshd
  900 system_u:system_r:sendmail_t             sendmail: accepting
connections
  909 system_u:system_r:sendmail_t             sendmail: Queue
runner@01:00:00 f
  921 system_u:system_r:httpd_t                /usr/sbin/httpd
  930 system_u:system_r:gpm_t                  gpm -t imps2 -m
/dev/mouse
  939 system_u:system_r:crond_t                crond
  947 system_u:system_r:local_login_t          login -- root     
  948 system_u:system_r:local_login_t          login -- root     
  949 system_u:system_r:getty_t                /sbin/mingetty tty3
  950 system_u:system_r:getty_t                /sbin/mingetty tty4
  951 system_u:system_r:getty_t                /sbin/mingetty tty5
  952 system_u:system_r:getty_t                /sbin/mingetty tty6
  953 system_u:system_r:httpd_t                /usr/sbin/httpd
  954 system_u:system_r:httpd_t                /usr/sbin/httpd
  955 system_u:system_r:httpd_t                /usr/sbin/httpd
  956 system_u:system_r:httpd_t                /usr/sbin/httpd
  957 system_u:system_r:httpd_t                /usr/sbin/httpd
  958 system_u:system_r:httpd_t                /usr/sbin/httpd
  959 system_u:system_r:httpd_t                /usr/sbin/httpd
  960 system_u:system_r:httpd_t                /usr/sbin/httpd
  961 root:sysadm_r:sysadm_t                   -bash
 1012 root:sysadm_r:sysadm_t                   -bash
 1064 root:sysadm_r:sysadm_t                   ps -e --context
 
The proftpd daemon runs in its own domain. ftpd_t
 
The open source proof of concept exploit code gains a root shell on my
Red Hat 8.0 System without running in enforcing mode. I ran the system
with a maintenance kernel. If I would switch to enforcing mode, what
would happen? Does the exploit gain a root shell with privileges
system_u:system_r:ftp_t? Is this possible? 
Which security feature of SELinux handles such attacks? Which avc
loggings should I see?
 
 
Best regards.
 
### Oliver Fritz
### Singerstrasse 80
### 10243 Berlin
 

------=_NextPart_000_0001_01C3A46B.CF156E50
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C3A46B.CB2DFAF0">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:HyphenationZone>21</w:HyphenationZone>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailFormatvorlage17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;
	mso-header-margin:35.4pt;
	mso-footer-margin:35.4pt;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Normale Tabelle";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DDE link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:35.4pt'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Hello,<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>I have created a =
SELinux
System running a vulnerable proftpd daemon (see
http://xforce.iss.net/xforce/alerts/id/154). My ps listing in enforcing =
mode
looks like this:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'>PID CONTEXT<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
</span>COMMAND<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span></font><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>1 <span
class=3DSpellE>system_u:system_r:init_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
class=3DSpellE>init</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>2 <span =
class=3DSpellE>system_u:system_r:kernel_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>[<span =
class=3DSpellE>keventd</span>]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>3 <span =
class=3DSpellE>system_u:system_r:kernel_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>[ksoftirqd_CPU0]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>4 <span =
class=3DSpellE>system_u:system_r:kernel_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>[<span class=3DSpellE>kswapd</span>]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>5 <span =
class=3DSpellE>system_u:system_r:kernel_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>[<span =
class=3DSpellE>bdflush</span>]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>6 <span =
class=3DSpellE>system_u:system_r:kernel_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>[<span =
class=3DSpellE>kupdated</span>]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>9 <span =
class=3DSpellE>system_u:system_r:kernel_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>[<span =
class=3DSpellE>kjournald</span>]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp; </span>828 <span =
class=3DSpellE>system_u:system_r:syslogd_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span class=3DSpellE>syslogd</span> -m =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp; </span>832 <span =
class=3DSpellE>system_u:system_r:klogd_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span class=3DSpellE>klogd</span> -x<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp; </span></span></font><font size=3D2
face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:"Courier New";
mso-ansi-language:EN-GB'>869 system_u:system_r:ftpd_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>proftpd: (accepting connections)<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span></span></font><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt;font-family:"Courier New"'>878 <span =
class=3DSpellE>system_u:system_r:sshd_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/<span class=3DSpellE>usr</span>/<span =
class=3DSpellE>sbin</span>/<span
class=3DSpellE>sshd</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp; </span></span></font><font size=3D2
face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:"Courier New";
mso-ansi-language:EN-GB'>900 system_u:system_r:sendmail_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
</span>sendmail: accepting connections<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span></span></font><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt;font-family:"Courier New"'>909 <span =
class=3DSpellE>system_u:system_r:sendmail_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;</span><span
class=3DSpellE>sendmail</span>: Queue runner@01:00:00 =
f<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp; </span>921 <span =
class=3DSpellE>system_u:system_r:httpd_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/<span class=3DSpellE>usr</span>/<span =
class=3DSpellE>sbin</span>/<span
class=3DSpellE>httpd</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp; </span>930 <span =
class=3DSpellE>system_u:system_r:gpm_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span class=3DSpellE>gpm</span> -t imps2 -m /<span =
class=3DSpellE>dev</span>/<span
class=3DSpellE>mouse</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'><span
style=3D'mso-spacerun:yes'>&nbsp; </span></span></font><font size=3D2
face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:"Courier New";
mso-ansi-language:EN-GB'>939 <span =
class=3DSpellE>system_u:system_r:crond_t</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>crond<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>947 system_u:system_r:local_login_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
</span>login -- root<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;
</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>948 system_u:system_r:local_login_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
</span>login -- root<span =
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;
</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>949 system_u:system_r:getty_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/sbin/mingetty tty3<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>950 system_u:system_r:getty_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/sbin/mingetty tty4<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>951 system_u:system_r:getty_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/sbin/mingetty tty5<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>952 system_u:system_r:getty_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/sbin/mingetty tty6<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>953 system_u:system_r:httpd_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/usr/sbin/httpd<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>954 system_u:system_r:httpd_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/usr/sbin/httpd<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>955 system_u:system_r:httpd_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/usr/sbin/httpd<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>956 system_u:system_r:httpd_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/usr/sbin/httpd<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>957 system_u:system_r:httpd_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/usr/sbin/httpd<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>958 system_u:system_r:httpd_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/usr/sbin/httpd<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>959 system_u:system_r:httpd_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/usr/sbin/httpd<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>960 system_u:system_r:httpd_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>/usr/sbin/httpd<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span =
style=3D'mso-spacerun:yes'>&nbsp;
</span>961 root<span class=3DGramE>:sysadm</span>_r:sysadm_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>-bash<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span
style=3D'mso-spacerun:yes'>&nbsp;</span>1012 root<span =
class=3DGramE>:sysadm</span>_r:sysadm_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>-bash<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:
"Courier New";mso-ansi-language:EN-GB'><span
style=3D'mso-spacerun:yes'>&nbsp;</span>1064 root<span =
class=3DGramE>:sysadm</span>_r:sysadm_t<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;</span>ps
-e --context<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>The proftpd daemon =
runs in
its own domain. ftpd_t<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>The open source proof =
of
concept exploit code gains a root shell on my Red Hat 8.0 System without
running in enforcing mode. I ran the system with a maintenance kernel. =
If I would
switch to enforcing mode, what would happen? Does the exploit gain a =
root shell
with privileges system_u:system_r:ftp_t? Is this possible? =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'>Which security feature =
of
SELinux handles such attacks? Which <span class=3DGramE>avc</span> =
loggings
should I see?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB'><o:p>&nbsp;</o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB;mso-no-proof:yes'>Best
regards.</span></font><span lang=3DEN-GB =
style=3D'mso-ansi-language:EN-GB;
mso-no-proof:yes'><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt;mso-ansi-language:EN-GB;mso-no-proof:yes'>&nbsp=
;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB;mso-no-proof:yes'>### =
Oliver
Fritz</span></font><span lang=3DEN-GB =
style=3D'mso-ansi-language:EN-GB;mso-no-proof:
yes'><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB;mso-no-proof:yes'>###
Singerstrasse 80</span></font><span lang=3DEN-GB =
style=3D'mso-ansi-language:EN-GB;
mso-no-proof:yes'><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial;mso-ansi-language:EN-GB;mso-no-proof:yes'>### =
</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;mso-no-proof:
yes'>10243 Berlin</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C3A46B.CF156E50--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
