Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A5202963
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 04:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749788866; cv=none; b=bV84rl2Uy4keaViANw6O5S5N41NhbvQJ8OfUf1TypHlHkv0AraurwCrIAaxV50dCdcoHWmrvsFOXQH/gYdcSXNldH1Hu80QNetmeCMTXjuTbla4oLT6iFFxgyDqlHenhhPUcfLrcvfBT6AQEmVoytxeAnD1P85ItdtHN1pbZZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749788866; c=relaxed/simple;
	bh=QZKLTSEhbXEnN69CvFw6npH625+RqFjPJOl7BYFr8Dc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HD99D7QLUE4QM5gGGHOXGE6zO5jjsa2PtZuL6AKcLF72xpO1WEMy5EhDGcrhAJMPrXdOtKDjVXsGWx9GG7JKsKw+AdPPK5O9eZUq5Iinmliz+uz26jC06gaEGHXYAxGDxRQmGVaVtQAH/VlJMh9hDfxekT/OG9P+4l/8dzdr0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZfkS/fi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZfkS/fi"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2f02cd1daeso1161864a12.3
        for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 21:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749788864; x=1750393664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L1MGHAlyxEn+6rVOGVTqMUaXcgeKN8yOE5psuvZUQJ0=;
        b=AZfkS/fisVXg4J8Hpp232TfgVfIT5Bm+iScdv+lT+W2umPoNlcrYhNSjAqcZoKhnCO
         2GsR4EBTpu7qUzA22FsxWo29Qrlpms9bOSDAwQ8eUTdQFFZDeahOcrmkWghK5d5+Vi0e
         qKXmXStkx08H8CDk3jujLWz2db3Savgm5rvGcutAYIaFix/M43PU3DRrJp8R42zJYlCr
         dPQNVxPEYbCKPMqIkwig02n1pda16NkbYT7jAnlcSrRljEeL5vNIjkxgULoDXZ9YpEPV
         TumhrRCfeKJ/39cG2ba3NnPuS1DBiowQg6uc98roAxtDqrolGv+vrnjuvzj+mE3qzn6z
         l7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749788864; x=1750393664;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L1MGHAlyxEn+6rVOGVTqMUaXcgeKN8yOE5psuvZUQJ0=;
        b=pAkvw+Orwv1N0LMFfgVIUyOHxcxoeIY08TmROEPU0+0/kYkUvnnL55tsmisk5Lt3EZ
         kfRJ7mdDRzArzLHqpb61yf6SjHMeg7EuqDcddbJyS6iZt5VAhgAGVRsCxxtHk6n5iQfn
         f8rKpBYcn4gdabrSo5tZtyfaZ260YsTib1bGpZllPF4xGfQ6A4QkfMyFdvYLuqHySvQq
         DV92ZJXnrN02XY68oEAaA9cM3xE+AOLi5eP8Xt1AjOh/UCb2BwtCIZFXMGPvK4S7To4z
         gDzI0PV4eKIBqih5bu/+HDljDv/HTBKxkeVZo5oHLh7bycrCT2Xzmsv17RibU8pqotKE
         x64A==
X-Gm-Message-State: AOJu0YxaoiG10DntN7io6xY99sJ2s4Dd8FhJGGHf8KY2zsLO3996Wt8/
	lqePR7xXRLqjwwDr0eU19EuA/GS8M9V45EBt4hyZ/3Y0fsGfYdN0U7CyxaUxmjZRcCYuHktz8sY
	tM0UZRjzoxRmuEndcANYS8NhgBv3K89LIkebXYqkxiu1JKtsD9tFGZ2PEVuKRA/8d0sB/i/EihW
	JX3zMvmzV9zPNOX1aSn5pidg9iUM3kKsbADXWEIg==
X-Google-Smtp-Source: AGHT+IFi/n7kjErBhlMTrMRfOKz2rJSAv1YqJb+I/lx//2J9mzkZXeGIGnPA+W0cvipFqI1ONL8hfyQX2LY=
X-Received: from pgcv13.prod.google.com ([2002:a05:6a02:530d:b0:b2f:64e5:602a])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:999f:b0:1f5:5a0b:4768
 with SMTP id adf61e73a8af0-21facc87930mr2173891637.21.1749788863734; Thu, 12
 Jun 2025 21:27:43 -0700 (PDT)
Date: Fri, 13 Jun 2025 04:27:36 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613042737.485384-1-inseob@google.com>
Subject: [PATCH v3 1/2] libsepol: Allow multiple policycap statements
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: takayas@google.com, tweek@google.com, stephen.smalley.work@gmail.com, 
	cgzones@googlemail.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

Same policycap statements don't conflict each other, so it's fine to
allow multiple policycap statements to exist.

Signed-off-by: Inseob Kim <inseob@google.com>

Change since v2:
- Remove the parent patch adding NETIF_WILDCARD
- Follow the pattern of SEPOL_EEXIST check and destroy
---
 libsepol/cil/src/cil_build_ast.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index b1f151e9..53f825ad 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -145,6 +145,9 @@ static int cil_allow_multiple_decls(struct cil_db *db, enum cil_flavor f_new, en
 	case CIL_OPTIONAL:
 		return CIL_TRUE;
 		break;
+	case CIL_POLICYCAP:
+		return CIL_TRUE;
+		break;
 	default:
 		break;
 	}
@@ -5559,8 +5562,14 @@ int cil_gen_policycap(struct cil_db *db, struct cil_tree_node *parse_current, st
 	key = parse_current->next->data;
 
 	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)polcap, (hashtab_key_t)key, CIL_SYM_POLICYCAPS, CIL_POLICYCAP);
-	if (rc != SEPOL_OK)
-		goto exit;
+	if (rc != SEPOL_OK) {
+		if (rc == SEPOL_EEXIST) {
+			cil_destroy_policycap(polcap);
+			polcap = NULL;
+		} else {
+			goto exit;
+		}
+	}
 
 	return SEPOL_OK;
 
-- 
2.50.0.rc2.692.g299adb8693-goog

