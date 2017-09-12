Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CGEeFV031565
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 12:14:42 -0400
Received: by mail-io0-f174.google.com with SMTP id k101so8148605iod.0
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 09:06:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a2755ee4-2a46-ff99-5653-c5f19a0efa55@ieee.org>
References: <a2755ee4-2a46-ff99-5653-c5f19a0efa55@ieee.org>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Tue, 12 Sep 2017 12:06:42 -0400
Message-ID: <CAB9W1A2Rz65gGks5sh0Yo89zsMzcTsU8Q+4ShyUuiKPxVbqXQQ@mail.gmail.com>
To: Chris PeBenito <pebenito@ieee.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113fee68b781f60559003a91"
Subject: Re: Userspace Python version
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113fee68b781f60559003a91
Content-Type: text/plain; charset="UTF-8"

On Sep 8, 2017 6:49 PM, "Chris PeBenito" <pebenito@ieee.org> wrote:

I believe that all major SELinux distributions have at least Python 3.4
support.  Python 3 changeover has gone so long that even 3.3 is about to go
end-of-life [1].  Can we officially drop Python 2.7 support in userspace
code?

I'd like to drop support for everything older than Python 3.4 in SETools.

[1] http://blog.python.org/2017/09/python-337rc1-is-now-availabl
e-prior-to.html


I would be fine with doing so.

--001a113fee68b781f60559003a91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
">On Sep 8, 2017 6:49 PM, &quot;Chris PeBenito&quot; &lt;<a href=3D"mailto:=
pebenito@ieee.org">pebenito@ieee.org</a>&gt; wrote:<br type=3D"attribution"=
><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">I believe that all major SELinux distributions ha=
ve at least Python 3.4 support.=C2=A0 Python 3 changeover has gone so long =
that even 3.3 is about to go end-of-life [1].=C2=A0 Can we officially drop =
Python 2.7 support in userspace code?<br>
<br>
I&#39;d like to drop support for everything older than Python 3.4 in SETool=
s.<br>
<br>
[1] <a href=3D"http://blog.python.org/2017/09/python-337rc1-is-now-availabl=
e-prior-to.html" rel=3D"noreferrer" target=3D"_blank">http://blog.python.or=
g/2017/09<wbr>/python-337rc1-is-now-availabl<wbr>e-prior-to.html</a></block=
quote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I wou=
ld be fine with doing so.</div><div dir=3D"auto"><div class=3D"gmail_extra"=
><br></div></div></div>

--001a113fee68b781f60559003a91--
