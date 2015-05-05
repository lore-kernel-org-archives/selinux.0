Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4526ipb027272
 for <selinux@tycho.nsa.gov>; Mon, 4 May 2015 22:06:44 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.14.5/8.14.5) with SMTP id t4523iKA031033
 for <selinux@tycho.nsa.gov>; Mon, 4 May 2015 19:06:41 -0700
Received: from sc-owa03.marvell.com ([199.233.58.149])
 by mx0a-0016f401.pphosted.com with ESMTP id 1u60skb10a-1
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
 for <selinux@tycho.nsa.gov>; Mon, 04 May 2015 19:06:41 -0700
From: Zhi Xin <xinzhi@marvell.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Mon, 4 May 2015 19:06:39 -0700
Subject: Give out all the avc logs in ome time
Message-ID: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
Content-Type: multipart/alternative;
 boundary="_000_F766E4F80769BD478052FB6533FA745D66611C3FD9SCVEXCH4marve_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_F766E4F80769BD478052FB6533FA745D66611C3FD9SCVEXCH4marve_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

In my daily work, I'm always solving the selinux deny as presented by avc l=
og. But I found that, for one particular test, selinux cannot give me all t=
he avc deny log in one time, which has slowed down a lot of my daily work.

For example, I trigger a process called test_daemon to access a /dev/test_d=
evice in a particular test. Totally, it should have "open, read, write, ioc=
tl" for permissions. But for one time test, I only catch "open, read" relat=
ed avc log. And only after I have merged a patch to give the "open" and "re=
ad" permission, I rerun the test. The "write ioctl" related avc  logs start=
 to occur. So my question is how can I get "open, read, write, ioctl" avc l=
og in one test.

I have done a little study on this issue. selinux avc log depends on audit =
subsystem. In /kernel/kernel/audit.c, some code has indicated that we may l=
ost the records in five ways:

115<http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.=
c#115>/* Records can be lost in several ways:

116<http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.=
c#116>   0) [suppressed in audit_alloc]

117<http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.=
c#117>   1) out of memory in audit_log_start [kmalloc of struct audit_buffe=
r]

118<http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.=
c#118>   2) out of memory in audit_log_move [alloc_skb]

119<http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.=
c#119>   3) suppressed due to audit_rate_limit

120<http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.=
c#120>   4) suppressed due to audit_backlog_limit

121<http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.=
c#121>*/

So is this the root-cause of my issue ? How can I modify kernel code to arc=
hieve my purpose or there already is a open/off switch to help me on giving=
 all the logs in one time test ?

Thanks
Sincerely
Alan Xin



--_000_F766E4F80769BD478052FB6533FA745D66611C3FD9SCVEXCH4marve_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:SimSun;}
span.c
	{mso-style-name:c;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN link=3Dblue vli=
nk=3Dpurple style=3D'text-justify-trim:punctuation'><div class=3DWordSectio=
n1><p class=3DMsoNormal><span lang=3DEN-US>Hi All,<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US>In my daily work, I&#8217;m always solving =
the selinux deny as presented by avc log. But I found that, for one particu=
lar test, selinux cannot give me all the avc deny log in one time, which ha=
s slowed down a lot of my daily work.<o:p></o:p></span></p><p class=3DMsoNo=
rmal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><s=
pan lang=3DEN-US>For example, I trigger a process called test_daemon to acc=
ess a /dev/test_device in a particular test. Totally, it should have &#8220=
;open, read, write, ioctl&#8221; for permissions. But for one time test, I =
only catch &#8220;open, read&#8221; related avc log. And only after I have =
merged a patch to give the &#8220;open&#8221; and &#8220;read&#8221; permis=
sion, I rerun the test. The &#8220;write ioctl&#8221; related avc &nbsp;log=
s start to occur. So my question is how can I get &#8220;open, read, write,=
 ioctl&#8221; avc log in one test.<o:p></o:p></span></p><p class=3DMsoNorma=
l><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-US>I have done a little study on this issue. selinux avc log dep=
ends on audit subsystem. In /kernel/kernel/audit.c, some code has indicated=
 that we may lost the records in five ways:<o:p></o:p></span></p><pre><a na=
me=3D115></a><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/=
kernel/kernel/audit.c#115"><span lang=3DEN-US style=3D'font-size:10.5pt;fon=
t-family:"Calibri","sans-serif";color:windowtext;text-decoration:none'>115<=
/span></a><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri=
","sans-serif"'>/* Records can be lost in several ways:<o:p></o:p></span></=
pre><pre><a name=3D116></a><a href=3D"http://10.38.120.31:8080/source/xref/=
pxa1928-lp5.0/kernel/kernel/audit.c#116"><span lang=3DEN-US style=3D'font-s=
ize:10.5pt;font-family:"Calibri","sans-serif";color:windowtext;text-decorat=
ion:none'>116</span></a><span lang=3DEN-US style=3D'font-size:10.5pt;font-f=
amily:"Calibri","sans-serif"'>&nbsp;&nbsp; 0) [suppressed in audit_alloc]<o=
:p></o:p></span></pre><pre><a name=3D117></a><a href=3D"http://10.38.120.31=
:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#117"><span lang=3DEN-=
US style=3D'font-size:10.5pt;font-family:"Calibri","sans-serif";color:windo=
wtext;text-decoration:none'>117</span></a><span lang=3DEN-US style=3D'font-=
size:10.5pt;font-family:"Calibri","sans-serif"'>&nbsp;&nbsp; 1) out of memo=
ry in audit_log_start [kmalloc of struct audit_buffer]<o:p></o:p></span></p=
re><pre><a name=3D118></a><a href=3D"http://10.38.120.31:8080/source/xref/p=
xa1928-lp5.0/kernel/kernel/audit.c#118"><span lang=3DEN-US style=3D'font-si=
ze:10.5pt;font-family:"Calibri","sans-serif";color:windowtext;text-decorati=
on:none'>118</span></a><span lang=3DEN-US style=3D'font-size:10.5pt;font-fa=
mily:"Calibri","sans-serif"'>&nbsp;&nbsp; 2) out of memory in audit_log_mov=
e [alloc_skb]<o:p></o:p></span></pre><pre><a name=3D119></a><a href=3D"http=
://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#119"><=
span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri","sans-ser=
if";color:windowtext;text-decoration:none'>119</span></a><span lang=3DEN-US=
 style=3D'font-size:10.5pt;font-family:"Calibri","sans-serif"'>&nbsp;&nbsp;=
 3) suppressed due to audit_rate_limit<o:p></o:p></span></pre><pre><a name=
=3D120></a><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/ke=
rnel/kernel/audit.c#120"><span lang=3DEN-US style=3D'font-size:10.5pt;font-=
family:"Calibri","sans-serif";color:windowtext;text-decoration:none'>120</s=
pan></a><span lang=3DEN-US style=3D'font-size:10.5pt;font-family:"Calibri",=
"sans-serif"'>&nbsp;&nbsp; 4) suppressed due to audit_backlog_limit<o:p></o=
:p></span></pre><pre><a name=3D121></a><a href=3D"http://10.38.120.31:8080/=
source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#121"><span lang=3DEN-US sty=
le=3D'font-size:10.5pt;font-family:"Calibri","sans-serif";color:windowtext;=
text-decoration:none'>121</span></a><span lang=3DEN-US style=3D'font-size:1=
0.5pt;font-family:"Calibri","sans-serif"'>*/<o:p></o:p></span></pre><p clas=
s=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMso=
Normal><span lang=3DEN-US>So is this the root-cause of my issue ? How can I=
 modify kernel code to archieve my purpose or there already is a open/off s=
witch to help me on giving all the logs in one time test ? <o:p></o:p></spa=
n></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-US>Thanks<o:p></o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US>Sincerely<o:p></o:p></span></p><p class=3DM=
soNormal><span lang=3DEN-US>Alan Xin<o:p></o:p></span></p><p class=3DMsoNor=
mal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><sp=
an lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>=

--_000_F766E4F80769BD478052FB6533FA745D66611C3FD9SCVEXCH4marve_--
