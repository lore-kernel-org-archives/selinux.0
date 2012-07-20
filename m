Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6K5U9nw018904
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2012 01:30:09 -0400
Received: by yenl3 with SMTP id l3so3777639yen.12
        for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2012 22:30:08 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Subject: kernel/omap seandroid-omap-tuna-3.0
Date: Thu, 19 Jul 2012 22:29:42 -0700
Message-Id: <1342762183-22189-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[PATCH] Fix for build error no support ARM mode `smc #0'

Fix for build tool not knowing how to deal with trustzone smc
instruction.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
