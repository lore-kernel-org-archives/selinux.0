Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C1C433F5
	for <selinux@archiver.kernel.org>; Thu,  3 Feb 2022 16:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiBCQxt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:53:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352453AbiBCQxp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Feb 2022 11:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643907225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGv6bPtumEMo8FJ1eMId97fCbbf94xuAltSewWRlwEA=;
        b=LlLSnltKsYaMj0nHpIZv1avngIe9EidxwTJbwaF+iP9sfQXsm/4YWRusAPcNsHA+Q2kaOt
        gtJS7nLYQwbYCyYE4nrz/0CDEnC3dus7GsRa6k5oktB25pnsEkkzixQHyAwJmNUcaG1roF
        eNaF/9IzF7EJXV3X/A/31zT+X/GQcCg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-YO1ZLoosMQqMSg9Zl4jUXA-1; Thu, 03 Feb 2022 11:53:44 -0500
X-MC-Unique: YO1ZLoosMQqMSg9Zl4jUXA-1
Received: by mail-ed1-f71.google.com with SMTP id w15-20020a056402268f00b00408234dc1dfso1755595edd.16
        for <selinux@vger.kernel.org>; Thu, 03 Feb 2022 08:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGv6bPtumEMo8FJ1eMId97fCbbf94xuAltSewWRlwEA=;
        b=LpMH6MiNo1QoFiDRUQDt10eJS47ZA5zVzXY3QM6bgH3oZPQCnwPt9Unetb1Lvq8TXb
         yeoQEyii9ifS4yjq8pI1wwyhFGhSQshfyf76JJ9WijZC9SfT3oUDSJ1/IFggMQ4ZDXQS
         Jq/Ly9K/5wIE9OxlDp2XtF13yVAG/+aCA5yv3iwMiSjtNsDCfiXX5IRcT0YQRojQwc+n
         kb3hpfkQnZMmBrvwhvXb4mQiJrHg1EpxfVcGHcA3hta3D/XMTaTbTFsEcYoz/A3MGJIu
         EPrg0dh9vp7vToIysqltmlWfgkGFoXY0f9rVaD3XWM5yI1FqhqmPM52l5ECTvUwnE2a+
         tTFQ==
X-Gm-Message-State: AOAM53111Ff5M4oQGrCRte/1fQgdOVEVwyhmgyDYhLrtDma/pUH1u47T
        +PaV42YCJXud5fnF+MSYZpnbzeOEnOOFYQynU7W/SGNCQYfWqExS3O8A8/RC1nDS5b/8OcgOOEf
        G47McHBsZVgULa+fayNvu04KiXJ1Uliw+m42uuu7YpirFQKY3ZUjtCgLDkKs7IWtmRlzCYw==
X-Received: by 2002:a05:6402:35d0:: with SMTP id z16mr36287029edc.149.1643907222097;
        Thu, 03 Feb 2022 08:53:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5PPdSsF23fHTl/T692kvYiTNt3k7KcBy5BxHkSo5Pz7PvSbi2OwALi4fFgLjXKDZg1lPUDA==
X-Received: by 2002:a05:6402:35d0:: with SMTP id z16mr36286998edc.149.1643907221603;
        Thu, 03 Feb 2022 08:53:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id bs4sm18141027edb.84.2022.02.03.08.53.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:53:41 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 5/6] libsemanage: optionally rebuild policy when modules are changed externally
Date:   Thu,  3 Feb 2022 17:53:26 +0100
Message-Id: <20220203165327.213601-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203165327.213601-1-omosnace@redhat.com>
References: <20220203165327.213601-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In Fedora/RHEL's selinux-policy package we ship a pre-built SELinux
policy store in the RPMs. When updating the main policy RPM, care must
be taken to rebuild the policy using `semodule -B` if there are any
other SELinux modules installed (whether shipped via another RPM or
manually installed locally).

However, this way of shipping/managing the policy creates complications
on systems, where system files are managed by rpm-ostree (such as Fedora
CoreOS or Red Hat CoreOS), where the "package update" process is more
sophisticated.

(Disclaimer: The following is written according to my current limited
understanding of rpm-ostree and may not be entirely accurate, but the
gist of it should match the reality.)

Basically, one can think of rpm-ostree as a kind of Git for system
files. The package content is provided on a "branch", where each
"commit" represents a set of package updates layered on top of the
previous commit (i.e. it is a rolling release with some defined
package content snapshots). The user can then maintain their own branch
with additional package updates/installations/... and "rebase" it on top
of the main branch as needed. On top of that, the user can also have
additional configuration files (or modifications to existing files) in
/etc, which represent an additional layer on top of the package content.

When updating the system (i.e. rebasing on a new "commit" of the "main
branch"), the files on the running system are not touched and the new
system state is prepared under a new root directory, which is chrooted
into on the next reboot.

When an rpm-ostree system is updated, there are three moments when the
SELinux module store needs to be rebuilt to ensure that all modules are
included in the binary policy:
1. When the local RPM installations are applied on top of the base
   system snapshot.
2. When local user configuartion is applied on top of that.
3. On system shutdown, to ensure that any changes in local configuration
   performed since (2.) are reflected in the final new system image.

Forcing a full rebuild at each step is not optimal and in many cases is
not necessary, as the user may not have any custom modules installed.

Thus, this patch extends libsemanage to compute a checksum of the
content of all enabled modules, which is stored in the store, and adds a
flag to the libsemanage handle that instructs it to check the module
content checksum against the one from the last successful transaction
and force a full policy rebuild if they don't match.

This will allow rpm-ostree systems to potentially reduce delays when
reconciling the module store when applying updates.

I wasn't able to measure any noticeable overhead of the hash
computation, which is now added for every transaction (both before and
after this change a full policy rebuild took about 7 seconds on my test
x86 VM). With the new option check_ext_changes enabled, rebuilding a
policy store with unchanged modules took only about 0.96 seconds.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/include/semanage/handle.h |   5 +
 libsemanage/src/direct_api.c          | 187 +++++++++++++++++++++-----
 libsemanage/src/handle.c              |  11 +-
 libsemanage/src/handle.h              |   1 +
 libsemanage/src/libsemanage.map       |   1 +
 libsemanage/src/modules.c             |   4 +-
 libsemanage/src/modules.h             |   3 +
 libsemanage/src/semanage_store.c      |   1 +
 libsemanage/src/semanage_store.h      |   1 +
 9 files changed, 175 insertions(+), 39 deletions(-)

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index 946d69bc..0157be4f 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -66,6 +66,11 @@ extern void semanage_set_reload(semanage_handle_t * handle, int do_reload);
  * 1 for yes, 0 for no (default) */
 extern void semanage_set_rebuild(semanage_handle_t * handle, int do_rebuild);
 
+/* set whether to rebuild the policy on commit when potential changes
+ * to module files since last rebuild are detected,
+ * 1 for yes (default), 0 for no */
+extern void semanage_set_check_ext_changes(semanage_handle_t * handle, int do_check);
+
 /* Fills *compiler_path with the location of the hll compiler sh->conf->compiler_directory_path
  * corresponding to lang_ext.
  * Upon success returns 0, -1 on error. */
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index f0bd7716..d83941b0 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -33,6 +33,8 @@
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
 #include <limits.h>
 #include <errno.h>
 #include <dirent.h>
@@ -56,8 +58,7 @@
 #include "semanage_store.h"
 #include "database_policydb.h"
 #include "policy.h"
-#include <sys/mman.h>
-#include <sys/wait.h>
+#include "sha256.h"
 
 #define PIPE_READ 0
 #define PIPE_WRITE 1
@@ -450,7 +451,7 @@ static int parse_module_headers(semanage_handle_t * sh, char *module_data,
 /* Writes a block of data to a file.  Returns 0 on success, -1 on
  * error. */
 static int write_file(semanage_handle_t * sh,
-		      const char *filename, char *data, size_t num_bytes)
+		      const char *filename, const char *data, size_t num_bytes)
 {
 	int out;
 
@@ -850,8 +851,21 @@ cleanup:
 	return ret;
 }
 
+static void update_checksum_with_len(Sha256Context *context, size_t s)
+{
+	int i;
+	uint8_t buffer[8];
+
+	for (i = 0; i < 8; i++) {
+		buffer[i] = s & 0xff;
+		s >>= 8;
+	}
+	Sha256Update(context, buffer, 8);
+}
+
 static int semanage_compile_module(semanage_handle_t *sh,
-				semanage_module_info_t *modinfo)
+				   semanage_module_info_t *modinfo,
+				   Sha256Context *context)
 {
 	char cil_path[PATH_MAX];
 	char hll_path[PATH_MAX];
@@ -922,6 +936,11 @@ static int semanage_compile_module(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
+	if (context) {
+		update_checksum_with_len(context, cil_data_len);
+		Sha256Update(context, cil_data, cil_data_len);
+	}
+
 	status = write_compressed_file(sh, cil_path, cil_data, cil_data_len);
 	if (status == -1) {
 		ERR(sh, "Failed to write %s\n", cil_path);
@@ -950,18 +969,40 @@ cleanup:
 	return status;
 }
 
+static int modinfo_cmp(const void *a, const void *b)
+{
+	const semanage_module_info_t *ma = a;
+	const semanage_module_info_t *mb = b;
+
+	return strcmp(ma->name, mb->name);
+}
+
 static int semanage_compile_hll_modules(semanage_handle_t *sh,
-				semanage_module_info_t *modinfos,
-				int num_modinfos)
+					semanage_module_info_t *modinfos,
+					int num_modinfos,
+					char *cil_checksum)
 {
-	int status = 0;
-	int i;
+	/* to be incremented when checksum input data format changes */
+	static const size_t CHECKSUM_EPOCH = 1;
+
+	int i, status = 0;
 	char cil_path[PATH_MAX];
 	struct stat sb;
+	Sha256Context context;
+	SHA256_HASH hash;
+	struct file_contents contents = {};
 
 	assert(sh);
 	assert(modinfos);
 
+	/* Sort modules by name to get consistent ordering. */
+	qsort(modinfos, num_modinfos, sizeof(*modinfos), &modinfo_cmp);
+
+	Sha256Initialise(&context);
+	update_checksum_with_len(&context, CHECKSUM_EPOCH);
+
+	/* prefix with module count to avoid collisions */
+	update_checksum_with_len(&context, num_modinfos);
 	for (i = 0; i < num_modinfos; i++) {
 		status = semanage_module_get_path(
 				sh,
@@ -969,29 +1010,91 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
 				SEMANAGE_MODULE_PATH_CIL,
 				cil_path,
 				sizeof(cil_path));
-		if (status != 0) {
-			goto cleanup;
-		}
+		if (status != 0)
+			return -1;
 
-		if (semanage_get_ignore_module_cache(sh) == 0 &&
-				(status = stat(cil_path, &sb)) == 0) {
-			continue;
-		}
-		if (status != 0 && errno != ENOENT) {
-			ERR(sh, "Unable to access %s: %s\n", cil_path, strerror(errno));
-			goto cleanup; //an error in the "stat" call
+		if (!semanage_get_ignore_module_cache(sh)) {
+			status = stat(cil_path, &sb);
+			if (status == 0) {
+				status = map_compressed_file(sh, cil_path, &contents);
+				if (status < 0) {
+					ERR(sh, "Error mapping file: %s", cil_path);
+					return -1;
+				}
+
+				/* prefix with length to avoid collisions */
+				update_checksum_with_len(&context, contents.len);
+				Sha256Update(&context, contents.data, contents.len);
+
+				unmap_compressed_file(&contents);
+				continue;
+			} else if (errno != ENOENT) {
+				ERR(sh, "Unable to access %s: %s\n", cil_path,
+				    strerror(errno));
+				return -1; //an error in the "stat" call
+			}
 		}
 
-		status = semanage_compile_module(sh, &modinfos[i]);
-		if (status < 0) {
-			goto cleanup;
+		status = semanage_compile_module(sh, &modinfos[i], &context);
+		if (status < 0)
+			return -1;
+	}
+	Sha256Finalise(&context, &hash);
+
+	semanage_hash_to_checksum_string(hash.bytes, cil_checksum);
+	return 0;
+}
+
+static int semanage_compare_checksum(semanage_handle_t *sh, const char *reference)
+{
+	const char *path = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES_CHECKSUM);
+	struct stat sb;
+	int fd, retval;
+	char *data;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1) {
+		if (errno != ENOENT) {
+			ERR(sh, "Unable to open %s: %s\n", path, strerror(errno));
+			return -1;
 		}
+		/* Checksum file not present - force a rebuild. */
+		return 1;
+	}
+
+	if (fstat(fd, &sb) == -1) {
+		ERR(sh, "Unable to stat %s\n", path);
+		retval = -1;
+		goto out_close;
 	}
 
-	status = 0;
+	if (sb.st_size != (off_t)CHECKSUM_CONTENT_SIZE) {
+		/* Incompatible/invalid hash type - just force a rebuild. */
+		WARN(sh, "Module checksum invalid - forcing a rebuild\n");
+		retval = 1;
+		goto out_close;
+	}
 
-cleanup:
-	return status;
+	data = mmap(NULL, CHECKSUM_CONTENT_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (data == MAP_FAILED) {
+		ERR(sh, "Unable to mmap %s\n", path);
+		retval = -1;
+		goto out_close;
+	}
+
+	retval = memcmp(data, reference, CHECKSUM_CONTENT_SIZE) != 0;
+	munmap(data, sb.st_size);
+out_close:
+	close(fd);
+	return retval;
+}
+
+static int semanage_write_modules_checksum(semanage_handle_t *sh,
+					   const char *checksum)
+{
+	const char *path = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES_CHECKSUM);
+
+	return write_file(sh, path, checksum, CHECKSUM_CONTENT_SIZE);
 }
 
 /* Files that must exist in order to skip policy rebuild. */
@@ -1030,6 +1133,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	semanage_module_info_t *modinfos = NULL;
 	mode_t mask = umask(0077);
 	struct stat sb;
+	char modules_checksum[CHECKSUM_CONTENT_SIZE + 1 /* '\0' */];
 
 	int do_rebuild, do_write_kernel, do_install;
 	int fcontexts_modified, ports_modified, seusers_modified,
@@ -1159,28 +1263,45 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		}
 	}
 
-	/*
-	 * If there were policy changes, or explicitly requested, or
-	 * any required files are missing, rebuild the policy.
-	 */
-	if (do_rebuild) {
-		/* =================== Module expansion =============== */
-
+	if (do_rebuild || sh->check_ext_changes) {
 		retval = semanage_get_active_modules(sh, &modinfos, &num_modinfos);
 		if (retval < 0) {
 			goto cleanup;
 		}
 
+		/* No modules - nothing to rebuild. */
 		if (num_modinfos == 0) {
 			goto cleanup;
 		}
 
-		retval = semanage_compile_hll_modules(sh, modinfos, num_modinfos);
+		retval = semanage_compile_hll_modules(sh, modinfos, num_modinfos,
+						      modules_checksum);
 		if (retval < 0) {
 			ERR(sh, "Failed to compile hll files into cil files.\n");
 			goto cleanup;
 		}
 
+		if (!do_rebuild && sh->check_ext_changes) {
+			retval = semanage_compare_checksum(sh, modules_checksum);
+			if (retval < 0)
+				goto cleanup;
+			do_rebuild = retval;
+		}
+
+		retval = semanage_write_modules_checksum(sh, modules_checksum);
+		if (retval < 0) {
+			ERR(sh, "Failed to write module checksum file.\n");
+			goto cleanup;
+		}
+	}
+
+	/*
+	 * If there were policy changes, or explicitly requested, or
+	 * any required files are missing, rebuild the policy.
+	 */
+	if (do_rebuild) {
+		/* =================== Module expansion =============== */
+
 		retval = semanage_get_cil_paths(sh, modinfos, num_modinfos, &mod_filenames);
 		if (retval < 0)
 			goto cleanup;
@@ -1703,7 +1824,7 @@ static int semanage_direct_extract(semanage_handle_t * sh,
 			goto cleanup;
 		}
 
-		rc = semanage_compile_module(sh, _modinfo);
+		rc = semanage_compile_module(sh, _modinfo, NULL);
 		if (rc < 0) {
 			goto cleanup;
 		}
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index bb1e6140..b2201ee3 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -116,20 +116,23 @@ semanage_handle_t *semanage_handle_create(void)
 
 void semanage_set_rebuild(semanage_handle_t * sh, int do_rebuild)
 {
-
 	assert(sh != NULL);
 
 	sh->do_rebuild = do_rebuild;
-	return;
 }
 
 void semanage_set_reload(semanage_handle_t * sh, int do_reload)
 {
-
 	assert(sh != NULL);
 
 	sh->do_reload = do_reload;
-	return;
+}
+
+void semanage_set_check_ext_changes(semanage_handle_t * sh, int do_check)
+{
+	assert(sh != NULL);
+
+	sh->check_ext_changes = do_check;
 }
 
 int semanage_get_hll_compiler_path(semanage_handle_t *sh,
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index e1ce83ba..4d2aae8f 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -61,6 +61,7 @@ struct semanage_handle {
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
 	int do_rebuild;		/* whether to rebuild policy if there were no changes */
+	int check_ext_changes;	/* whether to rebuild if external changes are detected via checksum */
 	int commit_err;		/* set by semanage_direct_commit() if there are
 				 * any errors when building or committing the
 				 * sandbox to kernel policy at /etc/selinux
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 00259fc8..c8214b26 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -348,4 +348,5 @@ LIBSEMANAGE_1.1 {
 
 LIBSEMANAGE_3.4 {
     semanage_module_compute_checksum;
+    semanage_set_check_ext_changes;
 } LIBSEMANAGE_1.1;
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index fe937519..c3bd90ac 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -979,9 +979,9 @@ int semanage_module_remove_key(semanage_handle_t *sh,
 }
 
 static const char CHECKSUM_TYPE[] = "sha256";
-static const size_t CHECKSUM_CONTENT_SIZE = sizeof(CHECKSUM_TYPE) + 1 + 2 * SHA256_HASH_SIZE;
+const size_t CHECKSUM_CONTENT_SIZE = sizeof(CHECKSUM_TYPE) + 1 + 2 * SHA256_HASH_SIZE;
 
-static void semanage_hash_to_checksum_string(const uint8_t *hash, char *checksum)
+void semanage_hash_to_checksum_string(const uint8_t *hash, char *checksum)
 {
 	size_t i;
 
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index 64d4a157..cf2432c5 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -102,4 +102,7 @@ int semanage_module_get_path(semanage_handle_t *sh,
 			     char *path,
 			     size_t len);
 
+extern const size_t CHECKSUM_CONTENT_SIZE;
+void semanage_hash_to_checksum_string(const uint8_t *hash, char *checksum);
+
 #endif
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 633ee731..767f05cb 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -115,6 +115,7 @@ static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"/disable_dontaudit",
 	"/preserve_tunables",
 	"/modules/disabled",
+	"/modules_checksum",
 	"/policy.kern",
 	"/file_contexts.local",
 	"/file_contexts.homedirs",
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index b9ec5664..1fc77da8 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -60,6 +60,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_DISABLE_DONTAUDIT,
 	SEMANAGE_PRESERVE_TUNABLES,
 	SEMANAGE_MODULES_DISABLED,
+	SEMANAGE_MODULES_CHECKSUM,
 	SEMANAGE_STORE_KERNEL,
 	SEMANAGE_STORE_FC_LOCAL,
 	SEMANAGE_STORE_FC_HOMEDIRS,
-- 
2.34.1

