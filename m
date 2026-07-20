Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB41426AC3
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577187; cv=none; b=QYkjvEA1QGr60qGC/qmOkT6xnZChFlv/lw0gTgbAS1zZYxyGTlbosVLGJfFNGbDEgI5+f2V/7Q8ddjRY30bCT2AXGFCCuvbYPTPhXTerWuM1/lwSRAYLsxZ30Vh5QSE5XrMq9mCND9+TzaXqk6YENM2uOCQkAWWc/4+UZ1TAAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577187; c=relaxed/simple;
	bh=ODpMSta0SqLzhWlYx1YRWru6AjbiYvv7ucOkOGqm1nA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAuMmX9aJPHwYMmqvDEoUWfEDwNIEH7+xskQ6GiV2Q91dcQy+8GCBawHIvq84JEs6pHW5nwZ3CnSZV1po1z840zpMo6FaN1Bkq7gJ54hQrHx66ELa4OPdG0Ia2EoqEN2UKmNtq5coP515FDj2hY41VKdISs4UhZIddeqfj60j0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tApNM6LD; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tApNM6LD"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51bfad59921so92415481cf.0
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577183; x=1785181983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QdjnM/oUlScRhGA1vwsLf2qkyuK2dDmSfHHHFEZ8weM=;
        b=tApNM6LD65oIW7V/qOUPuV+W1uZB5Z4E7QGAOABTMx6uckdRTGNaaZzZtQrguINW5U
         wRXbkgzZMlrnFiwh4XQsUJ4QYxa1nON/R2HwwZ7LQ/fIF22/5ldkc+UHIKeRJpnDWxKg
         4nO+ojCfYp7Th3JOYwPGsE0Y7vvChx13+PNKtA2nWhzZVQwu8C5eHwP1nTu98D2ju+Q2
         wy/XVJkH0B6NWr18Sr0u/FYMYbZ1praffrWD8fT7aeC1ci2nQmcRY4D/j8uuQLCLqiI9
         shuvaE0rLNQVzB1WsxRybRLFBgA0asR38nUEx5ovxdkG5kA4Dh7GQcFJsP5x0Lk6YzNY
         cB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577183; x=1785181983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QdjnM/oUlScRhGA1vwsLf2qkyuK2dDmSfHHHFEZ8weM=;
        b=FvrBBPVVLzyLcuUyoBjTS/kA+Nl+Lb8F6Ssk6LzjD59Wgc7v3OczDWZ4iLpP40W4gy
         Qiz5VV+8izA8oAM5aTTy0Rlf+E3p7maDT4GwZOIVThf9+OCRQMjBpjTYZ836WWgKfqzb
         WJERL7TnH2AKV8DN81tPx9KTylsfvmqJUuH3RKadmiyfwIY9Fy8vzOIeovhgHYof33Za
         bJw7ulVH9uFduDiTgbIMmlkKHXx0SY+9pHR4eobMkV9ZjJt2OglWQUdnjaekz1Fv5O0t
         MVoyPaZSKvoShqnPA0O2Wn3pzN/vDVDXtHvLEsD4RXTvnVOzTWJrKt9j0BxibpwAURbV
         /9LQ==
X-Gm-Message-State: AOJu0Yx6sCxA4DNBhQ6WEZGUXFtZFPmerUsQXTlLvq56TNcGqbZO3yDc
	e3SqEdPN1K0qYE52PqReypzfDEhAwM9BJ02zlpD7sm1VEsY0L9e1Gyr0LcPZxQ==
X-Gm-Gg: AfdE7ckaUWArnufXIU9JvA04T+yLk1EJviS5sYWU70H9edpxuLOCO18I4cUgz9W8KAd
	etqOruF8/LLolZv5+tN+4F67yAKzmts+1rTeqR0AqL5r34ooIn7q/TaNukg53D7ju/hZL0/PShs
	xGwUxyWKxw5caak3ssu0xVM/KRZ3h0HnN322GKy42gwr1NZyXl99gjOKRb4iRS3rsGLOL6/dQ1+
	Jn+7G40A1zU2E7fYSzkdk7Ib7tw0g7GGhEk4y3Y/trC/SYKnN6Jq+zgXSmjIx2ZuTxPorvvMnb+
	8GUKntBhrKXHHwiWHVRCCweIhzQ+yECMRSp2s0Uk/id5yJtyMI9LiBQYF9xhgTLfdf/Lof8SHO+
	u+S6yHVXUiKkX6J7V00KP1EK8X9K8jY2H4z3T8HZGVi8PB9cXDJTl1APfiph/723L1sinaKm4HC
	X5sbxTY+6n4LYCYRTGGnkFDHjyCVyDtZ50ghELrbOEpSsHkO1BDaFj6awkt22ZJwlMy9W4xfI/z
	m8bhA==
X-Received: by 2002:a05:622a:4d43:b0:51c:21d1:3862 with SMTP id d75a77b69052e-5213c008228mr147637411cf.8.1784577182375;
        Mon, 20 Jul 2026 12:53:02 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907785931e0sm99246786d6.21.2026.07.20.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:53:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	pebenito@ieee.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] python/sepolgen: port policygen.py to setools 4 API
Date: Mon, 20 Jul 2026 15:52:46 -0400
Message-ID: <20260720195247.49762-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

policygen.py still called seinfo() and sesearch(), the setools 3
python bindings that were removed years ago. The calls only survived
because they sat inside a bare "try/except: pass", so the "source type
can write to..."  hint in audit2allow output has been silently dead.

Replace them with the setools 4 equivalents:
- SELinuxPolicy().lookup_typeattr("domain").expand() for the
domain attribute member set.
- TERuleQuery(ruletype=[allow], source=..., tclass=[...], perms=...,
perms_subset=True) for the allow rule search, expanding rule.target
so attribute targets are resolved to concrete types

While here, cache the loaded policy on the PolicyGenerator instance so
it is not reparsed for every access vector, drop the wildcard import,
narrow the bare except to setools exceptions, and dedupe/sort the
resulting type list for stable output.

Fixes: https://github.com/SELinuxProject/selinux/issues/332
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/sepolgen/src/sepolgen/policygen.py | 41 ++++++++++++++---------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/src/sepolgen/policygen.py
index 7715bed5..a5af521a 100644
--- a/python/sepolgen/src/sepolgen/policygen.py
+++ b/python/sepolgen/src/sepolgen/policygen.py
@@ -26,9 +26,9 @@ import textwrap
 
 import selinux.audit2why as audit2why
 try:
-    from setools import *
-except:
-    pass
+    import setools
+except ImportError:
+    setools = None
 
 from . import refpolicy
 from . import objectmodel
@@ -85,6 +85,7 @@ class PolicyGenerator:
         self.dontaudit = False
         self.xperms = False
 
+        self.policy = None
         self.domains = None
         self.gen_cil = False
         self.comment_start = '#'
@@ -206,23 +207,31 @@ class PolicyGenerator:
                 rule.comment += "\n%s" % self.comment_start
                 rule.comment += "\tPossible cause is the source %s and target %s are different." % reason
 
-        try:
-            if ( av.type == audit2why.TERULE and
-                 "write" in av.perms and
-                 ( "dir" in av.obj_class or "open" in av.perms )):
-                if not self.domains:
-                    self.domains = seinfo(ATTRIBUTE, name="domain")[0]["types"]
-                types=[]
-
-                for i in [x[TCONTEXT] for x in sesearch([ALLOW], {SCONTEXT: av.src_type, CLASS: av.obj_class, PERMS: av.perms})]:
-                    if i not in self.domains:
-                        types.append(i)
+        if ( setools and
+             av.type == audit2why.TERULE and
+             "write" in av.perms and
+             ( "dir" in av.obj_class or "open" in av.perms )):
+            try:
+                if not self.policy:
+                    self.policy = setools.SELinuxPolicy()
+                    self.domains = set(str(t) for t in
+                                       self.policy.lookup_typeattr("domain").expand())
+                q = setools.TERuleQuery(self.policy,
+                                        ruletype=[setools.TERuletype.allow],
+                                        source=av.src_type,
+                                        tclass=[av.obj_class],
+                                        perms=av.perms, perms_subset=True)
+                types = set()
+                for r in q.results():
+                    types.update(str(t) for t in r.target.expand())
+                types -= self.domains
+                types = sorted(types)
                 if len(types) == 1:
                     rule.comment += "\n%s!!!! The source type '%s' can write to a '%s' of the following type:\n%s %s\n" % (self.comment_start, av.src_type, av.obj_class, self.comment_start, ", ".join(types))
                 elif len(types) >= 1:
                     rule.comment += "\n%s!!!! The source type '%s' can write to a '%s' of the following types:\n%s %s\n" % (self.comment_start, av.src_type, av.obj_class, self.comment_start, ", ".join(types))
-        except:
-            pass
+            except setools.exception.SEToolsException:
+                pass
 
         self.module.children.append(rule)
 
-- 
2.55.0

