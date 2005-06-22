Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5MJ7cgA020058
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 15:07:38 -0400 (EDT)
Subject: Updated SELinux Release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1110402140.6299.22.camel@moss-spartans.epoch.ncsc.mil>
References: <1110402140.6299.22.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 14:57:10 -0400
Message-Id: <1119466630.13181.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An updated SELinux release is available from the NSA SELinux web site;
see http://www.nsa.gov/selinux/news.cfm#R050622.

This SELinux release is based on Linux 2.6.12.  The 2.6.12 kernel
includes the name_connect permission check for controlling outbound
connections.  The SELinux kernel patch for 2.6.12 includes the execstack
and execheap permission checks contributed by Lorenzo.  The hierarchical
role and type support by Tresys Technology has been merged into libsepol
and checkpolicy.  A new audit2why utility has been added to
policycoreutils to help identify the causes of avc denials. libsepol has
been re-licensed under the LGPL.  Updated versions of setools by Tresys
and polgen by MITRE were added.  A number of patches for the userspace
libraries, tools, and policy were merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
