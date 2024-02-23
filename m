Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A341448F3
	for <selinux@vger.kernel.org>; Fri, 23 Feb 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723613; cv=none; b=fOthIdlBahbBYPytRZ1s622JPsTmdG+REIvegxKvNflh0+4w3v9tU4fIWinCKoZ4zYyT40QZyElGHo49SHwwlaH+7Xfv8LEVOPD8WdrF28eo2P4KyH69wuhqN3eOY1k0hiKDGcb9slS9giGqBsMWiAWS3pLaFEcC7T2YUwJvqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723613; c=relaxed/simple;
	bh=lyizb5ZyX13qKB7u9619mSQCHd6r4E8qYGIQRneFufE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VFuVt695nuGT+46OYa/+pgnk2W5j/tcp9opqsAONCcUqto1dax83XQWoUx8IK9cDubZu0AlMnJdLPato3dZ3qsR3ArW1158tWIgpFJcGvqTKs8XnPhCFDP7BdK/816VGm9q+9XK+fdnTZVEnpO/Na4+10JmFGBHOeKE2oLl50zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xj1Qt7nD; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xj1Qt7nD"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-787a843003eso79631785a.0
        for <selinux@vger.kernel.org>; Fri, 23 Feb 2024 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708723610; x=1709328410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y74s1yO/Ih0ePzv7Di1f6ypeFTeV8ZLPlXHemkSd4cU=;
        b=Xj1Qt7nDb1kw1lxzxVoQoCQpE7v+9epbIOMHmtiMUIx4Sus3+7eIQ66rhAjyFsPp7i
         r7605OHGJrtmPfqA7CZVPJbaG2fJig+8vrV9uU/lC8VV38lBXaarhDivoTm7ATKBnPXI
         69oW+srMbNVu6k2vV+2gutgbbwIgaG/2A4xQCIhIPrEoEFGHZRce6KLs8aGVsYbGC0L2
         KKfzDCbvkL86HkjoaWcxTt3XkEMVEj62zzi/IOXH06OlJ0Q6jF7C33KUmfV5rYhWZ8i1
         0pZpEbU8FuCIYVA11LkVB0s7dx2OL13BOr49n2wblYcSzBckwGU9/MhUVSPLUJlpvBhx
         cKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723610; x=1709328410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y74s1yO/Ih0ePzv7Di1f6ypeFTeV8ZLPlXHemkSd4cU=;
        b=hknfKSPOodLo+XiFq1Z7dflv8pjXm3vY2ImOLNWeOM5p5lBLJnlU2Gs6N/i1y8V9A2
         aWg65wK+JCvtSwfpbtlYf7zfFI/93bJp32R6qXUzP7iB0KxRmvTrZhI2D/rcNriB90jr
         xCE6BkaEchRgApDLQul+G2+iNUcCWvv1WU0fLcr4EH1zyvTl92Fy58VpjmasEYUs5N5h
         VwfqjYSj1s4j8jiNkStSbXJ/faijVoIfSK0GUQu7ZWHYb39jEnT50KPnxN3dblVJ766w
         mRROg57+h9nxqMk2gdmXejOM6ldQDx8zpa5fUpd+CUz+esSOHBLP1Wveo8krGn8MIzee
         rnNw==
X-Gm-Message-State: AOJu0Ywm0vZktUQWkMwsijYUgIbtSsSxANbb0Xy5o9kriF/qB9tCXl42
	axH/VbzenrXFkylgir0yI8goWKja4E4SeCHG4x9qxcPr3HlVN05Eu/5TjxDgjftaB5akT5hdJuI
	=
X-Google-Smtp-Source: AGHT+IFEfK7kIpwORdo/k06sKpCdQdbZlS1/ye1Z+ymrl0ng61a4y+oo8dBGuauLUKIVCT+ZNuYKEQ==
X-Received: by 2002:a05:620a:444f:b0:787:a7ef:7c1e with SMTP id w15-20020a05620a444f00b00787a7ef7c1emr1187767qkp.47.1708723610057;
        Fri, 23 Feb 2024 13:26:50 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id vq5-20020a05620a558500b00787289fa901sm6821054qkn.36.2024.02.23.13.26.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:26:49 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: cleanup selinux_lsm_getattr()
Date: Fri, 23 Feb 2024 16:26:40 -0500
Message-ID: <20240223212640.305789-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2397; i=paul@paul-moore.com; h=from:subject; bh=lyizb5ZyX13qKB7u9619mSQCHd6r4E8qYGIQRneFufE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl2Q2QRF03fCEr5nhQ/JFzgCp/QcDxGkBpbs0iW QZsK2qeqeyJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdkNkAAKCRDqIPLalzeJ c2fFD/9+KMDJaLUKhyYuZ4OQqbiQemcpJ6ETvloBZisfSZa/mbax9/vQ+5JJwSaEGRTpx7Yonj5 TxiGI2yXQosNTNIfZezhQAiD3gMD+I56XlAwZNtsejLQ2OqNtEoHh1aem1p0cJimdrg6wvJC4uT 5e7+dmuDdOaq4+AW2U+2rq1keeUyt4wVzojLyjBrOrvqcS+m5z3EKVq1tJgbySKj0biIWL35VU7 pv8Ex4CvQD5wFR070Dq+MKWbVqSvgbwlc43lOAIC35O5Gqzm3qYR4hRjbusZ9cmdXB7hGaE4AHM DKD27s2/aZQAdJASA4Od5C5PBcB7w7pVccbsOPNAe+BI9faCkCw8Oq23UMQe8UbXFiQN/lyAjOB qjyn/W/z1rNqdPjpeM119QtnxaKhS58ttI70N4ipP40GREDMN1c8dEWfsOmGX9hvDCwAsXInxkK IPEHio1rhFdEH8JW9ollmEGIVZ0IJ+5FysUX/qjCmFBks32yFa/B/gg8BWmi+qMN5QodIr0ETAP MtE9TwUn13776K9e7Fzb1rs3Irx0SuTfJg4fRy4MfDYvvz3sVp5H2JhBbB5BRV14eHZUN38yq8S mcCYB3bC1IgCwPldQdjPuZ0PMrxi5h4gpDX9V0jClwbvdELd3TTaQb4eRmOP4roKzWdRNBK8WZT SQ5swpTVODsmBEw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

A number of small changes to selinux_lsm_getattr() to improve the
quality and readability of the code:

* Explicitly set the `value` parameter to NULL in the case where an
  attribute has not been set.
* Rename the `__tsec` variable to `tsec` to better fit the SELinux code.
* Rename `bad` to `err_unlock` to better indicate the jump target drops
  the RCU lock.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a0fde0641f77..011b2ab08995 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6347,55 +6347,55 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 			       char **value)
 {
-	const struct task_security_struct *__tsec;
-	u32 sid;
+	const struct task_security_struct *tsec;
 	int error;
-	unsigned len;
+	u32 sid;
+	u32 len;
 
 	rcu_read_lock();
-	__tsec = selinux_cred(__task_cred(p));
-
-	if (current != p) {
-		error = avc_has_perm(current_sid(), __tsec->sid,
+	tsec = selinux_cred(__task_cred(p));
+	if (p != current) {
+		error = avc_has_perm(current_sid(), tsec->sid,
 				     SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
 		if (error)
-			goto bad;
+			goto err_unlock;
 	}
-
 	switch (attr) {
 	case LSM_ATTR_CURRENT:
-		sid = __tsec->sid;
+		sid = tsec->sid;
 		break;
 	case LSM_ATTR_PREV:
-		sid = __tsec->osid;
+		sid = tsec->osid;
 		break;
 	case LSM_ATTR_EXEC:
-		sid = __tsec->exec_sid;
+		sid = tsec->exec_sid;
 		break;
 	case LSM_ATTR_FSCREATE:
-		sid = __tsec->create_sid;
+		sid = tsec->create_sid;
 		break;
 	case LSM_ATTR_KEYCREATE:
-		sid = __tsec->keycreate_sid;
+		sid = tsec->keycreate_sid;
 		break;
 	case LSM_ATTR_SOCKCREATE:
-		sid = __tsec->sockcreate_sid;
+		sid = tsec->sockcreate_sid;
 		break;
 	default:
 		error = -EOPNOTSUPP;
-		goto bad;
+		goto err_unlock;
 	}
 	rcu_read_unlock();
 
-	if (!sid)
+	if (sid == SECSID_NULL) {
+		*value = NULL;
 		return 0;
+	}
 
 	error = security_sid_to_context(sid, value, &len);
 	if (error)
 		return error;
 	return len;
 
-bad:
+err_unlock:
 	rcu_read_unlock();
 	return error;
 }
-- 
2.43.2

