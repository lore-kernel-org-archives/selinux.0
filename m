Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7THkvOG014395
 for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2014 13:46:57 -0400
Received: by mail-ig0-f182.google.com with SMTP id a13so2974535igq.3
 for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2014 10:46:59 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 29 Aug 2014 12:46:59 -0500
Message-ID: <CAGReGbQqZ1UE6+QRHx+hSN8nACZXv+vCHtWj5hFkbeqd+pYwCw@mail.gmail.com>
Subject: Trouble building a selinux toolchain
From: Judd Meinders <judd.meinders@rockwellcollins.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e013c67c4723b640501c83d37
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e013c67c4723b640501c83d37
Content-Type: text/plain; charset=UTF-8

Hello list!

I am attempting to build a selinux toolchain for development of policy for
an embedded device.  I am required by our development lead to use centos6.5
as my host for policy compilation and testing.

CentOS6.5, by default, has a checkpolicy, and setools supporting up to
policy.24, however, the refpolicy I would like to start with includes
features that are not supported in 24.  So, I am trying to build a
toolchain to compile/develop/test a policy.29.

The features I need for development and testing are:
checkpolicy/checkmodule, audit2allow, and apol/qpol libraries, sediff, and
secmds from the setools project.

I don't seem to have any trouble getting libsepol, libselinux, sepolgen,
libsemanage, and checkpolicy to install to /opt/setoolchain.  And I can
compile a policy.29 at this point.  But I am now trying to get setools to
even compile using the headers and libraries in my /opt/toolchain, without
any luck.

here is some version info:
checkpolicy-2.3
libselinux-2.3
libsemanage-2.3
libsepol-2.3
sepolgen-1.2.1
setools-3.3.8
gcc-4.7.4
Python-2.7.7

When trying to configure setools, with this command:
$ ./configure --prefix=/opt/setoolchain --disable-bwidget-check
--with-selinux-devel=/opt/setoolchain/usr
--with-sepol-devel=/opt/setoolchain/usr

I wind up with this error:
checking for running SELinux system... yes
checking for sepol/sepol.h... checking sepol/sepol.h usability... yes
checking sepol/sepol.h presence... yes
checking for sepol/sepol.h... yes
checking for sepol_policydb_read in -lsepol... yes
checking selinux/selinux.h usability... yes
checking selinux/selinux.h presence... yes
checking for selinux/selinux.h... yes
checking selinux/context.h usability... yes
checking selinux/context.h presence... yes
checking for selinux/context.h... yes
checking for selinux_policy_root in -lselinux... no
configure: error: could not find libselinux at /opt/setoolchain/usr/lib

However, when I list the contents everything seems to be in order:
$ ls -la /opt/setoolchain/usr/lib
total 1712
drwxr-xr-x. 3 root root   4096 Aug 29 12:10 .
drwxr-xr-x. 8 root root   4096 Aug 29 11:25 ..
-rw-r--r--. 1 root root 323516 Aug 29 11:23 libselinux.a
lrwxrwxrwx. 1 root root     25 Aug 29 11:23 libselinux.so ->
../../lib/libselinux.so.1
-rw-r--r--. 1 root root 478528 Aug 29 11:29 libsemanage.a
lrwxrwxrwx. 1 root root     16 Aug 29 11:29 libsemanage.so ->
libsemanage.so.1
-rwxr-xr-x. 1 root root 317053 Aug 29 11:29 libsemanage.so.1
-rw-r--r--. 1 root root 617652 Aug 29 11:19 libsepol.a
lrwxrwxrwx. 1 root root     23 Aug 29 11:19 libsepol.so ->
../../lib/libsepol.so.1
drwxr-xr-x. 2 root root   4096 Aug 29 11:29 pkgconfig

Sorry for the long email.  Any suggestions would be appreciated.

Thanks,
Judd Meinders

--089e013c67c4723b640501c83d37
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello list!<div><br></div><div>I am attempting to build a =
selinux toolchain for development of policy for an embedded device. =C2=A0I=
 am required by our development lead to use centos6.5 as my host for policy=
 compilation and testing.</div>
<div><br></div><div>CentOS6.5, by default, has a checkpolicy, and setools s=
upporting up to policy.24, however, the refpolicy I would like to start wit=
h includes features that are not supported in 24. =C2=A0So, I am trying to =
build a toolchain to compile/develop/test a policy.29.</div>
<div><br></div><div>The features I need for development and testing are: ch=
eckpolicy/checkmodule, audit2allow, and apol/qpol libraries, sediff, and se=
cmds from the setools project.</div><div><br></div><div>I don&#39;t seem to=
 have any trouble getting libsepol, libselinux, sepolgen, libsemanage, and =
checkpolicy to install to /opt/setoolchain. =C2=A0And I can compile a polic=
y.29 at this point. =C2=A0But I am now trying to get setools to even compil=
e using the headers and libraries in my /opt/toolchain, without any luck.</=
div>
<div><div><br></div><div>here is some version info:</div><div>checkpolicy-2=
.3<br></div><div>libselinux-2.3<br></div><div>libsemanage-2.3<br></div><div=
>libsepol-2.3<br></div><div>sepolgen-1.2.1<br></div><div>setools-3.3.8<br>
</div><div>gcc-4.7.4<br></div><div>Python-2.7.7<br></div><div><br></div><di=
v>When trying to configure setools, with this command:</div><div>$ ./config=
ure --prefix=3D/opt/setoolchain --disable-bwidget-check --with-selinux-deve=
l=3D/opt/setoolchain/usr --with-sepol-devel=3D/opt/setoolchain/usr<br>
</div><div><br></div><div>I wind up with this error:</div><div><div>checkin=
g for running SELinux system... yes</div><div>checking for sepol/sepol.h...=
 checking sepol/sepol.h usability... yes</div><div>checking sepol/sepol.h p=
resence... yes</div>
<div>checking for sepol/sepol.h... yes</div><div>checking for sepol_policyd=
b_read in -lsepol... yes</div><div>checking selinux/selinux.h usability... =
yes</div><div>checking selinux/selinux.h presence... yes</div><div>checking=
 for selinux/selinux.h... yes</div>
<div>checking selinux/context.h usability... yes</div><div>checking selinux=
/context.h presence... yes</div><div>checking for selinux/context.h... yes<=
/div><div>checking for selinux_policy_root in -lselinux... no</div><div>
configure: error: could not find libselinux at /opt/setoolchain/usr/lib</di=
v></div><div><br></div><div>However, when I list the contents everything se=
ems to be in order:</div><div><div>$ ls -la /opt/setoolchain/usr/lib</div>
<div>total 1712</div><div>drwxr-xr-x. 3 root root =C2=A0 4096 Aug 29 12:10 =
.</div><div>drwxr-xr-x. 8 root root =C2=A0 4096 Aug 29 11:25 ..</div><div>-=
rw-r--r--. 1 root root 323516 Aug 29 11:23 libselinux.a</div><div>lrwxrwxrw=
x. 1 root root =C2=A0 =C2=A0 25 Aug 29 11:23 libselinux.so -&gt; ../../lib/=
libselinux.so.1</div>
<div>-rw-r--r--. 1 root root 478528 Aug 29 11:29 libsemanage.a</div><div>lr=
wxrwxrwx. 1 root root =C2=A0 =C2=A0 16 Aug 29 11:29 libsemanage.so -&gt; li=
bsemanage.so.1</div><div>-rwxr-xr-x. 1 root root 317053 Aug 29 11:29 libsem=
anage.so.1</div>
<div>-rw-r--r--. 1 root root 617652 Aug 29 11:19 libsepol.a</div><div>lrwxr=
wxrwx. 1 root root =C2=A0 =C2=A0 23 Aug 29 11:19 libsepol.so -&gt; ../../li=
b/libsepol.so.1</div><div>drwxr-xr-x. 2 root root =C2=A0 4096 Aug 29 11:29 =
pkgconfig</div>
</div><div><br></div><div>Sorry for the long email. =C2=A0Any suggestions w=
ould be appreciated.</div><br>
</div><div>Thanks,</div><div>Judd Meinders</div><div><br></div></div>

--089e013c67c4723b640501c83d37--
