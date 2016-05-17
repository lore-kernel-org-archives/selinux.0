Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4HFRkMC016291
 for <selinux@tycho.nsa.gov>; Tue, 17 May 2016 11:27:46 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 7FEC01A1BB
 for <selinux@tycho.nsa.gov>; Tue, 17 May 2016 17:27:42 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id VeBYZM016wlS for <selinux@tycho.nsa.gov>;
 Tue, 17 May 2016 17:27:40 +0200 (CEST)
Received: from valinor.bigon.be (unknown [193.53.238.201])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 4D1DC1A0D9
 for <selinux@tycho.nsa.gov>; Tue, 17 May 2016 17:27:40 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] semodule: Fix the --list-modules=full example in the manpage
Date: Tue, 17 May 2016 17:27:39 +0200
Message-Id: <1463498859-5911-1-git-send-email-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

---
 policycoreutils/semodule/semodule.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 68e95ab..7b07c45 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -116,7 +116,7 @@ $ semodule \-d alsa
 # Install a module at a specific priority.
 $ semodule \-X 100 \-i alsa.pp
 # List all modules.
-$ semodule \-l full
+$ semodule \-\-list-modules=full
 # Set an alternate path for the policy root
 $ semodule \-B \-p "/tmp"
 # Set an alternate path for the policy store root
-- 
2.8.1
