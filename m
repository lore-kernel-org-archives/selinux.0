Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9KK6iNs005746
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 16:06:44 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9KK3kN7009260
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 20:03:46 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions [144.51.25.4])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9KK4JJr027917
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 16:04:19 -0400 (EDT)
Subject: Updated Policy in the Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 16:03:18 -0400
Message-Id: <1129838598.25091.25.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.27.2 2005-10-20

* Merged patch from Chad Hanson.  Modified MLS constraints.  Provided
comments for the MLS attributes.

* Merged two patches from Thomas Bleher which made some minor fixes and
cleanups.

* Merged patches from Russell Coker. Added comments to some of the MLS
attributes.  Added the secure_mode_insmod boolean to determine whether
the system permits loading policy, setting enforcing mode, and changing
boolean values. Made minor fixes for the cdrecord_domain macro,
application_domain, newrole_domain, and daemon_base_domain macros.
Added rules to allow the mail server to access the user home directories
in the targeted policy and allows the postfix showq program to do DNS
lookups.  Minor fixes for the MCS policy.  Made other minor fixes and
cleanups.

* Merged patch from Dan Walsh.  Added opencd, pegasus, readahead, and
roundup policies.  Created can_access_pty macro to handle pty output.
Created nsswithch_domain macro for domains using nsswitch.  Added mcs
transition rules.  Removed mqueue and added capifs genfscon entries.
Added dhcpd and pegasus ports.  Added domain transitions from login
domains to pam_console and alsa domains.  Added rules to allow the httpd
and squid domains to relay more protocols.  For the targeted policy,
removed sysadm_r role from unconfined_t.  Made other fixes and cleanups.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
