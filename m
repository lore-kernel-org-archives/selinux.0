MIME-Version: 1.0
In-Reply-To: <511946AB.10802@tycho.nsa.gov>
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
 <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
 <511946AB.10802@tycho.nsa.gov>
From: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
Date: Mon, 11 Feb 2013 13:31:48 -0600
Message-ID: <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com>
Subject: Re: systemd selinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=bcaec54d43ea3683ea04d577f84a
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec54d43ea3683ea04d577f84a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

yes, I have a /usr/lib/pkgconfig/libselinux.pc , mm I'm using a 64bit
system, does that matter?


2013/2/11 Stephen Smalley <sds@tycho.nsa.gov>

> On 02/11/2013 02:17 PM, Brian Iv=E1n Mart=EDnez wrote:
>
>> Yes, thank you, first of all, and second, one user (the maintainer of
>> the package) found a patch from Fedora that, for now, seems to be
>> working fine, but that is not the problem now, the problem is with
>> systemd wich doesn't compile. The PKGBUILD file says it is version 197
>> and it applies 2 patches, use-split-usr-path.patch and
>> 0001-dbus-fix-serialization-**of-calendar-timers.patch, then it
>> configures
>> with the next flags:
>>
>> --enable-introspection
>> --enable-gtk-doc
>> --enable-selinux
>> --disable-audit
>> --disable-ima
>>
>> When I try to build using those files (from
>> https://aur.archlinux.org/**packages/selinux-systemd/<https://aur.archli=
nux.org/packages/selinux-systemd/>)
>> it gets stuck in
>> the configure part stating:
>>
>> checking for SELINUX... no
>> configure: error: *** SELinux support requested but libraries not found
>>
>> I think it just doesn't find SELinux but then how can I fix it? the only
>> dirs passed to configure are:
>>
>> --libexecdir=3D/usr/lib
>> --localstatedir=3D/var
>> --sysconfdir=3D/etc
>>
>> The PKGFILE may be more explicit than me.
>>
>
> Do you have a /usr/lib/pkgconfig/libselinux.**pc or /usr/lib64/pkgconfig/=
*
> *libselinux.pc file?
>
>
>


--=20
Ellos se r=EDen de mi por que soy diferente, yo me r=EDo de ellos por que t=
odos
son iguales-- J. Davis

--bcaec54d43ea3683ea04d577f84a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">yes, I have a /usr/lib/pkgconfig/libselinux.pc , mm I&#39;=
m using a 64bit system, does that matter?<br></div><div class=3D"gmail_extr=
a"><br><br><div class=3D"gmail_quote">2013/2/11 Stephen Smalley <span dir=
=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tyc=
ho.nsa.gov</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On 02/11/2013 02:17 PM, Brian Iv=E1n Mart=ED=
nez wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Yes, thank you, first of all, and second, one user (the maintainer of<br>
the package) found a patch from Fedora that, for now, seems to be<br>
working fine, but that is not the problem now, the problem is with<br>
systemd wich doesn&#39;t compile. The PKGBUILD file says it is version 197<=
br>
and it applies 2 patches, use-split-usr-path.patch and<br>
0001-dbus-fix-serialization-<u></u>of-calendar-timers.patch, then it config=
ures<br>
with the next flags:<br>
<br>
--enable-introspection<br>
--enable-gtk-doc<br>
--enable-selinux<br>
--disable-audit<br>
--disable-ima<br>
<br>
When I try to build using those files (from<br>
<a href=3D"https://aur.archlinux.org/packages/selinux-systemd/" target=3D"_=
blank">https://aur.archlinux.org/<u></u>packages/selinux-systemd/</a>) it g=
ets stuck in<br>
the configure part stating:<br>
<br>
checking for SELINUX... no<br>
configure: error: *** SELinux support requested but libraries not found<br>
<br>
I think it just doesn&#39;t find SELinux but then how can I fix it? the onl=
y<br>
dirs passed to configure are:<br>
<br>
--libexecdir=3D/usr/lib<br>
--localstatedir=3D/var<br>
--sysconfdir=3D/etc<br>
<br>
The PKGFILE may be more explicit than me.<br>
</blockquote>
<br>
Do you have a /usr/lib/pkgconfig/libselinux.<u></u>pc or /usr/lib64/pkgconf=
ig/<u></u>libselinux.pc file?<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Ellos se r=EDen de mi p=
or que soy diferente, yo me r=EDo de ellos por que todos son iguales-- J. D=
avis
</div>

--bcaec54d43ea3683ea04d577f84a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
