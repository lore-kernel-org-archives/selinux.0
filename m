Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627253;
	b=yzRDQ+u3kwgsQUDoD7IXT/jDsTa1V9uAFhXCnBTCMaSM4fotQjTekbD69F7Pdn54H6ow
	 TrQ9ay7pOALIXnLbR04H4HlHe5OU8BznezcPe+TERNlnL8TGbQcNoPqaf7225C7jP5YYB
	 X+w/t657KmAggJPABqIbqKJ9YNEOKr9hUMlL4762JZMO5QwJvQh3xzY7cvPXRDl3z6Bze
	 OfwRgeFNCYPZIrLYAk493fHn2N9L/1+IF63T01fwAt3n4OasDp5o72WeHh/wz3zz3K/8w
	 Zb3+PlV6ol1gzDnv6LOcBEwuyR3iZc6roRC0kiXjnbrluORZJGesSN7uRbtSq5B043A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M4FTiO7WdNnsj0BwCdH7jc+6ozwFvQPAo1xu9vjkks0=;
	b=nVOI9QRwDrvL+EC2lraqgZxMqcOWjee5H+aWVSpCCOP4SIbj/YhWAwdoW/T0Z6FtjDfV
	 BpH/I6w1wJ4GJPJOE3/YDBAPjq9y2we/We3Ia0jAmPwFMFbrX732WjBji7vsqrZRSZvp/
	 oq3XCp9B22aMKv5fF0jX1qg9CG8WXIyp33gUdwhVUwTrHulaDGAZH8yhBgPTKSndrTSih
	 uao/Onz3Fpe0PXZ5hLaKOykw5jG1bGyV8tmpZZNzxHRT31sO8t8M/XaNkt7knbqIAAGXy
	 OnHqT+dS+tgCnqj4gA6KXXoxyIM+VrD0tpsRNnrbO6jAy6Z2Yum3yPZEJUzObUIw3QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjpTzx6S;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E5606A326
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 13:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E6E5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjpTzx6S
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f30660e69so213335585a.0
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 05:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793627252; x=1794232052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4FTiO7WdNnsj0BwCdH7jc+6ozwFvQPAo1xu9vjkks0=;
        b=NjpTzx6SHeYcR82oEzUtWVoOcGzlrEe3SEvhczMLzSH5OkpwuDvM0sxY4rjHMXqYiv
         oLaD9yO6FSfByp8bVLuLu7IIFL2DanGM7tVn777z0dudX54ENaSvhcNYWgKgoh0mL7u1
         V5M7oXcNmymStoWhNANn8QL+F1ax76wEuUYRp7WA/151UQ0+ocCvJw3kmMejE0xJPcP6
         6uh2rblBZGsH35X8OctFhGJN7CHeA3rIL9Q11tq/VA7sZdKxOWF7IXYHBA4csIrZnJTo
         hLrLe2EU7unjptcvsVZup3cDLaKZc6JEIh+IrC9asDTqxAYi+jAnL2HfUfayM3a2oCQD
         mbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627252; x=1794232052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4FTiO7WdNnsj0BwCdH7jc+6ozwFvQPAo1xu9vjkks0=;
        b=F+FXmSfpQzH7S2xBQtp/478kzSSlFkwnQMamlRCHre0wE3Qz7vIJQ3gtCiSxbATZ81
         p7+8DnTjHWe+ZbwDdv0CdTj/jggHxdCBHIymsQYT5UzemlDrMWMLhCsPJ9z38mLYXeGg
         R3yHS2gT67za0dlC04b5Cn0l+ccsnkZpAyUrW/NcYZDMfcSTP6g04YWQun0ncgWqTJx1
         XS9ddzrnqEi2camg71Kyhupz16kAGqI7WsY+qro88o22TQNDo6lnvlnNDS9bSbsZcjuP
         o0rRmevwnzxODeIo2VkOhYmzVo2vq297OF2TkJiGcRODvrp6Rr44ivbVFH3qMSUOl2Gt
         xFtw==
X-Gm-Message-State: AFq9FYLjtK1G/tH/v5T5QVaU2qB81SOkqe8LCXwDcdFVN+RoLidmvZ0f
	RJ3wwy5bOD456H7fRwupXQT+G/NOKs/ViZGrSMkbIGq6bz2hCwfh5PESl4NFOi2R
X-Gm-Gg: AYBFou1IvwwiQ2nIfZ+wCoqb6oBGFlx6wm2yGKHGY3UiBuIQvvvbTwfCS8xpx81OFfQ
	nRwnJM0OBGq3D7SUBy7uJ3VQk32k9HyHmpCAoStCzhXgLUDHDjG/eNsKBgv04xx3jTCfKBjFY/J
	Xd7LdjANpX/oD3pWBsgrCscvb+KQxV8Ra/LPw/HOgsL2K1amDcmHeyBspcUTpAvKbdLpL954O0b
	bISpzfkeyqOv9/dCD+NR7xB1uYeekFr0u2RbJh64K3Uyp9XY4vtXWTT2j5LBumj7+psd+3dP5ts
	uv3F9UkkmDlMT3PfmJvdFMHayMwfdXg1nSMSDFAwsbZYNfN6rVzhSWGcanyzBbV8pVag/M0YkzA
	kXUMidxpM1L3HoEoxD4gqXBw4cjlQxnCC2vHbth6GXaTqEQKTJvNn3tmfxABI2j5S0zo9nmjCCF
	Eah7XCGMTmvR8691oQFLgYEjKohl3UBp39ekGuAYN3ZQ4i27tKU7M9ucEtxGB7HWY4NRRPNXe2R
	HB6irEN/Op0bITu36n5pJsDTNyMjnIwgSeRCAnJQmf3aHu7WHOe0Lp6hVZNETSUHx5UWxfe0h4M
	0QRRja9L2rXpxK28UQhcMJ150IeKgMqqnCN06wTE1qmQJy46Yr7eMeqRRyOcu+mrAGK4JiS0d0/
	wkXkSkDPzcME9IULXPln4zzSR/9oUlmUOQ1GrkyLRt2L90MG+fdghNCA6bhjGX2fQ6T33rCs7Hc
	cnQ/KImnUOywOTUuGnzTyuNYPvftnAbQkenDFSjkTbR7qfpnuy6ZA=
X-Received: by 2002:a05:620a:4114:b0:944:1fb1:690e with SMTP id af79cd13be357-944217a1987mr1593890985a.63.1793627252470;
        Mon, 02 Nov 2026 05:47:32 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94424e79d0bsm837009285a.0.2026.11.02.05.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:47:32 -0800 (PST)
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
Subject: [PATCH v3 2/2] libsemanage/genhomedircon: apply path substitution rules to home directories
Date: Mon,  2 Nov 2026 08:47:17 -0500
Message-ID: <20261102134718.1825-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102134718.1825-1-stephen.smalley.work@gmail.com>
References: <20261102134718.1825-1-stephen.smalley.work@gmail.com>
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
directory or, failing that, below the vendor configuration root of
the selected store, both below the semanage root, so that a
vendor-only file_contexts.subs_dist is honored without reading the
host configuration.

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
- with the semanage root set to a target image, a subs_dist only
  below the vendor configuration root inside the image is honored,
  and a missing file in the image does not read the host's rules
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
 libsemanage/src/genhomedircon.c | 190 ++++++++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 8 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 2717712c..0b7159bd 100644
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
@@ -190,6 +197,122 @@ static int ignore(const char *homedir)
 	return 0;
 }
 
+/* Canonicalize every entry of a home directory list in place.  Since
+ * canonicalization may make entries collide (e.g. when the useradd and
+ * libuser defaults resolve to the same directory), the list is rebuilt
+ * without duplicates, preserving its order. */
+static int canonicalize_homedir_list(genhomedircon_settings_t *s,
+				     semanage_list_t **list)
+{
+	semanage_list_t *canonical = NULL, *h, *prev = NULL, *next;
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
+	/* semanage_list_push() skips duplicates but prepends, so the
+	 * rebuilt list has to be reversed afterwards */
+	for (h = *list; h; h = h->next) {
+		if (semanage_list_push(&canonical, h->data))
+			goto err;
+	}
+
+	h = canonical;
+	while (h) {
+		next = h->next;
+		h->next = prev;
+		prev = h;
+		h = next;
+	}
+	canonical = prev;
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
+ * file_contexts.subs_dist) of the selected store: below the final
+ * SELinux policy directory or, failing that, below the vendor
+ * configuration root, both below the semanage root.  A file that
+ * neither root has is not an error.  Returns 0 on success, -1 on
+ * error. */
+static int load_subs_file(semanage_handle_t *sh, bool dist,
+			  semanage_path_subs_t **rules)
+{
+	const char *abs_path = dist ? selinux_file_context_subs_dist_path() :
+				      selinux_file_context_subs_path();
+	const char *policy_root = selinux_policy_root();
+	const char *toplevel = semanage_final_path(SEMANAGE_FINAL_SELINUX,
+						   SEMANAGE_FINAL_TOPLEVEL);
+	const char *root = semanage_root();
+	const char *suffix, *store;
+	char *paths[2] = { NULL, NULL };
+	FILE *fp;
+	int refused = 0;
+	int rc = -1;
+	int i;
+
+	*rules = NULL;
+
+	if (!abs_path || !policy_root || !toplevel || !root)
+		return -1;
+
+	/* the part of the libselinux path below the policy root */
+	suffix = abs_path + strlen(policy_root);
+
+	/* the store part of the final SELinux policy directory */
+	if (strlen(toplevel) < strlen(root) + strlen(selinux_path()))
+		return -1;
+	store = toplevel + strlen(root) + strlen(selinux_path());
+
+	if (asprintf(&paths[0], "%s%s", toplevel, suffix) < 0)
+		goto out;
+	if (asprintf(&paths[1], "%s/usr/lib/selinux/%s%s", root, store,
+		     suffix) < 0)
+		goto out;
+
+	for (i = 0; i < 2; i++) {
+		fp = fopen(paths[i], "re");
+		if (fp)
+			break;
+		if (errno == EACCES)
+			refused = 1;
+		else if (errno != ENOENT)
+			goto out;
+	}
+	if (!fp) {
+		if (!refused) {
+			/* not an error: neither root has the file */
+			rc = 0;
+		} else {
+			errno = EACCES;
+		}
+		goto out;
+	}
+
+	rc = semanage_path_subs_load_file(sh, fp, paths[i], rules);
+
+	fclose(fp);
+
+out:
+	free(paths[0]);
+	free(paths[1]);
+	return rc;
+}
+
 static int prefix_is_homedir_role(const semanage_user_t *user,
 				  const char *prefix)
 {
@@ -355,7 +478,7 @@ static bool parse_uid_config(const char *file, const char *key, const char *sep,
 	return false;
 }
 
-static semanage_list_t *get_home_dirs(genhomedircon_settings_t *s)
+static int get_home_dirs(genhomedircon_settings_t *s, semanage_list_t **out)
 {
 	semanage_list_t *homedir_list = NULL;
 	semanage_list_t *shells = NULL;
@@ -364,6 +487,8 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t *s)
 	struct passwd *pwbuf;
 	struct stat buf;
 
+	*out = NULL;
+
 	path = semanage_findval(PATH_ETC_USERADD, "HOME", "=");
 	if (path && *path) {
 		if (semanage_list_push(&homedir_list, path))
@@ -394,8 +519,13 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t *s)
 		}
 	}
 
-	if (!(s->usepasswd))
-		return homedir_list;
+	if (canonicalize_homedir_list(s, &homedir_list))
+		goto fail;
+
+	if (!(s->usepasswd)) {
+		*out = homedir_list;
+		return STATUS_SUCCESS;
+	}
 
 	shells = get_shell_list();
 	if (!shells) {
@@ -462,6 +592,20 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t *s)
 
 		semanage_rtrim(path, '/');
 
+		{
+			char *canonical = NULL;
+
+			if (semanage_path_subs_canonicalize(s->local_subs,
+							    s->dist_subs, path,
+							    &canonical) < 0)
+				goto fail;
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
@@ -500,14 +644,15 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t *s)
 	endpwent();
 	semanage_list_destroy(&shells);
 
-	return homedir_list;
+	*out = homedir_list;
+	return STATUS_SUCCESS;
 
 fail:
 	endpwent();
 	free(path);
 	semanage_list_destroy(&homedir_list);
 	semanage_list_destroy(&shells);
-	return NULL;
+	return STATUS_ERR;
 }
 
 /**
@@ -1144,8 +1289,20 @@ retry:
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
@@ -1386,7 +1543,12 @@ static int write_context_file(genhomedircon_settings_t *s, FILE *out)
 	}
 
 	if (homedir_context_tpl || homeroot_context_tpl) {
-		homedirs = get_home_dirs(s);
+		if (get_home_dirs(s, &homedirs) != STATUS_SUCCESS) {
+			ERR(s->h_semanage,
+			    "Could not get the home directories");
+			retval = STATUS_ERR;
+			goto done;
+		}
 		if (!homedirs) {
 			WARN(s->h_semanage,
 			     "no home directories were available, exiting without writing");
@@ -1469,6 +1631,8 @@ int semanage_genhomedircon(semanage_handle_t *sh, sepol_policydb_t *policydb,
 	s.homedir_template_path =
 		semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL);
 	s.fcfilepath = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_HOMEDIRS);
+	s.local_subs = NULL;
+	s.dist_subs = NULL;
 
 	s.fallback = calloc(1, sizeof(genhomedircon_user_entry_t));
 	if (s.fallback == NULL) {
@@ -1493,6 +1657,13 @@ int semanage_genhomedircon(semanage_handle_t *sh, sepol_policydb_t *policydb,
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
@@ -1510,6 +1681,9 @@ done:
 	while (s.fallback)
 		pop_user_entry(&(s.fallback));
 
+	semanage_path_subs_free(&s.local_subs);
+	semanage_path_subs_free(&s.dist_subs);
+
 	ignore_free();
 
 	return retval;
-- 
2.56.0

