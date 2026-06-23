Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853D37DAB3
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222158; cv=none; b=bgjsavfmRl6TjXaHTJ6LhBsYfLNI0K8YVIZ8J6PgqTx3hxHuFSFdLVDeyiqYKGzMbi/YNxY+HzUGy3RBTUG+w3Gp7I0TlQiCWGud9wmRiMram1JaKGIye4q6TSqOMMvtwKOc89uQZudAckTKJjqVUCz0DKqTRyv/742TQq1SnGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222158; c=relaxed/simple;
	bh=F1jGbJpinbDN5eo/Rs2ui1vKV1pnO20af9SRRU+TakI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sa5y2DZkw50rSD2bq1SqQexyG7okJA/gmG6kZD9gKBOqwHO9/JhotkdYG4Hb3VMH1QwcK+HrH6q1nk6n+x91qpE9YYZF/huz9dlou2/EHMP7Sd2xGxMo9iqMYkclfS5+MUlxHfS4TV1gOjWaIz+BoEzvgPaCLipQFiJB0e70kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=iQfIVr7Q; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="iQfIVr7Q"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222154;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfZIAEB3MeZzfqcQwYur1ABnDE6wRC8d5R7AX3rStLw=;
	b=iQfIVr7Qn0Am5XSRTNcuACyMGDmNI/LOsJtEFKCp2LlO4LUMsOJUSuaDm0VkT/PW9lRXN1
	nTQQj+p2hJ/trg8QB5DoaUNDxY4nRo4bWuHgOohRaKfQdI7cQArQVFVnwYx3qUh9rI+BdB
	mI6Rh1KT3rdTwa2zAs7wsAqT89skgYdhx4jgJbvItBBPgmThhZezoRvcCs7lukICRTEk+O
	/TgP7FgYHjnPxIWmIGYd85c2cAjshJNgf684cEs7pgd2ECO577yaG7iiV7PSPjW7RujOk8
	0SKHWn3Yy3TSVTKTMzGa/P/sFeqeHHzgM3g+5jat/UtWd2t2kkzy+dTFt8mL4w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 23/24] libselinux/audit2why: free reason_buf on a TE denial in audit2why analyze()
Date: Tue, 23 Jun 2026 15:42:12 +0200
Message-ID: <20260623134215.98273-22-cgoettsche@seltendoof.de>
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

sepol_compute_av_reason_buffer() allocates reason_buf for a constraint
reason, but only the CONSTRAINT branch freed it. A mixed TE|CONS reason
returns through the type-enforcement branch first and leaked the buffer.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index b03ecc91..5dc94302 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -418,10 +418,12 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 		avc->av = av;
 		nbools = check_booleans(&bools);
 		if (PyErr_Occurred()) {
+			free(reason_buf);
 			free_bools(bools);
 			return NULL;
 		}
 		if (nbools == 0) {
+			free(reason_buf);
 			if (av & ~avd.auditdeny) {
 				RETURN(DONTAUDIT)
 			} else {
@@ -438,6 +440,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 			b = bools;
 			outboollist = PyList_New(len);
 			if (!outboollist) {
+				free(reason_buf);
 				free_bools(bools);
 				return NULL;
 			}
@@ -447,12 +450,14 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 								b->active);
 				if (!bool_) {
 					Py_DECREF(outboollist);
+					free(reason_buf);
 					free_bools(bools);
 					return NULL;
 				}
 				PyList_SetItem(outboollist, len++, bool_);
 				b++;
 			}
+			free(reason_buf);
 			free_bools(bools);
 			/* 'N' steals the reference to outboollist */
 			return Py_BuildValue("iN", BOOLEAN, outboollist);
-- 
2.53.0

