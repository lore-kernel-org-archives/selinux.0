Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3TK3dgA006829
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2005 16:03:40 -0400 (EDT)
Subject: Updated Policy in Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Apr 2005 16:04:06 -0400
Message-Id: <1114805046.6480.15.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.23.14 2005-04-29

* Added afs policy from Andrew Reisse.

* Merged patch from Lorenzo Hernández García-Hierro which defines
execstack and execheap permissions.  The patch excludes these
permissions from general_domain_access and updates the macros for X,
legacy binaries, users, and unconfined domains.

* Added nlmsg_relay permisison where netlink_audit_socket class is used.
Added nlmsg_readpriv permission to auditd_t and auditctl_t.

* Merged some minor cleanups from Russell Coker and David Hampton.

* Merged patch from Dan Walsh.  Many changes made to allow targeted
policy to run closer to strict and now almost all of non-userspace is
protected via SELinux.  Kernel is now in unconfined_domain for targeted
and runs as root:system_r:kernel_t.  Added transitionbool to
daemon_sub_domain, mainly to turn off httpd_suexec transitioning.
Implemented web_client_domain name_connect rules.  Added yp support for
cups.  Now the real hotplug, udev, initial_sid_contexts are used for the
targeted policy.  Other minor cleanups and fixes.  Auditd fixes by Paul
Moore.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
