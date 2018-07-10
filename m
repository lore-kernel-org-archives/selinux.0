Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6A8uhsJ017062
 for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2018 04:56:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70F26402315B
 for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2018 08:56:39 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1122B7C55
 for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2018 08:56:38 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 10 Jul 2018 10:56:34 +0200
Message-Id: <20180710085634.5671-1-vmojzis@redhat.com>
In-Reply-To: <CAJfZ7=nuYJ-=RHzCkiTkvt5-T+hG9GJgQtiz7X6AYHoorYwGsQ@mail.gmail.com>
References: <CAJfZ7=nuYJ-=RHzCkiTkvt5-T+hG9GJgQtiz7X6AYHoorYwGsQ@mail.gmail.com>
Subject: [PATCH] python/semanage: Replace bare except with specific
 one
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The corresponding except clause should only be used for
exceptions caused by audit module error or unavailability.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 29b4afe0..78ffb091 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -140,7 +140,7 @@ try:
 
             self.log_list = []
             self.log_change_list = []
-except:
+except OSError, ImportError:
     class logger:
 
         def __init__(self):
-- 
2.14.3
