Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v21MSfEt003238
 for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2017 17:28:41 -0500
Received: by mail-wm0-f52.google.com with SMTP id n11so10697983wma.0
 for <selinux@tycho.nsa.gov>; Wed, 01 Mar 2017 14:28:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
From: cgzones <cgzones@googlemail.com>
Date: Wed, 1 Mar 2017 23:28:38 +0100
Message-ID: <CAJ2a_DdGZcTr+877CUjWTC97Mg7ROAXTgyESpEq54nBpC-HvkQ@mail.gmail.com>
Subject: Re: SELinux type transition rule not working
To: Ian Pilcher <arequipeno@gmail.com>
Cc: Systemd <systemd-devel@lists.freedesktop.org>,
 selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1146e5588e72dd0549b2d5fb
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1146e5588e72dd0549b2d5fb
Content-Type: text/plain; charset=UTF-8

On 1 Mar 2017 10:41 pm, "Ian Pilcher" <arequipeno@gmail.com> wrote:

I am using systemd's RuntimeDirectory to create a directory for a
service.

   RuntimeDirectory=squoxy

This causes systemd to create /run/squoxy before starting my service,
but I haven't been able to get the SELinux context set correctly on the
directory.

I've set file context rules for both /run/squoxy and /var/run/squoxy:

^/var/run/squoxy(/.*)?  all files  system_u:object_r:squoxy_var_run_t:s0
^/run/squoxy(/.*)?      all files  system_u:object_r:squoxy_var_run_t:s0

And, indeed, restorecon will set the context of the directory to
squoxy_var_run_t.

I've also added a type transition rule, attempting to get the correct
context applied automatically when systemd creates the directory:

type_transition init_t var_run_t : dir squoxy_var_run_t "squoxy";

Can you try a transition from initrc_t or the interface
init_daemon_pid_file()

But the directory is still being created as var_run_t:

drwxr-xr-x. nobody nobody system_u:object_r:var_run_t:s0   /run/squoxy

What am I doing wrong?

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a1146e5588e72dd0549b2d5fb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On 1 Mar 2017 10:41 pm, &quot;Ian Pilcher&quot; &lt;<a href=3D"ma=
ilto:arequipeno@gmail.com">arequipeno@gmail.com</a>&gt; wrote:<br type=3D"a=
ttribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">I am using systemd&#39;s RuntimeDirect=
ory to create a directory for a<br>
service.<br>
<br>
=C2=A0 =C2=A0RuntimeDirectory=3Dsquoxy<br>
<br>
This causes systemd to create /run/squoxy before starting my service,<br>
but I haven&#39;t been able to get the SELinux context set correctly on the=
<br>
directory.<br>
<br>
I&#39;ve set file context rules for both /run/squoxy and /var/run/squoxy:<b=
r>
<br>
^/var/run/squoxy(/.*)?=C2=A0 all files=C2=A0 system_u:object_r:squoxy_var_r=
<wbr>un_t:s0<br>
^/run/squoxy(/.*)?=C2=A0 =C2=A0 =C2=A0 all files=C2=A0 system_u:object_r:sq=
uoxy_var_r<wbr>un_t:s0<br>
<br>
And, indeed, restorecon will set the context of the directory to<br>
squoxy_var_run_t.<br>
<br>
I&#39;ve also added a type transition rule, attempting to get the correct<b=
r>
context applied automatically when systemd creates the directory:<br>
<br>
type_transition init_t var_run_t : dir squoxy_var_run_t &quot;squoxy&quot;;=
<br></blockquote></div></div></div><div dir=3D"auto">Can you try a transiti=
on from initrc_t or the interface init_daemon_pid_file()</div><div dir=3D"a=
uto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote clas=
s=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
But the directory is still being created as var_run_t:<br>
<br>
drwxr-xr-x. nobody nobody system_u:object_r:var_run_t:<wbr>s0=C2=A0 =C2=A0/=
run/squoxy<br>
<br>
What am I doing wrong?<font color=3D"#888888"><br>
<br>
-- <br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
Ian Pilcher=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0<a href=3D"mailto:arequipeno@gmail.com" target=3D"_blank">arequip=
eno@gmail.com</a><br>
-------- &quot;I grew up before Mark Zuckerberg invented friendship&quot; -=
-------<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</font></blockquote></div><br></div></div></div>

--001a1146e5588e72dd0549b2d5fb--
