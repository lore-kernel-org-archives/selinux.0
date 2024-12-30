Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214111C32
	for <selinux@vger.kernel.org>; Mon, 30 Dec 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735567536; cv=none; b=tk2QIazjK8EptBP7Mo9D8sStnJGVJQUBeQGb01BO3nM9q/P104Ffzr+8ni9x/GmQLslvmZEvGEgh0XzGM74XhUmoEgvailxoK0KdPl6qpqWHre9FNUqMZK/zRePqrFkPx4mXgNz210d066OJ7qSiL1fzUy1UJCOg7AfHTz6YTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735567536; c=relaxed/simple;
	bh=7zt8iorEmIE3g8IPmjce1JcNR/LW0FwGKanFwx8DCIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kvCH3nvYA6uT0eh2Vn8kxl8u3DU8MoqQd9Gm49vfNtRx+jzYGE2APLOvHvJGPDps+e3oIfERigM+1haLzTXbzWUJSqfszN2tDfV2F/d589wpjoaGv7KkCpMIPXat+UaLNRfGtm8czK7YfJ5Ry+8Hh/MMuDkqTf5P/MNn4R8//uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=BEWmsNF+; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="BEWmsNF+"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1735567530;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=q7s7M5oHeTmJqWb48Z2cOEY0xgteRz4my6g5TanzvOA=;
	b=BEWmsNF+GUnHrSZo/XvfYMRuhpiD5vgAHVM799bNwlzMfj7R5KPWX5Y9maf3M2JhDaxp9m
	optP0naBnkJ6GtjmoBidoW0VR4+SurNVmk2RXJut69UP8Y3yXmEQYZKmiWYGwB4mK5/Gyo
	smwn9heLEi4ayX5qoJfq4rBGrGhPwo3DzRHoS/6SZbEaV+fdZq9bfdnEvZkBCOZPSVOSyo
	bhKGNcH/3AOXOviPOfk6Y5k1SgMo/Z1Mtfj04BFLI5+zZLoCm9Zn4iufSnknaZjARFXAY0
	MHx6/mKFkL2uECL17Af4F7F4YQzISO/AHrozZVtBXc7HsJvU+V4s69dZPMIBXA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] python: fix typos
Date: Mon, 30 Dec 2024 15:05:22 +0100
Message-ID: <20241230140523.60053-1-cgoettsche@seltendoof.de>
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

Found by codespell(1) and typos[1].

[1]: https://github.com/crate-ci/typos

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/sepolgen/src/sepolgen/module.py      | 2 +-
 python/sepolgen/src/sepolgen/objectmodel.py | 2 +-
 python/sepolgen/src/sepolgen/refpolicy.py   | 6 +++---
 python/sepolicy/sepolicy/sepolicy.glade     | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/module.py b/python/sepolgen/src/sepolgen/module.py
index 745364cd..b7d64627 100644
--- a/python/sepolgen/src/sepolgen/module.py
+++ b/python/sepolgen/src/sepolgen/module.py
@@ -111,7 +111,7 @@ class ModuleCompiler:
      .semodule_package [string] Fully qualified path to the module
                    packager. Defaults to /usr/bin/semodule_package.
      .output       [file object] File object used to write verbose
-                   output of the compililation and packaging process.
+                   output of the compilation and packaging process.
     """
     def __init__(self, output=None):
         """Create a ModuleCompiler instance, optionally with an
diff --git a/python/sepolgen/src/sepolgen/objectmodel.py b/python/sepolgen/src/sepolgen/objectmodel.py
index ccce86c1..29c18ec8 100644
--- a/python/sepolgen/src/sepolgen/objectmodel.py
+++ b/python/sepolgen/src/sepolgen/objectmodel.py
@@ -59,7 +59,7 @@ implicitly_typed_objects = ["socket", "fd", "process", "file", "lnk_file", "fifo
 # to and object ("write") or to a subject from an object ("read"). Read
 # or write is described from the subject point-of-view. It is also possible
 # for a permission to represent both a read and write (though the flow is
-# typical asymettric in terms of bandwidth). It is also possible for
+# typical asymmetric in terms of bandwidth). It is also possible for
 # permission to not flow information (meaning that the result is pure
 # side-effect).
 #
diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 32278896..78725397 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -324,7 +324,7 @@ class SecurityContext(Leaf):
     def to_string(self, default_level=None):
         """Return a string representing this security context.
 
-        By default, the string will contiain a MCS / MLS level
+        By default, the string will contain a MCS / MLS level
         potentially from the default which is passed in if none was
         set.
 
@@ -333,7 +333,7 @@ class SecurityContext(Leaf):
              empty string.
 
         Returns:
-           A string represening the security context in the form
+           A string representing the security context in the form
               'user:role:type:level'.
         """
         fields = [self.user, self.role, self.type]
@@ -609,7 +609,7 @@ class AVRule(Leaf):
     def to_string(self):
         """Return a string representation of the rule
         that is a valid policy language representation (assuming
-        that the types, object class, etc. are valie).
+        that the types, object class, etc. are valid).
         """
         if self.gen_cil:
             s = ""
diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
index 30e7b03f..a9e4cb3a 100644
--- a/python/sepolicy/sepolicy/sepolicy.glade
+++ b/python/sepolicy/sepolicy/sepolicy.glade
@@ -235,7 +235,7 @@
       <column type="gchararray"/>
       <!-- column-name Label -->
       <column type="gboolean"/>
-      <!-- column-name Mislabled -->
+      <!-- column-name Mislabeled -->
       <column type="gboolean"/>
       <!-- column-name Cur -->
       <column type="gchararray"/>
@@ -392,7 +392,7 @@
       <column type="gchararray"/>
       <!-- column-name Fix -->
       <column type="gboolean"/>
-      <!-- column-name Mislabled -->
+      <!-- column-name Mislabeled -->
       <column type="gboolean"/>
       <!-- column-name Cur -->
       <column type="gchararray"/>
@@ -5538,7 +5538,7 @@ s0-s0:c1023</property>
       <column type="gchararray"/>
       <!-- column-name Label -->
       <column type="gboolean"/>
-      <!-- column-name Mislabled -->
+      <!-- column-name Mislabeled -->
       <column type="gboolean"/>
       <!-- column-name Cur -->
       <column type="gchararray"/>
-- 
2.45.2

