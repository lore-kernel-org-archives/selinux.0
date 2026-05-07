Received: from mx208.easyname.com (mx208.easyname.com [212.232.28.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353C3E63B8
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.232.28.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149078; cv=none; b=aijsDzzadVjeuZ/69a9CVTduAR4lDIENtlEZ/0uZDrUE778LEgFfTuif4YumQQqonLEnBzR/wfbEnL/pX16pDrNBh6hRamKcjRD3xQgQT+/8nJLOX/yYIgR07OMfeCcnRZCyt835OKVp9tO0lYYuKWm0Fp6JXjM25Y3v9BlvvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149078; c=relaxed/simple;
	bh=UC5qXoIoUayhC/U4bw0myN5K57Evkg+0tRZW0yhiyBA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LwnxHK164aD0D2DZKPvNCdMuKQ7SpCvd90/C2RIh0cHR9Qwk8A5a3OgrGR5Y6z/wMkzP63BVq7Swcr+Vinf9X2HlNOSfygbc15Gpc9NDB8TzbNcMh3/j1E+IEXLejQ/GoMRVmrFBriHeeTw+47KNaE7HYiC8xeCfQfqylzwgv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peppergray.xyz; spf=pass smtp.mailfrom=peppergray.xyz; dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b=mbfLKDOt; dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b=mbfLKDOt; arc=none smtp.client-ip=212.232.28.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peppergray.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peppergray.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b="mbfLKDOt";
	dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b="mbfLKDOt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=peppergray.xyz; s=easyname; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cAdDS79MPy3stDY1j4RZwqpd0jqr7dxDQxcMnxw23oA=; b=mbfLKDOtUHXeSb6h3fCATCk6/N
	cacxO6pveK3r5X24BGZOIMmOThlKnKJRnaoEgwldVNhQhTpodApaaYGfDa2yFWA+FtUpPblgN9gRw
	QWkjTwnWqNUnpntbN0cmSVQhrSHvMaaHHDS6HdcbL8V9yxhod6xNiGMkgo0mhQMkAZRMG5/yfMbxw
	wyRSclER1MwDaA9EXWI0j0CHrcI6fkqjnvhfixz9YN7OAPjqETa9cXTejBd1A7ECWXg+lujA6VmdO
	sfMzxZvp1Y+zeHj/khd99kxJyHfU+xYixnhj2OT2gQUWkhRkJKd/t84TXRTvh4CZeDBx41+DVTXvm
	mEmdQQaA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=peppergray.xyz; s=easyname; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cAdDS79MPy3stDY1j4RZwqpd0jqr7dxDQxcMnxw23oA=; b=mbfLKDOtUHXeSb6h3fCATCk6/N
	cacxO6pveK3r5X24BGZOIMmOThlKnKJRnaoEgwldVNhQhTpodApaaYGfDa2yFWA+FtUpPblgN9gRw
	QWkjTwnWqNUnpntbN0cmSVQhrSHvMaaHHDS6HdcbL8V9yxhod6xNiGMkgo0mhQMkAZRMG5/yfMbxw
	wyRSclER1MwDaA9EXWI0j0CHrcI6fkqjnvhfixz9YN7OAPjqETa9cXTejBd1A7ECWXg+lujA6VmdO
	sfMzxZvp1Y+zeHj/khd99kxJyHfU+xYixnhj2OT2gQUWkhRkJKd/t84TXRTvh4CZeDBx41+DVTXvm
	mEmdQQaA==;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by mx.easyname.com with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <hello@peppergray.xyz>)
	id 1wKvPX-0002Na-A5
	for selinux@vger.kernel.org; Thu, 07 May 2026 09:52:53 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so981338a12.1
        for <selinux@vger.kernel.org>; Thu, 07 May 2026 02:52:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw4xPh8WZqhFqSWDPJuUZv5EiswjDCq/bt6L5ncQiUOuD1mAduM
	3T3mrDlSgoH7LdJY9jl9e0AHfJsUKtf1sf7P/+oGXu3G8S0Tnr/yRiGHPeRbc+AMClo863fVuHh
	PVaX4PTiPBEBRPjAnBedHQE0uyLPhrLmDF7bVwvsrQw==
X-Received: by 2002:a05:6402:5411:b0:67b:89f5:26c7 with SMTP id
 4fb4d7f45d1cf-67d64c902a0mr3594302a12.26.1778147567086; Thu, 07 May 2026
 02:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pepper Gray <hello@peppergray.xyz>
Date: Thu, 7 May 2026 11:52:35 +0200
X-Gmail-Original-Message-ID: <CAHLDejxHRvHPWYK8q-VO4_OpEozY-4bKc4hSuFL6SL6o=JKw_A@mail.gmail.com>
X-Gm-Features: AVHnY4Lu4mqpKooC4OAiKdmlj4fg-HdxfJ56tfqvTLalUNPpOlMqqfGElG8Em9A
Message-ID: <CAHLDejxHRvHPWYK8q-VO4_OpEozY-4bKc4hSuFL6SL6o=JKw_A@mail.gmail.com>
Subject: [PATCH] adjust audit2why map for python2 and 3
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 3cd62189af93997ab5ff58684352af38900c7758 Mon Sep 17 00:00:00 2001
From: Pepper Gray <hello@peppergray.xyz>
Date: Sat, 11 Apr 2026 19:33:07 +0200
Subject: [PATCH] adjust audit2why map for python2 and 3

align conditional python symbols creation and export

fix: #461
Signed-off-by: Pepper Gray <hello@peppergray.xyz>
---
 libselinux/src/audit2why-py2.map |  5 +++++
 libselinux/src/audit2why-py3.map |  5 +++++
 libselinux/src/setup.py          | 16 +++++++++++++---
 3 files changed, 23 insertions(+), 3 deletions(-)
 create mode 100644 libselinux/src/audit2why-py2.map
 create mode 100644 libselinux/src/audit2why-py3.map

diff --git a/libselinux/src/audit2why-py2.map b/libselinux/src/audit2why-py2.map
new file mode 100644
index 0000000000..249f0beb3b
--- /dev/null
+++ b/libselinux/src/audit2why-py2.map
@@ -0,0 +1,5 @@
+AUDIT2WHY_2.9 {
+  global:
+    initaudit2why;
+  local: *;
+};
diff --git a/libselinux/src/audit2why-py3.map b/libselinux/src/audit2why-py3.map
new file mode 100644
index 0000000000..e99b8d7688
--- /dev/null
+++ b/libselinux/src/audit2why-py3.map
@@ -0,0 +1,5 @@
+AUDIT2WHY_2.9 {
+  global:
+    PyInit_audit2why;
+  local: *;
+};
diff --git a/libselinux/src/setup.py b/libselinux/src/setup.py
index 679ea43f8b..9201448f0e 100644
--- a/libselinux/src/setup.py
+++ b/libselinux/src/setup.py
@@ -1,11 +1,21 @@
-#!/usr/bin/python3
+#!/usr/bin/env python

+import sys
 from setuptools import Extension, setup

+PY_MAJOR_VERSION = sys.version_info[0]
+
+if PY_MAJOR_VERSION >= 3:
+    audit2why_map = "audit2why-py3.map"
+    description = "SELinux python 3 bindings"
+else:
+    audit2why_map = "audit2why-py2.map"
+    description = "SELinux python 2 bindings"
+
 setup(
     name="selinux",
     version="3.10",
-    description="SELinux python 3 bindings",
+    description=description,
     author="SELinux Project",
     author_email="selinux@vger.kernel.org",
     ext_modules=[
@@ -19,6 +29,6 @@
                   include_dirs=['../include'],
                   library_dirs=['.'],
                   libraries=['selinux'],
-                  extra_link_args=['-l:libsepol.a',
'-Wl,--version-script=audit2why.map'])
+                  extra_link_args=['-l:libsepol.a',
"-Wl,--version-script={}".format(audit2why_map])
     ],
 )
