Message-ID: <1498492210.13301.20.camel@tycho.nsa.gov>
Subject: Re: run_init messes up terminal settings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Mon, 26 Jun 2017 11:50:10 -0400
In-Reply-To: <20170626132626.GA15033@julius.enp8s0.d30>
References: <f19a1c21-5c15-cb56-9e55-08df2f66429a@debian.org>
 <1498482496.13301.2.camel@tycho.nsa.gov>
 <20170626132626.GA15033@julius.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-06-26 at 15:26 +0200, Dominick Grift wrote:
> On Mon, Jun 26, 2017 at 09:08:16AM -0400, Stephen Smalley wrote:
> > On Sat, 2017-06-24 at 12:20 +0200, Laurent Bigonville wrote:
> > > Hello,
> > > Russell opened the following bug regarding run_init in the debian
> > > bts:
> > > ====
> > > [...]
> > > It turns out that the problem was not running $(arch), but
> > > running
> > > run_init in 
> > > the shell it spawned.  Below is an example of reproducing this,
> > > the
> > > first time 
> > > run_init performs as expected.  The second time is fails without
> > > me
> > > even 
> > > typing a password or pressing ENTER.  The result is the same with
> > > any
> > > command, 
> > > but ls is just a good example.  This happens no matter what shell
> > > is
> > > spawned 
> > > (whether it's ssh, su, or just an Xterm), run_init seems
> > > generally
> > > broken with 
> > > the 4.9.0-2-amd64/4.9.13-1 kernel at least.
> > > 
> > > NB I can't rule out the possibility of a kernel bug at this
> > > stage.  But at 
> > > this time it seems best to assume it's a run_init bug until
> > > proven
> > > otherwise.
> > > 
> > > Sorry for the inconvenience Andreas.
> > > 
> > > # run_init ls /boot
> > > Authenticating root.
> > > Password: 
> > > config-4.9.0-2-amd64      lost+found                System.map-
> > > 4.9.0-
> > > 3-amd64
> > > config-4.9.0-3-amd64      memtest86+.bin            vmlinuz-
> > > 4.9.0-2-
> > > amd64
> > > grub                      memtest86+_multiboot.bin  vmlinuz-
> > > 4.9.0-3-
> > > amd64
> > > initrd.img-4.9.0-2-amd64  real
> > > initrd.img-4.9.0-3-amd64  System.map-4.9.0-2-amd64
> > > # run_init ls /boot
> > > Authenticating root.
> > > Password: 
> > > run_init: incorrect password for root
> > > authentication failed.
> > > # 
> > > ====
> > > I can reproduce this with 2.7-rc3, run_init is compiled with pam
> > > and
> > > audit support.
> > > An idea what could happen here?
> > > Regards,
> > > Laurent Bigonville
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863187
> > 
> > I don't think this could have ever worked under run_init since
> > open_init_pty was introduced (originally from Debian); note that
> > open_init_pty does alter terminal settings.
> > 
> > I don't quite follow the example given above.  It shows executing
> > run_init twice with ls /boot as the arguments, which is not running
> > run_init within run_init.  That works fine for me.
> > 
> > If I try something like:
> > run_init run_init ls /boot
> > which actually runs run_init within run_init, then that also works
> > for
> > me without problem.
> > 
> > If I try something like:
> > run_init /bin/bash
> > then I lose any echoing of input characters to the shell (due to
> > open_init_pty turning it off), but I can enter commands and execute
> > them, or run stty sane to regain echoing.  But I don't think that
> > has
> > ever been supported since the introduction of open_init_pty in 2005
> > (policycoreutils 1.21.2).  What's the use case for it?
> > 
> > Side bar: run_init (and open_init_pty) are no longer packaged by
> > Fedora
> > since systemd renders it unnecessary, and even prior to that,
> > Fedora
> > policy enabled DIRECT_INITRC=y in build.conf, and therefore
> > run_init
> 
> Correct me if i am wrong but fedora has DIRECT_INITRC=n AFAICT
> 
> https://src.fedoraproject.org/cgit/rpms/selinux-policy.git/tree/selin
> ux-policy.spec#n173
> https://src.fedoraproject.org/cgit/rpms/selinux-policy.git/tree/selin
> ux-policy.spec#n393
> 
> I vaguely recall that in a strict environment one still might need
> run_init for the `update aliases` functionality in redhar-based
> distributions.. i might be wrong though

run_init is no longer packaged in Fedora at all (see
policycoreutils.spec, which removes it during %install so that it will
not be packaged).  Looking at the ChangeLog, this happened in 2012:
* Mon Nov 5 2012 Dan Walsh <dwalsh@redhat.com> - 2.1.12-25
- Remove run_init, no longer needed with systemd.

Thus, DIRECT_INITRC=y is no longer required either, for the same reason
(obsoleted by systemd).  Prior to that change, Fedora built with
DIRECT_INITRC=y for -targeted policy; only -mls and -strict built with
DIRECT_INITRC=n and needed run_init.

> 
> > wasn't required for typical operation (maybe under -mls policy it
> > was
> > still needed, not sure). Possibly we should move run_init out of
> > policycoreutils into its own subdirectory in the selinux userspace
> > tree
> > to reflect this transition and start deprecating it.
> > 
> 
> 
