Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBGNFubX017285
 for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2016 18:15:57 -0500
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
 [209.85.214.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 502005646DC
 for <selinux@tycho.nsa.gov>; Sat, 17 Dec 2016 00:15:47 +0100 (CET)
Received: by mail-it0-f53.google.com with SMTP id y23so33417595itc.0
 for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2016 15:15:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4028608.pKKk40ccRB@russell.coker.com.au>
References: <4028608.pKKk40ccRB@russell.coker.com.au>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 17 Dec 2016 00:15:45 +0100
Message-ID: <CAJfZ7==GE=E0LfnbtwLM1PRPKaiF9SCje+RSi3J8FG41HaP56g@mail.gmail.com>
Subject: Re: Another getcon() vs getcon_raw() issue in systemd
To: Russell Coker <russell@coker.com.au>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1144bb34f3adf10543cebfd4
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1144bb34f3adf10543cebfd4
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 16, 2016 at 1:33 PM, Russell Coker <russell@coker.com.au> wrote:

> http://selinux.tycho.nsa.narkive.com/cZUV3wmW/selinux-set-callback-problem
>
> The above URL has the archive of the last time I raised an issue like this.
> Thanks to Nicolas Iooss for pointing out the solution.
>
> type=USER_AVC msg=audit(1481891298.695:687055): pid=1 uid=0
> auid=4294967295
> ses=4294967295 subj=system_u:system_r:init_t:s0 msg='avc:  denied  {
> status }
> for auid=n/a uid=0 gid=0 cmdline="/lib/systemd/systemd-machined"
> scontext=system_u:system_r:systemd_machined_t:SystemLow
> tcontext=system_u:system_r:init_t:s0 tclass=system
> exe="/lib/systemd/systemd"
> sauid=0 hostname=? addr=? terminal=?'
>
> Now in Debian/Unstable we have a similar issue with systemd 232-7 giving
> audit.log entries like the above.


Hi,
I quickly searched in systemd git tree where the source context comes from.
My starting point was the call to sd_bus_query_sender_creds()
in mac_selinux_generic_access_check() [1]. This function may call
sd_bus_get_name_creds() [2] -> bus_get_name_creds_dbus1() [3]
-> sd_bus_call_method("org.freedesktop.DBus",
..., "GetConnectionSELinuxSecurityContext", ..., "s", unique ? unique :
name) [4]. As the audit entry you sent comes from a DBus call
between systemd-machined and systemd, this code path is likely to have been
the origin of the source context.

The DBus method which is called is implemented in DBus function
bus_driver_handle_get_connection_selinux_security_context() [5], which
calls several functions until libselinux's getpeercon() [6]. As it is not
getpeercon_raw(), this may give the translated label. In order to test
this, could you please execute the following command and tell its output?

dbus-send --system --print-reply --dest=org.freedesktop.DBus
/org/freedesktop/DBus
org.freedesktop.DBus.GetConnectionSELinuxSecurityContext
'string:org.freedesktop.machine1'

Or, if you have not got dbus-send but have gdbus:

gdbus call --system --dest org.freedesktop.DBus --object-path
/org/freedesktop/DBus --method
org.freedesktop.DBus.GetConnectionSELinuxSecurityContext
org.freedesktop.machine1

On my system, which does not use MLS (so I am currently not able to
reproduce the issue), I get: array of bytes
"system_u:system_r:systemd_machined_t". If on your system it gives a
context with SystemLow, it will confirm the origin of the issue. Also, the
DBus specification is quite strange about the method: "Returns the security
context used by SELinux, in an unspecified format. If you know what this
means, please contribute documentation via the D-Bus bug tracking system."
[7]. It seems GetConnectionCredentials should be preferred. In order to see
whether modifying systemd code would be enough to fix this, or whether it
is a bug in the D-Bus interfaces, what does this command return on your
system?

dbus-send --system --print-reply --dest=org.freedesktop.DBus
/org/freedesktop/DBus org.freedesktop.DBus.GetConnectionCredentials
'string:org.freedesktop.machine1'

Cheers,
Nicolas

[1]
https://github.com/systemd/systemd/blob/v232/src/core/selinux-access.c#L206
[2]
https://github.com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-convenience.c#L542
[3]
https://github.com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-control.c#L929
[4]
https://github.com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-control.c#L865
[5]
https://cgit.freedesktop.org/dbus/dbus/tree/bus/driver.c?h=dbus-1.10#n1809
[6]
https://cgit.freedesktop.org/dbus/dbus/tree/bus/selinux.c?h=dbus-1.10#n724
[7]
https://cgit.freedesktop.org/dbus/dbus/tree/doc/dbus-specification.xml?h=dbus-1.10#n6200

--001a1144bb34f3adf10543cebfd4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, Dec 16, 2016 at 1:33 PM, Russell Coker <span dir=3D"ltr">&lt;<a href=3D=
"mailto:russell@coker.com.au" target=3D"_blank">russell@coker.com.au</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><a hre=
f=3D"http://selinux.tycho.nsa.narkive.com/cZUV3wmW/selinux-set-callback-pro=
blem" rel=3D"noreferrer" target=3D"_blank">http://selinux.tycho.nsa.<wbr>na=
rkive.com/cZUV3wmW/selinux-<wbr>set-callback-problem</a><br>
<br>
The above URL has the archive of the last time I raised an issue like this.=
<br>
Thanks to Nicolas Iooss for pointing out the solution.<br>
<br>
type=3DUSER_AVC msg=3Daudit(1481891298.695:<wbr>687055): pid=3D1 uid=3D0 au=
id=3D4294967295<br>
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:<wbr>s0 msg=3D&#39;avc:=C2=
=A0 denied=C2=A0 { status }<br>
for auid=3Dn/a uid=3D0 gid=3D0 cmdline=3D&quot;/lib/systemd/systemd-<wbr>ma=
chined&quot;<br>
scontext=3Dsystem_u:system_r:<wbr>systemd_machined_t:SystemLow<br>
tcontext=3Dsystem_u:system_r:<wbr>init_t:s0 tclass=3Dsystem=C2=A0 exe=3D&qu=
ot;/lib/systemd/systemd&quot;<br>
sauid=3D0 hostname=3D? addr=3D? terminal=3D?&#39;<br>
<br>
Now in Debian/Unstable we have a similar issue with systemd 232-7 giving<br=
>
audit.log entries like the above.</blockquote><div><br></div><div>Hi,</div>=
<div>I quickly searched in systemd git tree where the source context comes =
from. My starting point was the call to=C2=A0sd_bus_query_sender_creds() in=
=C2=A0mac_selinux_generic_access_check() [1]. This function may call sd_bus=
_get_name_creds() [2] -&gt; bus_get_name_creds_dbus1() [3] -&gt;=C2=A0sd_bu=
s_call_method(&quot;org.freedesktop.DBus&quot;, ...,=C2=A0&quot;GetConnecti=
onSELinuxSecurityContext&quot;, ..., &quot;s&quot;,=C2=A0unique ? unique : =
name) [4]. As the audit entry you sent comes from a DBus call between=C2=A0=
systemd-machined and systemd, this code path is likely to have been the ori=
gin of the source context.</div><div><br></div><div>The DBus method which i=
s called is implemented in DBus function=C2=A0<span style=3D"color:rgb(0,0,=
0);font-size:13.3333px">bus_driver_handle_get_connection_selinux_security_c=
ontext()</span>=C2=A0[5], which calls several functions until libselinux&#3=
9;s getpeercon() [6]. As it is not getpeercon_raw(), this may give the tran=
slated label. In order to test this, could you please execute the following=
 command and tell its output?</div><div><br></div><div>dbus-send --system -=
-print-reply --dest=3Dorg.freedesktop.DBus /org/freedesktop/DBus org.freede=
sktop.DBus.GetConnectionSELinuxSecurityContext &#39;string:org.freedesktop.=
machine1&#39;<br></div><div><br></div><div>Or, if you have not got dbus-sen=
d but have gdbus:</div><div><br></div><div>gdbus call --system --dest org.f=
reedesktop.DBus --object-path /org/freedesktop/DBus --method org.freedeskto=
p.DBus.GetConnectionSELinuxSecurityContext org.freedesktop.machine1<br></di=
v><div><br></div><div>On my system, which does not use MLS (so I am current=
ly not able to reproduce the issue), I get:=C2=A0array of bytes &quot;syste=
m_u:system_r:systemd_machined_t&quot;. If on your system it gives a context=
 with SystemLow, it will confirm the origin of the issue. Also, the DBus sp=
ecification is quite strange about the method: &quot;Returns the security c=
ontext used by SELinux, in an unspecified=C2=A0format. If you know what thi=
s means, please contribute=C2=A0documentation via the D-Bus bug tracking sy=
stem.&quot; [7]. It seems=C2=A0GetConnectionCredentials should be preferred=
. In order to see whether modifying systemd code would be enough to fix thi=
s, or whether it is a bug in the D-Bus interfaces, what does this command r=
eturn on your system?</div><div><br></div><div>dbus-send --system --print-r=
eply --dest=3Dorg.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DB=
us.GetConnectionCredentials &#39;string:org.freedesktop.machine1&#39;<br></=
div><div><br></div><div>Cheers,</div><div>Nicolas</div><div><br></div><div>=
[1]=C2=A0<a href=3D"https://github.com/systemd/systemd/blob/v232/src/core/s=
elinux-access.c#L206">https://github.com/systemd/systemd/blob/v232/src/core=
/selinux-access.c#L206</a></div><div>[2]=C2=A0<a href=3D"https://github.com=
/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-convenience.c#L542">ht=
tps://github.com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-conven=
ience.c#L542</a></div></div>[3]=C2=A0<a href=3D"https://github.com/systemd/=
systemd/blob/v232/src/libsystemd/sd-bus/bus-control.c#L929">https://github.=
com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-control.c#L929</a><=
/div><div class=3D"gmail_extra">[4]=C2=A0<a href=3D"https://github.com/syst=
emd/systemd/blob/v232/src/libsystemd/sd-bus/bus-control.c#L865">https://git=
hub.com/systemd/systemd/blob/v232/src/libsystemd/sd-bus/bus-control.c#L865<=
/a></div><div class=3D"gmail_extra">[5]=C2=A0<a href=3D"https://cgit.freede=
sktop.org/dbus/dbus/tree/bus/driver.c?h=3Ddbus-1.10#n1809">https://cgit.fre=
edesktop.org/dbus/dbus/tree/bus/driver.c?h=3Ddbus-1.10#n1809</a></div><div =
class=3D"gmail_extra">[6]=C2=A0<a href=3D"https://cgit.freedesktop.org/dbus=
/dbus/tree/bus/selinux.c?h=3Ddbus-1.10#n724">https://cgit.freedesktop.org/d=
bus/dbus/tree/bus/selinux.c?h=3Ddbus-1.10#n724</a></div><div class=3D"gmail=
_extra">[7]=C2=A0<a href=3D"https://cgit.freedesktop.org/dbus/dbus/tree/doc=
/dbus-specification.xml?h=3Ddbus-1.10#n6200">https://cgit.freedesktop.org/d=
bus/dbus/tree/doc/dbus-specification.xml?h=3Ddbus-1.10#n6200</a></div></div=
>

--001a1144bb34f3adf10543cebfd4--
