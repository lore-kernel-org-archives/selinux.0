Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648C43550A
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143118; cv=none; b=ZmGJV/vhuROCCbOQcX0nfk5jZO3FNrDsSKs60gIN1cB+EluU19sE+swBTQIZOO+XTm6DYb62/qweKptLg1BHkzf6ysUSODijHjm2twV6mIfS7ruG4zE1etwEDsfru2VqgXxw8gDHPG3lBqmlW7SivQ6FxqcPge6jKxhNfTEUaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143118; c=relaxed/simple;
	bh=PmH391A6TO0gaGyUsBIKOitYnmb7K4504f9XXR9L0Zk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DTFgb1RhmAW8zVTjdWVENKkrdy+sGZFzVystCkcuOltW/NYY5rIIHT9BtGrTglhrmhgB+v2TxWUiszXGJb+ENmpRCqt5vO+m/d7Ptg9UH2uoEoXkQlRc7prnytSA9tPihXrirvLHAx8n5ggBnEnYrhcpHs0HNzoNA7J8cwaUjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4nHV5Wq; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4nHV5Wq"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so907816a12.1
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 22:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790143116; x=1790747916; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NXJUetFR7AJ6D/BzchuT4HBHOV5ivAIlr/T9LYZQyAk=;
        b=C4nHV5Wqu2vfKi1vJMaFupK54uquOfx9igtI2409Phfnum5LHuOPANvBEf0UH2bEnr
         Mj3JKrAYCgTIdzrQYLj3ISEERQ8gaxamH8is096BrocG7VqZGt94lV9k2vH+OJCy9e0o
         BP7558rRyejHfA9gAAT3Yx96/hi7GhpzRWzM8CZCOs0hLXh6ROXwPjkb35wmISBVhBOw
         7X4PnUBdpfsIsSm7E8qRp5lUFUoCiKQwlUWeMYhZOkGgLDD/H3Hu13e55l2II0iADNva
         5LsRHRTHV75q6Z2y3op4Fj4j2naVdJmYROw7eEKQW+iYHrEybWYp/cNUU9xuTs1m7ceI
         iozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790143116; x=1790747916;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NXJUetFR7AJ6D/BzchuT4HBHOV5ivAIlr/T9LYZQyAk=;
        b=Vt2zyrUg+FVygvtnk/QjC7Bm2grl3Wwe4DJkLPVSMRxFU5OFM9kFJF3aj//sWOQ4SP
         DPl2GyvlZfhjZM1LCHf8gLQsqDCG3awsC2CQJA3VjP00uldseX0hF0MySZzq1kUjU5h6
         7hsc9ZvQN/bNuKq/2PAlBF5S6kkNQzF/pxeQX5f/TGQvXCwvRPlF3pA6XIICexThtBvk
         J9pAg7OHKigw+drJ9BcPZjdU1JimqxHFnP8JhjA99CdPsIppQNB+jxFmG5iofSNTQdGV
         nAgXX0cboRMc27nZ40mVZxrkgrO5BOYrfjhnNukr5ZWaRn9fwOFdYJ3/u9ObYkY0BXsg
         +Yjg==
X-Gm-Message-State: AFuF++kgvQWNyG2Zb/hbIbD/Gh2GqIurwPIeUYEtyq81zjkJLc9hAei+
	GC0mKDAngi0voGiDDogAF36ISzazEq60JFZ/VY0pRPT2bP169q0bCJNjeko9MNDYDXyzUSYR0xD
	MMQhKokqv/o15blm68zFqqOMxbFS28UOm6sF/DAascf7PnkjIZTcFxTg4UaHMcEbnzhDrNhzMhQ
	Rqc/8KdmeQgkLYUHhSgN4vORRbTTegj/N4Y/iWmA==
X-Received: from pgdj28.prod.google.com ([2002:a05:6a02:521c:b0:cc4:37bf:2ca4])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b01:b0:3d3:ae50:97cb
 with SMTP id adf61e73a8af0-3ddf7f0bfd0mr1854115637.24.1790143115637; Tue, 22
 Sep 2026 22:58:35 -0700 (PDT)
Date: Wed, 23 Sep 2026 14:58:23 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923055823.3567355-1-inseob@google.com>
Subject: [PATCH] libsepol,checkpolicy: add --multiple-decls option
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
users, so only SYM_TYPES is added to that allowlist, behind a new
policydb flag. Nothing else is needed: create_type() returns the
existing datum when the symbol exists and define_type() sets one
attribute bit per declaration against it. Using the same identifier for
both a type and an attribute remains an error, as does a repeated
declaration of any other kind of symbol.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 checkpolicy/checkpolicy.8                  |  3 +++
 checkpolicy/checkpolicy.c                  | 16 ++++++++++++++--
 libsepol/include/sepol/policydb/policydb.h |  2 ++
 libsepol/src/policydb.c                    |  7 +++++--
 4 files changed, 24 insertions(+), 4 deletions(-)

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
index 9716f5f..9e0eb72 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1456,8 +1456,11 @@ int symtab_insert(policydb_t *pol, uint32_t sym, hashtab_key_t key,
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
-- 
2.55.0.1082.g2b9226bbc0-goog

