Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n625Vpnw013446
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 01:31:51 -0400
Received: from mail-px0-f202.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n625VYvW014527
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 05:31:35 GMT
Received: by pxi40 with SMTP id 40so129340pxi.32
        for <selinux@tycho.nsa.gov>; Wed, 01 Jul 2009 22:31:50 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: selinux@tycho.nsa.gov
Subject: SELinux-non-trivial-fixes.
Date: Wed,  1 Jul 2009 22:32:39 -0700
Message-Id: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I decided to sit and manually write out all of the SELinux
area(or at least some of it). So along the way
whenever I saw what might need a bit of cleaning up
I wrote it down, and then once finished
created a patch to submit for you guy's to decide.
 
So here you go(still need to go into the other directories,
and will later on) but for now hope you like what you see,
and if you see something that might need changing send me a post. 



 security/selinux/avc.c       |   21 ++--
 security/selinux/hooks.c     |  265 +++++++++++++++++++++---------------------
 security/selinux/netif.c     |   12 +-
 security/selinux/netlabel.c  |   10 +-
 security/selinux/netnode.c   |   20 ++--
 security/selinux/netport.c   |   12 +-
 security/selinux/selinuxfs.c |   61 +++++-----
 security/selinux/xfrm.c      |   26 ++--
 8 files changed, 213 insertions(+), 214 deletions(-)




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
