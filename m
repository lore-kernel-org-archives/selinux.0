Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p49KWCP5008160
	for <selinux@tycho.nsa.gov>; Mon, 9 May 2011 16:32:14 -0400
Received: from fep05-svc.tim.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p49KWDCN016730
	for <selinux@tycho.nsa.gov>; Mon, 9 May 2011 20:32:13 GMT
Subject: [PATCH 0/2 v2]: minor improvements and clean-ups for
 policycoreutils/setfiles
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Lawrence <slawrence@tresys.com>
Date: Mon, 09 May 2011 22:32:06 +0200
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1304973130.2521.69.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

RE-SUBMISSION (originally submitted on Sun, 20 Feb 2011 09:56:42 +0100)

I propose a couple of patches for a few minor and quite obvious
improvements of the userspace tool setfiles.

They are mainly targeting the documentation of previously undocumented
options (a more detailed description is provided in the relative patch
messages that follow).

These two patches must be applied before the following patch is applied:

[PATCH v2]: setfiles should provide an option to avoid abortion on a
missing file


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
