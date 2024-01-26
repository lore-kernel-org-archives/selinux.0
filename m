Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2412B9B
	for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265864; cv=none; b=hiTm5w+nBBx6H72ZxIHWXLdRXYiHPriF8xGGL8DbXQhLDFy8LhKSyuZR+EnwK4RSvLKgsDx6ISiwNUsZepYyx5D04yjvx9yLecZQAJpO1RjehqPX4+sdT0luE23IiyCLfAXcdEcD/t93PwfSxi5Q9z0ernSLsx+eRzubLgImWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265864; c=relaxed/simple;
	bh=KDwKvxjFBtCGcBHvMr/jFLU0CTemadUlZgy031SYquI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3ykt2N/ctc8jOuWlkOeX6pvAgt7ivum+tSlSprWsGMQTLIVTE/UhsUBO2BiU/mO2CHlqLB8RnayT3ulGhL76h6tqQSTQEHWodh5J+mpRPYHALLxY1Ng7ZfnX8jI/q1YGHOr9PTzpzQ16IJgU+i8cHrLeRO+/PTKCI0PBhZPHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDa/Niud; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDa/Niud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706265855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fEWqYXcFpyH0h2J3JzWjNyw0EkIiJEepfjoSL7blk4o=;
	b=VDa/NiudPX2J/KcbP8a1tvZ6Mq62L1qp0DDCqyTk+4BG0qxNObrgjufvyFs0fWqfF+4a5H
	8jE2HRVezmMSV30OVXLVkR2kTew6zfgKFwgkJz+nrS7vbQZOGKaId8s5Ss4FG4M/s2QLi9
	E32q/NuO70QOby5C9YTamIWUsXOpFWs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-dC84CTaiOEyNyRb3Dhkhbw-1; Fri, 26 Jan 2024 05:44:10 -0500
X-MC-Unique: dC84CTaiOEyNyRb3Dhkhbw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5101ebb72c8so196886e87.2
        for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 02:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706265848; x=1706870648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEWqYXcFpyH0h2J3JzWjNyw0EkIiJEepfjoSL7blk4o=;
        b=iebZTyrCgyF8GGXREB+utgrXVgXcTdYzY/ibAmJVT+QLPXUp6GI0xKmGmzyb8GDnuR
         SjTK2Acjc74fqY97a9c1iDSd6KeesKgX9iQPIS8qlAHuZX3LQd2YgecDwXe+05akOzGF
         QMANjl5a0ZdXw062kNGnwNM50jA8PU9CuWte7GcXG55CkxKpMPJMOJc0L4q1cXx25OcL
         dt6+uYu3s6L4v20cuqG68x6WfhOWb0QXPWVdE5xWVga9DphRp6i+RHwCfmX7Xg1x9aci
         jyiSeX5WtLLcN4WagFZYAI31MqgIXO0MdQSTV/SLF9owi3gZJ2OwdcOI0MYjbIV/vGL7
         jxwA==
X-Gm-Message-State: AOJu0YwexFzV/ELEDUQpKXl5hD7PFmGxqqbpSKieJlnt/75Vq5en3H+f
	GqHe4lW2C0N0MjYD7iBc5QLn4yOwZyhx5V108uRyudrQEDyotW7PJMOqj/xTubjkRbFtb3o7nay
	0ssOCagfDmpxeIfkMEtZ8aJTNv2G153tnQDhtq1rf1hoNwSGP0rtJvq1dsdX3ltM=
X-Received: by 2002:ac2:4564:0:b0:510:1023:784d with SMTP id k4-20020ac24564000000b005101023784dmr574331lfm.81.1706265847911;
        Fri, 26 Jan 2024 02:44:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLz0ct9zFeeITjNYcc+4b79PuevNDGcLbg6XkBVWisv//4gW2d8624fgOAcbVF9MSADDq+dA==
X-Received: by 2002:ac2:4564:0:b0:510:1023:784d with SMTP id k4-20020ac24564000000b005101023784dmr574307lfm.81.1706265846018;
        Fri, 26 Jan 2024 02:44:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id d19-20020ac24c93000000b0051025dcd3e0sm139616lfl.69.2024.01.26.02.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 02:44:05 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] security: fix the logic in security_inode_getsecctx()
Date: Fri, 26 Jan 2024 11:44:03 +0100
Message-ID: <20240126104403.1040692-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inode_getsecctx LSM hook has previously been corrected to have
-EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
behavior. However, the call_int_hook()-generated loop in
security_inode_getsecctx() was left treating 0 as the neutral value, so
after an LSM returns 0, the loop continues to try other LSMs, and if one
of them returns a non-zero value, the function immediately returns with
said value. So in a situation where SELinux and the BPF LSMs registered
this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
returned 0.

Fix this by open-coding the call_int_hook() loop and making it use the
correct LSM_RET_DEFAULT() value as the neutral one, similar to what
other hooks do.

Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com/
Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecctx")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

I ran 'tools/nfs.sh' on the patch and even though it fixes the most
serious issue that Stephen reported, some of the tests are still
failing under NFS (but I will presume that these are pre-existing issues
not caused by the patch).

I can also see an opportunity to clean up the hook implementations in
security/security.c - I plan to have a go at it and send it as a
separate patch later.

 security/security.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 0144a98d3712..6196ccaba433 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4255,7 +4255,19 @@ EXPORT_SYMBOL(security_inode_setsecctx);
  */
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		rc = hp->hook.inode_getsecctx(inode, ctx, ctxlen);
+		if (rc != LSM_RET_DEFAULT(inode_getsecctx))
+			return rc;
+	}
+
+	return LSM_RET_DEFAULT(inode_getsecctx);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
-- 
2.43.0

