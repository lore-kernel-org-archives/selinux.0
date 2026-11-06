Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967480;
	b=Bj68faP26bfgj/I46Mlvj5B4pqezEkpTk6ya5VYH30wYc4y7AVWpia5dVE1qdAReNc+e
	 n1JiMHsSWjbkDx3D1zXfkEQXc4W7J4onQvJ5OtW6/83UlKjac1ReWwI0cJ18af1JK2OvC
	 0H4AO+eNXzdZ62ItSzPYrif4PsmRMlKdwlQTeqW/GkLso6ZHW/9jX6quqA9CLxyz62uma
	 d4DpwbaBvFflga2aqxcTAecbAHLlL7bDTwYUegNiTGaJj7RZfXbP/76CGEoqGm2/J3R43
	 Dtuuk8KdqWMezMR63mz+GzELhoxzNvAdULtNTJZ9OOx6nSJUPyMPNIf3MHgcoYO+fwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967480;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=n1jzrvutq7Ia9kYi6MZP5NvCgsZxc4t4T4f6cGxiY0g=;
	b=R2AglRiXOGAKatK1sFZquiaPnTCSvvQtYJiT4tBJJsxAzVKFK05B9OK5JoK4qsC+t2Cg
	 N+iwti0LIDM2YfwXVcrR7mxCW2ifHwfSc1OhsbV278LkkLHPyKx9OL8etpiQFYD97GoWl
	 JYkrwB66WzZAYZpA3yRIGcHsHHdw7GMcveIACLQ+rC7lnTI28vWkRz+WoxFBRKhalGTS4
	 uWBfZovnuiUo/X6dxACdRwjzmyou87TFU3jWOUIAsZFU9IhrPap6NoZs4GLdbc+8Re97J
	 5Q9RlG4hNx6Tv1SlJQ/8/KuKQK2FQE/WqD0QkiGWHigtF9JvW149xgfrTPeohXTsIoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=rXagvX1O;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DD606A32D
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 486DD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=rXagvX1O
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793967470;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1jzrvutq7Ia9kYi6MZP5NvCgsZxc4t4T4f6cGxiY0g=;
	b=rXagvX1ORnCpKzHkxhmofJD/p4EM7y73fEv3eIyeOQay4/vSp481qORCrr/jk9ZP2o+18w
	M8TPWqNU010Mi+OWxMohCEJOYI4pzhjVn5udv9/Hs958E9roJL1XOJ9I/em+8N5SvVtnTr
	uvriZeQ1UABRn8NaMPFESScfEnzi/IhsqI0B2gfx3CJHiT7Qs5xRW4n4IgJurGimT7zYa5
	q705qr6a7dBdn094LV/BotXw22WEfevJipXOX7b1yvAP6sj4phVyTzPBQgjcUL68NSg7xi
	3tRUdoKgQmBSqCX9Y1NbzXctaKGoxp4OC1A+vc2j6qx42qGEBz7vhJ3abVp0UA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 3/5] libselinux/audit2why: do not return a value with a pending exception
Date: Fri,  6 Nov 2026 13:17:22 +0100
Message-ID: <20261106121725.48778-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261106121725.48778-1-cgoettsche@seltendoof.de>
References: <20261106121725.48778-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

init() returned Py_BuildValue("i", result) even when __policy_init() had set an
exception and returned non-zero; return NULL so the exception propagates.
Likewise analyze() ignored an exception set by check_booleans() (e.g. a libsepol
boolean query failure) and went on to build a result object; detect the pending
exception, free the partial boolean list, and return NULL.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 739174a4..13d7b752 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -340,6 +340,9 @@ static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args)
 	if (!PyArg_ParseTuple(args, "|s:policy_init", &init_path))
 		return NULL;
 	result = __policy_init(init_path);
+	if (result)
+		/* __policy_init() set a Python exception */
+		return NULL;
 	return Py_BuildValue("i", result);
 }
 
@@ -364,6 +367,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 	sepol_access_vector_t perm, av;
 	struct sepol_av_decision avd;
 	int rc;
+	int nbools;
 	int i = 0;
 
 	if (!PyArg_ParseTuple(args, "sssO!:audit2why", &scon, &tcon, &tclassstr,
@@ -430,7 +434,12 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 		avc->tsid = tsid;
 		avc->tclass = tclass;
 		avc->av = av;
-		if (check_booleans(&bools) == 0) {
+		nbools = check_booleans(&bools);
+		if (PyErr_Occurred()) {
+			free_bools(bools);
+			return NULL;
+		}
+		if (nbools == 0) {
 			if (av & ~avd.auditdeny) {
 				RETURN(DONTAUDIT)
 			} else {
-- 
2.55.0

