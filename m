Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v34GbZi9016557
 for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2017 12:37:36 -0400
Received: by mail-wr0-f180.google.com with SMTP id w11so217479063wrc.3
 for <selinux@tycho.nsa.gov>; Tue, 04 Apr 2017 09:37:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491323167.31785.14.camel@tycho.nsa.gov>
References: <CAHFUiBNUTOaOYVch=MJPz6c_Stx_B_rmMA-FjMVcneiWouGKOw@mail.gmail.com>
 <1491323167.31785.14.camel@tycho.nsa.gov>
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Tue, 4 Apr 2017 09:37:30 -0700
Message-ID: <CAHFUiBPfTCsPTmKTOuRdRNp8Z1cSCiUj6D1QY0LpyPQ5M-a4Vw@mail.gmail.com>
Subject: Re: Confining a Java process reading file
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f403045f1652672ddc054c59e41d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045f1652672ddc054c59e41d
Content-Type: text/plain; charset=UTF-8

Do you mean that we create our own new domain, e.g. myapp_t?
I tried this and it works for my a.out that reads test.txt.

I tried runcon as well for the Java version:

runcon system_u:object_r:myapp_t:SystemLow java Test

The response I got was: runcon: java: Permission denied.
In the audit.log I found that runcon is just not permitted for everything.
Any thoughts?

...
type=SYSCALL msg=audit(1491323666.800:4249): arch=40000028 syscall=11
per=800000 success=no exit=-13 a0=7ec2c140 a1=7ec2c34c a2=7ec2c35c
a3=6e69622f items=0 ppid=989 pid=10629 auid=1001 uid=1001 gid=1001
euid=1001 suid=1001 fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0
ses=3 comm="runcon" exe="/usr/bin/runcon"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)

type=AVC msg=audit(1491323672.070:4255): avc:  denied  { execstack } for
 pid=10631 comm="runcon"
scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tclass=process permissive=0

type=SYSCALL msg=audit(1491323672.070:4255): arch=40000028 syscall=125
per=800000 success=no exit=-13 a0=7e84c000 a1=1000 a2=1000007 a3=76fb6f18
items=0 ppid=10630 pid=10631 auid=1001 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=pts0 ses=3 comm="runcon" exe="/usr/bin/runcon"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)

type=AVC msg=audit(1491323672.080:4256): avc:  denied  { transition } for
 pid=10631 comm="runcon"
path="/usr/lib/jvm/java-8-openjdk-armhf/jre/bin/java" dev="mmcblk0p2"
ino=524520 scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=system_u:object_r:myapp_t:s0 tclass=process permissive=0

type=SYSCALL msg=audit(1491323672.080:4256): arch=40000028 syscall=11
per=800000 success=no exit=-13 a0=7e84c5dc a1=7e84c7ec a2=7e84c7f8
a3=6e69622f items=0 ppid=10630 pid=10631 auid=1001 uid=0 gid=0 euid=0
suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3 comm="runcon"
exe="/usr/bin/runcon"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)

type=AVC msg=audit(1491323700.770:4269): avc:  denied  { transition } for
 pid=10636 comm="runcon"
path="/usr/lib/jvm/java-8-openjdk-armhf/jre/bin/java" dev="mmcblk0p2"
ino=524520 scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=system_u:object_r:myapp_t:s0 tclass=process permissive=1

type=AVC msg=audit(1491323700.770:4269): avc:  denied  { entrypoint } for
 pid=10636 comm="runcon"
path="/usr/lib/jvm/java-8-openjdk-armhf/jre/bin/java" dev="mmcblk0p2"
ino=524520 scontext=system_u:object_r:myapp_t:s0
tcontext=system_u:object_r:java_exec_t:s0 tclass=file permissive=1
...


On Tue, Apr 4, 2017 at 9:26 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2017-04-04 at 08:50 -0700, Rahmadi Trimananda wrote:
> > Hey Guys,
> >
> > I am trying to confine a Java process that I have so that it will be
> > able to read only certain files. This is my experiment setup for my
> > folder. Basically a.out (C program) and Test.class (Java class) are
> > coded to read and print out the text in test.txt.
> >
> >     unconfined_u:object_r:httpd_t:SystemLow a.out
> > unconfined_u:object_r:user_home_t:SystemLow test.c
> >     unconfined_u:object_r:httpd_t:SystemLow Test.class
> > unconfined_u:object_r:user_home_t:SystemLow Test.java
> > unconfined_u:object_r:user_home_t:SystemLow test.txt
> >
> > I tried to change the type label for a.out from user_home_t to
> > httpd_t just for the sake of the experiment. With this setup, a.out
> > is no longer able to read test.txt in enforcing mode. However, I seem
> > to not be able to do it for Test.class as it's running on a JVM. The
> > java label is "bin_t". And I checked using this:
> >
> > sesearch -s bin_t -t user_home_t -c file -p read -Ad
> >
> > And it doesn't seem to have a rule that allows bin_t to read a file
> > with user_home_t label.
> >
> > What's the right way to do this if any? Then, I also try to confine
> > port accesses for Test.class, e.g. I only allow it to access ports
> > 1234 and 2345. Same question, what's the right way to do this?
>
> I think you are conflating file labels with process labels.  The
> /usr/sbin/httpd file is labeled with the httpd_exec_t type; the running
> httpd process runs in the httpd_t domain (to be precise, init_t
> transitions to httpd_t upon executing httpd_exec_t).  bin_t is just a
> generally executable file type that doesn't cause a domain transition
> (as no domain transition is defined in policy on it), so a process that
> execs a bin_t file will just stay in its domain.  You want to create a
> new domain and run your program in that; if you are running it through
> an interpreter, then you can force it into the target domain via
> runcon.
>
>
>
>
>
>


-- 
Kind regards,
Rahmadi Trimananda

Ph.D. student @ University of California, Irvine
"Stay hungry, stay foolish!" - Steve Jobs -

--f403045f1652672ddc054c59e41d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Do you mean that we create our own new domain, e.g. myapp_=
t?<div>I tried this and it works for my a.out that reads test.txt.</div><di=
v><br></div><div>I tried runcon as well for the Java version:</div><div><br=
></div><div>runcon system_u:object_r:myapp_t:SystemLow java Test<br></div><=
div><br></div><div>The response I got was:=C2=A0runcon: java: Permission de=
nied.</div><div>In the audit.log I found that runcon is just not permitted =
for everything. Any thoughts?</div><div><br></div><div>...</div><div><div>t=
ype=3DSYSCALL msg=3Daudit(1491323666.800:4249): arch=3D40000028 syscall=3D1=
1 per=3D800000 success=3Dno exit=3D-13 a0=3D7ec2c140 a1=3D7ec2c34c a2=3D7ec=
2c35c a3=3D6e69622f items=3D0 ppid=3D989 pid=3D10629 auid=3D1001 uid=3D1001=
 gid=3D1001 euid=3D1001 suid=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D1001 fs=
gid=3D1001 tty=3Dpts0 ses=3D3 comm=3D&quot;runcon&quot; exe=3D&quot;/usr/bi=
n/runcon&quot; subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023=
 key=3D(null)<br></div><div><br></div><div>type=3DAVC msg=3Daudit(149132367=
2.070:4255): avc: =C2=A0denied =C2=A0{ execstack } for =C2=A0pid=3D10631 co=
mm=3D&quot;runcon&quot; scontext=3Dunconfined_u:unconfined_r:unconfined_t:s=
0-s0:c0.c1023 tcontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1=
023 tclass=3Dprocess permissive=3D0</div><div><br></div><div>type=3DSYSCALL=
 msg=3Daudit(1491323672.070:4255): arch=3D40000028 syscall=3D125 per=3D8000=
00 success=3Dno exit=3D-13 a0=3D7e84c000 a1=3D1000 a2=3D1000007 a3=3D76fb6f=
18 items=3D0 ppid=3D10630 pid=3D10631 auid=3D1001 uid=3D0 gid=3D0 euid=3D0 =
suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D3 comm=3D&q=
uot;runcon&quot; exe=3D&quot;/usr/bin/runcon&quot; subj=3Dunconfined_u:unco=
nfined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)</div><div><br></div><div>=
type=3DAVC msg=3Daudit(1491323672.080:4256): avc: =C2=A0denied =C2=A0{ tran=
sition } for =C2=A0pid=3D10631 comm=3D&quot;runcon&quot; path=3D&quot;/usr/=
lib/jvm/java-8-openjdk-armhf/jre/bin/java&quot; dev=3D&quot;mmcblk0p2&quot;=
 ino=3D524520 scontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1=
023 tcontext=3Dsystem_u:object_r:myapp_t:s0 tclass=3Dprocess permissive=3D0=
</div><div><br></div><div>type=3DSYSCALL msg=3Daudit(1491323672.080:4256): =
arch=3D40000028 syscall=3D11 per=3D800000 success=3Dno exit=3D-13 a0=3D7e84=
c5dc a1=3D7e84c7ec a2=3D7e84c7f8 a3=3D6e69622f items=3D0 ppid=3D10630 pid=
=3D10631 auid=3D1001 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 s=
gid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D3 comm=3D&quot;runcon&quot; exe=3D&quot;=
/usr/bin/runcon&quot; subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c=
0.c1023 key=3D(null)</div><div><br></div><div>type=3DAVC msg=3Daudit(149132=
3700.770:4269): avc: =C2=A0denied =C2=A0{ transition } for =C2=A0pid=3D1063=
6 comm=3D&quot;runcon&quot; path=3D&quot;/usr/lib/jvm/java-8-openjdk-armhf/=
jre/bin/java&quot; dev=3D&quot;mmcblk0p2&quot; ino=3D524520 scontext=3Dunco=
nfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:objec=
t_r:myapp_t:s0 tclass=3Dprocess permissive=3D1</div><div><br></div><div>typ=
e=3DAVC msg=3Daudit(1491323700.770:4269): avc: =C2=A0denied =C2=A0{ entrypo=
int } for =C2=A0pid=3D10636 comm=3D&quot;runcon&quot; path=3D&quot;/usr/lib=
/jvm/java-8-openjdk-armhf/jre/bin/java&quot; dev=3D&quot;mmcblk0p2&quot; in=
o=3D524520 scontext=3Dsystem_u:object_r:myapp_t:s0 tcontext=3Dsystem_u:obje=
ct_r:java_exec_t:s0 tclass=3Dfile permissive=3D1</div></div><div>...<br><di=
v><br></div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Tue, Apr 4, 2017 at 9:26 AM, Stephen Smalley <span dir=3D"ltr">&l=
t;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On=
 Tue, 2017-04-04 at 08:50 -0700, Rahmadi Trimananda wrote:<br>
&gt; Hey Guys,<br>
&gt;<br>
&gt; I am trying to confine a Java process that I have so that it will be<b=
r>
&gt; able to read only certain files. This is my experiment setup for my<br=
>
&gt; folder. Basically a.out (C program) and Test.class (Java class) are<br=
>
&gt; coded to read and print out the text in test.txt.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 unconfined_u:object_r:httpd_t:<wbr>SystemLow a.out<br>
&gt; unconfined_u:object_r:user_<wbr>home_t:SystemLow test.c<br>
&gt; =C2=A0 =C2=A0 unconfined_u:object_r:httpd_t:<wbr>SystemLow Test.class<=
br>
&gt; unconfined_u:object_r:user_<wbr>home_t:SystemLow Test.java<br>
&gt; unconfined_u:object_r:user_<wbr>home_t:SystemLow test.txt<br>
&gt;<br>
&gt; I tried to change the type label for a.out from user_home_t to<br>
&gt; httpd_t just for the sake of the experiment. With this setup, a.out<br=
>
&gt; is no longer able to read test.txt in enforcing mode. However, I seem<=
br>
&gt; to not be able to do it for Test.class as it&#39;s running on a JVM. T=
he<br>
&gt; java label is &quot;bin_t&quot;. And I checked using this:<br>
&gt;<br>
&gt; sesearch -s bin_t -t user_home_t -c file -p read -Ad<br>
&gt;<br>
&gt; And it doesn&#39;t seem to have a rule that allows bin_t to read a fil=
e<br>
&gt; with user_home_t label.<br>
&gt;<br>
&gt; What&#39;s the right way to do this if any? Then, I also try to confin=
e<br>
&gt; port accesses for Test.class, e.g. I only allow it to access ports<br>
&gt; 1234 and 2345. Same question, what&#39;s the right way to do this?<br>
<br>
</span>I think you are conflating file labels with process labels.=C2=A0 Th=
e<br>
/usr/sbin/httpd file is labeled with the httpd_exec_t type; the running<br>
httpd process runs in the httpd_t domain (to be precise, init_t<br>
transitions to httpd_t upon executing httpd_exec_t).=C2=A0 bin_t is just a<=
br>
generally executable file type that doesn&#39;t cause a domain transition<b=
r>
(as no domain transition is defined in policy on it), so a process that<br>
execs a bin_t file will just stay in its domain.=C2=A0 You want to create a=
<br>
new domain and run your program in that; if you are running it through<br>
an interpreter, then you can force it into the target domain via<br>
runcon.<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Ki=
nd regards,<div>Rahmadi Trimananda</div><div><br></div><div>Ph.D. student @=
 University of California, Irvine</div><div>&quot;Stay hungry, stay foolish=
!&quot; - Steve Jobs -</div></div></div>
</div>

--f403045f1652672ddc054c59e41d--
