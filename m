Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1838910F
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660114; cv=none; b=RqNB+pNW0lZWo78whXo6yJBiyB4uOGogQUG4Qv0n6OxVytnPpQo776C2gqMx/htrskjNg0U1Q4QV3fdU4k2ExBbfrXDSnltivOlAkpGxnYfj3Nw+yfl2udxS+4Tkyl8xoMiXVVLXFaEvueMdR2sHjj2qnsZYkky4mmztODR2l3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660114; c=relaxed/simple;
	bh=/0Rx4hr0wLcyB+15aBxnqfsWddK45K/F1OWklIQdNsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxzo39hyhd2e4jP2mKTMRMc7rPNHQO/8z/SfZRw26nVMPOFrifFDqWKcy8ivq0uYCGe9zjyLUIYTmz7Lpbd6vTIln1OgejhsJEVctI5FBV3uF+5/Yces6ahaISKmbtyWa7eseYbDxV1zpNHlOYpYdMsbbRdiWZcb2obC5U1aOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgREEqdL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgREEqdL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2a449c57so117789451cf.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 11:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784660111; x=1785264911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gfoiPuOPu0j3XcDroZRybpWJbp2e7/Npu+K+/Ql+5+c=;
        b=fgREEqdL7t3hLPbpDQ5wS88uf9rnL3diDHvFkS4WAKIZGRNE1px1fCP0c7WkQELZej
         7D9zeSyDJfroTE6LQCT7loWaajXkD7BzozHyMkvCHGwVrZCfp1m3Lgib/wFxuWI3mbKu
         nmH2OucGDof+WRdGjQ7OM3iJ1/PsBwWWJOsyY6ulBEHYVgNTcLnLbS4n0637xxYe3Jp4
         KI596CWrDIvCpI2GclNbO8I+Lh0w/YCVbswu80ldmMtyC5OkyqtOyTeHOhth/XFGGr2+
         C7+VHQ8Tqrb9Sf5ArzQBl1LdExtOUZNj1hcZy5WsGQyeXYkiH/y9Voz27yDNe/tenekD
         a7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784660111; x=1785264911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gfoiPuOPu0j3XcDroZRybpWJbp2e7/Npu+K+/Ql+5+c=;
        b=FANz18uF+D8CccRFSA2W6aBJ2SOGVTFvhnzh2OG+XQA3mJBdAOm9aiHFe98lgiuLW5
         /yP/XFOLubSHLf0GJOlTwsed2YBDIUupMA2kpeC3Nfg48UYtWPUpwO3ZZxisQyOTiZUj
         kWUURmGwrj7vpHSO0Fd3oLI81oo6Kn97FAKFPlXonvlqmxJZ45C8HTxh0m735TECbFgt
         NR+xJ48DCF5ALqnl1iNRKWPKOIm68I7xlAXcpleaAbJdNnYEtp+2SUoXErRss+qkzEaW
         DAzlPxa6YGjtLAqbFAitpc6bhtLJMirEH/Xw19H5MXSwen7Kvqiq42IplotMO4HDm3e9
         8Y9Q==
X-Gm-Message-State: AOJu0YyQBw5jqmfOBXR72eqj9L7CFSv73QHvwsoPnT1WBzJC9dKcnpIk
	4d7qiLabvsph0/bc+b+pIGcwqNS6/oEtu2m6EJ+ynItcpwDTwsHzYIqgGWrKIg==
X-Gm-Gg: AfdE7clTbsEvTlA936fcS5hFUkQLd8lB1rQbykiXM5ICqFt+lRQBlxpAk2sEZNLBXrP
	k5Sg6P6bHEUmKeTmd1aTxenukfTYFL96zvH7RhOAie0CUet6ZI7dscQD+v7EaBeAKDQFFWkpVsw
	+Xz5PGXsDmfVI7p3cTeBGeKSglScumNaWdGgCtQb5oj54QuIpjUTyE9udUqI0KJXwB6uAXYHNdM
	DgWMjmRdYsgTzqkOC/LX+sd0MDKtP+nbTFUVgKzgXoZeCaRaHkWKG/9nhf2qRYJGCPxneOL5ZyY
	p3hB1VfYfmRh4NA6oqUFEvEsvIHvHvayChiSvoC90iSu/ibhGPueUG1CYgzyMDj2DHT/Q9oI6dA
	ZZs/1VyS9jr9Jkt1oJBnfyN0y/6i0BLhWT4/zN3Sdzg6nHK8d0fifZuVNwy4nZzLKdv7YghjpBA
	kqmGE9WG3jeAvvtnH6JnjBxMBW/wK8yoc3UEA6UbDadHUKN6skMZI+Y0BCOwZxrlvcfLo+XQ10d
	sDnzQ==
X-Received: by 2002:a05:622a:87:b0:517:8011:3a4d with SMTP id d75a77b69052e-5213c7e4fc7mr186140931cf.20.1784660111445;
        Tue, 21 Jul 2026 11:55:11 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d402cb05sm739601cf.31.2026.07.21.11.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:55:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	cahu@suse.de,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] libselinux: add pyproject.toml file
Date: Tue, 21 Jul 2026 14:53:56 -0400
Message-ID: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pyproject.toml file for the libselinux python bindings.

Fixes: https://github.com/SELinuxProject/selinux/issues/505
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---

NB I don't understand this sufficiently to fully migrate setup.py but
hopefully this addresses the issue?

 libselinux/src/pyproject.toml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 libselinux/src/pyproject.toml

diff --git a/libselinux/src/pyproject.toml b/libselinux/src/pyproject.toml
new file mode 100644
index 00000000..dfc44e81
--- /dev/null
+++ b/libselinux/src/pyproject.toml
@@ -0,0 +1,24 @@
+[build-system]
+requires = ["setuptools", "wheel"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "selinux"
+version = "3.11"
+description = "Python bindings for libselinux (SELinux userspace library)"
+readme = "../README.md"
+license = "libselinux-1.0"
+authors = [
+    { name = "SELinux Project", email = "selinux@vger.kernel.org" }
+]
+classifiers = [
+    "Programming Language :: Python :: 3",
+    "Operating System :: POSIX :: Linux",
+    "Topic :: Security",
+]
+
+[project.urls]
+Homepage = "https://github.com/SELinuxProject/selinux"
+
+# The actual .so is produced by a custom build_ext (SWIG + libselinux.so),
+# driven from setup.py.
-- 
2.55.0

