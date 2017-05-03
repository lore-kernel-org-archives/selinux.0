Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfN029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA6BFC04B320
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:01 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 08/19] sepolicy: We should be creating _exec interfaces when
 we create the domtrans interface
Date: Wed,  3 May 2017 12:30:25 +0200
Message-Id: <20170503103036.17514-9-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Dan Walsh <dwalsh@redhat.com>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/templates/executable.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/templates/executable.py b/python/sepolicy/sepolicy/templates/executable.py
index 4cc5bfa4..456a7ca8 100644
--- a/python/sepolicy/sepolicy/templates/executable.py
+++ b/python/sepolicy/sepolicy/templates/executable.py
@@ -220,7 +220,7 @@ if_program_rules="""
 
 ########################################
 ## <summary>
-##	Execute TEMPLATE in the TEMPLATETYPE domin.
+##	Execute TEMPLATETYPE_exec_t in the TEMPLATETYPE domin.
 ## </summary>
 ## <param name=\"domain\">
 ## <summary>
@@ -236,6 +236,25 @@ interface(`TEMPLATETYPE_domtrans',`
 	corecmd_search_bin($1)
 	domtrans_pattern($1, TEMPLATETYPE_exec_t, TEMPLATETYPE_t)
 ')
+
+######################################
+## <summary>
+##	Execute TEMPLATETYPE in the caller domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`TEMPLATETYPE_exec',`
+	gen_require(`
+		type TEMPLATETYPE_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	can_exec($1, TEMPLATETYPE_exec_t)
+')
 """
 
 if_user_program_rules="""
-- 
2.12.2
