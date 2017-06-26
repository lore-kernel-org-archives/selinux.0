Message-ID: <1498482496.13301.2.camel@tycho.nsa.gov>
Subject: Re: run_init messes up terminal settings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Laurent Bigonville <bigon@debian.org>, selinux <selinux@tycho.nsa.gov>
Cc: 863187-forwarded@bugs.debian.org, Russell Coker <russell@coker.com.au>
Date: Mon, 26 Jun 2017 09:08:16 -0400
In-Reply-To: <f19a1c21-5c15-cb56-9e55-08df2f66429a@debian.org>
References: <f19a1c21-5c15-cb56-9e55-08df2f66429a@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-06-24 at 12:20 +0200, Laurent Bigonville wrote:
> Hello,
> Russell opened the following bug regarding run_init in the debian
> bts:
> ====
> [...]
> It turns out that the problem was not running $(arch), but running
> run_init in 
> the shell it spawned.  Below is an example of reproducing this, the
> first time 
> run_init performs as expected.  The second time is fails without me
> even 
> typing a password or pressing ENTER.  The result is the same with any
> command, 
> but ls is just a good example.  This happens no matter what shell is
> spawned 
> (whether it's ssh, su, or just an Xterm), run_init seems generally
> broken with 
> the 4.9.0-2-amd64/4.9.13-1 kernel at least.
> 
> NB I can't rule out the possibility of a kernel bug at this
> stage.  But at 
> this time it seems best to assume it's a run_init bug until proven
> otherwise.
> 
> Sorry for the inconvenience Andreas.
> 
> # run_init ls /boot
> Authenticating root.
> Password: 
> config-4.9.0-2-amd64      lost+found                System.map-4.9.0-
> 3-amd64
> config-4.9.0-3-amd64      memtest86+.bin            vmlinuz-4.9.0-2-
> amd64
> grub                      memtest86+_multiboot.bin  vmlinuz-4.9.0-3-
> amd64
> initrd.img-4.9.0-2-amd64  real
> initrd.img-4.9.0-3-amd64  System.map-4.9.0-2-amd64
> # run_init ls /boot
> Authenticating root.
> Password: 
> run_init: incorrect password for root
> authentication failed.
> # 
> ====
> I can reproduce this with 2.7-rc3, run_init is compiled with pam and
> audit support.
> An idea what could happen here?
> Regards,
> Laurent Bigonville
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863187

I don't think this could have ever worked under run_init since
open_init_pty was introduced (originally from Debian); note that
open_init_pty does alter terminal settings.

I don't quite follow the example given above.  It shows executing
run_init twice with ls /boot as the arguments, which is not running
run_init within run_init.  That works fine for me.

If I try something like:
run_init run_init ls /boot
which actually runs run_init within run_init, then that also works for
me without problem.

If I try something like:
run_init /bin/bash
then I lose any echoing of input characters to the shell (due to
open_init_pty turning it off), but I can enter commands and execute
them, or run stty sane to regain echoing.  But I don't think that has
ever been supported since the introduction of open_init_pty in 2005
(policycoreutils 1.21.2).  What's the use case for it?

Side bar: run_init (and open_init_pty) are no longer packaged by Fedora
since systemd renders it unnecessary, and even prior to that, Fedora
policy enabled DIRECT_INITRC=y in build.conf, and therefore run_init
wasn't required for typical operation (maybe under -mls policy it was
still needed, not sure). Possibly we should move run_init out of
policycoreutils into its own subdirectory in the selinux userspace tree
to reflect this transition and start deprecating it.
