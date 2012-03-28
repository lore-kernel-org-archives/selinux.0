Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2SHFLTj014153
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2012 13:15:21 -0400
Received: by yenq2 with SMTP id q2so1004592yen.12
        for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2012 10:15:20 -0700 (PDT)
From: Bill Chimiak <wch1m1@gmail.com>
To: selinux@tycho.nsa.gov
Subject: User Mode Linux
Date: Wed, 28 Mar 2012 13:14:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201203281314.34713.w.chimiak@ieee.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In trying to run User Mode Linux, I have to do a 
setsebool -P mmap_low_allowed 1

This seems a bad idea.

One thought is to run UMLs on only one machine where the 
mmap_low_allowed is kind of OK.

The other is to toggle mmap_low_allowed when UMLs need to be run
and toggle it off when done.

Any thoughts?

Does Xen VMs have the same problem?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
