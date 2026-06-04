Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8935DA75
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593570; cv=none; b=MjifZC+R/32xW/bwnWPt50E2CnLREIGmokttVJ2307Qjg/8s3dKyTnM6pOYUpBdSuQgBATkbS8NblJea1clnXqNuu4/04G+V3e+Nez+0ZEd4gedaM3d5gka5cFL9jnNTdSz9f5o+9ZevVoW63x+m8oBuofYrfg066sv9wIWd1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593570; c=relaxed/simple;
	bh=8WZqhHc72V+BlWTqgTLgL2GH3c39upU8/LU9G3+e7ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fL0SUaAFQx1bCEbmLXDp4i+RDP5GAksaAwGEdJHCXz91eK1+o0kvGUSO3TB80THxMgInSHbixTKBHsIDXr/nBD5y94RYwpRoPPw61YdgAE0mA8VB0FIeSbYsuoBh1vhfO/4uvoX8xZ6+7C9bqaLDE8dZOxtH7/reHcdavhANbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGLr9RDn; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGLr9RDn"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-516d0db9372so7476921cf.2
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593568; x=1781198368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyk0OmR00kT+RftFACgpMg6UrXK6dN15KHMWZ0gUVAc=;
        b=VGLr9RDn4JnjB+F9UjSo6R05el7pxBvcSZCKFU7U637FsZd2mEi7o4W4HMrA77F2iJ
         wjNrJKUiyk4DgGfeSGc/0m+V5Q7R/V3zbQIi6qjoqkxjJ2+MIeftxUAs+FlAxtPrXMLl
         ky82LAn5s0vESGJyywDQo8URExqFIyrM3Lk5gGUwri0+LlBuUdQZjHC+gJ3ZjpHUqWMp
         uqSrZWmmAX8ZBNraIFAdYm6uIrVv6vrRgnWxN2HakUMmbCE7JQR7UNFAJrrXhl4WEAWb
         kSKzRZzIE7Y5Lz86XDwMzsJbo+cJqxMwdFta+K2/oYYkVkTeNjFcgPxgNUuWOHXjTo2G
         nxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593568; x=1781198368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyk0OmR00kT+RftFACgpMg6UrXK6dN15KHMWZ0gUVAc=;
        b=mwveZYXM0kId70d2o9fwG22vyYTLCDvv3e3dNHGZU7KUVbe0Y9aNoG+hOPH9n0xqMp
         ctr2JJrTAolccjQhgo5nS+JqnwKU3Jpv5c1BAunKysk4jlieu1UuL5dfpXOnJlLEaGKx
         r5Fe5io7BcOxPe9FgLH8NGDfUr3F1iixz0kNS5TrfAmXpDVfohpEhpvgvPCPCbFW4mqe
         y2SiZteFll43yAu3+r10ZAM8SR5ibf9yG3jTjP5bHyrAzYWZvRO9JieEcLmq/+btUumG
         Gx1pizlOJ5spXuHuBcsdLSRAtvzo1ABWS7lHEKM8oE37gLRhOiUhnsPSfNNSBaniqcIQ
         +ThQ==
X-Gm-Message-State: AOJu0Yxs2VKnP6Uwcy/damDAM1HOCDAC2GToSQGkv8d2NBj1CaMHEdV3
	JsaKrQZE5KUqdhDmqbBJkEPYLGfmEAeBlXnS3FddzSSsyWVWvTRkLuMJUU6iXQ==
X-Gm-Gg: Acq92OFAzoTBQoFk2mryk4qz8l6r+sydqmlbe8ber0a184T1pv5OcOlNk7TSIiQO7M0
	fQfQgEb4UBPF1aZ/UU5ukjg+9nfrN8mYerAXouU/ni5jhAySp3noc1+PwdvieFkXkaHOa/Yzh15
	8Y7aly5sZO6D9U8N1tS4jsMmiWbpr8ctsD0SdP7M5+L/7SMgLAe2kprGxxx0pqKxrYgV3oj57kW
	axbWGBkLzjY0Gce0gSG/V5xLUhW9tIsbLM3hNLEY7uoxRBs9HNO/UkDBwur6Lu8kcIr+pQT4CW7
	xZYt2TjgjtVQq3ornqkxlPSLYaHAuk8rRpVwpHoWWeWJU0pm5jjOpBJGccrscvCaveFWkT7sFQM
	5STgfft+Fy/ZBptV9HgdIcBlk+kkGPzMeNBAvqH2xDy4b9Bzt0AC93scYGfVH+v7GSPL1IR65RN
	c3HTUaTDoOXpOwu7eqhxAGLIJ0/BJcyFtHKqdIYeMVDg2OIPvUo1a3Diijk7D9BNYiJzrPgrqIB
	AGSHcS/wsUYtuyIYEZe0lgw8JxQNBUcrh3UZQ==
X-Received: by 2002:a05:622a:17c7:b0:510:1325:58b9 with SMTP id d75a77b69052e-5177871fe36mr122486231cf.41.1780593567917;
        Thu, 04 Jun 2026 10:19:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c08234sm56902601cf.6.2026.06.04.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:19:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: selabel_close: only call func_close if set
Date: Thu,  4 Jun 2026 13:19:12 -0400
Message-ID: <20260604171912.263475-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

func_close is assigned by the init handlers and may be NULL
on an error return from an init handler prior to setting it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index ad40440c..dcbd60ab 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -394,7 +394,8 @@ void selabel_close(struct selabel_handle *rec)
 {
 	if (rec->digest)
 		selabel_digest_fini(rec->digest);
-	rec->func_close(rec);
+	if (rec->func_close)
+		rec->func_close(rec);
 	free(rec->spec_file);
 	free(rec);
 }
-- 
2.54.0

