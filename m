Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4F426D0A
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476157; cv=none; b=I/SqN/cMeOg/ZJIViMdSXrLzO8lCQHfZBwbrDQODPnfZ2PNqGxJbI3auTrawRoY+UrZNQJhMl7Pb62W87f/NnnM91pxCvgybmnXRiyNyu/iwC+ea9A7Gu5k7TLEKdHQpHHm9YNozgJzjgEezQO43eLkZhiLUySGE84jS8pMGvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476157; c=relaxed/simple;
	bh=qE5YiE/RL5CmVrzFnyyvVvMmmM1bpa7BEgVPW/F2Dfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sw9OXfuobkYLWaS0H0scZD0NBNqEh5MBCDvFnRQBt8wpdtcxnZEFJpc6U6bNssn/yXOYZRZOFXshAfJa8GubZfCrGdEi1H9eWFLWBfSFPsBeCjExpUqHEgztWPWGtI5W5sxhUzNHVVgkq0bg5OAt7jxmk8Ysr648o2sIdKuWGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgCq1kvB; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgCq1kvB"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efb708b1a0so319606d6.3
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786476155; x=1787080955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UXjRL1jvs/pNWW7H9nIlM1JnuKkP/qHkk8AKvoB6dXA=;
        b=UgCq1kvBp0ciKZiL5s4gALyRTOQ5Cm6JmPv52D1zwGO7UklUVk7hvlx8QqEjAzhom0
         yueVRr+/k+JOVFTJSxkpmQbx1rw9aacIQOmg4N3G4bOIXAEvqnY+dBkUBSCSpHKtl7mV
         RCejalMWx8qdi0MndBVh4nCLgdH9y3pZDLrVDpoDAeo9FJ8Lo4jE2nXAWtiNTEVMMWP2
         Jwp515/bhyWI5aWVyVdX6Gv1pKmJz1TDtMZB1AFgXbcXDXlhMn/HAPSrsL6S4PCpKpJz
         mcEtkOfs9zdHmdCeJnHjaN3hzrKoRaI2ziBgcS4TLPixM6/zpwWeIMjICJrx4+vcGg0V
         5dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786476155; x=1787080955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UXjRL1jvs/pNWW7H9nIlM1JnuKkP/qHkk8AKvoB6dXA=;
        b=og7OsPP5AkhUQrlDx7GR6ipDwi1d03j1JXraHO7bq0/IggIfKB5kkP+YXLlFjJOAns
         RF0fiV9CU9gdkJhIO+RFpd6vKvWoAnF+wbbtSqbUsIW/qR/NGjbPpRZfwGRT0Qz7DBak
         vZxjvVuay5+EnV63PgdNN6975JZkx1451KJBZI/8W4cQyaUiv+c5jzyoKFxRlRnUJi+m
         gudKpkjf/WCIaVWtb6seaVc8LwzDzdBoWgtLo7r6xszuiYOB47WK5ru0aYAst0yQSB+J
         nRXLdBsDaw0ekFWH8992U5RmMThjzZY+QrFdUbaKMTq6QFVAxc+MwQczsvpua95QFJOx
         4imA==
X-Gm-Message-State: AOJu0YwkarawXiXeifVoAuGFWlfzGFNaUjYWayby/B6BPjkxXua8fx3I
	EYTiz3P16LtFfE3SjunM+TUojy+xm/iY73RwWif8FC3/FsZaux8/Og0Je9/emg==
X-Gm-Gg: AR+sD13wH81xrU7yH3U1POY8FRKNLQ7xaRvrxdTwQPoOS2SwToUzLmRbsh9q+VztrvE
	G8x8F0R+jYHR8nLz+Q7nyA5JfJa1cizpYphtWdgzHz7PyLMn5WTSHad9cTtK3xDMbEQli5EYL22
	QCASysmdhpDejW5zsXsz8ds3gxUSna9+/7GXls1tcgMuXVi1YjyMf27QY+zCKc92HugISek1Kl+
	vvcTPES5ZdZk/uD3nUwuHC0gqDxBYQ60R/7/c3mWhDON75g9ENOl3hoXN99NlHpwy/ecuf7mw7D
	ZHTNcAH5ngvX1PMieLrX1zKM9iPkKN6hOQZRjcSOts8wHlJ6T67DxruQGnlxz6s8CHguqOXdCqu
	BFv+0OP4nJKMuKdguitXDZiyiRszwrbW0t/TezqufkYi5aiwkovLzQSbAOU9WLl0MqozwTfsmBU
	WftsPF2KRTkL2zX8pG2U0k1dCOUaiQvIBsMTy4Ur8uH2dVKQFTh8jrMV1/IFbG9cV/+ejFPDIMr
	N0W8ctAiME=
X-Received: by 2002:a05:6214:3f84:b0:907:840e:bf11 with SMTP id 6a1803df08f44-90a6c16ea7dmr27103886d6.10.1786476155151;
        Tue, 11 Aug 2026 12:22:35 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3994efsm5702196d6.32.2026.08.11.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:22:34 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2 v2] libsepol: Improve the validation of type aliases
Date: Tue, 11 Aug 2026 15:22:16 -0400
Message-ID: <20260811192216.140092-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811192216.140092-1-jwcart2@gmail.com>
References: <20260811192216.140092-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A maliciously crafted binary policy could have a type alias that
refers to an attribute or that ultimately refers back to itself
in a loop.

Validate that type aliases ultimately refer to a primary type
and not to an attribute or themselves.

Signed-off-by: James Carter <jwcart2@gmail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2: Remove MAX_ALIAS_REPEATS (now in private.h) and add private.h

 libsepol/src/policydb_validate.c | 71 +++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5687c82b..09d90a41 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -7,6 +7,7 @@
 #include <sepol/policydb/services.h>
 
 #include "debug.h"
+#include "private.h"
 #include "kernel_to_common.h"
 #include "policydb_validate.h"
 
@@ -660,19 +661,23 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 {
 	if (validate_value(type->s.value, &flavors[SYM_TYPES]))
 		goto bad;
-	if (type->primary && validate_value(type->primary, &flavors[SYM_TYPES]))
+
+	switch (type->flags) {
+	case 0:
+	case TYPE_FLAGS_NEVERAUDIT:
+	case TYPE_FLAGS_PERMISSIVE:
+	case TYPE_FLAGS_NEVERAUDIT | TYPE_FLAGS_PERMISSIVE:
+	case TYPE_FLAGS_EXPAND_ATTR_TRUE:
+	case TYPE_FLAGS_EXPAND_ATTR_FALSE:
+	case TYPE_FLAGS_EXPAND_ATTR:
+		break;
+	default:
 		goto bad;
+	}
 
-	switch (type->flavor) {
-	case TYPE_TYPE:
-	case TYPE_ALIAS:
-		if (!ebitmap_is_empty(&type->types))
-			goto bad;
-		if (type->bounds &&
-		    validate_simpletype(type->bounds, p, flavors))
+	if (type->flavor == TYPE_ATTRIB) {
+		if (type->primary != 1)
 			goto bad;
-		break;
-	case TYPE_ATTRIB:
 		if (p->policy_type == POLICY_KERN) {
 			if (!ebitmap_is_empty(&type->types))
 				goto bad;
@@ -683,21 +688,37 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 		}
 		if (type->bounds)
 			goto bad;
-		break;
-	default:
-		goto bad;
-	}
-
-	switch (type->flags) {
-	case 0:
-	case TYPE_FLAGS_NEVERAUDIT:
-	case TYPE_FLAGS_PERMISSIVE:
-	case TYPE_FLAGS_NEVERAUDIT | TYPE_FLAGS_PERMISSIVE:
-	case TYPE_FLAGS_EXPAND_ATTR_TRUE:
-	case TYPE_FLAGS_EXPAND_ATTR_FALSE:
-	case TYPE_FLAGS_EXPAND_ATTR:
-		break;
-	default:
+	} else if ((type->flavor == TYPE_TYPE) ||
+		   (type->flavor == TYPE_ALIAS)) {
+		if (!ebitmap_is_empty(&type->types))
+			goto bad;
+		if (type->bounds &&
+		    validate_simpletype(type->bounds, p, flavors))
+			goto bad;
+		if ((type->flavor == TYPE_TYPE) && type->primary) {
+			if (type->primary > 1)
+				goto bad;
+		} else {
+			const type_datum_t *t = type;
+			uint32_t v;
+			int repeats = 0;
+			while ((t->flavor == TYPE_ALIAS) || (t->primary == 0)) {
+				if (repeats >= MAX_ALIAS_REPEATS)
+					break;
+				v = (t->primary) ? t->primary : t->s.value;
+				if (validate_value(v, &flavors[SYM_TYPES]))
+					break;
+				t = p->type_val_to_struct[v - 1];
+				if (t == type)
+					break;
+				repeats++;
+			}
+			if ((t->flavor != TYPE_TYPE) || (t->primary != 1)) {
+				ERR(handle, "Alias validation failed");
+				goto bad;
+			}
+		}
+	} else {
 		goto bad;
 	}
 
-- 
2.55.0

