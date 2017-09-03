Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v83CL5f4026262
 for <selinux@tycho.nsa.gov>; Sun, 3 Sep 2017 08:21:09 -0400
Received: from localhost.localdomain (abo-140-56-69.avi.modulonet.fr
 [85.69.56.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 96DE35646D1
 for <selinux@tycho.nsa.gov>; Sun,  3 Sep 2017 14:20:01 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  3 Sep 2017 14:19:25 +0200
Message-Id: <20170903121928.24024-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170903121928.24024-1-nicolas.iooss@m4x.org>
References: <20170903121928.24024-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 3/6] libsepol/cil: fix -Wwrite-strings warning
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

cil_defaults_to_policy() defines its third argument as non-const "char
*kind" even though it is called with literal strings. This makes gcc
report the following warning when compiling with -Wwrite-strings:

    ../cil/src/cil_policy.c: In function ‘cil_gen_policy’:
    ../cil/src/cil_policy.c:1931:60: error: passing argument 3 of
    ‘cil_defaults_to_policy’ discards ‘const’ qualifier from pointer
    target type [-Werror=discarded-qualifiers]

      cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_USER],
                             "default_user");
                             ^~~~~~~~~~~~~~

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 729b6e06e9c5..6d4987c4e4e6 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -775,7 +775,7 @@ static void cil_classes_to_policy(FILE *out, struct cil_list *classorder)
 	}
 }
 
-static void cil_defaults_to_policy(FILE *out, struct cil_list *defaults, char *kind)
+static void cil_defaults_to_policy(FILE *out, struct cil_list *defaults, const char *kind)
 {
 	struct cil_list_item *i1, *i2, *i3;
 	struct cil_default *def;
-- 
2.14.1
