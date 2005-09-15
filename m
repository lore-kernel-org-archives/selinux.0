Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8FLFCNs019814
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2005 17:15:13 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8FL2d5s026408
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2005 21:05:13 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions [144.51.25.4])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8FKH1Jr017899
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2005 16:17:01 -0400 (EDT)
Subject: Updated Policy in Sourcforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 16:16:24 -0400
Message-Id: <1126815384.25802.10.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.27.1 2005-09-15
* Merged small patches from Russell Coker for the apostrophe, dhcpc,
fsadm, and setfiles policy.
* Merged a patch from Russell Coker with some minor fixes to a multitude
of policy files.
* Merged patch from Dan Walsh from August 15th. Adds certwatch policy.
Adds mcs support to Makefile.  Adds mcs file which defines sensitivities
and categories for the MSC policy.  Creates an authentication_domain
macro in global_macros.te for domains that use pam_authentication.
Creates the anonymous_domain macro so that the ftpd, rsync, httpd, and
smbd domains can share the ftpd_anon_t and ftpd_anon_rw_t types.
Removes netifcon rules to start isolating individual ethernet devices.
Changes vpnc from a daemon to an application_domain.  Adds audit_control
capability to crond_t.  Adds dac_override and dac_read_search
capabilities to fsadm_t to allow the manipulation of removable media.
Adds read_sysctl macro to the base_passwd_domain macro.  Adds rules to
allow alsa_t to communicate with userspace.  Allows networkmanager to
communicate with isakmp_port and to use vpnc.  For targeted policy,
removes transitions of sysadm_t to apm_t, backup_t, bootloader_t,
cardmgr_t, clockspeed_t, hwclock_t, and kudzu_t. Makes other minor
cleanups and fixes.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
