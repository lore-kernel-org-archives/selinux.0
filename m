Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1PFgRd9009070
 for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2015 10:42:27 -0500
Received: by mail-ob0-f174.google.com with SMTP id wo20so4543623obc.5
 for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2015 07:42:23 -0800 (PST)
MIME-Version: 1.0
Sender: ecank1@gmail.com
Date: Wed, 25 Feb 2015 17:42:23 +0200
Message-ID: <CA+2y117Qsyy1EVqioo6e1r44mOBK5GiEDRAQczngkhQpRgmD9Q@mail.gmail.com>
Subject: Cross-compile for arm architecture
From: Emre Can Kucukoglu <eckucukoglu@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113ce96240c6b1050feb7b3c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113ce96240c6b1050feb7b3c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I want to use SELinux for my experimental vanilla kernel distribution in
Pandaboard ES. To achieve that I have configured my kernel for SELinux
support. Then, I have recently cloned selinux userspace repository to
cross-compile it for arm architecture. I use arm-linux-gnueabi toolchain in
Ubuntu 14.04 workstation.

$ export ARCH=3Darm
$ export CROSS_COMPILE=3Darm-linux-gnueabi-

As mentioned in readme instruction,

$ make DESTDIR=3D~/obj install install-pywrap

command is used, however due to -Werror flags in various Makefile's, error
is thrown:

dispol.c: In function =E2=80=98main=E2=80=99:
dispol.c:452:8: error: ignoring return value of =E2=80=98fgets=E2=80=99, de=
clared with
attribute warn_unused_result [-Werror=3Dunused-result]
   fgets(ans, sizeof(ans), stdin);
        ^
dispol.c:479:9: error: ignoring return value of =E2=80=98fgets=E2=80=99, de=
clared with
attribute warn_unused_result [-Werror=3Dunused-result]
    fgets(ans, sizeof(ans), stdin);
         ^
dispol.c:490:9: error: ignoring return value of =E2=80=98fgets=E2=80=99, de=
clared with
attribute warn_unused_result [-Werror=3Dunused-result]
    fgets(ans, sizeof(ans), stdin);
         ^
dispol.c:517:9: error: ignoring return value of =E2=80=98fgets=E2=80=99, de=
clared with
attribute warn_unused_result [-Werror=3Dunused-result]
    fgets(OutfileName, sizeof(OutfileName), stdin);
         ^
cc1: all warnings being treated as errors
make[2]: *** [dispol.o] Error 1

I did this modification to get over this error which is caused by -Werror
flag:

char *fgetsret; /* error is given, because return value is not captured */
fgetsret =3D fgets(...);
if (!fgetsret) { /* if fgetsret is not used, another error comes from
warning */
// some exit message
exit(1);
}

Did I miss something about SELinux cross-compilation for an arm
architecture, since constantly I'm taking errors.
--=20
Emre Can Kucukoglu

--001a113ce96240c6b1050feb7b3c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I want to use SELinux for my exp=
erimental vanilla kernel distribution in Pandaboard ES. To achieve that I h=
ave configured my kernel for SELinux support. Then, I have recently cloned =
selinux userspace repository to cross-compile it for arm architecture. I us=
e arm-linux-gnueabi toolchain in Ubuntu 14.04 workstation.=C2=A0<div><br></=
div><div><div>$ export ARCH=3Darm</div><div>$ export CROSS_COMPILE=3Darm-li=
nux-gnueabi-</div></div><div><br></div><div>As mentioned in readme instruct=
ion,=C2=A0</div><div><br></div><div>$ make DESTDIR=3D~/obj install install-=
pywrap</div><div><br></div><div>command is used, however due to -Werror fla=
gs in various Makefile&#39;s, error is thrown:=C2=A0</div><div><br></div><d=
iv><div>dispol.c: In function =E2=80=98main=E2=80=99:<br></div><div>dispol.=
c:452:8: error: ignoring return value of =E2=80=98fgets=E2=80=99, declared =
with attribute warn_unused_result [-Werror=3Dunused-result]</div><div>=C2=
=A0 =C2=A0fgets(ans, sizeof(ans), stdin);</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^</div><div>dispol.c:479:9: error: ignoring return value of =E2=80=
=98fgets=E2=80=99, declared with attribute warn_unused_result [-Werror=3Dun=
used-result]</div><div>=C2=A0 =C2=A0 fgets(ans, sizeof(ans), stdin);</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^</div><div>dispol.c:490:9: error: ig=
noring return value of =E2=80=98fgets=E2=80=99, declared with attribute war=
n_unused_result [-Werror=3Dunused-result]</div><div>=C2=A0 =C2=A0 fgets(ans=
, sizeof(ans), stdin);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^</div><=
div>dispol.c:517:9: error: ignoring return value of =E2=80=98fgets=E2=80=99=
, declared with attribute warn_unused_result [-Werror=3Dunused-result]</div=
><div>=C2=A0 =C2=A0 fgets(OutfileName, sizeof(OutfileName), stdin);</div><d=
iv>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^</div><div>cc1: all warnings being tr=
eated as errors</div><div>make[2]: *** [dispol.o] Error 1</div><div><br></d=
iv></div><div>I did this modification to get over this error which is cause=
d by -Werror flag:<br></div><div><br></div><div>char *fgetsret; /* error is=
 given, because return value is not captured */</div><div>fgetsret =3D fget=
s(...);</div><div><div>if (!fgetsret) { /* if fgetsret is not used, another=
 error comes from warning */</div><div><span style=3D"white-space:pre">// s=
ome exit message</span></div><div>exit(1);</div><div>}</div></div><div><div=
><br></div><div>Did I miss something about SELinux cross-compilation for an=
 arm architecture, since constantly I&#39;m taking errors.</div>-- <br><div=
 class=3D"gmail_signature">Emre Can Kucukoglu</div>
</div></div></div>

--001a113ce96240c6b1050feb7b3c--
