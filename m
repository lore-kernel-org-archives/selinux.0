Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5O1vvgA002604
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 21:57:57 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5O1lVRO007174
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 01:47:31 GMT
Subject: Re: mdadm policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119569243.9390.77.camel@localhost>
References: <1119569243.9390.77.camel@localhost>
Content-Type: multipart/mixed; boundary="=-XDmcNfxMQrsHMk5QH91C"
Date: Thu, 23 Jun 2005 21:50:46 -0400
Message-Id: <1119577846.20101.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XDmcNfxMQrsHMk5QH91C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-06-24 at 00:27 +0100, antoine wrote:
> I was looking for a policy for mdadm, I know there is one in Fedora, but
> I use gentoo and I couldn't download it without getting the whole rpm,

Policy is attached, and I recommend using something similar
over the one you have.

> so I ended up writing one (attached) - it is also a good learning
> exercise. Shouldn't it be in serefpolicy.sourceforge.net?
> 
> Works for me (tm)

The following things are wrong with this policy:

(1) It allows everything the program wants to do, regardless
of whether it is a good idea.

(2) It is not organized in any sensible way. Sensible way means
making use of existing macros, grouping rules together,
and commenting *everything* with the purpose for adding
that rule (or better yet group of rules) - this is the
overall action that you want to allow with this block of rules.

(3) It adds primitive rules for things already present in macros.
For example, the daemon_domain covers the transition.

(4)...and there's numerous specific things wrong with it,
that I won't go into....starting from lack of exec_type on
the bin_type, not following naming conventions, etc..

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-XDmcNfxMQrsHMk5QH91C
Content-Disposition: attachment; filename=mdadm.te
Content-Type: text/plain; name=mdadm.te; charset=utf-8
Content-Transfer-Encoding: 7bit

#DESC mdadm - Linux RAID tool
#
# Author: Colin Walters <walters@redhat.com>
#

daemon_base_domain(mdadm, `, fs_domain')
role sysadm_r types mdadm_t;

allow initrc_t mdadm_var_run_t:file create_file_perms;

# Kernel filesystem permissions
r_dir_file(mdadm_t, proc_t)
allow mdadm_t proc_mdstat_t:file rw_file_perms;
read_sysctl(mdadm_t)
r_dir_file(mdadm_t, sysfs_t) 

# Configuration
allow mdadm_t { etc_t etc_runtime_t }:file { getattr read };
read_locale(mdadm_t)

# Linux capabilities
allow mdadm_t self:capability { dac_override sys_admin ipc_lock };

# Helper program access
can_exec(mdadm_t, { bin_t sbin_t })

# RAID block device access
allow mdadm_t fixed_disk_device_t:blk_file create_file_perms;
allow mdadm_t device_t:lnk_file { getattr read };

# Ignore attempts to read every device file
dontaudit mdadm_t device_type:{ chr_file blk_file } getattr;
dontaudit mdadm_t device_t:{ fifo_file file dir chr_file blk_file } { read getattr };
dontaudit mdadm_t devpts_t:dir r_dir_perms;

# Ignore attempts to read/write sysadmin tty
dontaudit mdadm_t sysadm_tty_device_t:chr_file rw_file_perms;

# Other random ignores
dontaudit mdadm_t tmpfs_t:dir r_dir_perms;
dontaudit mdadm_t initctl_t:fifo_file getattr;
var_run_domain(mdadm)
allow mdadm_t var_t:dir { getattr search };

--=-XDmcNfxMQrsHMk5QH91C--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
