Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i44MjsRb015861
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 18:45:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i44Mhd5b005697
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 22:43:39 GMT
Received: from smtp801.mail.sc5.yahoo.com (smtp801.mail.sc5.yahoo.com [66.163.168.180])
	by jazzswing.ncsc.mil  with SMTP id i44Mhcql005694
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 22:43:38 GMT
Received: from xtl1.xtl.tenegg.com (localhost.localdomain [127.0.0.1])
	by xtl1.xtl.tenegg.com (8.12.10/8.12.10) with ESMTP id i44Mjoh6026749
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 15:45:50 -0700
Received: (from mitch@localhost)
	by xtl1.xtl.tenegg.com (8.12.10/8.12.10/Submit) id i44MjoYV026747
	for selinux@tycho.nsa.gov; Tue, 4 May 2004 15:45:50 -0700
Date: Tue, 4 May 2004 15:45:49 -0700
From: Tom Mitchell <mitch48@sbcglobal.net>
To: selinux@tycho.nsa.gov
Subject: Label for /.autofsck
Message-ID: <20040504224549.GC25599@xtl1.xtl.tenegg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



I noticed this recently:

/usr/sbin/setfiles:  relabeling /.autofsck from system_u:object_r:root_t to system_u:object_r:default_t

What is the correct label?


-- 
	T o m  M i t c h e l l 
	/dev/null the ultimate in secure storage.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
