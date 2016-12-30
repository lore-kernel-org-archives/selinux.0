Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBUHh5PY013559
 for <selinux@tycho.nsa.gov>; Fri, 30 Dec 2016 12:43:05 -0500
Received: by mail-it0-f48.google.com with SMTP id 75so218007044ite.1
 for <selinux@tycho.nsa.gov>; Fri, 30 Dec 2016 09:43:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <70625685.47kgmqZV44@russell.coker.com.au>
References: <4028608.pKKk40ccRB@russell.coker.com.au>
 <7415401.n4TOyH4plo@russell.coker.com.au>
 <CAJfZ7=nLMJdwfYRCuPR5LssYHXp2SZ00cPk9RxKa=e_3EsHLNQ@mail.gmail.com>
 <70625685.47kgmqZV44@russell.coker.com.au>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Fri, 30 Dec 2016 12:43:01 -0500
Message-ID: <CAB9W1A2bzpKEWEzpxqou=cWnvWkURxQVSjPDyVe3EBB0B8NA0w@mail.gmail.com>
Subject: Re: Another getcon() vs getcon_raw() issue in systemd
To: russell@coker.com.au
Cc: selinux <selinux@tycho.nsa.gov>, Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: multipart/alternative; boundary=001a114a8040c5c7090544e3bbec
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114a8040c5c7090544e3bbec
Content-Type: text/plain; charset=UTF-8

On Dec 30, 2016 8:08 AM, "Russell Coker" <russell@coker.com.au> wrote:

On Monday, 26 December 2016 7:10:19 PM AEDT Nicolas Iooss wrote:
> With the output you gave I searched in D-Bus source how the
> LinuxSecurityLabel was computed here. I discovered a lot of files in dbus/
> directory which seem to duplicate things from bus/ I have described in my
> previous email. In dbus/dbus-sysdeps-unix.c there is a function which
calls
> "getsockopt (client_fd, SOL_SOCKET, SO_PEERSEC, ...)" in order to get this
> "system_u:system_r:systemd_machined_t:s0"
> (add_linux_security_label_to_credentials,
> https://cgit.freedesktop.org/dbus/dbus/tree/dbus/dbus-
sysdeps-unix.c?h=dbus-> 1.10#n1760). This function queries the same kernel
API as libselinux's
> getpeercon_raw(), but without using libselinux (which is normal as it can
> also returns Smack or AppArmor labels). This is why the context is not
> translated.
>
> The documentation of GetConnectionCredentials->LinuxSecurityLabel is way
> better than the one of GetConnectionSELinuxSecurityContext in D-Bus
> specification (
> https://cgit.freedesktop.org/dbus/dbus/tree/doc/dbus-
specification.xml?h=dbu
> s-1.10#n6030) so if I were to decide, I would rather migrate systemd's
> bus_get_name_creds_dbus1() to GetConnectionCredentials (in
> https://github.com/systemd/systemd/blob/v232/src/
libsystemd/sd-bus/bus-contr
> ol.c#L865). However this implies some non-trivial systemd code
modifications
> and I do not know how systemd developers are willing to modify this part
of
> their code.
> An other option consists in making D-Bus use getpeercon_raw() in
> GetConnectionSELinuxSecurityContext (and documenting this in the D-Bus
> spec). I do not know what subtle side-effects such a change would have on
a
> system (a quick search of users of this interface on searchcode.com gave
> some Android-related projects).

Thanks for your suggestions.  I ran a VM of Fedora 24 with my policy to test
this.  Fedora 24 ran well with that and gave no such errors.  Fedora has
dbus
1.11.8 (development) and systemd 229 while Debian/Unstable has dbus 1.10.14
(stable) and systemd 332.

A did a diff on the Fedora 24 dbus source and the Debian dbus source and
didn't find anything that seemed to be related.  So I presume that it's more
related to systemd - which doesn't necessarily imply that changing systemd
is
the correct way to fix it.

I'll try rawhide now.


Fedora no longer runs mcstransd by default, so that may also be relevant.
Dbusd should likely provide the raw context to clients so that they are
free to use either the raw or translated interfaces without difficulty.


--
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a114a8040c5c7090544e3bbec
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
">On Dec 30, 2016 8:08 AM, &quot;Russell Coker&quot; &lt;<a href=3D"mailto:=
russell@coker.com.au">russell@coker.com.au</a>&gt; wrote:<br type=3D"attrib=
ution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">On Monday, 26 De=
cember 2016 7:10:19 PM AEDT Nicolas Iooss wrote:<br>
&gt; With the output you gave I searched in D-Bus source how the<br>
&gt; LinuxSecurityLabel was computed here. I discovered a lot of files in d=
bus/<br>
&gt; directory which seem to duplicate things from bus/ I have described in=
 my<br>
&gt; previous email. In dbus/dbus-sysdeps-unix.c there is a function which =
calls<br>
&gt; &quot;getsockopt (client_fd, SOL_SOCKET, SO_PEERSEC, ...)&quot; in ord=
er to get this<br>
&gt; &quot;system_u:system_r:systemd_<wbr>machined_t:s0&quot;<br>
&gt; (add_linux_security_label_to_<wbr>credentials,<br>
</div>&gt; <a href=3D"https://cgit.freedesktop.org/dbus/dbus/tree/dbus/dbus=
-sysdeps-unix.c?h=3Ddbus-" rel=3D"noreferrer" target=3D"_blank">https://cgi=
t.freedesktop.org/<wbr>dbus/dbus/tree/dbus/dbus-<wbr>sysdeps-unix.c?h=3Ddbu=
s-</a>&gt; 1.10#n1760). This function queries the same kernel API as libsel=
inux&#39;s<br>
<div class=3D"quoted-text">&gt; getpeercon_raw(), but without using libseli=
nux (which is normal as it can<br>
&gt; also returns Smack or AppArmor labels). This is why the context is not=
<br>
&gt; translated.<br>
&gt;<br>
&gt; The documentation of GetConnectionCredentials-&gt;<wbr>LinuxSecurityLa=
bel is way<br>
&gt; better than the one of GetConnectionSELinuxSecurityCo<wbr>ntext in D-B=
us<br>
&gt; specification (<br>
&gt; <a href=3D"https://cgit.freedesktop.org/dbus/dbus/tree/doc/dbus-specif=
ication.xml?h=3Ddbu" rel=3D"noreferrer" target=3D"_blank">https://cgit.free=
desktop.org/<wbr>dbus/dbus/tree/doc/dbus-<wbr>specification.xml?h=3Ddbu</a>=
<br>
&gt; s-1.10#n6030) so if I were to decide, I would rather migrate systemd&#=
39;s<br>
&gt; bus_get_name_creds_dbus1() to GetConnectionCredentials (in<br>
&gt; <a href=3D"https://github.com/systemd/systemd/blob/v232/src/libsystemd=
/sd-bus/bus-contr" rel=3D"noreferrer" target=3D"_blank">https://github.com/=
systemd/<wbr>systemd/blob/v232/src/<wbr>libsystemd/sd-bus/bus-contr</a><br>
&gt; ol.c#L865). However this implies some non-trivial systemd code modific=
ations<br>
&gt; and I do not know how systemd developers are willing to modify this pa=
rt of<br>
&gt; their code.<br>
&gt; An other option consists in making D-Bus use getpeercon_raw() in<br>
&gt; GetConnectionSELinuxSecurityCo<wbr>ntext (and documenting this in the =
D-Bus<br>
&gt; spec). I do not know what subtle side-effects such a change would have=
 on a<br>
&gt; system (a quick search of users of this interface on <a href=3D"http:/=
/searchcode.com" rel=3D"noreferrer" target=3D"_blank">searchcode.com</a> ga=
ve<br>
&gt; some Android-related projects).<br>
<br>
</div>Thanks for your suggestions.=C2=A0 I ran a VM of Fedora 24 with my po=
licy to test<br>
this.=C2=A0 Fedora 24 ran well with that and gave no such errors.=C2=A0 Fed=
ora has dbus<br>
1.11.8 (development) and systemd 229 while Debian/Unstable has dbus 1.10.14=
<br>
(stable) and systemd 332.<br>
<br>
A did a diff on the Fedora 24 dbus source and the Debian dbus source and<br=
>
didn&#39;t find anything that seemed to be related.=C2=A0 So I presume that=
 it&#39;s more<br>
related to systemd - which doesn&#39;t necessarily imply that changing syst=
emd is<br>
the correct way to fix it.<br>
<br>
I&#39;ll try rawhide now.<br></blockquote></div></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Fedora no longer runs mcstransd by default, =
so that may also be relevant.=C2=A0 Dbusd should likely provide the raw con=
text to clients so that they are free to use either the raw or translated i=
nterfaces without difficulty.=C2=A0</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquo=
te class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<div class=3D"elided-text"><br>
--<br>
My Main Blog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://etbe.coker.=
com.au/" rel=3D"noreferrer" target=3D"_blank">http://etbe.coker.com.au/</a>=
<br>
My Documents Blog=C2=A0 =C2=A0 <a href=3D"http://doc.coker.com.au/" rel=3D"=
noreferrer" target=3D"_blank">http://doc.coker.com.au/</a><br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</div></blockquote></div><br></div></div></div>

--001a114a8040c5c7090544e3bbec--
