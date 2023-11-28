Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="I7HaYSmP"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC01194
	for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54af0eca12dso6320249a12.3
        for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701195821; x=1701800621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTylBJVMK9XMzuJdFv2XBicAbgdq4KMsxu6TmPMJlCk=;
        b=I7HaYSmPrEUbmdx4plL9RuSeI/CBMqwrqMTEzS2YTK4HwUgj+2ajaVV2Cjyr4nGLBl
         +cBdYadNl7k1ph8qFrFLpfYDWS3LUw0rp1SXSFxzA/AKgcKTf6zG6hEz5VZs5AImLaSZ
         L4zVgiePGfHiMSUQzK0NDNg/1yie3N8whTLIDg3t+aa4+7d5WAWIsJCfZ9RrSBcLu5Cr
         dr/Kjlp0vKewq/izILgNyfDcJiVX3kR+HEvwrukW54Onnuywmz4Uz+tBS883bMdYyowi
         ALL678EK+5RtLLhxUs8bbNy2Jv0Lv4icYTIYMSyePK74WQHISjaq+o2MVce/oJsNf8fn
         db0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701195821; x=1701800621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTylBJVMK9XMzuJdFv2XBicAbgdq4KMsxu6TmPMJlCk=;
        b=gMzi1lN1ksC8nEZWoxNttNRPg1VA5sa6Y9dHeuB5P3kYxLOFovtPDm/d0MFpj7p/cW
         TNR4Wu/PY/ykL/wDs+q2Ious/JJHDFPQU0kr4ROSr2eH2y/6QOe603GqzhH7SuOVonZ4
         dn+thvgBu8U9T5G8TYHLAuf6/4x0x+WK/A81cgpjpXsfL/utNZCacNbMH5j09peDN/Wu
         GBMEdMov6g+2kshXe6m/Vh2ZsmW+1E6MiTDhR81QI9MHNyQW6mu46damwGOiPF2vKQjR
         pLedxkJNU8UlLo0571R1rfPgn9QqAoc4JYiKCmS6AGbE1gn3bXL3BYd4UDXzL0Os51QO
         BhFQ==
X-Gm-Message-State: AOJu0YxCw5ek6wFzR6i4oenjGtBlAvztbFHjLE5g4B+0dCWukCi0VLry
	1EDJXs1fZNg4+avSE3iCaZ+6+LzAWsc=
X-Google-Smtp-Source: AGHT+IEOJnuvWOjuv6cD2hXpBfuyxtw/yh59oafJHPK2glDt0NbKbiFeiDmZp3cT1pvDBKP/fWA5gA==
X-Received: by 2002:a17:907:d30c:b0:9ae:699d:8a2a with SMTP id vg12-20020a170907d30c00b009ae699d8a2amr14557996ejc.5.1701195821247;
        Tue, 28 Nov 2023 10:23:41 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-003-184-154.77.3.pool.telefonica.de. [77.3.184.154])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709067d8b00b009dddec5a96fsm7122024ejo.170.2023.11.28.10.23.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 10:23:41 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 4/7] checkpolicy/dispol: misc updates
Date: Tue, 28 Nov 2023 19:23:31 +0100
Message-ID: <20231128182334.57740-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128182334.57740-1-cgzones@googlemail.com>
References: <20231128182334.57740-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* add option to display users
* drop duplicate option to display booleans
* show number of entries before listing them
* drop global variable

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/test/dispol.c | 53 +++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 944ef7ec..02cb9499 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -33,9 +33,7 @@
 #include <stdio.h>
 #include <fcntl.h>
 
-static policydb_t policydb;
-
-static struct command {
+static const struct command {
 	enum {
 		EOL    = 0,
 		HEADER = 1,
@@ -50,7 +48,6 @@ static struct command {
 	{CMD,       '2',  "display conditional AVTAB (entirely)"},
 	{CMD,       '3',  "display conditional AVTAB (only ENABLED rules)"},
 	{CMD,       '4',  "display conditional AVTAB (only DISABLED rules)"},
-	{CMD,       '5',  "display conditional bools"},
 	{CMD,       '6',  "display conditional expressions"},
 	{CMD|NOOPT, '7',  "change a boolean value"},
 	{CMD,       '8',  "display role transitions"},
@@ -58,11 +55,12 @@ static struct command {
 	{CMD,       'c',  "display policy capabilities"},
 	{CMD,       'b',  "display booleans"},
 	{CMD,       'C',  "display classes"},
+	{CMD,       'u',  "display users"},
 	{CMD,       'r',  "display roles"},
 	{CMD,       't',  "display types"},
 	{CMD,       'a',  "display type attributes"},
 	{CMD,       'p',  "display the list of permissive types"},
-	{CMD,       'u',  "display unknown handling setting"},
+	{CMD,       'U',  "display unknown handling setting"},
 	{CMD,       'F',  "display filename_trans rules"},
 	{HEADER, 0, ""},
 	{CMD|NOOPT, 'f',  "set output file"},
@@ -234,17 +232,6 @@ static int display_avtab(avtab_t * a, uint32_t what, policydb_t * p, FILE * fp)
 	return 0;
 }
 
-static int display_bools(policydb_t * p, FILE * fp)
-{
-	unsigned int i;
-
-	for (i = 0; i < p->p_bools.nprim; i++) {
-		fprintf(fp, "%s : %d\n", p->p_bool_val_to_name[i],
-			p->bool_val_to_struct[i]->state);
-	}
-	return 0;
-}
-
 static void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 {
 
@@ -313,6 +300,8 @@ static int display_handle_unknown(policydb_t * p, FILE * out_fp)
 		fprintf(out_fp, "Deny unknown classes and permissions\n");
 	else if (p->handle_unknown == REJECT_UNKNOWN)
 		fprintf(out_fp, "Reject unknown classes and permissions\n");
+	else
+		fprintf(out_fp, "<INVALID SETTING!>\n");
 	return 0;
 }
 
@@ -334,7 +323,7 @@ static int display_booleans(policydb_t * p, FILE *fp)
 {
 	uint32_t i;
 
-	fprintf(fp, "booleans:\n");
+	fprintf(fp, "booleans (#%u):\n", p->p_bools.table->nel);
 	for (i = 0; i < p->p_bools.nprim; i++) {
 		fprintf(fp, "\t%s : %d\n", p->p_bool_val_to_name[i],
 			p->bool_val_to_struct[i]->state);
@@ -364,7 +353,7 @@ static int display_classes(policydb_t * p, FILE *fp)
 {
 	uint32_t i;
 
-	fprintf(fp, "classes:\n");
+	fprintf(fp, "classes (#%u):\n", p->p_classes.table->nel);
 	for (i = 0; i < p->p_classes.nprim; i++) {
 		if (!p->p_class_val_to_name[i])
 			continue;
@@ -386,7 +375,7 @@ static void display_permissive(policydb_t *p, FILE *fp)
 	ebitmap_node_t *node;
 	unsigned int i;
 
-	fprintf(fp, "permissive sids:\n");
+	fprintf(fp, "permissive sids (#%u):\n", ebitmap_cardinality(&p->permissive_map));
 	ebitmap_for_each_positive_bit(&p->permissive_map, node, i) {
 		fprintf(fp, "\t");
 		display_id(p, fp, SYM_TYPES, i - 1, "");
@@ -394,11 +383,25 @@ static void display_permissive(policydb_t *p, FILE *fp)
 	}
 }
 
+static int display_users(policydb_t * p, FILE *fp)
+{
+	uint32_t i;
+
+	fprintf(fp, "users (#%u):\n", p->p_users.table->nel);
+	for (i = 0; i < p->p_users.nprim; i++) {
+		if (!p->p_user_val_to_name[i])
+			continue;
+
+		fprintf(fp, "\t%s\n", p->p_user_val_to_name[i]);
+	}
+	return 0;
+}
+
 static int display_roles(policydb_t * p, FILE *fp)
 {
 	uint32_t i;
 
-	fprintf(fp, "roles:\n");
+	fprintf(fp, "roles (#%u):\n", p->p_roles.table->nel);
 	for (i = 0; i < p->p_roles.nprim; i++) {
 		if (!p->p_role_val_to_name[i])
 			continue;
@@ -412,7 +415,7 @@ static int display_types(policydb_t * p, FILE *fp)
 {
 	uint32_t i;
 
-	fprintf(fp, "types:\n");
+	fprintf(fp, "types (out of #%u):\n", p->p_types.table->nel);
 	for (i = 0; i < p->p_types.nprim; i++) {
 		if (!p->p_type_val_to_name[i])
 			continue;
@@ -429,7 +432,7 @@ static int display_attributes(policydb_t * p, FILE *fp)
 {
 	uint32_t i;
 
-	fprintf(fp, "attributes:\n");
+	fprintf(fp, "attributes (out of #%u):\n", p->p_types.table->nel);
 	for (i = 0; i < p->p_types.nprim; i++) {
 		if (!p->p_type_val_to_name[i])
 			continue;
@@ -522,6 +525,7 @@ int main(int argc, char **argv)
 	char *name;
 	int state;
 	struct policy_file pf;
+	policydb_t policydb;
 
 	if (argc < 2 || strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)
 		usage(argv[0]);
@@ -616,9 +620,6 @@ int main(int argc, char **argv)
 			display_avtab(&policydb.te_cond_avtab, RENDER_DISABLED,
 				      &policydb, out_fp);
 			break;
-		case '5':
-			display_bools(&policydb, out_fp);
-			break;
 		case '6':
 			display_cond_expressions(&policydb, out_fp);
 			break;
@@ -678,6 +679,8 @@ int main(int argc, char **argv)
 			display_types(&policydb, out_fp);
 			break;
 		case 'u':
+			display_users(&policydb, out_fp);
+			break;
 		case 'U':
 			display_handle_unknown(&policydb, out_fp);
 			break;
-- 
2.43.0

