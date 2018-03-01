Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w21B3G0O011456
 for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2018 06:03:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31D6540FB646
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 11:03:14 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA6F79C067
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 11:03:13 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu,  1 Mar 2018 12:03:06 +0100
Message-Id: <20180301110306.16715-1-vmojzis@redhat.com>
In-Reply-To: <20180301105945.15587-1-vmojzis@redhat.com>
References: <20180301105945.15587-1-vmojzis@redhat.com>
Subject: [PATCH] gui/fcontextPage: Set default object class in
 addDialog
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This ensures that user cannot leave the object class selection blank.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 gui/fcontextPage.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
index a6577ef7..370bbee4 100644
--- a/gui/fcontextPage.py
+++ b/gui/fcontextPage.py
@@ -164,6 +164,7 @@ class fcontextPage(semanagePage):
         self.fcontextEntry.set_text("")
         self.fcontextEntry.set_sensitive(True)
         self.fcontextFileTypeCombo.set_sensitive(True)
+        self.fcontextFileTypeCombo.set_active(0)
         self.fcontextTypeEntry.set_text("")
         self.fcontextMLSEntry.set_text("s0")
 
-- 
2.14.3
