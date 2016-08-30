Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UH3rqH020639
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 13:03:53 -0400
Received: from hellfire (unknown [10.255.0.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by tbhext01.m0noc.net (Postfix) with ESMTPSA id 3sNvxL0rtCz2ZYPs
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 18:03:50 +0100 (BST)
From: "Paul Bolton" <paul.a.bolton@m0noc.net>
To: <selinux@tycho.nsa.gov>
Subject: SELinux MLS Policies
Date: Tue, 30 Aug 2016 18:03:49 +0100
Message-ID: <01e601d202e0$7aaf62d0$700e2870$@a.bolton@m0noc.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_01E7_01D202E8.DC73CAD0"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.

------=_NextPart_000_01E7_01D202E8.DC73CAD0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

First, apologies if this is the wrong SELinux list to post such questions;
as you can guess I'm new to SELinux development.

 

I'm looking at getting a base MLS policy running on a fully patched CentOS
7.2 build which I will then customise; currently as a learning exercise.

 

Unfortunately I'm having a few problems (usually it works out-of-the-box on
distros I've used, but not in this case), so I hope someone on the list can
give me a push in the right direction.

 

Bottom line is that if I try to use the vendor supplied version the system
is unusable if set to enforcing (I've used MLS before, so I do mean unusable
in this case).

 

I've now downloaded the latest reference policy, compiled it for mls and
systemd including updating the broken labelling due to /bin and /sbin being
symlinks. Things look better but there are still many errors.

 

One group in particular puzzles me (hopefully due to some misunderstanding
on my part).

 

I get AVC's for a number of critical files relating to systemd sockets and
/dev/log, for example. e.g.

 

-- snip --

type=AVC msg=audit(1472476843.913:1124): avc:  denied  { sendto } for
pid=11015 comm="sshd" path="/dev/log"
scontext=system_u:system_r:sshd_t:s0-s15:c0.c1023
tcontext=system_u:system_r:kernel_t:s15:c0.c1023 tclass=unix_dgram_socket

 

        Was caused by:

 

#Constraint rule:

 

        mlsconstrain unix_dgram_socket { sendto } ((l1 eq l2 -Fail-)  or
(t1=sshd_t  eq TYPE_ENTRY -Fail-) { POLICY_SOURCE: mlsnetwriteranged }  and
(l1 dom l2 -Fail-)  and (l1 domby h2 -Pass-)  or (t1=sshd_t  eq TYPE_ENTRY
-Fail-) { POLICY_SOURCE: mlsnetwritetoclr }  and (h1 dom L2 -Pass-)  and (l1
domby l2 -Pass-)  or (t1=sshd_t  eq TYPE_ENTRY -Fail-) { POLICY_SOURCE:
mlsnetwrite }  or (t2=kernel_t  eq TYPE_ENTRY -Fail-) { POLICY_SOURCE:
mlstrustedobject } ); Constraint DENIED

 

#       Possible cause is the source level (s0-s15:c0.c1023) and target
level (s15:c0.c1023) are different.

-- snip --

 

Now, given that /dev/log is labelled as a devlog_t:

 

# ls -lZ /dev/log

srw-rw-rw-. root root system_u:object_r:devlog_t:s15:c0.c1023 /dev/log

 

And according to logging.te, this is a trusted object:

 

mls_trusted_object(devlog_t)

 

Why is the target context for evaluation kernel_t and not devlog_t? Surely
it should be devlog_t and therefore pass the constraint rule as a trusted
object?

 

 

Paul

----

http://blog.m0noc.com/ | https://keybase.io/m0noc

4329 E4C5 71F3 58B2 2246  D04D 25DA 39C2 3876 FE3D

 


------=_NextPart_000_01E7_01D202E8.DC73CAD0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
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
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-GB link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>First, =
apologies if this is the wrong SELinux list to post such questions; as =
you can guess I&#8217;m new to SELinux development.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I&#8217;m =
looking at getting a base MLS policy running on a fully patched CentOS =
7.2 build which I will then customise; currently as a learning =
exercise.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Unfortunately I&#8217;m having a few problems (usually =
it works out-of-the-box on distros I&#8217;ve used, but not in this =
case), so I hope someone on the list can give me a push in the right =
direction.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Bottom line is that if I try to use the vendor =
supplied version the system is unusable if set to enforcing (I&#8217;ve =
used MLS before, so I do mean unusable in this case).<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I&#8217;ve =
now downloaded the latest reference policy, compiled it for mls and =
systemd including updating the broken labelling due to /bin and /sbin =
being symlinks. Things look better but there are still many =
errors.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>One group in particular puzzles me (hopefully due to =
some misunderstanding on my part).<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I get =
AVC&#8217;s for a number of critical files relating to systemd sockets =
and /dev/log, for example. e.g.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>-- snip =
--<o:p></o:p></p><p class=3DMsoNormal>type=3DAVC =
msg=3Daudit(1472476843.913:1124): avc:&nbsp; denied&nbsp; { sendto } =
for&nbsp; pid=3D11015 comm=3D&quot;sshd&quot; =
path=3D&quot;/dev/log&quot; =
scontext=3Dsystem_u:system_r:sshd_t:s0-s15:c0.c1023 =
tcontext=3Dsystem_u:system_r:kernel_t:s15:c0.c1023 =
tclass=3Dunix_dgram_socket<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Was caused =
by:<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>#Constraint rule:<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mlsconstrain unix_dgram_socket { sendto } ((l1 eq l2 -Fail-)&nbsp; or =
(t1=3Dsshd_t&nbsp; eq TYPE_ENTRY -Fail-) { POLICY_SOURCE: =
mlsnetwriteranged }&nbsp; and (l1 dom l2 -Fail-)&nbsp; and (l1 domby h2 =
-Pass-)&nbsp; or (t1=3Dsshd_t&nbsp; eq TYPE_ENTRY -Fail-) { =
POLICY_SOURCE: mlsnetwritetoclr }&nbsp; and (h1 dom L2 -Pass-)&nbsp; and =
(l1 domby l2 -Pass-)&nbsp; or (t1=3Dsshd_t&nbsp; eq TYPE_ENTRY -Fail-) { =
POLICY_SOURCE: mlsnetwrite }&nbsp; or (t2=3Dkernel_t&nbsp; eq TYPE_ENTRY =
-Fail-) { POLICY_SOURCE: mlstrustedobject } ); Constraint =
DENIED<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Possible cause =
is the source level (s0-s15:c0.c1023) and target level (s15:c0.c1023) =
are different.<o:p></o:p></p><p class=3DMsoNormal>-- snip =
--<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Now, given that /dev/log is labelled as a =
devlog_t:<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal># ls -lZ /dev/log<o:p></o:p></p><p =
class=3DMsoNormal>srw-rw-rw-. root root =
system_u:object_r:devlog_t:s15:c0.c1023 /dev/log<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>And =
according to logging.te, this is a trusted object:<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>mls_trusted_object(devlog_t)<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Why is the =
target context for evaluation kernel_t and not devlog_t? Surely it =
should be devlog_t and therefore pass the constraint rule as a trusted =
object?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span =
style=3D'font-size:10.5pt;font-family:Consolas'>Paul<o:p></o:p></span></p=
><p class=3DMsoNormal><span =
style=3D'font-size:10.5pt;font-family:Consolas'>----<o:p></o:p></span></p=
><p class=3DMsoNormal><span =
style=3D'font-size:10.5pt;font-family:Consolas'>http://blog.m0noc.com/ | =
https://keybase.io/m0noc<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.5pt;font-family:Consolas'>4329 E4C5 71F3 58B2 =
2246&nbsp; D04D 25DA 39C2 3876 FE3D<o:p></o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_01E7_01D202E8.DC73CAD0--
