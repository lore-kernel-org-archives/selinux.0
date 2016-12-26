Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBQIAUvM001075
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 13:10:30 -0500
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com
 [209.85.214.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id C9E195606B0
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 19:10:20 +0100 (CET)
Received: by mail-it0-f46.google.com with SMTP id x2so154388535itf.1
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 10:10:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7415401.n4TOyH4plo@russell.coker.com.au>
References: <4028608.pKKk40ccRB@russell.coker.com.au>
 <CAJfZ7==GE=E0LfnbtwLM1PRPKaiF9SCje+RSi3J8FG41HaP56g@mail.gmail.com>
 <7415401.n4TOyH4plo@russell.coker.com.au>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Mon, 26 Dec 2016 19:10:19 +0100
Message-ID: <CAJfZ7=nLMJdwfYRCuPR5LssYHXp2SZ00cPk9RxKa=e_3EsHLNQ@mail.gmail.com>
Subject: Re: Another getcon() vs getcon_raw() issue in systemd
To: Russell Coker <russell@coker.com.au>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114abf06059490054493a6ab
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114abf06059490054493a6ab
Content-Type: text/plain; charset=UTF-8

On Mon, Dec 26, 2016 at 11:33 AM, Russell Coker <russell@coker.com.au>
wrote:

> On Saturday, 17 December 2016 12:15:45 AM AEDT Nicolas Iooss wrote:
> > On Fri, Dec 16, 2016 at 1:33 PM, Russell Coker <russell@coker.com.au>
> wrote:
> > > http://selinux.tycho.nsa.narkive.com/cZUV3wmW/selinux-
> set-callback-problem
> > >
> > > The above URL has the archive of the last time I raised an issue like
> > > this.
> > > Thanks to Nicolas Iooss for pointing out the solution.
> > >
> > > type=USER_AVC msg=audit(1481891298.695:687055): pid=1 uid=0
> > > auid=4294967295
> > > ses=4294967295 subj=system_u:system_r:init_t:s0 msg='avc:  denied  {
> > > status }
> > > for auid=n/a uid=0 gid=0 cmdline="/lib/systemd/systemd-machined"
> > > scontext=system_u:system_r:systemd_machined_t:SystemLow
> > > tcontext=system_u:system_r:init_t:s0 tclass=system
> > > exe="/lib/systemd/systemd"
> > > sauid=0 hostname=? addr=? terminal=?'
> > >
> > > Now in Debian/Unstable we have a similar issue with systemd 232-7
> giving
> > > audit.log entries like the above.
> >
> > [...]
> >
> > dbus-send --system --print-reply --dest=org.freedesktop.DBus
> > /org/freedesktop/DBus
> > org.freedesktop.DBus.GetConnectionSELinuxSecurityContext
> > 'string:org.freedesktop.machine1'
>
> Below is the output, looks like your analysis is correct.
>
> method return time=1482748196.242707 sender=org.freedesktop.DBus ->
> destination=:1.1301 serial=3 reply_serial=2
>    array of bytes "system_u:system_r:systemd_machined_t:SystemLow"
>
> > DBus specification is quite strange about the method: "Returns the
> security
> > context used by SELinux, in an unspecified format. If you know what this
> > means, please contribute documentation via the D-Bus bug tracking
> system."
>
> Strange, something for someone here to look into I guess.
>
> > [7]. It seems GetConnectionCredentials should be preferred. In order to
> see
> > whether modifying systemd code would be enough to fix this, or whether it
> > is a bug in the D-Bus interfaces, what does this command return on your
> > system?
> >
> > dbus-send --system --print-reply --dest=org.freedesktop.DBus
> > /org/freedesktop/DBus org.freedesktop.DBus.GetConnectionCredentials
> > 'string:org.freedesktop.machine1'
>
> Here's the result, does it indicate that D-Bus or systemd should be
> changed?
>
> method return time=1482748196.247091 sender=org.freedesktop.DBus ->
> destination=:1.1302 serial=3 reply_serial=2
>    array [
>       dict entry(
>          string "ProcessID"
>          variant             uint32 1123
>       )
>       dict entry(
>          string "UnixUserID"
>          variant             uint32 0
>       )
>       dict entry(
>          string "LinuxSecurityLabel"
>          variant             array of bytes
> "system_u:system_r:systemd_machined_t:s0" + \0
>       )
>    ]
>
> Thanks for your help.  I hope to get this fixed before the next release of
> Debian is frozen...


With the output you gave I searched in D-Bus source how the
LinuxSecurityLabel was computed here. I discovered a lot of files in dbus/
directory which seem to duplicate things from bus/ I have described in my
previous email. In dbus/dbus-sysdeps-unix.c there is a function which calls
"getsockopt (client_fd, SOL_SOCKET, SO_PEERSEC, ...)" in order to get this
"system_u:system_r:systemd_machined_t:s0"
(add_linux_security_label_to_credentials,
https://cgit.freedesktop.org/dbus/dbus/tree/dbus/dbus-sysdeps-unix.c?h=dbus-1.10#n1760).
This function queries the same kernel API as libselinux's getpeercon_raw(),
but without using libselinux (which is normal as it can also returns Smack
or AppArmor labels). This is why the context is not translated.

The documentation of GetConnectionCredentials->LinuxSecurityLabel is way
better than the one of GetConnectionSELinuxSecurityContext in D-Bus
specification (
https://cgit.freedesktop.org/dbus/dbus/tree/doc/dbus-specification.xml?h=dbus-1.10#n6030)
so if I were to decide, I would rather migrate systemd's
bus_get_name_creds_dbus1() to GetConnectionCredentials (in
https://github.com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-control.c#L865).
However this implies some non-trivial systemd code modifications and I do
not know how systemd developers are willing to modify this part of their
code.
An other option consists in making D-Bus use getpeercon_raw() in
GetConnectionSELinuxSecurityContext (and documenting this in the D-Bus
spec). I do not know what subtle side-effects such a change would have on a
system (a quick search of users of this interface on searchcode.com gave
some Android-related projects).

Cheers,
Nicolas

--001a114abf06059490054493a6ab
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Dec 26, 2016 at 11:33 AM, Russell Coker <span dir=3D"ltr">&lt;<a href=
=3D"mailto:russell@coker.com.au" target=3D"_blank">russell@coker.com.au</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Saturday, 17 December 2=
016 12:15:45 AM AEDT Nicolas Iooss wrote:<br>
&gt; On Fri, Dec 16, 2016 at 1:33 PM, Russell Coker &lt;<a href=3D"mailto:r=
ussell@coker.com.au">russell@coker.com.au</a>&gt; wrote:<br>
&gt; &gt; <a href=3D"http://selinux.tycho.nsa.narkive.com/cZUV3wmW/selinux-=
set-callback-problem" rel=3D"noreferrer" target=3D"_blank">http://selinux.t=
ycho.nsa.<wbr>narkive.com/cZUV3wmW/selinux-<wbr>set-callback-problem</a><br=
>
&gt; &gt;<br>
&gt; &gt; The above URL has the archive of the last time I raised an issue =
like<br>
&gt; &gt; this.<br>
&gt; &gt; Thanks to Nicolas Iooss for pointing out the solution.<br>
&gt; &gt;<br>
&gt; &gt; type=3DUSER_AVC msg=3Daudit(1481891298.695:<wbr>687055): pid=3D1 =
uid=3D0<br>
&gt; &gt; auid=3D4294967295<br>
&gt; &gt; ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:<wbr>s0 msg=3D&#=
39;avc:=C2=A0 denied=C2=A0 {<br>
&gt; &gt; status }<br>
&gt; &gt; for auid=3Dn/a uid=3D0 gid=3D0 cmdline=3D&quot;/lib/systemd/syste=
md-<wbr>machined&quot;<br>
&gt; &gt; scontext=3Dsystem_u:system_r:<wbr>systemd_machined_t:SystemLow<br=
>
&gt; &gt; tcontext=3Dsystem_u:system_r:<wbr>init_t:s0 tclass=3Dsystem<br>
&gt; &gt; exe=3D&quot;/lib/systemd/systemd&quot;<br>
&gt; &gt; sauid=3D0 hostname=3D? addr=3D? terminal=3D?&#39;<br>
&gt; &gt;<br>
&gt; &gt; Now in Debian/Unstable we have a similar issue with systemd 232-7=
 giving<br>
&gt; &gt; audit.log entries like the above.<br>
&gt;<br>
&gt; [...]<br>
&gt;<br>
&gt; dbus-send --system --print-reply --dest=3Dorg.freedesktop.DBus<br>
&gt; /org/freedesktop/DBus<br>
&gt; org.freedesktop.DBus.<wbr>GetConnectionSELinuxSecurityCo<wbr>ntext<br>
&gt; &#39;string:org.freedesktop.<wbr>machine1&#39;<br>
<br>
</div></div>Below is the output, looks like your analysis is correct.<br>
<br>
method return time=3D1482748196.242707 sender=3Dorg.freedesktop.DBus -&gt;<=
br>
destination=3D:1.1301 serial=3D3 reply_serial=3D2<br>
=C2=A0 =C2=A0array of bytes &quot;system_u:system_r:systemd_<wbr>machined_t=
:SystemLow&quot;<br>
<span class=3D"gmail-"><br>
&gt; DBus specification is quite strange about the method: &quot;Returns th=
e security<br>
&gt; context used by SELinux, in an unspecified format. If you know what th=
is<br>
&gt; means, please contribute documentation via the D-Bus bug tracking syst=
em.&quot;<br>
<br>
</span>Strange, something for someone here to look into I guess.<br>
<span class=3D"gmail-"><br>
&gt; [7]. It seems GetConnectionCredentials should be preferred. In order t=
o see<br>
&gt; whether modifying systemd code would be enough to fix this, or whether=
 it<br>
&gt; is a bug in the D-Bus interfaces, what does this command return on you=
r<br>
&gt; system?<br>
&gt;<br>
&gt; dbus-send --system --print-reply --dest=3Dorg.freedesktop.DBus<br>
&gt; /org/freedesktop/DBus org.freedesktop.DBus.<wbr>GetConnectionCredentia=
ls<br>
&gt; &#39;string:org.freedesktop.<wbr>machine1&#39;<br>
<br>
</span>Here&#39;s the result, does it indicate that D-Bus or systemd should=
 be changed?<br>
<br>
method return time=3D1482748196.247091 sender=3Dorg.freedesktop.DBus -&gt;<=
br>
destination=3D:1.1302 serial=3D3 reply_serial=3D2<br>
=C2=A0 =C2=A0array [<br>
=C2=A0 =C2=A0 =C2=A0 dict entry(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string &quot;ProcessID&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0variant=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0uint32 1123<br>
=C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 dict entry(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string &quot;UnixUserID&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0variant=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0uint32 0<br>
=C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 dict entry(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string &quot;LinuxSecurityLabel&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0variant=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0array of bytes<br>
&quot;system_u:system_r:systemd_<wbr>machined_t:s0&quot; + \0<br>
=C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0]<br>
<br>
Thanks for your help.=C2=A0 I hope to get this fixed before the next releas=
e of<br>
Debian is frozen...</blockquote><div><br></div><div>With the output you gav=
e I searched in D-Bus source how the LinuxSecurityLabel was computed here. =
I discovered a lot of files in dbus/ directory which seem to duplicate thin=
gs from bus/ I have described in my previous email. In=C2=A0dbus/dbus-sysde=
ps-unix.c there is a function which calls &quot;getsockopt (client_fd, SOL_=
SOCKET, SO_PEERSEC, ...)&quot; in order to get this &quot;system_u:system_r=
:systemd_<wbr>machined_t:s0&quot; (add_linux_security_label_to_credentials,=
 <a href=3D"https://cgit.freedesktop.org/dbus/dbus/tree/dbus/dbus-sysdeps-u=
nix.c?h=3Ddbus-1.10#n1760">https://cgit.freedesktop.org/dbus/dbus/tree/dbus=
/dbus-sysdeps-unix.c?h=3Ddbus-1.10#n1760</a>). This function queries the sa=
me kernel API as libselinux&#39;s getpeercon_raw(), but without using libse=
linux (which is normal as it can also returns Smack or AppArmor labels). Th=
is is why the context is not translated.</div><div><br></div><div>The docum=
entation of GetConnectionCredentials-&gt;LinuxSecurityLabel is way better t=
han the one of GetConnectionSELinuxSecurityCo<wbr>ntext in D-Bus specificat=
ion (<a href=3D"https://cgit.freedesktop.org/dbus/dbus/tree/doc/dbus-specif=
ication.xml?h=3Ddbus-1.10#n6030">https://cgit.freedesktop.org/dbus/dbus/tre=
e/doc/dbus-specification.xml?h=3Ddbus-1.10#n6030</a>) so if I were to decid=
e, I would rather migrate systemd&#39;s bus_get_name_creds_dbus1() to GetCo=
nnectionCredentials (in=C2=A0<a href=3D"https://github.com/systemd/systemd/=
blob/v232/src/libsystemd/sd-bus/bus-control.c#L865">https://github.com/syst=
emd/systemd/blob/v232/src/libsystemd/sd-bus/bus-control.c#L865</a>). Howeve=
r this implies some non-trivial systemd code modifications and I do not kno=
w how systemd developers are willing to modify this part of their code.</di=
v><div>An other option consists in making D-Bus use getpeercon_raw() in Get=
ConnectionSELinuxSecurityCo<wbr>ntext (and documenting this in the D-Bus sp=
ec). I do not know what subtle side-effects such a change would have on a s=
ystem (a quick search of users of this interface on <a href=3D"http://searc=
hcode.com">searchcode.com</a> gave some Android-related projects).</div><di=
v><br></div><div>Cheers,</div><div>Nicolas</div></div><br></div></div>

--001a114abf06059490054493a6ab--
