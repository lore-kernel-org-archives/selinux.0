Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5CHmoWK009541
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 13:48:50 -0400
From: Tim Shearer <tim.shearer@overturenetworks.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Kernel error: SELinux:  Invalid class 0
Date: Fri, 12 Jun 2015 17:48:44 +0000
Message-ID: <33526A3108217C45B7DAFFA5277E4B67118AF1B3@mbx024-e1-nj-2.exch024.domain.local>
Content-Type: multipart/alternative;
 boundary="_000_33526A3108217C45B7DAFFA5277E4B67118AF1B3mbx024e1nj2exch_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_33526A3108217C45B7DAFFA5277E4B67118AF1B3mbx024e1nj2exch_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Environment: CentOS 7, with either stock 3.10 kernel, or custom 3.19 kernel=
.

I'm getting a AVC denial message in the audit logs that corresponds to the =
opening of a TIPC socket (AF_TIPC). The denial is seems valid, and is trigg=
ered by a custom C++ application that hasn't yet been assigned an appropria=
te security context. The problem I'm having is that the AVC message is garb=
led (non-ASCII data in the denied and tclass fields), which makes it diffic=
ult to assemble a new policy:

----
type=3DAVC msg=3Daudit(1434126658.487:34500): avc:  denied  { garbage_chara=
cters } for  pid=3D292 comm=3D"kworker/u16:5" scontext=3Dsystem_u:system_r:=
kernel_t:s0 tcontext=3Dsystem_u:object_r:unlabeled_t:s0 tclass=3Dgarbage_ch=
aracters permissive=3D0
----

This corresponds to a kernel error that shows up in the debuglog:
SELinux:  Invalid class 0

setroubleshootd also has, er, trouble:

----
/var/lib/setroubleshoot/setroubleshoot_database.xml:51: parser error : PCDA=
TA invalid Char value 15
      <tclass>D</tclass>
              ^
/var/lib/setroubleshoot/setroubleshoot_database.xml:51: parser error : PCDA=
TA invalid Char value 31
      <tclass>D</tclass>
etc.
----

I'm new to SELinux, and this seems a little more obscure than your typical =
newbie problem. Any guidance would be appreciated!

Many thanks in advance,
Tim



This email and attachments may contain privileged or confidential informati=
on intended only for the addressee(s) indicated. The sender does not waive =
any of its rights, privileges or protections respecting this information. I=
f you are not the named addressee, an employee, or agent responsible for se=
nding this message to the named addressee (or this message was received by =
mistake), you are not authorized to read, print, retain, copy or disseminat=
e this message or any part of it. If received in error, please notify us im=
mediately by e-mail, discard any paper copies and delete all electronic fil=
es of the email.

Computer viruses can be transmitted via email. The recipient should check t=
his email and any attachments for viruses. Email transmission cannot be gua=
ranteed to be secured or error-free as information could be intercepted, co=
rrupted, lost, destroyed, arrive late or incomplete, or contain viruses. Th=
e sender accepts no liability for any damage caused by any transmitted viru=
ses or errors or omissions in the contents of this message.

Overture Networks, Inc. 637 Davis Drive, Morrisville, NC USA 27560 www.over=
turenetworks.com

--_000_33526A3108217C45B7DAFFA5277E4B67118AF1B3mbx024e1nj2exch_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Environment: CentOS 7, with either stock 3.10 kernel=
, or custom 3.19 kernel.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m getting a AVC denial message in the audit =
logs that corresponds to the opening of a TIPC socket (AF_TIPC). The denial=
 is seems valid, and is triggered by a custom C&#43;&#43; application that =
hasn&#8217;t yet been assigned an appropriate security
 context. The problem I&#8217;m having is that the AVC message is garbled (=
non-ASCII data in the denied and tclass fields), which makes it difficult t=
o assemble a new policy:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">----<o:p></o:p></p>
<p class=3D"MsoNormal">type=3DAVC msg=3Daudit(1434126658.487:34500): avc:&n=
bsp; denied&nbsp; { <b>
garbage_characters</b> } for&nbsp; pid=3D292 comm=3D&quot;kworker/u16:5&quo=
t; scontext=3Dsystem_u:system_r:kernel_t:s0 tcontext=3Dsystem_u:object_r:un=
labeled_t:s0 tclass=3D<b>garbage_characters</b> permissive=3D0<o:p></o:p></=
p>
<p class=3D"MsoNormal">----<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This corresponds to a kernel error that shows up in =
the debuglog:<o:p></o:p></p>
<p class=3D"MsoNormal">SELinux:&nbsp; Invalid class 0<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">setroubleshootd also has, er, trouble:<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">----<o:p></o:p></p>
<p class=3D"MsoNormal">/var/lib/setroubleshoot/setroubleshoot_database.xml:=
51: parser error : PCDATA invalid Char value 15<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;tclass&gt;D&lt;/t=
class&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ^<o:p></o:p></p>
<p class=3D"MsoNormal">/var/lib/setroubleshoot/setroubleshoot_database.xml:=
51: parser error : PCDATA invalid Char value 31<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;tclass&gt;D&lt;/t=
class&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">etc.<o:p></o:p></p>
<p class=3D"MsoNormal">----<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m new to SELinux, and this seems a little mo=
re obscure than your typical newbie problem. Any guidance would be apprecia=
ted!
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Many thanks in advance,<o:p></o:p></p>
<p class=3D"MsoNormal">Tim<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<br>
<br>
<font size=3D"1">This email and attachments may contain privileged or confi=
dential information intended only for the addressee(s) indicated. The sende=
r does not waive any of its rights, privileges or protections respecting th=
is information. If you are not the
 named addressee, an employee, or agent responsible for sending this messag=
e to the named addressee (or this message was received by mistake), you are=
 not authorized to read, print, retain, copy or disseminate this message or=
 any part of it. If received in
 error, please notify us immediately by e-mail, discard any paper copies an=
d delete all electronic files of the email.<br>
<br>
Computer viruses can be transmitted via email. The recipient should check t=
his email and any attachments for viruses. Email transmission cannot be gua=
ranteed to be secured or error-free as information could be intercepted, co=
rrupted, lost, destroyed, arrive
 late or incomplete, or contain viruses. The sender accepts no liability fo=
r any damage caused by any transmitted viruses or errors or omissions in th=
e contents of this message.<br>
<br>
Overture Networks, Inc. 637 Davis Drive, Morrisville, NC USA 27560 www.over=
turenetworks.com</font>
</body>
</html>

--_000_33526A3108217C45B7DAFFA5277E4B67118AF1B3mbx024e1nj2exch_--
