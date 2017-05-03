Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfO029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE368A89D
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:02 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 09/19] Fix typo in  executable.py template.
Date: Wed,  3 May 2017 12:30:26 +0200
Message-Id: <20170503103036.17514-10-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Miroslav Grepl <mgrepl@redhat.com>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/templates/executable.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/templates/executable.py b/python/sepolicy/sepolicy/templates/executable.py
index 456a7ca8..f2679938 100644
--- a/python/sepolicy/sepolicy/templates/executable.py
+++ b/python/sepolicy/sepolicy/templates/executable.py
@@ -220,7 +220,7 @@ if_program_rules="""
 
 ########################################
 ## <summary>
-##	Execute TEMPLATETYPE_exec_t in the TEMPLATETYPE domin.
+##	Execute TEMPLATETYPE_exec_t in the TEMPLATETYPE domain.
 ## </summary>
 ## <param name=\"domain\">
 ## <summary>
-- 
2.12.2
