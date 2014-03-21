Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2LDbPDp026491
 for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2014 09:37:25 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so2411507pab.37
 for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2014 06:37:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <01e101cf4509$9942ae60$cbc80b20$@nrl.navy.mil>
References: <01e101cf4509$9942ae60$cbc80b20$@nrl.navy.mil>
Date: Fri, 21 Mar 2014 17:37:24 +0400
Message-ID: <CABu+-8q=3RCtHep+3szWRX9F8OmXgZ2hBe9247BHQHz7U0rXeg@mail.gmail.com>
Subject: Re: How to restore a policy module
From: Ilya Frolov <ilya.a.frolov@gmail.com>
To: kim.lawson-jenkins@nrl.navy.mil
Content-Type: multipart/alternative; boundary=047d7b6dce406908e604f51dfc18
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b6dce406908e604f51dfc18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Kim,

i'd downloaded rpm, containing relevant module, unpacked it and then used
semodule -i /path/to/module.pp to replace it.
Also, i think simple reinstall of the policy would do the trick.

Here's what i base my assumption on:

root@selinux:/root # cp /etc/selinux/custom/modules/active/modules/apt.pp
/tmp/
root@selinux:/root # semodule -l | grep apt
apt     1.8.2
root@selinux:/root # semodule -r apt
root@selinux:/root # ls -la /etc/selinux/custom/modules/active/modules/apt*
ls: cannot access /etc/selinux/custom/modules/active/modules/apt*: No such
file or directory
root@selinux:/root # semodule -i /tmp/apt.pp
root@selinux:/root # ls -la /etc/selinux/custom/modules/active/modules/apt*
-rw-------. 1 root root 6814 Mar 21 13:33
/etc/selinux/custom/modules/active/modules/apt.pp


regards,
ilya


On Fri, Mar 21, 2014 at 5:29 PM, Kim Lawson-Jenkins <
kim.lawson-jenkins@nrl.navy.mil> wrote:

> In an attempt to lockdown a system I removed the remotelogin policy modul=
e
> using semodule =E2=80=93r.  I=E2=80=99m using the targeted policy on RHEL=
6.  How do I add
> this file back to my current configuration?
>
>
>
>
>
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
>

--047d7b6dce406908e604f51dfc18
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Kim,<div><br></div><div>i&#39;d downloaded rpm, cont=
aining relevant module, unpacked it and then used semodule -i /path/to/modu=
le.pp to replace it.</div><div>Also, i think simple reinstall of the policy=
 would do the trick.</div>
<div><br></div><div>Here&#39;s what i base my assumption on:</div><div><br>=
</div><div><div>root@selinux:/root # cp /etc/selinux/custom/modules/active/=
modules/apt.pp /tmp/</div><div>root@selinux:/root # semodule -l | grep apt<=
/div>
<div>apt =C2=A0 =C2=A0 1.8.2</div><div>root@selinux:/root # semodule -r apt=
</div><div>root@selinux:/root # ls -la /etc/selinux/custom/modules/active/m=
odules/apt*</div><div>ls: cannot access /etc/selinux/custom/modules/active/=
modules/apt*: No such file or directory</div>
<div>root@selinux:/root # semodule -i /tmp/apt.pp=C2=A0</div><div>root@seli=
nux:/root # ls -la /etc/selinux/custom/modules/active/modules/apt*</div><di=
v>-rw-------. 1 root root 6814 Mar 21 13:33 /etc/selinux/custom/modules/act=
ive/modules/apt.pp</div>
</div><div><br></div><div><br></div><div>regards,</div><div>ilya</div></div=
><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Mar =
21, 2014 at 5:29 PM, Kim Lawson-Jenkins <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:kim.lawson-jenkins@nrl.navy.mil" target=3D"_blank">kim.lawson-jenkins@=
nrl.navy.mil</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">

<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div><p class=3D"MsoNorm=
al">In an attempt to lockdown a system I removed the remotelogin policy mod=
ule using semodule =E2=80=93r.=C2=A0 I=E2=80=99m using the targeted policy =
on RHEL6.=C2=A0 How do I add this file back to my current configuration?<u>=
</u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p><p class=3D"MsoNormal"><u></=
u>=C2=A0<u></u></p><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p><p class=
=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div></div><br>____________________=
___________________________<br>

Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
<br></blockquote></div><br></div>

--047d7b6dce406908e604f51dfc18--
