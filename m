Message-ID: <1491326251.31785.17.camel@tycho.nsa.gov>
Subject: Re: Confining a Java process reading file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rahmadi Trimananda <rtrimana@uci.edu>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Date: Tue, 04 Apr 2017 13:17:31 -0400
In-Reply-To: <CAHFUiBPfTCsPTmKTOuRdRNp8Z1cSCiUj6D1QY0LpyPQ5M-a4Vw@mail.gmail.com>
References: <CAHFUiBNUTOaOYVch=MJPz6c_Stx_B_rmMA-FjMVcneiWouGKOw@mail.gmail.com>
 <1491323167.31785.14.camel@tycho.nsa.gov>
 <CAHFUiBPfTCsPTmKTOuRdRNp8Z1cSCiUj6D1QY0LpyPQ5M-a4Vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-04-04 at 09:37 -0700, Rahmadi Trimananda wrote:
> Do you mean that we create our own new domain, e.g. myapp_t?
> I tried this and it works for my a.out that reads test.txt.
> 
> I tried runcon as well for the Java version:
> 
> runcon system_u:object_r:myapp_t:SystemLow java Test

Just runcon -t myapp_t java Test would be simpler, and would preserve
your user identity, role, and level.  Processes don't use object_r;
that is only for files/objects.

> The response I got was: runcon: java: Permission denied.
> In the audit.log I found that runcon is just not permitted for
> everything. Any thoughts?
> 
> ...
> type=SYSCALL msg=audit(1491323666.800:4249): arch=40000028 syscall=11
> per=800000 success=no exit=-13 a0=7ec2c140 a1=7ec2c34c a2=7ec2c35c
> a3=6e69622f items=0 ppid=989 pid=10629 auid=1001 uid=1001 gid=1001
> euid=1001 suid=1001 fsuid=1001 egid=1001 sgid=1001 fsgid=1001
> tty=pts0 ses=3 comm="runcon" exe="/usr/bin/runcon"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> 
> type=AVC msg=audit(1491323672.070:4255): avc:  denied  { execstack }
> for  pid=10631 comm="runcon"
> scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tclass=process permissive=0

This again reflects a problem with the way your userspace was built.
execstack -q /usr/bin/runcon
readelf -l /usr/bin/runcon

In the interim, you can allow execstack pervasively via:
setsebool -P allow_execstack=1

> type=SYSCALL msg=audit(1491323672.070:4255): arch=40000028
> syscall=125 per=800000 success=no exit=-13 a0=7e84c000 a1=1000
> a2=1000007 a3=76fb6f18 items=0 ppid=10630 pid=10631 auid=1001 uid=0
> gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3
> comm="runcon" exe="/usr/bin/runcon"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> 
> type=AVC msg=audit(1491323672.080:4256): avc:  denied  { transition }
> for  pid=10631 comm="runcon" path="/usr/lib/jvm/java-8-openjdk-
> armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:myapp_t:s0 tclass=process permissive=0
> 
> type=SYSCALL msg=audit(1491323672.080:4256): arch=40000028 syscall=11
> per=800000 success=no exit=-13 a0=7e84c5dc a1=7e84c7ec a2=7e84c7f8
> a3=6e69622f items=0 ppid=10630 pid=10631 auid=1001 uid=0 gid=0 euid=0
> suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3 comm="runcon"
> exe="/usr/bin/runcon" subj=unconfined_u:unconfined_r:unconfined_t:s0-
> s0:c0.c1023 key=(null)
> 
> type=AVC msg=audit(1491323700.770:4269): avc:  denied  { transition }
> for  pid=10636 comm="runcon" path="/usr/lib/jvm/java-8-openjdk-
> armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:myapp_t:s0 tclass=process permissive=1
> 
> type=AVC msg=audit(1491323700.770:4269): avc:  denied  { entrypoint }
> for  pid=10636 comm="runcon" path="/usr/lib/jvm/java-8-openjdk-
> armhf/jre/bin/java" dev="mmcblk0p2" ino=524520
> scontext=system_u:object_r:myapp_t:s0
> tcontext=system_u:object_r:java_exec_t:s0 tclass=file permissive=1

Add the following to your policy:
domain_entry_file(myapp_t, java_exec_t)
spec_domtrans_pattern(unconfined_t, java_exec_t, myapp_t)


> ...
> 
> 
> On Tue, Apr 4, 2017 at 9:26 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Tue, 2017-04-04 at 08:50 -0700, Rahmadi Trimananda wrote:
> > > Hey Guys,
> > >
> > > I am trying to confine a Java process that I have so that it will
> > be
> > > able to read only certain files. This is my experiment setup for
> > my
> > > folder. Basically a.out (C program) and Test.class (Java class)
> > are
> > > coded to read and print out the text in test.txt.
> > >
> > >     unconfined_u:object_r:httpd_t:SystemLow a.out
> > > unconfined_u:object_r:user_home_t:SystemLow test.c
> > >     unconfined_u:object_r:httpd_t:SystemLow Test.class
> > > unconfined_u:object_r:user_home_t:SystemLow Test.java
> > > unconfined_u:object_r:user_home_t:SystemLow test.txt
> > >
> > > I tried to change the type label for a.out from user_home_t to
> > > httpd_t just for the sake of the experiment. With this setup,
> > a.out
> > > is no longer able to read test.txt in enforcing mode. However, I
> > seem
> > > to not be able to do it for Test.class as it's running on a JVM.
> > The
> > > java label is "bin_t". And I checked using this:
> > >
> > > sesearch -s bin_t -t user_home_t -c file -p read -Ad
> > >
> > > And it doesn't seem to have a rule that allows bin_t to read a
> > file
> > > with user_home_t label.
> > >
> > > What's the right way to do this if any? Then, I also try to
> > confine
> > > port accesses for Test.class, e.g. I only allow it to access
> > ports
> > > 1234 and 2345. Same question, what's the right way to do this?
> > 
> > I think you are conflating file labels with process labels.  The
> > /usr/sbin/httpd file is labeled with the httpd_exec_t type; the
> > running
> > httpd process runs in the httpd_t domain (to be precise, init_t
> > transitions to httpd_t upon executing httpd_exec_t).  bin_t is just
> > a
> > generally executable file type that doesn't cause a domain
> > transition
> > (as no domain transition is defined in policy on it), so a process
> > that
> > execs a bin_t file will just stay in its domain.  You want to
> > create a
> > new domain and run your program in that; if you are running it
> > through
> > an interpreter, then you can force it into the target domain via
> > runcon.
> > 
> > 
> > 
> > 
> > 
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
