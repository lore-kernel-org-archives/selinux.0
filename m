Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982263D0C18
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937103; cv=none; b=eXhPbCmQZxpCb6nP3KZAEed3f4jpx5HkOAUJgvUnFPjAPmlk98Lghk9mN8nmHiTO/yC8qbgQ3w8mJqbnCL1zvBipTTmvIDdoM1fzQA04/JBgQ4QABT9huHz/1fCKaqos41b2xrKXoKG9gub4i74Ng0tieZL8jaFzfRNVY/wvAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937103; c=relaxed/simple;
	bh=v0sZdtHZ19fsifJzoYHmKp8btpOuIZWB/a27qMyvk8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saiENM1gRx0RhSvTx6C0XowmwZskABpxigi6RvXbJf+6Kb/ZPmtwPhWfkRIgn7OofikVU/1mslIuSgrNVI6GyfcK5mpeEcWppIEVkFHkJEQPUu0zQhFse/5a6SYG5CcCZZ5B+9eOQzTtH+GzBHE1mt1ODblVeLokcKQZ8wXFgNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzA5cuy7; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzA5cuy7"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ce3876a50cso46721016d6.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780937099; x=1781541899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=29/xcBPfWmPm8dVn72D8sLofl0MXoogjzdlQGXRHUKs=;
        b=BzA5cuy7oGd4y2Db6Ew663Ix2j9sDwCbk8h29rA6EEdmAOk+JKQXepr3wnpr8Q34Mh
         kC0/MhVeZ6523khaGeU7BxcGTCCKO+C60hFF/p+sLsCszSymOfCpc1kIvf3D4q5dkYoZ
         g4h3t1XE0v5NimLQg/bSLYP6vm9pDQlPU5Qfa2SXyyc0kXLPqMZQh+fmndeWc0stkvPB
         jiBpptcUqjqi7VLICBXxfhfJno9945v5h0JBAU8C9ARJJVRbro83qPFNhvR2+HB9Y7UL
         LBMP91IXIeKeL5Hy4hwJ8wp63gn+W3i9+ATPk9s2gFPRtDJnmfLkbMYvdnHMmKQJzr7z
         I40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937099; x=1781541899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29/xcBPfWmPm8dVn72D8sLofl0MXoogjzdlQGXRHUKs=;
        b=MTck/jjsgweSd9GGFUpE/R0TnffOkYTFOonCVwzEwOXx0/76YJWdmGSQUMyws86jDD
         RQX0pcNxu5yeJSRDvXrrjuL1qS7ktPjHdfz3jLqNLUkhgHBew+doBBmxbL0Iz7xEXXFA
         oKgWADL1ecPXx2UICAFozeE/+aIPtEzUdKUlXXRQ2UpC0U/mIxpt5Gy6Iem1XN6cAoya
         B/adolKs7h4Mqmdqmw2S2ixjen5ueX/tWpSVOZrKcudxJTPeexqx6O1AIU7GF2fx6aGK
         vsJBdddLYu/WX0VIQ/C5+PuylS5UtjheJT2M0XBG5nPCAsQABLGTAW3GQ+UqVbKxm0IT
         0YSg==
X-Gm-Message-State: AOJu0Yxt+K4AjOYbv5KoTHGibexGpkDl+9iqbTJBfR/RQmuEnob1w6rD
	LgzKnp96TRW8VYzJc1sw+0FEloTOPfjXkos9SdcECxWkEp1EyffrdplerCXTGw==
X-Gm-Gg: Acq92OEuiBJcDg+XfLqVEe0SJnl7cyUp4PXdVJgy10VZtWAIjHZ5CKLGO6CT1TKBfBP
	1VprgJxOMlvJ5V6WUtT+HOZO+aTHbeKELLvvlHRL/mtsrU9Rw2LJnKkvPl4e5Y4dabXDHJb8pso
	JktSwVh5RgyAVoeERgdyUgpC0AAZ+GQH2MDFBWaDsnZd3PJg0Pf//YgRA7Uk6Bz1GEWmS8RsF8X
	wDfl2l230ZdfNBtoBovg3LDs922v7g82Pn/cOTl2J5Woy7ZKsB5syrPWRfNsbfa5GMCIpifxxRD
	GNvoEl4rjNilY74DXFXyOCuU2nGHhIfQpTF6hwohnffPpGN0bEr1cmO0gcZ34Nkna9txpsGfS+k
	IjLaIzBx1r+TJowRcrOHGTVoQn8btGPTzDFRyu5xjIEVnid3M7bXJwPP6kAr6jFQ36Ye0X0S375
	8RchXygsX1XPg9XGYmAjpm7gtyOj1ug20wkERfWqReAvbFzCuNQEIlafvFptat2OHiIyTIHmVPW
	Iy+sNqS4EIONZpi5ZovzGq3xHNhlsqjfBivNA==
X-Received: by 2002:a0c:bf0b:0:b0:8cc:ed49:bdd8 with SMTP id 6a1803df08f44-8cee5fb771dmr202172276d6.5.1780937099298;
        Mon, 08 Jun 2026 09:44:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm172671816d6.45.2026.06.08.09.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:44:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: label_backends_android: fix non-anti-symmetric cmp function
Date: Mon,  8 Jun 2026 12:44:44 -0400
Message-ID: <20260608164444.313701-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qsort(3) requires its comparison function to be anti-symmetric.  The
current cmp() function used by the Android label backends is not
anti-symmetric in the case of a key starting with "*".  Fix it.

Arguably we should be checking for an exact match for "*" both in
cmp() and in property_lookup() but this might break compatibility.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_backends_android.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index 4f12d0d7..f1a3050a 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -4,6 +4,7 @@
  */
 
 #include <stdarg.h>
+#include <stdbool.h>
 #include <string.h>
 #include <ctype.h>
 #include <errno.h>
@@ -32,11 +33,11 @@ struct saved_data {
 static int cmp(const void *A, const void *B)
 {
 	const struct spec *sp1 = A, *sp2 = B;
+	bool wild1 = (sp1->property_key[0] == '*');
+	bool wild2 = (sp2->property_key[0] == '*');
 
-	if (strncmp(sp1->property_key, "*", 1) == 0)
-		return 1;
-	if (strncmp(sp2->property_key, "*", 1) == 0)
-		return -1;
+	if (wild1 != wild2)
+		return wild1 - wild2;
 
 	size_t L1 = strlen(sp1->property_key);
 	size_t L2 = strlen(sp2->property_key);
-- 
2.54.0

