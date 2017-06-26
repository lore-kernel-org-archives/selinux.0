Message-ID: <1498490551.13301.16.camel@tycho.nsa.gov>
Subject: Re: run_init messes up terminal settings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Laurent Bigonville <bigon@debian.org>, selinux <selinux@tycho.nsa.gov>
Cc: 863187-forwarded@bugs.debian.org, Russell Coker <russell@coker.com.au>
Date: Mon, 26 Jun 2017 11:22:31 -0400
In-Reply-To: <d5e647e7-8767-b176-e769-6a50de234af2@debian.org>
References: <f19a1c21-5c15-cb56-9e55-08df2f66429a@debian.org>
 <1498482496.13301.2.camel@tycho.nsa.gov>
 <d5e647e7-8767-b176-e769-6a50de234af2@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-06-26 at 15:56 +0200, Laurent Bigonville wrote:
> Le 26/06/17 à 15:08, Stephen Smalley a écrit :
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
> 
> I just re-tried again and I can definitely reproduce this in debian 
> unstable. My complete test case is:
> 
> sudo -i
> <type the password>
> run_init ls /boot
> <type the password>
> <ls output>
> run_init ls /boot
> <error>
> 
> If I exit the shell started by sudo, run_init will works again for
> one 
> invocation before getting the error again.

Hmm...I couldn't reproduce on Fedora with the upstream selinux
userspace.  The above sequence works for me no matter how many times I
run run_init ls /boot.

What I did notice was that if I tried running two run_init commands
immediately after each other ala:
run_init id && run_init id
then the second one would fail on the user authentication.
(in comparison, su -c id && su -c id works fine.)

But if I try again manually, run_init works fine.

strace -f of the failed run_init (ala run_init id && strace -f run_init
id 2> err.txt) showed that it ends up getting -1 with errno EAGAIN on
the attempted read of the password from descriptor 0 (stdin).

This seems to be due to open_init_pty.  If I remove
/usr/sbin/open_init_pty, the above works without any problem (run_init
falls back to running the command directly if open_init_pty does not
exist; open_init_pty was always optional and introduced by Debian).

In particular, open_init_pty marks stdin and stdout non-blocking before
entering its event loop to handle I/O between the caller and the child.
 If you comment those setfd_nonblock() calls out, then the second
authentication works, but that will have other effects.

I'd be inclined to just drop open_init_pty (for that matter, I'd like
to deprecate/drop run_init entirely, but I guess it might be needed if
not using DIRECT_INITRC=y and not using systemd).

> 
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
> > wasn't required for typical operation (maybe under -mls policy it
> > was
> > still needed, not sure). Possibly we should move run_init out of
> > policycoreutils into its own subdirectory in the selinux userspace
> > tree
> > to reflect this transition and start deprecating it.
> 
> run_init and newrole executables are still packaged in debian but in
> a 
> different package that is not pulled by anything, so people that need
> it 
> have to manually install it.
