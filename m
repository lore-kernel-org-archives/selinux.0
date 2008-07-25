Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P29org004478
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 22:09:50 -0400
Received: from py-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P29ngJ021761
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 02:09:49 GMT
Received: by py-out-1112.google.com with SMTP id a78so8423531pyh.32
        for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 19:09:49 -0700 (PDT)
Subject: Policy loading:  initramfs vs. patched /sbin/init
From: Stephen Smalley <stephen.smalley@gmail.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov, Caleb Case <ccase@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <200807231242.51484.russell@coker.com.au>
References: <200807231017.30237.russell@coker.com.au>
	 <1216779113.3580.6.camel@sulphur> <200807231242.51484.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 24 Jul 2008 22:08:01 -0400
Message-Id: <1216951692.5185.36.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I saw your blog entry about policy loading on planet selinux - you ought
to bring issues like that up on selinux list for discussion rather than
just blogging about them.

First, to clarify, while Ubuntu and Fedora are initiating the policy
load from the initramfs, they are taking the policy from the real root
filesystem.  Thus, the policy is not being stored on the initramfs image
and updates to policy do not require rebuilding the image.

Both Ubuntu and Fedora have the script that runs from the initramfs
initiate the policy load, but Ubuntu does it by having the script invoke
the load_policy utility from the real root (chroot /path/to/realroot
load_policy -i) while Fedora does it by having the script invoke a nash
built-in command that directly calls the selinux_init_load_policy()
libselinux function call after chroot'ing into the real root.  The
Fedora approach was motivated by not wanting to pull the chroot utility
into the initrd and by wanting more precise error handling (making nash
exit if policy load fails and the system is enforcing so that the system
halts).  However this has caused some issues with pulling libsepol into
the initramfs and thereby limiting the maximum policy that can be loaded
to whatever policy version is supported by the initramfs libsepol.

On the positive side, the initramfs-based approach does mean
that /sbin/init from the real root automatically transitions into the
right domain since policy is already loaded.  And policy gets loaded no
matter what init is used or even if the user specifies an alternate
init= program on the kernel command line.

As you note, performing the load from initramfs can be problematic for
systems that cannot or choose not to use an initramfs, and that has come
up for two kernel developers already where they just happened to not use
an initramfs for a kernel they built themselves and had SELinux left
disabled (no policy loaded) unwittingly.

So I'm not fundamentally opposed to having the support in /sbin/init as
well if that's feasible, but you'll need it to detect whether policy has
already been loaded and skip it if so or it will end up loading policy
twice on systems that are using the initramfs-based approach.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
