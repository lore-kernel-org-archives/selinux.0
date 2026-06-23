Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341237D13A
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222160; cv=none; b=DjHDzpx3RfNKA4F9fqXJRPDKEcGZfu8kG+fGSDnDrvj013tGc7mxsXd7Vo0TJ791Y3eOKRxI1edOJ9QXMDC5mj8Z6Bv4T2d7RvAlksdF4DA3Y0kpANd2JjBkVyO8vNxj4gjJTgHh5+ZE332PXFhVFnf6uBkfk2YVFddduT+j9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222160; c=relaxed/simple;
	bh=htPxigcYVdHoPVW/FH2Jq3haxda00hJaZf0yYuwxPiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ppz8bkTbDv+iQqIHuT7tXo5991QKVEF6lDCjfkbtRmYPsCei9HGM5q0Bu1bgCPGjmwRGFK2wBTG2NuJDalC9/nkUxVrqO0Xg8GC/LCCx7cXSymzRTKVd3UgaHKty0Lwa7P6fFuCL/Gq+yQNPi7pcKPsxQt/3yDL/PaBbvOQd18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ZwKzJ+X4; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ZwKzJ+X4"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222154;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgn7OP4Nh2uu+SkU2TminkQ9nKNE3HEcrzPUtdf02W8=;
	b=ZwKzJ+X4zHFolv9FfIPxaDGBwQhU8xarHD4OZ3+LDnTiUlmh8YUl9WSTkZITtCngMWyGzX
	SGBLm72Mj431YKM747NP5j+d2aOAS8s1e+R/OJ+a0oWWSFuDervwdOLnSzVKyeRgZO0f91
	osJQW5fHzFCSeNbm0V4PMgEnSSVAaCi9gpjk7xhseD+VB2m4aiGMRP12BnP332ApW4AILM
	JMU9giLI2LuZfFNE1NvKgJREtBZyKxKlaFanOvYK28NCOIVy+g+tcLQsbxiHmjMDXvbqzR
	kq2PJB0hHacgp/5AuqIOoPt7mFZl2id/yTvjkSXfbS/3fUKPgc1+hwBpCqn0bw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 22/24] libselinux/audit2why: free boolean names returned by check_booleans()
Date: Tue, 23 Jun 2026 15:42:11 +0200
Message-ID: <20260623134215.98273-21-cgoettsche@seltendoof.de>
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

check_booleans() strdup()s each boolean name into the array it returns, but
the BOOLEAN branch of analyze() only freed the array itself after copying the
names into the Python list, leaking every name on each call.  Add a helper
that frees the names and the array.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 2e1a98a9..b03ecc91 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -165,6 +165,17 @@ static int check_booleans(struct boolean_t **bools)
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
@@ -331,7 +342,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 	PyObject *listObj;
 	PyObject *strObj;
 	Py_ssize_t numlines;
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
2.53.0

