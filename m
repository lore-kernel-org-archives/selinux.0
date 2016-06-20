Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5K0HIXT025030
 for <selinux@tycho.nsa.gov>; Sun, 19 Jun 2016 20:17:18 -0400
Received: by mail-it0-f44.google.com with SMTP id z189so34506803itg.0
 for <selinux@tycho.nsa.gov>; Sun, 19 Jun 2016 17:17:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEe7Eb1Mo0FSHkrHZxM1s0z3ckOBfuahhak4HakoDdtGUFd9vQ@mail.gmail.com>
References: <CAEe7Eb1Mo0FSHkrHZxM1s0z3ckOBfuahhak4HakoDdtGUFd9vQ@mail.gmail.com>
Date: Sun, 19 Jun 2016 17:17:15 -0700
Message-ID: <CAFftDdpUoHLOKybBhZXnbB+1-Ldr1khBYPnVsaci3x3L+bUqkw@mail.gmail.com>
Subject: Re: Selectively assigning SELinux policies to permissive and
 enforcement mode
From: William Roberts <bill.c.roberts@gmail.com>
To: Taeho Kgil <taeho.kgil@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113f62d2736a4d0535aaa030
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113f62d2736a4d0535aaa030
Content-Type: text/plain; charset=UTF-8

You could set enforcing mode to on via set enforce, which enables it
globally, and then set various domains in permissive to get a mixed blend
of enforcing and non-enforcing.
On Jun 19, 2016 16:21, "Taeho Kgil" <taeho.kgil@gmail.com> wrote:

> Hi SELinux community,
>
> I'm relatively new to this mailing list and not sure if this is the
> appropriate place to raise this question.
>
> I am trying to see if we can selectively assign policies to permissive and
> enforcement. Is this a possible capability available today?
>
> Thanks
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a113f62d2736a4d0535aaa030
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">You could set enforcing mode to on via set enforce, which en=
ables it globally, and then set various domains in permissive to get a mixe=
d blend of enforcing and non-enforcing.</p>
<div class=3D"gmail_quote">On Jun 19, 2016 16:21, &quot;Taeho Kgil&quot; &l=
t;<a href=3D"mailto:taeho.kgil@gmail.com">taeho.kgil@gmail.com</a>&gt; wrot=
e:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">=
Hi SELinux community,=C2=A0<div><br></div><div>I&#39;m relatively new to th=
is mailing list and not sure if this is the appropriate place to raise this=
 question.=C2=A0</div><div><br></div><div>I
 am trying to see if we can selectively assign policies to permissive=20
and enforcement. Is this a possible capability available today?</div><div><=
br></div><div>Thanks</div></div>
<br>_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br></blo=
ckquote></div>

--001a113f62d2736a4d0535aaa030--
