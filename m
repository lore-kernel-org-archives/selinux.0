Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1N46tdW027776
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 23:06:55 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1N44Wat003328
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 04:04:32 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j1N44VJL016302
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 23:04:31 -0500 (EST)
Subject: Strange staff role problems...
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 22 Feb 2005 23:07:24 -0500
Message-Id: <1109131644.5285.10.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What does this mean, exactly, and what can cause it?

Feb 22 22:19:15 cobra kernel: inode_doinit_with_dentry:
context_to_sid([username]:object_r:staff_home_dir_t) returned 22 for
dev=dm-2 ino=324481

Feb 22 22:20:44 cobra kernel: inode_doinit_with_dentry:
context_to_sid([username]:object_r:staff_home_t) returned 22 for
dev=dm-2 ino=324482

Something's broken on my machine. I had to reboot,
and then gdm said my home directory is missing (which it isn't - 
apparently it sees unlabeled context, which doesn't make any sense 
either, because ls -Z shows staff_home_dir_t).

Then I enable permissive mode, start X, and it creates unlabeled_t 
Xauthority file. Restorecon properly restores that to staff_home_t.

What could be the problem?
I have all the right users and roles, I think
in /etc/selinux/strict/users/local.users

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
