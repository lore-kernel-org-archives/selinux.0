Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NNbIgA002016
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 19:37:18 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NNRQNa019226
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 23:27:26 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 163DCAEF83
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 23:46:14 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21980-13 for <selinux@tycho.nsa.gov>;
 Thu, 23 Jun 2005 23:46:12 +0100 (BST)
Received: from [192.168.0.1] (unknown [81.1.90.226])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 1C6A9AEF82
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 23:46:12 +0100 (BST)
Subject: mdadm policy
From: antoine <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-CicUDSgghUlm9U+AS5vp"
Date: Fri, 24 Jun 2005 00:27:23 +0100
Message-Id: <1119569243.9390.77.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-CicUDSgghUlm9U+AS5vp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I was looking for a policy for mdadm, I know there is one in Fedora, but
I use gentoo and I couldn't download it without getting the whole rpm,
so I ended up writing one (attached) - it is also a good learning
exercise. Shouldn't it be in serefpolicy.sourceforge.net?

Works for me (tm)
Is this any good? (I think it should probably use macros for shlib and
ptys, and use dontaudit instead of allow for some of the devices)

Antoine

--=-CicUDSgghUlm9U+AS5vp
Content-Disposition: inline; filename=mdadm.fc
Content-Type: text/plain; name=mdadm.fc; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

/etc/mdadm.conf					--	system_u:object_r:mdadm_etc_t
/sbin/mdadm					--	system_u:object_r:mdadm_bin_t

--=-CicUDSgghUlm9U+AS5vp
Content-Disposition: inline; filename=mdadm.te
Content-Type: text/plain; name=mdadm.te; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

# antoine@nagafix.co.uk

daemon_domain(mdadm, `, fs_domain')

type mdadm_etc_t, file_type, sysadmfile;
type mdadm_bin_t, file_type, sysadmfile;

domain_auto_trans(initrc_t, mdadm_bin_t, mdadm_t)
domain_auto_trans(sysadm_t, mdadm_bin_t, mdadm_t)

# role system_r types mdadm_t;

allow initrc_t mdadm_etc_t:file read;
allow mdadm_t mdadm_etc_t:file { getattr read };

allow mdadm_t etc_t:dir search;

allow mdadm_t ld_so_cache_t:file { getattr read };
allow mdadm_t lib_t:dir search;
allow mdadm_t lib_t:lnk_file read;
allow mdadm_t shlib_t:file { execute getattr read };

allow mdadm_t proc_mdstat_t:file { getattr read };
allow mdadm_t proc_t:dir search;
allow mdadm_t root_t:dir search;

allow mdadm_t tmpfs_t:dir { getattr read };


allow mdadm_t device_t:lnk_file read;

allow mdadm_t self:capability sys_admin;


# DEV:
allow mdadm_t clock_device_t:chr_file getattr;
allow mdadm_t console_device_t:chr_file { getattr read write };
allow mdadm_t cpu_device_t:chr_file getattr;
allow mdadm_t device_t:blk_file { getattr ioctl read };
allow mdadm_t device_t:chr_file getattr;
allow mdadm_t device_t:dir { getattr read search };
allow mdadm_t device_t:file getattr;
allow mdadm_t device_t:lnk_file getattr;
allow mdadm_t devlog_t:sock_file getattr;
allow mdadm_t devpts_t:dir { getattr read };
allow mdadm_t devtty_t:chr_file getattr;
allow mdadm_t fixed_disk_device_t:blk_file getattr;
allow mdadm_t init_t:fd use;
allow mdadm_t initctl_t:fifo_file getattr;
allow mdadm_t memory_device_t:chr_file getattr;
allow mdadm_t mouse_device_t:chr_file getattr;
allow mdadm_t null_device_t:chr_file { getattr read };
allow mdadm_t ptmx_t:chr_file getattr;
allow mdadm_t random_device_t:chr_file getattr;
allow mdadm_t tty_device_t:chr_file getattr;
#allow mdadm_t tun_tap_device_t:chr_file getattr;
allow mdadm_t zero_device_t:chr_file getattr;

allow mdadm_t fixed_disk_device_t:blk_file read;

--=-CicUDSgghUlm9U+AS5vp--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
