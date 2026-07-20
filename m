Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE443FB7E1
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576094; cv=none; b=QrctvWUjdNQ3TQIf3ft09EAIPT5Yz7DmI9gxISvHgSMnOtPwAsXZYDGk0XeyAPUyx9asqrik1XaNmHYjQLLqWZU+cshN/0HidzKpW1aibn3Aqrx811ZMH3yaC0bfOocy6lMarC3ZmW37d5IqwoKYbNqXyU8Aq7E9tijp/vlVajQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576094; c=relaxed/simple;
	bh=Pvo9gX6AyztH7tdUYlsHmqvKbZf9OJkA4PFwemc8IXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTTaS4GdwEjQN+eY+WjpAsJJ0mD7FIJ/AOXlt3oCbTphw4e1RAE28ipe3T4cihOzgS2Ia/5tuNQyV9OHVnRJDnNatxKEUPF4sODTpeAGK/THrnufp5qXVV6jQs3rKnSpVNQ+kMnO8GzKkYXPEeomWcLAZ10dcDeosrh4DEkwPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7vC2Cr1; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7vC2Cr1"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e5c92c389so689262885a.3
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784576090; x=1785180890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GgU7oEluQ6mzwstAbqUDcZz18uEL5ctIps+ZteKHdfY=;
        b=B7vC2Cr1FDXKKtLT5juSyK+gyRz9XBpDsn29+UuGYwhGNex3q8Bu5UQw0oFuX/iGid
         jGDzrB5lRAqXwldCtmSSIM8ChLOJB7BvwF6eSZbw+UmlhP1USfeHORJbjt8Wwe3lYAux
         ohOQCm24SRplwvvU4MEwk9MarLSYLbo3Ah0yjuOLq2L4h+qBjSyzmOZdpKYRmSRrsBqM
         6ZgTFI8ssVVpYMxEw9d+SFsF/nNte3r1+4JwRhyF0o02pEYXP3xHnLM8kGY+mLPTuqMq
         UyhMzvzDfkyNlzcNaOVa+FZq+1xxjUy9UxsoxY0w8Xc2NXWRjiCpeNyTVG3YY7fTLAve
         2LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576090; x=1785180890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgU7oEluQ6mzwstAbqUDcZz18uEL5ctIps+ZteKHdfY=;
        b=s+4CYrlR5wSbgXionzunDvmdhJmDOCxEB0YxUJbZ6vA83ThZUvx6Y0AhSyF/Y5tZOS
         vuoxz55pizzKsfP3aWe9/DrwVJ839hCUS8WlCqn9iFjsmAMx26Nj3V17g3r4+Jza6SRZ
         fzdyqCbcKaIe39RY74JHEC2OdG/sIs9RvyL2qE1MOSvNBkSvW66Xdr+/z66VwFsiSQAZ
         8KfdFGE/4Sj9Z6WfxSVgAsVDoszcNw1l5G5teq1gVwlp0vH7PaOxChuCLCY0S28aWUG9
         cW0GigeXTBs/NLty+oRLCCIKWDTWpPQYbQB7BvmJdOENmLTXCAF8TgN/VRWOk1OS0hRG
         lCKg==
X-Gm-Message-State: AOJu0Yxeq5GsKlwhTZoocwqGTiQcZol/6qQK+rPvNmsOA+hF5+nBUEXc
	Dvk+Ife2lVHjkUH19kuqeWouUsNsqIcK3TrSulP5j8DNWp7lmbwhofTjF+tUlw==
X-Gm-Gg: AfdE7cmUakV1S3AHLmYVo3707TV0GWnZ6dp2DsCxlhPKSH/MOSOcgsCHVyOlSRkbTtG
	B4Dv6bVc7D5SKJnPJ587+Tt58gOpY3aQfFzA24ZrMM2yc3D1+9kEcTZn+pwgp+G5SYSZDL8cwJt
	ogLnVoQlMS2lXnRjUI+2rxpjPeESbLqtDZYlTRuKLqC+hccEZ109Ve3fRZGHeiImoAKgTabwcMc
	K5LtZqQFt8AWYMx2wPvbjxhiiwFictCKbDCtPtWii7a6msXTNDHrXWyqlv9qKhwF17X91mGL0RP
	nXW3HSvwr0kLsNGLH3PqsWl3BQErLT8wGcEcnWCPM2QLXcEVY6x/rSQfRxkGm5MDOy+WB9A9GYq
	IxzwBZAJVvkaJSFEz2xpr3SinrVGAVOT51P55pbE27QoRvUUkOcNIsm0gMw+AdW+WwYfm5p2F6O
	VgNrRZzv+x+5Ro/Dw8W/839fYZ35ATiJOjtHeYgaasrVVQ25SOhFgCjtfnZpIivv29AbdR0EUqt
	tDLXQ==
X-Received: by 2002:a05:620a:19a2:b0:92e:f16b:1b64 with SMTP id af79cd13be357-930b43531ebmr1566005785a.88.1784576089877;
        Mon, 20 Jul 2026 12:34:49 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5300432sm942488385a.17.2026.07.20.12.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:34:49 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	pebenito@ieee.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] python/sepolgen: port policygen.py to setools 4 API
Date: Mon, 20 Jul 2026 15:34:26 -0400
Message-ID: <20260720193426.48519-1-stephen.smalley.work@gmail.com>
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
index 7715bed5..2475ccd3 100644
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
+                    types.update(str(t) for t in r.target_expand())
+                types -= self.domains
+                types = sorted(types)
                 if len(types) == 1:
                     rule.comment += "\n%s!!!! The source type '%s' can write to a '%s' of the following type:\n%s %s\n" % (self.comment_start, av.src_type, av.obj_class, self.comment_start, ", ".join(types))
                 elif len(types) >= 1:
                     rule.comment += "\n%s!!!! The source type '%s' can write to a '%s' of the following types:\n%s %s\n" % (self.comment_start, av.src_type, av.obj_class, self.comment_start, ", ".join(types))
-        except:
-            pass
+            except (setools.exception.SEToolsException, AttributeError):
+                pass
 
         self.module.children.append(rule)
 
-- 
2.55.0

