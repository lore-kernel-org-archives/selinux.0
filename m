MIME-Version: 1.0
In-Reply-To: <51193FDB.5030506@tycho.nsa.gov>
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
 <51193FDB.5030506@tycho.nsa.gov>
From: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
Date: Mon, 11 Feb 2013 13:17:16 -0600
Message-ID: <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
Subject: Re: pam_selinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d044631703a05a504d577c46c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d044631703a05a504d577c46c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yes, thank you, first of all, and second, one user (the maintainer of the
package) found a patch from Fedora that, for now, seems to be working fine,
but that is not the problem now, the problem is with systemd wich doesn't
compile. The PKGBUILD file says it is version 197 and it applies 2 patches,
use-split-usr-path.patch and
0001-dbus-fix-serialization-of-calendar-timers.patch, then it configures
with the next flags:

--enable-introspection
--enable-gtk-doc
--enable-selinux
--disable-audit
--disable-ima

When I try to build using those files (from
https://aur.archlinux.org/packages/selinux-systemd/) it gets stuck in the
configure part stating:

checking for SELINUX... no
configure: error: *** SELinux support requested but libraries not found

I think it just doesn't find SELinux but then how can I fix it? the only
dirs passed to configure are:

--libexecdir=3D/usr/lib
--localstatedir=3D/var
--sysconfdir=3D/etc

The PKGFILE may be more explicit than me.


2013/2/11 Stephen Smalley <sds@tycho.nsa.gov>

> On 02/09/2013 02:21 PM, Brian Iv=E1n Mart=EDnez wrote:
>
>> Hi, first time mailer here.
>>
>> Lately I've grown curious about SELinux and I would like to be able to
>> install it on my Archlinux. There are packages in the AUR repo but those
>> are from before glibc-2.16, with the update the packages broke. I have
>> successfully build and installed libselinux and libsepol  but now it's
>> turn for pam with selinux enabled which fails with the complain that it
>> doesn't know rlim size in the pam_unix_passwd.c file.
>>
>> I posted this in the G+ group trying to figure out if is a bug in pam or
>> in SELinux and the guys there told me to post it here.
>>
>> The AUR package I try to use to build pam is
>> https://aur.archlinux.org/**packages/selinux-pam/<https://aur.archlinux.=
org/packages/selinux-pam/>.
>>
>
> Can you post the actual error output?  And provide more details about wha=
t
> versions you are using?
>
>
>


--=20
Ellos se r=EDen de mi por que soy diferente, yo me r=EDo de ellos por que t=
odos
son iguales-- J. Davis

--f46d044631703a05a504d577c46c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, thank you, first of all, and second, one user (the ma=
intainer of the package) found a patch from Fedora that, for now, seems to =
be working fine, but that is not the problem now, the problem is with syste=
md wich doesn&#39;t compile. The PKGBUILD file says it is version 197 and i=
t applies 2 patches, use-split-usr-path.patch and 0001-dbus-fix-serializati=
on-of-calendar-timers.patch, then it configures with the next flags:<br>

<br>--enable-introspection<br>--enable-gtk-doc<br>--enable-selinux<br>--dis=
able-audit<br>--disable-ima<br><br>When I try to build using those files (f=
rom <a href=3D"https://aur.archlinux.org/packages/selinux-systemd/">https:/=
/aur.archlinux.org/packages/selinux-systemd/</a>) it gets stuck in the conf=
igure part stating:<br>

<br>checking for SELINUX... no<br>configure: error: *** SELinux support req=
uested but libraries not found<br><br>I think it just doesn&#39;t find SELi=
nux but then how can I fix it? the only dirs passed to configure are:<br>

<br>--libexecdir=3D/usr/lib<br>--localstatedir=3D/var<br>--sysconfdir=3D/et=
c<br><br>The PKGFILE may be more explicit than me.<br></div><div class=3D"g=
mail_extra"><br><br><div class=3D"gmail_quote">2013/2/11 Stephen Smalley <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">=
sds@tycho.nsa.gov</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On 02/09/2013 02:21 PM, Brian Iv=E1n Mart=ED=
nez wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi, first time mailer here.<br>
<br>
Lately I&#39;ve grown curious about SELinux and I would like to be able to<=
br>
install it on my Archlinux. There are packages in the AUR repo but those<br=
>
are from before glibc-2.16, with the update the packages broke. I have<br>
successfully build and installed libselinux and libsepol =A0but now it&#39;=
s<br>
turn for pam with selinux enabled which fails with the complain that it<br>
doesn&#39;t know rlim size in the pam_unix_passwd.c file.<br>
<br>
I posted this in the G+ group trying to figure out if is a bug in pam or<br=
>
in SELinux and the guys there told me to post it here.<br>
<br>
The AUR package I try to use to build pam is<br>
<a href=3D"https://aur.archlinux.org/packages/selinux-pam/" target=3D"_blan=
k">https://aur.archlinux.org/<u></u>packages/selinux-pam/</a> .<br>
</blockquote>
<br>
Can you post the actual error output? =A0And provide more details about wha=
t versions you are using?<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Ellos se r=EDen de mi p=
or que soy diferente, yo me r=EDo de ellos por que todos son iguales-- J. D=
avis
</div>

--f46d044631703a05a504d577c46c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
