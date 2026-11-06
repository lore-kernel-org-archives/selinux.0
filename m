Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967480;
	b=FWd0+AdYHJIUzirhRRILoN9B6qpzSAJvUelFtt3EbVwEazj/zY47cWlXWTTEzorHIKDI
	 CRF0OabTiaJ7nBniDTHA/cxDjHPUMRUzK0pla9BvaKx93pzK9Xz135V7J1swbAeCjQUyL
	 hJfoqHlbyyNpkypYl3C9rQBKn5UteTb2s8496aEQ7mRaVxSOjKHiYZd7Ea6872bJMcQx1
	 7ldnPtkeM9cq0gYikDQJ+nqu3t0hyrMeTcS+bbQdqjARAXJ+TeZ68W2B2BtsB7PotNKkF
	 2YRLNtke6U3GUC2hMpLiLSsuYqxalnxg7FrcdCc6GFjLqFv32vPZcB9XqFyx6lZ5/lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967480;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4TqcvvdoqqFAB/FcShspArCAF4VCiJ6HTIRIM3HiQsY=;
	b=X2idUYvwljnUFfYeNFo5IJGE0wJ8J3iiKJfUb145SKP5mJrCIGdac2eEV1167kdjHIEr
	 DEC+HispbyUhO2J5EKtyuZLSen/J6E59MyCKNAFVgYTFDHCu27d+O7ALUbaPr0wnt/rdu
	 XGoCBHDXhsbKw67JycM8p7Uc5C7bHhtmBLut/V3QoHy7K9/bpgqHXCtRis4knxgKOEia2
	 qai760+thuUOE+cTg5HwTgAoZnwgxNykAsc90FuVB+H8BIPwperuE0sFTv1zjV26xvqWk
	 3RKrUTUCY9otvqrcbOJx0me97nTH8Rx0QOLOOXqk3Gy+gJdo3lFSsFF5S951zW3VXHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=dTlzzCQ1;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48585606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48585606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=dTlzzCQ1
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793967470;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TqcvvdoqqFAB/FcShspArCAF4VCiJ6HTIRIM3HiQsY=;
	b=dTlzzCQ1LObwVayfthl51EEpRXCsNuxFkqjY7OsIwUNe7/8LowtYYIcsvMO+q8aijvzbbK
	9cS7HHva6rRzAp6N8qdZeFMVwS7A4UOFI5Q20HdZkQT/2JwcyazTnohmal5ct7WqmVtPcO
	SSSgM3tKW+S/hLDyd53LP74oE1rnoIWfsDHxrl3RduPy0/7sZSozPioarFlF01ccwvMhRo
	XN3WfiT71rb1PjBkSs+MEZ/Z9vJN/eH2nCOhkgJELLEDl98W9XQiuGDzOcmS4YmwJKolTO
	74ksZm+66hnnz1642zH53UbLZMRFEGbgJaQdkD1Yt/TlML7g2vaYM8kFJgv+BA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 4/5] libselinux/audit2why: use public PyUnicode_AsUTF8 and Py_ssize_t list size
Date: Fri,  6 Nov 2026 13:17:23 +0100
Message-ID: <20261106121725.48778-3-cgoettsche@seltendoof.de>
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

_PyUnicode_AsString() is a deprecated private CPython alias for the public
PyUnicode_AsUTF8(); switch to the latter.  Also store PyList_Size() in a
Py_ssize_t (and index the list with one) instead of truncating to int.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 13d7b752..7bdc7acd 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -359,7 +359,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 	char *tclassstr;
 	PyObject *listObj;
 	PyObject *strObj;
-	int numlines;
+	Py_ssize_t numlines;
 	struct boolean_t *bools = NULL;
 	unsigned int reason;
 	sepol_security_id_t ssid, tsid;
@@ -368,7 +368,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 	struct sepol_av_decision avd;
 	int rc;
 	int nbools;
-	int i = 0;
+	Py_ssize_t i = 0;
 
 	if (!PyArg_ParseTuple(args, "sssO!:audit2why", &scon, &tcon, &tclassstr,
 			      &PyList_Type, &listObj))
@@ -408,7 +408,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 		strObj = PyList_GetItem(listObj, i); /* Can't fail */
 
 		/* make it a string */
-		permstr = _PyUnicode_AsString(strObj);
+		permstr = PyUnicode_AsUTF8(strObj);
 		if (!permstr)
 			/* not a string; exception already set */
 			return NULL;
-- 
2.55.0

