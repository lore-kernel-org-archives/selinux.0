Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0LHPBhE018327
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 12:25:11 -0500
Received: by mail-we0-f198.google.com with SMTP id r1so3137612wey.5
        for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 09:25:07 -0800 (PST)
From: Hung Truong <hung.truong@tridsys.com>
MIME-Version: 1.0
Date: Mon, 21 Jan 2013 12:25:05 -0500
Message-ID: <3086262d0228a121663cb87f5d77a07a@mail.gmail.com>
Subject: Turn off "dontaudit" rules in monolithic policy
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7b3438eaf9e36b04d3cfbd15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b3438eaf9e36b04d3cfbd15
Content-Type: text/plain; charset=UTF-8

I have a custom monolithic build based on RHEL6 policy.
I get this error when try to turn off dontaudit rules:

$ semodule -DB


libsemanage.semanage_link_sandbox: Could not access sandbox base file
/etc/selinux/targeted/modules/bmp/base.pp. (No such file or directory)

Is there other way to turn off dontaudit rules in a monilithic policy?



Many thanks,

--Hung Truong

--047d7b3438eaf9e36b04d3cfbd15
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dus-ascii"><meta name=3D"Generator" content=3D"Microsoft Word 12 (filtere=
d medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div =
class=3D"WordSection1"><p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNorm=
al">I have a custom monolithic build based on RHEL6 policy. <br>I get this =
error when try to turn off dontaudit rules:<br>
<br></p><p class=3D"MsoNormal">$ semodule -DB</p><p class=3D"MsoNormal"><br=
>libsemanage.semanage_link_sandbox: Could not access sandbox base file /etc=
/selinux/targeted/modules/bmp/base.pp. (No such file or directory)<br><br>I=
s there other way to turn off dontaudit rules in a monilithic policy?</p>
<p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNormal">Many thanks,</p><p =
class=3D"MsoNormal">--Hung Truong</p></div></body></html>

--047d7b3438eaf9e36b04d3cfbd15--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
