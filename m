Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n62HjNGN023586
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 13:45:23 -0400
Received: from mail-pz0-f188.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n62Hk0w8029073
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 17:46:01 GMT
Received: by pzk26 with SMTP id 26so177366pzk.32
        for <selinux@tycho.nsa.gov>; Thu, 02 Jul 2009 10:45:22 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: selinux@tycho.nsa.gov
Subject: SELinux-Fix-some-typos.
Date: Thu,  2 Jul 2009 10:46:14 -0700
Message-Id: <1246556775-8942-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After receiving some feedback about the patches
I had sumbmitted yeasterday, I decided to go
back and resubmit them so they don't create
so much churn(just focus on typos).


 security/selinux/avc.c      |    6 +++---
 security/selinux/hooks.c    |    4 ++--
 security/selinux/netlabel.c |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
