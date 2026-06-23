Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356037DAA2
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222158; cv=none; b=tJkXxXzG0n+OHC9pXahlhjIcFlIXqx+lO9u3qNoOJkr5hglAQ5eS0r4a9X6mYWdO1gqWF8cTXZ5+U+RteUp27+X8Cf29JHjKzN+kw9HDYH9XyCbzwWtKVWR0M3v8oCU9pVKp1Q9GZS6zj6RgcM3zy/SoEvWYbDminL8nNwzEyOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222158; c=relaxed/simple;
	bh=d8rdfYOfd5ROx+XgLMY5JY3uCgzViA3Bu6eMi0Wes7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/qCELPtgrpeLyDjqo0WuaR4ESW9xBZxgsYf9+RE0RdYcpxR4LN4lpMYo3WWt7XelgyispjCbViGcj8u2Ku23c47ugrLCJnuVm3CUM3bh96s0POuwwPzhOzyzfZQNjwkgpWhEAmLBTG+nlEAQusKmoLntYUeDgLq29twyY2jywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Z7AyomfK; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Z7AyomfK"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222153;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJ+pguqp/wlaFbh5DV7HDJ/PKFcA9gSXjZW5ppyWB2c=;
	b=Z7AyomfKCZ1LJY0UstsjnUaBJZHFh1KZ/HFQ+tCEL1vpzK+YPySuIrWqLitm8iaUs8fh87
	vQs6kuX6mKoLA1R1kofVCvbQKU7NeeJASNAZguS1gbcgapPN13HISKLyCYYIpmHOpRVXuq
	skMKfSIbB6HU8Fum952W04TQQ9G4CkFU2SL/8UsLoT9hM6lqyUOsU32PgcISL5HomYRHAk
	GVP60uZBHP7Tu1vV6yav+7pIjI10585FMG2Wqey4leqQ3lfx3+UlgKmHVev4kbDdg/w9+F
	mFvvOW5srAeWWbErU1XMfTgoODVv0u3bvpmTZst5I1h0YPM/nVFYbL7VCleGXQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 19/24] libselinux/audit2why: check CPython allocations in analyze()
Date: Tue, 23 Jun 2026 15:42:08 +0200
Message-ID: <20260623134215.98273-18-cgoettsche@seltendoof.de>
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

PyList_New() and Py_BuildValue() can fail; their results were used in
PyList_SetItem() without a NULL check, which on OOM would dereference NULL or
insert NULL holes into the returned list.  Check both and clean up on failure.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 3c3aa105..c6c4c223 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -417,10 +417,19 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 			}
 			b = bools;
 			outboollist = PyList_New(len);
+			if (!outboollist) {
+				free_bools(bools);
+				return NULL;
+			}
 			len = 0;
 			while (b->name) {
 				PyObject *bool_ = Py_BuildValue("(si)", b->name,
 								b->active);
+				if (!bool_) {
+					Py_DECREF(outboollist);
+					free_bools(bools);
+					return NULL;
+				}
 				PyList_SetItem(outboollist, len++, bool_);
 				b++;
 			}
-- 
2.53.0

