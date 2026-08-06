Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681A3AA1B6
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026668; cv=none; b=IP4KboJEIXtDRY56eO61aEOzMmmKfXsHa3xZSsU2/Amum678atd83Jv+cYKfSkMG2xwRdxQRi/cnGGKbmAAtFP/sqcTIpYmVilQnQbNGXvPwPDpsIArwY/9xaMeSGrKmo1rlnl5LlO2c2G3S5FUKfXGoRFq3HNRjA0KtBqnCM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026668; c=relaxed/simple;
	bh=9lJ10YcZCInEwCTAkV7uyjeGl+w1rcmLLB4z1d7QCZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kWQRzk2swHHhuXjscEaEpMlz4kcbh3o3I0Ss4ikgKZNk7UTNPH+qvkkO2mRxNYjpzduo9LkOlzupVTLgQENxT7zjiR92v66/PymUTMSXRV09JF7G/STjBYQo1eYKKvgRDRfrvhyAP6Ear+045ygrSQ8JvBn7X7mpdYx8hcnn2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQFsEVnH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQFsEVnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786026666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3g6UGoTbQYVEkR/GHdSK7H0HJYntQx9WGhAA6UP3dXs=;
	b=KQFsEVnHLfKe6AUsW+2efuKfX4HpKpj/PvM/BOak+b2MA55QHFoihU94DVsa49DL3dhk5h
	IpqOYY9BnZPCzF7gi59Ai4PTJ3uAj00DVL0C+y8yM4cg2J8xAyQ3PHA4cNLAcfHO+PU6y+
	+74AKLhanW1233cLGaxB6k8tRd6aeRU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-_pFzOMruNNK3PvX1bYQmQw-1; Thu,
 06 Aug 2026 10:30:59 -0400
X-MC-Unique: _pFzOMruNNK3PvX1bYQmQw-1
X-Mimecast-MFC-AGG-ID: _pFzOMruNNK3PvX1bYQmQw_1786026659
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E311A1955BCE
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 14:30:58 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.34.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E9EC180049F;
	Thu,  6 Aug 2026 14:30:57 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>,
	=?UTF-8?q?Jitka=20Plesn=C3=ADkov=C3=A1?= <jplesnik@redhat.com>
Subject: [PATCH] libselinux: Replace PyString_FromString with PyUnicode_FromString for SWIG 4.5.0 compatibility
Date: Thu,  6 Aug 2026 16:30:44 +0200
Message-ID: <20260806143044.42884-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

SWIG 4.5.0 removed Python 2 C API compatibility macros (PyInt_*,
PyString_*, SWIG_Python_str_*) from its runtime header pyhead.swg.
These macros previously mapped deprecated Python 2 C API names to their
Python 3 equivalents.

Fixes: https://github.com/SELinuxProject/selinux/issues/538
Authored-by: Jitka Plesníková <jplesnik@redhat.com>
Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libselinux/src/selinuxswig_python.i | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 03ed296d5b85..17a2620d46f7 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -69,7 +69,7 @@ def install(src, dest):
 	PyObject* list = PyList_New(*$2);
 	int i;
 	for (i = 0; i < *$2; i++) {
-		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
+		PyList_SetItem(list, i, PyUnicode_FromString((*$1)[i]));
 	}
 	$result = SWIG_AppendOutput($result, list);
 }
@@ -102,7 +102,7 @@ def install(src, dest):
 			len++;
 		plist = PyList_New(len);
 		for (i = 0; i < len; i++) {
-			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
+			PyList_SetItem(plist, i, PyUnicode_FromString((*$1)[i]));
 		}
 	} else {
 		plist = PyList_New(0);
@@ -119,7 +119,7 @@ def install(src, dest):
 	if (*$1) {
 		plist = PyList_New(result);
 		for (i = 0; i < result; i++) {
-			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
+			PyList_SetItem(plist, i, PyUnicode_FromString((*$1)[i]));
 		}
 	} else {
 		plist = PyList_New(0);
-- 
2.55.0

