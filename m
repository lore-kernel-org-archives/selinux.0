Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971029;
	b=WdYKEqBHHis+x8/ze/GSbsSBzA6hUIRhKHtvvN7II4zjFOjzoj4i/VrS7bQ3bASWBlkY
	 EBZSOH5Jo7SdZc97UpMNhvDHDsXrQYIrx1D2Cn7IrJvUKE1l/JkTLLYNnq0Updsl0VQ1+
	 EJaOIQzthP0N7WMXtHYN/ZZ8LS+8oTzXRqNKKVO38WDwIyfMijBsj6w32D3BUap6DCzH9
	 ZJYCgJacVY4n7z1xOnp5S5zgRs9Rs0EYn7xjv1vD6Z2yfvtFLgpRmAwrmJ1+ztY+nCDc5
	 zdOq4wAj3S2wCHFoZek5NGsxbMBIeULsqgckpgX4+AH6BLMWTfm2fx2SaGEfPE51adw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971029;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IhKpjq9x7OND2i4YcTN64SXzHE3zuuAipHcSA/k0LY0=;
	b=QG0nOVaSrPmEgW5SUBOWfcrXHAUzLDO5L+CHEexkvx9ERjjxtri2FhB108oSCLDe6LrT
	 srWr+SS7pwPW7IhcNLwg2gq2SwguFZi6MUQznDn1upEVIpY/zohEnM7NFwBgf6PBVdTZ8
	 NgPoz2ByTztRqHF+t++XIxhwn3Tmq2ukuUPlwAEPOKlt+/zX8IRMoKPp9+UyK2W5SNIFU
	 97bDyhV1hldW0nHeWc8JkVQy6x2Ydy87EkOTocteU07mSQFq8pMP3eM1XaPWqchbKaoQ4
	 dSMNDko8/PpKLMjFup8WB+QjKSiRxei+vkrGkTqyu3bRVqDuMHJEf92O9hYUtnZotVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=SX5Nnqu0;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC841606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 13:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC841606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=SX5Nnqu0
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793971026;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhKpjq9x7OND2i4YcTN64SXzHE3zuuAipHcSA/k0LY0=;
	b=SX5Nnqu0NaKwva+dWSDyPZkOnU8N/0jhbE2Op+0qEcp8N7T6/N+Ig0SQKTgdiznpx1JBqz
	LWUw+35L1O5mvPEXTeNbGQ7wpYdG/mDb+RbUHEDImzHNM5Oj4S3Ix8Dnz0wT5h2NoCUHqZ
	+S5s19t4rWeBoan22N8bjZCMteOJd5hQhWlaFlEsWW70mPBHskUTsprymTLGIhMjoE8X3t
	SR+V3f66lioK2RIV8jdDSQYUHYFlJQJw7CAH7i/zsl/GIuYkkc2AKX7U70sSQW4bBdUEfB
	9uXRvwHea8Vw4kICfgQDGKACcY/o5uioqwTRKqjhkbE3ubNl5S/2DsWi/zItBA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] python/semanage: fix permissive add with bytes module bindings
Date: Fri,  6 Nov 2026 14:16:52 +0100
Message-ID: <20261106131652.267648-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261106131652.267648-1-cgoettsche@seltendoof.de>
References: <20261106131652.267648-1-cgoettsche@seltendoof.de>
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

Commit 82c7c876 ("libsemanage: treat module data as bytes in the Python
bindings") changed the Python signature of semanage_module_install() to
take the module data as a single bytes-like object, but
permissiveRecords.add() still passes a str plus an explicit length.
Every `semanage permissive -a TYPE` therefore fails with:

    TypeError: semanage_module_install() takes 4 arguments but 5 were given

Pass the CIL text encoded as UTF-8 and drop the length argument.

Add a test that drives permissiveRecords.add()/delete() against a
private, throw-away policy store, so the call is checked against the
real bindings without needing root or an SELinux enabled system.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/semanage/Makefile                 |  1 +
 python/semanage/seobject.py              |  2 +-
 python/semanage/test-permissive-store.py | 90 ++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100755 python/semanage/test-permissive-store.py

diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 51208d9e..314fe359 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -32,6 +32,7 @@ install: all
 	install -m 644 $(BASHCOMPLETIONS) $(DESTDIR)$(BASHCOMPLETIONDIR)/semanage
 
 test:
+	@$(PYTHON) test-permissive-store.py
 	@$(PYTHON) test-semanage.py -a
 clean:
 
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 36d16858..7e703cf8 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -509,7 +509,7 @@ class permissiveRecords(semanageRecords):
         name = "permissive_%s" % type
         modtxt = "(typepermissive %s)" % type
 
-        rc = semanage_module_install(self.sh, modtxt, len(modtxt), name, "cil")
+        rc = semanage_module_install(self.sh, modtxt.encode("utf-8"), name, "cil")
         if rc >= 0:
             self.commit()
 
diff --git a/python/semanage/test-permissive-store.py b/python/semanage/test-permissive-store.py
new file mode 100755
index 00000000..f8e657ee
--- /dev/null
+++ b/python/semanage/test-permissive-store.py
@@ -0,0 +1,90 @@
+#!/usr/bin/python3
+#
+# Exercise seobject.permissiveRecords against a private, throw-away policy
+# store so that the Python calls into the libsemanage bindings are checked
+# against their actual signatures. This needs neither root nor an SELinux
+# enabled system, only the semanage bindings and seobject importable.
+
+import os
+import shutil
+import tempfile
+import unittest
+
+import semanage
+import seobject
+
+BASE_CIL = b"""
+(typeattribute cil_gen_require)
+(roleattribute cil_gen_require)
+(handleunknown allow)
+(mls true)
+(sid security)
+(sidorder (security))
+(sensitivity s0)
+(sensitivityorder (s0))
+(user system_u)
+(userrole system_u object_r)
+(userlevel system_u (s0))
+(userrange system_u ((s0) (s0)))
+(role object_r)
+(roletype object_r test_t)
+(type test_t)
+(sidcontext security (system_u object_r test_t ((s0) (s0))))
+(class test_class (test_perm))
+(classorder (test_class))
+(allow test_t self (test_class (test_perm)))
+"""
+
+STORE = "store"
+
+
+class PermissiveStoreTests(unittest.TestCase):
+
+    def setUp(self):
+        self.root = tempfile.mkdtemp(prefix="semanage-permissive-test-")
+        os.makedirs(os.path.join(self.root, "etc", "selinux"))
+        with open(os.path.join(self.root, "etc", "selinux", "semanage.conf"), "w") as f:
+            f.write("disable-genhomedircon = true\n")
+        base = os.path.join(self.root, STORE, "active", "modules", "100", "base")
+        os.makedirs(base)
+        with open(os.path.join(base, "cil"), "wb") as f:
+            f.write(BASE_CIL)
+        with open(os.path.join(base, "lang_ext"), "w") as f:
+            f.write("cil")
+
+        semanage.semanage_set_root(self.root)
+        self.sh = semanage.semanage_handle_create()
+        self.assertIsNotNone(self.sh)
+        semanage.semanage_set_create_store(self.sh, 1)
+        semanage.semanage_set_reload(self.sh, 0)
+        semanage.semanage_set_store_root(self.sh, "")
+        semanage.semanage_select_store(self.sh, STORE, semanage.SEMANAGE_CON_DIRECT)
+        self.assertGreaterEqual(semanage.semanage_connect(self.sh), 0)
+
+        # Bypass semanageRecords.__init__(), which consults the policy
+        # configuration of the running system.
+        self.records = object.__new__(seobject.permissiveRecords)
+        self.records.sh = self.sh
+        self.records.noreload = True
+        self.records.mylog = seobject.nulllogger()
+
+    def tearDown(self):
+        semanage.semanage_disconnect(self.sh)
+        semanage.semanage_handle_destroy(self.sh)
+        semanage.semanage_set_root("/")
+        shutil.rmtree(self.root)
+
+    def test_add_delete(self):
+        self.assertEqual(self.records.get_all(), [])
+
+        self.records.begin()
+        self.records.add("test_t")
+        self.assertEqual(self.records.get_all(), ["test_t"])
+
+        self.records.begin()
+        self.records.delete("test_t")
+        self.assertEqual(self.records.get_all(), [])
+
+
+if __name__ == "__main__":
+    unittest.main()
-- 
2.55.0

