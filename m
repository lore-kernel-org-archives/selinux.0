Subject: Updated Release
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: selinux@tycho.ncsc.mil
Content-Type: text/plain
Date: 16 Jan 2003 10:31:52 -0500
Message-Id: <1042731115.3597.2297.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site <http://www.nsa.gov/selinux/> including the mail
list archive has been updated. The site includes a new release of the
LSM-based SELinux prototype. The base 2.5 kernel version has been
updated to 2.5.58.  The base 2.4 kernel version remains at 2.4.20, but
the LSM patch and the SELinux module for 2.4 have changed since the last
release.  New contributed policy analysis and policy management tools
have been added to the provided tools and utilities. Hooks for xattr
operations were added to 2.4.  Inode security initialization has been
reworked using the d_instantiate hook.  The nfsd private file bug in 2.4
has been fixed and the task_kill bug in 2.5 has been fixed.  Configuring
the SELinux Policy, a technical report included in the documentation,
has been updated to reflect recent changes.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
