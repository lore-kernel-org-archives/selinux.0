Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456F537DAA6
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222159; cv=none; b=Bk+QCEP7rq5idTTRGVNV1E6EYGbWwVfFhhSXb14TSNtTVFE9APK9nIEUezhTq1f+5vk31SA/NgmSe4CpYoMgbmiQzBvpBrUucUZqMvSffCfoDefHfGzbiOCh+jkpLePCMLqXaD5N9GotP6LgDuT7Za8BPgGUEcB7gA3BVILFoso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222159; c=relaxed/simple;
	bh=8hfHvMB+fBhg8+FcTKRhpgTIrAcrEKxNfDjuUNSKtGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q74tpyMewV5RC6ftGXBU2AF1uAP+o++VDjcD0ecbHeMWozzyJmx9MpdGtpbjcE+c2X2mdt5KD5dUespIDWIy5HyggA056pdUz/xKu7hvw2/blPA7gQ0ywen87VkfEXyFjYVRrtrV+vtU1c2ZLRcTjpVxQunqw6DwXxh1h81mFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=hjrzG9T2; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="hjrzG9T2"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222153;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3eE1hew6c7h9cqXRilkxg3ZdIXThwSM037gpZKYXWg=;
	b=hjrzG9T2pfccLyxqL/4LJLhPI4Jya2YYRdPQbBnYcm+JZeOs9ZI6gaeN1UUN+l1ZWbQMAa
	j2TJQJIgsvSfvZIfSBeta3I0sOsl/i3t6JI4psnXW1oqLNb1cXQluOY7aNkROWAHmNltsb
	exCnl0tyBfKbwzQf6RqtjvThyajCC1f6MOxGq6xwN8ZiyRu0DjYxSlFRJISG4p6GPPy+Hv
	90LCzTS7WpI3f6RSgN3pHwasrUphUh0Z/lcv2Yj3AdNnui6Y8NPviBCdg1MxVQbdJCTZ5Y
	jcDHZY7UbJ2ccv0gxYPS0PKmzDdI4FQytHb8gx4/OblAK5nG3Aq5LuaymXvhqA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 20/24] libselinux/audit2why: do not return a value with a pending exception
Date: Tue, 23 Jun 2026 15:42:09 +0200
Message-ID: <20260623134215.98273-19-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
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
index c6c4c223..cae13f19 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -311,6 +311,9 @@ static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args)
 	if (!PyArg_ParseTuple(args, "|s:policy_init", &init_path))
 		return NULL;
 	result = __policy_init(init_path);
+	if (result)
+		/* __policy_init() set a Python exception */
+		return NULL;
 	return Py_BuildValue("i", result);
 }
 
@@ -335,6 +338,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 	sepol_access_vector_t perm, av;
 	struct sepol_av_decision avd;
 	int rc;
+	int nbools;
 	int i = 0;
 
 	if (!PyArg_ParseTuple(args, "sssO!:audit2why", &scon, &tcon, &tclassstr,
@@ -401,7 +405,12 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
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
2.53.0

