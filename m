Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h412eXI4008240
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 22:40:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h412eNVf021298
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 02:40:23 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h412eL4D021295
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 02:40:22 GMT
Date: Thu, 1 May 2003 12:40:28 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: selinux@tycho.nsa.gov
Subject: Kernel Patch 2.4.20
Message-ID: <20030501024028.GC13019@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From Russell's kernel patch, version 2003.04.07-1.

-int init_private_file(struct file *filp, struct dentry *dentry, int mode)
+int open_private_file(struct file *filp, struct dentry *dentry, int flags)

Is there any good reason for renaming this function?

Is the new function backword compatable with the old version?

This change breaks the UML HPPFS filesystem (whatever that is...) which
has a number of calls to init_private_file.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
