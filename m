Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEW7mG010763
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:32:07 -0500
Received: by mail-la0-f69.google.com with SMTP id ed20so2679365lab.4
        for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 06:32:01 -0800 (PST)
From: Hung Truong <hung.truong@tridsys.com>
References: <3086262d0228a121663cb87f5d77a07a@mail.gmail.com> <756D04455A661C4CA25DC5BA4902A7A70130D8@XCH-PHX-204.sw.nos.boeing.com>
In-Reply-To: <756D04455A661C4CA25DC5BA4902A7A70130D8@XCH-PHX-204.sw.nos.boeing.com>
MIME-Version: 1.0
Date: Tue, 22 Jan 2013 09:31:59 -0500
Message-ID: <d2ec19d66b29b9d3206b49e021bd9aff@mail.gmail.com>
Subject: RE: Turn off "dontaudit" rules in monolithic policy
To: "Vu, Joseph" <joseph.vu@boeing.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7b603c1ed85b7904d3e1708c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b603c1ed85b7904d3e1708c
Content-Type: text/plain; charset=UTF-8

I am using version 3.7.19-155el6.6.



*From:* Vu, Joseph [mailto:joseph.vu@boeing.com]
*Sent:* Tuesday, January 22, 2013 9:19 AM
*To:* Hung Truong; SELinux
*Subject:* RE: Turn off "dontaudit" rules in monolithic policy



Hung,



I have been trying to rebuild monolithic policy and was not able to.

What version of SELinux Policy and RHT are you using?


------------------------------

*From:* owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov<owner-selinux@tycho.nsa.gov>]
*On Behalf Of *Hung Truong
*Sent:* Monday, January 21, 2013 11:25 AM
*To:* SELinux
*Subject:* Turn off "dontaudit" rules in monolithic policy



I have a custom monolithic build based on RHEL6 policy.
I get this error when try to turn off dontaudit rules:

$ semodule -DB


libsemanage.semanage_link_sandbox: Could not access sandbox base file
/etc/selinux/targeted/modules/bmp/base.pp. (No such file or directory)

Is there other way to turn off dontaudit rules in a monilithic policy?



Many thanks,

--Hung Truong

--047d7b603c1ed85b7904d3e1708c
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
--></style></head><body lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div =
class=3D"WordSection1"><p class=3D"MsoNormal"><span style=3D"color:#1f497d"=
>I am using version 3.7.19-155el6.6.</span></p><p class=3D"MsoNormal"><span=
 style=3D"color:#1f497d">=C2=A0</span></p>
<div><div style=3D"border:none;border-top:solid #b5c4df 1.0pt;padding:3.0pt=
 0in 0in 0in"><p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;fon=
t-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&qu=
ot;"> Vu, Joseph [mailto:<a href=3D"mailto:joseph.vu@boeing.com">joseph.vu@=
boeing.com</a>] <br>
<b>Sent:</b> Tuesday, January 22, 2013 9:19 AM<br><b>To:</b> Hung Truong; S=
ELinux<br><b>Subject:</b> RE: Turn off &quot;dontaudit&quot; rules in monol=
ithic policy</span></p></div></div><p class=3D"MsoNormal">=C2=A0</p><p clas=
s=3D"MsoNormal">
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;;color:blue">Hung,</span><span style=3D"font-size:12.0pt;font-fami=
ly:&quot;Times New Roman&quot;,&quot;serif&quot;"></span></p><p class=3D"Ms=
oNormal">
<span style=3D"font-size:12.0pt;font-family:&quot;Times New Roman&quot;,&qu=
ot;serif&quot;">=C2=A0</span></p><p class=3D"MsoNormal"><span style=3D"font=
-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:blu=
e">I have been trying to rebuild monolithic policy and was not able to.</sp=
an><span style=3D"font-size:12.0pt;font-family:&quot;Times New Roman&quot;,=
&quot;serif&quot;"></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:blue">What version of SELinux Policy=
 and RHT=C2=A0are you using?</span><span style=3D"font-size:12.0pt;font-fam=
ily:&quot;Times New Roman&quot;,&quot;serif&quot;"></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;">=C2=A0</span></p><div class=3D"MsoNo=
rmal" align=3D"center" style=3D"text-align:center"><span style=3D"font-size=
:12.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;"><hr size=
=3D"2" width=3D"100%" align=3D"center">
</span></div><p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span=
 style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&=
quot;">From:</span></b><span style=3D"font-size:10.0pt;font-family:&quot;Ta=
homa&quot;,&quot;sans-serif&quot;"> <a href=3D"mailto:owner-selinux@tycho.n=
sa.gov">owner-selinux@tycho.nsa.gov</a> [<a href=3D"mailto:owner-selinux@ty=
cho.nsa.gov">mailto:owner-selinux@tycho.nsa.gov</a>] <b>On Behalf Of </b>Hu=
ng Truong<br>
<b>Sent:</b> Monday, January 21, 2013 11:25 AM<br><b>To:</b> SELinux<br><b>=
Subject:</b> Turn off &quot;dontaudit&quot; rules in monolithic policy</spa=
n><span style=3D"font-size:12.0pt;font-family:&quot;Times New Roman&quot;,&=
quot;serif&quot;"></span></p>
<p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNormal" style=3D"margin-bot=
tom:12.0pt">I have a custom monolithic build based on RHEL6 policy. <br>I g=
et this error when try to turn off dontaudit rules:</p><p class=3D"MsoNorma=
l">$ semodule -DB</p>
<p class=3D"MsoNormal"><br>libsemanage.semanage_link_sandbox: Could not acc=
ess sandbox base file /etc/selinux/targeted/modules/bmp/base.pp. (No such f=
ile or directory)<br><br>Is there other way to turn off dontaudit rules in =
a monilithic policy?</p>
<p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNormal">Many thanks,</p><p =
class=3D"MsoNormal">--Hung Truong</p></div></body></html>

--047d7b603c1ed85b7904d3e1708c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
