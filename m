Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA13AE704
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787826; cv=none; b=rL8tayVRg66Fd+Q5SjV42z0Eh2yIMZzTwIXIy+f7lPZ1FMqKag9UARXRht6oQVT8Wqf5TpaoJsBDRosLuZnWfZZWStatDJkkKAd+jR+EIdHNGG9p9s3x81KCghb+idqHqA2u4jKmaIqGqOeZWA5BR1CRNHXx1+jAL/iwA2TWcns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787826; c=relaxed/simple;
	bh=N/cg4aryy1YKRG967FneYNr61fD9VcTmMYXjQXh9Z4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k49LS+WLQxTokE3K5Woi8r4a9Kp33ReZ/M8C3yGN4wcntVJ6a80v2jACBDRMfrW5ssE3ckjAhwak9/fp0sQCMrtlreGLVaSSuZfqDdxIXGF1frE9ur5uKPTAS+ezXLbeTP4MQmR5vNHbMeMzbNosNYW4QAxXTbRFkp0Aan1uOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B14JfDDa; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B14JfDDa"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c0cea8883so2497501cf.1
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785787824; x=1786392624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p18jJUn2jBzTyE81wFeeE9bYQh0ijlFQJl3k0jIZXPU=;
        b=B14JfDDa1RGXPx8dz1HFc6t5p9v57ndxlR4v0BdtO8Oy5PgWaTNTbGlAqrJutXQ5hF
         TekelCb1k0Q0IW2L9dUf3aGwZY4sKpZUC+JSR5qpe9fYqZppwHkEvTcOpxGJZsXwB+8d
         4loS2h4JGtp1cB6683x+fc4HQG6Zbhu4issyGPFNC8x8q5lzMhW4lt4uqo+8gag0BSTj
         fyHClnZD3k4FUtclMbGXISny+d08mPHAvfvy8feqDUkcmofwmOSsWggHLIOESou6Iuyg
         dLZmD4rrD6BcdNtmNrEOLG0Qq49oGq/cXTRQ7mvcCa8om25HhSLa7g7pfvJzjBa5eTJ5
         Qqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785787824; x=1786392624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p18jJUn2jBzTyE81wFeeE9bYQh0ijlFQJl3k0jIZXPU=;
        b=ok7xKxX3p/L5VTydtftNJ5IDZhDDel9nXn0MRqNgHNSJWFRpn2qtcFTWYKJ7GEjvY1
         adnhv2OPlm2QVtCj3s9Gn+R1SXdKcPBUkPJI2Bhfj+WiDNHMJyJUtDOOIf9O74QpfMAc
         iBH/XNs6PhecyTsm/E+Z/jOJ4idpmLHYlcJWCTFl+NFFJEgkVmwLHNITW4fQ7RgSd93u
         4qrorcjCLXXRQFTEk41h8YXFaqPh/J+5pofn4SoKtTffW1xNN/l4qm4IFnDDeD7m7IyW
         rdVPzTQtHsGrr7zPvoU/CgXvLfittUUi30DXo2nB4ssSvjDpk3VcpTGNry89ESNG1Gee
         U37Q==
X-Gm-Message-State: AOJu0YxiNHO9ZJVqABSQzicURpE3DNudQlyBHDvWbiaE3k8FB4IBXbYM
	pQoUIg1EqMdFRRuv74B4+cg1eKeB7tc0TC3zJFLqnML0u8vT8npF+VyodIQ4Jw==
X-Gm-Gg: AR+sD10PiVhhbkvizI8yj/R0bR06dTDSIHVhf+zB4UCLOA7kAbTkIq2+U7Xmn2Woucy
	3m9i9vnfnn6nB86+IoRqc9SK0neunY+YRxVy/pLh6Fi8Cq3sQ1xXyRuWgG2aVVTbYhbZdzPuFWf
	ZIk0Q/F/dBY2HKqdOMg89dvf9w4S+uw4R3cErCL7jnBAGE+g4V4wpK7MTJtp2gmI60iuWPU1wst
	0EOrUX5LIJjSAnWKDT/d15vFgtUgLI+HX32GyRyC6OmH3N9UkIOvnuCIZr3KOLS0KnRcFTR5T92
	1B68zhMD8Bylo3oulP8vCQf0t9t+QACq4bboP1Iloc+yNo5ISF3DWZziJCPnPN1ifJIv+VgRFQk
	Fw2QXjp3FEDt160TamO4S/gQb75nxAuvdx4e+Jt8j/BRSOcByZSgmuabw0Fd6IBeYfAq1E5Gekq
	+oLpttPwOdsOjNx43iSkBbCU+5usdERzxQ72qE3mjh2WCkQhVN2G/uHA8PcFoFSxOIxVlT0LK+s
	eaSL8q2Fi3Q8PKvzOZrZx8ynb6YMARKQ6cJkpL2K2bay1/yZ7DvfRyDXG/J1hFt
X-Received: by 2002:a05:622a:5b94:b0:517:87a9:6a89 with SMTP id d75a77b69052e-52cd34c91f1mr16746551cf.6.1785787824101;
        Mon, 03 Aug 2026 13:10:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm68680641cf.0.2026.08.03.13.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 13:10:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libsepol: log an error if we hit the max depth for __evaluate_classperms_list()
Date: Mon,  3 Aug 2026 16:09:36 -0400
Message-ID: <20260803200935.49341-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a cil_log() statement so that we do not fail silently if we hit
the max depth. While we are here, introduce a #define for the max
depth and use it, and fix the comparison so that we fail immediately
when the depth has already reached the limit.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 adds the missing newline to cil_log(); was confused by the
fact that cil_tree_log() doesn't want one but cil_log() does.

 libsepol/cil/src/cil_post.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 183b0d49..b9d5696f 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -49,6 +49,8 @@
 #include "cil_symtab.h"
 #include "cil_deny.h"
 
+#define MAX_CLASSPERMS_DEPTH (32)
+
 #define GEN_REQUIRE_ATTR \
 	"cil_gen_require" /* Also in libsepol/src/module_to_cil.c */
 #define TYPEATTR_INFIX "_typeattr_" /* Also in libsepol/src/module_to_cil.c */
@@ -2296,8 +2298,11 @@ static int __evaluate_classperms_list(struct cil_list *classperms,
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr;
 
-	if (depth > 32)
+	if (depth >= MAX_CLASSPERMS_DEPTH) {
+		cil_log(CIL_ERR, "Exceeded max classperms depth (%u)\n",
+			MAX_CLASSPERMS_DEPTH);
 		return SEPOL_ERR;
+	}
 
 	cil_list_for_each(curr, classperms) {
 		if (curr->flavor == CIL_CLASSPERMS) {
-- 
2.55.0

