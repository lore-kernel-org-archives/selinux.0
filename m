MIME-Version: 1.0
In-Reply-To: <51195783.5080201@tycho.nsa.gov>
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
 <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
 <511946AB.10802@tycho.nsa.gov> <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com>
 <511951CC.1000607@tycho.nsa.gov> <CACcxAnF8p+zJJ7XeV9JbWmLvxKWH2vJKKZXRcUXTN6U6GKy7BA@mail.gmail.com>
 <CACcxAnEXkFasdDFKVw8baaXP7bbgx5vndfL=j7dUAsVhrMxxMA@mail.gmail.com> <51195783.5080201@tycho.nsa.gov>
From: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
Date: Mon, 11 Feb 2013 14:54:57 -0600
Message-ID: <CACcxAnHVdep6fkEFxqwt0ZmoPshDVG1PTvNpEEMGEL_gaZ_d8g@mail.gmail.com>
Subject: Re: systemd selinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d04428210937df904d579212e
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04428210937df904d579212e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I'll talk to the maintainer, we are in 2.1.0 right now, I'll see how to
update the package, for libselinux. Any patch that should be added to the
2.1.9 or any better version?


2013/2/11 Stephen Smalley <sds@tycho.nsa.gov>

> On 02/11/2013 03:22 PM, Brian Iv=E1n Mart=EDnez wrote:
>
>> I did use the makepkg command to test, should I try to ./configure my
>> self?
>>
>
> Looks like systemd requires a specific version of libselinux.
> http://lists.freedesktop.org/**archives/systemd-devel/2012-**
> September/006621.html<http://lists.freedesktop.org/archives/systemd-devel=
/2012-September/006621.html>
>
>


--=20
Ellos se r=EDen de mi por que soy diferente, yo me r=EDo de ellos por que t=
odos
son iguales-- J. Davis

--f46d04428210937df904d579212e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ll talk to the maintainer, we are in 2.1.0 right now=
, I&#39;ll see how to update the package, for libselinux. Any patch that sh=
ould be added to the 2.1.9 or any better version?<br></div><div class=3D"gm=
ail_extra">

<br><br><div class=3D"gmail_quote">2013/2/11 Stephen Smalley <span dir=3D"l=
tr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.ns=
a.gov</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im">On 02/11/2013 03:22 PM, Brian Iv=E1n Mart=EDnez wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I did use the makepkg command to test, should I try to ./configure my self?=
<br>
</blockquote>
<br></div>
Looks like systemd requires a specific version of libselinux.<br>
<a href=3D"http://lists.freedesktop.org/archives/systemd-devel/2012-Septemb=
er/006621.html" target=3D"_blank">http://lists.freedesktop.org/<u></u>archi=
ves/systemd-devel/2012-<u></u>September/006621.html</a><br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Ellos se r=EDen de mi p=
or que soy diferente, yo me r=EDo de ellos por que todos son iguales-- J. D=
avis
</div>

--f46d04428210937df904d579212e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
