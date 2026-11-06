Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967481;
	b=dXZxfe8fbYQANPyxItLErN41Rr4wGnT/tALJqyRvZDzD072WjiBLwxcQX59ij93ZytQR
	 jVVIGZ/g6S4ONlgr69bSW9Bxpkd23Ldv0GNKowzbquiNX4GW31JmHiy4NENIbanaCoipO
	 CBXJjMNmX3Is0IdwNSWrbbXKj753xGHfb/ZafbJXIy9ZK3mRdbLvCyH3919xrGGeAcOHr
	 On6SBLHzMl+8BnURydS4DV5n4vJaBv3swD0ah9jy4QpO12PH+ebRW9bgQN3TKQ6I5L5CE
	 LbdK6aR9e9kjoeIt3hnyJPwxGpBQIF+8eXzwcLWYu+Kd1BCQLFY2eYVD8zyhfSAtgfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967481;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sKOSiRoI5YmdsnGjkS36GrIU69aS0vQVUlBXQ/Vtbko=;
	b=GOkawIPQjsrM/L+2h9ifkknDRPYUo1YLR9AMCRJCUk0MLJhYcPZ9wff3kEuQS3ZALPgJ
	 p4D7KOoEQLgWj02vgtUwrjU1v/JtrJbl+LjLKbb+U6hJde66raClDJmAPsj0cvW0rVt+S
	 dqmJ+56KgREPHVRZzifUgFtnDGhEcZEVZky1qiQROi2OBjyl0qzyFWm6x4fMVPilY3su7
	 iCgoX8/xNkIKJKDqlCrx3jMuKkW9n0rEjhk8aQW4rNT+6SwGNcsJrTy2p2qxEBOifTsV/
	 L9wslZ6A4RNdqepHnMN3CvYNy3aB8MxNSSmVM2UxSMLbW0E3p987wWD7+Sgq9OXHGeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b="AR0p/d1Z";
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B1606A32F
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 487B1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=AR0p/d1Z
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793967470;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKOSiRoI5YmdsnGjkS36GrIU69aS0vQVUlBXQ/Vtbko=;
	b=AR0p/d1ZOrSGi1uj1w6RXos+MuDdkigGtQSIvk53HIvi0lYlLgvNF1KsV3jYSqk+kGNa2o
	FOKUKwuWHmUhW9s5w0m6Wp10Wk4USpaLOM4tYHG/HSkxJ+d/XnEbefh8A87FRgavPj/lDi
	s9X026En2/uAS0WPF0WAq5cjwiUuTliG6fsHfi7w56U8CShGGTsp+nCt6FZd6U+gO5N2gA
	dhbfy4Qkt3Gp15PGfJeLkB7A8WqVQyLMCwGog8u7Xo6qqa6Zt1+OOJUIfkEqLlD5KHZQ4I
	LV4xobdFL3y1Ou67hZJy1Gk5+US21ERfNfEt4kX4bLBJfkRK+VIxNPh9VzWz9Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 1/5] libselinux/audit2why: free boolean names returned by check_booleans()
Date: Fri,  6 Nov 2026 13:17:25 +0100
Message-ID: <20261106121725.48778-5-cgoettsche@seltendoof.de>
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

check_booleans() strdup()s each boolean name into the array it returns, but
the BOOLEAN branch of analyze() only freed the array itself after copying the
names into the Python list, leaking every name on each call.  Add a helper
that frees the names and the array.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: move patch defining free_bools() first
---
 libselinux/src/audit2why.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 50dfefc3..22f8f4f3 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -180,6 +180,17 @@ static int check_booleans(struct boolean_t **bools)
 	return fcnt;
 }
 
+static void free_bools(struct boolean_t *bools)
+{
+	struct boolean_t *b;
+
+	if (!bools)
+		return;
+	for (b = bools; b->name; b++)
+		free(b->name);
+	free(bools);
+}
+
 static PyObject *finish(PyObject *self __attribute__((unused)), PyObject *args)
 {
 	PyObject *result = 0;
@@ -346,7 +357,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 	PyObject *listObj;
 	PyObject *strObj;
 	int numlines;
-	struct boolean_t *bools;
+	struct boolean_t *bools = NULL;
 	unsigned int reason;
 	sepol_security_id_t ssid, tsid;
 	sepol_security_class_t tclass;
@@ -442,7 +453,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 				PyList_SetItem(outboollist, len++, bool_);
 				b++;
 			}
-			free(bools);
+			free_bools(bools);
 			/* 'N' steals the reference to outboollist */
 			return Py_BuildValue("iN", BOOLEAN, outboollist);
 		}
-- 
2.55.0

