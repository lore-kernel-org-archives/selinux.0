Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j07L5TIi018520
	for <selinux@tycho.nsa.gov>; Fri, 7 Jan 2005 16:05:29 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j07L3a0j015348
	for <selinux@tycho.nsa.gov>; Fri, 7 Jan 2005 21:03:36 GMT
Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j07L5lnL028605
	for <selinux@tycho.nsa.gov>; Fri, 7 Jan 2005 16:05:47 -0500 (EST)
Subject: Updated SELinux Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1105131588.28680.379.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 07 Jan 2005 15:59:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An updated SELinux release is available from the NSA SELinux web site;
see http://www.nsa.gov/selinux/news.cfm#R050107.  This release is based
on Linux 2.6.10, but the current SELinux patch for the kernel includes a
number of changes merged after 2.6.10 was released, including the AVC
scalability work, AVC API and statistics support, dynamic context
transition support, and enhanced controls over executable mappings.  The
checkpolicy policy compiler has been updated to order node context
entries and to support supplementary type attribute declarations. 
Several improvements to libselinux, policycoreutils, and policy have
been merged.  Updated versions of setools, slat, and polgen were added. 
The selinux-doc CREDITS file
and Contributors web page have been updated.

As discussed on the list after the last release, we have reduced the NSA
SELinux release to just the core SELinux code, dropping the patched
userland packages, the prepatched kernel tarball, and the full userland
tarball.  Information about obtaining patched userland packages for
various distributions is available from the sourceforge selinux site
(http://selinux.sf.net), and a reference set of SELinux userland patches
is available in the public Fedora CVS tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
