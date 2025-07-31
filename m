Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CACC13D
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957355; cv=none; b=ZkeUgvV1K0X1OSWbVQnSmN+2qHEZefxjMC1xEUfEPpWFWr46wFZJNi+SZKlGgwAnll9lgPpBLZ0FKLpXJFIx7MsmrdSOFq9vJmozcUKx95Zo6Bgp1w1D/hwFcEV074fhy/PxgsiI4GwMCB8A2LbBMta2TRI7OGIvifE0bPsmUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957355; c=relaxed/simple;
	bh=L6hpZxksUbbLOxyxL5XJQGcezZQx3dRpE5pyXefKDs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=es2w6+9rZruvC96J9foVZm5gtXV20N5EO0KPF4H60rcHSLbzRRbwrLhXVt1OOVvJa5UoEtAd7dKDIyqQ8c5M8L+i/wnxUTMESEZilzlxBKUC5wBR7RjrDw0rinfRu18ih3s6tutoWE4ZcFdZhUO9BrrT5NtEt1BhrK67glpKgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGBGOent; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGBGOent"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45892deb246so1337945e9.2
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753957352; x=1754562152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xhGkizseSjj8M5q6Mt6GM1rQiBQd5VOWaKLd/Qq4Rc=;
        b=EGBGOentcmUpkE7tz8iObpZgwCScXSWzfi5uOemjfQn4DXR8sXtUOPmXXq4rKjrV5g
         msGUPJcg7ax9G9YHKlNIXPLH27RZvfZS0+B+ZmV0K9Lb7abQnPopa7C6EDhD/+5CKJy5
         UhxV8EsgEJ0db/UfEdaOE8dEcI1bCXgxX/qVbAZMcH5nPR8LaM9L5edVvh18nqXo08jQ
         qpJxGZhtKxM+qcmfvDjl7t9rR1QfxFXjlLyU7GISNPjnlSFfB7XQjaXhMm6xaLjGnKcp
         yohvD6EK/WT0NfJS68jc1a3AKmRRVTPXzdA5+hrwNH95TUxvuOdK0FGXjczKJBhFKk3k
         P04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957352; x=1754562152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xhGkizseSjj8M5q6Mt6GM1rQiBQd5VOWaKLd/Qq4Rc=;
        b=JcfmSY+QQ5w1RhYiIBSdDV6ep0D/um0bhRKHYh7vHwiDMjrHb/p/tzFmAQZAOVGgon
         vClT/FrlEh0/bo8zbZdim9HdL7wzYfecDa74QsfN2qth5TwAQy0fPixn9aStGHJHmu4o
         obacVU2oU6lCBnuhHfoOarZzzgqgp74BdzuG5Dw3FaSbGJ8hdoHecH/NKYmpyVf8iu1V
         wamJu3T/ajb7A0KJpTn+kn8829t3m22VsoLseJQaROZV9JpCTxUzsK3w5bXlpqAgsdsM
         vrYIVq4a6Iq4wGUaRqcU6rubJiiv87dePlCkeBEVeA43Zh2dDqlhXYK26HsfraEUIV6a
         eW2A==
X-Gm-Message-State: AOJu0YzsggiNozj5hW7Cx1YbY8EVCi6jGjuqZrHjv2e6wf+UlxEULtKY
	1nwxplQHYEcoACZfsB+0Emd0Qn+zpyaUPvL7s+lT05EPgofa6WkK8EU2C8iSPg==
X-Gm-Gg: ASbGncv6MBHpRBQHNNNV0LOshyKcu+4pwhIu7AbahkNCPrfKyD7FWPJWJCcvAR7qi8w
	oGP6YtAsPcoAncmShLFinCL2KxmloI7cOn/PqVGjNdsHxQThs59Ql46rpknBXgpznapFj3Z+740
	nHcCkY90rf1GBD2tCFTVSYLXgiOJRHOgCiF24pvx6/rwpGdBWQRx4QqiicO+hj2bDCoE2r20V8i
	2IrmaIEjW3BCNxEKcEbWkNLgyxMpfZKJ/yg0wi0Df6toxfGOACMWcq2abdYnhopZdkRQKaEc7Nu
	4lF4P0KAi24cKazb1/m0C5xSKni328qgfMWEziIugFWdL6ea87aQv76EuKR02VtVlyGrMQdsDwi
	HbGA9m3xB0ZQ6
X-Google-Smtp-Source: AGHT+IHNFa7nU9j8ugrD5PxyQQBiV5sl7EBLr7EaR0THdMHqQ2UW5Vd36aE4GnHP6f3igtJy9DmdUw==
X-Received: by 2002:a05:600c:4443:b0:456:285b:db24 with SMTP id 5b1f17b1804b1-4589eaa6e95mr17529495e9.28.1753957352069;
        Thu, 31 Jul 2025 03:22:32 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953d033fsm63087765e9.15.2025.07.31.03.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:22:31 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] python: fix flake8 F824 error
Date: Thu, 31 Jul 2025 11:22:24 +0100
Message-ID: <20250731102224.1045166-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes failing CI[1].  From the flake8 documentation[2]:

> global name / nonlocal name is unused: name is never assigned in scope

Meaning that a global only needs to be defined with the global keyword
in scope when it's being assigned to; not when it's being read.

[1] https://github.com/SELinuxProject/selinux/actions/runs/16623315767/job/47032933729
[2] https://flake8.pycqa.org/en/latest/user/error-codes.html

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 mcstrans/share/util/mlstrans-test         | 4 ++--
 python/semanage/seobject.py               | 1 -
 python/sepolgen/src/sepolgen/refparser.py | 2 +-
 python/sepolicy/sepolicy/__init__.py      | 3 ---
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/mlstrans-test
index df34e0e6..8fa0c379 100644
--- a/mcstrans/share/util/mlstrans-test
+++ b/mcstrans/share/util/mlstrans-test
@@ -8,7 +8,7 @@ errors = 0
 
 
 def untrans(trans, val):
-    global errors, verbose
+    global errors
     (rc, raw) = selinux.selinux_trans_to_raw_context(trans)
     if raw != val:
         print("untrans: '%s' -> '%s' != '%s' FAILED" % (trans, raw, val))
@@ -19,7 +19,7 @@ def untrans(trans, val):
 
 
 def trans(raw, val):
-    global errors, verbose
+    global errors
     (rc, trans) = selinux.selinux_raw_to_trans_context(raw)
     if trans != val:
         print("trans: '%s' -> '%s' != '%s' FAILED" % (raw, trans, val))
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 10963e81..b41efd59 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -244,7 +244,6 @@ class semanageRecords:
     args = None
 
     def __init__(self, args = None):
-        global handle
         if args:
             # legacy code - args was store originally
             if isinstance(args, str):
diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index c8a3eb54..01a322ca 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -1038,7 +1038,7 @@ def p_quoted_filename(p):
 #
 
 def p_error(tok):
-    global error, parse_file, success, parser
+    global error, success
     error = "%s: Syntax error on line %d %s [type=%s]" % (parse_file, tok.lineno, tok.value, tok.type)
     print(error)
     success = False
diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 2d526c94..3b87a869 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -195,7 +195,6 @@ def init_policy():
     policy(policy_file)
 
 def info(setype, name=None):
-    global _pol
     if not _pol:
         init_policy()
 
@@ -354,7 +353,6 @@ def _setools_rule_to_dict(rule):
 
 
 def search(types, seinfo=None):
-    global _pol
     if not _pol:
         init_policy()
     if not seinfo:
@@ -936,7 +934,6 @@ def get_all_roles():
     if roles:
         return roles
 
-    global _pol
     if not _pol:
         init_policy()
 
-- 
2.50.1

