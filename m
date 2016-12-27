Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBRIPpFp028996
 for <selinux@tycho.nsa.gov>; Tue, 27 Dec 2016 13:25:53 -0500
Received: by mail-it0-f54.google.com with SMTP id o141so152914773itc.0
 for <selinux@tycho.nsa.gov>; Tue, 27 Dec 2016 10:25:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161227120145.75ff429f@gentp.lnet>
References: <20161227120145.75ff429f@gentp.lnet>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Tue, 27 Dec 2016 13:25:47 -0500
Message-ID: <CAB9W1A2pTt1gArG0tbmkw8Qo=V7wb2CdVhEUM5LUL1YQowxTNA@mail.gmail.com>
Subject: Re: Domain of kernel module initalization code
To: Luis Ressel <aranea@aixah.de>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114a80403557f10544a7fbba
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114a80403557f10544a7fbba
Content-Type: text/plain; charset=UTF-8

On Dec 27, 2016 6:04 AM, "Luis Ressel" <aranea@aixah.de> wrote:

Hello,

when a userspace program A (usually kmod or udev) instructs the kernel
to load a kernel module via the finit_module syscall, the kernel loads
the module into its address space and executes the initalization
routine provided by the module.

This initialization routine then runs in A's SELinux domain. While that
makes sense implementation-wise and is indeed what I'd expected (going
by my admittely fairly basic understanding of the SELinux internals),
I'm not sure whether this is how the kernel should behave.

For example, this behaviour is currently triggering a bug on my
systems: Since Linux 4.8, most graphics drivers need CAP_SYS_ADMIN
during their module initialization (due to what is probably a kernel
bug). Hence, loading them with udev works fine because my SELinux
policy allows udev to use this capability, but those modules can't be
loaded manually with kmod/modprobe.

I could of course work around that by granting kmod the 'self:capability
sys_admin' permission, but I'm reluctant to do this since kmod itself
does not require CAP_SYS_ADMIN for its operations.

Any thoughts on this matter?


Perhaps the kernel should switch to the init task cred before executing the
module init code.


Regards,
Luis Ressel
_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a114a80403557f10544a7fbba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Dec 27, 2016 6:04 AM, &quot;Luis Ressel&quot; &lt;<a href=3D"mailt=
o:aranea@aixah.de">aranea@aixah.de</a>&gt; wrote:<br type=3D"attribution"><=
blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Hello,<br>
<br>
when a userspace program A (usually kmod or udev) instructs the kernel<br>
to load a kernel module via the finit_module syscall, the kernel loads<br>
the module into its address space and executes the initalization<br>
routine provided by the module.<br>
<br>
This initialization routine then runs in A&#39;s SELinux domain. While that=
<br>
makes sense implementation-wise and is indeed what I&#39;d expected (going<=
br>
by my admittely fairly basic understanding of the SELinux internals),<br>
I&#39;m not sure whether this is how the kernel should behave.<br>
<br>
For example, this behaviour is currently triggering a bug on my<br>
systems: Since Linux 4.8, most graphics drivers need CAP_SYS_ADMIN<br>
during their module initialization (due to what is probably a kernel<br>
bug). Hence, loading them with udev works fine because my SELinux<br>
policy allows udev to use this capability, but those modules can&#39;t be<b=
r>
loaded manually with kmod/modprobe.<br>
<br>
I could of course work around that by granting kmod the &#39;self:capabilit=
y<br>
sys_admin&#39; permission, but I&#39;m reluctant to do this since kmod itse=
lf<br>
does not require CAP_SYS_ADMIN for its operations.<br>
<br>
Any thoughts on this matter?<br></blockquote></div></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Perhaps the kernel should switch to the i=
nit task cred before executing the module init code.=C2=A0</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D=
"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
<br>
Regards,<br>
Luis Ressel<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</blockquote></div><br></div></div></div>

--001a114a80403557f10544a7fbba--
