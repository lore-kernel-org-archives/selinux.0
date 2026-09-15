Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C94229D9
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488490; cv=none; b=JIjfqjaJbROTGe+4v0hAofpv9j3xyRyQdPBp4+SzFOYMv7IcH8Ml5B91BW0+Bdr4voYwV6loudY/AE32okRCl7qzqfoiEapcway6GOM+266yzkaxGDlUYsKgaS5Mu1h1z1/W2sBPts3IA5AsDLSGxqe3xykvJxJcY9nMTuzV2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488490; c=relaxed/simple;
	bh=VT6LdAzqHzUMSm0Nzy9o96jThGlb3f4ugXVlPPi50X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+jcRLeSbUqX2uCCMmguNKdTdnj6YQG5LQdEN7LxS4x1uMhcqcXUTC4aNk4L9CqMXXkDdhtWdpTtfxdoxYw9P3LUfEV/tUEaFQR6ApSoQIXva9ldh7E1CyUvvd2J4qa2sF++V4VMY8kngGyQQWYpffyBFlLWIGv5WS6INgwixio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aabj1VhV; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aabj1VhV"
Received: by mail-vs2-f42.google.com with SMTP id ada2fe7eead31-7954fbd0ffaso1067606137.3
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488487; x=1790093287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLWIEq+TsGB/pKgK6y1w1RaY1u+Ut//y4bF7GHfcuZs=;
        b=Aabj1VhVJ/gfjqhXsOpc5/cnkfMFQ74he7hzlCNQL2R4huVi6SSregvEgiaP1f5Xxz
         7E3foQlGZM0AERfxuDTMfgHJCvY497ut/rIQIcsWM/X3YQpOxSaUrGxOFg74XvMnhCev
         lZ+2RFSiEfn7kcpHuYdU0Z9QZd2uhPqIKjBiM/WkWlSvgDYfM/Uzca2tE8t4+VE8C/Fu
         bPWcbVcmH+sAOsjaQVTCn+sZlgAsTYCeslSI2R4nZkVExys9sXLgXyNnYcpcAbKlVtD+
         xMurV5Pcav3m64ZjRalcYJvtSdRVa/jkannUQ9K+gkS+es6BgFz7G19Nc05mlN9nHiTW
         QLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488487; x=1790093287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eLWIEq+TsGB/pKgK6y1w1RaY1u+Ut//y4bF7GHfcuZs=;
        b=yRQTalwpncGt5XCpNo4Ezm+iOQ9v22Ix/p+PCT8OGkvwLUp7AhzqQSc3uLCiXP7j1i
         aFkVnP1TMNeKNTrhmD3rKEVlsuX+aEtU2qF0Sqskcm8WUBxkpjQDVK9pgj5E3HFz/96f
         EGGRUQ6NSINOZtUV2HAfA2dOtGcysh80D+akLFH9tua5Nswd7ys8Y3lZApJMhJL/jTTD
         uB6HtBtbYkVg30mzC6tXt8N3jrE5huuPO62QqOiFHAg/WaS7SN8mpjF+kXX9LWNS3M8F
         T1ACbiY+TOp50TpxDAcS/pGZNtlVbENrYTh4AEzRZDItXhF9bUGow5AJwyMp6MZMZKOS
         nOng==
X-Gm-Message-State: AFuF++nWdyb7w2qCm5zE6PduKIPLjCYNidVArmR2omMJEFxy0HqbjU0l
	YHc8tOwPEpmwJxALVR4EM2RMuho9RG+A30d9EpnJstSoKRlWPf3NbUhA+3zyZA==
X-Gm-Gg: AYBFou1J+XahN3VSdyDMhL60krei8dNBguzGOY3ZuimVX30t5NaJlRzrYd6+Ha4CW9A
	cOkMKna6U3Cjfa0gFtAWw17SHwaKLaNDCSZE5UPI1zngnXLCIxfOSmhsS8dtQuxIujDaFMSzFig
	NNvXKEpduVka0diMKZ56FcWJ8mmferUUaRrAAc/EFDGakN8S7ipbn6PDiThCzLdRilSFTSgi6tM
	ZWNHCUXbZueU9RNp+kbPHTsa8RsI13pmHMGfBd46LRnps36lmIQcoG2sy2hvpR9zn9mC5byf7VS
	/77g+qG8n6/2mmGtkF4gGULfgbkrV45nUHUP7qF+DMkAiBoeA8mFDbTDcVQNNF7CvBrBraBcEpM
	x2Z3mMg8dPE5KzPO8MAKqOkpL9OyhNocURFkvX/tq6HZcA/qrw2Cl+r4nXB03ZdxeZpDqodebhI
	Z3OXqE39xjbVCBxyoGo5z3B9P6ZjHRip80bA9hgxP75VUqjd2oSNEvrw7IW2G+ss+BG4GGq/P6u
	AuWA4O0d0fdQQznPS1baKhl1TUTnEMLvsqZoyBUckiVoM4Y/+Tmk1tesl8OHQakrXydukkrGqFW
	TfAToxnkJA==
X-Received: by 2002:a05:6102:c91:b0:79b:c51a:e5a with SMTP id ada2fe7eead31-79bc51a11a3mr9147595137.0.1789488487377;
        Tue, 15 Sep 2026 09:08:07 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be7c885sm1961696d6.21.2026.09.15.09.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:08:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/4] libsepol/cil: reject control characters in ocontext name fields
Date: Tue, 15 Sep 2026 12:07:38 -0400
Message-ID: <20260915160738.46723-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915160738.46723-2-stephen.smalley.work@gmail.com>
References: <20260915160738.46723-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CIL lexer accepts a quoted string containing any byte other than
NUL, newline, or the closing quote, and cil_gen_netifcon(),
cil_gen_fsuse(), cil_gen_genfscon(), and cil_gen_ibendportcon() copy
the resulting string into the corresponding policydb ocontext name
field verbatim. policydb_validate() rejects control characters in
these four fields, so a policy such as:

    (netifcon "e\x01th0" ...)

is compiled to a binary that libsepol itself refuses to read back,
breaking any tool that operates on the loaded policy.

The classic policy compiler cannot emit such names since the relevant
lexer tokens (identifier / filesystem / netifname) do not accept
control characters. Bring the CIL compiler to parity by rejecting them
in these four name fields at build_ast time, so a compiled policy is
always accepted by the validator.

The genfscon path and the filecon / typetransition name arguments are
intentionally not covered here; those correspond to pathnames and can
embed control characters.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 4cc9ccf1..eb1537d3 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -56,6 +56,22 @@ struct cil_args_build {
 	struct cil_tree_node *boolif;
 };
 
+static int cil_verify_ocon_name(const char *name, const char *what)
+{
+	const unsigned char *s;
+
+	for (s = (const unsigned char *)name; *s; s++) {
+		if (iscntrl(*s)) {
+			cil_log(CIL_ERR,
+				"Invalid character 0x%02x in %s name\n", *s,
+				what);
+			return SEPOL_ERR;
+		}
+	}
+
+	return SEPOL_OK;
+}
+
 static int cil_fill_list(struct cil_tree_node *current, enum cil_flavor flavor,
 			 struct cil_list **list)
 {
@@ -4622,6 +4638,11 @@ int cil_gen_genfscon(struct cil_db *db, struct cil_tree_node *parse_current,
 	genfscon->fs_str = parse_current->next->data;
 	genfscon->path_str = parse_current->next->next->data;
 
+	rc = cil_verify_ocon_name(genfscon->fs_str, "genfscon filesystem");
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
 	if (parse_current->next->next->next->next) {
 		/* (genfscon <FS_STR> <PATH_STR> <FILE_TYPE> ... */
 		char *file_type = parse_current->next->next->next->data;
@@ -4715,6 +4736,12 @@ int cil_gen_netifcon(struct cil_db *db, struct cil_tree_node *parse_current,
 
 	netifcon->interface_str = parse_current->next->data;
 
+	rc = cil_verify_ocon_name(netifcon->interface_str,
+				  "netifcon interface");
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
 	if (parse_current->next->next->cl_head == NULL) {
 		netifcon->if_context_str = parse_current->next->next->data;
 	} else {
@@ -4792,6 +4819,11 @@ int cil_gen_ibendportcon(__attribute__((unused)) struct cil_db *db,
 
 	ibendportcon->dev_name_str = parse_current->next->data;
 
+	rc = cil_verify_ocon_name(ibendportcon->dev_name_str,
+				  "ibendportcon device");
+	if (rc != SEPOL_OK)
+		goto exit;
+
 	rc = cil_fill_integer(parse_current->next->next, &ibendportcon->port,
 			      10);
 	if (rc != SEPOL_OK) {
@@ -5241,6 +5273,11 @@ int cil_gen_fsuse(struct cil_db *db, struct cil_tree_node *parse_current,
 
 	fsuse->fs_str = parse_current->next->next->data;
 
+	rc = cil_verify_ocon_name(fsuse->fs_str, "fsuse filesystem");
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
 	if (parse_current->next->next->next->cl_head == NULL) {
 		fsuse->context_str = parse_current->next->next->next->data;
 	} else {
-- 
2.55.0

