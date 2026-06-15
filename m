Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6072D3EBF15
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526541; cv=none; b=nP8m/M1LnQUSkyzU81sMzo+LuTiDb5rqlxS5BjiqwUqOJiiKc0KZvIPiV4eYo3ktNasW1P26sW0xuRkr8Ix7RQfsOTDfvPZUl3h6Rr4O5e5cLegK9wKhs5mISjQpZRiDX3NnPTPnyFoq2pEvrKnWNqSsSg1OdfEy2Sme4pfDMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526541; c=relaxed/simple;
	bh=eQeKm6AI0mQqXgpLXKo/w0Ypppbhlob0Ax5sayvw29M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7vDllXp+SuqdQF4TOWZbUe7R7Lb0zmT676BgAdVin7cBore43ckLvQuHqN+9sWRSmMbI3VTDvf8UeerwVVvjTzFfS9wq4A38Dyzj95JHTg1ARKw3fRBaESaTpFXs1YLhFoEXAkdpM7NvDaplnEE/LMseqW5dTN0bGbeao8j4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI7ECK9X; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI7ECK9X"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ccd1f57b32so41938746d6.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781526537; x=1782131337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wD9s0K23RLzV+jLC/XlDXG+rTEHgra6rvcCEiYCn0q8=;
        b=FI7ECK9XzS56X8fvSaRcGrVbkgRBvLo+hIcHPZW0PcSLTQwQ2z9skkOBeM9NZHK8lQ
         3eMJTFt22lGEo+iNebN4b4EpOGece5CyuCbKsQNtXCd75EUuOlUosaqVFC4xp6FZ7bwO
         jxlE9hY5LMua/WpMn2+oY9iBaX08vMq6v8ifYfW0ncHhyK8voAZHUUsRrprmeZs7r71h
         EJxZTkAV+QoDv+O1s/pN3elCTSRvHA/BhZYALzeOjG2L/DHPL+bx0wk+Y4AtzpodH3qu
         BwXEXF85jvVSwK4Ccr9QlXi9d79VEbzJyyyqucPAk/K/o/rVolCOcOv0sZLsjr8fDyUo
         Ktsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526537; x=1782131337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD9s0K23RLzV+jLC/XlDXG+rTEHgra6rvcCEiYCn0q8=;
        b=kb1WrZUzvfGxTgw+d9AkevvvcsT4ilk+XxZwl9GsJHMxcl0jmVX33QgPphGvDyXVnv
         6teIluUfp9EpJW4WhcPvOmeODqencRNwBRSBTe8uGC21ijwQRB/CTgveO4k+a0NfN5bQ
         fZbwopqN68lHXdkocAhTpf1RyjxTDg/UooP90UEP2ueRXoX6Iz3pqv7k6kYpEn58pJsF
         xJ+g7jHY2Uc/bJp8FzKG+RqObJyq/tw71rw1rOtwO9pFZZGahSbBe3Umvo1Q5KCLYgw/
         hG4Gb9E3Ha7Oqyd7KNQ21bfRnixjutl8As9o1jjDEdkTaINs/siEJLI+zN3C6KN2zD8u
         jT4w==
X-Gm-Message-State: AOJu0Yz3WFAgQsIaWqCx4MF1Lbv80Z5pL3ee77TTkjh/5/MmQjxCrQ7R
	IYJeKfTGQ0QRi6yWOmFyh1vkSH56hTqU9r36mrWn5SWdPXKoF09ElFdSalHx1A==
X-Gm-Gg: Acq92OHtajxwzf7eAsBrD8pBSho9oRDqgtfJ6bNbX857j949O2EzokaiA9Jf3oRC383
	HMue+ThJu1bS9gx5gUy2qtHgCWtZ2xahRXuc6CG1ieNTaVnpHZKtYgfhiwBgYMZNFGEtmbZH/RJ
	VgCzaEu59VeAtKgZSrgFb49leUZOs1xxudiN3G7SLUqVXSF50IP/JTZ/5RWW81wO+iNzve0N22+
	ravWuZY5DD/6APgpY23k4uAakEbG3jCImZHD+3U8odlSHoWlPJTsxh2lUrJg6TsqlaYqtKvYBpG
	Ml201uvIBytNVBGvK0beTPZZ5O7vxTZvKsLLByPVfnWeFiG3Pk8qXJS96e6afbalBSdiQPGLKpr
	wK9Qk+AeElAk+OWBQeuDap4KlBFMNrbZTpV8PY1gAIQ7IYwRJOxwNCcprtLZGu0m48yPj7Bx6Lx
	NEMc32Dg2nzfjMUYzJ0gH8lV6BY9KW8J/SsDRWjIFbfm7BpfflTlrZPZRgNN/gaPTcif3afWyq1
	dvkejPtSaOmS4tkIHrhN4KeCsc=
X-Received: by 2002:ad4:5ce9:0:b0:8cc:ce88:9eda with SMTP id 6a1803df08f44-8d32c01110dmr237702036d6.15.1781526536984;
        Mon, 15 Jun 2026 05:28:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d304578816sm110144606d6.23.2026.06.15.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:28:56 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] libsepol: cast to unsigned char in ctype calls
Date: Mon, 15 Jun 2026 08:28:40 -0400
Message-ID: <20260615122840.42032-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

Passing a plain char to the <ctype.h> functions is undefined when the
value is negative (C11 7.4p1). On platforms where char is signed, a byte
>= 0x80 from a module name, seusers/file_contexts entry, CIL identifier
or IP token sign-extends to a negative int. Cast to unsigned char before
each isspace/isalnum/isalpha/isdigit call, as libselinux already does.

Fixes: https://github.com/SELinuxProject/selinux/pull/525
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c |  7 ++++---
 libsepol/cil/src/cil_verify.c    | 11 ++++++-----
 libsepol/cil/src/cil_write_ast.c |  2 +-
 libsepol/src/module_to_cil.c     | 10 +++++-----
 libsepol/src/util.c              |  8 +++++---
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 2b0921f0..3a6b1631 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4507,7 +4507,7 @@ int cil_gen_nodecon(struct cil_db *db, struct cil_tree_node *parse_current,
 	} else {
 		char *addr = parse_current->next->data;
 		if (strchr(addr, ':') ||
-		    (strchr(addr, '.') && isdigit(addr[0]))) {
+		    (strchr(addr, '.') && isdigit((unsigned char)addr[0]))) {
 			cil_ipaddr_init(&nodecon->addr);
 			rc = cil_fill_ipaddr(parse_current->next,
 					     nodecon->addr);
@@ -4529,7 +4529,7 @@ int cil_gen_nodecon(struct cil_db *db, struct cil_tree_node *parse_current,
 	} else {
 		char *mask = parse_current->next->next->data;
 		if (strchr(mask, ':') ||
-		    (strchr(mask, '.') && isdigit(mask[0]))) {
+		    (strchr(mask, '.') && isdigit((unsigned char)mask[0]))) {
 			cil_ipaddr_init(&nodecon->mask);
 			rc = cil_fill_ipaddr(parse_current->next->next,
 					     nodecon->mask);
@@ -5749,7 +5749,8 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr)
 	addr_str = addr_node->data;
 	if (strchr(addr_str, ':')) {
 		addr->family = AF_INET6;
-	} else if (strchr(addr_str, '.') && isdigit(addr_str[0])) {
+	} else if (strchr(addr_str, '.') &&
+		   isdigit((unsigned char)addr_str[0])) {
 		addr->family = AF_INET;
 	} else {
 		goto exit;
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 67b98b09..eb732e44 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -115,7 +115,7 @@ int cil_verify_name(const struct cil_db *db, const char *name,
 		goto exit;
 	}
 
-	if (!isalpha(name[0])) {
+	if (!isalpha((unsigned char)name[0])) {
 		cil_log(CIL_ERR, "First character in %s is not a letter\n",
 			name);
 		goto exit;
@@ -123,8 +123,8 @@ int cil_verify_name(const struct cil_db *db, const char *name,
 
 	if (db->qualified_names == CIL_FALSE) {
 		for (i = 1; i < len; i++) {
-			if (!isalnum(name[i]) && name[i] != '_' &&
-			    name[i] != '-') {
+			if (!isalnum((unsigned char)name[i]) &&
+			    name[i] != '_' && name[i] != '-') {
 				cil_log(CIL_ERR,
 					"Invalid character \"%c\" in %s\n",
 					name[i], name);
@@ -133,8 +133,9 @@ int cil_verify_name(const struct cil_db *db, const char *name,
 		}
 	} else {
 		for (i = 1; i < len; i++) {
-			if (!isalnum(name[i]) && name[i] != '_' &&
-			    name[i] != '-' && name[i] != '.') {
+			if (!isalnum((unsigned char)name[i]) &&
+			    name[i] != '_' && name[i] != '-' &&
+			    name[i] != '.') {
 				cil_log(CIL_ERR,
 					"Invalid character \"%c\" in %s\n",
 					name[i], name);
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index e09f558d..ca3b0ce3 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1708,7 +1708,7 @@ static int __write_parse_ast_node_helper(struct cil_tree_node *node,
 		size_t i;
 
 		for (i = 0; i < len; i++) {
-			if (isspace(str[i])) {
+			if (isspace((unsigned char)str[i])) {
 				fprintf(args->out, "\"%s\"\n", str);
 				return SEPOL_OK;
 			}
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 9e61754f..9881c9ce 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -118,7 +118,7 @@ static int get_line(char **start, char *end, char **line)
 
 	*line = NULL;
 
-	for (p = *start; p < end && isspace(*p); p++)
+	for (p = *start; p < end && isspace((unsigned char)*p); p++)
 		;
 
 	*start = p;
@@ -3534,7 +3534,7 @@ static int seusers_to_cil(struct sepol_module_package *mod_pkg)
 
 	while ((rc = get_line(&cur, end, &line)) > 0) {
 		tmp = line;
-		while (isspace(*tmp)) {
+		while (isspace((unsigned char)*tmp)) {
 			tmp++;
 		}
 
@@ -3627,7 +3627,7 @@ static int user_extra_to_cil(struct sepol_module_package *mod_pkg)
 
 	while ((rc = get_line(&cur, end, &line)) > 0) {
 		tmp = line;
-		while (isspace(*tmp)) {
+		while (isspace((unsigned char)*tmp)) {
 			tmp++;
 		}
 
@@ -3699,7 +3699,7 @@ static int file_contexts_to_cil(struct sepol_module_package *mod_pkg)
 
 	while ((rc = get_line(&cur, end, &line)) > 0) {
 		tmp = line;
-		while (isspace(*tmp)) {
+		while (isspace((unsigned char)*tmp)) {
 			tmp++;
 		}
 
@@ -4411,7 +4411,7 @@ static int fix_module_name(struct policydb *pdb)
 	// CIL is more restrictive in module names than checkmodule. Convert bad
 	// characters to underscores
 	for (letter = pdb->name; *letter != '\0'; letter++) {
-		if (isalnum(*letter)) {
+		if (isalnum((unsigned char)*letter)) {
 			continue;
 		}
 
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index 01616577..52faeaa6 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -248,10 +248,11 @@ static inline int tokenize_str(char delim, char **str, const char **ptr,
 	*str = NULL;
 
 	while (**ptr != '\0') {
-		if (isspace(delim) && isspace(**ptr)) {
+		if (isspace((unsigned char)delim) &&
+		    isspace((unsigned char)**ptr)) {
 			(*ptr)++;
 			break;
-		} else if (!isspace(delim) && **ptr == delim) {
+		} else if (!isspace((unsigned char)delim) && **ptr == delim) {
 			(*ptr)++;
 			break;
 		}
@@ -273,7 +274,8 @@ static inline int tokenize_str(char delim, char **str, const char **ptr,
 	}
 
 	/* Squash spaces if the delimiter is a whitespace character */
-	while (**ptr != '\0' && isspace(delim) && isspace(**ptr)) {
+	while (**ptr != '\0' && isspace((unsigned char)delim) &&
+	       isspace((unsigned char)**ptr)) {
 		(*ptr)++;
 	}
 
-- 
2.54.0

