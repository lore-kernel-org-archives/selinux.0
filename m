Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2619B584
	for <selinux@vger.kernel.org>; Thu, 25 Jul 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923876; cv=none; b=c30jxzzmCot0jM+bSWw26eiojiahhYI1lzrG+dAh1TsDW76B6S6TY93bIx6DEIfT37N7NlqVgYhAqmkseTGmOC1CJAosDw5Y6IyxhxfEGmInelVFGb4IxO95G2/CnOXLcFmKxDKgMBQ1UK0b2fZ1HF4LxbzVdVVf2EIT+b7xBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923876; c=relaxed/simple;
	bh=s1k0QGPYMYXScl8nZ9I0HKbb+YULQicVIyGDFp+nFGg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fk/w5MhXXBOrdApok24Nj6MVsfp3/9zDxdUeMgdlbF5uQfvRb35Baku6Evpjj13H14R+5Phg09froaZhpVbZ1r2MWsaIztnBfeeIyGE619CiBEbpcOx4f9Di4su3Sw+RzTtnwZbdcYHdRHz7JsFtM795u/PCyJRc6qBtXa3PKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8sUvBw+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8sUvBw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721923873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XM0HryaWuk/il8a7aH+UXFkBZ6VbBg6eUZ0hf2Mu+as=;
	b=E8sUvBw+ZBV047ca7b0fiIo6JQaddboyf+QUyRRGlJQzZVzrTo3tQVrAj0DWiJBhgo88qx
	lHCcqtIc9jxDseCcrT+zMqJp0OoXN2L/7Yy7gz820jOew8HU0FMMqZkhIiQrywtPHwLGlF
	MTZcUvp0y5IOGvkBTZ4hSVOCAilxXP4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-IAIsywbuPE-Zx5OB74ZaYQ-1; Thu,
 25 Jul 2024 12:11:12 -0400
X-MC-Unique: IAIsywbuPE-Zx5OB74ZaYQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E20A1955F3D
	for <selinux@vger.kernel.org>; Thu, 25 Jul 2024 16:11:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 963E619560AE
	for <selinux@vger.kernel.org>; Thu, 25 Jul 2024 16:11:10 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v4] libsemanage: Preserve file context and ownership in policy store
Date: Thu, 25 Jul 2024 18:11:05 +0200
Message-ID: <20240725161107.1446978-1-vmojzis@redhat.com>
In-Reply-To: <b4ec6621-dbbb-4f59-9d2e-7fd4edc6b116@redhat.com>
References: <b4ec6621-dbbb-4f59-9d2e-7fd4edc6b116@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Make sure that file context (all parts) and ownership of
files/directories in policy store does not change no matter which user
and under which context executes policy rebuild.

Fixes:
  # semodule -B
  # ls -lZ  /etc/selinux/targeted/contexts/files

-rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 Jul 11 09:57 file_contexts
-rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 Jul 11 09:57 file_contexts.bin
-rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 Jul 11 09:57 file_contexts.homedirs
-rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 Jul 11 09:57 file_contexts.homedirs.bin

  SELinux user changed from system_u to the user used to execute semodule

  # capsh --user=testuser --caps="cap_dac_override,cap_chown+eip" --addamb=cap_dac_override,cap_chown -- -c "semodule -B"
  # ls -lZ  /etc/selinux/targeted/contexts/files

-rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 421397 Jul 19 09:10 file_contexts
-rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 593470 Jul 19 09:10 file_contexts.bin
-rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  14704 Jul 19 09:10 file_contexts.homedirs
-rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  20289 Jul 19 09:10 file_contexts.homedirs.bin

  Both file context and ownership changed -- causes remote login
  failures and other issues in some scenarios.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/semanage_store.c | 31 +++++++++++++++++++++++++++++++
 libsemanage/src/semanage_store.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 27c5d349..95596a93 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -36,6 +36,7 @@ typedef struct dbase_policydb dbase_t;
 #include "database_policydb.h"
 #include "handle.h"
 
+#include <selinux/restorecon.h>
 #include <selinux/selinux.h>
 #include <sepol/policydb.h>
 #include <sepol/module.h>
@@ -767,6 +768,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
 	if (!retval && rename(tmp, dst) == -1)
 		return -1;
 
+	semanage_setfiles(dst);
 out:
 	errno = errsv;
 	return retval;
@@ -819,6 +821,8 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 			goto cleanup;
 		}
 		umask(mask);
+
+		semanage_setfiles(dst);
 	}
 
 	for (i = 0; i < len; i++) {
@@ -837,6 +841,7 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 				goto cleanup;
 			}
 			umask(mask);
+			semanage_setfiles(path2);
 		} else if (S_ISREG(sb.st_mode) && flag == 1) {
 			mask = umask(0077);
 			if (semanage_copy_file(path, path2, sb.st_mode,
@@ -938,6 +943,7 @@ int semanage_mkdir(semanage_handle_t *sh, const char *path)
 
 		}
 		umask(mask);
+		semanage_setfiles(path);
 	}
 	else {
 		/* check that it really is a directory */
@@ -1614,16 +1620,19 @@ static int semanage_validate_and_compile_fcontexts(semanage_handle_t * sh)
 		    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC)) != 0) {
 		goto cleanup;
 	}
+	semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_BIN));
 
 	if (sefcontext_compile(sh,
 		    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL)) != 0) {
 		goto cleanup;
 	}
+	semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL_BIN));
 
 	if (sefcontext_compile(sh,
 		    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS)) != 0) {
 		goto cleanup;
 	}
+	semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS_BIN));
 
 	status = 0;
 cleanup:
@@ -3018,3 +3027,25 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 	return 0;
 }
+
+/* Make sure the file context and ownership of files in the policy
+ * store does not change */
+void semanage_setfiles(const char *path){
+	struct stat sb;
+	int fd;
+	/* Fix the user and role portions of the context, ignore errors
+	 * since this is not a critical operation */
+	selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | SELINUX_RESTORECON_IGNORE_NOENTRY);
+
+	/* Make sure "path" is owned by root */
+	if ((geteuid() != 0 || getegid() != 0) &&
+	    ((fd = open(path, O_RDONLY)) != -1)){
+		/* Skip files with the SUID or SGID bit set -- abuse protection */
+		if ((fstat(fd, &sb) != -1) &&
+		    !(S_ISREG(sb.st_mode) &&
+		      (sb.st_mode & (S_ISUID | S_ISGID))))
+			fchown(fd, 0, 0);
+
+		close(fd);
+	}
+}
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 1fc77da8..e21dadeb 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -124,6 +124,7 @@ int semanage_get_cil_paths(semanage_handle_t * sh, semanage_module_info_t *modin
 int semanage_get_active_modules(semanage_handle_t *sh,
 			       semanage_module_info_t **modinfo, int *num_modules);
 
+void semanage_setfiles(const char *path);
 
 /* lock file routines */
 int semanage_get_trans_lock(semanage_handle_t * sh);
-- 
2.43.0

