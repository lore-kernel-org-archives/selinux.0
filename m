Message-ID: <1491400801.15479.5.camel@tycho.nsa.gov>
Subject: Re: Confining a Java process reading file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rahmadi Trimananda <rtrimana@uci.edu>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Date: Wed, 05 Apr 2017 10:00:01 -0400
In-Reply-To: <CAHFUiBM4Tc8mWrNVw15MRELcabcmOwZ1wvy9CnaQd4hw=qHzqA@mail.gmail.com>
References: <CAHFUiBNUTOaOYVch=MJPz6c_Stx_B_rmMA-FjMVcneiWouGKOw@mail.gmail.com>
 <1491323167.31785.14.camel@tycho.nsa.gov>
 <CAHFUiBPfTCsPTmKTOuRdRNp8Z1cSCiUj6D1QY0LpyPQ5M-a4Vw@mail.gmail.com>
 <1491326251.31785.17.camel@tycho.nsa.gov>
 <CAHFUiBNFpt0V_X5V+gu=28WPNwz3DR2iJDDDrRtX2+rWv+WRdw@mail.gmail.com>
 <1491328445.31785.22.camel@tycho.nsa.gov>
 <1491333342.31785.25.camel@tycho.nsa.gov>
 <CAHFUiBPLVxZMQtoD8TiAifR-guW3CsVk43GPyD_KWm73oOCobg@mail.gmail.com>
 <CAHFUiBM4Tc8mWrNVw15MRELcabcmOwZ1wvy9CnaQd4hw=qHzqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-04-04 at 15:52 -0700, Rahmadi Trimananda wrote:
> iotuser@raspberrypi:~ $ scanelf -lpqe
> RWX --- ---  /usr/lib/arm-linux-gnueabihf/libarmmem.so
> RWX --- ---  /usr/lib/arm-linux-gnueabihf/libmad.so.0.2.1
> RWX --- ---  /lib/klibc-YL2Pal4e_FwRI58JJ6S97Xf241g.so
> RWX --- ---  /usr/lib/libopenblas_armv6p-r0.2.12.so
> RWX --- ---  /usr/bin/penguinspuzzle

Ok, so the runcon binary itself is not the problem (its GNU_STACK is RW
and has no WE segments), but the above shared objects (and possibly
others) presently are marked as requiring an executable stack. lddtree
/usr/bin/runcon will show you which shared objects are used by runcon,
for example, and it will likely end up including one of these shared
objects (or another one that is RWX).  This is a problem that you as a
user cannot fix directly (well, you could try clearing the executable
stack flag on the offending object via execstack -c, but this may break
your system if it truly requires an executable stack); it really needs
to be addressed by the package maintainers for your distribution (i.e.
identify the offending packages and file bugs).  It is a security risk
independent of whether you use SELinux itself, and it prevents you from
fully benefiting from SELinux. A reference that you can provide to the
package maintainers:
https://wiki.gentoo.org/wiki/Hardened/GNU_stack_quickstart

It is perhaps also worth noting that your runcon binary (and presumably
others) is not a Position Independent Executable (PIE) - note the EXEC
rather than DYN for the ELF file type; this also degrades your security
independent of whether using SELinux.

Some discussion of PIE among other things:
https://wiki.gentoo.org/wiki/Hardened/Toolchain

Discussion of text relocations and how to fix, since we also saw
execmod denials in your avc messages:
https://wiki.gentoo.org/wiki/Hardened/Textrels_Guide

> 
> On Tue, Apr 4, 2017 at 3:51 PM, Rahmadi Trimananda <rtrimana@uci.edu>
> wrote:
> > Alright, this is the output for readelf -l /usr/bin/runcon:
> > 
> > Elf file type is EXEC (Executable file)
> > Entry point 0x11c58
> > There are 9 program headers, starting at offset 52
> > 
> > Program Headers:
> >   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg
> > Align
> >   EXIDX          0x0054d4 0x000154d4 0x000154d4 0x00008 0x00008 R  
> > 0x4
> >   PHDR           0x000034 0x00010034 0x00010034 0x00120 0x00120 R E
> > 0x4
> >   INTERP         0x000154 0x00010154 0x00010154 0x00019 0x00019 R  
> > 0x1
> >       [Requesting program interpreter: /lib/ld-linux-armhf.so.3]
> >   LOAD           0x000000 0x00010000 0x00010000 0x054e0 0x054e0 R E
> > 0x10000
> >   LOAD           0x005efc 0x00025efc 0x00025efc 0x00278 0x003ec RW
> >  0x10000
> >   DYNAMIC        0x005f08 0x00025f08 0x00025f08 0x000f8 0x000f8 RW
> >  0x4
> >   NOTE           0x000170 0x00010170 0x00010170 0x00044 0x00044 R  
> > 0x4
> >   GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW
> >  0x10
> >   GNU_RELRO      0x005efc 0x00025efc 0x00025efc 0x00104 0x00104 R  
> > 0x1
> > 
> >  Section to Segment mapping:
> >   Segment Sections...
> >    00     .ARM.exidx 
> >    01     
> >    02     .interp 
> >    03     .interp .note.ABI-tag .note.gnu.build-id .gnu.hash
> > .dynsym .dynstr .gnu.version .gnu.version_r .rel.dyn .rel.plt .init
> > .plt .text .fini .rodata .ARM.exidx .eh_frame 
> >    04     .init_array .fini_array .jcr .dynamic .got .data .bss 
> >    05     .dynamic 
> >    06     .note.ABI-tag .note.gnu.build-id 
> >    07     
> >    08     .init_array .fini_array .jcr .dynamic
> > 
> > On Tue, Apr 4, 2017 at 12:15 PM, Stephen Smalley <sds@tycho.nsa.gov
> > > wrote:
> > > On Tue, 2017-04-04 at 13:54 -0400, Stephen Smalley wrote:
> > > > On Tue, 2017-04-04 at 10:44 -0700, Rahmadi Trimananda wrote:
> > > > > This again reflects a problem with the way your userspace was
> > > > > built.
> > > > > - Could you please explain what the problem is and how to
> > > solve
> > > > > this?
> > > >
> > > > Please run readelf -l /usr/bin/runcon and provide the output.
> > > 
> > > Also, if you have scanelf (from pax-utils), running scanelf -lpqe
> > > and
> > > providing the output would be helpful.
> > > 
> > > >
> > > > > Umm, then how about generating port labels?
> > > > > I tried adding a new port to my myapp_t label using
> > >  "semanage
> > > > > port",
> > > > > but it's complaining that myapp_t is not a port label. Need
> > > your
> > > > > insights here as well. Thank you!
> > > >
> > > > Yes, you would want to define a separate port type.
> > > > type myapp_port_t;
> > > > corenet_port(myapp_port_t)
> > > >
> > > > Then use myapp_port_t in your semanage port command.
> > > >
> > > > >
> > > > > On Tue, Apr 4, 2017 at 10:17 AM, Stephen Smalley <sds@tycho.n
> > > sa.gov
> > > > > >
> > > > > wrote:
> > > > > > On Tue, 2017-04-04 at 09:37 -0700, Rahmadi Trimananda
> > > wrote:
> > > > > > > Do you mean that we create our own new domain, e.g.
> > > myapp_t?
> > > > > > > I tried this and it works for my a.out that reads
> > > test.txt.
> > > > > > >
> > > > > > > I tried runcon as well for the Java version:
> > > > > > >
> > > > > > > runcon system_u:object_r:myapp_t:SystemLow java Test
> > > > > >
> > > > > > Just runcon -t myapp_t java Test would be simpler, and
> > > would
> > > > > > preserve
> > > > > > your user identity, role, and level.  Processes don't use
> > > > > > object_r;
> > > > > > that is only for files/objects.
> > > > > >
> > > > > > > The response I got was: runcon: java: Permission denied.
> > > > > > > In the audit.log I found that runcon is just not
> > > permitted for
> > > > > > > everything. Any thoughts?
> > > > > > >
> > > > > > > ...
> > > > > > > type=SYSCALL msg=audit(1491323666.800:4249):
> > > arch=40000028
> > > > > >
> > > > > > syscall=11
> > > > > > > per=800000 success=no exit=-13 a0=7ec2c140 a1=7ec2c34c
> > > > > >
> > > > > > a2=7ec2c35c
> > > > > > > a3=6e69622f items=0 ppid=989 pid=10629 auid=1001 uid=1001
> > > > > >
> > > > > > gid=1001
> > > > > > > euid=1001 suid=1001 fsuid=1001 egid=1001 sgid=1001
> > > fsgid=1001
> > > > > > > tty=pts0 ses=3 comm="runcon" exe="/usr/bin/runcon"
> > > > > > > subj=unconfined_u:unconfined_r:unconfined_t:s0-
> > > s0:c0.c1023
> > > > > >
> > > > > > key=(null)
> > > > > > >
> > > > > > > type=AVC msg=audit(1491323672.070:4255): avc:  denied  {
> > > > > >
> > > > > > execstack }
> > > > > > > for  pid=10631 comm="runcon"
> > > > > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-
> > > s0:c0.c1023
> > > > > > > tcontext=unconfined_u:unconfined_r:unconfined_t:s0-
> > > s0:c0.c1023
> > > > > > > tclass=process permissive=0
> > > > > >
> > > > > > This again reflects a problem with the way your userspace
> > > was
> > > > > > built.
> > > > > > execstack -q /usr/bin/runcon
> > > > > > readelf -l /usr/bin/runcon
> > > > > >
> > > > > > In the interim, you can allow execstack pervasively via:
> > > > > > setsebool -P allow_execstack=1
> > > > > >
> > > > > > > type=SYSCALL msg=audit(1491323672.070:4255):
> > > arch=40000028
> > > > > > > syscall=125 per=800000 success=no exit=-13 a0=7e84c000
> > > a1=1000
> > > > > > > a2=1000007 a3=76fb6f18 items=0 ppid=10630 pid=10631
> > > auid=1001
> > > > > >
> > > > > > uid=0
> > > > > > > gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
> > > tty=pts0
> > > > > > > ses=3
> > > > > > > comm="runcon" exe="/usr/bin/runcon"
> > > > > > > subj=unconfined_u:unconfined_r:unconfined_t:s0-
> > > s0:c0.c1023
> > > > > >
> > > > > > key=(null)
> > > > > > >
> > > > > > > type=AVC msg=audit(1491323672.080:4256): avc:  denied  {
> > > > > >
> > > > > > transition }
> > > > > > > for  pid=10631 comm="runcon" path="/usr/lib/jvm/java-8-
> > > openjdk-
> > > > > > > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > > > > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-
> > > s0:c0.c1023
> > > > > > > tcontext=system_u:object_r:myapp_t:s0 tclass=process
> > > > > > > permissive=0
> > > > > > >
> > > > > > > type=SYSCALL msg=audit(1491323672.080:4256):
> > > arch=40000028
> > > > > >
> > > > > > syscall=11
> > > > > > > per=800000 success=no exit=-13 a0=7e84c5dc a1=7e84c7ec
> > > > > >
> > > > > > a2=7e84c7f8
> > > > > > > a3=6e69622f items=0 ppid=10630 pid=10631 auid=1001 uid=0
> > > gid=0
> > > > > >
> > > > > > euid=0
> > > > > > > suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3
> > > > > > > comm="runcon"
> > > > > > > exe="/usr/bin/runcon"
> > > > > >
> > > > > > subj=unconfined_u:unconfined_r:unconfined_t:s0-
> > > > > > > s0:c0.c1023 key=(null)
> > > > > > >
> > > > > > > type=AVC msg=audit(1491323700.770:4269): avc:  denied  {
> > > > > >
> > > > > > transition }
> > > > > > > for  pid=10636 comm="runcon" path="/usr/lib/jvm/java-8-
> > > openjdk-
> > > > > > > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > > > > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-
> > > s0:c0.c1023
> > > > > > > tcontext=system_u:object_r:myapp_t:s0 tclass=process
> > > > > > > permissive=1
> > > > > > >
> > > > > > > type=AVC msg=audit(1491323700.770:4269): avc:  denied  {
> > > > > >
> > > > > > entrypoint }
> > > > > > > for  pid=10636 comm="runcon" path="/usr/lib/jvm/java-8-
> > > openjdk-
> > > > > > > armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> > > > > > > scontext=system_u:object_r:myapp_t:s0
> > > > > > > tcontext=system_u:object_r:java_exec_t:s0 tclass=file
> > > > > >
> > > > > > permissive=1
> > > > > >
> > > > > > Add the following to your policy:
> > > > > > domain_entry_file(myapp_t, java_exec_t)
> > > > > > spec_domtrans_pattern(unconfined_t, java_exec_t, myapp_t)
> > > > > >
> > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > >
> > > > > > > On Tue, Apr 4, 2017 at 9:26 AM, Stephen Smalley <sds@tych
> > > o.nsa.
> > > > > > > go
> > > > > >
> > > > > > v>
> > > > > > > wrote:
> > > > > > > > On Tue, 2017-04-04 at 08:50 -0700, Rahmadi Trimananda
> > > wrote:
> > > > > > > > > Hey Guys,
> > > > > > > > >
> > > > > > > > > I am trying to confine a Java process that I have so
> > > that
> > > > > > > > > it
> > > > > >
> > > > > > will
> > > > > > > > be
> > > > > > > > > able to read only certain files. This is my
> > > experiment
> > > > > > > > > setup
> > > > > >
> > > > > > for
> > > > > > > > my
> > > > > > > > > folder. Basically a.out (C program) and Test.class
> > > (Java
> > > > > >
> > > > > > class)
> > > > > > > > are
> > > > > > > > > coded to read and print out the text in test.txt.
> > > > > > > > >
> > > > > > > > >     unconfined_u:object_r:httpd_t:SystemLow a.out
> > > > > > > > > unconfined_u:object_r:user_home_t:SystemLow test.c
> > > > > > > > >     unconfined_u:object_r:httpd_t:SystemLow
> > > Test.class
> > > > > > > > > unconfined_u:object_r:user_home_t:SystemLow Test.java
> > > > > > > > > unconfined_u:object_r:user_home_t:SystemLow test.txt
> > > > > > > > >
> > > > > > > > > I tried to change the type label for a.out from
> > > user_home_t
> > > > > >
> > > > > > to
> > > > > > > > > httpd_t just for the sake of the experiment. With
> > > this
> > > > > > > > > setup,
> > > > > > > >
> > > > > > > > a.out
> > > > > > > > > is no longer able to read test.txt in enforcing mode.
> > > > > >
> > > > > > However, I
> > > > > > > > seem
> > > > > > > > > to not be able to do it for Test.class as it's
> > > running on a
> > > > > >
> > > > > > JVM.
> > > > > > > > The
> > > > > > > > > java label is "bin_t". And I checked using this:
> > > > > > > > >
> > > > > > > > > sesearch -s bin_t -t user_home_t -c file -p read -Ad
> > > > > > > > >
> > > > > > > > > And it doesn't seem to have a rule that allows bin_t
> > > to
> > > > > > > > > read
> > > > > >
> > > > > > a
> > > > > > > > file
> > > > > > > > > with user_home_t label.
> > > > > > > > >
> > > > > > > > > What's the right way to do this if any? Then, I also
> > > try to
> > > > > > > >
> > > > > > > > confine
> > > > > > > > > port accesses for Test.class, e.g. I only allow it to
> > > > > > > > > access
> > > > > > > >
> > > > > > > > ports
> > > > > > > > > 1234 and 2345. Same question, what's the right way to
> > > do
> > > > > >
> > > > > > this?
> > > > > > > >
> > > > > > > > I think you are conflating file labels with process
> > > labels. 
> > > > > >
> > > > > > The
> > > > > > > > /usr/sbin/httpd file is labeled with the httpd_exec_t
> > > type;
> > > > > > > > the
> > > > > > > > running
> > > > > > > > httpd process runs in the httpd_t domain (to be
> > > precise,
> > > > > > > > init_t
> > > > > > > > transitions to httpd_t upon executing httpd_exec_t). 
> > > bin_t
> > > > > > > > is
> > > > > >
> > > > > > just
> > > > > > > > a
> > > > > > > > generally executable file type that doesn't cause a
> > > domain
> > > > > > > > transition
> > > > > > > > (as no domain transition is defined in policy on it),
> > > so a
> > > > > >
> > > > > > process
> > > > > > > > that
> > > > > > > > execs a bin_t file will just stay in its domain.  You
> > > want to
> > > > > > > > create a
> > > > > > > > new domain and run your program in that; if you are
> > > running
> > > > > > > > it
> > > > > > > > through
> > > > > > > > an interpreter, then you can force it into the target
> > > domain
> > > > > >
> > > > > > via
> > > > > > > > runcon.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > -- 
> > > > > > > Kind regards,
> > > > > > > Rahmadi Trimananda
> > > > > > >
> > > > > > > Ph.D. student @ University of California, Irvine
> > > > > > > "Stay hungry, stay foolish!" - Steve Jobs -
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
> > 
> > 
> > 
> > -- 
> > Kind regards,
> > Rahmadi Trimananda
> > 
> > Ph.D. student @ University of California, Irvine
> > "Stay hungry, stay foolish!" - Steve Jobs -
> > 
> 
> 
> 
> -- 
> Kind regards,
> Rahmadi Trimananda
> 
> Ph.D. student @ University of California, Irvine
> "Stay hungry, stay foolish!" - Steve Jobs -
