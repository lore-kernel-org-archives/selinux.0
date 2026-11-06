Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967480;
	b=StLukq8lg7YC7np9/PiuKuLrP1G+2i3d1uABUeOCwxqLDIYJeXLoFVjcm8OtAsNIWuH8
	 SrnyOGwhoTCFiljbCDpZles0Xgu9xhi2FcKgBEcGo8i8+J5J4edwms+F/C+0DMkpwsv57
	 4c9KjaE8DSf/HrXcRi9h07qaOfej6XGUoH4YxgMvzb4JWrBznlfXep8MUE3jCFczqyiqe
	 2MAKW8xW2+DfZZIyln+jsZnKNXgMHWov5ElUHqmEmzHY4rjE3nZIRrnXFE/phcfdYg1vx
	 m05QDInqMxaaYRD2vl2ECDghOyMgPuZxtxT/2T8TemMb8NSPUJ8nVcwGnJUkQQLhCnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967480;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+DCuaBfA29AxFjQgVoFjzWuU0+XhGnDleGbfAGhoraU=;
	b=U5IEys+Piigvf+OxqRXWrglV7/tzpXBCxc8dVBMKCtW4Ye1iJO+otk8aJjOmsFIG2KEb
	 CXDQgx5GELXF3Ed/mFjhp1mnpOxdbMbGGymhviZTyVFvZQFPdkFNF6QRu0374A70vwy6P
	 ri0nZyjLJNPG0RuawHJ4b2ve+WXsBji4rtEp6hgRyWnr/GYi0PhsTMXyvtgJkFvkfpfCW
	 cSZkYtVWwNB/S/oR3r4BPjPAz/3Qlc+wffnkw6IYRiUCUzuxqlmJv75IxFAYBkRvuRWLh
	 7rRv0pPKTkdOnt/C0Y8H1OlNDQBDhBAbJCK2dtb1LO3owttj5K/k5WZswcepXnvhCQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=YIExps6z;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880E606A330
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4880E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=YIExps6z
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793967469;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+DCuaBfA29AxFjQgVoFjzWuU0+XhGnDleGbfAGhoraU=;
	b=YIExps6zri5rM/nDSiHcMFfYzlmXhMI5dBVqAoojr/GN/Cq9rqOAXqRitds8Wb2zy+TEgw
	Jfi2dVK+4J6p6rNt2uD5DhcWKQqOSj1ao84tc84cWOXBXdpuyyUb8FAaOw4VFJSEsFJMnq
	8ibdGcwjBEWRVH/l5AcY7YXbW/6hwMXgaf3aFplx+T9QNIMusY9xAnWsapXhrWlDzprfD4
	5iotHOfL9l2kuvfGbnNHa2ttyZKGbAqvl92qm50N8ZnQN4wvJwB+rn9d7pdsEAVFrlREXR
	NUF+nIwTxCko0YSCe/TwYqCf4GnnGHZzBJoQ5Bx1Qc5MmsM/CdSMlIuc0/7fHg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 2/5] libselinux/audit2why: check CPython allocations in analyze()
Date: Fri,  6 Nov 2026 13:17:21 +0100
Message-ID: <20261106121725.48778-1-cgoettsche@seltendoof.de>
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

PyList_New() and Py_BuildValue() can fail; their results were used in
PyList_SetItem() without a NULL check, which on OOM would dereference NULL or
insert NULL holes into the returned list.  Check both and clean up on failure.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 22f8f4f3..739174a4 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -446,10 +446,19 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
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
2.55.0

