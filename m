Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4ENmwi5021332
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 19:48:58 -0400
Received: by mail-it0-f46.google.com with SMTP id e20-v6so15562349itc.1
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 16:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <991a548d-1cdc-5e15-89d9-a36a557429d2@schaufler-ca.com>
In-Reply-To: <991a548d-1cdc-5e15-89d9-a36a557429d2@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Mon, 14 May 2018 19:48:18 -0400
Message-ID: <CAB9W1A1=mRMn_HuUu-Qsxy8goWMW1C3U5eCOTWV1JSj2+9F2BA@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="00000000000070f5ea056c331f67"
Subject: Re: Anyone using the SELinux test suite on Fedora 28?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--00000000000070f5ea056c331f67
Content-Type: text/plain; charset="UTF-8"

It's been running fine for me. Maybe you just need to clean your tree and
do a fresh make test.

On Mon, May 14, 2018, 7:37 PM Casey Schaufler <casey@schaufler-ca.com>
wrote:

> Has anyone had success with the SELinux test suite on Fedora 28?
> I find the chcon and newrole are unhappy with the contexts used
> in the suite.
>
>
>

--00000000000070f5ea056c331f67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It&#39;s been running fine for me. Maybe you just need to=
 clean your tree and do a fresh make test.=C2=A0</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr">On Mon, May 14, 2018, 7:37 PM Casey Schaufler &l=
t;<a href=3D"mailto:casey@schaufler-ca.com">casey@schaufler-ca.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">Has anyone had success with =
the SELinux test suite on Fedora 28?<br>
I find the chcon and newrole are unhappy with the contexts used<br>
in the suite.<br>
<br>
<br>
</blockquote></div>

--00000000000070f5ea056c331f67--
