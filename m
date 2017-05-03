Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfL029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:30:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD88161B9C
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:30:56 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 06/19] Fix up generation of application policy
Date: Wed,  3 May 2017 12:30:23 +0200
Message-Id: <20170503103036.17514-7-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Dan Walsh <dwalsh@redhat.com>

Signed-off-by: Dan Walsh <dwalsh@redhat.com>
---
 python/sepolicy/sepolicy-generate.8              | 2 +-
 python/sepolicy/sepolicy/templates/executable.py | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy-generate.8 b/python/sepolicy/sepolicy-generate.8
index 2e674568..0c5f998f 100644
--- a/python/sepolicy/sepolicy-generate.8
+++ b/python/sepolicy/sepolicy-generate.8
@@ -13,7 +13,7 @@ Common options
 Confined Applications
 
 .br
-.B sepolicy generate \-\-application [\-n NAME] command [\-w WRITE_PATH ]
+.B sepolicy generate \-\-application [\-n NAME] [\-u USER ]command [\-w WRITE_PATH ]
 .br
 .B sepolicy generate \-\-cgi [\-n NAME] command [\-w WRITE_PATH ]
 .br
diff --git a/python/sepolicy/sepolicy/templates/executable.py b/python/sepolicy/sepolicy/templates/executable.py
index 4b9534d3..0db6b9cc 100644
--- a/python/sepolicy/sepolicy/templates/executable.py
+++ b/python/sepolicy/sepolicy/templates/executable.py
@@ -86,6 +86,7 @@ roleattribute system_r TEMPLATETYPE_roles;
 type TEMPLATETYPE_t;
 type TEMPLATETYPE_exec_t;
 application_domain(TEMPLATETYPE_t, TEMPLATETYPE_exec_t)
+role TEMPLATETYPE_roles types TEMPLATETYPE_t;
 
 permissive TEMPLATETYPE_t;
 """
-- 
2.12.2
