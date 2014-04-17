Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3HLdCil013242
 for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2014 17:39:12 -0400
Message-ID: <1397770748.3305.386.camel@metroid.usersys.redhat.com>
Subject: selinux_init_load_policy() and systemd switch-root
From: Will Woods <wwoods@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 17 Apr 2014 17:39:08 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hey all. I have a few questions for you! 

* Is it OK to load policy more than once? (e.g. load new policy after 
  chroot/switch-root to new system)

* If so (and I'm pretty sure that's OK), are we supposed to call
  selinux_init_load_policy for each switch-root, or is
  selinux_mkload_policy supposed to be sufficient?

* What should happen if we switch-root from a system with SELinux
  enabled/permissive to one that has SELINUX=disabled? 

Background on the problem follows. It's optional reading; sorry there's
so much of it.


So, I'm working on major-version upgrades in Fedora/RHEL (and, broadly,
anything that uses systemd + SELinux).

The important (and unusual) thing about upgrades is that they involve
*two* switch-roots - the normal one from initramfs to real root, and a
second one to go from real root to "upgrade.img"[1], which does the
upgrade itself.

So upgrades have *three* roots: initramfs, real root, and upgrade.img.
And initramfs/upgrade.img contain the new release's tools/policy/etc.

The problem: Currently, we try to load policy during initramfs. This
turns out to be a bad idea: nothing in initramfs is labeled, every
process ends up with kernel_t, and so files created in /run or /dev may
have the wrong labels.

Also, on systems where the admin has chosen to remove SELinux, systemd
freezes when it switches to the real root, because a) enforcing is on,
but b) policy can't be loaded.

So a saner plan would seem to be to let the system load policy as normal
(i.e.: do nothing during initramfs, load policy when entering real
root), then load the *new* policy when switching to upgrade.img.

But: systemd refuses to load policy more than once, for reasons that
seem unrelated to loading policy itself[2].

So: maybe it would make sense to have call selinux_init_load_policy()
after *every* switch-root?

We can't just use selinux_mkload_policy() because (as the comment in
selinux_init_load_policy() points out) we need to do things like reset
the config and re-mount selinuxfs after a chroot.

But it also seems like selinux_init_load_policy() assumes it will only
be called once; a later comment says:

        /*
         * If we failed to disable, SELinux will still be 
         * effectively permissive, because no policy is loaded. 
         * No need to call security_setenforce(0) here.
         */

Except: if we were enforcing in the previous root, and the new root
requests SELINUX=disabled.. then policy *is* loaded, and we *do* need
security_setenforce(0).

So: is that just a bug, or is selinux_init_load_policy() really not
intended to be called more than once? And if that's the case, how should
I re-load config/policy/etc. after a switch-root?

Any help / suggestions / comments / questions / expert guidance is very
welcome here. 

Thanks in advance,

-w

[1] initramfs and upgrade.img are actually the same image in the current
implementation, but that's not really important here.

[2] The original code[3] seems to be avoiding an infinite loop:
  * when systemd v12 starts, it tries to load policy
  * if policy loads OK, systemd restarts
So in *that* case, yes, systemd needed to load policy *only* once.
But these days, selinux_setup() is only called at system startup and
after each switch-root, and it doesn't restart systemd. So that's not a
problem.

[3] http://cgit.freedesktop.org/systemd/systemd/commit?id=c4dcdb9
