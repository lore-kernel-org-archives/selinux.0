Subject: Re: A question about installing refpolicy-2.10081210
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <COL109-W23743BA1B690A08216533AB0C0@phx.gbl>
References: <COL109-W23743BA1B690A08216533AB0C0@phx.gbl>
Content-Type: text/plain
Date: Tue, 04 Aug 2009 08:00:20 -0400
Message-Id: <1249387220.9193.41.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-08-04 at 03:00 +0000, TaurusHarry wrote:
> Hi all,
> 
> I have a question about the error messages when installing
> refpolicy-2.20081210 from the tresys website on dell 610(x86_32)
> laptop. I have installed and compiled refpolicy-2.20081210 by the
> following selinux user space tools:
> 
> libsepol-2.0.36
> libselinux-2.0.79
> libsemanage-2.0.27
> policycoreutils-2.0.55
> checkpolicy-2.0.19
> sepolgen-1.0.16
> 
> Then I use kernel cmdline of "root=/dev/sda1 rw init=/bin/bash
> selinux=1" to boot into a shell with selinux enabled so that I could
> setup proper security contexts for the whole file system in the shell
> before the next time I would let kernel boot into normal /sbin/init
> program and start everything with correct security context. Then I do
> the following commands:
> 
> mount -t proc none /proc
> mount -t sysfs none /sys
> mount -t selinuxfs none /selinux
> SELINUXTYPE=refpolicy-20081210
> /usr/sbin/load_policy -q /etc/selinux/$SELINUXTYPE/policy/policy.24
> sed -i "s/^SELINUXTYPE=.*/SELINUXTYPE=$S!
> ELINUXTYPE/" /etc/selinux/config
> /usr/sbin/restorecon -v -R /
> 
> The "load_policy -q" would pop up a message of:
> type=1403 audit(1255195933.120:2): policy loaded auid=4294967295
> ses=4294967295
> 
> so I guess the policy.24 has been loaded successfully, and the
> "restorecon" could run successfully. However, when I change the kernel
> cmdline with "init=/sbin/init" I could see hundreds of error messages
> about udev and mingetty such as:
> 
> udevd-event[1252]: selinux_setfscreatecon: matchpathcon(/dev/.tmp-8-0)
> failed
> udevd-event[1215]: selinux_setfilecon: matchpathcon(/dev/ram12) failed

What did you end up with as
your /etc/selinux/$SELINUXTYPE/contexts/files/file_contexts file?

> and 
> 
> type=1400 audit(1248303983.579:5559): avc:  denied  { open } for
> pid=3283 comm="mingetty" name="var" dev=sda1 ino=103169
> scontext=system_u:system_r:getty_t:s0-s15:c0.c255
> tcontext=system_u:object_r:var_t:s0 tclass=dir
> type=1400 audit(1248303983.598:5560): avc:  denied  { open } for
> pid=3282 comm="mingetty" name="var" dev=sda1 ! ino=103169
> scontext=system_u:system_r:getty_t:s0-s15:c0.c255 tcontext=
> system_u:object_r:var_t:s0 tclass=dir

That's a kernel bug.  Kernel version?  Fixed by:
http://marc.info/?l=git-commits-head&m=123049921710331&w=2
http://marc.info/?l=git-commits-head&m=123809417718576&w=2

If you can't fix your kernel, then disable open permission in your
policy (remove policycap open_perms; from policy/policy_capabilities).

> with "INIT: no more processes left in this runlevel" in the end when I
> try to login through serial console.
> 
> I guess above error messages may have resulted in the file system
> having not been labeled correctly, does anyone know what I may have
> missed out when trying to relabeling the file system when first time
> booting into the shell?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
