Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20032C76196
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 17:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCaRfJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCaRfI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 13:35:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8CD1DFB7
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 10:35:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so92667213edo.2
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680284105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UogeGrUFgYor9PoY7iEhaLf4O71b3PRPDiz838AXgWo=;
        b=qfd4CzQZYTHqkPAtZXugBtC7zFiQ5EnRrMSKjh7Y4yTkZqFCFEF3GEOWSpqpkYF7Aq
         YuCFxBICBdiWSnd1ycITGO0infFFXiJ2d+aiHFXEGRk4vy4zu7uatujWYcasCgzSiFHf
         0Jyzsz0Qs9F4vcuS/hAHNAElDgfOeODushed2Xr4UJ2EdlzBRfap8rsIUyIXbeRJh89A
         0u5j1tGI8Mk83gIDDH26oIt5YFedh+IZaAidciQ9tHRFEihnAc4BWduM7kBJrEx+8VUX
         4wsdbNYrS4D4drj1JD8AzmTqtRcnYJ8vBInobUZBQAvvUQmFl9nOiU0Z7mxdIdZcLcTH
         +7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UogeGrUFgYor9PoY7iEhaLf4O71b3PRPDiz838AXgWo=;
        b=DuS0RygJKgAWrgN2Kh7pMk6hsAyyjKOap8L6i+7YPKMY6c2pP6e66dGzV6EhA0XFXy
         G1FhKwuSCiAmLJaWGEEizBTVZ5A10WCb0KupS6Xi0A1EzmxPzOro6/VSJHr8Pm6dwPpx
         rVt4JGdp1aSEp59fBTg954MXkHV2NcOXO88BnPI+8nhUC9p3/vJCmmJq05vYTotBBg7F
         VvOTLFiwYfa4GcgRKRlPvfYjnJCApYI1yAeflxnSS4FbonAnWhNLJTxNBIUGeF+6b0nV
         GEIKjTKxaP8tgntHngwj95REFbKqFgs/BEVzpLEos7detfYpCODXbGl27u/SgkOXMsVZ
         dczg==
X-Gm-Message-State: AAQBX9fYMDOmXxiq+Lb71BxJ6BjSJIaCXv3J9Yo2Inf9afHVzN88pO5A
        Wy8qX65j+UNaGOD67Buc7lHJWPeJ33mR05HO
X-Google-Smtp-Source: AKy350YGdlNGFlrnX21lz68W3ZbYpt79/ZQe8/ySvzCD/v7nHvv3scdoBpRmn0fbgS7Wq8F5LF1RKw==
X-Received: by 2002:a50:fb11:0:b0:4fb:5291:13bb with SMTP id d17-20020a50fb11000000b004fb529113bbmr28699303edq.39.1680284105206;
        Fri, 31 Mar 2023 10:35:05 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-126-250.77.10.pool.telefonica.de. [77.10.126.250])
        by smtp.gmail.com with ESMTPSA id h5-20020a50c385000000b004ad601533a3sm1303138edf.55.2023.03.31.10.35.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:35:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] checkpolicy/dispol: add output functions
Date:   Fri, 31 Mar 2023 19:34:41 +0200
Message-Id: <20230331173442.101678-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331173442.101678-1-cgzones@googlemail.com>
References: <20230331173442.101678-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the ability to show booleans, classes, roles, types and type
attributes of policies.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Almost all of the time seinfo(8) is a superior tool and several policy
details are still not supported, e.g. genfscon, ocontexts and class
constraints.
dispol was however useful in the past to analyze some OSS-Fuzz generated
policies, since seinfo trips over non-ascii identifier names.
---
 checkpolicy/test/dispol.c | 94 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 36a3362c..adac2370 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -274,6 +274,18 @@ static int change_bool(char *name, int state, policydb_t * p, FILE * fp)
 	return 0;
 }
 
+static int display_booleans(policydb_t * p, FILE *fp)
+{
+	uint32_t i;
+
+	fprintf(fp, "booleans:\n");
+	for (i = 0; i < p->p_bools.nprim; i++) {
+		fprintf(fp, "\t%s : %d\n", p->p_bool_val_to_name[i],
+			p->bool_val_to_struct[i]->state);
+	}
+	return 0;
+}
+
 static void display_policycaps(policydb_t * p, FILE * fp)
 {
 	ebitmap_node_t *node;
@@ -292,6 +304,20 @@ static void display_policycaps(policydb_t * p, FILE * fp)
 	}
 }
 
+static int display_classes(policydb_t * p, FILE *fp)
+{
+	uint32_t i;
+
+	fprintf(fp, "classes:\n");
+	for (i = 0; i < p->p_classes.nprim; i++) {
+		if (!p->p_class_val_to_name[i])
+			continue;
+
+		fprintf(fp, "\t%s\n", p->p_class_val_to_name[i]);
+	}
+	return 0;
+}
+
 static void display_id(policydb_t *p, FILE *fp, uint32_t symbol_type,
 		       uint32_t symbol_value, const char *prefix)
 {
@@ -312,6 +338,54 @@ static void display_permissive(policydb_t *p, FILE *fp)
 	}
 }
 
+static int display_roles(policydb_t * p, FILE *fp)
+{
+	uint32_t i;
+
+	fprintf(fp, "roles:\n");
+	for (i = 0; i < p->p_roles.nprim; i++) {
+		if (!p->p_role_val_to_name[i])
+			continue;
+
+		fprintf(fp, "\t%s\n", p->p_role_val_to_name[i]);
+	}
+	return 0;
+}
+
+static int display_types(policydb_t * p, FILE *fp)
+{
+	uint32_t i;
+
+	fprintf(fp, "types:\n");
+	for (i = 0; i < p->p_types.nprim; i++) {
+		if (!p->p_type_val_to_name[i])
+			continue;
+
+		if (p->type_val_to_struct[i]->flavor == TYPE_ATTRIB)
+			continue;
+
+		fprintf(fp, "\t%s\n", p->p_type_val_to_name[i]);
+	}
+	return 0;
+}
+
+static int display_attributes(policydb_t * p, FILE *fp)
+{
+	uint32_t i;
+
+	fprintf(fp, "attributes:\n");
+	for (i = 0; i < p->p_types.nprim; i++) {
+		if (!p->p_type_val_to_name[i])
+			continue;
+
+		if (p->type_val_to_struct[i]->flavor != TYPE_ATTRIB)
+			continue;
+
+		fprintf(fp, "\t%s\n", p->p_type_val_to_name[i]);
+	}
+	return 0;
+}
+
 static void display_role_trans(policydb_t *p, FILE *fp)
 {
 	role_trans_t *rt;
@@ -381,6 +455,11 @@ static int menu(void)
 	printf("8)  display role transitions\n");
 	printf("\n");
 	printf("c)  display policy capabilities\n");
+	printf("b)  display booleans\n");
+	printf("C)  display classes\n");
+	printf("r)  display roles\n");
+	printf("t)  display types\n");
+	printf("a)  display type attributes\n");
 	printf("p)  display the list of permissive types\n");
 	printf("u)  display unknown handling setting\n");
 	printf("F)  display filename_trans rules\n");
@@ -511,12 +590,27 @@ int main(int argc, char **argv)
 		case '8':
 			display_role_trans(&policydb, out_fp);
 			break;
+		case 'a':
+			display_attributes(&policydb, out_fp);
+			break;
+		case 'b':
+			display_booleans(&policydb, out_fp);
+			break;
 		case 'c':
 			display_policycaps(&policydb, out_fp);
 			break;
+		case 'C':
+			display_classes(&policydb, out_fp);
+			break;
 		case 'p':
 			display_permissive(&policydb, out_fp);
 			break;
+		case 'r':
+			display_roles(&policydb, out_fp);
+			break;
+		case 't':
+			display_types(&policydb, out_fp);
+			break;
 		case 'u':
 		case 'U':
 			display_handle_unknown(&policydb, out_fp);
-- 
2.40.0

