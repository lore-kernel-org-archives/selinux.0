Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7AExpOb002469
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 10:59:51 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7AEpq7C014999
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 14:51:52 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions [144.51.25.4])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7AEqFdD004511
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 10:52:15 -0400 (EDT)
Subject: Updated Policy in Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 10:52:02 -0400
Message-Id: <1123685522.18934.14.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.25.4 2005-08-010
* Merged small patches from Russell Coker for the restorecon, kudzu,
lvm, radvd, and spamassasin policies.
* Added fs_use_trans rule for mqueue from Mark Gebhart to support the
work he has done on providing SELinux support for mqueue.
* Merged a patch from Dan Walsh. Removes the user_can_mount tunable.
Adds disable_evolution_trans and disable_thunderbird_trans booleans.
Adds the nscd_client_domain attribute to insmod_t.  Removes the
user_ping boolean from targeted policy.  Adds hugetlbfs, inotifyfs, and
mqueue filesystems to genfs_contexts.  Adds the isakmp_port for vpnc.
Creates the pptp daemon domain.  Allows getty to run sbin_t for pppd.
Allows initrc to write to default_t for booting.  Allows Hotplug_t
sys_rawio for prism54 card at boot.  Other minor fixes.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
