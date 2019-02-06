Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F648C169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 20:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE4F218B0
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 20:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfBFUd4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfBFUd4 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Feb 2019 15:33:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9069C01DDFE
        for <selinux@vger.kernel.org>; Wed,  6 Feb 2019 20:33:55 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-32.brq.redhat.com [10.40.204.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1118D6155B;
        Wed,  6 Feb 2019 20:33:54 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2] libselinux: Fix RESOURCE_LEAK defects reported by coverity scan
Date:   Wed,  6 Feb 2019 21:33:50 +0100
Message-Id: <20190206203350.27930-1-plautrba@redhat.com>
In-Reply-To: <CAJfZ7=mO29pHKvNH7r6WWabyNth=nJboYU1rP4DpW5E41Q_YQQ@mail.gmail.com>
References: <CAJfZ7=mO29pHKvNH7r6WWabyNth=nJboYU1rP4DpW5E41Q_YQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 06 Feb 2019 20:33:55 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:

libselinux/src/checkAccess.c:93: leaked_storage: Variable "user_context" going out of scope leaks the storage it points to.
libselinux/src/label_db.c:286: leaked_storage: Variable "filp" going out of scope leaks the storage it points to.
libselinux/src/label_db.c:291: leaked_storage: Variable "filp" going out of scope leaks the storage it points to.
libselinux/src/label_file.c:405: leaked_storage: Variable "str_buf" going out of scope leaks the storage it points to.
libselinux/src/load_policy.c:266: leaked_storage: Variable "names" going out of scope leaks the storage it points to.
libselinux/src/selinux_config.c:183: leaked_storage: Variable "end" going out of scope leaks the storage it points to.
libselinux/src/selinux_config.c:184: overwrite_var: Overwriting "end" in "end = type + strlen(type) - 1" leaks the storage that "end" points to.
libselinux/src/selinux_restorecon.c:376: leaked_storage: Variable "new_entry" going out of scope leaks the storage it points to.
libselinux/src/selinux_restorecon.c:855: leaked_storage: Variable "xattr_value" going out of scope leaks the storage it points to.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/checkAccess.c        |  4 +++-
 libselinux/src/label_db.c           |  3 +++
 libselinux/src/label_file.c         |  4 +++-
 libselinux/src/load_policy.c        |  4 +++-
 libselinux/src/selinux_config.c     | 17 +++++++++--------
 libselinux/src/selinux_restorecon.c | 12 ++++++++++--
 6 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 8de57477..16bfcfb6 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -89,8 +89,10 @@ int selinux_check_passwd_access(access_vector_t requested)
 		int retval;
 
 		passwd_class = string_to_security_class("passwd");
-		if (passwd_class == 0)
+		if (passwd_class == 0) {
+			freecon(user_context);
 			return 0;
+		}
 
 		retval = security_compute_av_raw(user_context,
 						     user_context,
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index c46d0a1d..fba96c92 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -283,10 +283,12 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 	}
 	if (fstat(fileno(filp), &sb) < 0) {
 		free(catalog);
+		fclose(filp);
 		return NULL;
 	}
 	if (!S_ISREG(sb.st_mode)) {
 		free(catalog);
+		fclose(filp);
 		errno = EINVAL;
 		return NULL;
 	}
@@ -340,6 +342,7 @@ out_error:
 		free(spec->lr.ctx_trans);
 	}
 	free(catalog);
+	fclose(filp);
 
 	return NULL;
 }
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index dbf51a93..b81fd552 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -317,8 +317,10 @@ end_arch_check:
 			goto out;
 		}
 		rc = next_entry(str_buf, mmap_area, entry_len);
-		if (rc < 0)
+		if (rc < 0) {
+			free(str_buf);
 			goto out;
+		}
 
 		if (str_buf[entry_len - 1] != '\0') {
 			free(str_buf);
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index e9f1264a..20052beb 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -262,8 +262,10 @@ checkbool:
 			rc = security_get_boolean_names(&names, &len);
 			if (!rc) {
 				values = malloc(sizeof(int) * len);
-				if (!values)
+				if (!values) {
+					free(names);
 					goto unmap;
+				}
 				for (i = 0; i < len; i++)
 					values[i] =
 						security_get_boolean_active(names[i]);
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 292728f3..b06cb63b 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -177,8 +177,7 @@ static void init_selinux_config(void)
 
 			if (!strncasecmp(buf_p, SELINUXTYPETAG,
 					 sizeof(SELINUXTYPETAG) - 1)) {
-				selinux_policytype = type =
-				    strdup(buf_p + sizeof(SELINUXTYPETAG) - 1);
+				type = strdup(buf_p + sizeof(SELINUXTYPETAG) - 1);
 				if (!type)
 					return;
 				end = type + strlen(type) - 1;
@@ -187,6 +186,11 @@ static void init_selinux_config(void)
 					*end = 0;
 					end--;
 				}
+				if (setpolicytype(type) != 0) {
+					free(type);
+					return;
+				}
+				free(type);
 				continue;
 			} else if (!strncmp(buf_p, SETLOCALDEFS,
 					    sizeof(SETLOCALDEFS) - 1)) {
@@ -212,13 +216,10 @@ static void init_selinux_config(void)
 		fclose(fp);
 	}
 
-	if (!type) {
-		selinux_policytype = type = strdup(SELINUXDEFAULT);
-		if (!type)
-			return;
-	}
+	if (!selinux_policytype && setpolicytype(SELINUXDEFAULT) != 0)
+		return;
 
-	if (asprintf(&selinux_policyroot, "%s%s", SELINUXDIR, type) == -1)
+	if (asprintf(&selinux_policyroot, "%s%s", SELINUXDIR, selinux_policytype) == -1)
 		return;
 
 	for (i = 0; i < NEL; i++)
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 0f0fd6ca..924d9538 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -351,12 +351,19 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 	new_entry->next = NULL;
 
 	new_entry->directory = strdup(directory);
-	if (!new_entry->directory)
+	if (!new_entry->directory) {
+		free(new_entry);
+		free(sha1_buf);
 		goto oom;
+	}
 
 	new_entry->digest = strdup(sha1_buf);
-	if (!new_entry->digest)
+	if (!new_entry->digest) {
+		free(new_entry->directory);
+		free(new_entry);
+		free(sha1_buf);
 		goto oom;
+	}
 
 	new_entry->result = digest_result;
 
@@ -850,6 +857,7 @@ int selinux_restorecon(const char *pathname_orig,
 
 	if (lstat(pathname, &sb) < 0) {
 		if (flags.ignore_noent && errno == ENOENT) {
+			free(xattr_value);
 			free(pathdnamer);
 			free(pathname);
 			return 0;
-- 
2.20.1

