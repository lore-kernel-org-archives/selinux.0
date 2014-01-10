Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0A9XMOF021894
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 04:33:22 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so4196657pbc.26
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 01:33:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <441837E5-55B1-463C-A8E2-7F48F2C847E0@me.com>
References: <441837E5-55B1-463C-A8E2-7F48F2C847E0@me.com>
Date: Fri, 10 Jan 2014 13:33:20 +0400
Message-ID: <CABu+-8pi=O=FWO=t-rGo-_9rSjmYagdFvJcjXyWvFKyd6m_NLQ@mail.gmail.com>
Subject: Re: new to selinux
From: Ilya Frolov <ilya.a.frolov@gmail.com>
To: Bryan Harris <bryanlharris@me.com>
Content-Type: multipart/alternative; boundary=e89a8ff1c462aa14b504ef9a6a7c
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--e89a8ff1c462aa14b504ef9a6a7c
Content-Type: text/plain; charset=UTF-8

On Fri, Jan 10, 2014 at 1:16 PM, Bryan Harris <bryanlharris@me.com> wrote:

> Hello,
>
> I'm wondering if it is possible to use selinux network & process labeling,
> iptables, and something like /usr/bin/script to create an environment where
> we can enforce session recording for ssh sessions.
>
> We will soon have a requirement to record our actions on customer
> environments, but at the same time we also need to block users who have not
> activated the recording.  Is selinux policy an appropriate way to
> accomplish these requirements?  I'd like to search for the details and
> learn more, but if I'm taking the wrong approach I'd like to know that
> before starting out.
>
> Any guidance is greatly appreciated.  Thanks in advance.
>
> V/r,
> Bryan
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

Hello Bryan,

have a look at ttyrec -- you can set it as shell to do ssh session
recording per-user and without fiddling in kernel space, and you can
enforce it that way even without selinux for non-root users.

If you are interested in restricting root user and maybe play with the live
system -- feel free to contact me offlist, i've done the similar things for
my selinux playbox, and (i'll check now) i think its still alive.


regards,
ilya

--e89a8ff1c462aa14b504ef9a6a7c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, Jan 10, 2014 at 1:16 PM, Bryan Harris <span dir=3D"ltr">&lt;<a href=3D"=
mailto:bryanlharris@me.com" target=3D"_blank">bryanlharris@me.com</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Hello,<br>
<br>
I&#39;m wondering if it is possible to use selinux network &amp; process la=
beling, iptables, and something like /usr/bin/script to create an environme=
nt where we can enforce session recording for ssh sessions.<br>
<br>
We will soon have a requirement to record our actions on customer environme=
nts, but at the same time we also need to block users who have not activate=
d the recording. =C2=A0Is selinux policy an appropriate way to accomplish t=
hese requirements? =C2=A0I&#39;d like to search for the details and learn m=
ore, but if I&#39;m taking the wrong approach I&#39;d like to know that bef=
ore starting out.<br>

<br>
Any guidance is greatly appreciated. =C2=A0Thanks in advance.<br>
<br>
V/r,<br>
Bryan<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</blockquote></div><br></div><div class=3D"gmail_extra">Hello Bryan,<div><b=
r></div><div>have a look at ttyrec -- you can set it as shell to do ssh ses=
sion recording per-user and without fiddling in kernel space, and you can e=
nforce it that way even without selinux for non-root users.</div>
<div><br></div><div>If you are interested in restricting root user and mayb=
e play with the live system -- feel free to contact me offlist, i&#39;ve do=
ne the similar things for my selinux playbox, and (i&#39;ll check now) i th=
ink its still alive.</div>
<div><br></div><div><br></div><div>regards,</div><div>ilya</div><div class=
=3D"gmail_extra"><br></div></div></div>

--e89a8ff1c462aa14b504ef9a6a7c--
