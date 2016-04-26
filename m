Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3QM3v8J016196
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 18:03:57 -0400
Received: from mail-lf0-f54.google.com (mail-lf0-f54.google.com
 [209.85.215.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 091AA56489B
 for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2016 00:03:46 +0200 (CEST)
Received: by mail-lf0-f54.google.com with SMTP id j11so35115027lfb.1
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 15:03:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461391499-20593-1-git-send-email-jason@perfinion.com>
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-1-git-send-email-jason@perfinion.com>
Date: Wed, 27 Apr 2016 00:03:45 +0200
Message-ID: <CAJfZ7=ktBsGVOqm8y6MQnwa-tiXrjrB_vB1cLFNuMg9a2Z9pfQ@mail.gmail.com>
Subject: Re: genhomedircon USERID and USERNAME patches v2
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: Jason Zaman <jason@perfinion.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114b15928ce39b05316a7723
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114b15928ce39b05316a7723
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 23, 2016 at 8:04 AM, Jason Zaman <jason@perfinion.com> wrote:

> Version 2 of the genhomedircon patches. These fix a few issues
> that Nicolas Iooss found.
>
> Changes from v1:
>
> - Changed the fallback for the username to "[^/]+" instead of
>     "[^/]*" or ".*"
> - Made args const in write_replacements()
> - Combined the %{USERNAME} and %{USERID} replacements into one
>     method so they both get called together. This means that
>     fcontexts like "%{USERNAME}-%{USERID}" become eg "root-0"
>     as expected.
> - I left the gid param in the struct for now. genhomedircon
>     does not generate things for eg "%wheel" which I will look
>     into later.
>

Hello,
I have read these patches and tested them on my system. They seem to work
fine: I added some corner-case file context patterns to my policy (mixing
USER, %{USERNAME}, %{USERID}, ROLE and system_u) and checked the content of
/etc/selinux/.../contexts/files/file_contexts.homedirs, the result of
"matchpathcon" (on existing and non-existing paths) and the behavior of
systemd-logind (which labels correctly the files). This set of patches
looks good to me.

Thanks,
Nicolas

--001a114b15928ce39b05316a7723
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On S=
at, Apr 23, 2016 at 8:04 AM, Jason Zaman <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:jason@perfinion.com" target=3D"_blank">jason@perfinion.com</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb=
(204,204,204);padding-left:1ex">Version 2 of the genhomedircon patches. The=
se fix a few issues<br>
that Nicolas Iooss found.<br>
<br>
Changes from v1:<br>
<br>
- Changed the fallback for the username to &quot;[^/]+&quot; instead of<br>
=C2=A0 =C2=A0 &quot;[^/]*&quot; or &quot;.*&quot;<br>
- Made args const in write_replacements()<br>
- Combined the %{USERNAME} and %{USERID} replacements into one<br>
=C2=A0 =C2=A0 method so they both get called together. This means that<br>
=C2=A0 =C2=A0 fcontexts like &quot;%{USERNAME}-%{USERID}&quot; become eg &q=
uot;root-0&quot;<br>
=C2=A0 =C2=A0 as expected.<br>
- I left the gid param in the struct for now. genhomedircon<br>
=C2=A0 =C2=A0 does not generate things for eg &quot;%wheel&quot; which I wi=
ll look<br>
=C2=A0 =C2=A0 into later.<br></blockquote><div><br></div><div>Hello,</div><=
div>I have read these patches and tested them on my system. They seem to wo=
rk fine: I added some corner-case file context patterns to my policy (mixin=
g USER, %{USERNAME}, %{USERID}, ROLE and system_u) and checked the content =
of /etc/selinux/.../contexts/files/file_contexts.homedirs, the result of &q=
uot;matchpathcon&quot; (on existing and non-existing paths) and the behavio=
r of systemd-logind (which labels correctly the files). This set of patches=
 looks good to me.</div><div><br></div><div>Thanks,</div><div>Nicolas</div>=
</div><br></div></div>

--001a114b15928ce39b05316a7723--
