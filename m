Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBJHq1rO010905
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 12:52:01 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBJHqZj8024886
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 17:52:36 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id kBJHqWim031657
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 12:52:32 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id kBJHqWo7008451
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 12:52:32 -0500
Received: from vpn-14-3.rdu.redhat.com (vpn-14-3.rdu.redhat.com [10.11.14.3])
	by pobox.corp.redhat.com (8.13.1/8.12.8) with ESMTP id kBJHqVJJ013098
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 12:52:31 -0500
Subject: superblock_doinit emits a message for every mount
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 19 Dec 2006 12:52:31 -0500
Message-Id: <1166550751.20187.63.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So I recently heard a complaint that we emit a message every time a FS
is mounted.  In this case they have lots of autofs mounts happening in
turn gets lots of messages like:

Dec 18 16:32:06 buildrm55 kernel: SELinux: initialized (dev 0:39, type
nfs), uses genfs_contexts

They all come from superblock_doinit in hooks.c.

printk(KERN_INFO "SELinux: initialized (dev %s, type %s), %s\n",
       sb->s_id, sb->s_type->name,
       labeling_behaviors[sbsec->behavior-1]);

which fill their logs.  They wanted to know if we were willing to give a
way to turn such informational messages off.  I can discuss with
them /proc/sys/kernel/printk and configuring syslog to ignore
kernel.info but I wondered if anyone else had any comments or thought
about these particular messages.  Do we need them?  Are they really
anything other than debugging?

-Eric



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
