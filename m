Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j65Jq4gA025726
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 15:52:04 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j65JnUSt004312
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 19:49:30 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions [144.51.25.4])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j65JoUZf016247
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 15:50:30 -0400 (EDT)
Subject: Updated Policy in Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 15:50:39 -0400
Message-Id: <1120593039.3157.15.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.25.1 2005-07-05
* Moved role_tty_type_change, reach_sysadm, and priv_user macros from
user.te to user_macros.te as suggested by Steve.
* Modified admin_domain macro so autrace would work and removed privuser
attribute for dhcpc as suggested by Russell Coker.
* Merged rather large patch from Dan Walsh.  Moves targeted/strict/mls
policies closer together.  Adds local.te for users to customize.
Includes minor fixes to auditd, cups, cyrus_imapd, dhcpc, and dovecot.
Includes Russell Coker's patch that defines all ports in network.te.
Ports are always defined now, no ifdefs are used in network.te.  Also
includes Ivan Gyurdiev's user home directory policy patches.  These
patches add alsa, bonobo, ethereal, evolution, gconf, gnome, gnome_vfs,
iceauth, orbit, and thunderbird policy.  They create read_content,
write_trusted, and write_untrusted macros in content.te.  They create
network_home, write_network_home, read_network_home,
base_domain_ro_access, home_domain_access, home_domain, and
home_domain_ro macros in home_macros.te.  They also create
$3_read_content, $3_write_content, and write_untrusted booleans.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
