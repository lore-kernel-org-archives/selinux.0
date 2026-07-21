Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AC4028FB
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654185; cv=none; b=m4fc6gUiLTxWDTKpZ7tFMSEWmJ7bT+jBe9t6mN1dnsLqBd97rUKUhz48B/qm09J/LF1rR2JlgLDTFowRLuybxwEMamTIrMjikjse97DIdnLPyOgNJbipdgUr4c1uduYfx18k/rmvUgntBVKzFUdLVrgSruSOccsjIKL0lcPRWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654185; c=relaxed/simple;
	bh=AJZHlT9c3C9W3aEA3qvIvF5bVOuBRTYsJYHqlKnfmkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsgrIDrFuPQxaf8vCojYk+ldsV+3lRrHdb64/aa5V+5MceBJckkIuwTnQODlI0VjAnGs/yY79ugyPWt/0hk0OykBfMYaRIRflnlZ1yN5nmuWR8HATqj/aC0P49btETYkU+rcJWxNmhPvO+kASifCUA++CKE+Oigr09m6+Gm1N7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIZo3tqQ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIZo3tqQ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e4fd65b2bso639558385a.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784654182; x=1785258982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wt7D2ZH3gotK1NaeObL96Gd4bYAlaq3biHpagLlKySA=;
        b=gIZo3tqQXqV1r8cbd3D4o0fcuKPyQRSc2SqwmSdJ6s3MHmfjW65a66PfTm3h03pYX4
         F1bsV8bp9ORXoaxRIjmzVeAGBDxzx7ZkVVsIbEGNOJi4qX1zc/HDNTXT+R9J428BGokK
         QHKyVN/5NyXQoFpH4JHZqcIIox09T/UjGomdpG2n3eecqIziSuow1JaM4ntexTxSmwvd
         JPdGBukQS88vonsyUbTEhR1DcsIQMKAcDPGdRFg4LhPdlFU0G0p++95Oi7VCrg0fRRiG
         KsmYnkRAXVJ5vkPyHcikEhXClWCmTFC++VvTCb2KzZ2YQBCFx9ViVCzs1W+8F0RYhDZM
         7Y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784654182; x=1785258982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wt7D2ZH3gotK1NaeObL96Gd4bYAlaq3biHpagLlKySA=;
        b=iEXL7J+yS4ZWzB32dTti/c2T3AbqtzNXXzoVB8i+lOeX0Ef7s/XZ63h/AGfp/ePzbC
         kmgkffcDTSTn2Pzqsl9+MgGTvsFD0eRHxHudYL5igmxY/+RmGyzZ5LkANylXES5My7k7
         S7O18LbSNxUVH+FBFkL7hajYjtUBRuHPWCGGE41zYXmukYdBACICP0y0Xl6bAnQr/hse
         f+MK2xvDekeP89hNUsBbwlBrJVlFF/vBWm3lZILhOyn97fceaFOa6iDrtujRznd4Hp76
         XMUVF4S99drI/+toxLtZsa5KccpfOP5SKqCktaKN5sO5kooiD0HLzijAP9xJLIujuZ2q
         YuNg==
X-Gm-Message-State: AOJu0Yw1MZ3Pm2Vy+09mAinzWMIO7itqTqmBHvKCi8CPCY8eQiBwDsT5
	bLv9nglGZI7m8NPHb4NA8kJ72WCdvqwcd7gC6Btnz8pSGvfzr8pzfvyD2RAgIA==
X-Gm-Gg: AfdE7cmHkldlayHwEFjXQRW+iYQ00Vm35FhSp4RJVYKQP72PobMFcj1z5vUIG+soHYe
	g7TPhECLg3Hs69+dOXaKw6MCVI/MJ84m1dVauY9/romxpD1tKA10D3FoAkmRByKP5R9kLuRxlgE
	VwceFBBC+gvtPJsg+UD1K+fZQgkqOv6t2ldpgFWtkOIoRDKqFbu9ZTxKcsiAR6frleMVi0g8Y/z
	yhvOb/k9VAGdPunbpdH8Sy3OOMkBXKC/mqRA77WjpOKpZ+hVssbwMfqXa/IukBSmgZ4IFcCSZt4
	qkMRH7zNdBYG+X+wpFuh+1dtc2XnWOLLIS3nKpznvzUTFGJOK3ZaLJ1lgU9z+BWO+Cy98MW74wY
	jgbw4ngd+dpXJpVEtPrgVqs/06GAqGrzLiEbS96tGZ3n4lh52zBFZNJjTzs1cZmLiJrfd7fuoF1
	CDbA9FGINKToOG1wPDifPo250IuFflS5MUik/yer47fOHsHryAa9XQwciOp5ATHJ0/H98I9IOpp
	D8BMQ==
X-Received: by 2002:a05:620a:4693:b0:92e:cac7:96e6 with SMTP id af79cd13be357-930b430a21amr1960931985a.58.1784654182411;
        Tue, 21 Jul 2026 10:16:22 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545ec44sm1157894985a.34.2026.07.21.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:16:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: fix Python binding for security_load_policy()
Date: Tue, 21 Jul 2026 13:16:07 -0400
Message-ID: <20260721171607.61110-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9639f5d ("Add decent constants for python for return of
getenforce call") also added a global typemap that forces every void *
parameter to NULL from Python. This was intended to auto-supply NULL
for the opaque auditdata parameter of avc_has_perm(), avc_audit(), and
selinux_check_access(), but also matched the void *data parameter of
security_load_policy(), forcing it to NULL and preventing its
use. Restrict the auto-NULL typemap to only the auditdata parameters
and provide a typemap for security_load_policy that supports passing
any bytes-like object (bytes, bytearray, mmap) that can be handled.

Fixes: https://github.com/SELinuxProject/selinux/issues/354
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinuxswig_python.i | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 03ed296d..c8c08a40 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -88,9 +88,30 @@ def install(src, dest):
   $1 = &temp;
 }
 
-%typemap(in, numinputs=0) void *(char *temp=NULL) {
-	$1 = temp;
+/*
+ * Auto-supply NULL for the opaque auditdata parameter on avc_has_perm(),
+ * avc_audit(), and selinux_check_access(); it is not usable from Python.
+ * Restricted by parameter name so that it does not swallow other void * args.
+ */
+%typemap(in, numinputs=0) void *auditdata {
+	$1 = NULL;
+}
+
+/*
+ * security_load_policy(const void *data, size_t len) accept any
+ * object exposing the buffer protocol (bytes, bytearray, mmap, ...)
+ * as a single Python argument.
+ */
+%typemap(in) (const void *data, size_t len)(Py_buffer view) {
+	view.obj = NULL;
+	if (PyObject_GetBuffer($input, &view, PyBUF_SIMPLE) < 0)
+		SWIG_fail;
+	$1 = view.buf;
+	$2 = (size_t)view.len;
 }
+%typemap(freearg) (const void *data, size_t len) {
+	PyBuffer_Release(&view$argnum);
+ }
 
 /* Makes security_compute_user() return a Python list of contexts */
 %typemap(argout) (char ***con) {
-- 
2.55.0

