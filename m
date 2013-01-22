Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEJBMP009504
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:19:11 -0500
Received: from stl-mbsout-01.boeing.com (localhost.localdomain [127.0.0.1])
	by stl-mbsout-01.boeing.com (8.14.4/8.14.4/DOWNSTREAM_MBSOUT) with ESMTP id r0MEJ9xD013493
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 08:19:09 -0600
From: "Vu, Joseph" <joseph.vu@boeing.com>
To: Hung Truong <hung.truong@tridsys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: RE: Turn off "dontaudit" rules in monolithic policy
Date: Tue, 22 Jan 2013 14:19:06 +0000
Message-ID: <756D04455A661C4CA25DC5BA4902A7A70130D8@XCH-PHX-204.sw.nos.boeing.com>
References: <3086262d0228a121663cb87f5d77a07a@mail.gmail.com>
In-Reply-To: <3086262d0228a121663cb87f5d77a07a@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="_000_756D04455A661C4CA25DC5BA4902A7A70130D8XCHPHX204swnosboe_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_756D04455A661C4CA25DC5BA4902A7A70130D8XCHPHX204swnosboe_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hung,

I have been trying to rebuild monolithic policy and was not able to.
What version of SELinux Policy and RHT are you using?

________________________________
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On B=
ehalf Of Hung Truong
Sent: Monday, January 21, 2013 11:25 AM
To: SELinux
Subject: Turn off "dontaudit" rules in monolithic policy


I have a custom monolithic build based on RHEL6 policy.
I get this error when try to turn off dontaudit rules:

$ semodule -DB

libsemanage.semanage_link_sandbox: Could not access sandbox base file /etc/=
selinux/targeted/modules/bmp/base.pp. (No such file or directory)

Is there other way to turn off dontaudit rules in a monilithic policy?

Many thanks,
--Hung Truong

--_000_756D04455A661C4CA25DC5BA4902A7A70130D8XCHPHX204swnosboe_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta content=3D"MSHTML 6.00.2900.6287" name=3D"GENERATOR">
<style>@font-face {
	font-family: Cambria Math;
}
@font-face {
	font-family: Calibri;
}
@font-face {
	font-family: Tahoma;
}
@page WordSection1 {size: 8.5in 11.0in; margin: 1.0in 1.0in 1.0in 1.0in; }
P.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Calibri","sans-serif"
}
LI.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Calibri","sans-serif"
}
DIV.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Calibri","sans-serif"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
P.MsoAcetate {
	FONT-SIZE: 8pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Tahoma","sans-serif"; m=
so-style-priority: 99; mso-style-link: "Balloon Text Char"
}
LI.MsoAcetate {
	FONT-SIZE: 8pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Tahoma","sans-serif"; m=
so-style-priority: 99; mso-style-link: "Balloon Text Char"
}
DIV.MsoAcetate {
	FONT-SIZE: 8pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Tahoma","sans-serif"; m=
so-style-priority: 99; mso-style-link: "Balloon Text Char"
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: "Calibri","sans-serif"; mso-style-type: pe=
rsonal-compose
}
SPAN.BalloonTextChar {
	FONT-FAMILY: "Tahoma","sans-serif"; mso-style-priority: 99; mso-style-link=
: "Balloon Text"; mso-style-name: "Balloon Text Char"
}
.MsoChpDefault {
	mso-style-type: export-only
}
DIV.WordSection1 {
	page: WordSection1
}
</style>
</head>
<body lang=3D"EN-US" vlink=3D"purple" link=3D"blue">
<div dir=3D"ltr" align=3D"left"><span class=3D"703191714-22012013"><font fa=
ce=3D"Arial" color=3D"#0000ff" size=3D"2">Hung,</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"703191714-22012013"><font fa=
ce=3D"Arial" color=3D"#0000ff" size=3D"2"></font></span>&nbsp;</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"703191714-22012013"><font fa=
ce=3D"Arial" color=3D"#0000ff" size=3D"2">I have been trying to rebuild mon=
olithic policy and was not able to.</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"703191714-22012013"><font fa=
ce=3D"Arial" color=3D"#0000ff" size=3D"2">What version of SELinux Policy an=
d RHT&nbsp;are you using?</font></span></div>
<br>
<div class=3D"OutlookMessageHeader" lang=3D"en-us" dir=3D"ltr" align=3D"lef=
t">
<hr tabindex=3D"-1">
<font face=3D"Tahoma" size=3D"2"><b>From:</b> owner-selinux@tycho.nsa.gov [=
mailto:owner-selinux@tycho.nsa.gov]
<b>On Behalf Of </b>Hung Truong<br>
<b>Sent:</b> Monday, January 21, 2013 11:25 AM<br>
<b>To:</b> SELinux<br>
<b>Subject:</b> Turn off &quot;dontaudit&quot; rules in monolithic policy<b=
r>
</font><br>
</div>
<div></div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">I have a custom monolithic build based on RHEL6 poli=
cy. <br>
I get this error when try to turn off dontaudit rules:<br>
<br>
</p>
<p class=3D"MsoNormal">$ semodule -DB</p>
<p class=3D"MsoNormal"><br>
libsemanage.semanage_link_sandbox: Could not access sandbox base file /etc/=
selinux/targeted/modules/bmp/base.pp. (No such file or directory)<br>
<br>
Is there other way to turn off dontaudit rules in a monilithic policy?</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Many thanks,</p>
<p class=3D"MsoNormal">--Hung Truong</p>
</div>
</body>
</html>

--_000_756D04455A661C4CA25DC5BA4902A7A70130D8XCHPHX204swnosboe_--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
