Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v35GHjEe018591
 for <selinux@tycho.nsa.gov>; Wed, 5 Apr 2017 12:17:46 -0400
Received: by mail-wr0-f171.google.com with SMTP id t20so22104668wra.1
 for <selinux@tycho.nsa.gov>; Wed, 05 Apr 2017 09:17:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491400801.15479.5.camel@tycho.nsa.gov>
References: <CAHFUiBNUTOaOYVch=MJPz6c_Stx_B_rmMA-FjMVcneiWouGKOw@mail.gmail.com>
 <1491323167.31785.14.camel@tycho.nsa.gov>
 <CAHFUiBPfTCsPTmKTOuRdRNp8Z1cSCiUj6D1QY0LpyPQ5M-a4Vw@mail.gmail.com>
 <1491326251.31785.17.camel@tycho.nsa.gov>
 <CAHFUiBNFpt0V_X5V+gu=28WPNwz3DR2iJDDDrRtX2+rWv+WRdw@mail.gmail.com>
 <1491328445.31785.22.camel@tycho.nsa.gov>
 <1491333342.31785.25.camel@tycho.nsa.gov>
 <CAHFUiBPLVxZMQtoD8TiAifR-guW3CsVk43GPyD_KWm73oOCobg@mail.gmail.com>
 <CAHFUiBM4Tc8mWrNVw15MRELcabcmOwZ1wvy9CnaQd4hw=qHzqA@mail.gmail.com>
 <1491400801.15479.5.camel@tycho.nsa.gov>
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Wed, 5 Apr 2017 09:17:40 -0700
Message-ID: <CAHFUiBPK1NPiHoOunjXL3EFtx4kUC98Ps7Yvh_q1UQokYGgjUA@mail.gmail.com>
Subject: Re: Confining a Java process reading file
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Content-Type: multipart/alternative; boundary=001a114423d84ce56c054c6dbbba
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114423d84ce56c054c6dbbba
Content-Type: text/plain; charset=UTF-8

Thank you for your explanation! Very helpful...
Although I think this means that I need to be in contact with the package
maintainer and this problem won't be solved immediately.

Regards,
Rahmadi

On Wed, Apr 5, 2017 at 7:00 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2017-04-04 at 15:52 -0700, Rahmadi Trimananda wrote:
> > iotuser@raspberrypi:~ $ scanelf -lpqe
> > RWX --- ---  /usr/lib/arm-linux-gnueabihf/libarmmem.so
> > RWX --- ---  /usr/lib/arm-linux-gnueabihf/libmad.so.0.2.1
> > RWX --- ---  /lib/klibc-YL2Pal4e_FwRI58JJ6S97Xf241g.so
> > RWX --- ---  /usr/lib/libopenblas_armv6p-r0.2.12.so
> > RWX --- ---  /usr/bin/penguinspuzzle
>
> Ok, so the runcon binary itself is not the problem (its GNU_STACK is RW
> and has no WE segments), but the above shared objects (and possibly
> others) presently are marked as requiring an executable stack. lddtree
> /usr/bin/runcon will show you which shared objects are used by runcon,
> for example, and it will likely end up including one of these shared
> objects (or another one that is RWX).  This is a problem that you as a
> user cannot fix directly (well, you could try clearing the executable
> stack flag on the offending object via execstack -c, but this may break
> your system if it truly requires an executable stack); it really needs
> to be addressed by the package maintainers for your distribution (i.e.
> identify the offending packages and file bugs).  It is a security risk
> independent of whether you use SELinux itself, and it prevents you from
> fully benefiting from SELinux. A reference that you can provide to the
> package maintainers:
> https://wiki.gentoo.org/wiki/Hardened/GNU_stack_quickstart
>
> It is perhaps also worth noting that your runcon binary (and presumably
> others) is not a Position Independent Executable (PIE) - note the EXEC
> rather than DYN for the ELF file type; this also degrades your security
> independent of whether using SELinux.
>
> Some discussion of PIE among other things:
> https://wiki.gentoo.org/wiki/Hardened/Toolchain
>
> Discussion of text relocations and how to fix, since we also saw
> execmod denials in your avc messages:
> https://wiki.gentoo.org/wiki/Hardened/Textrels_Guide
>
> >
> > On Tue, Apr 4, 2017 at 3:51 PM, Rahmadi Trimananda <rtrimana@uci.edu>
> > wrote:
> > > Alright, this is the output for readelf -l /usr/bin/runcon:
> > >
> > > Elf file type is EXEC (Executable file)
> > > Entry point 0x11c58
> > > There are 9 program headers, starting at offset 52
> > >
> > > Program Headers:
> > >   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg
> > > Align
> > >   EXIDX          0x0054d4 0x000154d4 0x000154d4 0x00008 0x00008 R
> > > 0x4
> > >   PHDR           0x000034 0x00010034 0x00010034 0x00120 0x00120 R E
> > > 0x4
> > >   INTERP         0x000154 0x00010154 0x00010154 0x00019 0x00019 R
> > > 0x1
> > >       [Requesting program interpreter: /lib/ld-linux-armhf.so.3]
> > >   LOAD           0x000000 0x00010000 0x00010000 0x054e0 0x054e0 R E
> > > 0x10000
> > >   LOAD           0x005efc 0x00025efc 0x00025efc 0x00278 0x003ec RW
> > >  0x10000
> > >   DYNAMIC        0x005f08 0x00025f08 0x00025f08 0x000f8 0x000f8 RW
> > >  0x4
> > >   NOTE           0x000170 0x00010170 0x00010170 0x00044 0x00044 R
> > > 0x4
> > >   GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW
> > >  0x10
> > >   GNU_RELRO      0x005efc 0x00025efc 0x00025efc 0x00104 0x00104 R
> > > 0x1
> > >
> > >  Section to Segment mapping:
> > >   Segment Sections...
> > >    00     .ARM.exidx
> > >    01
> > >    02     .interp
> > >    03     .interp .note.ABI-tag .note.gnu.build-id .gnu.hash
> > > .dynsym .dynstr .gnu.version .gnu.version_r .rel.dyn .rel.plt .init
> > > .plt .text .fini .rodata .ARM.exidx .eh_frame
> > >    04     .init_array .fini_array .jcr .dynamic .got .data .bss
> > >    05     .dynamic
> > >    06     .note.ABI-tag .note.gnu.build-id
> > >    07
> > >    08     .init_array .fini_array .jcr .dynamic
> > >
> > > On Tue, Apr 4, 2017 at 12:15 PM, Stephen Smalley <sds@tycho.nsa.gov
> > > > wrote:
> > > > On Tue, 2017-04-04 at 13:54 -0400, Stephen Smalley wrote:
> > > > > On Tue, 2017-04-04 at 10:44 -0700, Rahmadi Trimananda wrote:
> > > > > > This again reflects a problem with the way your userspace was
> > > > > > built.
> > > > > > - Could you please explain what the problem is and how to
> > > > solve
> > > > > > this?
> > > > >
> > > > > Please run readelf -l /usr/bin/runcon and provide the output.
> > > >
> > > > Also, if you have scanelf (from pax-utils), running scanelf -lpqe
> > > > and
> > > > providing the output would be helpful.
> > > >
> > > > >
> > > > > > Umm, then how about generating port labels?
> > > > > > I tried adding a new port to my myapp_t label using
> > > >  "semanage
> > > > > > port",
> > > > > > but it's complaining that myapp_t is not a port label. Need
> > > > your
> > > > > > insights here as well. Thank you!
> > > > >
> > > > > Yes, you would want to define a separate port type.
> > > > > type myapp_port_t;
> > > > > corenet_port(myapp_port_t)
> > > > >
> > > > > Then use myapp_port_t in your semanage port command.
> > > > >
> > > > > >
> > > > > > On Tue, Apr 4, 2017 at 10:17 AM, Stephen Smalley <sds@tycho.n
> > > > sa.gov
> > > > > > >
> > > > > > wrote:
> > > > > > > On Tue, 2017-04-04 at 09:37 -0700, Rahmadi Trimananda
> > > > wrote:
> > > > > > > > Do you mean that we create our own new domain, e.g.
> > > > myapp_t?
> > > > > > > > I tried this and it works for my a.out that reads
> > > > test.txt.
> > > > > > > >
> > > > > > > > I tried runcon as well for the Java version:
> > > > > > > >
> > > > > > > > runcon system_u:object_r:myapp_t:SystemLow java Test
> > > > > > >
> > > > > > > Just runcon -t myapp_t java Test would be simpler, and
> > > > would
> > > > > > > preserve
> > > > > > > your user identity, role, and level.  Processes don't use
> > > > > > > object_r;
> > > > > > > that is only for files/objects.
> > > > > > >
> > > > > > > > The response I got was: runcon: java: Permission denied.
> > > > > > > > In the audit.log I found that runcon is just not
> > > > permitted for
> > > > > > > > everything. Any thoughts?
> > > > > > > >
> > > > > > > > ...
> > > > > > > > type=SYSCALL msg=audit(1491323666.800:4249):
> > > > arch=40000028
> > > > > > >
> > > > > > > syscall=11
> > > > > > > > per=800000 success=no exit=-13 a0=7ec2c140 a1=7ec2c34c
> > > > > > >
> > > > > > > a2=7ec2c35c
> > > > > > > > a3=6e69622f items=0 ppid=989 pid=10629 auid=1001 uid=1001
> > > > > > >
> > > > > > > gid=1001
> > > > > > > > euid=1001 suid=1001 fsuid=1001 egid=1001 sgid=1001
> > > > fsgid=1001
> > > > > > > > tty=pts0 ses=3 comm="runcon" exe="/usr/bin/runcon"
> > > > > > > > subj=unconfined_u:unconfined_r:unconfined_t:s0-
> > > > s0:c0.c1023
> > > > > > >
> > > > > > > key=(null)
> > > > > > > >
> > > > > > > > type=AVC msg=audit(1491323672.070:4255): avc:  denied  {
> > > > > > >
> > > > > > > execstack }
> > > > > > > > for  pid=10631 comm="runcon"
> > > > > > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-
> > > > s0:c0.c1023
> > > > > > > > tcontext=unconfined_u:unconfined_r:unconfined_t:s0-
> > > > s0:c0.c1023
> > > > > > > > tclass=process permissive=0
> > > > > > >
> > > > > > > This again reflects a problem with the way your userspace
> > > > was
> > > > > > > built.
> > > > > > > execstack -q /usr/bin/runcon
> > > > > > > readelf -l /usr/bin/runcon
> > > > > > >
> > > > > > > In the interim, you can allow execstack pervasively via:
> > > > > > > setsebool -P allow_execstack=1
> > > > > > >
> > > > > > > > type=SYSCALL msg=audit(1491323672.070:4255):
> > > > arch=40000028
> > > > > > > > syscall=125 per=800000 success=no exit=-13 a0=7e84c000
> > > > a1=1000
> > > > > > > > a2=1000007 a3=76fb6f18 items=0 ppid=10630 pid=10631
> > > > auid=1001
> > > > > > >
> > > > > > > uid=0
> > > > > > > > gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
> > > > tty=pts0
> > > > > > > > ses=3
> > > > > > > > comm="runcon" exe="/usr/bin/runcon"
> > > > > > > > subj=unconfined_u:unconfined_r:unconfined_t:s0-
> > > > s0:c0.c1023
> > > > > > >
> > > > > > > key=(null)
> > > > > > > >
> > > > > > > > type=AVC msg=audit(1491323672.080:4256): avc:  denied  {
> > > > > > >
> > > > > > > transition }
> > > > > > > > for  pid=10631 comm="runcon" path="/usr/lib/jvm/java-8-
> > > > openjdk-
> > > > > > > > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > > > > > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-
> > > > s0:c0.c1023
> > > > > > > > tcontext=system_u:object_r:myapp_t:s0 tclass=process
> > > > > > > > permissive=0
> > > > > > > >
> > > > > > > > type=SYSCALL msg=audit(1491323672.080:4256):
> > > > arch=40000028
> > > > > > >
> > > > > > > syscall=11
> > > > > > > > per=800000 success=no exit=-13 a0=7e84c5dc a1=7e84c7ec
> > > > > > >
> > > > > > > a2=7e84c7f8
> > > > > > > > a3=6e69622f items=0 ppid=10630 pid=10631 auid=1001 uid=0
> > > > gid=0
> > > > > > >
> > > > > > > euid=0
> > > > > > > > suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3
> > > > > > > > comm="runcon"
> > > > > > > > exe="/usr/bin/runcon"
> > > > > > >
> > > > > > > subj=unconfined_u:unconfined_r:unconfined_t:s0-
> > > > > > > > s0:c0.c1023 key=(null)
> > > > > > > >
> > > > > > > > type=AVC msg=audit(1491323700.770:4269): avc:  denied  {
> > > > > > >
> > > > > > > transition }
> > > > > > > > for  pid=10636 comm="runcon" path="/usr/lib/jvm/java-8-
> > > > openjdk-
> > > > > > > > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > > > > > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-
> > > > s0:c0.c1023
> > > > > > > > tcontext=system_u:object_r:myapp_t:s0 tclass=process
> > > > > > > > permissive=1
> > > > > > > >
> > > > > > > > type=AVC msg=audit(1491323700.770:4269): avc:  denied  {
> > > > > > >
> > > > > > > entrypoint }
> > > > > > > > for  pid=10636 comm="runcon" path="/usr/lib/jvm/java-8-
> > > > openjdk-
> > > > > > > > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > > > > > > > scontext=system_u:object_r:myapp_t:s0
> > > > > > > > tcontext=system_u:object_r:java_exec_t:s0 tclass=file
> > > > > > >
> > > > > > > permissive=1
> > > > > > >
> > > > > > > Add the following to your policy:
> > > > > > > domain_entry_file(myapp_t, java_exec_t)
> > > > > > > spec_domtrans_pattern(unconfined_t, java_exec_t, myapp_t)
> > > > > > >
> > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > >
> > > > > > > > On Tue, Apr 4, 2017 at 9:26 AM, Stephen Smalley <sds@tych
> > > > o.nsa.
> > > > > > > > go
> > > > > > >
> > > > > > > v>
> > > > > > > > wrote:
> > > > > > > > > On Tue, 2017-04-04 at 08:50 -0700, Rahmadi Trimananda
> > > > wrote:
> > > > > > > > > > Hey Guys,
> > > > > > > > > >
> > > > > > > > > > I am trying to confine a Java process that I have so
> > > > that
> > > > > > > > > > it
> > > > > > >
> > > > > > > will
> > > > > > > > > be
> > > > > > > > > > able to read only certain files. This is my
> > > > experiment
> > > > > > > > > > setup
> > > > > > >
> > > > > > > for
> > > > > > > > > my
> > > > > > > > > > folder. Basically a.out (C program) and Test.class
> > > > (Java
> > > > > > >
> > > > > > > class)
> > > > > > > > > are
> > > > > > > > > > coded to read and print out the text in test.txt.
> > > > > > > > > >
> > > > > > > > > >     unconfined_u:object_r:httpd_t:SystemLow a.out
> > > > > > > > > > unconfined_u:object_r:user_home_t:SystemLow test.c
> > > > > > > > > >     unconfined_u:object_r:httpd_t:SystemLow
> > > > Test.class
> > > > > > > > > > unconfined_u:object_r:user_home_t:SystemLow Test.java
> > > > > > > > > > unconfined_u:object_r:user_home_t:SystemLow test.txt
> > > > > > > > > >
> > > > > > > > > > I tried to change the type label for a.out from
> > > > user_home_t
> > > > > > >
> > > > > > > to
> > > > > > > > > > httpd_t just for the sake of the experiment. With
> > > > this
> > > > > > > > > > setup,
> > > > > > > > >
> > > > > > > > > a.out
> > > > > > > > > > is no longer able to read test.txt in enforcing mode.
> > > > > > >
> > > > > > > However, I
> > > > > > > > > seem
> > > > > > > > > > to not be able to do it for Test.class as it's
> > > > running on a
> > > > > > >
> > > > > > > JVM.
> > > > > > > > > The
> > > > > > > > > > java label is "bin_t". And I checked using this:
> > > > > > > > > >
> > > > > > > > > > sesearch -s bin_t -t user_home_t -c file -p read -Ad
> > > > > > > > > >
> > > > > > > > > > And it doesn't seem to have a rule that allows bin_t
> > > > to
> > > > > > > > > > read
> > > > > > >
> > > > > > > a
> > > > > > > > > file
> > > > > > > > > > with user_home_t label.
> > > > > > > > > >
> > > > > > > > > > What's the right way to do this if any? Then, I also
> > > > try to
> > > > > > > > >
> > > > > > > > > confine
> > > > > > > > > > port accesses for Test.class, e.g. I only allow it to
> > > > > > > > > > access
> > > > > > > > >
> > > > > > > > > ports
> > > > > > > > > > 1234 and 2345. Same question, what's the right way to
> > > > do
> > > > > > >
> > > > > > > this?
> > > > > > > > >
> > > > > > > > > I think you are conflating file labels with process
> > > > labels.
> > > > > > >
> > > > > > > The
> > > > > > > > > /usr/sbin/httpd file is labeled with the httpd_exec_t
> > > > type;
> > > > > > > > > the
> > > > > > > > > running
> > > > > > > > > httpd process runs in the httpd_t domain (to be
> > > > precise,
> > > > > > > > > init_t
> > > > > > > > > transitions to httpd_t upon executing httpd_exec_t).
> > > > bin_t
> > > > > > > > > is
> > > > > > >
> > > > > > > just
> > > > > > > > > a
> > > > > > > > > generally executable file type that doesn't cause a
> > > > domain
> > > > > > > > > transition
> > > > > > > > > (as no domain transition is defined in policy on it),
> > > > so a
> > > > > > >
> > > > > > > process
> > > > > > > > > that
> > > > > > > > > execs a bin_t file will just stay in its domain.  You
> > > > want to
> > > > > > > > > create a
> > > > > > > > > new domain and run your program in that; if you are
> > > > running
> > > > > > > > > it
> > > > > > > > > through
> > > > > > > > > an interpreter, then you can force it into the target
> > > > domain
> > > > > > >
> > > > > > > via
> > > > > > > > > runcon.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Kind regards,
> > > > > > > > Rahmadi Trimananda
> > > > > > > >
> > > > > > > > Ph.D. student @ University of California, Irvine
> > > > > > > > "Stay hungry, stay foolish!" - Steve Jobs -
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Kind regards,
> > > > > > Rahmadi Trimananda
> > > > > >
> > > > > > Ph.D. student @ University of California, Irvine
> > > > > > "Stay hungry, stay foolish!" - Steve Jobs -
> > > >
> > >
> > >
> > >
> > > --
> > > Kind regards,
> > > Rahmadi Trimananda
> > >
> > > Ph.D. student @ University of California, Irvine
> > > "Stay hungry, stay foolish!" - Steve Jobs -
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

--001a114423d84ce56c054c6dbbba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for your explanation! Very helpful...=C2=A0<div>=
Although I think this means that I need to be in contact with the package m=
aintainer and this problem won&#39;t be solved immediately.</div><div><br><=
/div><div>Regards,</div><div>Rahmadi</div></div><div class=3D"gmail_extra">=
<br><div class=3D"gmail_quote">On Wed, Apr 5, 2017 at 7:00 AM, Stephen Smal=
ley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_b=
lank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><span class=3D"">On Tue, 2017-04-04 at 15:52 -0700, Rahmadi Trimananda=
 wrote:<br>
&gt; iotuser@raspberrypi:~ $ scanelf -lpqe<br>
&gt; RWX --- --- =C2=A0/usr/lib/arm-linux-gnueabihf/<wbr>libarmmem.so<br>
&gt; RWX --- --- =C2=A0/usr/lib/arm-linux-gnueabihf/<wbr>libmad.so.0.2.1<br=
>
&gt; RWX --- --- =C2=A0/lib/klibc-YL2Pal4e_<wbr>FwRI58JJ6S97Xf241g.so<br>
&gt; RWX --- --- =C2=A0/usr/lib/<a href=3D"http://libopenblas_armv6p-r0.2.1=
2.so" rel=3D"noreferrer" target=3D"_blank">libopenblas_armv6p-<wbr>r0.2.12.=
so</a><br>
&gt; RWX --- --- =C2=A0/usr/bin/penguinspuzzle<br>
<br>
</span>Ok, so the runcon binary itself is not the problem (its GNU_STACK is=
 RW<br>
and has no WE segments), but the above shared objects (and possibly<br>
others) presently are marked as requiring an executable stack. lddtree<br>
/usr/bin/runcon will show you which shared objects are used by runcon,<br>
for example, and it will likely end up including one of these shared<br>
objects (or another one that is RWX).=C2=A0 This is a problem that you as a=
<br>
user cannot fix directly (well, you could try clearing the executable<br>
stack flag on the offending object via execstack -c, but this may break<br>
your system if it truly requires an executable stack); it really needs<br>
to be addressed by the package maintainers for your distribution (i.e.<br>
identify the offending packages and file bugs).=C2=A0 It is a security risk=
<br>
independent of whether you use SELinux itself, and it prevents you from<br>
fully benefiting from SELinux. A reference that you can provide to the<br>
package maintainers:<br>
<a href=3D"https://wiki.gentoo.org/wiki/Hardened/GNU_stack_quickstart" rel=
=3D"noreferrer" target=3D"_blank">https://wiki.gentoo.org/wiki/<wbr>Hardene=
d/GNU_stack_quickstart</a><br>
<br>
It is perhaps also worth noting that your runcon binary (and presumably<br>
others) is not=C2=A0a Position Independent Executable (PIE) - note the EXEC=
<br>
rather than DYN for the ELF file type; this also degrades your security<br>
independent of whether using SELinux.<br>
<br>
Some discussion of PIE among other things:<br>
<a href=3D"https://wiki.gentoo.org/wiki/Hardened/Toolchain" rel=3D"noreferr=
er" target=3D"_blank">https://wiki.gentoo.org/wiki/<wbr>Hardened/Toolchain<=
/a><br>
<br>
Discussion of text relocations and how to fix, since we also saw<br>
execmod denials in your avc messages:<br>
<a href=3D"https://wiki.gentoo.org/wiki/Hardened/Textrels_Guide" rel=3D"nor=
eferrer" target=3D"_blank">https://wiki.gentoo.org/wiki/<wbr>Hardened/Textr=
els_Guide</a><br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt; On Tue, Apr 4, 2017 at 3:51 PM, Rahmadi Trimananda &lt;<a href=3D"mail=
to:rtrimana@uci.edu">rtrimana@uci.edu</a>&gt;<br>
&gt; wrote:<br>
&gt; &gt; Alright, this is the output for readelf -l /usr/bin/runcon:<br>
&gt; &gt;<br>
&gt; &gt; Elf file type is EXEC (Executable file)<br>
&gt; &gt; Entry point 0x11c58<br>
&gt; &gt; There are 9 program headers, starting at offset 52<br>
&gt; &gt;<br>
&gt; &gt; Program Headers:<br>
&gt; &gt; =C2=A0 Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Offset =C2=A0 Virt=
Addr =C2=A0 PhysAddr =C2=A0 FileSiz MemSiz =C2=A0Flg<br>
&gt; &gt; Align<br>
&gt; &gt; =C2=A0 EXIDX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0054d4 0x000154d=
4 0x000154d4 0x00008 0x00008 R =C2=A0<br>
&gt; &gt; 0x4<br>
&gt; &gt; =C2=A0 PHDR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000034 0x0001003=
4 0x00010034 0x00120 0x00120 R E<br>
&gt; &gt; 0x4<br>
&gt; &gt; =C2=A0 INTERP =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000154 0x00010154 0x0=
0010154 0x00019 0x00019 R =C2=A0<br>
&gt; &gt; 0x1<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 [Requesting program interpreter: /lib/ld-lin=
ux-armhf.so.3]<br>
&gt; &gt; =C2=A0 LOAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000000 0x0001000=
0 0x00010000 0x054e0 0x054e0 R E<br>
&gt; &gt; 0x10000<br>
&gt; &gt; =C2=A0 LOAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x005efc 0x00025ef=
c 0x00025efc 0x00278 0x003ec RW<br>
&gt; &gt; =C2=A00x10000<br>
&gt; &gt; =C2=A0 DYNAMIC =C2=A0 =C2=A0 =C2=A0 =C2=A00x005f08 0x00025f08 0x0=
0025f08 0x000f8 0x000f8 RW<br>
&gt; &gt; =C2=A00x4<br>
&gt; &gt; =C2=A0 NOTE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000170 0x0001017=
0 0x00010170 0x00044 0x00044 R =C2=A0<br>
&gt; &gt; 0x4<br>
&gt; &gt; =C2=A0 GNU_STACK =C2=A0 =C2=A0 =C2=A00x000000 0x00000000 0x000000=
00 0x00000 0x00000 RW<br>
&gt; &gt; =C2=A00x10<br>
&gt; &gt; =C2=A0 GNU_RELRO =C2=A0 =C2=A0 =C2=A00x005efc 0x00025efc 0x00025e=
fc 0x00104 0x00104 R =C2=A0<br>
&gt; &gt; 0x1<br>
&gt; &gt;<br>
&gt; &gt; =C2=A0Section to Segment mapping:<br>
&gt; &gt; =C2=A0 Segment Sections...<br>
&gt; &gt; =C2=A0 =C2=A000 =C2=A0 =C2=A0 .ARM.exidx=C2=A0<br>
&gt; &gt; =C2=A0 =C2=A001 =C2=A0 =C2=A0=C2=A0<br>
&gt; &gt; =C2=A0 =C2=A002 =C2=A0 =C2=A0 .interp=C2=A0<br>
&gt; &gt; =C2=A0 =C2=A003 =C2=A0 =C2=A0 .interp .note.ABI-tag .note.gnu.bui=
ld-id .gnu.hash<br>
&gt; &gt; .dynsym .dynstr .gnu.version .gnu.version_r .rel.dyn .rel.plt .in=
it<br>
&gt; &gt; .plt .text .fini .rodata .ARM.exidx .eh_frame=C2=A0<br>
&gt; &gt; =C2=A0 =C2=A004 =C2=A0 =C2=A0 .init_array .fini_array .jcr .dynam=
ic .got .data .bss=C2=A0<br>
&gt; &gt; =C2=A0 =C2=A005 =C2=A0 =C2=A0 .dynamic=C2=A0<br>
&gt; &gt; =C2=A0 =C2=A006 =C2=A0 =C2=A0 .note.ABI-tag .note.gnu.build-id=C2=
=A0<br>
&gt; &gt; =C2=A0 =C2=A007 =C2=A0 =C2=A0=C2=A0<br>
&gt; &gt; =C2=A0 =C2=A008 =C2=A0 =C2=A0 .init_array .fini_array .jcr .dynam=
ic<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Apr 4, 2017 at 12:15 PM, Stephen Smalley &lt;<a href=3D"m=
ailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a><br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; On Tue, 2017-04-04 at 13:54 -0400, Stephen Smalley wrote:<br=
>
&gt; &gt; &gt; &gt; On Tue, 2017-04-04 at 10:44 -0700, Rahmadi Trimananda w=
rote:<br>
&gt; &gt; &gt; &gt; &gt; This again reflects a problem with the way your us=
erspace was<br>
&gt; &gt; &gt; &gt; &gt; built.<br>
&gt; &gt; &gt; &gt; &gt; - Could you please explain what the problem is and=
 how to<br>
&gt; &gt; &gt; solve<br>
&gt; &gt; &gt; &gt; &gt; this?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Please run readelf -l /usr/bin/runcon and provide the o=
utput.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Also, if you have scanelf (from pax-utils), running scanelf =
-lpqe<br>
&gt; &gt; &gt; and<br>
&gt; &gt; &gt; providing the output would be helpful.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Umm, then how about generating port labels?<br>
&gt; &gt; &gt; &gt; &gt; I tried adding a new port to my myapp_t label usin=
g<br>
&gt; &gt; &gt; =C2=A0&quot;semanage<br>
&gt; &gt; &gt; &gt; &gt; port&quot;,<br>
&gt; &gt; &gt; &gt; &gt; but it&#39;s complaining that myapp_t is not a por=
t label. Need<br>
&gt; &gt; &gt; your<br>
&gt; &gt; &gt; &gt; &gt; insights here as well. Thank you!<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Yes, you would want to define a separate port type.<br>
&gt; &gt; &gt; &gt; type myapp_port_t;<br>
&gt; &gt; &gt; &gt; corenet_port(myapp_port_t)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Then use myapp_port_t in your semanage port command.<br=
>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Tue, Apr 4, 2017 at 10:17 AM, Stephen Smalley &=
lt;sds@tycho.n<br>
&gt; &gt; &gt; <a href=3D"http://sa.gov" rel=3D"noreferrer" target=3D"_blan=
k">sa.gov</a><br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Tue, 2017-04-04 at 09:37 -0700, Rahmadi Tr=
imananda<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Do you mean that we create our own new d=
omain, e.g.<br>
&gt; &gt; &gt; myapp_t?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; I tried this and it works for my a.out t=
hat reads<br>
&gt; &gt; &gt; test.txt.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; I tried runcon as well for the Java vers=
ion:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; runcon system_u:object_r:myapp_t:<wbr>Sy=
stemLow java Test<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Just runcon -t myapp_t java Test would be sim=
pler, and<br>
&gt; &gt; &gt; would<br>
&gt; &gt; &gt; &gt; &gt; &gt; preserve<br>
&gt; &gt; &gt; &gt; &gt; &gt; your user identity, role, and level.=C2=A0 Pr=
ocesses don&#39;t use<br>
&gt; &gt; &gt; &gt; &gt; &gt; object_r;<br>
&gt; &gt; &gt; &gt; &gt; &gt; that is only for files/objects.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; The response I got was:=C2=A0runcon: jav=
a: Permission denied.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; In the audit.log I found that runcon is =
just not<br>
&gt; &gt; &gt; permitted for<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; everything. Any thoughts?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; ...<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; type=3DSYSCALL msg=3Daudit(1491323666.80=
0:4249)<wbr>:<br>
&gt; &gt; &gt; arch=3D40000028<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; syscall=3D11<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; per=3D800000 success=3Dno exit=3D-13 a0=
=3D7ec2c140 a1=3D7ec2c34c<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; a2=3D7ec2c35c<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; a3=3D6e69622f items=3D0 ppid=3D989 pid=
=3D10629 auid=3D1001 uid=3D1001<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; gid=3D1001<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; euid=3D1001 suid=3D1001 fsuid=3D1001 egi=
d=3D1001 sgid=3D1001<br>
&gt; &gt; &gt; fsgid=3D1001<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; tty=3Dpts0 ses=3D3 comm=3D&quot;runcon&q=
uot; exe=3D&quot;/usr/bin/runcon&quot;<br>
</div></div><span class=3D"">&gt; &gt; &gt; &gt; &gt; &gt; &gt; subj=3Dunco=
nfined_u:unconfined_<wbr>r:unconfined_t:s0-<br>
&gt; &gt; &gt; s0:c0.c1023<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; key=3D(null)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
</span><span class=3D"">&gt; &gt; &gt; &gt; &gt; &gt; &gt; type=3DAVC msg=
=3Daudit(1491323672.070:4255)<wbr>: avc: =C2=A0denied =C2=A0{<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; execstack }<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; for =C2=A0pid=3D10631 comm=3D&quot;runco=
n&quot;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; scontext=3Dunconfined_u:<wbr>unconfined_=
r:unconfined_t:s0-<br>
&gt; &gt; &gt; s0:c0.c1023<br>
</span>&gt; &gt; &gt; &gt; &gt; &gt; &gt; tcontext=3Dunconfined_u:<wbr>unco=
nfined_r:unconfined_t:s0-<br>
&gt; &gt; &gt; s0:c0.c1023<br>
<span class=3D"im HOEnZb">&gt; &gt; &gt; &gt; &gt; &gt; &gt; tclass=3Dproce=
ss permissive=3D0<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; This again reflects a problem with the way yo=
ur userspace<br>
&gt; &gt; &gt; was<br>
&gt; &gt; &gt; &gt; &gt; &gt; built.<br>
&gt; &gt; &gt; &gt; &gt; &gt; execstack -q /usr/bin/runcon<br>
&gt; &gt; &gt; &gt; &gt; &gt; readelf -l /usr/bin/runcon<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; In the interim, you can allow execstack perva=
sively via:<br>
&gt; &gt; &gt; &gt; &gt; &gt; setsebool -P allow_execstack=3D1<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; type=3DSYSCALL msg=3Daudit(1491323672.07=
0:4255)<wbr>:<br>
&gt; &gt; &gt; arch=3D40000028<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; syscall=3D125 per=3D800000 success=3Dno =
exit=3D-13 a0=3D7e84c000<br>
&gt; &gt; &gt; a1=3D1000<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; a2=3D1000007 a3=3D76fb6f18 items=3D0 ppi=
d=3D10630 pid=3D10631<br>
&gt; &gt; &gt; auid=3D1001<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; uid=3D0<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=
=3D0 sgid=3D0 fsgid=3D0<br>
&gt; &gt; &gt; tty=3Dpts0<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; ses=3D3<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; comm=3D&quot;runcon&quot; exe=3D&quot;/u=
sr/bin/runcon&quot;<br>
</span><span class=3D"im HOEnZb">&gt; &gt; &gt; &gt; &gt; &gt; &gt; subj=3D=
unconfined_u:unconfined_<wbr>r:unconfined_t:s0-<br>
&gt; &gt; &gt; s0:c0.c1023<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; key=3D(null)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
</span><div class=3D"HOEnZb"><div class=3D"h5">&gt; &gt; &gt; &gt; &gt; &gt=
; &gt; type=3DAVC msg=3Daudit(1491323672.080:4256)<wbr>: avc: =C2=A0denied =
=C2=A0{<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; transition }<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; for =C2=A0pid=3D10631 comm=3D&quot;runco=
n&quot; path=3D&quot;/usr/lib/jvm/java-8-<br>
&gt; &gt; &gt; openjdk-<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; armhf/jre/bin/java&quot; dev=3D&quot;mmc=
blk0p2&quot; ino=3D524520<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; scontext=3Dunconfined_u:<wbr>unconfined_=
r:unconfined_t:s0-<br>
&gt; &gt; &gt; s0:c0.c1023<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; tcontext=3Dsystem_u:object_r:<wbr>myapp_=
t:s0 tclass=3Dprocess<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; permissive=3D0<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; type=3DSYSCALL msg=3Daudit(1491323672.08=
0:4256)<wbr>:<br>
&gt; &gt; &gt; arch=3D40000028<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; syscall=3D11<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; per=3D800000 success=3Dno exit=3D-13 a0=
=3D7e84c5dc a1=3D7e84c7ec<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; a2=3D7e84c7f8<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; a3=3D6e69622f items=3D0 ppid=3D10630 pid=
=3D10631 auid=3D1001 uid=3D0<br>
&gt; &gt; &gt; gid=3D0<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; euid=3D0<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsg=
id=3D0 tty=3Dpts0 ses=3D3<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; comm=3D&quot;runcon&quot;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; exe=3D&quot;/usr/bin/runcon&quot;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; subj=3Dunconfined_u:unconfined_<wbr>r:unconfi=
ned_t:s0-<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; s0:c0.c1023 key=3D(null)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; type=3DAVC msg=3Daudit(1491323700.770:42=
69)<wbr>: avc: =C2=A0denied =C2=A0{<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; transition }<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; for =C2=A0pid=3D10636 comm=3D&quot;runco=
n&quot; path=3D&quot;/usr/lib/jvm/java-8-<br>
&gt; &gt; &gt; openjdk-<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; armhf/jre/bin/java&quot; dev=3D&quot;mmc=
blk0p2&quot; ino=3D524520<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; scontext=3Dunconfined_u:<wbr>unconfined_=
r:unconfined_t:s0-<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">&gt; &gt; &gt; s0:c0.c1=
023<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; tcontext=3Dsystem_u:object_r:<wbr>myapp_=
t:s0 tclass=3Dprocess<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; permissive=3D1<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; type=3DAVC msg=3Daudit(1491323700.770:42=
69)<wbr>: avc: =C2=A0denied =C2=A0{<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; entrypoint }<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; for =C2=A0pid=3D10636 comm=3D&quot;runco=
n&quot; path=3D&quot;/usr/lib/jvm/java-8-<br>
&gt; &gt; &gt; openjdk-<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; armhf/jre/bin/java&quot; dev=3D&quot;mmc=
blk0p2&quot; ino=3D524520<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; scontext=3Dsystem_u:object_r:<wbr>myapp_=
t:s0<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; tcontext=3Dsystem_u:object_r:<wbr>java_e=
xec_t:s0 tclass=3Dfile<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; permissive=3D1<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Add the following to your policy:<br>
&gt; &gt; &gt; &gt; &gt; &gt; domain_entry_file(myapp_t, java_exec_t)<br>
&gt; &gt; &gt; &gt; &gt; &gt; spec_domtrans_pattern(<wbr>unconfined_t, java=
_exec_t, myapp_t)<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; ...<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; On Tue, Apr 4, 2017 at 9:26 AM, Stephen =
Smalley &lt;sds@tych<br>
&gt; &gt; &gt; o.nsa.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; go<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; v&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; On Tue, 2017-04-04 at 08:50 -0700, =
Rahmadi Trimananda<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Hey Guys,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I am trying to confine a Java =
process that I have so<br>
&gt; &gt; &gt; that<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; it<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; will<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; be<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; able to read only certain file=
s. This is my<br>
&gt; &gt; &gt; experiment<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; setup<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; for<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; my<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; folder. Basically a.out (C pro=
gram) and Test.class<br>
&gt; &gt; &gt; (Java<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; class)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; are<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; coded to read and print out th=
e text in test.txt.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 unconfined_u:obj=
ect_r:httpd_t:<wbr>SystemLow a.out<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; unconfined_u:object_r:user_<wb=
r>home_t:SystemLow test.c<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 unconfined_u:obj=
ect_r:httpd_t:<wbr>SystemLow<br>
&gt; &gt; &gt; Test.class<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; unconfined_u:object_r:user_<wb=
r>home_t:SystemLow Test.java<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; unconfined_u:object_r:user_<wb=
r>home_t:SystemLow test.txt<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I tried to change the type lab=
el for a.out from<br>
&gt; &gt; &gt; user_home_t<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; httpd_t just for the sake of t=
he experiment. With<br>
&gt; &gt; &gt; this<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; setup,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; a.out<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; is no longer able to read test=
.txt in enforcing mode.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; However, I<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; seem<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; to not be able to do it for Te=
st.class as it&#39;s<br>
&gt; &gt; &gt; running on a<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; JVM.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; The<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; java label is &quot;bin_t&quot=
;. And I checked using this:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; sesearch -s bin_t -t user_home=
_t -c file -p read -Ad<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; And it doesn&#39;t seem to hav=
e a rule that allows bin_t<br>
&gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; read<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; a<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; file<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; with user_home_t label.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; What&#39;s the right way to do=
 this if any? Then, I also<br>
&gt; &gt; &gt; try to<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; confine<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; port accesses for Test.class, =
e.g. I only allow it to<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; access<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; ports<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; 1234 and 2345. Same question, =
what&#39;s the right way to<br>
&gt; &gt; &gt; do<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; this?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I think you are conflating file lab=
els with process<br>
&gt; &gt; &gt; labels.=C2=A0<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; The<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; /usr/sbin/httpd file is labeled wit=
h the httpd_exec_t<br>
&gt; &gt; &gt; type;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; the<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; running<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; httpd process runs in the httpd_t d=
omain (to be<br>
&gt; &gt; &gt; precise,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; init_t<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; transitions to httpd_t upon executi=
ng httpd_exec_t).=C2=A0<br>
&gt; &gt; &gt; bin_t<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; is<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; just<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; a<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; generally executable file type that=
 doesn&#39;t cause a<br>
&gt; &gt; &gt; domain<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; transition<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; (as no domain transition is defined=
 in policy on it),<br>
&gt; &gt; &gt; so a<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; process<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; that<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; execs a bin_t file will just stay i=
n its domain.=C2=A0 You<br>
&gt; &gt; &gt; want to<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; create a<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; new domain and run your program in =
that; if you are<br>
&gt; &gt; &gt; running<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; it<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; through<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; an interpreter, then you can force =
it into the target<br>
&gt; &gt; &gt; domain<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; via<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; runcon.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; --=C2=A0<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Kind regards,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Rahmadi Trimananda<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Ph.D. student @ University of California=
, Irvine<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &quot;Stay hungry, stay foolish!&quot; -=
 Steve Jobs -<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; --=C2=A0<br>
&gt; &gt; &gt; &gt; &gt; Kind regards,<br>
&gt; &gt; &gt; &gt; &gt; Rahmadi Trimananda<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Ph.D. student @ University of California, Irvine<b=
r>
&gt; &gt; &gt; &gt; &gt; &quot;Stay hungry, stay foolish!&quot; - Steve Job=
s -<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --=C2=A0<br>
&gt; &gt; Kind regards,<br>
&gt; &gt; Rahmadi Trimananda<br>
&gt; &gt;<br>
&gt; &gt; Ph.D. student @ University of California, Irvine<br>
&gt; &gt; &quot;Stay hungry, stay foolish!&quot; - Steve Jobs -<br>
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

--001a114423d84ce56c054c6dbbba--
