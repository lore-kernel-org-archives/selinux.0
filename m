Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBSE4emS020143
 for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2014 09:04:40 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so15896318pab.28
 for <selinux@tycho.nsa.gov>; Sun, 28 Dec 2014 06:04:38 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 28 Dec 2014 19:34:37 +0530
Message-ID: <CAF4ab9Wu1hf5qBKj5L7mtpp4eqqfRixJY3dvZJ+n3+xPQNxnzw@mail.gmail.com>
Subject: Problem running "selinux sandbox" with java
From: Bhuvan Gupta <bhuvangu@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c2e94c04bb05050b473d3b
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c2e94c04bb05050b473d3b
Content-Type: text/plain; charset=UTF-8

Hello all,
Greeting and happy new year to all.
I am trying to sandbox a java application using selinux sandbox.
System details: Redhat 6 | x86_64 | no x server install | jdk7 from oracle
tar.gz version | cgred and cgconfig are stop
The cmd (run as root)
*         sandbox /root/jdk/bin/java -version*
above cmd failed with
*         /root/jdk/bin/java: error while loading shared libraries:
libjli.so: cannot open shared object file: No such file or directory*

Digging, revealed that "libjli.so" is RPATH shared library. so i thought ok
since sandbox is copying my bin/java to /tmp/sandbox_random therefore a
hardcode path will not be found.
Then i change the RPATH using "chrpath" utility and changed it to a
hardcode value
But still it showed the same error.

Then i used the -M -i option of sandbox and ran following command (i
included all the .so file it complaint about):

*      sandbox -M -i /root/jdk/lib/amd64/jli/libjli.so -i
/root/jdk/jre/lib/amd64/libjava.so -i /root/jdk/jre/lib/amd64/jvm.cfg -i
/root/jdk/jre/lib/amd64/server/libjvm.so -i
 /root/jdk/jre/lib/amd64/libverify.so -i /root/jdk/jre/lib/amd64/libzip.so
/root/jdk/bin/java  -version*

Following command resulted in this error:
*Java HotSpot(TM) 64-Bit Server VM warning: INFO:
os::commit_memory(0x00007fb039000000, 2555904, 1) failed; error='Permission
denied' (errno=13)*
*#*
*# There is insufficient memory for the Java Runtime Environment to
continue.*
*# Native memory allocation (malloc) failed to allocate 2555904 bytes for
committing reserved memory.*
*# An error report file with more information is saved as:*
*# /root/hs_err_pid1270.log*

Now i used the strace to see what happened and strace printed(small
section)
*clone(child_stack=0,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0x7fb15b6359d0) = 8268*
*close(4)                                = 0*
*read(3, "", 1048576)                    = 0*
*close(3)                                = 0*
*wait4(8268, Java HotSpot(TM) 64-Bit Server VM warning: INFO:
os::commit_memory(0x00007f4579000000, 2555904, 1) failed; error='Permission
denied' (errno=13)*

I have enough space for sure

*Can you guys please indicate what might be wrong ?*

--001a11c2e94c04bb05050b473d3b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:13px">Hello all,=C2=A0</span><div=
 style=3D"font-size:13px">Greeting and happy new year to all.</div><div sty=
le=3D"font-size:13px">I am trying to sandbox a java application using selin=
ux sandbox.</div><div style=3D"font-size:13px">System details: Redhat 6 | x=
86_64 | no x server install | jdk7 from oracle tar.gz version | cgred and=
=C2=A0cgconfig are stop=C2=A0</div><div style=3D"font-size:13px">The cmd (r=
un as root)</div><div style=3D"font-size:13px"><i>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0=C2=A0sandbox /root/jdk/bin/java -version</i></div><div style=3D"f=
ont-size:13px">above cmd failed with=C2=A0</div><div style=3D"font-size:13p=
x"><i>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/root/jdk/bin/java: error while loa=
ding shared libraries: libjli.so: cannot open shared object file: No such f=
ile or directory</i><br></div><div style=3D"font-size:13px"><br></div><div =
style=3D"font-size:13px">Digging, revealed that &quot;libjli.so&quot; is RP=
ATH shared library. so i thought ok since sandbox is copying my bin/java to=
 /tmp/sandbox_random therefore a hardcode path will not be found.</div><div=
 style=3D"font-size:13px">Then i change the RPATH using &quot;chrpath&quot;=
 utility and changed it to a hardcode value</div><div style=3D"font-size:13=
px">But still it showed the same error.</div><div style=3D"font-size:13px">=
<br></div><div style=3D"font-size:13px">Then i used the -M -i option of san=
dbox and ran following command (i included all the .so file it complaint ab=
out):</div><div style=3D"font-size:13px"><i>=C2=A0 =C2=A0 =C2=A0 sandbox -M=
 -i /root/jdk/lib/amd64/jli/libjli.so -i /root/jdk/jre/lib/amd64/libjava.so=
 -i /root/jdk/jre/lib/amd64/jvm.cfg -i /root/jdk/jre/lib/amd64/server/libjv=
m.so -i =C2=A0 =C2=A0/root/jdk/jre/lib/amd64/libverify.so -i /root/jdk/jre/=
lib/amd64/libzip.so /root/jdk/bin/java =C2=A0-version<br></i></div><div sty=
le=3D"font-size:13px"><br></div><div style=3D"font-size:13px">Following com=
mand resulted in this error:</div><div style=3D"font-size:13px"><div><i>Jav=
a HotSpot(TM) 64-Bit Server VM warning: INFO: os::commit_memory(0x00007fb03=
9000000, 2555904, 1) failed; error=3D&#39;Permission denied&#39; (errno=3D1=
3)</i></div><div><i>#</i></div><div><i># There is insufficient memory for t=
he Java Runtime Environment to continue.</i></div><div><i># Native memory a=
llocation (malloc) failed to allocate 2555904 bytes for committing reserved=
 memory.</i></div><div><i># An error report file with more information is s=
aved as:</i></div><div><i># /root/hs_err_pid1270.log</i></div></div><div st=
yle=3D"font-size:13px"><br></div><div style=3D"font-size:13px">Now i used t=
he strace to see what happened and strace printed(small section)=C2=A0</div=
><div style=3D"font-size:13px"><div><i>clone(child_stack=3D0, flags=3DCLONE=
_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=3D0x7fb15b6359d0) =
=3D 8268</i></div><div><i>close(4) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0</i></div><div><i>read(3, &quot;&quot;, 1048576) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</i></div><div><i>clos=
e(3) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0</i></div><div><i>wait4(8268,=
 Java HotSpot(TM) 64-Bit Server VM warning: INFO: os::commit_memory(0x00007=
f4579000000, 2555904, 1) failed; error=3D&#39;Permission denied&#39; (errno=
=3D13)</i></div></div><div style=3D"font-size:13px"><br></div><div style=3D=
"font-size:13px">I have enough space for sure</div><div style=3D"font-size:=
13px"><br></div><div style=3D"font-size:13px"><b><i>Can you guys please ind=
icate what might be wrong ?</i></b></div></div>

--001a11c2e94c04bb05050b473d3b--
