Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r41CeSFj027026
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2013 08:40:28 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so1289687lab.15
        for <selinux@tycho.nsa.gov>; Wed, 01 May 2013 05:40:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5181072c.4648320a.7ef1.ffff8111@mx.google.com>
References: <5181072c.4648320a.7ef1.ffff8111@mx.google.com>
From: piruthiviraj natarajan <piruthiviraj@gmail.com>
Date: Wed, 1 May 2013 18:10:06 +0530
Message-ID: <CAFVW_7mMfa3j9z=mSbr0SiGhri55WSyr16gtpYcDQoMUScL_ZQ@mail.gmail.com>
Subject: Re: Current Makefile system is inconvenient/limited
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b3441fe1541fb04dba76cd6
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b3441fe1541fb04dba76cd6
Content-Type: text/plain; charset=ISO-8859-1

I think the whole implementation of selinux is unachievable in Debian as
far as I have tested until the Wheezy RCs and Sid too.
You cannot set an enforcing mode in Debian and have a smooth working system
as RHEL clones or Fedora.
On Wed, May 1, 2013 at 5:44 PM, Michael Seyfert <michael@codesand.org>wrote:

> The current system for building selinux requires a lot of workarounds like
> C_INCLUDE_PATH and is also interdependent on setools. I was looking at the
> debian packages and they require two build throughs of selinux just to get
> things to compile properly. Am I the only one that thinks this is a problem?
> --
> Michael Seyfert
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--047d7b3441fe1541fb04dba76cd6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I think the whole implementation of selinux is unachievable in Debian as fa=
r as I have tested until the Wheezy RCs and Sid too.<br>You cannot set an e=
nforcing mode in Debian and have a smooth working system as RHEL clones or =
Fedora.<br>

<div class=3D"gmail_quote">On Wed, May 1, 2013 at 5:44 PM, Michael Seyfert =
<span dir=3D"ltr">&lt;<a href=3D"mailto:michael@codesand.org" target=3D"_bl=
ank">michael@codesand.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">

The current system for building selinux requires a lot of workarounds like =
C_INCLUDE_PATH and is also interdependent on setools. I was looking at the =
debian packages and they require two build throughs of selinux just to get =
things to compile properly. Am I the only one that thinks this is a problem=
?<br>


<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Michael Seyfert<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</font></span></blockquote></div><br>

--047d7b3441fe1541fb04dba76cd6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
