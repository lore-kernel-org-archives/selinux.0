Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1R1KtDq018320
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 20:21:13 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1QHnMGK015536
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 17:50:37 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j1QHn1nP010561
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 12:49:17 -0500 (EST)
Subject: security files - why not sysadmfile
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sat, 26 Feb 2005 12:52:28 -0500
Message-Id: <1109440349.11452.7.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why are those types not marked sysadmfile?
This is particularly annoying when vi spits out
error messages every time I edit a selinux source file.

#
# security_t is the target type when checking
# the permissions in the security class.  It is also
# applied to selinuxfs inodes.
#
type security_t, fs_type;

#
# policy_config_t is the type of /etc/security/selinux/*
# the security server policy configuration.
#
type policy_config_t, file_type;

#
# policy_src_t is the type of the policy source
# files.
#
type policy_src_t, file_type;

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
