Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v34MpdY4027777
 for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2017 18:51:39 -0400
Received: by mail-wr0-f179.google.com with SMTP id k6so220798871wre.2
 for <selinux@tycho.nsa.gov>; Tue, 04 Apr 2017 15:51:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491333342.31785.25.camel@tycho.nsa.gov>
References: <CAHFUiBNUTOaOYVch=MJPz6c_Stx_B_rmMA-FjMVcneiWouGKOw@mail.gmail.com>
 <1491323167.31785.14.camel@tycho.nsa.gov>
 <CAHFUiBPfTCsPTmKTOuRdRNp8Z1cSCiUj6D1QY0LpyPQ5M-a4Vw@mail.gmail.com>
 <1491326251.31785.17.camel@tycho.nsa.gov>
 <CAHFUiBNFpt0V_X5V+gu=28WPNwz3DR2iJDDDrRtX2+rWv+WRdw@mail.gmail.com>
 <1491328445.31785.22.camel@tycho.nsa.gov>
 <1491333342.31785.25.camel@tycho.nsa.gov>
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Tue, 4 Apr 2017 15:51:34 -0700
Message-ID: <CAHFUiBPLVxZMQtoD8TiAifR-guW3CsVk43GPyD_KWm73oOCobg@mail.gmail.com>
Subject: Re: Confining a Java process reading file
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Content-Type: multipart/alternative; boundary=f403045f165225743b054c5f1e5e
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045f165225743b054c5f1e5e
Content-Type: text/plain; charset=UTF-8

Alright, this is the output for readelf -l /usr/bin/runcon:

Elf file type is EXEC (Executable file)
Entry point 0x11c58
There are 9 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  EXIDX          0x0054d4 0x000154d4 0x000154d4 0x00008 0x00008 R   0x4
  PHDR           0x000034 0x00010034 0x00010034 0x00120 0x00120 R E 0x4
  INTERP         0x000154 0x00010154 0x00010154 0x00019 0x00019 R   0x1
      [Requesting program interpreter: /lib/ld-linux-armhf.so.3]
  LOAD           0x000000 0x00010000 0x00010000 0x054e0 0x054e0 R E 0x10000
  LOAD           0x005efc 0x00025efc 0x00025efc 0x00278 0x003ec RW  0x10000
  DYNAMIC        0x005f08 0x00025f08 0x00025f08 0x000f8 0x000f8 RW  0x4
  NOTE           0x000170 0x00010170 0x00010170 0x00044 0x00044 R   0x4
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x10
  GNU_RELRO      0x005efc 0x00025efc 0x00025efc 0x00104 0x00104 R   0x1

 Section to Segment mapping:
  Segment Sections...
   00     .ARM.exidx
   01
   02     .interp
   03     .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym
.dynstr .gnu.version .gnu.version_r .rel.dyn .rel.plt .init .plt .text
.fini .rodata .ARM.exidx .eh_frame
   04     .init_array .fini_array .jcr .dynamic .got .data .bss
   05     .dynamic
   06     .note.ABI-tag .note.gnu.build-id
   07
   08     .init_array .fini_array .jcr .dynamic

On Tue, Apr 4, 2017 at 12:15 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2017-04-04 at 13:54 -0400, Stephen Smalley wrote:
> > On Tue, 2017-04-04 at 10:44 -0700, Rahmadi Trimananda wrote:
> > > This again reflects a problem with the way your userspace was
> > > built.
> > > - Could you please explain what the problem is and how to solve
> > > this?
> >
> > Please run readelf -l /usr/bin/runcon and provide the output.
>
> Also, if you have scanelf (from pax-utils), running scanelf -lpqe and
> providing the output would be helpful.
>
> >
> > > Umm, then how about generating port labels?
> > > I tried adding a new port to my myapp_t label using  "semanage
> > > port",
> > > but it's complaining that myapp_t is not a port label. Need your
> > > insights here as well. Thank you!
> >
> > Yes, you would want to define a separate port type.
> > type myapp_port_t;
> > corenet_port(myapp_port_t)
> >
> > Then use myapp_port_t in your semanage port command.
> >
> > >
> > > On Tue, Apr 4, 2017 at 10:17 AM, Stephen Smalley <sds@tycho.nsa.gov
> > > >
> > > wrote:
> > > > On Tue, 2017-04-04 at 09:37 -0700, Rahmadi Trimananda wrote:
> > > > > Do you mean that we create our own new domain, e.g. myapp_t?
> > > > > I tried this and it works for my a.out that reads test.txt.
> > > > >
> > > > > I tried runcon as well for the Java version:
> > > > >
> > > > > runcon system_u:object_r:myapp_t:SystemLow java Test
> > > >
> > > > Just runcon -t myapp_t java Test would be simpler, and would
> > > > preserve
> > > > your user identity, role, and level.  Processes don't use
> > > > object_r;
> > > > that is only for files/objects.
> > > >
> > > > > The response I got was: runcon: java: Permission denied.
> > > > > In the audit.log I found that runcon is just not permitted for
> > > > > everything. Any thoughts?
> > > > >
> > > > > ...
> > > > > type=SYSCALL msg=audit(1491323666.800:4249): arch=40000028
> > > >
> > > > syscall=11
> > > > > per=800000 success=no exit=-13 a0=7ec2c140 a1=7ec2c34c
> > > >
> > > > a2=7ec2c35c
> > > > > a3=6e69622f items=0 ppid=989 pid=10629 auid=1001 uid=1001
> > > >
> > > > gid=1001
> > > > > euid=1001 suid=1001 fsuid=1001 egid=1001 sgid=1001 fsgid=1001
> > > > > tty=pts0 ses=3 comm="runcon" exe="/usr/bin/runcon"
> > > > > subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > >
> > > > key=(null)
> > > > >
> > > > > type=AVC msg=audit(1491323672.070:4255): avc:  denied  {
> > > >
> > > > execstack }
> > > > > for  pid=10631 comm="runcon"
> > > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > > > tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > > > tclass=process permissive=0
> > > >
> > > > This again reflects a problem with the way your userspace was
> > > > built.
> > > > execstack -q /usr/bin/runcon
> > > > readelf -l /usr/bin/runcon
> > > >
> > > > In the interim, you can allow execstack pervasively via:
> > > > setsebool -P allow_execstack=1
> > > >
> > > > > type=SYSCALL msg=audit(1491323672.070:4255): arch=40000028
> > > > > syscall=125 per=800000 success=no exit=-13 a0=7e84c000 a1=1000
> > > > > a2=1000007 a3=76fb6f18 items=0 ppid=10630 pid=10631 auid=1001
> > > >
> > > > uid=0
> > > > > gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0
> > > > > ses=3
> > > > > comm="runcon" exe="/usr/bin/runcon"
> > > > > subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > >
> > > > key=(null)
> > > > >
> > > > > type=AVC msg=audit(1491323672.080:4256): avc:  denied  {
> > > >
> > > > transition }
> > > > > for  pid=10631 comm="runcon" path="/usr/lib/jvm/java-8-openjdk-
> > > > > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > > > tcontext=system_u:object_r:myapp_t:s0 tclass=process
> > > > > permissive=0
> > > > >
> > > > > type=SYSCALL msg=audit(1491323672.080:4256): arch=40000028
> > > >
> > > > syscall=11
> > > > > per=800000 success=no exit=-13 a0=7e84c5dc a1=7e84c7ec
> > > >
> > > > a2=7e84c7f8
> > > > > a3=6e69622f items=0 ppid=10630 pid=10631 auid=1001 uid=0 gid=0
> > > >
> > > > euid=0
> > > > > suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3
> > > > > comm="runcon"
> > > > > exe="/usr/bin/runcon"
> > > >
> > > > subj=unconfined_u:unconfined_r:unconfined_t:s0-
> > > > > s0:c0.c1023 key=(null)
> > > > >
> > > > > type=AVC msg=audit(1491323700.770:4269): avc:  denied  {
> > > >
> > > > transition }
> > > > > for  pid=10636 comm="runcon" path="/usr/lib/jvm/java-8-openjdk-
> > > > > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > > > tcontext=system_u:object_r:myapp_t:s0 tclass=process
> > > > > permissive=1
> > > > >
> > > > > type=AVC msg=audit(1491323700.770:4269): avc:  denied  {
> > > >
> > > > entrypoint }
> > > > > for  pid=10636 comm="runcon" path="/usr/lib/jvm/java-8-openjdk-
> > > > > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > > > > scontext=system_u:object_r:myapp_t:s0
> > > > > tcontext=system_u:object_r:java_exec_t:s0 tclass=file
> > > >
> > > > permissive=1
> > > >
> > > > Add the following to your policy:
> > > > domain_entry_file(myapp_t, java_exec_t)
> > > > spec_domtrans_pattern(unconfined_t, java_exec_t, myapp_t)
> > > >
> > > >
> > > > > ...
> > > > >
> > > > >
> > > > > On Tue, Apr 4, 2017 at 9:26 AM, Stephen Smalley <sds@tycho.nsa.
> > > > > go
> > > >
> > > > v>
> > > > > wrote:
> > > > > > On Tue, 2017-04-04 at 08:50 -0700, Rahmadi Trimananda wrote:
> > > > > > > Hey Guys,
> > > > > > >
> > > > > > > I am trying to confine a Java process that I have so that
> > > > > > > it
> > > >
> > > > will
> > > > > > be
> > > > > > > able to read only certain files. This is my experiment
> > > > > > > setup
> > > >
> > > > for
> > > > > > my
> > > > > > > folder. Basically a.out (C program) and Test.class (Java
> > > >
> > > > class)
> > > > > > are
> > > > > > > coded to read and print out the text in test.txt.
> > > > > > >
> > > > > > >     unconfined_u:object_r:httpd_t:SystemLow a.out
> > > > > > > unconfined_u:object_r:user_home_t:SystemLow test.c
> > > > > > >     unconfined_u:object_r:httpd_t:SystemLow Test.class
> > > > > > > unconfined_u:object_r:user_home_t:SystemLow Test.java
> > > > > > > unconfined_u:object_r:user_home_t:SystemLow test.txt
> > > > > > >
> > > > > > > I tried to change the type label for a.out from user_home_t
> > > >
> > > > to
> > > > > > > httpd_t just for the sake of the experiment. With this
> > > > > > > setup,
> > > > > >
> > > > > > a.out
> > > > > > > is no longer able to read test.txt in enforcing mode.
> > > >
> > > > However, I
> > > > > > seem
> > > > > > > to not be able to do it for Test.class as it's running on a
> > > >
> > > > JVM.
> > > > > > The
> > > > > > > java label is "bin_t". And I checked using this:
> > > > > > >
> > > > > > > sesearch -s bin_t -t user_home_t -c file -p read -Ad
> > > > > > >
> > > > > > > And it doesn't seem to have a rule that allows bin_t to
> > > > > > > read
> > > >
> > > > a
> > > > > > file
> > > > > > > with user_home_t label.
> > > > > > >
> > > > > > > What's the right way to do this if any? Then, I also try to
> > > > > >
> > > > > > confine
> > > > > > > port accesses for Test.class, e.g. I only allow it to
> > > > > > > access
> > > > > >
> > > > > > ports
> > > > > > > 1234 and 2345. Same question, what's the right way to do
> > > >
> > > > this?
> > > > > >
> > > > > > I think you are conflating file labels with process labels.
> > > >
> > > > The
> > > > > > /usr/sbin/httpd file is labeled with the httpd_exec_t type;
> > > > > > the
> > > > > > running
> > > > > > httpd process runs in the httpd_t domain (to be precise,
> > > > > > init_t
> > > > > > transitions to httpd_t upon executing httpd_exec_t).  bin_t
> > > > > > is
> > > >
> > > > just
> > > > > > a
> > > > > > generally executable file type that doesn't cause a domain
> > > > > > transition
> > > > > > (as no domain transition is defined in policy on it), so a
> > > >
> > > > process
> > > > > > that
> > > > > > execs a bin_t file will just stay in its domain.  You want to
> > > > > > create a
> > > > > > new domain and run your program in that; if you are running
> > > > > > it
> > > > > > through
> > > > > > an interpreter, then you can force it into the target domain
> > > >
> > > > via
> > > > > > runcon.
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Kind regards,
> > > > > Rahmadi Trimananda
> > > > >
> > > > > Ph.D. student @ University of California, Irvine
> > > > > "Stay hungry, stay foolish!" - Steve Jobs -
> > >
> > >
> > >
> > > --
> > > Kind regards,
> > > Rahmadi Trimananda
> > >
> > > Ph.D. student @ University of California, Irvine
> > > "Stay hungry, stay foolish!" - Steve Jobs -
>



-- 
Kind regards,
Rahmadi Trimananda

Ph.D. student @ University of California, Irvine
"Stay hungry, stay foolish!" - Steve Jobs -

--f403045f165225743b054c5f1e5e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Alright, this is the output for readelf -l /usr/bin/runcon=
:<div><br></div><div><div>Elf file type is EXEC (Executable file)</div><div=
>Entry point 0x11c58</div><div>There are 9 program headers, starting at off=
set 52</div><div><br></div><div>Program Headers:</div><div>=C2=A0 Type =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset =C2=A0 VirtAddr =C2=A0 PhysAddr =C2=
=A0 FileSiz MemSiz =C2=A0Flg Align</div><div>=C2=A0 EXIDX =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x0054d4 0x000154d4 0x000154d4 0x00008 0x00008 R =C2=A0 0x=
4</div><div>=C2=A0 PHDR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000034 0x00010=
034 0x00010034 0x00120 0x00120 R E 0x4</div><div>=C2=A0 INTERP =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x000154 0x00010154 0x00010154 0x00019 0x00019 R =C2=A0 0=
x1</div><div>=C2=A0 =C2=A0 =C2=A0 [Requesting program interpreter: /lib/ld-=
linux-armhf.so.3]</div><div>=C2=A0 LOAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0x000000 0x00010000 0x00010000 0x054e0 0x054e0 R E 0x10000</div><div>=C2=A0=
 LOAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x005efc 0x00025efc 0x00025efc 0x0=
0278 0x003ec RW =C2=A00x10000</div><div>=C2=A0 DYNAMIC =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x005f08 0x00025f08 0x00025f08 0x000f8 0x000f8 RW =C2=A00x4</div><di=
v>=C2=A0 NOTE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000170 0x00010170 0x0001=
0170 0x00044 0x00044 R =C2=A0 0x4</div><div>=C2=A0 GNU_STACK =C2=A0 =C2=A0 =
=C2=A00x000000 0x00000000 0x00000000 0x00000 0x00000 RW =C2=A00x10</div><di=
v>=C2=A0 GNU_RELRO =C2=A0 =C2=A0 =C2=A00x005efc 0x00025efc 0x00025efc 0x001=
04 0x00104 R =C2=A0 0x1</div><div><br></div><div>=C2=A0Section to Segment m=
apping:</div><div>=C2=A0 Segment Sections...</div><div>=C2=A0 =C2=A000 =C2=
=A0 =C2=A0 .ARM.exidx=C2=A0</div><div>=C2=A0 =C2=A001 =C2=A0 =C2=A0=C2=A0</=
div><div>=C2=A0 =C2=A002 =C2=A0 =C2=A0 .interp=C2=A0</div><div>=C2=A0 =C2=
=A003 =C2=A0 =C2=A0 .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dyn=
sym .dynstr .gnu.version .gnu.version_r .rel.dyn .rel.plt .init .plt .text =
.fini .rodata .ARM.exidx .eh_frame=C2=A0</div><div>=C2=A0 =C2=A004 =C2=A0 =
=C2=A0 .init_array .fini_array .jcr .dynamic .got .data .bss=C2=A0</div><di=
v>=C2=A0 =C2=A005 =C2=A0 =C2=A0 .dynamic=C2=A0</div><div>=C2=A0 =C2=A006 =
=C2=A0 =C2=A0 .note.ABI-tag .note.gnu.build-id=C2=A0</div><div>=C2=A0 =C2=
=A007 =C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A008 =C2=A0 =C2=A0 .init_arr=
ay .fini_array .jcr .dynamic</div></div></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Tue, Apr 4, 2017 at 12:15 PM, Stephen Small=
ey <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_bl=
ank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><span class=3D"">On Tue, 2017-04-04 at 13:54 -0400, Stephen Smalley wro=
te:<br>
&gt; On Tue, 2017-04-04 at 10:44 -0700, Rahmadi Trimananda wrote:<br>
&gt; &gt; This again reflects a problem with the way your userspace was<br>
&gt; &gt; built.<br>
&gt; &gt; - Could you please explain what the problem is and how to solve<b=
r>
&gt; &gt; this?<br>
&gt;<br>
&gt; Please run readelf -l /usr/bin/runcon and provide the output.<br>
<br>
</span>Also, if you have scanelf (from pax-utils), running scanelf -lpqe an=
d<br>
providing the output would be helpful.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; &gt; Umm, then how about generating port labels?<br>
&gt; &gt; I tried adding a new port to my myapp_t label using =C2=A0&quot;s=
emanage<br>
&gt; &gt; port&quot;,<br>
&gt; &gt; but it&#39;s complaining that myapp_t is not a port label. Need y=
our<br>
&gt; &gt; insights here as well. Thank you!<br>
&gt;<br>
&gt; Yes, you would want to define a separate port type.<br>
&gt; type myapp_port_t;<br>
&gt; corenet_port(myapp_port_t)<br>
&gt;<br>
&gt; Then use myapp_port_t in your semanage port command.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Apr 4, 2017 at 10:17 AM, Stephen Smalley &lt;<a href=3D"m=
ailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt; &gt; On Tue, 2017-04-04 at 09:37 -0700, Rahmadi Trimananda wrote:=
<br>
&gt; &gt; &gt; &gt; Do you mean that we create our own new domain, e.g. mya=
pp_t?<br>
&gt; &gt; &gt; &gt; I tried this and it works for my a.out that reads test.=
txt.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I tried runcon as well for the Java version:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; runcon system_u:object_r:myapp_t:<wbr>SystemLow java Te=
st<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Just runcon -t myapp_t java Test would be simpler, and would=
<br>
&gt; &gt; &gt; preserve<br>
&gt; &gt; &gt; your user identity, role, and level.=C2=A0 Processes don&#39=
;t use<br>
&gt; &gt; &gt; object_r;<br>
&gt; &gt; &gt; that is only for files/objects.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The response I got was:=C2=A0runcon: java: Permission d=
enied.<br>
&gt; &gt; &gt; &gt; In the audit.log I found that runcon is just not permit=
ted for<br>
&gt; &gt; &gt; &gt; everything. Any thoughts?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; ...<br>
&gt; &gt; &gt; &gt; type=3DSYSCALL msg=3Daudit(1491323666.800:4249)<wbr>: a=
rch=3D40000028<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; syscall=3D11<br>
&gt; &gt; &gt; &gt; per=3D800000 success=3Dno exit=3D-13 a0=3D7ec2c140 a1=
=3D7ec2c34c<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; a2=3D7ec2c35c<br>
&gt; &gt; &gt; &gt; a3=3D6e69622f items=3D0 ppid=3D989 pid=3D10629 auid=3D1=
001 uid=3D1001<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; gid=3D1001<br>
&gt; &gt; &gt; &gt; euid=3D1001 suid=3D1001 fsuid=3D1001 egid=3D1001 sgid=
=3D1001 fsgid=3D1001<br>
&gt; &gt; &gt; &gt; tty=3Dpts0 ses=3D3 comm=3D&quot;runcon&quot; exe=3D&quo=
t;/usr/bin/runcon&quot;<br>
&gt; &gt; &gt; &gt; subj=3Dunconfined_u:unconfined_<wbr>r:unconfined_t:s0-s=
0:c0.c1023<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; key=3D(null)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; type=3DAVC msg=3Daudit(1491323672.070:4255)<wbr>: avc: =
=C2=A0denied =C2=A0{<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; execstack }<br>
&gt; &gt; &gt; &gt; for =C2=A0pid=3D10631 comm=3D&quot;runcon&quot;<br>
&gt; &gt; &gt; &gt; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:=
s0-<wbr>s0:c0.c1023<br>
&gt; &gt; &gt; &gt; tcontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:=
s0-<wbr>s0:c0.c1023<br>
&gt; &gt; &gt; &gt; tclass=3Dprocess permissive=3D0<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This again reflects a problem with the way your userspace wa=
s<br>
&gt; &gt; &gt; built.<br>
&gt; &gt; &gt; execstack -q /usr/bin/runcon<br>
&gt; &gt; &gt; readelf -l /usr/bin/runcon<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In the interim, you can allow execstack pervasively via:<br>
&gt; &gt; &gt; setsebool -P allow_execstack=3D1<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; type=3DSYSCALL msg=3Daudit(1491323672.070:4255)<wbr>: a=
rch=3D40000028<br>
&gt; &gt; &gt; &gt; syscall=3D125 per=3D800000 success=3Dno exit=3D-13 a0=
=3D7e84c000 a1=3D1000<br>
&gt; &gt; &gt; &gt; a2=3D1000007 a3=3D76fb6f18 items=3D0 ppid=3D10630 pid=
=3D10631 auid=3D1001<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; uid=3D0<br>
&gt; &gt; &gt; &gt; gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 f=
sgid=3D0 tty=3Dpts0<br>
&gt; &gt; &gt; &gt; ses=3D3<br>
&gt; &gt; &gt; &gt; comm=3D&quot;runcon&quot; exe=3D&quot;/usr/bin/runcon&q=
uot;<br>
&gt; &gt; &gt; &gt; subj=3Dunconfined_u:unconfined_<wbr>r:unconfined_t:s0-s=
0:c0.c1023<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; key=3D(null)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; type=3DAVC msg=3Daudit(1491323672.080:4256)<wbr>: avc: =
=C2=A0denied =C2=A0{<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; transition }<br>
&gt; &gt; &gt; &gt; for =C2=A0pid=3D10631 comm=3D&quot;runcon&quot; path=3D=
&quot;/usr/lib/jvm/java-8-<wbr>openjdk-<br>
&gt; &gt; &gt; &gt; armhf/jre/bin/java&quot; dev=3D&quot;mmcblk0p2&quot; in=
o=3D524520<br>
&gt; &gt; &gt; &gt; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:=
s0-<wbr>s0:c0.c1023<br>
&gt; &gt; &gt; &gt; tcontext=3Dsystem_u:object_r:<wbr>myapp_t:s0 tclass=3Dp=
rocess<br>
&gt; &gt; &gt; &gt; permissive=3D0<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; type=3DSYSCALL msg=3Daudit(1491323672.080:4256)<wbr>: a=
rch=3D40000028<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; syscall=3D11<br>
&gt; &gt; &gt; &gt; per=3D800000 success=3Dno exit=3D-13 a0=3D7e84c5dc a1=
=3D7e84c7ec<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; a2=3D7e84c7f8<br>
&gt; &gt; &gt; &gt; a3=3D6e69622f items=3D0 ppid=3D10630 pid=3D10631 auid=
=3D1001 uid=3D0 gid=3D0<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; euid=3D0<br>
&gt; &gt; &gt; &gt; suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpt=
s0 ses=3D3<br>
&gt; &gt; &gt; &gt; comm=3D&quot;runcon&quot;<br>
&gt; &gt; &gt; &gt; exe=3D&quot;/usr/bin/runcon&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; subj=3Dunconfined_u:unconfined_<wbr>r:unconfined_t:s0-<br>
&gt; &gt; &gt; &gt; s0:c0.c1023 key=3D(null)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; type=3DAVC msg=3Daudit(1491323700.770:4269)<wbr>: avc: =
=C2=A0denied =C2=A0{<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; transition }<br>
&gt; &gt; &gt; &gt; for =C2=A0pid=3D10636 comm=3D&quot;runcon&quot; path=3D=
&quot;/usr/lib/jvm/java-8-<wbr>openjdk-<br>
&gt; &gt; &gt; &gt; armhf/jre/bin/java&quot; dev=3D&quot;mmcblk0p2&quot; in=
o=3D524520<br>
&gt; &gt; &gt; &gt; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:=
s0-<wbr>s0:c0.c1023<br>
&gt; &gt; &gt; &gt; tcontext=3Dsystem_u:object_r:<wbr>myapp_t:s0 tclass=3Dp=
rocess<br>
&gt; &gt; &gt; &gt; permissive=3D1<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; type=3DAVC msg=3Daudit(1491323700.770:4269)<wbr>: avc: =
=C2=A0denied =C2=A0{<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; entrypoint }<br>
&gt; &gt; &gt; &gt; for =C2=A0pid=3D10636 comm=3D&quot;runcon&quot; path=3D=
&quot;/usr/lib/jvm/java-8-<wbr>openjdk-<br>
&gt; &gt; &gt; &gt; armhf/jre/bin/java&quot; dev=3D&quot;mmcblk0p2&quot; in=
o=3D524520<br>
&gt; &gt; &gt; &gt; scontext=3Dsystem_u:object_r:<wbr>myapp_t:s0<br>
&gt; &gt; &gt; &gt; tcontext=3Dsystem_u:object_r:<wbr>java_exec_t:s0 tclass=
=3Dfile<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; permissive=3D1<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Add the following to your policy:<br>
&gt; &gt; &gt; domain_entry_file(myapp_t, java_exec_t)<br>
&gt; &gt; &gt; spec_domtrans_pattern(<wbr>unconfined_t, java_exec_t, myapp_=
t)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; ...<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Tue, Apr 4, 2017 at 9:26 AM, Stephen Smalley &lt;sds=
@tycho.nsa.<br>
&gt; &gt; &gt; &gt; go<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; v&gt;<br>
&gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; On Tue, 2017-04-04 at 08:50 -0700, Rahmadi Trimana=
nda wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; Hey Guys,<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; I am trying to confine a Java process that I =
have so that<br>
&gt; &gt; &gt; &gt; &gt; &gt; it<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; will<br>
&gt; &gt; &gt; &gt; &gt; be<br>
&gt; &gt; &gt; &gt; &gt; &gt; able to read only certain files. This is my e=
xperiment<br>
&gt; &gt; &gt; &gt; &gt; &gt; setup<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; for<br>
&gt; &gt; &gt; &gt; &gt; my<br>
&gt; &gt; &gt; &gt; &gt; &gt; folder. Basically a.out (C program) and Test.=
class (Java<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; class)<br>
&gt; &gt; &gt; &gt; &gt; are<br>
&gt; &gt; &gt; &gt; &gt; &gt; coded to read and print out the text in test.=
txt.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 unconfined_u:object_r:httpd_t:<=
wbr>SystemLow a.out<br>
&gt; &gt; &gt; &gt; &gt; &gt; unconfined_u:object_r:user_<wbr>home_t:System=
Low test.c<br>
&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 unconfined_u:object_r:httpd_t:<=
wbr>SystemLow Test.class<br>
&gt; &gt; &gt; &gt; &gt; &gt; unconfined_u:object_r:user_<wbr>home_t:System=
Low Test.java<br>
&gt; &gt; &gt; &gt; &gt; &gt; unconfined_u:object_r:user_<wbr>home_t:System=
Low test.txt<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; I tried to change the type label for a.out fr=
om user_home_t<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt; &gt; &gt; httpd_t just for the sake of the experiment. =
With this<br>
&gt; &gt; &gt; &gt; &gt; &gt; setup,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; a.out<br>
&gt; &gt; &gt; &gt; &gt; &gt; is no longer able to read test.txt in enforci=
ng mode.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; However, I<br>
&gt; &gt; &gt; &gt; &gt; seem<br>
&gt; &gt; &gt; &gt; &gt; &gt; to not be able to do it for Test.class as it&=
#39;s running on a<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; JVM.<br>
&gt; &gt; &gt; &gt; &gt; The<br>
&gt; &gt; &gt; &gt; &gt; &gt; java label is &quot;bin_t&quot;. And I checke=
d using this:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; sesearch -s bin_t -t user_home_t -c file -p r=
ead -Ad<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; And it doesn&#39;t seem to have a rule that a=
llows bin_t to<br>
&gt; &gt; &gt; &gt; &gt; &gt; read<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; a<br>
&gt; &gt; &gt; &gt; &gt; file<br>
&gt; &gt; &gt; &gt; &gt; &gt; with user_home_t label.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; What&#39;s the right way to do this if any? T=
hen, I also try to<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; confine<br>
&gt; &gt; &gt; &gt; &gt; &gt; port accesses for Test.class, e.g. I only all=
ow it to<br>
&gt; &gt; &gt; &gt; &gt; &gt; access<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; ports<br>
&gt; &gt; &gt; &gt; &gt; &gt; 1234 and 2345. Same question, what&#39;s the =
right way to do<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; this?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I think you are conflating file labels with proces=
s labels.=C2=A0<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The<br>
&gt; &gt; &gt; &gt; &gt; /usr/sbin/httpd file is labeled with the httpd_exe=
c_t type;<br>
&gt; &gt; &gt; &gt; &gt; the<br>
&gt; &gt; &gt; &gt; &gt; running<br>
&gt; &gt; &gt; &gt; &gt; httpd process runs in the httpd_t domain (to be pr=
ecise,<br>
&gt; &gt; &gt; &gt; &gt; init_t<br>
&gt; &gt; &gt; &gt; &gt; transitions to httpd_t upon executing httpd_exec_t=
).=C2=A0 bin_t<br>
&gt; &gt; &gt; &gt; &gt; is<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; just<br>
&gt; &gt; &gt; &gt; &gt; a<br>
&gt; &gt; &gt; &gt; &gt; generally executable file type that doesn&#39;t ca=
use a domain<br>
&gt; &gt; &gt; &gt; &gt; transition<br>
&gt; &gt; &gt; &gt; &gt; (as no domain transition is defined in policy on i=
t), so a<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; process<br>
&gt; &gt; &gt; &gt; &gt; that<br>
&gt; &gt; &gt; &gt; &gt; execs a bin_t file will just stay in its domain.=
=C2=A0 You want to<br>
&gt; &gt; &gt; &gt; &gt; create a<br>
&gt; &gt; &gt; &gt; &gt; new domain and run your program in that; if you ar=
e running<br>
&gt; &gt; &gt; &gt; &gt; it<br>
&gt; &gt; &gt; &gt; &gt; through<br>
&gt; &gt; &gt; &gt; &gt; an interpreter, then you can force it into the tar=
get domain<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; via<br>
&gt; &gt; &gt; &gt; &gt; runcon.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; --=C2=A0<br>
&gt; &gt; &gt; &gt; Kind regards,<br>
&gt; &gt; &gt; &gt; Rahmadi Trimananda<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Ph.D. student @ University of California, Irvine<br>
&gt; &gt; &gt; &gt; &quot;Stay hungry, stay foolish!&quot; - Steve Jobs -<b=
r>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --=C2=A0<br>
&gt; &gt; Kind regards,<br>
&gt; &gt; Rahmadi Trimananda<br>
&gt; &gt;<br>
&gt; &gt; Ph.D. student @ University of California, Irvine<br>
&gt; &gt; &quot;Stay hungry, stay foolish!&quot; - Steve Jobs -<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Kind regards,<div>Rahmadi Trimananda</div><div><br></div><div>Ph.D=
. student @ University of California, Irvine</div><div>&quot;Stay hungry, s=
tay foolish!&quot; - Steve Jobs -</div></div></div>
</div>

--f403045f165225743b054c5f1e5e--
