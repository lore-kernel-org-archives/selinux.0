Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300610;
	b=w7QWJhynBf+/mVqXbEm9x0dmLyAxtDzPMH9d8xbIJb101pcpK/1GbPRiBz6Wq5eTKJzO
	 NF89ZvJRHpfuajNrg3iXywAn3cuWsAKQ3cVooxL3kjhYlyuw5FojlaEJL0nffKp3UXvlQ
	 Xds0WChUiQbL2+e0hyPVwEjwX5LYCvKSIQeQc7sQb84LCTkfNyYwAixRKUuONFXMgLAOg
	 ndlgCEjmUg+Ehp7BfEexOmeoplmzyjBYevHAwPcpW43jjOq5r+5A6GCd8vRbMbOV+v6Zx
	 N5f4AVfiSZAjfIBG2qS5S3Pljbvxfkp4xiaK4R2QKN+y9CIDt/y720U3vg7v0c/OiWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SB5r6xEGMd9GcxBz/BlU2Esr+uDv4P6kz1O/Y/ppkZ0=;
	b=DjUH6t+QSlbSDlYWIPDBDcDyyyYii0DgQIzBVB7MLonqvTVd9dzrHPUvBpGzxIl7E3e4
	 UnLL+a/q4Y6fuyRfwbO1B52GCxYuoYRpLLRbTIQbM4touTzhz7wywxujaQDF9AP168bdI
	 p0UG6tfhD+GwENCoW3TyBM0VkUtSR26LJqWR1/YMh8K42lvKggjJsZB36U9j49pQ4G5qK
	 ckWBBPQgjmO14cJMO6Z5kqVwxVGnOWjY4qS7bPRYy+F1fNIq23FncrvryqTqNcvlZ+4jl
	 +kFheKEe5SouxD2D11fuYBFBACfu/KTv4zCXdSLzuP+HJ5qK493tLM07dcoUq+w855w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k0IJ+xPD;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A1606A31D
	for <selinux@vger.kernel.org>; Thu, 29 Oct 2026 19:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 170A1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k0IJ+xPD
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-533797e72e8so15803321cf.2
        for <selinux@vger.kernel.org>; Thu, 29 Oct 2026 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300609; x=1793905409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SB5r6xEGMd9GcxBz/BlU2Esr+uDv4P6kz1O/Y/ppkZ0=;
        b=k0IJ+xPDNR/ZeRyEltBBTfrUbzA96Wo938RyahWg4EiTO8u1XHggySHmGd/E4K89sl
         qjPHassVs9kFAAAOcVjohFdo5zD/zJKFRXqp00dPJX8/AYtVVm9teIIHpXoqH9EpCNRt
         +ug4mRShaoKECRTdM7foR9pOL1EwqAywyMcOWVncNOQc5DSCaeCtZ50tB1UTEAy/g2nX
         g5qRYaC+SP3gBIWAo5q8eYaPEVUKl7PvuSYWglkyygjdiy3WEJGD/r2is1yhH0m8qiZR
         RvtufNruUIPI2pC1qtILlf/6TMbdFcXkgtgoaVuOoI4v5DSsd5HSTq8s+a3CPXsAcjn0
         WVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300609; x=1793905409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SB5r6xEGMd9GcxBz/BlU2Esr+uDv4P6kz1O/Y/ppkZ0=;
        b=n/y9TO1oYlvXSQafxw/nPbxXcFlcH/HW1oRXPygXB13HArFEWN/WQ+hvZpObICL4h9
         M1bp0jHKbCF9rDiSDF3FGKrYHIeAq8ZyzOHwnacnXBbeXngcsaxPP8IGqPhXPNj7kQ0Z
         jTz3b4wIdNCLux6BFWyK7MhLI4jwAh9iKMAx6kutIt8nWeDVHmEf86BZH1CXRHbNEnNc
         rWORIKXkXh56gMDRJR0cuLYtOVKTSW5dkrD1zfFL73aUlAo/h2SVlAz19QDLJoV3QYKi
         /R12/yZU8r1geWIpp4aVmWcp4S/i6WyhGhkU1DP+x5P/Pl01pyyQGGCe9tinFkpyiD7d
         FBVA==
X-Gm-Message-State: AFq9FYLQutW48SrlqYS7gefLo4nEdeGkul3f+TJPKeVL+TbI1gr936M8
	34TEk7H39L4g5eLeeU1FYxHGQG/Bjto0lplVtqZIblSF3+FlseUvLoG2Vap0M2rO
X-Gm-Gg: AYBFou1x+qzoZ2UlU2JEiXrpnidl6adecj1jBEinL2AbhzGk9P28W9NZzQTgxJVmQMj
	+KqREOWHw9or4D7Bk2DL8zUZIPHdcslDnvk7MX0RtzsNpQ5N1LJ3b+TBjPIb6sDP2YHeK8tWB/O
	IMpVBGxfmgiKtWk5D2MceDYnpcrS3VMuB6gbd8HX41U974uoOO/ZLoECrHSsoiRROQvpe5/MvLf
	o1f8K9AnCZ/SlKJupYfkuI+jxV3yvqVjqvxr94H0sFY+Jg2FU0TDGF/yezTmRjztckw5AnpFGt0
	I8CB83Dh1qarTkzTerwwU9udAR1AecelMGOKrTSQwkjsEM192IbLxkBoNjWO4TbIjPyRbzHvbTZ
	VJQGLybwx6+P4fubMdQOfav3bTEL8EAFRPigp/vlYXk70Iyb+uNbeu8ldcteoARHSyDko/ZFf8u
	D0NqeZ3C3bUlUHK+fWRXAQnAnRSPagWjbqOjyJU16VtLDa5bID+ppAQOV0wcX4zEDhCAoibYlpW
	q6bpJkMP2pMxzEkBwVOolLhVyyVQhk96schE8A7mjRVw7/KrWRECES9JUp8yVAcJe4eJf15VjFb
	d8ytdsNfEtz27PTk4ET+vyTD+7Hjv3QD5EguWhQOJE4fiNGBoPSYbO+/rkIv4ylcA1uIlEefICA
	G8yYfOisvnNRJ4BoZtnZ/L7nYMJY8MLupGWpIbKnKupVoZWG8YEfBnUOkfU9zymcrPHLa2fqfYp
	PB3YvpX0alVpqAPJj2HqQA8d7aFwnvtin04OirywwQiCWdL9Fa+Qx4
X-Received: by 2002:a05:622a:488:b0:536:98a5:cd8c with SMTP id d75a77b69052e-53fcb7f9ac3mr101085741cf.30.1793300608730;
        Thu, 29 Oct 2026 12:03:28 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-542a57bd0d0sm1222031cf.27.2026.10.29.12.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:03:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Eugenij Safonov <ja.safonau@protonmail.com>
Subject: [PATCH v2 2/2] libsemanage/genhomedircon: apply path substitution rules to home directories
Date: Thu, 29 Oct 2026 15:03:09 -0400
Message-ID: <20261029190309.138027-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029190309.138027-1-stephen.smalley.work@gmail.com>
References: <20261029190309.138027-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eugenij Safonov <ja.safonau@protonmail.com>

genhomedircon derives the home directory prefixes for the generated
file_contexts.homedirs patterns from /etc/default/useradd (HOME=),
/etc/libuser.conf (LU_HOMEDIRECTORY) and the passwd database, without
taking path substitution rules (file_contexts.subs(5)) into account.

On systems where /home is an alias for another location (e.g. bootc and
ostree based systems with HOME=/var/home in /etc/default/useradd and a
"/var/home /home" equivalency rule in file_contexts.subs_dist), the
generated patterns therefore use the aliased prefix, while libselinux
canonicalizes lookup paths to the original path before matching.  None
of the generated patterns can ever match, so any relabel of user home
directories produces default_t, which breaks confined services reading
user files - most visibly sshd, which cannot read authorized_keys and
silently falls back to password authentication.

Fix this by loading the local and distribution path substitution files
and canonicalizing every home directory prefix (useradd and libuser
defaults, the /home and /export/home fallbacks, and per-user home
directories from the passwd database) through them before generating
patterns, using the helpers added in the previous commit.  The
substitution files are resolved below the final SELinux policy
directory first and then across the libselinux configuration roots,
so that a vendor-only file_contexts.subs_dist is honored as well.

A side effect is that the existing check for password file entries
conflicting with a file context now checks the canonical path, which
makes it catch conflicts it previously missed, as file context rules
always use original paths (semanage rejects aliased file specs).

Verified in a container against the Fedora targeted policy:

- HOME=/var/home together with the stock "/var/home /home" subs_dist
  rule now generates /home/[^/]+ patterns, and matchpathcon resolves
  /var/home/<user>/.ssh/authorized_keys to ssh_home_t again
- a subs_dist file available only below the vendor configuration
  root (/usr/lib/selinux) is honored as well
- chained local (/srv/homes -> /var/home) and distribution
  (/var/home -> /home) rules resolve to /home
- a wildcard source (/*/varhome) and duplicate rules behave as at
  runtime lookup
- per-user patterns generated from SELinux user mappings are
  canonicalized as well
- with no matching substitution rules the generated file is
  byte-identical to the unpatched output

Reference: https://github.com/SELinuxProject/selinux/issues/547
Signed-off-by: Eugenij Safonov <ja.safonau@protonmail.com>
---
 libsemanage/src/genhomedircon.c | 136 +++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 2717712c..36e284b1 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -36,9 +36,13 @@
 
 #include "utilities.h"
 #include "genhomedircon.h"
+#include "path_subs.h"
+
+#include <selinux/selinux.h>
 
 #include <assert.h>
 #include <ctype.h>
+#include <fcntl.h>
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -120,6 +124,10 @@ typedef struct {
 	genhomedircon_user_entry_t *fallback;
 	semanage_handle_t *h_semanage;
 	sepol_policydb_t *policydb;
+	/* path substitution rules (see file_contexts.subs(5)) used to
+	 * canonicalize home directory paths */
+	semanage_path_subs_t *local_subs;
+	semanage_path_subs_t *dist_subs;
 } genhomedircon_settings_t;
 
 typedef struct {
@@ -190,6 +198,87 @@ static int ignore(const char *homedir)
 	return 0;
 }
 
+/* Canonicalize every entry of a home directory list in place.  Since
+ * canonicalization may make entries collide (e.g. when the useradd and
+ * libuser defaults resolve to the same directory), the list is rebuilt
+ * without duplicates. */
+static int canonicalize_homedir_list(genhomedircon_settings_t *s,
+				     semanage_list_t **list)
+{
+	semanage_list_t *canonical = NULL, *h;
+
+	for (h = *list; h; h = h->next) {
+		char *newpath = NULL;
+
+		if (semanage_path_subs_canonicalize(s->local_subs, s->dist_subs,
+						    h->data, &newpath) < 0)
+			goto err;
+		if (newpath) {
+			free(h->data);
+			h->data = newpath;
+		}
+	}
+
+	for (h = *list; h; h = h->next) {
+		if (semanage_list_push(&canonical, h->data))
+			goto err;
+	}
+
+	semanage_list_destroy(list);
+	*list = canonical;
+	return STATUS_SUCCESS;
+
+err:
+	semanage_list_destroy(&canonical);
+	return STATUS_ERR;
+}
+
+/* Load a path substitution file (file_contexts.subs or
+ * file_contexts.subs_dist), first below the final SELinux policy
+ * directory, then across the libselinux configuration roots.  A file
+ * that no root has is not an error.  Returns 0 on success, -1 on
+ * error. */
+static int load_subs_file(semanage_handle_t *sh, bool dist,
+			  semanage_path_subs_t **rules)
+{
+	const char *abs_path = dist ? selinux_file_context_subs_dist_path() :
+				      selinux_file_context_subs_path();
+	const char *root = semanage_final_path(SEMANAGE_FINAL_SELINUX,
+					       SEMANAGE_FINAL_TOPLEVEL);
+	size_t root_len = strlen(selinux_policy_root());
+	char *final_path = NULL;
+	FILE *fp = NULL;
+	int fd, rc;
+
+	*rules = NULL;
+
+	if (asprintf(&final_path, "%s%s", root, abs_path + root_len) < 0)
+		return -1;
+
+	fp = fopen(final_path, "re");
+	if (!fp && (errno == ENOENT || errno == EACCES)) {
+		fd = selinux_policy_open(abs_path, O_RDONLY);
+		if (fd >= 0) {
+			fp = fdopen(fd, "re");
+			if (!fp)
+				close(fd);
+		}
+	}
+
+	if (!fp) {
+		rc = errno == ENOENT ? 0 : -1;
+		free(final_path);
+		return rc;
+	}
+
+	rc = semanage_path_subs_load_file(sh, fp, final_path, rules);
+
+	fclose(fp);
+	free(final_path);
+
+	return rc;
+}
+
 static int prefix_is_homedir_role(const semanage_user_t *user,
 				  const char *prefix)
 {
@@ -394,6 +483,9 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t *s)
 		}
 	}
 
+	if (canonicalize_homedir_list(s, &homedir_list))
+		goto fail;
+
 	if (!(s->usepasswd))
 		return homedir_list;
 
@@ -462,6 +554,22 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t *s)
 
 		semanage_rtrim(path, '/');
 
+		{
+			char *canonical = NULL;
+
+			if (semanage_path_subs_canonicalize(s->local_subs,
+							    s->dist_subs, path,
+							    &canonical) < 0) {
+				free(path);
+				goto fail;
+			}
+
+			if (canonical) {
+				free(path);
+				path = canonical;
+			}
+		}
+
 		if (!semanage_list_find(homedir_list, path)) {
 			/*
 			 * Now check for an existing file context that matches
@@ -1144,8 +1252,20 @@ retry:
 		goto cleanup;
 	}
 
-	retval = push_user_entry(head, name, uid, gid, sename, prefix,
-				 pwent->pw_dir, level, selogin, homedir_role);
+	char *canonical_home = NULL;
+
+	if (semanage_path_subs_canonicalize(s->local_subs, s->dist_subs,
+					    pwent->pw_dir,
+					    &canonical_home) < 0) {
+		retval = STATUS_ERR;
+		goto cleanup;
+	}
+
+	retval =
+		push_user_entry(head, name, uid, gid, sename, prefix,
+				canonical_home ? canonical_home : pwent->pw_dir,
+				level, selogin, homedir_role);
+	free(canonical_home);
 cleanup:
 	free(rbuf);
 	return retval;
@@ -1469,6 +1589,8 @@ int semanage_genhomedircon(semanage_handle_t *sh, sepol_policydb_t *policydb,
 	s.homedir_template_path =
 		semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL);
 	s.fcfilepath = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_HOMEDIRS);
+	s.local_subs = NULL;
+	s.dist_subs = NULL;
 
 	s.fallback = calloc(1, sizeof(genhomedircon_user_entry_t));
 	if (s.fallback == NULL) {
@@ -1493,6 +1615,13 @@ int semanage_genhomedircon(semanage_handle_t *sh, sepol_policydb_t *policydb,
 	s.h_semanage = sh;
 	s.policydb = policydb;
 
+	if (load_subs_file(sh, false, &s.local_subs) < 0 ||
+	    load_subs_file(sh, true, &s.dist_subs) < 0) {
+		ERR(sh, "Could not load the path substitution rules");
+		retval = STATUS_ERR;
+		goto done;
+	}
+
 	if (!(out = fopen(s.fcfilepath, "we"))) {
 		/* couldn't open output file */
 		ERR(sh, "Could not open the file_context file for writing");
@@ -1510,6 +1639,9 @@ done:
 	while (s.fallback)
 		pop_user_entry(&(s.fallback));
 
+	semanage_path_subs_free(&s.local_subs);
+	semanage_path_subs_free(&s.dist_subs);
+
 	ignore_free();
 
 	return retval;
-- 
2.56.0

