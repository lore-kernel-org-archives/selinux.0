Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1AEPmRb009346
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 09:25:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1AEONQk001598
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 14:24:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i1AEOMYo001595
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 14:24:22 GMT
Subject: Re: Issues relabeling filesystems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ignacio Tripodi <ignaciot@unt.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <B70EC6D6-5B84-11D8-B6A3-000393013D1A@unt.edu>
References: <B70EC6D6-5B84-11D8-B6A3-000393013D1A@unt.edu>
Content-Type: text/plain
Message-Id: <1076423145.5910.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 10 Feb 2004 09:25:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-02-09 at 23:50, Ignacio Tripodi wrote:
> - - I've been looking at the list archives about the issues loading the 
> policy from initrd when using UML. Is there a good reason for loading 
> it from initrd instead of, for example, inserting the code from the 
> script you provided (se-init) into the rc.local script? I'm having 
> trouble loading the initrd that I created with the patched script, but 
> I'm not sure if it's worth the trouble:
> 
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 151k freed
> VFS: Mounted root (ext2 filesystem) readonly.
> Kernel panic: No init found.  Try passing init= option to kernel.

In early releases of the 2.6-based SELinux, you had to perform the
initial policy load from the initrd.  However, that was changed to
instead use a patched /sbin/init program (from the SysVinit package) to
perform the initial policy load and then re-exec init into the correct
domain.  So SELinux no longer requires a special initrd.  rc.local is
too late, but the patched /sbin/init program works fine.

Naturally, if you want to specify root=LABEL=/ in your grub.conf, you do
need an initrd; otherwise, you can just set it to root=/dev/hda2 or
whatever is appropriate for your system.  A common problem with the
initrd boots is failing to set the default ram disk size sufficiently
large (e.g. 8192) in your kernel configuration.
Check your .config for your CONFIG_BLK_DEV_RAM_SIZE value; 8192 is
recommended.  That's settable under the Device Drivers->Block devices
menu in make menuconfig.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
