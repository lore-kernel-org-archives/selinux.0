Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4HEZeEZ004293
 for <selinux@tycho.nsa.gov>; Tue, 17 May 2016 10:35:40 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 2138C1A1BB
 for <selinux@tycho.nsa.gov>; Tue, 17 May 2016 16:35:38 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id p61H1YqnNqrE for <selinux@tycho.nsa.gov>;
 Tue, 17 May 2016 16:35:36 +0200 (CEST)
Received: from valinor.bigon.be (unknown [193.53.238.201])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 41D9F1A0D9
 for <selinux@tycho.nsa.gov>; Tue, 17 May 2016 16:35:36 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2] policycoreutils: Minor fix in a French translation
Date: Tue, 17 May 2016 16:35:36 +0200
Message-Id: <1463495736-4529-1-git-send-email-bigon@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

---
 policycoreutils/po/fr.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/po/fr.po b/policycoreutils/po/fr.po
index be33d59..5c797c9 100644
--- a/policycoreutils/po/fr.po
+++ b/policycoreutils/po/fr.po
@@ -1307,7 +1307,7 @@ msgstr "syntaxe :  %s [-q]\n"
 #: ../load_policy/load_policy.c:71
 #, c-format
 msgid "%s:  Policy is already loaded and initial load requested\n"
-msgstr "La stratégie %s est déjà chargée et un chargement initial est requis\n"
+msgstr "%s : La stratégie est déjà chargée et un chargement initial est demandé\n"
 
 #: ../load_policy/load_policy.c:80
 #, c-format
-- 
2.8.1
