Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6Q1UpZK019367
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2012 21:30:51 -0400
Received: by yenl3 with SMTP id l3so1517200yen.12
        for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2012 18:30:50 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Subject: external/libselinux
Date: Wed, 25 Jul 2012 18:30:07 -0700
Message-Id: <1343266208-4869-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[PATCH] Support for sebool in seapp_contexts

This patch adds support for being able to specify sebool in seapp_contexts.
If sebool is specified, it has ultimate preference over any other specification.

If/Once this patch is accepted I will update the header comment in seapp_contexts.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
