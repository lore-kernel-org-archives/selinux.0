Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BNTwwWmK"
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1B1703
	for <selinux@vger.kernel.org>; Thu,  7 Dec 2023 08:53:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a00cbb83c80so129682966b.0
        for <selinux@vger.kernel.org>; Thu, 07 Dec 2023 08:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701968021; x=1702572821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Irw99sikyzW6fCcrZbxrcrLDtp9wAwmF7qtfqQBwcbk=;
        b=BNTwwWmKWNL2Djacx3kLt2dkZAWHuTsGoj9SfQb1a581QNR9EThP0jX0WEgGPRmCET
         vQ3L684Nc66IDebYK9XqzLJ2aJBqvqrDbWd+0zVyudmks7fB8aXuwXkTorGi1N44Arna
         +OE+0J6hR9rMaazSGwFw81eie8SQQ/h1NmPjpv1jlayuYSQKQre1+hDokZSNMrFw1MsY
         eCIdFmvs9enul9Sd/RWzaIZps1FVeEteQ3ol1GuKGgaWuUGnustrmbdABpX41Hnbl1ba
         NI5n3iNOUwkcFgB0AfP5Nw3GUlK0vdCKwCH5E6uBDYiCRQsMn8ralpeSccD9yO6lsBVh
         S8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701968021; x=1702572821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Irw99sikyzW6fCcrZbxrcrLDtp9wAwmF7qtfqQBwcbk=;
        b=Lpw0Fk+AQDbF4m1wt6vf0R7H4BcX3oylOOKNkrBgWQkyFD1C1YCzYVnhb5ckwCPpgF
         6oVrAXQZdVTBsltg2zws7cmsz1n9qfe2+enz6Eq/uMKkwdyVKCgNSgyAWrM9Y+wG9KFF
         fQxHED/bNL+mG9z3apcoN+19h6RWojWPoerfnA7TK/6FlCPpdxHMsvNR0LaCcHe4a7he
         5K8x87MlTo0X/3G9z/zE3ZKSG6eHqOduQpD8SCzZzAoDQ3/7nMQdEQ6IOtVjr3fBZTFv
         RJOlB4HFGLroBSJ8PKh6oP6/JVKnHVsYptsbboUnMPQUThAaYrk3U3PVYYdWiOmMR282
         yZxA==
X-Gm-Message-State: AOJu0YxWoronoXNYXXrhW+UqK3xnzwepfQQKGFXJYEt572cq+Q9IDx6L
	qv0Dx5wlQqr6dvrC1P/Jld9VRnwILyk=
X-Google-Smtp-Source: AGHT+IGRulFjsTo7BtKo+hqNfhAc9AtGYOb1xO5kXnZDF6rFm6aEUyQ8cZ9Oi6eLsa3SNsd9oPHhpw==
X-Received: by 2002:a17:907:cc11:b0:a18:2d8f:6bf4 with SMTP id uo17-20020a170907cc1100b00a182d8f6bf4mr1503727ejc.45.1701968020990;
        Thu, 07 Dec 2023 08:53:40 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-172-210.77.10.pool.telefonica.de. [77.10.172.210])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906170400b00a1cdf29af64sm1039211eje.45.2023.12.07.08.53.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:53:40 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2] checkpolicy/dispol: misc updates
Date: Thu,  7 Dec 2023 17:53:36 +0100
Message-ID: <20231207165336.64135-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
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
v2:
   drop 'b' instead of '5' of duplicated boolean option
---
 checkpolicy/test/dispol.c | 57 ++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 944ef7ec..18829c97 100644
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
@@ -50,19 +48,19 @@ static struct command {
 	{CMD,       '2',  "display conditional AVTAB (entirely)"},
 	{CMD,       '3',  "display conditional AVTAB (only ENABLED rules)"},
 	{CMD,       '4',  "display conditional AVTAB (only DISABLED rules)"},
-	{CMD,       '5',  "display conditional bools"},
+	{CMD,       '5',  "display booleans"},
 	{CMD,       '6',  "display conditional expressions"},
 	{CMD|NOOPT, '7',  "change a boolean value"},
 	{CMD,       '8',  "display role transitions"},
 	{HEADER, 0, ""},
 	{CMD,       'c',  "display policy capabilities"},
-	{CMD,       'b',  "display booleans"},
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
@@ -617,7 +621,7 @@ int main(int argc, char **argv)
 				      &policydb, out_fp);
 			break;
 		case '5':
-			display_bools(&policydb, out_fp);
+			display_booleans(&policydb, out_fp);
 			break;
 		case '6':
 			display_cond_expressions(&policydb, out_fp);
@@ -659,9 +663,6 @@ int main(int argc, char **argv)
 		case 'a':
 			display_attributes(&policydb, out_fp);
 			break;
-		case 'b':
-			display_booleans(&policydb, out_fp);
-			break;
 		case 'c':
 			display_policycaps(&policydb, out_fp);
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

