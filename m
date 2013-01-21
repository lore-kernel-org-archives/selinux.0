Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0LIeumN022058
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 13:40:56 -0500
Received: by mail-wg0-f72.google.com with SMTP id fg15so6838762wgb.3
        for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 10:40:52 -0800 (PST)
From: Hung Truong <hung.truong@tridsys.com>
References: 3086262d0228a121663cb87f5d77a07a@mail.gmail.com
In-Reply-To: 3086262d0228a121663cb87f5d77a07a@mail.gmail.com
MIME-Version: 1.0
Date: Mon, 21 Jan 2013 13:40:50 -0500
Message-ID: <bf19e346e82ccd053990b576f4058a61@mail.gmail.com>
Subject: ERROR 'type staff_java_t is not within scope' at token
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7b3438eaecf3e104d3d0cc19
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b3438eaecf3e104d3d0cc19
Content-Type: text/plain; charset=UTF-8

I have this rule in my policy:



gen_require(`

                type staff_java_t;

                type cdvoip_sysadmcat_pki_cdvaserver_pem_t;

')

allow staff_java_t cdvoip_sysadmcat_pki_cdvaserver_pem_t: file { read open
};





and get error 'type staff_java_t is not within scope'  when compile it.





policy/modules/cdvoip/cdvoip_sysadmcat.te":306:ERROR 'type staff_java_t is
not within scope' at token ';' on line 1684769:

/usr/bin/checkpolicy:  loading policy configuration from policy.conf

allow staff_java_t cdvoip_sysadmcat_pki_cdvaserver_pem_t: file { read open
};



checkpolicy:  error(s) encountered while parsing configuration

make: ***
[/home/cdvadmin/workspace/cdvoip/rpms/BUILDROOT/selinux-policy-3.7.19-155el6.4.x86_64/etc/selinux/targeted/policy/policy.24]
Error 1





Does anyone know why I get this error and how to fix it?  BTW, if it does
matter, I modified the *.spec file to build a monolithic and strict policy.



Many thanks,

Hung Truong

--047d7b3438eaecf3e104d3d0cc19
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
>I have this rule in my policy:</span></p><p class=3D"MsoNormal"><span styl=
e=3D"color:#1f497d">=C2=A0</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">gen_require(`</span></=
p><p class=3D"MsoNormal"><span style=3D"color:#1f497d">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ty=
pe staff_java_t;</span></p><p class=3D"MsoNormal"><span style=3D"color:#1f4=
97d">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 type cdvoip_sysadmcat_pki_cdvaserver_pem_t;</span></p=
>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">&#39;)</span></p><p cl=
ass=3D"MsoNormal"><span style=3D"color:#1f497d">allow staff_java_t cdvoip_s=
ysadmcat_pki_cdvaserver_pem_t: file { read open };</span></p><p class=3D"Ms=
oNormal">
<span style=3D"color:#1f497d">=C2=A0</span></p><p class=3D"MsoNormal"><span=
 style=3D"color:#1f497d">=C2=A0</span></p><p class=3D"MsoNormal"><span styl=
e=3D"color:#1f497d">and get error &#39;type staff_java_t is not within scop=
e&#39; =C2=A0when compile it.</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">=C2=A0</span></p><p cl=
ass=3D"MsoNormal"><span style=3D"color:#1f497d">=C2=A0</span></p><p class=
=3D"MsoNormal"><span style=3D"color:#1f497d">policy/modules/cdvoip/cdvoip_s=
ysadmcat.te&quot;:306:ERROR &#39;type staff_java_t is not within scope&#39;=
 at token &#39;;&#39; on line 1684769:</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">/usr/bin/checkpolicy:=
=C2=A0 loading policy configuration from policy.conf</span></p><p class=3D"=
MsoNormal"><span style=3D"color:#1f497d">allow staff_java_t cdvoip_sysadmca=
t_pki_cdvaserver_pem_t: file { read open };</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">=C2=A0</span></p><p cl=
ass=3D"MsoNormal"><span style=3D"color:#1f497d">checkpolicy:=C2=A0 error(s)=
 encountered while parsing configuration</span></p><p class=3D"MsoNormal"><=
span style=3D"color:#1f497d">make: *** [/home/cdvadmin/workspace/cdvoip/rpm=
s/BUILDROOT/selinux-policy-3.7.19-155el6.4.x86_64/etc/selinux/targeted/poli=
cy/policy.24] Error 1</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">=C2=A0</span></p><p cl=
ass=3D"MsoNormal"><span style=3D"color:#1f497d">=C2=A0</span></p><p class=
=3D"MsoNormal"><span style=3D"color:#1f497d">Does anyone know why I get thi=
s error and how to fix it?=C2=A0 BTW, if it does matter, I modified the *.s=
pec file to build a monolithic and strict policy.</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d">=C2=A0</span></p><p cl=
ass=3D"MsoNormal"><span style=3D"color:#1f497d">Many thanks,</span></p><p c=
lass=3D"MsoNormal"><span style=3D"color:#1f497d">Hung Truong</span></p><p c=
lass=3D"MsoNormal">
<span style=3D"color:#1f497d">=C2=A0</span></p></div></body></html>

--047d7b3438eaecf3e104d3d0cc19--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
