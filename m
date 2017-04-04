Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v34Hil4O005289
 for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2017 13:44:47 -0400
Received: by mail-wm0-f44.google.com with SMTP id w204so6060067wmd.1
 for <selinux@tycho.nsa.gov>; Tue, 04 Apr 2017 10:44:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491326251.31785.17.camel@tycho.nsa.gov>
References: <CAHFUiBNUTOaOYVch=MJPz6c_Stx_B_rmMA-FjMVcneiWouGKOw@mail.gmail.com>
 <1491323167.31785.14.camel@tycho.nsa.gov>
 <CAHFUiBPfTCsPTmKTOuRdRNp8Z1cSCiUj6D1QY0LpyPQ5M-a4Vw@mail.gmail.com>
 <1491326251.31785.17.camel@tycho.nsa.gov>
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Tue, 4 Apr 2017 10:44:43 -0700
Message-ID: <CAHFUiBNFpt0V_X5V+gu=28WPNwz3DR2iJDDDrRtX2+rWv+WRdw@mail.gmail.com>
Subject: Re: Confining a Java process reading file
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Content-Type: multipart/alternative; boundary=001a1144472cc57344054c5ad480
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1144472cc57344054c5ad480
Content-Type: text/plain; charset=UTF-8

*This again reflects a problem with the way your userspace was built. *-
Could you please explain what the problem is and how to solve this?

Umm, then how about generating port labels?
I tried adding a new port to my myapp_t label using  "semanage port", but
it's complaining that myapp_t is not a port label. Need your insights here
as well. Thank you!

On Tue, Apr 4, 2017 at 10:17 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2017-04-04 at 09:37 -0700, Rahmadi Trimananda wrote:
> > Do you mean that we create our own new domain, e.g. myapp_t?
> > I tried this and it works for my a.out that reads test.txt.
> >
> > I tried runcon as well for the Java version:
> >
> > runcon system_u:object_r:myapp_t:SystemLow java Test
>
> Just runcon -t myapp_t java Test would be simpler, and would preserve
> your user identity, role, and level.  Processes don't use object_r;
> that is only for files/objects.
>
> > The response I got was: runcon: java: Permission denied.
> > In the audit.log I found that runcon is just not permitted for
> > everything. Any thoughts?
> >
> > ...
> > type=SYSCALL msg=audit(1491323666.800:4249): arch=40000028 syscall=11
> > per=800000 success=no exit=-13 a0=7ec2c140 a1=7ec2c34c a2=7ec2c35c
> > a3=6e69622f items=0 ppid=989 pid=10629 auid=1001 uid=1001 gid=1001
> > euid=1001 suid=1001 fsuid=1001 egid=1001 sgid=1001 fsgid=1001
> > tty=pts0 ses=3 comm="runcon" exe="/usr/bin/runcon"
> > subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> >
> > type=AVC msg=audit(1491323672.070:4255): avc:  denied  { execstack }
> > for  pid=10631 comm="runcon"
> > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > tclass=process permissive=0
>
> This again reflects a problem with the way your userspace was built.
> execstack -q /usr/bin/runcon
> readelf -l /usr/bin/runcon
>
> In the interim, you can allow execstack pervasively via:
> setsebool -P allow_execstack=1
>
> > type=SYSCALL msg=audit(1491323672.070:4255): arch=40000028
> > syscall=125 per=800000 success=no exit=-13 a0=7e84c000 a1=1000
> > a2=1000007 a3=76fb6f18 items=0 ppid=10630 pid=10631 auid=1001 uid=0
> > gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3
> > comm="runcon" exe="/usr/bin/runcon"
> > subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> >
> > type=AVC msg=audit(1491323672.080:4256): avc:  denied  { transition }
> > for  pid=10631 comm="runcon" path="/usr/lib/jvm/java-8-openjdk-
> > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > tcontext=system_u:object_r:myapp_t:s0 tclass=process permissive=0
> >
> > type=SYSCALL msg=audit(1491323672.080:4256): arch=40000028 syscall=11
> > per=800000 success=no exit=-13 a0=7e84c5dc a1=7e84c7ec a2=7e84c7f8
> > a3=6e69622f items=0 ppid=10630 pid=10631 auid=1001 uid=0 gid=0 euid=0
> > suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3 comm="runcon"
> > exe="/usr/bin/runcon" subj=unconfined_u:unconfined_r:unconfined_t:s0-
> > s0:c0.c1023 key=(null)
> >
> > type=AVC msg=audit(1491323700.770:4269): avc:  denied  { transition }
> > for  pid=10636 comm="runcon" path="/usr/lib/jvm/java-8-openjdk-
> > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > tcontext=system_u:object_r:myapp_t:s0 tclass=process permissive=1
> >
> > type=AVC msg=audit(1491323700.770:4269): avc:  denied  { entrypoint }
> > for  pid=10636 comm="runcon" path="/usr/lib/jvm/java-8-openjdk-
> > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > scontext=system_u:object_r:myapp_t:s0
> > tcontext=system_u:object_r:java_exec_t:s0 tclass=file permissive=1
>
> Add the following to your policy:
> domain_entry_file(myapp_t, java_exec_t)
> spec_domtrans_pattern(unconfined_t, java_exec_t, myapp_t)
>
>
> > ...
> >
> >
> > On Tue, Apr 4, 2017 at 9:26 AM, Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> > > On Tue, 2017-04-04 at 08:50 -0700, Rahmadi Trimananda wrote:
> > > > Hey Guys,
> > > >
> > > > I am trying to confine a Java process that I have so that it will
> > > be
> > > > able to read only certain files. This is my experiment setup for
> > > my
> > > > folder. Basically a.out (C program) and Test.class (Java class)
> > > are
> > > > coded to read and print out the text in test.txt.
> > > >
> > > >     unconfined_u:object_r:httpd_t:SystemLow a.out
> > > > unconfined_u:object_r:user_home_t:SystemLow test.c
> > > >     unconfined_u:object_r:httpd_t:SystemLow Test.class
> > > > unconfined_u:object_r:user_home_t:SystemLow Test.java
> > > > unconfined_u:object_r:user_home_t:SystemLow test.txt
> > > >
> > > > I tried to change the type label for a.out from user_home_t to
> > > > httpd_t just for the sake of the experiment. With this setup,
> > > a.out
> > > > is no longer able to read test.txt in enforcing mode. However, I
> > > seem
> > > > to not be able to do it for Test.class as it's running on a JVM.
> > > The
> > > > java label is "bin_t". And I checked using this:
> > > >
> > > > sesearch -s bin_t -t user_home_t -c file -p read -Ad
> > > >
> > > > And it doesn't seem to have a rule that allows bin_t to read a
> > > file
> > > > with user_home_t label.
> > > >
> > > > What's the right way to do this if any? Then, I also try to
> > > confine
> > > > port accesses for Test.class, e.g. I only allow it to access
> > > ports
> > > > 1234 and 2345. Same question, what's the right way to do this?
> > >
> > > I think you are conflating file labels with process labels.  The
> > > /usr/sbin/httpd file is labeled with the httpd_exec_t type; the
> > > running
> > > httpd process runs in the httpd_t domain (to be precise, init_t
> > > transitions to httpd_t upon executing httpd_exec_t).  bin_t is just
> > > a
> > > generally executable file type that doesn't cause a domain
> > > transition
> > > (as no domain transition is defined in policy on it), so a process
> > > that
> > > execs a bin_t file will just stay in its domain.  You want to
> > > create a
> > > new domain and run your program in that; if you are running it
> > > through
> > > an interpreter, then you can force it into the target domain via
> > > runcon.
> > >
> > >
> > >
> > >
> > >
> > >
> >
> >
> >
> > --
> > Kind regards,
> > Rahmadi Trimananda
> >
> > Ph.D. student @ University of California, Irvine
> > "Stay hungry, stay foolish!" - Steve Jobs -
>



-- 
Kind regards,
Rahmadi Trimananda

Ph.D. student @ University of California, Irvine
"Stay hungry, stay foolish!" - Steve Jobs -

--001a1144472cc57344054c5ad480
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px"><i>This again reflects a =
problem with the way your userspace was built. </i>- Could you please expla=
in what the problem is and how to solve this?</span><div><span style=3D"fon=
t-size:12.8px"><br></span></div><div><span style=3D"font-size:12.8px">Umm, =
then how about generating port labels?</span></div><div><span style=3D"font=
-size:12.8px">I tried adding a new port to my myapp_t label using =C2=A0&qu=
ot;semanage port&quot;, but it&#39;s complaining that myapp_t is not a port=
 label. Need your insights here as well. Thank you!</span></div></div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Apr 4, 2017 at=
 10:17 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tych=
o.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><span class=3D"">On Tue, 2017-04-04 at 09:37 -0=
700, Rahmadi Trimananda wrote:<br>
&gt; Do you mean that we create our own new domain, e.g. myapp_t?<br>
&gt; I tried this and it works for my a.out that reads test.txt.<br>
&gt;<br>
&gt; I tried runcon as well for the Java version:<br>
&gt;<br>
&gt; runcon system_u:object_r:myapp_t:<wbr>SystemLow java Test<br>
<br>
</span>Just runcon -t myapp_t java Test would be simpler, and would preserv=
e<br>
your user identity, role, and level.=C2=A0 Processes don&#39;t use object_r=
;<br>
that is only for files/objects.<br>
<span class=3D""><br>
&gt; The response I got was:=C2=A0runcon: java: Permission denied.<br>
&gt; In the audit.log I found that runcon is just not permitted for<br>
&gt; everything. Any thoughts?<br>
&gt;<br>
&gt; ...<br>
&gt; type=3DSYSCALL msg=3Daudit(1491323666.800:4249)<wbr>: arch=3D40000028 =
syscall=3D11<br>
&gt; per=3D800000 success=3Dno exit=3D-13 a0=3D7ec2c140 a1=3D7ec2c34c a2=3D=
7ec2c35c<br>
&gt; a3=3D6e69622f items=3D0 ppid=3D989 pid=3D10629 auid=3D1001 uid=3D1001 =
gid=3D1001<br>
&gt; euid=3D1001 suid=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D1001 fsgid=3D1=
001<br>
&gt; tty=3Dpts0 ses=3D3 comm=3D&quot;runcon&quot; exe=3D&quot;/usr/bin/runc=
on&quot;<br>
&gt; subj=3Dunconfined_u:unconfined_<wbr>r:unconfined_t:s0-s0:c0.c1023 key=
=3D(null)<br>
&gt;<br>
&gt; type=3DAVC msg=3Daudit(1491323672.070:4255)<wbr>: avc: =C2=A0denied =
=C2=A0{ execstack }<br>
&gt; for =C2=A0pid=3D10631 comm=3D&quot;runcon&quot;<br>
&gt; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c=
1023<br>
&gt; tcontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c=
1023<br>
&gt; tclass=3Dprocess permissive=3D0<br>
<br>
</span>This again reflects a problem with the way your userspace was built.=
<br>
execstack -q /usr/bin/runcon<br>
readelf -l /usr/bin/runcon<br>
<br>
In the interim, you can allow execstack pervasively via:<br>
setsebool -P allow_execstack=3D1<br>
<div><div class=3D"h5"><br>
&gt; type=3DSYSCALL msg=3Daudit(1491323672.070:4255)<wbr>: arch=3D40000028<=
br>
&gt; syscall=3D125 per=3D800000 success=3Dno exit=3D-13 a0=3D7e84c000 a1=3D=
1000<br>
&gt; a2=3D1000007 a3=3D76fb6f18 items=3D0 ppid=3D10630 pid=3D10631 auid=3D1=
001 uid=3D0<br>
&gt; gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D=
pts0 ses=3D3<br>
&gt; comm=3D&quot;runcon&quot; exe=3D&quot;/usr/bin/runcon&quot;<br>
&gt; subj=3Dunconfined_u:unconfined_<wbr>r:unconfined_t:s0-s0:c0.c1023 key=
=3D(null)<br>
&gt;<br>
&gt; type=3DAVC msg=3Daudit(1491323672.080:4256)<wbr>: avc: =C2=A0denied =
=C2=A0{ transition }<br>
&gt; for =C2=A0pid=3D10631 comm=3D&quot;runcon&quot; path=3D&quot;/usr/lib/=
jvm/java-8-<wbr>openjdk-<br>
&gt; armhf/jre/bin/java&quot; dev=3D&quot;mmcblk0p2&quot; ino=3D524520<br>
&gt; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c=
1023<br>
&gt; tcontext=3Dsystem_u:object_r:<wbr>myapp_t:s0 tclass=3Dprocess permissi=
ve=3D0<br>
&gt;<br>
&gt; type=3DSYSCALL msg=3Daudit(1491323672.080:4256)<wbr>: arch=3D40000028 =
syscall=3D11<br>
&gt; per=3D800000 success=3Dno exit=3D-13 a0=3D7e84c5dc a1=3D7e84c7ec a2=3D=
7e84c7f8<br>
&gt; a3=3D6e69622f items=3D0 ppid=3D10630 pid=3D10631 auid=3D1001 uid=3D0 g=
id=3D0 euid=3D0<br>
&gt; suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D3 comm=
=3D&quot;runcon&quot;<br>
&gt; exe=3D&quot;/usr/bin/runcon&quot; subj=3Dunconfined_u:unconfined_<wbr>=
r:unconfined_t:s0-<br>
&gt; s0:c0.c1023 key=3D(null)<br>
&gt;<br>
&gt; type=3DAVC msg=3Daudit(1491323700.770:4269)<wbr>: avc: =C2=A0denied =
=C2=A0{ transition }<br>
&gt; for =C2=A0pid=3D10636 comm=3D&quot;runcon&quot; path=3D&quot;/usr/lib/=
jvm/java-8-<wbr>openjdk-<br>
&gt; armhf/jre/bin/java&quot; dev=3D&quot;mmcblk0p2&quot; ino=3D524520<br>
&gt; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c=
1023<br>
&gt; tcontext=3Dsystem_u:object_r:<wbr>myapp_t:s0 tclass=3Dprocess permissi=
ve=3D1<br>
&gt;<br>
&gt; type=3DAVC msg=3Daudit(1491323700.770:4269)<wbr>: avc: =C2=A0denied =
=C2=A0{ entrypoint }<br>
&gt; for =C2=A0pid=3D10636 comm=3D&quot;runcon&quot; path=3D&quot;/usr/lib/=
jvm/java-8-<wbr>openjdk-<br>
&gt; armhf/jre/bin/java&quot; dev=3D&quot;mmcblk0p2&quot; ino=3D524520<br>
&gt; scontext=3Dsystem_u:object_r:<wbr>myapp_t:s0<br>
&gt; tcontext=3Dsystem_u:object_r:<wbr>java_exec_t:s0 tclass=3Dfile permiss=
ive=3D1<br>
<br>
</div></div>Add the following to your policy:<br>
domain_entry_file(myapp_t, java_exec_t)<br>
spec_domtrans_pattern(<wbr>unconfined_t, java_exec_t, myapp_t)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt; ...<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Apr 4, 2017 at 9:26 AM, Stephen Smalley &lt;<a href=3D"mailto:=
sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; wrote:<br>
&gt; &gt; On Tue, 2017-04-04 at 08:50 -0700, Rahmadi Trimananda wrote:<br>
&gt; &gt; &gt; Hey Guys,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I am trying to confine a Java process that I have so that it=
 will<br>
&gt; &gt; be<br>
&gt; &gt; &gt; able to read only certain files. This is my experiment setup=
 for<br>
&gt; &gt; my<br>
&gt; &gt; &gt; folder. Basically a.out (C program) and Test.class (Java cla=
ss)<br>
&gt; &gt; are<br>
&gt; &gt; &gt; coded to read and print out the text in test.txt.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 unconfined_u:object_r:httpd_t:<wbr>SystemLow a=
.out<br>
&gt; &gt; &gt; unconfined_u:object_r:user_<wbr>home_t:SystemLow test.c<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 unconfined_u:object_r:httpd_t:<wbr>SystemLow T=
est.class<br>
&gt; &gt; &gt; unconfined_u:object_r:user_<wbr>home_t:SystemLow Test.java<b=
r>
&gt; &gt; &gt; unconfined_u:object_r:user_<wbr>home_t:SystemLow test.txt<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I tried to change the type label for a.out from user_home_t =
to<br>
&gt; &gt; &gt; httpd_t just for the sake of the experiment. With this setup=
,<br>
&gt; &gt; a.out<br>
&gt; &gt; &gt; is no longer able to read test.txt in enforcing mode. Howeve=
r, I<br>
&gt; &gt; seem<br>
&gt; &gt; &gt; to not be able to do it for Test.class as it&#39;s running o=
n a JVM.<br>
&gt; &gt; The<br>
&gt; &gt; &gt; java label is &quot;bin_t&quot;. And I checked using this:<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; sesearch -s bin_t -t user_home_t -c file -p read -Ad<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; And it doesn&#39;t seem to have a rule that allows bin_t to =
read a<br>
&gt; &gt; file<br>
&gt; &gt; &gt; with user_home_t label.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; What&#39;s the right way to do this if any? Then, I also try=
 to<br>
&gt; &gt; confine<br>
&gt; &gt; &gt; port accesses for Test.class, e.g. I only allow it to access=
<br>
&gt; &gt; ports<br>
&gt; &gt; &gt; 1234 and 2345. Same question, what&#39;s the right way to do=
 this?<br>
&gt; &gt;<br>
&gt; &gt; I think you are conflating file labels with process labels.=C2=A0=
 The<br>
&gt; &gt; /usr/sbin/httpd file is labeled with the httpd_exec_t type; the<b=
r>
&gt; &gt; running<br>
&gt; &gt; httpd process runs in the httpd_t domain (to be precise, init_t<b=
r>
&gt; &gt; transitions to httpd_t upon executing httpd_exec_t).=C2=A0 bin_t =
is just<br>
&gt; &gt; a<br>
&gt; &gt; generally executable file type that doesn&#39;t cause a domain<br=
>
&gt; &gt; transition<br>
&gt; &gt; (as no domain transition is defined in policy on it), so a proces=
s<br>
&gt; &gt; that<br>
&gt; &gt; execs a bin_t file will just stay in its domain.=C2=A0 You want t=
o<br>
&gt; &gt; create a<br>
&gt; &gt; new domain and run your program in that; if you are running it<br=
>
&gt; &gt; through<br>
&gt; &gt; an interpreter, then you can force it into the target domain via<=
br>
&gt; &gt; runcon.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --=C2=A0<br>
&gt; Kind regards,<br>
&gt; Rahmadi Trimananda<br>
&gt;<br>
&gt; Ph.D. student @ University of California, Irvine<br>
&gt; &quot;Stay hungry, stay foolish!&quot; - Steve Jobs -<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Kind regards,<div>Rahmadi Trimananda</div><div><br></div><div>Ph.D=
. student @ University of California, Irvine</div><div>&quot;Stay hungry, s=
tay foolish!&quot; - Steve Jobs -</div></div></div>
</div>

--001a1144472cc57344054c5ad480--
