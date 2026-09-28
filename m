Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD453E4C96
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576709; cv=none; b=eTX/2Tp/yUX2LfhMnsxt1TUughgIo9+IGh51yWwYjdJnhB7oyH5ru1bqrTeajw4xduuuph1V2S97fIvML4xYf/nwmB8JU1hu2PSUoXHhVhwACwYkJ3vZv8TAhwu9Rl2/w7a4fDwdz+RwpB0U3sdQRcMBqGOLTjRjSgmep6kCzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576709; c=relaxed/simple;
	bh=/MslaPsAwSJeKoH2RXpoHusPKf/9mDJxI1cvSHvSPPc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RbCAQjBprUtN24TiplDJsMj1fGDPy4mxMJMJD6b7S6sh6Vue6pFwj0UTorO6kixVuXnokv6PLW5YJvXPYeugVvIT3DZMiMuZ0tNf/FN7681EY7f745dLvd2/kum7uxDn/vr+6DijBOpraqL8nttbtfOgIuCUPGFpJq6mLPzcjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agTLfn/F; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agTLfn/F"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so3101464a12.2
        for <selinux@vger.kernel.org>; Sun, 27 Sep 2026 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790576707; x=1791181507; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ofpBLAjDkBQ49nas8IbeLZK0rzOy2bm93J3ip0cci10=;
        b=agTLfn/FVCY3Wrx1UQYsIRkMfwfUHLz+5GaLBxpehU7za3Q3EbVRabmYbH0phmXfp/
         iSFO4UoBPrOXoUuLfPZmxUfTYnDe35JHb09PtENO26Xhpv6AV0cclKjumyWSPtWlBpSS
         v3vWWXemK+qVPiSavmCxXTy0d1DCMHiXGfhXvOfQeUjG72dvpJpcB19yIKjxUkOdZ7vT
         z2OXeMATuS1zXPnxlT7G8LJwWy28CegyJ63h5ITripC0MurEdYHRPZlvcxtrAVZUohDE
         8OXpoMEFFTLEKG6Xu3YHNLrK0Zm6hw+o4DqaRYEu7M2dJOdmf2irfutE4fB7sDvPqfS5
         7OCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576707; x=1791181507;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ofpBLAjDkBQ49nas8IbeLZK0rzOy2bm93J3ip0cci10=;
        b=cwYxnmLvAtC3gXFRzgPiUDXvaif/FXwcmvvW5Yz8VMMqaqNVlnLG0Gh/XLiR4P4UZp
         Wezn8hDCU4NEp8jpWW9vCq/c1dG4W7oTQdBZFvyMerrSSTYBfjtDA8Tn/skjiY2WQBYw
         gZZlINyMe7LvpOawZ4vnaxuVuH+ZelJVWFYe/cHVluZObXglnJjT8v33KVlN1Ddt7TBX
         /TS94iXEpET3i+4Llv+8HmyLfSBy4Tzcw+F8tdyy8MiqoOm2dp5Eott63EIBOOC1BMKD
         UQ7VYhSrELYBmKHixM6kNxdWBccsnl2ICVF4q+mjGTJyvYYq7maRQkfX7uw9LudcyRGA
         u6AA==
X-Gm-Message-State: AFuF++kBlTCZCT6MCEfaAueJxJt9hYjcirvrL/ECYzppqbPb1YFTzwG7
	n9ltmoDljRj2qwfS19Y/AqdynJ0oV5ZOUaEp0Nt6cpjY4MHeTLXOtuaESmTvdpnQjW8WE6Bp637
	dOrHJSn6pUEPVvm3/8ZJ8vSL4Hb4nxs2pOHokmem+uOHywOh0pLJ3YJ9aGnWPdpGMPylqUgL0l5
	5CTsnzOWV+oxqWRdJ+u2J1Vfggvj9maAcJGpuVIQ==
X-Received: from pgbfq9.prod.google.com ([2002:a05:6a02:2989:b0:cc7:a4b2:4040])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7010:b0:3da:755f:a031
 with SMTP id adf61e73a8af0-3de26c10217mr7284546637.12.1790576706910; Sun, 27
 Sep 2026 23:25:06 -0700 (PDT)
Date: Mon, 28 Sep 2026 15:24:59 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928062459.3189005-1-inseob@google.com>
Subject: [PATCH v2] libsepol,checkpolicy: add --multiple-decls option
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, nnk@google.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a -m/--multiple-decls option to checkpolicy, mirroring the option of
the same name in secilc, which allows a type or an attribute to be
declared more than once. The declarations are merged into a single
symbol whose attribute set is the union of the attribute sets of the
individual declarations. Without the option a repeated declaration
remains an error.

Policies assembled from several independently maintained sources may
declare the same type in more than one of them. secilc merges such
declarations when it links the resulting CIL files, but checkpolicy
rejects them when the same sources are compiled in a single run.

symtab_insert() already permits multiple declarations of roles and
users, so SYM_TYPES is added to that allowlist, behind a new policydb
flag. Like role attributes, type aliases are excluded, as in secilc;
otherwise add_aliases_to_type() would silently turn a declared type
into an alias of another type. The merge needs nothing else:
create_type() returns the existing datum when the symbol exists and
define_type() sets one attribute bit per declaration against it. Using
the same identifier for both a type and an attribute remains an error,
as does a repeated declaration of any other kind of symbol.

Signed-off-by: Inseob Kim <inseob@google.com>
---
v2:
 - Reject multiple declarations where either the new or the existing
   symbol is a type alias, following the `secilc -m` behavior
---
 checkpolicy/checkpolicy.8                  |  3 +++
 checkpolicy/checkpolicy.c                  | 16 +++++++++++--
 libsepol/include/sepol/policydb/policydb.h |  2 ++
 libsepol/src/policydb.c                    | 28 ++++++++++++++++++++--
 4 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index caaaf67..b37d0ff 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -46,6 +46,9 @@ Output line markers for allow rules, in addition to neverallow rules. This optio
 of the output CIL policy file, but the additional line markers helps debugging, especially
 neverallow failure reports. Can only be used when writing a CIL policy file.
 .TP
+.B \-m,\-\-multiple\-decls
+Allow types and attributes to be re-declared.
+.TP
 .B \-c policyvers
 Specify the policy version, defaults to the latest.
 .TP
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 1ab9598..cc866b3 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -107,7 +107,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
 	       "[-N] [-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O] "
-	       "[-t target_platform (selinux,xen)] [-E] [-V] [-L] [input_file]\n",
+	       "[-t target_platform (selinux,xen)] [-E] [-V] [-L] [-m] [input_file]\n",
 	       progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
 }
@@ -391,6 +391,7 @@ int main(int argc, char **argv)
 	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0,
 		     optimize = 0, disable_neverallow = 0;
 	unsigned int line_marker_for_allow = 0;
+	unsigned int multiple_decls = 0;
 	struct val_to_name v;
 	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
 	unsigned int policyvers = 0;
@@ -422,11 +423,12 @@ int main(int argc, char **argv)
 		{ "optimize", no_argument, NULL, 'O' },
 		{ "werror", no_argument, NULL, 'E' },
 		{ "line-marker-for-allow", no_argument, NULL, 'L' },
+		{ "multiple-decls", no_argument, NULL, 'm' },
 		{ "help", no_argument, NULL, 'h' },
 		{ NULL, 0, NULL, 0 }
 	};
 
-	while ((ch = getopt_long(argc, argv, "o:t:dbU:MNCFSVc:OELh",
+	while ((ch = getopt_long(argc, argv, "o:t:dbU:MNCFSVc:OELmh",
 				 long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'o':
@@ -507,6 +509,9 @@ int main(int argc, char **argv)
 		case 'L':
 			line_marker_for_allow = 1;
 			break;
+		case 'm':
+			multiple_decls = 1;
+			break;
 		case 'h':
 		default:
 			usage(argv[0]);
@@ -555,6 +560,12 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (multiple_decls && binary) {
+		fprintf(stderr,
+			"Multiple declarations are only meaningful when compiling source policy\n");
+		exit(1);
+	}
+
 	if (binary) {
 		fd = open(file, O_RDONLY);
 		if (fd < 0) {
@@ -628,6 +639,7 @@ int main(int argc, char **argv)
 		parse_policy.mls = mlspol;
 		parse_policy.handle_unknown = handle_unknown;
 		parse_policy.policyvers = policyvers;
+		parse_policy.multiple_decls = multiple_decls;
 
 		policydbp = &parse_policy;
 
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index bf948d9..ae125fd 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -630,6 +630,8 @@ typedef struct policydb {
 	/* avrules whose line markes will be printed. Defaults to neverallow and
 	   neverallowxperm */
 	uint32_t line_marker_avrules;
+
+	int multiple_decls;
 } policydb_t;
 
 struct sepol_policydb {
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 9716f5f..fbfc0bf 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1385,6 +1385,12 @@ int policydb_load_isids(policydb_t *p, sidtab_t *s)
 	return 0;
 }
 
+static int type_is_alias(const type_datum_t *type)
+{
+	return type->flavor == TYPE_ALIAS ||
+	       (type->flavor == TYPE_TYPE && !type->primary);
+}
+
 /* Declare a symbol for a certain avrule_block context.  Insert it
  * into a symbol table for a policy.  This function will handle
  * inserting the appropriate scope information in addition to
@@ -1456,8 +1462,11 @@ int symtab_insert(policydb_t *pol, uint32_t sym, hashtab_key_t key,
 			return rc;
 		}
 	} else if (scope_datum->scope == SCOPE_DECL && scope == SCOPE_DECL) {
-		/* disallow multiple declarations for non-roles/users */
-		if (sym != SYM_ROLES && sym != SYM_USERS) {
+		/* disallow multiple declarations for non-roles/users, unless
+		 * the policy opted in to multiple declarations of types and
+		 * attributes */
+		if (sym != SYM_ROLES && sym != SYM_USERS &&
+		    !(sym == SYM_TYPES && pol->multiple_decls)) {
 			return -2;
 		}
 		/* Further confine that a role attribute can't have the same
@@ -1478,6 +1487,21 @@ int symtab_insert(policydb_t *pol, uint32_t sym, hashtab_key_t key,
 				return -2;
 			}
 		}
+		if (sym == SYM_TYPES) {
+			type_datum_t *base_type;
+			type_datum_t *cur_type = (type_datum_t *)datum;
+
+			base_type = (type_datum_t *)hashtab_search(
+				pol->symtab[sym].table, key);
+			assert(base_type != NULL);
+
+			if (type_is_alias(base_type) ||
+			    type_is_alias(cur_type)) {
+				/* Only regular types and attributes are
+				 * allowed to have multiple declarations. */
+				return -2;
+			}
+		}
 	} else if (scope_datum->scope == SCOPE_REQ && scope == SCOPE_DECL) {
 		scope_datum->scope = SCOPE_DECL;
 	}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

