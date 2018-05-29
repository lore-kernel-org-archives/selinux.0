Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4TFEm0c031147
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 11:14:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 40wHKZ5QyNz19YjW
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 15:13:06 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 40wHKY6tX9z19Yj4
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 15:13:05 +0000 (UTC)
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id D22051A0C0
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 17:13:00 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id et-VDWdw6Y8F for <selinux@tycho.nsa.gov>;
 Tue, 29 May 2018 17:12:39 +0200 (CEST)
Received: from valinor.bigon.be (unknown [193.53.238.201])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 94CE41A055
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 17:12:39 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Date: Tue, 29 May 2018 17:12:38 +0200
Message-Id: <20180529151238.7956-1-bigon@debian.org>
Subject: [PATCH] policycoreutils: Fix typo in newrole.1 manpage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

---
 policycoreutils/newrole/newrole.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/newrole/newrole.1 b/policycoreutils/newrole/newrole.1
index 0d9738a1..893c42f7 100644
--- a/policycoreutils/newrole/newrole.1
+++ b/policycoreutils/newrole/newrole.1
@@ -44,7 +44,7 @@ specified by that range.  If the
 or
 .B --preserve-environment
 option is specified, the shell with the new SELinux context will preserve environment variables,
-otherwise a new minimal enviroment is created.
+otherwise a new minimal environment is created.
 .PP
 Additional arguments
 .I ARGS
-- 
2.17.0
