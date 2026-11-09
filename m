Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237919;
	b=srVjOVkk9Pc+S4RMqQDoJPYuudDCFE27KcyHIx5rqQ5zdpV6o7vOLFVsw0i7ySazvmGB
	 RC1TUOmWvAD52vnVhpDs5PUYKNsEwmwNs+e23U+x6aQf5KRlERaV4E9IJJfZZU2ERKBs1
	 Gy/w9h8Xl+kZp09b3ctky5sZztya2DGwhd+hnkO4TLl7PoyibIIGlZyPrndUi/1Vaj4Zk
	 t+BR0PRJE7i4JkgsoWfX+LRTJ9F+QfbXC7PYEYZGwXdNhfGFnz62zA9mJSMHgi9re1OtD
	 1kjP5G7Eg3jLdy79YwBUiwPK1K/+PCPKKcvsICR3EAcJDRflj5TR3ABCFbOyHjU41Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=s9wN64PtUvXhnvW9hj3C94/kv4lfhxO9dkGy9dfJwys=;
	b=u/FtDc9E8ZnTK4IrPrE/NTdfNhmwGPw/2M22mFSXz/0kSjy3iyFjthRrkv0IBQqFpIi8
	 oK9kQ/MuShR81qXuNluQUDDB2O8ElYpxkzHcw78LJJIH0dzWRhmrzdYphYfgt5QZrbwqS
	 qGEiotLq1qRvaMqv+1A4usVcEH0ivI333EUZ+7QFjfv/YIybUD+JPhBJi8cYp+HON4f1z
	 wu0rHt7gWk59zo5ETy4y/v/D2uJXubVdNtoGrb3/FlyDsmx4wfYC7k9tZMj/GBTEU89An
	 gRRE7edHePxxXGST5asW///JdyOpy6wEmoZmr2kEY+2GvT3w9vx0qYdP0BMas3vNScQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jCS6444+;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DBC606A31C
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44DBC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jCS6444+
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91ec2d42231so10758116d6.2
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 07:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237918; x=1794842718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s9wN64PtUvXhnvW9hj3C94/kv4lfhxO9dkGy9dfJwys=;
        b=jCS6444+L1/2gmOZUxEYhbGLoR3fdVWhblC1U/pl5AlIg8LJ9ewElZ/I/LcxicMDTl
         d5+tbDdyq3VXO1+bssJgmXz4BifssaKhcpEnrkXFyXi39nr3d5dHjRPw29iIVQVEydRR
         Ig1rlpV1xzuNeHhPZ+izymmGfGQxdOU8RnMyPCziS2tvXpb/+lpmIX1VXMc3BwUekxQc
         SPl8KmpYTX9n9XI6Vr2mpwDDN80SQiOW24eo2/UBQsuBK58wq3e3xnxQmhlpTacnMjAd
         Wk7TeperG/8iM07SZK3fdEyMDT9d2wMKjCU3PjGtBIMve4igdQYjKpy19rzCQKzfibcR
         XiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237918; x=1794842718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s9wN64PtUvXhnvW9hj3C94/kv4lfhxO9dkGy9dfJwys=;
        b=LFedaGtCHeye92aIx4I7sd4sDrch9sSGfmUI3BRTxaFhUeWXzBp9sJb/TuvVUcPc8/
         G2IbPClfrQIYN2iabNMeql+WG5MGtxAXDLcTQNwk24N/S0BNl5bkxPVQHMdPs+0J+ZBN
         jjzf72TjO8q8z0w/1PKhHIchZ/irMuWPCcOejHwJ2P8BaCf9YyI4YkbJX8Lr9/jB2WTf
         eqjr0e1mwFE+75JXqbh5Ntx7wdlZIMPjsdjqjZhMRau65ndGShh0aoxcYE8uHfLvbmPX
         cgUOkhUU10CzV6yKoDnDOcOcrWr0mBaN2V7MC747Pyznhl5NaenPiKDik8gjCvTrxF3C
         nxhA==
X-Gm-Message-State: APuU4Z/gSqbIfNIFbxZo6Ffozyt3DbbNX/ljeBjwceJNwegPdecVoMTq
	Xo/ut/7iKJUcUX4gW9pfWzcB012t9vrHvAo3+g7CSIopsbIKaCyNz/ZRnTu4R4mj
X-Gm-Gg: AYBFou3BrEcrmCHx8BExdRYpo2yy1x/jTfO2j36QHTWNZmdRuLiMN8+9CGhMFziEW5M
	UVkvnppvxb6bR1Sdf04dzOm9JuvYIJfEoS9AlK+PSlH4X3W0GUaSqtJoiKikSbFqFLkWAuNqxBl
	UHOT75FKBDYEXB0nmGXLwraGpp6dcFFa2hKg8PUkxjFxkSsZCjl2jRIy+KM8G2QRM94V0Ce+fm+
	NqfJZkMq4YIpls5btj6foK6+T02tu5pB8MIzZdM8EOS9RjXAXBpEjUpCPmmI1yBmbyGLokxK4U+
	8W7l7LbxFFtqqXchdyFXvSEPOSclRyvQIudmwNAPdn0VaVxpChF0jwShBN30GWDHn4p58Durxpi
	2oA/LJZyji7/2GbBqDtcdfC5SyVisbixA0Uzm4mhqaMkdpJLBC9ie7MQx8URvlWcAm+VqpTtb9E
	A0bu14cfi0w0xRdyWFOZoODLoABDFIclIuXRyYh+hwkxvWzz5rtMX68NTHO2fjIV8phMP3X/b9A
	4c7wE8e1B5EESQSa8ZNmOAeUVDPB9WBEOzqyX4RBi1GrTmGBYpfZKCEG1qqqerZUBnPP2J6QrKY
	yASPPnbzX0yesCYRFI0/w/o4ioLZpwejWG+aOx90k81BpmqAv3/k3qGnfKCfuR3yrcgxmXGMXFe
	Yf4AMIc+JOGCpNaxdDXA8UbfpslWHTYA3f3Sdzq024cZqJMkIabyOOQBICepSNW4QujFHFoCinl
	Hhm/VUjPKHsdEl7oiDZMMfmkCp5jMVKGnmiwNEBLhhqX2Xcg==
X-Received: by 2002:a05:6214:d6d:b0:91e:89ce:ceee with SMTP id 6a1803df08f44-91ed24376cemr57213116d6.43.1794237917785;
        Mon, 09 Nov 2026 07:25:17 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecee766c1sm44208046d6.36.2026.11.09.07.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:25:17 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	cgzones@googlemail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/3] python/semanage: fix test-permissive-store.py when run by CI
Date: Mon,  9 Nov 2026 10:25:00 -0500
Message-ID: <20261109152502.124123-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stub the sepolicy module in test-permissive-store.py when it cannot be
imported: seobject pulls in sepolicy (and thereby setools) at module
level, but the permissive record operations exercised by the tests
never use it. Without this the new test fails in CI, where setools is
not installed, before exercising the bindings at all.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/semanage/Makefile                 |  1 +
 python/semanage/test-permissive-store.py | 32 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 314fe359..0474390b 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -35,5 +35,6 @@ test:
 	@$(PYTHON) test-permissive-store.py
 	@$(PYTHON) test-semanage.py -a
 clean:
+	rm -rf __pycache__
 
 relabel:
diff --git a/python/semanage/test-permissive-store.py b/python/semanage/test-permissive-store.py
index f8e657ee..d7719a1b 100755
--- a/python/semanage/test-permissive-store.py
+++ b/python/semanage/test-permissive-store.py
@@ -7,10 +7,34 @@
 
 import os
 import shutil
+import sys
 import tempfile
+import types
 import unittest
 
 import semanage
+
+# seobject imports sepolicy (which requires setools) at module level, but
+# the permissive record operations exercised here never use it. Provide an
+# empty placeholder when setools is not available, e.g. in CI, so that the
+# bindings themselves are still exercised.
+try:
+    import sepolicy  # noqa: F401
+except ImportError:
+    sys.modules["sepolicy"] = types.ModuleType("sepolicy")
+
+try:
+    import setools  # noqa: F401
+except ImportError:
+    setools = types.ModuleType("setools")
+    setools.policyrep = types.ModuleType("setools.policyrep")
+    setools.policyrep.SELinuxPolicy = type("SELinuxPolicy", (), {})
+    setools.typequery = types.ModuleType("setools.typequery")
+    setools.typequery.TypeQuery = type("TypeQuery", (), {})
+    sys.modules["setools"] = setools
+    sys.modules["setools.policyrep"] = setools.policyrep
+    sys.modules["setools.typequery"] = setools.typequery
+
 import seobject
 
 BASE_CIL = b"""
@@ -45,6 +69,10 @@ class PermissiveStoreTests(unittest.TestCase):
         os.makedirs(os.path.join(self.root, "etc", "selinux"))
         with open(os.path.join(self.root, "etc", "selinux", "semanage.conf"), "w") as f:
             f.write("disable-genhomedircon = true\n")
+            f.write("[sefcontext_compile]\n")
+            f.write("path = /bin/true\n")
+            f.write("args = $@\n")
+            f.write("[end]\n")
         base = os.path.join(self.root, STORE, "active", "modules", "100", "base")
         os.makedirs(base)
         with open(os.path.join(base, "cil"), "wb") as f:
@@ -57,6 +85,10 @@ class PermissiveStoreTests(unittest.TestCase):
         self.assertIsNotNone(self.sh)
         semanage.semanage_set_create_store(self.sh, 1)
         semanage.semanage_set_reload(self.sh, 0)
+        # Do not spawn setfiles to validate file contexts: the test policy
+        # defines none, and the host setfiles may not match the libsepol
+        # this test was built against (or may not exist at all).
+        semanage.semanage_set_check_contexts(self.sh, 0)
         semanage.semanage_set_store_root(self.sh, "")
         semanage.semanage_select_store(self.sh, STORE, semanage.SEMANAGE_CON_DIRECT)
         self.assertGreaterEqual(semanage.semanage_connect(self.sh), 0)
-- 
2.56.0

