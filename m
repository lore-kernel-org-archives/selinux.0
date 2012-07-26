Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6QLilgw017295
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 17:44:47 -0400
Received: by yhp26 with SMTP id 26so2659369yhp.12
        for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 14:44:46 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Subject: external/libselinux
Date: Thu, 26 Jul 2012 14:44:04 -0700
Message-Id: <1343339045-19207-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[PATCH] Allow zygote to spawn non matched apps in permissive mode

Adding support for apps not to be killed on a non-match in seapp
contexts if the selinux enforcing mode is permissive. Currently
it sends denials using selinux_log with it set to SELINUX_ERROR,
but it should probably use the auditing function which currently
is not implemented.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
