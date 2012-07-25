Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6PKcsgb006942
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2012 16:38:54 -0400
Received: by yenl3 with SMTP id l3so1282046yen.12
        for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2012 13:38:53 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Subject: kernel/omap seandroid-tuna-3.0
Date: Wed, 25 Jul 2012 13:38:14 -0700
Message-Id: <1343248695-32278-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[PATCH] Support older compilers by wrapping smc .arch

The earlier patch broke 4.4.0 builds, but it looks like 4.4.0
is no longer supported as other kernel erros spew when building
with that toolchain. However, I don't think that my patch should
be the one to break backwards compatability.

Opinions appreciated!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
