Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfM029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 52BC680C09
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:00 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 07/19] sepolicy: ptrace should be a part of deny_ptrace
 boolean in TEMPLATETYPE_admin
Date: Wed,  3 May 2017 12:30:24 +0200
Message-Id: <20170503103036.17514-8-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Miroslav Grepl <mgrepl@redhat.com>

Signed-off-by: Dan Walsh <dwalsh@redhat.com>
---
 python/sepolicy/sepolicy/templates/executable.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/templates/executable.py b/python/sepolicy/sepolicy/templates/executable.py
index 0db6b9cc..4cc5bfa4 100644
--- a/python/sepolicy/sepolicy/templates/executable.py
+++ b/python/sepolicy/sepolicy/templates/executable.py
@@ -419,8 +419,12 @@ interface(`TEMPLATETYPE_admin',`
 if_middle_admin="""
 	')
 
-	allow $1 TEMPLATETYPE_t:process { ptrace signal_perms };
+	allow $1 TEMPLATETYPE_t:process { signal_perms };
 	ps_process_pattern($1, TEMPLATETYPE_t)
+
+    tunable_policy(`deny_ptrace',`',`
+        allow $1 TEMPLATETYPE_t:process ptrace;
+    ')
 """
 
 if_initscript_admin_types="""
-- 
2.12.2
