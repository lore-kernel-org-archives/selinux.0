Subject: [patch 0/3] selinux: fix of selinuxfs inode number assigning and
	cleanup of selinuxfs
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 16:18:30 -0400
Message-Id: <1175717910.14463.69.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set fixes a potential problem of inode number conflicts in
selinuxfs, makes numbering the inodes in the booleans directory
consistent with what is done for the initial_contexts directory, and
removes an unused enumeration constant.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
