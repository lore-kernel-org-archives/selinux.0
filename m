Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4HKrcNU024232
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 16:53:38 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 46B9156475F
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 22:53:31 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsepol: remove unused attribute on a used argument
Date: Wed, 17 May 2017 22:53:24 +0200
Message-Id: <20170517205324.18805-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since commit 58962eb3d847 ("libsepol,checkpolicy: add binary module
support for xperms") function display_avrule() has been using its "p"
argument even though it was previously marked unused. This makes clang
report:

    policydb.c:3276:7: error: 'p' was marked unused but was used
    [-Werror,-Wused-but-marked-unused].
        if (p->policyvers < MOD_POLICYDB_VERSION_XPERMS_IOCTL) {
            ^

Remove the attribute to make the code consistent again.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 069eb7e66540..b1530955aa39 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3212,8 +3212,7 @@ common_read, class_read, role_read, type_read, user_read,
 
 /************** module reading functions below **************/
 
-static avrule_t *avrule_read(policydb_t * p
-			     __attribute__ ((unused)), struct policy_file *fp)
+static avrule_t *avrule_read(policydb_t * p, struct policy_file *fp)
 {
 	unsigned int i;
 	uint32_t buf[2], len;
-- 
2.13.0
