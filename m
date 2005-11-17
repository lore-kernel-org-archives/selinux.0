Received: from moss-lions.epoch.ncsc.mil (moss-lions [144.51.25.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAHJ6dMA013323
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 14:06:39 -0500 (EST)
Subject: Updated Policy in the Sourceforge CVS
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 13:58:20 -0500
Message-Id: <1132253900.3004.8.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.27.3 2005-11-17

* Removed the seuser policy as suggested by Kevin Carr on Nov 7th.

* Removed unnecessary allow rule concerning tmpfs_t in the squid policy
as suggested by Russell Coker on Oct 27th.

* Merged a patch from Jonathan Kim on Nov 10th which modified the
restorecon policy to use the secadmin attribute.

* Merged a patch from Dan Walsh's cvs.  Added avahi, exim, and yppasswdd
policies.  Added the unconfinedtrans attribute for domains that can
transistion to unconfined_t.  Added httpd_enable_ftp_server,
allow_postgresql_use_pam, pppd_can_insmod, and allow_gssd_read_tmp
booleans.  Created a $1_disable_trans boolean used in the
init_service_domain macro to specify whether init should transition to a
new domain when executing.  Included Chad Hanson's patch which adds the
mls* attributes to more domains and makes other changes to support MLS.
Included Russell Coker's patch which makes many changes to the sendmail
policy.  Added rules to allow initscripts to execute scripts that they
generate.  Added dbus support to the named policy.  Made other fixes and
cleanups to various policies including amanda, apache, bluetooth,
pegasus, postfix, pppd, and slapd.  Removed sendmail policy from
targeted.
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
