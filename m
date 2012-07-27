Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6RIxQEx013283
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 14:59:26 -0400
Received: by yhp26 with SMTP id 26so3693368yhp.12
        for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 11:59:24 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Subject: external/libselinux
Date: Fri, 27 Jul 2012 11:58:41 -0700
Message-Id: <1343415522-31745-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[PATCH] Allow zygote to spawn non matched apps in permissive mode

Revised based on stephens comments.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
