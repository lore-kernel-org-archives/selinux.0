Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6RJgx3i015936
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 15:42:59 -0400
Received: by ghbz13 with SMTP id z13so3736285ghb.12
        for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 12:42:58 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Subject: external/libselinux
Date: Fri, 27 Jul 2012 12:42:02 -0700
Message-Id: <1343418124-3562-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch series enables supoprt for two features:
1. Allow the specification of an sebool flag in seapp_contexts, cleaned up
   per Stephen's requests. A specified sebool= is matched over unspecified 
   sebool=.

2. Allowing spawned apps to launch in the Zygote's context when SELinux
   is in permissive mode and a match is not found.

[PATCH 1/2] Allow zygote to spawn non matched apps in permissive mode
[PATCH 2/2] You can now specify a sebool= flag in seapp_contexts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
