Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880FC47CC67
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240517; cv=none; b=XNy3XUq4XIh85Nuq5w82sjk/Oc675LsICqrbjPTvXurFAkJIwKquf0c7d51M7nLBOqIpZrdMNQcGUsfCo6MjTGlOvn5cF1qLtmagg8l611an4hwJrsRp6VtUlqVvPRz+Z5ER5mZ/HcStbnEy/mLoGHaHWrk6vzZc8CNfie/ug/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240517; c=relaxed/simple;
	bh=Pxf/DVfE/8IImMEND6JoDMHWuvG5o4oJGuY4jYna+90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tx9LizBX5kEIxqXJomActpXbdd7CQCDA6t0SZzeEVOpMoDPRdnbo++XveaLco4nzTFXwA78rjp8S3ZvJuv+LL5bKlNNq0GDTnx7pSO227OrtZulOazjd/6zP8Aogeu4+NzsghFkp7gWmt4NrZ3vyMZSW1IIVC+6RRwbYOh/0jz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPXQeAnB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPXQeAnB"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c04bf4711so20758941cf.2
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787240514; x=1787845314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQy+Qh1tNmh//T3zQRLZu8r0DvLhBozSMzm+aaLvHEg=;
        b=fPXQeAnBXCS1XB5kUpo4dFENirrTQb3iSIPJ0DqWQvXP7HCOCLZ+APZ8zsKOnjVBjN
         jqxEZG/tSbMqh8GKUlmw0LQmnhqMgVADo924u8FmfjOqX2rJK+gRL2F4zvl4b64sflnd
         Ms55qhmMTw9IZoGjG2SYqwcpbc2Pc+um6X8HCe2jl/Y9tSEoVlfdSpBfKvWnuzaLXaCv
         GpdkzSLtpDduPc9SlPQ84oZ7sHlDDybmhulfJfWfN/7t5W4BArUAALCePdM5ocje+Li0
         ikc64/Zck0AJfamnCd/NM6Ww4YAnc69T/wus6JMEtMKCq41BKsw68ZjeByaoNN4A6/7E
         45Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240514; x=1787845314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQy+Qh1tNmh//T3zQRLZu8r0DvLhBozSMzm+aaLvHEg=;
        b=gCS749Y08394F4qRX1aE/i4Ir0zezjEXwu8w2XyYArLbodJY+IMzrw3uspoFt4vdqv
         L1QxcUWGF4BmwowKMd9T4PHXGNNyukxKNT92yDlNPJqRZxYQq+08ryjmXU1pveGRFChE
         EEUX7eDgebxuP7ZrDswBDU19c1izksZVIfwGJTK4aEbXh4UneSy/0TjopQbST2EviXrh
         hcoGjkKUnduPdqmB652VE519EgAn4EvhqxH68wZu0xQOrQNyhqZ9zGaXS1r5Wozl33J2
         XP+tpltbEjxHW//fELXK0qFggPwPrHsrMka5V7C+BR6Ym/98vE/euBjG8jwby9AHTm4Q
         3/NQ==
X-Gm-Message-State: AOJu0YwbuJAEKk8HXgU19t9xtyNeQ5iuWGnbHX3BJ/5OS2INqboXzOtI
	eIozyJEFa4RacuSi4qOwqezhvQenPgf70FC/dmUiSSTlDnSgGc7Q70QAPZN6Sg==
X-Gm-Gg: AR+sD11aBhQdPbbXQ7yRpXMV60UDHRfmgclcg3ilrm4wcAWXFQsx3dFr3sM9BUTIvFX
	D21TIHOeIRXt1sMCSe76zLPUqq0XtmS8sR3dBJ3Mm4fBM4cnLIE/yVKu+FJvAaCf92obFdm45KT
	bONDpPNbA7rrsVLnuPQ+L7bKUOYlUoB/iGMn3qDMOUcbZ1kexgwJQP3BoxUvS1rq1N/ORYWnVIQ
	PeiwfSZCvW/NfBjT5volzO2jrXWqib/Nkai3zTFHz5IgsDL6ckpa/KDVnrhjs0FrlnvSnoViH5A
	DWL42eJ5qCFkMXqRtjg7nbJR5oQ8wMPjT0A6PUF+Tgn6P1jcd7hGePw/u+HSXSLvYKV3lhFVAsj
	PFbuF8v7VM/jo4WPau+kRra0Z02BOZpJ5neA9vXFEOqMlTa/5P81o6PmHktZkhKH7YhxMa5HQHC
	BD3gJ70eK8yOqr/OqhYkJsMtM8VQBRZ1V9JIvnvWmx1EIM7jheqDBiJduc7Ve0R8bBve7ZULVYE
	P6/M9XtvMY=
X-Received: by 2002:ac8:5850:0:b0:51b:e92f:ec5 with SMTP id d75a77b69052e-52dd575f33emr124197941cf.3.1787240514142;
        Thu, 20 Aug 2026 08:41:54 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd857b6b1sm33046471cf.3.2026.08.20.08.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:41:53 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Remove assertion and comment from discard_tunables()
Date: Thu, 20 Aug 2026 11:41:43 -0400
Message-ID: <20260820154143.12706-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820154143.12706-1-jwcart2@gmail.com>
References: <20260820154143.12706-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Policy validation ensures that there is never a mixture of tunables
and booleans in one expression, this means that the assertion in
discard_tunables() is not needed.

Remove the assertion and the comment (which is incorrect) above
the assertion. Since the variable "tunables" was only used in the
assertion, remove it as well.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 18718973..f7ff61cd 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -3194,7 +3194,7 @@ static void discard_tunables(sepol_handle_t *sh, policydb_t *pol)
 
 		for (cur_node = decl->cond_list; cur_node != NULL;
 		     cur_node = cur_node->next) {
-			int booleans = 0, tunables = 0;
+			int booleans = 0;
 			cond_bool_datum_t *booldatum;
 
 			for (cur_expr = cur_node->expr; cur_expr != NULL;
@@ -3205,7 +3205,6 @@ static void discard_tunables(sepol_handle_t *sh, policydb_t *pol)
 						    [cur_expr->boolean - 1];
 				if (booldatum->flags &
 				    COND_BOOL_FLAGS_TUNABLE) {
-					tunables++;
 					if (preserve_tunables)
 						booldatum->flags &=
 							~COND_BOOL_FLAGS_TUNABLE;
@@ -3214,13 +3213,6 @@ static void discard_tunables(sepol_handle_t *sh, policydb_t *pol)
 				}
 			}
 
-			/* bool_copy_callback() at link phase has ensured
-			 * that no mixture of tunables and booleans in one
-			 * expression. However, this would be broken by the
-			 * request to preserve tunables */
-			if (!preserve_tunables)
-				assert(!(booleans && tunables));
-
 			if (booleans || preserve_tunables) {
 				cur_node->flags &= ~COND_NODE_FLAGS_TUNABLE;
 			} else {
-- 
2.55.0

