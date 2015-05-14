MIME-Version: 1.0
Sender: ecank1@gmail.com
In-Reply-To: <55544356.1050802@gmail.com>
References: <55544356.1050802@gmail.com>
Date: Thu, 14 May 2015 10:44:53 +0300
Message-ID: <CA+2y114X0say5NgXegHhnfD2RgP4zvMWTLdjpoVkqvhAGokFrw@mail.gmail.com>
Subject: Re: How to start SELinux on embedded device
From: Emre Can Kucukoglu <eckucukoglu@gmail.com>
To: rajkumar <rajkumarmadhani@gmail.com>
Content-Type: multipart/alternative; boundary=089e011761913ec6f2051605e77b
Cc: Selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e011761913ec6f2051605e77b
Content-Type: text/plain; charset=UTF-8

Hi Rajkumar,

Basically, you need 3 major steps.

1. Enable security framework and SELinux configurations from linux kernel.
like: CONFIG_SECURITY_SELINUX, DEFAULT_SECURITY_SELINUX,
SECURITY_SELINUX_AVC_STATS, CONFIG_SECURITY_SELINUX_BOOTPARAM,
SECURITY_SELINUX_DEVELOP, CONFIG_SECURITY_SELINUX_DISABLE
2. Then download and compile SELinux:
https://github.com/SELinuxProject/selinux. Add cross-compiled files to your
rootfs.
3. Download and configure SELinux reference policy project, however keep in
mind, you have lots of redundant policy modules in reference policy, you
should keep them out. Load policies, enable your SELinux. (see setenforce,
/etc/selinux/config, boot args, kernel configuration).
4. Later, you 'can' download and compile setools3 (vs3 is stable one i
guess) to ease your policy management.

I think SELinux notebook is a good resource to learn how to use SELinux,
not how to port it.
You can look my presentation about SELinux overview, however keep in mind
that it is not reviewed yet.
https://docs.google.com/presentation/d/1Qtl_vaxvcAPse47d2sCWH6IAhn9XYFKkHEsOddobHpw/edit?usp=sharing

In which step do you think you are?

2015-05-14 9:40 GMT+03:00 rajkumar <rajkumarmadhani@gmail.com>:

> Hi I am Rajkumar new to SELinux.
>
>
> My Requirement is to start SELinux porting on Embedded device consists of
> ARM processor.
> Using linux kernel version is 3.0.35.
> I started reading The SELinux notebook 4th edition.
> Made some changes in .config like enabling SELinux in kernel.
> And what are the changes need to be done rootfs apart from DAC  and in
> kernel.
>
>
> Please provide guidelines.
>
> --
> Regards
> Rajkumar.m
> +91 8501021114
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



-- 
Emre Can Kucukoglu

--089e011761913ec6f2051605e77b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Rajkumar,<div><br></div><div>Basically, you need 3 majo=
r steps.<div><br></div><div>1. Enable security framework and SELinux config=
urations from linux kernel.</div><div>like: CONFIG_SECURITY_SELINUX, DEFAUL=
T_SECURITY_SELINUX, SECURITY_SELINUX_AVC_STATS, CONFIG_SECURITY_SELINUX_BOO=
TPARAM, SECURITY_SELINUX_DEVELOP, CONFIG_SECURITY_SELINUX_DISABLE<br></div>=
<div>2. Then download and compile SELinux:=C2=A0<a href=3D"https://github.c=
om/SELinuxProject/selinux">https://github.com/SELinuxProject/selinux</a>. A=
dd cross-compiled files to your rootfs.</div><div>3. Download and configure=
 SELinux reference policy project, however keep in mind, you have lots of r=
edundant policy modules in reference policy, you should keep them out. Load=
 policies, enable your SELinux. (see setenforce, /etc/selinux/config, boot =
args, kernel configuration).</div><div>4. Later, you &#39;can&#39; download=
 and compile setools3 (vs3 is stable one i guess) to ease your policy manag=
ement.</div><div><br></div><div>I think SELinux notebook is a good resource=
 to learn how to use SELinux, not how to port it.=C2=A0</div><div>You can l=
ook my presentation about SELinux overview, however keep in mind that it is=
 not reviewed yet.</div><div><a href=3D"https://docs.google.com/presentatio=
n/d/1Qtl_vaxvcAPse47d2sCWH6IAhn9XYFKkHEsOddobHpw/edit?usp=3Dsharing">https:=
//docs.google.com/presentation/d/1Qtl_vaxvcAPse47d2sCWH6IAhn9XYFKkHEsOddobH=
pw/edit?usp=3Dsharing</a><br></div><div><br></div><div>In which step do you=
 think you are?</div></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">2015-05-14 9:40 GMT+03:00 rajkumar <span dir=3D"ltr">&lt;<=
a href=3D"mailto:rajkumarmadhani@gmail.com" target=3D"_blank">rajkumarmadha=
ni@gmail.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi I am Rajk=
umar new to SELinux.<br>
<br>
<br>
My Requirement is to start SELinux porting on Embedded device consists of A=
RM processor.<br>
Using linux kernel version is 3.0.35.<br>
I started reading The SELinux notebook 4th edition.<br>
Made some changes in .config like enabling SELinux in kernel.<br>
And what are the changes need to be done rootfs apart from DAC=C2=A0 and in=
 kernel.<br>
<br>
<br>
Please provide guidelines.<span class=3D"HOEnZb"><font color=3D"#888888"><b=
r>
<br>
-- <br>
Regards<br>
Rajkumar.m<br>
<a href=3D"tel:%2B91%208501021114" value=3D"+918501021114" target=3D"_blank=
">+91 8501021114</a><br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">Emre Can Kucukoglu</div>
</div>

--089e011761913ec6f2051605e77b--
