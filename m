Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s495Xhdo001382
 for <selinux@tycho.nsa.gov>; Fri, 9 May 2014 01:33:43 -0400
Received: by mail-ig0-f172.google.com with SMTP id uy17so725287igb.5
 for <selinux@tycho.nsa.gov>; Thu, 08 May 2014 22:33:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1675546.P9Rft7smSN@sifl>
References: <CAHw9pMX-T9CHgahLLKjAfA_tOeFuKSwniikV_-ejw3GsCOQW0Q@mail.gmail.com>
 <1675546.P9Rft7smSN@sifl>
Date: Fri, 9 May 2014 09:33:43 +0400
Message-ID: <CAHw9pMWohg9D6PKkeeuTwT_u6HoRi71y2kTirsOf+1wuDOW0XA@mail.gmail.com>
Subject: Re: selinux and static label for sVirt
From: vlad halilov <vlad.halilov@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=047d7b10cedddbcb6704f8f0f01b
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b10cedddbcb6704f8f0f01b
Content-Type: text/plain; charset=UTF-8

Yeah, that's my wrong. Now everything all right with full label context
'system_u:system_r:svirt_t:s1'. Thanks everyone.


On Fri, May 9, 2014 at 12:34 AM, Paul Moore <paul@paul-moore.com> wrote:

>
> If you are going to use static labels with sVirt you need to specify the
> entire SELinux label and not just the MLS field.  I recommend searching for
> the "Red Hat Enterprise Linux 6 Virtualization Security Guide" for more
> information on using sVirt with RHEL6.
>
>

--047d7b10cedddbcb6704f8f0f01b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yeah, that&#39;s my wrong. Now everything all right with f=
ull label context &#39;system_u:system_r:svirt_t:s1&#39;. Thanks everyone.<=
br><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Ma=
y 9, 2014 at 12:34 AM, Paul Moore <span dir=3D"ltr">&lt;<a href=3D"mailto:p=
aul@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>&gt;</span> wr=
ote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D""><br>
</div>If you are going to use static labels with sVirt you need to specify =
the<br>
entire SELinux label and not just the MLS field. =C2=A0I recommend searchin=
g for<br>
the &quot;Red Hat Enterprise Linux 6 Virtualization Security Guide&quot; fo=
r more<br>
information on using sVirt with RHEL6.<br>
<span class=3D"HOEnZb"></span><br></blockquote></div></div></div>

--047d7b10cedddbcb6704f8f0f01b--
