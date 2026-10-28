Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197743;
	b=NURfuM014WMtdF3IsVQ9fpKD33cxMVJHKkkM1QRXtL3oMhgQMESZ7fgEjGX1jdNchgS1
	 Mwjoz5uu+nBPura3xVWMozdaVzL3G2QLiyACCIYqJTA826885N/owzBun4tV5OWpv9rEg
	 sZcrbNbwehYM/iESVPJHPZS2wZrwtI/BNhtm5A4KVDJzpMtKwYaZ+ysvqOHXiOAoseh/Z
	 FHKge/ms8Zfjn/CorWSzDepqjjWHgq0RjJ4ej5iLoGR9LUc9CTrasatalF1ZNymhmSVEn
	 stgE9sad/6KwY1zzNQEn9ZktrqfI+F9axLBZTrtjDnt5PthcV09nmC9f6krXYzBissQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yg7EeqA3lPmtXK8AD8UmehzuqNFG5rKrUFW6hF3gh/I=;
	b=Zcrgvv24qqv/JcuWKXFQR14oOTTOIlZEO5ibJaobnnVk2CnCDVjWSuQgif/7FwYYGmKB
	 aCNKdawC1VWyBFqwJ7mhJ20Oo8wZqVoGCJtGgtmfpsZ/DLS26DCMBdtUuosABtP+U+cys
	 88d1BwFDbS4jEcA8gMiVVrcXZW9m9+7VxsX0DtTesaPe58KHZDSL2B0DSPVfWcIHTRAhA
	 xC+TrwRDkeilJnH2PQUgnDzWhT9Pb8ET5skprABmxNiwLTnR3ns4Uyjgl+HgG7OcnC0BM
	 EsAL/MwAreymeWDZwfELAGdgNpljjB5bH9emGl8/BBUgVmMGS6ZGSrksl/GsR022osg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PaqDJZPZ;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00658606A31D
	for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 14:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00658606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PaqDJZPZ
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f259cdc86so85212285a.3
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2026 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197742; x=1793802542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yg7EeqA3lPmtXK8AD8UmehzuqNFG5rKrUFW6hF3gh/I=;
        b=PaqDJZPZ1pz4rXPRdjm707T4/20fQN5FR+xKSEKeCN4DGHUTVyD9+N+b4gtC1FvUbR
         klcBHCzAyJmhgM5bx6G61G8vuV0KeMbV1yrWyxkQGuybkcWPAmlDza31oG+0LahioeDz
         84ZlJwXXqTbpCOSW2jY3EOWtNjY8SnT+Aopz2SItyuXxHbj4Hr4XJqnEqhjrpvPyEwhg
         aGx4EeI8ANVSDCOjvasHROv3u+YSgLosEhe6NQPrTFcs3OYYrLQmpxHNhzO3oZT+hfOL
         f+gEZX0cpBGTPl8mCe+3cksse2vNHRUzwfDh1KfYGSmLD94JMTRpozcGtiB5Omo9h2Cq
         3GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197742; x=1793802542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yg7EeqA3lPmtXK8AD8UmehzuqNFG5rKrUFW6hF3gh/I=;
        b=b6uJ18XtnJu5Z9EgBtmhRaFoa6txOf0S9Jq5wOLvaOZkyDOsfqyRSbAHtxpAHqEL2D
         OKKoNyAWOSXdyvRscb9WvloQWyOE5NO+0yRA/veqnYm6a1CoW2AdmqhQfO7E+SFNFJzC
         z5/RMzuyAhRc3NfcZJNREUzr5Bdan16WqPVcNl/H6RHS/E/jeSbzMljW1q0YxEb3S/fl
         gwlgRv79mBMTH6Ts8Lkw92/i4TmlN8T/92ZJjrB+TE9X+4yZ/4ll2851tz7PtUrfSwQ/
         4OfvkfDO/qTEjp0ctmAkvZVViAYSs5yErBFiIYGh/zb8bzNJHjflLqWpLK0+9ETlKBTp
         aZrQ==
X-Gm-Message-State: AFq9FYKC2109Yy9RdcXbYFTldzaf2VIKHiK2IRGG7tsBirBAz70HQkR9
	45I3Q6taQtDAX+unW7QDJp8Z9HuItTsYvGZPqURapG1s4BSs781nqz2s2IQW4rQu
X-Gm-Gg: AYBFou3GJugnU4NiEtUDHI+M3QhIpHtm79J8FiuhkX1g5tvfe0U0GqhpooLjFpda8u9
	WHrgeApOkzAXrrRJyiDfY5aTwyuc6nBQk2xsoik9uOJgbtR8YmFudjKPZKgyUpDbhe6AIvc8Qcz
	VS9O4fGhxzjuyOUY4DGCX+FYUDgBxPD+xfpNFwHWa+AJkWk51UYyNxaRTapUGBHWhcdjtcAH3zD
	MMOzQEeSobrP7x+e/OK6LSNYHMm9jG21CNrWtv5SiSGy+X+L0+FcVr+pDVtGq3DeHqiNaQ79azw
	TnzcTHRSzOaozBiSW23rSwUbfkISVa1g7784v9ezSG914cOhBJPa6oZ2Ut5i0sfJamgdutNsnhh
	e7KHBkZNH90XLmQloVKmBucItRPIhYNoiK4qBzdcLqwVYw7sZyTyDRyc4OqvWTxNy8MFpG7m1Uh
	2ua4V+GAvbtpXmSd6qV0+wnfy1EaqDtOXXAGlrv45g1bb0xkuTLQn6y1Psx1WfoqEBNRbFS45b8
	V/vcXvcwYXoXU+1veBH8B6Olin49YeEYKQH4L0605PB6M0F/yZOR/b4XV9I5i6DgtQLB1wBI4ni
	sosZRLyhQKUhFXaRwSguPAHzL5bRQOS7lCLJohvRwNF/EjpM45b9yFvyvWsNUFQ30ldPE3JYgKh
	1v0lWL8GE87ikwYYhMmf7Yb8ETBY7lMCbPefwoKIsdPpLOHjlRx7fi/k7EEyxg1/MXXyThth2+j
	8ZNGY3bqz1mAWIiyeTFydQyfQr3F8uChUpE9JK6tnEB+WkBho7S3o=
X-Received: by 2002:a05:620a:4728:b0:93e:d051:8f19 with SMTP id af79cd13be357-94408a97b0bmr346774985a.40.1793197741526;
        Wed, 28 Oct 2026 07:29:01 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f05ae2f3sm1276791885a.5.2026.10.28.07.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:29:01 -0700 (PDT)
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
Subject: [PATCH 2/2] libsemanage/genhomedircon: apply path substitution rules to home directories
Date: Wed, 28 Oct 2026 10:28:43 -0400
Message-ID: <20261028142843.130002-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028142843.130002-1-stephen.smalley.work@gmail.com>
References: <20261028142843.130002-1-stephen.smalley.work@gmail.com>
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
patterns, using the helpers added in the previous commit.  Wildcard
substitution rules are skipped with a warning since they cannot be
applied to these prefixes.

A side effect is that the existing check for password file entries
conflicting with a file context now checks the canonical path, which
makes it catch conflicts it previously missed, as file context rules
always use original paths (semanage rejects aliased file specs).

Verified in a container against the Fedora targeted policy:

- HOME=/var/home together with the stock "/var/home /home" subs_dist
  rule now generates /home/[^/]+ patterns, and matchpathcon resolves
  /var/home/<user>/.ssh/authorized_keys to ssh_home_t again
- chained local (/srv/homes -> /var/home) and distribution
  (/var/home -> /home) rules resolve to /home
- per-user patterns generated from SELinux user mappings are
  canonicalized as well
- with no matching substitution rules the generated file is
  byte-identical to the unpatched output

Reference: https://github.com/SELinuxProject/selinux/issues/547
Signed-off-by: Eugenij Safonov <ja.safonau@protonmail.com>
---
 libsemanage/src/genhomedircon.c | 100 +++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 2717712c..a7bcb296 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -36,6 +36,9 @@
 
 #include "utilities.h"
 #include "genhomedircon.h"
+#include "path_subs.h"
+
+#include <selinux/selinux.h>
 
 #include <assert.h>
 #include <ctype.h>
@@ -120,6 +123,10 @@ typedef struct {
 	genhomedircon_user_entry_t *fallback;
 	semanage_handle_t *h_semanage;
 	sepol_policydb_t *policydb;
+	/* path substitution rules (see file_contexts.subs(5)) used to
+	 * canonicalize home directory paths */
+	semanage_path_subs_t *local_subs;
+	semanage_path_subs_t *dist_subs;
 } genhomedircon_settings_t;
 
 typedef struct {
@@ -190,6 +197,56 @@ static int ignore(const char *homedir)
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
+	char *newpath;
+
+	for (h = *list; h; h = h->next) {
+		newpath = semanage_path_subs_canonicalize(
+			s->local_subs, s->dist_subs, h->data);
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
+/* Path of a path substitution file (file_contexts.subs or
+ * file_contexts.subs_dist) below the final SELinux policy directory. */
+static char *subs_file_path(bool dist)
+{
+	const char *root = semanage_final_path(SEMANAGE_FINAL_SELINUX,
+					       SEMANAGE_FINAL_TOPLEVEL);
+	const char *abs_path = dist ? selinux_file_context_subs_dist_path() :
+				      selinux_file_context_subs_path();
+	size_t root_len = strlen(selinux_policy_root());
+	char *path;
+
+	if (asprintf(&path, "%s%s", root, abs_path + root_len) < 0)
+		return NULL;
+
+	return path;
+}
+
 static int prefix_is_homedir_role(const semanage_user_t *user,
 				  const char *prefix)
 {
@@ -394,6 +451,9 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t *s)
 		}
 	}
 
+	if (canonicalize_homedir_list(s, &homedir_list))
+		goto fail;
+
 	if (!(s->usepasswd))
 		return homedir_list;
 
@@ -462,6 +522,16 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t *s)
 
 		semanage_rtrim(path, '/');
 
+		{
+			char *canonical = semanage_path_subs_canonicalize(
+				s->local_subs, s->dist_subs, path);
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
@@ -1144,8 +1214,14 @@ retry:
 		goto cleanup;
 	}
 
-	retval = push_user_entry(head, name, uid, gid, sename, prefix,
-				 pwent->pw_dir, level, selogin, homedir_role);
+	char *canonical_home = semanage_path_subs_canonicalize(
+		s->local_subs, s->dist_subs, pwent->pw_dir);
+
+	retval =
+		push_user_entry(head, name, uid, gid, sename, prefix,
+				canonical_home ? canonical_home : pwent->pw_dir,
+				level, selogin, homedir_role);
+	free(canonical_home);
 cleanup:
 	free(rbuf);
 	return retval;
@@ -1462,6 +1538,7 @@ int semanage_genhomedircon(semanage_handle_t *sh, sepol_policydb_t *policydb,
 {
 	genhomedircon_settings_t s;
 	FILE *out = NULL;
+	char *subs_path_local = NULL, *subs_path_dist = NULL;
 	int retval = 0;
 
 	assert(sh);
@@ -1469,6 +1546,8 @@ int semanage_genhomedircon(semanage_handle_t *sh, sepol_policydb_t *policydb,
 	s.homedir_template_path =
 		semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL);
 	s.fcfilepath = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_HOMEDIRS);
+	s.local_subs = NULL;
+	s.dist_subs = NULL;
 
 	s.fallback = calloc(1, sizeof(genhomedircon_user_entry_t));
 	if (s.fallback == NULL) {
@@ -1493,6 +1572,18 @@ int semanage_genhomedircon(semanage_handle_t *sh, sepol_policydb_t *policydb,
 	s.h_semanage = sh;
 	s.policydb = policydb;
 
+	subs_path_local = subs_file_path(false);
+	subs_path_dist = subs_file_path(true);
+	if (!subs_path_local || !subs_path_dist) {
+		retval = STATUS_ERR;
+		goto done;
+	}
+	if (semanage_path_subs_load(sh, subs_path_local, &s.local_subs) < 0 ||
+	    semanage_path_subs_load(sh, subs_path_dist, &s.dist_subs) < 0) {
+		retval = STATUS_ERR;
+		goto done;
+	}
+
 	if (!(out = fopen(s.fcfilepath, "we"))) {
 		/* couldn't open output file */
 		ERR(sh, "Could not open the file_context file for writing");
@@ -1510,6 +1601,11 @@ done:
 	while (s.fallback)
 		pop_user_entry(&(s.fallback));
 
+	semanage_path_subs_free(&s.local_subs);
+	semanage_path_subs_free(&s.dist_subs);
+	free(subs_path_local);
+	free(subs_path_dist);
+
 	ignore_free();
 
 	return retval;
-- 
2.56.0

