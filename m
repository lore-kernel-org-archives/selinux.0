Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7JJ2ZrT028984
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 15:02:35 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7JJ1spw006503
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 19:01:54 GMT
Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7JJ2e1H004458
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 15:02:40 -0400 (EDT)
Subject: Updated SELinux release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 19 Aug 2004 15:01:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An updated SELinux release is available from
http://www.nsa.gov/selinux/.  This release is based on Linux 2.6.8.1. 
The stable SELinux kernel now includes revalidation of the controlling
tty upon domain transitions.  The SELinux NFSv3 enhancements now include
revalidation of the inode security attributes from the server.  The core
checkpolicy logic has been moved into libsepol, a library for binary
policy manipulation.  Improved support for using policy booleans has
been integrated into load_policy and init, and many compile-time policy
tunables have been converted to runtime policy booleans.  Updated
userland patches and SRPMS have been merged from the Fedora Core 3
development tree.  A number of contributed patches have been merged for
the example policy and the policy core utilities. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
