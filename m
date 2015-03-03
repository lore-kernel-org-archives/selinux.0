Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t23F3vbL013173
 for <selinux@tycho.nsa.gov>; Tue, 3 Mar 2015 10:03:57 -0500
Received: by obcva2 with SMTP id va2so122577obc.6
 for <selinux@tycho.nsa.gov>; Tue, 03 Mar 2015 07:03:55 -0800 (PST)
MIME-Version: 1.0
Sender: ecank1@gmail.com
In-Reply-To: <54EE138A.8010009@tycho.nsa.gov>
References: <CA+2y117Qsyy1EVqioo6e1r44mOBK5GiEDRAQczngkhQpRgmD9Q@mail.gmail.com>
 <54EE138A.8010009@tycho.nsa.gov>
Date: Tue, 3 Mar 2015 17:03:54 +0200
Message-ID: <CA+2y1172GwSBiqY8KZrSY6FV7g5xsSGp726MN_xikgJCSNnXsw@mail.gmail.com>
Subject: Re: Cross-compile for arm architecture
From: Emre Can Kucukoglu <eckucukoglu@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113ce962ba8b16051063a4aa
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113ce962ba8b16051063a4aa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Now, I'm working with Fedora 21. However another error exists now:

Toolchain: gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux

export
PATH=3D$PATH:/home/ecank/1511/toolchain/gcc-linaro-arm-linux-gnueabihf-4.9-=
2014.09_linux/bin
export CC=3Darm-linux-gnueabihf-gcc
export CROSS_COMPILE=3Darm-linux-gnueabihf-
export CFLAGS=3D-D__thread=3D
export EMBEDDED=3Dy
export DESTDIR=3D~/obj
make install install-pywrap

arm-linux-gnueabihf-gcc: error: unrecognized command line option
=E2=80=98-mno-tls-direct-seg-refs=E2=80=99
Makefile:130: recipe for target 'is_customizable_type.o' failed
make[2]: *** [is_customizable_type.o] Error 1
make[2]: Leaving directory '/home/ecank/1511/selinux/libselinux/src'
Makefile:28: recipe for target 'install' failed

all output: http://pastebin.com/U03hhtJJ

moreover:
$ arm-linux-gnueabihf-gcc --version
arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro
GCC 4.9-2014.09) 4.9.2 20140904 (prerelease)
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Then after deletion of
TLSFLAGS +=3D -mno-tls-direct-seg-refs
(i deleted that flag, since it was related with x86-64 and i386)
(https://gcc.gnu.org/onlinedocs/gcc-4.9.2/gcc/i386-and-x86-64-Options.html)

New error is related with pcre library.

arm-linux-gnueabihf-gcc -D__thread=3D -I../include
-I/home/ecank/obj/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
-DDISABLE_AVC -DDISABLE_BOOL -DDISABLE_RPM -DDISABLE_SETRANS  -c -o
label_file.o label_file.c
label_file.c:21:18: fatal error: pcre.h: No such file or directory
 #include <pcre.h>
                  ^
compilation terminated.
Makefile:130: recipe for target 'label_file.o' failed

all output: http://pastebin.com/9rxKFvLL

Really need help about compiling SELinux for an arm.

Thanks in advance.


2015-02-25 20:25 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:

> On 02/25/2015 10:42 AM, Emre Can Kucukoglu wrote:
> > Hello,
> >
> > I want to use SELinux for my experimental vanilla kernel distribution i=
n
> > Pandaboard ES. To achieve that I have configured my kernel for SELinux
> > support. Then, I have recently cloned selinux userspace repository to
> > cross-compile it for arm architecture. I use arm-linux-gnueabi toolchai=
n
> > in Ubuntu 14.04 workstation.
> >
> > $ export ARCH=3Darm
> > $ export CROSS_COMPILE=3Darm-linux-gnueabi-
> >
> > As mentioned in readme instruction,
> >
> > $ make DESTDIR=3D~/obj install install-pywrap
> >
> > command is used, however due to -Werror flags in various Makefile's,
> > error is thrown:
> >
> > dispol.c: In function =E2=80=98main=E2=80=99:
> > dispol.c:452:8: error: ignoring return value of =E2=80=98fgets=E2=80=99=
, declared with
> > attribute warn_unused_result [-Werror=3Dunused-result]
> >    fgets(ans, sizeof(ans), stdin);
> >         ^
> > dispol.c:479:9: error: ignoring return value of =E2=80=98fgets=E2=80=99=
, declared with
> > attribute warn_unused_result [-Werror=3Dunused-result]
> >     fgets(ans, sizeof(ans), stdin);
> >          ^
> > dispol.c:490:9: error: ignoring return value of =E2=80=98fgets=E2=80=99=
, declared with
> > attribute warn_unused_result [-Werror=3Dunused-result]
> >     fgets(ans, sizeof(ans), stdin);
> >          ^
> > dispol.c:517:9: error: ignoring return value of =E2=80=98fgets=E2=80=99=
, declared with
> > attribute warn_unused_result [-Werror=3Dunused-result]
> >     fgets(OutfileName, sizeof(OutfileName), stdin);
> >          ^
> > cc1: all warnings being treated as errors
> > make[2]: *** [dispol.o] Error 1
> >
> > I did this modification to get over this error which is caused by
> > -Werror flag:
> >
> > char *fgetsret; /* error is given, because return value is not captured
> */
> > fgetsret =3D fgets(...);
> > if (!fgetsret) { /* if fgetsret is not used, another error comes from
> > warning */
> > // some exit message
> > exit(1);
> > }
> >
> > Did I miss something about SELinux cross-compilation for an arm
> > architecture, since constantly I'm taking errors.
>
> Hmm...that's interesting.  Builds just fine on Fedora 20.  I do however
> get the same error building on Ubuntu 14.04 (which is not something we
> typically test on; most SELinux developers work on Fedora).
>
> Willing to accept patches to fix it, but it is merely a test/debugging
> program that you can even exclude from your build if you like.
>
>


--=20
Emre Can Kucukoglu

--001a113ce962ba8b16051063a4aa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Now, I&#39;m working with Fedora 21. However another error=
 exists now:<div><br></div><div>Toolchain:=C2=A0gcc-linaro-arm-linux-gnueab=
ihf-4.9-2014.09_linux</div><div><br></div><div><div>export PATH=3D$PATH:/ho=
me/ecank/1511/toolchain/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bi=
n</div><div>export CC=3Darm-linux-gnueabihf-gcc</div><div>export CROSS_COMP=
ILE=3Darm-linux-gnueabihf-</div><div>export CFLAGS=3D-D__thread=3D=C2=A0</d=
iv><div>export EMBEDDED=3Dy</div><div>export DESTDIR=3D~/obj</div><div>make=
 install=C2=A0install-pywrap</div></div><div><br></div><div>arm-linux-gnuea=
bihf-gcc: error: unrecognized command line option =E2=80=98-mno-tls-direct-=
seg-refs=E2=80=99</div><div>Makefile:130: recipe for target &#39;is_customi=
zable_type.o&#39; failed</div><div>make[2]: *** [is_customizable_type.o] Er=
ror 1</div><div>make[2]: Leaving directory &#39;/home/ecank/1511/selinux/li=
bselinux/src&#39;</div><div>Makefile:28: recipe for target &#39;install&#39=
; failed</div><div><br></div><div>all output:=C2=A0<a href=3D"http://pasteb=
in.com/U03hhtJJ">http://pastebin.com/U03hhtJJ</a></div><div><br></div><div>=
moreover:</div><div><div>$ arm-linux-gnueabihf-gcc --version</div><div>arm-=
linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.=
9-2014.09) 4.9.2 20140904 (prerelease)</div><div>Copyright (C) 2014 Free So=
ftware Foundation, Inc.</div><div>This is free software; see the source for=
 copying conditions.=C2=A0 There is NO</div><div>warranty; not even for MER=
CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.</div></div><div><br></div=
><div>Then after deletion of</div><div>TLSFLAGS +=3D=C2=A0-mno-tls-direct-s=
eg-refs<br></div><div>(i deleted that flag, since it was related with x86-6=
4 and i386)=C2=A0<br></div><div>(<a href=3D"https://gcc.gnu.org/onlinedocs/=
gcc-4.9.2/gcc/i386-and-x86-64-Options.html">https://gcc.gnu.org/onlinedocs/=
gcc-4.9.2/gcc/i386-and-x86-64-Options.html</a>)<br></div><div><br></div><di=
v>New error is related with pcre library.</div><div><br></div><div><div>arm=
-linux-gnueabihf-gcc -D__thread=3D -I../include -I/home/ecank/obj/usr/inclu=
de -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -DDISABLE_AVC -DDISABLE_BOOL -DDI=
SABLE_RPM -DDISABLE_SETRANS =C2=A0-c -o label_file.o label_file.c</div><div=
>label_file.c:21:18: fatal error: pcre.h: No such file or directory</div><d=
iv>=C2=A0#include &lt;pcre.h&gt;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^</div><div>compilation terminated.</div><d=
iv>Makefile:130: recipe for target &#39;label_file.o&#39; failed</div></div=
><div><br></div><div>all output:=C2=A0<a href=3D"http://pastebin.com/9rxKFv=
LL">http://pastebin.com/9rxKFvLL</a></div><div><br></div><div>Really need h=
elp about compiling SELinux for an arm.</div><div><br></div><div>Thanks in =
advance.</div><div><br><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">2015-02-25 20:25 GMT+02:00 Stephen Smalley <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt=
;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-=
style:solid;padding-left:1ex"><div><div>On 02/25/2015 10:42 AM, Emre Can Ku=
cukoglu wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I want to use SELinux for my experimental vanilla kernel distribution =
in<br>
&gt; Pandaboard ES. To achieve that I have configured my kernel for SELinux=
<br>
&gt; support. Then, I have recently cloned selinux userspace repository to<=
br>
&gt; cross-compile it for arm architecture. I use arm-linux-gnueabi toolcha=
in<br>
&gt; in Ubuntu 14.04 workstation.<br>
&gt;<br>
&gt; $ export ARCH=3Darm<br>
&gt; $ export CROSS_COMPILE=3Darm-linux-gnueabi-<br>
&gt;<br>
&gt; As mentioned in readme instruction,<br>
&gt;<br>
&gt; $ make DESTDIR=3D~/obj install install-pywrap<br>
&gt;<br>
&gt; command is used, however due to -Werror flags in various Makefile&#39;=
s,<br>
&gt; error is thrown:<br>
&gt;<br>
&gt; dispol.c: In function =E2=80=98main=E2=80=99:<br>
&gt; dispol.c:452:8: error: ignoring return value of =E2=80=98fgets=E2=80=
=99, declared with<br>
&gt; attribute warn_unused_result [-Werror=3Dunused-result]<br>
&gt;=C2=A0 =C2=A0 fgets(ans, sizeof(ans), stdin);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; dispol.c:479:9: error: ignoring return value of =E2=80=98fgets=E2=80=
=99, declared with<br>
&gt; attribute warn_unused_result [-Werror=3Dunused-result]<br>
&gt;=C2=A0 =C2=A0 =C2=A0fgets(ans, sizeof(ans), stdin);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
&gt; dispol.c:490:9: error: ignoring return value of =E2=80=98fgets=E2=80=
=99, declared with<br>
&gt; attribute warn_unused_result [-Werror=3Dunused-result]<br>
&gt;=C2=A0 =C2=A0 =C2=A0fgets(ans, sizeof(ans), stdin);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
&gt; dispol.c:517:9: error: ignoring return value of =E2=80=98fgets=E2=80=
=99, declared with<br>
&gt; attribute warn_unused_result [-Werror=3Dunused-result]<br>
&gt;=C2=A0 =C2=A0 =C2=A0fgets(OutfileName, sizeof(OutfileName), stdin);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
&gt; cc1: all warnings being treated as errors<br>
&gt; make[2]: *** [dispol.o] Error 1<br>
&gt;<br>
&gt; I did this modification to get over this error which is caused by<br>
&gt; -Werror flag:<br>
&gt;<br>
&gt; char *fgetsret; /* error is given, because return value is not capture=
d */<br>
&gt; fgetsret =3D fgets(...);<br>
&gt; if (!fgetsret) { /* if fgetsret is not used, another error comes from<=
br>
&gt; warning */<br>
&gt; // some exit message<br>
&gt; exit(1);<br>
&gt; }<br>
&gt;<br>
&gt; Did I miss something about SELinux cross-compilation for an arm<br>
&gt; architecture, since constantly I&#39;m taking errors.<br>
<br>
</div></div>Hmm...that&#39;s interesting.=C2=A0 Builds just fine on Fedora =
20.=C2=A0 I do however<br>
get the same error building on Ubuntu 14.04 (which is not something we<br>
typically test on; most SELinux developers work on Fedora).<br>
<br>
Willing to accept patches to fix it, but it is merely a test/debugging<br>
program that you can even exclude from your build if you like.<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>Emre Ca=
n Kucukoglu</div>
</div></div></div>

--001a113ce962ba8b16051063a4aa--
