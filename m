Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB7KSfMA003090
	for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2005 15:28:41 -0500 (EST)
Subject: ANN: Updated SELinux Release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1126110201.14896.80.camel@moss-spartans.epoch.ncsc.mil>
References: <1110402140.6299.22.camel@moss-spartans.epoch.ncsc.mil>
	 <1119466630.13181.175.camel@moss-spartans.epoch.ncsc.mil>
	 <1126110201.14896.80.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 15:28:41 -0500
Message-Id: <1133987321.2366.124.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An updated SELinux release is available from the NSA SELinux web site;
see
http://www.nsa.gov/selinux/news.cfm#R051207

This release is based on Linux 2.6.14.  The SELinux kernel patch for
2.6.14 includes support for canonicalization of getxattr results by
SELinux, support for userspace to obtain canonical contexts via
selinuxfs, a compatibility fix for MLS file contexts on non-MLS systems,
and a fix to prevent setting SELinux attributes on inodes created in
mountpoint labeled filesystems.  All of these changes have already been
upstreamed into Linus' git tree for inclusion in 2.6.15.

In userspace, a number of enhancements to the libraries and utilities
have been merged.  These enhancements include support for mapping Linux
users to SELinux users and ranges via seusers without requiring policy
modifications, a major reworking of the policy management and policy
module support including major updates to libsepol, checkpolicy,
libsemanage and policycoreutils, and centralization of and improvements
to the policy loading logic.

Note that pam_selinux and SELinux userland patches for programs such as
gdm, sshd, and crond have been modified in order to take advantage of
the seusers mechanism for mapping Linux users to SELinux users and
ranges. Similarly, the SELinux patch for SysVinit has been modified in
order to use the new policy loading logic provided by libselinux.
Please refer to the Fedora Core public CVS tree for updated SELinux
userland patches in order to port these updates to other distributions
as appropriate.

With regard to the policy management and module support, this release
introduces the first version of libsemanage to provide a shared library
and that includes support for managing some (but not yet all) non-module
policy components.  Note that the policy module package format has
changed incompatibly since the prior nsa.gov SELinux release, as
discussed on the list, but any future changes will provide proper
compatibility support.  The module utilities have been significantly
overhauled and manual pages have been created for them.  setsebool has
been reworked to include support for the policy management
infrastructure.  audit2allow has been rewritten in python and extended
to support generation of policy modules. genhomedircon has been partly
converted to support the policy management infrastructure; there is
still a lingering issue with expanding the ROLE macro in
homedir_template for users, so manual updating of file_contexts.homedirs
is necessary for non-user_r users if using policy managed via
libsemanage.

Although this release includes an updated copy of the example policy,
this will likely be the last such release before a final snapshot of the
example policy is archived to the historical versions page.  Further
work on this policy has been superseded by the SELinux reference policy
project, see http://serefpolicy.sourceforge.net.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
