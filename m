Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6QIqumM007435
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 14:52:56 -0400
Received: by ghbz13 with SMTP id z13so2445307ghb.12
        for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 11:52:54 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Subject: kernel/omap
Date: Thu, 26 Jul 2012 11:52:09 -0700
Message-Id: <1343328730-10603-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[PATCH] Fix for build error no support ARM mode `smc #0'

Updated incorrect compiler version check logic

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
