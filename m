Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7DFLrZ7018647
 for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2018 11:21:53 -0400
Received: by mail-oi0-f48.google.com with SMTP id s198-v6so27863961oih.11
 for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2018 08:21:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180812202522.3743-1-nicolas.iooss@m4x.org>
References: <20180812202522.3743-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 13 Aug 2018 08:21:48 -0700
Message-ID: <CAFftDdp5Xrh4FoJvE3C4Yqd3XC-kKUxK2rV0drETZSkkbNO1rA@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="000000000000f30334057352a6d9"
Subject: Re: [PATCH v2 00/13] Fix some issues found by flake8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000f30334057352a6d9
Content-Type: text/plain; charset="UTF-8"

On Sun, Aug 12, 2018 at 1:25 PM, Nicolas Iooss <nicolas.iooss@m4x.org>
wrote:

> Here is the second revision of this patchset. The changes were:
>
> * I removed the buggy code instead of commenting it, in python/sepolgen.
> * I fixed a typo in the description of a patch.
>
>
Ack on the patchset from me.


>
> Nicolas Iooss (13):
>   libselinux: fix flake8 warnings in SWIG-generated code
>   python/sepolgen: do not import twice the modules
>   python/sepolgen: return NotImplemented instead of raising it
>   python/sepolicy: drop unused CheckPolicyType
>   python/sepolicy: use lowercase variable name
>   python/sepolgen: fix refpolicy parsing of "permissive"
>   python/sepolgen: silence linter warning about has_key
>   python/sepolgen: remove buggy code
>   python/sepolgen: use self when accessing members in FilesystemUse
>   python/sepolicy: fix "procotol" misspelling
>   python/sepolicy: use variables which exist in the gui.py
>   python/sepolicy: do not import sepolicy.generate.DAEMON twice
>   python/sepolicy: do not import types
>
>  libselinux/src/selinuxswig_python.i        |  5 +++--
>  python/sepolgen/src/sepolgen/interfaces.py |  7 +------
>  python/sepolgen/src/sepolgen/refparser.py  |  4 ++--
>  python/sepolgen/src/sepolgen/refpolicy.py  |  6 +++---
>  python/sepolgen/src/sepolgen/util.py       |  6 +-----
>  python/sepolicy/sepolicy.py                | 12 +-----------
>  python/sepolicy/sepolicy/generate.py       |  1 -
>  python/sepolicy/sepolicy/gui.py            | 12 ++++++------
>  8 files changed, 17 insertions(+), 36 deletions(-)
>
> --
> 2.18.0
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--000000000000f30334057352a6d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sun, Aug 12, 2018 at 1:25 PM, Nicolas Iooss <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:nicolas.iooss@m4x.org" target=3D"_blank">nicolas.iooss@m4x.=
org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Here is the sec=
ond revision of this patchset. The changes were:<br>
<br>
* I removed the buggy code instead of commenting it, in python/sepolgen.<br=
>
* I fixed a typo in the description of a patch.<br>
<br></blockquote><div><br></div><div>Ack on the patchset from me.</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<br>
Nicolas Iooss (13):<br>
=C2=A0 libselinux: fix flake8 warnings in SWIG-generated code<br>
=C2=A0 python/sepolgen: do not import twice the modules<br>
=C2=A0 python/sepolgen: return NotImplemented instead of raising it<br>
=C2=A0 python/sepolicy: drop unused CheckPolicyType<br>
=C2=A0 python/sepolicy: use lowercase variable name<br>
=C2=A0 python/sepolgen: fix refpolicy parsing of &quot;permissive&quot;<br>
=C2=A0 python/sepolgen: silence linter warning about has_key<br>
=C2=A0 python/sepolgen: remove buggy code<br>
=C2=A0 python/sepolgen: use self when accessing members in FilesystemUse<br=
>
=C2=A0 python/sepolicy: fix &quot;procotol&quot; misspelling<br>
=C2=A0 python/sepolicy: use variables which exist in the gui.py<br>
=C2=A0 python/sepolicy: do not import sepolicy.generate.DAEMON twice<br>
=C2=A0 python/sepolicy: do not import types<br>
<br>
=C2=A0libselinux/src/selinuxswig_<wbr>python.i=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 5 +++--<br>
=C2=A0python/sepolgen/src/sepolgen/<wbr>interfaces.py |=C2=A0 7 +------<br>
=C2=A0python/sepolgen/src/sepolgen/<wbr>refparser.py=C2=A0 |=C2=A0 4 ++--<b=
r>
=C2=A0python/sepolgen/src/sepolgen/<wbr>refpolicy.py=C2=A0 |=C2=A0 6 +++---=
<br>
=C2=A0python/sepolgen/src/sepolgen/<wbr>util.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 6 +-----<br>
=C2=A0python/sepolicy/sepolicy.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 12 +-----------<br>
=C2=A0python/sepolicy/sepolicy/<wbr>generate.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 -<br>
=C2=A0python/sepolicy/sepolicy/gui.<wbr>py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 12 ++++++------<br>
=C2=A08 files changed, 17 insertions(+), 36 deletions(-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-- <br>
2.18.0<br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</font></span></blockquote></div><br></div></div>

--000000000000f30334057352a6d9--
