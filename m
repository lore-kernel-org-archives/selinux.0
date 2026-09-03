Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B074BB80D
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445945; cv=none; b=qCo+F8TkE0Sf0vHW23SW/L/Goun9N0wP8XQs1gakc0cDa3hDYrwAhHcS5ZE19p7PCDTRdKGhMjBwumhlNMXF6PFlF5U4Jkm6eMVATt+305bxAtevatHIrnJW77ODP+ZOPhWXD/KwXHv+su+68vG08GGeWGMo28MNYMlxnVESacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445945; c=relaxed/simple;
	bh=9QWwRrDUHUVUTt1OqVj98bYmBD4pEczbZ3ta3XDmDvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCR29ozVi5OhvEostIUMrb5Tm4s50eUS5R+i4STZoCJd6qc+DlbJeOa03rsefk9Dx6UDpgziPs0dmwFj1hXOOJxNHtJJXjJJYucHlj31cAeBhWUgmri1cCeTBJATE902KjWgTRvvn9QhUeGt4WXTIuMt8hbevobmPszlCkpJDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpuSrVW3; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpuSrVW3"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4563ac048f4so2048873fac.0
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788445936; x=1789050736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJlq5R9uiBwg963o4TVcJbhYR9TG97fx9LEsAokMnrU=;
        b=XpuSrVW3olGQX58+3XYoaNONE0phXWvtnAHXFYx2tX3lNfk0ZzBD63NpdM5Qyc4M9b
         wXptFLqNRQGGFCCqlxulFIs9gP8HeYKfnAyXZQpoiXTRmEgtnYrThBAdwac2SmcQBJul
         Onx3bZgkniE6LFKM0zdQXb0tPY4H/kHE8KHXiT2/IEck2NMcTwlENI7YdBJbRNcNOErC
         JeQqIVK6Ugd2u47ZH5TI3ycNtUCZtr0NP7dOGNvhBE/iD4dogHUs1j/77Mjv1I1tHLZ5
         QUStx68PEKBlomIbAD5UHAVHtHixrCpfvg8f/IOy3UvWtvYepAoK5Z7N+1z7SC6c+vpr
         KwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445936; x=1789050736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJlq5R9uiBwg963o4TVcJbhYR9TG97fx9LEsAokMnrU=;
        b=WxJYBL9DixlnSazeuY84jNClzf0fgsCkJuiuA5GiRyPW+14OzVL3XqJW37dYt+VwBM
         VFQqVLwLtnRo4kUBpmP2v99aBtQVgy+kWKpo0s6NA+/EXsWUdDA/NLOz/gmtprvTnNzz
         kJGuTFd/7k/gqGj9dWdyvkCetBWHS1ddLeC2YD9UhmANVTuEwRexJ+Z/syCZ/APjun6Z
         OCDXBl2P2UkJxPHe7iMZ65DHdNjc/nkNdvWDfL+xaH75ljIhkm+kq5qiWVW4mjImvPsl
         Uzg3gJCCmfABo2/p/akrRkMSBRhnfVDNLpuDeWWplctFMjth1msSpYNTJEkhl/UxoYcG
         f/+w==
X-Gm-Message-State: AFuF++k8PVSFyxVkHCfa0zBN39PUbbXzsym8cF7PGASSxgiWyF4HW1L7
	hlo82rH3h4dGKO8IFogyZZ8o+nOUds1mLdBw8vcB2Dt0Mhp+LL4yItgsRcHO3A==
X-Gm-Gg: AYBFou0qXWzoci0sxSteR7a5qD01UdWIPsyUXMKaF6l2ps5Zj2IXpzRVC5QjmOvW2aW
	TFC6nhjfoO3TTKlwKpL88Mj4Mk2UmtFEPaqSIsWJRqI6UchqjD37GNlFUlqSPamAcZZt17itdtt
	dTbv8YwvCpPu6rKkLj7CAC4cpUzXAJkPAUC/aat1PdOkRH6pZRR0IvFRxlz0BiWJ4ClQgiYwiFJ
	FyXtljq8RftCOavI82tlTVOdeum10/YAdKeDDeJ7h+S/snmH8MADfxxlLCK3ZlA62H0eoFmVHIh
	L9rYIXw/kdEpoMBjLb95ReRpCiN/7ZFlxG2p+kFyY0qt8HGR125zKYzE6/KsDHI66YYGXBflJA9
	TwNARuUNNTp31ClceVWC3iI28FBjMBREymdhjBvLup6+YL93PyrvaxSuyhNqmSk4Dka44AkqN8+
	KMgxcGY7ia8D2zSNA9Csf2V8Ag+y/dCLNw7YmaRirft9oUnrDD8ViYRFWz6CSgxZN5r3qD1aeRw
	zum4QYGiN6uzv6cGMvdK1n5wAqvCYKjab3XS7U6HGk6CZ5pXaE3Lz1uRYofWVos
X-Received: by 2002:a05:622a:4c07:b0:52d:f700:6deb with SMTP id d75a77b69052e-530523bd186mr10608371cf.17.1788445916377;
        Thu, 03 Sep 2026 07:31:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530330282bfsm43110841cf.11.2026.09.03.07.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:31:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 4/4] libselinux: search file_contexts files across configuration roots
Date: Thu,  3 Sep 2026 10:26:01 -0400
Message-ID: <20260903142600.19723-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903142600.19723-2-stephen.smalley.work@gmail.com>
References: <20260903142600.19723-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When no SELABEL_OPT_PATH is specified, resolve each of the
file_contexts inputs (base, .homedirs, .local, .subs, .subs_dist)
independently against the configuration-root list. On a stateless
system these have different owners and land in different roots:

    - .subs_dist ships with the policy package and is never rewritten by
    libsemanage, so it stays under the vendor root;
    - .subs and a hand-edited .local are admin config under /etc;
    - base, .homedirs, and a managed .local are regenerated by libsemanage
    into whatever root SEMANAGE_FINAL_SELINUX points at.

open_file() already pairs a text file with its .bin sibling by mtime
within one directory, so a compiled form under a lower-priority root
never shadows a newer text file under a higher one; passing ".bin" as
the sibling suffix to selinux_policy_resolve() lets a root that
carries only the compiled form still satisfy the search.

The SELABEL_OPT_PATH case keeps the existing behavior: everything is
looked up relative to the caller-supplied path.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c       | 49 ++++++++++++++++++++++++++-----
 libselinux/src/selinux_config.c   | 31 +++++++++++++++++++
 libselinux/src/selinux_internal.h | 10 +++++++
 3 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index ce14e63d..54c43419 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1594,17 +1594,37 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	char subs_file[PATH_MAX + 1];
 	/* Process local and distribution substitution files */
 	if (!path_provided) {
-		rec->spec_files[0] = strdup(selinux_file_context_path());
+		char resolved[PATH_MAX + 1];
+
+		/*
+		 * Each file_contexts input is resolved independently
+		 * against the configuration-root list. The .local and
+		 * .subs files are admin config. The .homedirs file is
+		 * generated locally and .subs_dist ships with the policy
+		 * package and is not reinstalled by libsemanage, so on a
+		 * stateless system they will not share a directory with the
+		 * base file. Text/.bin pairing stays per-directory in
+		 * open_file(), so a lower-priority compiled form never
+		 * shadows a higher-priority text file.
+		 */
+		selinux_policy_resolve(selinux_file_context_path(), ".bin",
+				       resolved, sizeof(resolved));
+		rec->spec_files[0] = strdup(resolved);
 		if (rec->spec_files[0] == NULL)
 			goto finish;
-		status = selabel_subs_init(
-			selinux_file_context_subs_dist_path(), rec->digest,
-			&data->dist_subs, &data->dist_subs_num,
-			&data->dist_subs_alloc);
+
+		selinux_policy_resolve(selinux_file_context_subs_dist_path(),
+				       NULL, subs_file, sizeof(subs_file));
+		status = selabel_subs_init(subs_file, rec->digest,
+					   &data->dist_subs,
+					   &data->dist_subs_num,
+					   &data->dist_subs_alloc);
 		if (status)
 			goto finish;
-		status = selabel_subs_init(selinux_file_context_subs_path(),
-					   rec->digest, &data->subs,
+
+		selinux_policy_resolve(selinux_file_context_subs_path(), NULL,
+				       subs_file, sizeof(subs_file));
+		status = selabel_subs_init(subs_file, rec->digest, &data->subs,
 					   &data->subs_num, &data->subs_alloc);
 		if (status)
 			goto finish;
@@ -1627,6 +1647,21 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 #endif
 
 	for (i = 0; i < num_optional_paths; i++) {
+#if !defined(BUILD_HOST) && !defined(ANDROID)
+		if (!path_provided) {
+			char opt_path[PATH_MAX + 1], resolved[PATH_MAX + 1];
+
+			snprintf(opt_path, sizeof(opt_path), "%s.%s",
+				 selinux_file_context_path(), opt_suffixes[i]);
+			selinux_policy_resolve(opt_path, ".bin", resolved,
+					       sizeof(resolved));
+			rec->spec_files[num_required_paths + i] =
+				strdup(resolved);
+			if (rec->spec_files[num_required_paths + i] == NULL)
+				goto finish;
+			continue;
+		}
+#endif
 		if (asprintf(&rec->spec_files[num_required_paths + i], "%s.%s",
 			     rec->spec_files[0], opt_suffixes[i]) < 0) {
 			rec->spec_files[num_required_paths + i] = NULL;
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index ef03eea5..a4b5f463 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -595,3 +595,34 @@ int selinux_policy_open(const char *path, int flags)
 	errno = ENOENT;
 	return -1;
 }
+
+int selinux_policy_resolve(const char *path, const char *sibling, char *out,
+			   size_t outlen)
+{
+	char probe[PATH_MAX];
+	unsigned int i;
+
+	__selinux_once(once, init_selinux_config);
+
+	if (strlcpy(out, path, outlen) >= outlen)
+		goto noent;
+	for (i = 0;; i++) {
+		if (access(out, F_OK) == 0)
+			return 0;
+		if (sibling) {
+			snprintf(probe, sizeof(probe), "%s%s", out, sibling);
+			if (access(probe, F_OK) == 0)
+				return 0;
+		}
+		if (!selinux_policyroots[i + 1] ||
+		    selinux_policy_remap(path, selinux_policyroots[i + 1], out,
+					 outlen))
+			break;
+	}
+
+	/* Nothing found: leave primary path in @out for diagnostics. */
+	strlcpy(out, path, outlen);
+noent:
+	errno = ENOENT;
+	return -1;
+}
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index d913a1b0..731826ad 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -122,6 +122,16 @@ const char *const *selinux_policy_roots(void);
 FILE *selinux_policy_fopen(const char *path, const char *mode);
 int selinux_policy_open(const char *path, int flags);
 
+/*
+ * Resolve @path against the configuration-root list: write into @out
+ * the first remapping under which @out (or @out concatenated with
+ * @sibling, when the base file is optional but a sibling such as .bin
+ * may exist alone is present. If no root has the file, @out receives
+ * @path unchanged and -1 is returned with errno ENOENT. Internal only.
+ */
+int selinux_policy_resolve(const char *path, const char *sibling, char *out,
+			   size_t outlen);
+
 extern int has_selinux_config;
 
 #ifndef HAVE_STRLCPY
-- 
2.55.0

