Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732015;
	b=gxej3zZS7f5pOqtsaQij8aI475ANlC3QKhpLdBWo7pEA68u8GEwRaEccoyUpU6SMV4B2
	 e2SH6gD9iDsGklR9rtkKdakLIdFlzJJarGMrrg/UCgE0hjxsXizYzfy1endpFsIUmVW0E
	 BWKk2+MG+v4Dzvd0WTKVyrLd1gAAG2ZEOodqDq5D0waEqnwd9i6oHFk1MSTIIxu829lLr
	 rpFbBWzbK0b71zoVFRo5eLRbmNkcq228CGJyLsaEOACWmcDx7qU6ddTkUY62ON9mMdjJ/
	 telIt+2NYEUMuXqY6e9orLnIvXj7Om8hz/fplatCqgl5xPrfCm/rxEFYORGTy3ucY9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FzvqNitBoY2jxyhHq+DZU+eiZDsF+y0XBm26cBq2WVA=;
	b=whCcdb7oac0D/3T0KtOQ/tQDSBhjKMBgRZGN1IR/K4hkaKck59GZEIoJm7YxS6wucWky
	 AxoNRhS+VtftKz+V9/DQzU/q8vkJ5/bgIk5aOvzoMErJHubSyxm0foga7lvl3W70bOOSI
	 tCN04ww5b6nijeUR4yH4zaFmEkiGiWxIkA9FqufQFCp/fQ4rEtBq/R3AlIhyaNqE4wvC0
	 R/3O/iXDOACAfZXPF1+FvfHBLfyUxjIwETBEQ8aSAAsvYwhkyTmptbUBy+kA1Yw91D3h+
	 A03+jb7J4x4xHLdJsEnKWIMouvbjsSMWfCVlZ/NLmf6I2ubNHEPJ8/fuGNnzVKjHUhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uNfCzdXx;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC1606A32C
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88BC1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uNfCzdXx
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c763de878so33336626d6.0
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732014; x=1794336814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FzvqNitBoY2jxyhHq+DZU+eiZDsF+y0XBm26cBq2WVA=;
        b=uNfCzdXxXqCJgbuuzh9Cv+kvO3/DgBq1GrVf67RnBCZ9oZnj6ogBT84O2AK3C/dgeJ
         LxS2xW0LnH6Tuv6tBn+Td982K9lHF5QPCSgJoDJFLzGqyZRFWdjGEtom7na1/p6zQZc7
         c+xjXldV+6mIqE5QH7ocA6XVzJW5aTUDrIq3J8lspN4VtWv4++fNhCpb9s2+XWF2Cdn4
         Et/hTgnmtpeSwdi0v9WlDblIFk6BH+TiJIAXayvlJ+gXwvXDPT2JKRW308wWidlz/8iG
         XsEN8kFrzXKrxLslCuKZuA8/gciB9q0I8rUMITJ6C0FuKCxmK388ZLXtBgzc1iu1vZcD
         puCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732014; x=1794336814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FzvqNitBoY2jxyhHq+DZU+eiZDsF+y0XBm26cBq2WVA=;
        b=UkjDPqeOZIYTnUGhy2ji1gtwWCkYFj7VqB7MLQ96vpOPwHx5P6vbomdQh7gs1VZiZn
         EVFAyjQpEPTumXtWCvnUoqeFFPRGKYNLoC+prCcx3fO05ukXo3/9Fc/Np0o0T73TH2Wv
         PZisxEV8+At1dU3a9OChHN37GA6/6P4hllB7k8f6ou4KWDuWQsTB1PolCvR4Oej32uwA
         RQgXAJfNwRe2GP6qt22nA1cyX6yaFs+AbSIAeteBpN9osZ2fuMukcAz562hJ6zhqSp+M
         WzyaxD5pDvrolc5pxsYIndHEv/nJBl29Yyaeyq0T74pZ+1oyFW67h/wKgLXaVIJWWVy5
         vk6Q==
X-Gm-Message-State: APuU4Z/TDFNRQSMPv44kys8j+cNGGNafRx0eVZxOhQaLWSPHFOMQxVZc
	wYU7TLJ85ikHhBk081j/z/dn9Lvfycnnk7aRcYd6LcV0zUQdH0WJfnVFmCNXHTGS
X-Gm-Gg: AYBFou22HUn71YI9RUwOOuETYgP373Sz6clsRxm7AK+6xUMyJWzDs5tTKzl5TWqSZ8Z
	zsaC4FlzN5minJ+j5Uvx5iFJIBMxpW7iw1NFTtLjfiA7UBrf5xKsl4WKGiir7L5jYIJVhYydH5L
	afJjImaqPJZ+XTDOkHj2tP+ri4csvGgCveQzTIzYoXlcIAX9CmFjjJSp9DtqHRPKYjmn7Imaf/d
	+rUjl9rPtCfYql/4jULtnfGz5YwUNJIjtt2M2prYi0QZV3C278fs1Brb759nAVYvXwl3VE9TQJt
	Yy/0K2u8/Zvqx8O4c81XIIDCzQDP8MNgTUbipihDMsl17A2fPKAWz8fCOyUd6E3X9wJwrdV0Fji
	Owd66oM4QjbLloYUQ6C3NLGvmlXxgytcQB9MMRf5tOn0w7LrnpF796aT5Irm/bxLrVFbrU112pA
	sy+Plan7BaVmJcTXk22H3Q8lI85Jw2OTnIMgYzbZR/aBYzqX+42HoHJmJ1ehE0V84A3z7v/kyHN
	sPKRWHTTVn7B6QT1WvDFHne2EDk+re6WSX6cDZuRAnpWU3H8Vt5P9rqORb2l1U3Pt/HM3sPP5FK
	Ag1xWLsuwR0BQgoLu6D6iUS5aBadfNdjeAL/qq4YFTCAvojmantP4ra35uQ41aJV8CLzyrjtxNx
	+MHVqvmxeARYDQSwerbZgr35l0Ci06dAxjGiz+8GpIfyuqEdoVs3KrsLYUy+CBUeWFu86oiKnSO
	kRMT6zZoaEEgtqBD4wGv3sezkGnOz94CpdoO/oZ6fw/FiHWdAWrf5n
X-Received: by 2002:a05:620a:461e:b0:943:e946:8c6d with SMTP id af79cd13be357-94421793f93mr2382479185a.72.1793732014064;
        Tue, 03 Nov 2026 10:53:34 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:33 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 14/20] libselinux: let Python own policy_open descriptor cleanup
Date: Tue,  3 Nov 2026 13:53:01 -0500
Message-ID: <20261103185307.45924-14-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103185307.45924-1-stephen.smalley.work@gmail.com>
References: <20261103185307.45924-1-stephen.smalley.work@gmail.com>
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

os.fdopen can take ownership of a descriptor and close it before raising
an exception during text wrapper setup. Closing the raw descriptor again
masks the exception with EBADF, or closes an unrelated descriptor if the
number has been reused.

Use built-in open with a fallback-aware opener instead, so Python manages
ownership from descriptor creation through wrapper construction. Preserve
the read-only underlying open flags. closefd=False is rejected before
opening a path rather than leaking the descriptor hidden by this helper.

Test success, early and late failures, descriptor counts, read-only flags,
and controlled descriptor reuse. The tests can use either the exact helper
extracted from the SWIG source or a generated native binding.

Fixes: edbc7af1c9cd ("libselinux: add Python binding for selinux_policy_open()")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinuxswig_python.i  |  10 +--
 libselinux/tests/Makefile            |   2 +
 libselinux/tests/test_policy_open.py | 125 +++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 6 deletions(-)
 create mode 100644 libselinux/tests/test_policy_open.py

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 2340ed2d..28d37e92 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -65,12 +65,10 @@ def install(src, dest):
 
 def policy_open(path, mode="r", **kwargs):
     """ Open a policy configuration file for reading, searching fallback configuration roots (see selinux_policy_open(3)). Returns a file object """
-    fd = selinux_policy_open(path, os.O_RDONLY | os.O_CLOEXEC)
-    try:
-        return os.fdopen(fd, mode, **kwargs)
-    except:  # noqa: E722
-        os.close(fd)
-        raise
+    def opener(name, flags):
+        return selinux_policy_open(name, os.O_RDONLY | os.O_CLOEXEC)
+
+    return open(path, mode, opener=opener, **kwargs)
 %}
 
 /* security_get_boolean_names() typemap */
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index c73e5c65..89899d6f 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -1,6 +1,7 @@
 PCRE_LDLIBS ?= -lpcre2-8
 CFLAGS ?= -O2 -g -Wall -Wextra -Werror
 override CFLAGS += -I../include -I../src -pthread
+PYTHON ?= python3
 INIT_OOM_WRAPS = asprintf __asprintf_chk strdup calloc free
 XDEV_WRAPS = getfilecon_raw lgetfilecon_raw openat openat64 fstat fstat64
 EXCLUDE_WRAPS = getfilecon_raw lgetfilecon_raw openat openat64
@@ -35,6 +36,7 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-load-policy-version
 	./test-auxiliary-duplicates ../utils/sefcontext_compile
 	./test-android-specfiles
+	$(PYTHON) test_policy_open.py
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
diff --git a/libselinux/tests/test_policy_open.py b/libselinux/tests/test_policy_open.py
new file mode 100644
index 00000000..337be348
--- /dev/null
+++ b/libselinux/tests/test_policy_open.py
@@ -0,0 +1,125 @@
+import ast
+import errno
+import os
+from pathlib import Path
+import sys
+import tempfile
+import unittest
+
+
+if os.environ.get("SELINUX_TEST_BINDING"):
+    import selinux
+    policy_open = selinux.policy_open
+else:
+    # Exercise the exact helper without requiring a built Python extension.
+    source = (Path(__file__).resolve().parents[1] / "src" /
+              "selinuxswig_python.i").read_text()
+    code = source.split("%pythoncode %{", 1)[1].split("%}", 1)[0]
+    function = next(node for node in ast.parse(code).body
+                    if isinstance(node, ast.FunctionDef) and
+                    node.name == "policy_open")
+    namespace = {"os": os, "selinux_policy_open": os.open}
+    exec(compile(ast.Module(body=[function], type_ignores=[]),
+                 "selinuxswig_python.i", "exec"), namespace)
+    policy_open = namespace["policy_open"]
+
+
+class PolicyOpenTests(unittest.TestCase):
+    def setUp(self):
+        self.directory = tempfile.TemporaryDirectory()
+        self.addCleanup(self.directory.cleanup)
+        self.path = os.path.join(self.directory.name, "config")
+        with open(self.path, "w") as stream:
+            stream.write("policy data\n")
+
+    def test_reads(self):
+        for mode, expected in [("r", "policy data\n"),
+                               ("rb", b"policy data\n")]:
+            with self.subTest(mode=mode):
+                with policy_open(self.path, mode) as stream:
+                    fd = stream.fileno()
+                    self.assertFalse(os.get_inheritable(fd))
+                    self.assertEqual(stream.read(), expected)
+                with self.assertRaises(OSError):
+                    os.fstat(fd)
+
+    def test_exceptions_and_cleanup(self):
+        scenarios = [
+            ("r", {"encoding": "not-a-real-codec"}),
+            ("r", {"newline": "invalid"}),
+            ("r", {"buffering": 0}),
+            ("rb", {"encoding": "utf-8"}),
+            ("bad", {}),
+            ("r", {"closefd": False}),
+        ]
+        for mode, kwargs in scenarios:
+            with self.subTest(mode=mode, kwargs=kwargs):
+                before = len(os.listdir("/proc/self/fd"))
+                try:
+                    open(self.path, mode, **kwargs)
+                except Exception as error:
+                    expected = type(error)
+                else:
+                    self.fail("fixture did not fail")
+                for _ in range(10):
+                    with self.assertRaises(expected):
+                        policy_open(self.path, mode, **kwargs)
+                self.assertEqual(len(os.listdir("/proc/self/fd")), before)
+
+    def test_open_failure(self):
+        with self.assertRaises(FileNotFoundError):
+            policy_open(self.path + ".missing")
+
+    def test_late_failure_does_not_close_reused_fd(self):
+        namespace = policy_open.__globals__
+        original = namespace["selinux_policy_open"]
+        opened = []
+        replacement = []
+
+        def track(name, flags):
+            fd = original(name, flags)
+            opened.append(fd)
+            return fd
+
+        def trace(frame, event, arg):
+            if (frame.f_code is policy_open.__code__ and
+                    event == "exception" and not replacement):
+                self.assertEqual(len(opened), 1)
+                with self.assertRaises(OSError) as result:
+                    os.fstat(opened[0])
+                self.assertEqual(result.exception.errno, errno.EBADF)
+                fd = os.open(self.path, os.O_RDONLY)
+                replacement.append(fd)
+                self.assertEqual(fd, opened[0])
+            return trace
+
+        namespace["selinux_policy_open"] = track
+        previous = sys.gettrace()
+        try:
+            sys.settrace(trace)
+            # This check occurs after raw-stream creation in CPython.
+            with self.assertRaises(ValueError):
+                policy_open(self.path, buffering=0)
+            sys.settrace(previous)
+            self.assertEqual(len(replacement), 1)
+            self.assertEqual(os.read(replacement[0], 32), b"policy data\n")
+        finally:
+            sys.settrace(previous)
+            namespace["selinux_policy_open"] = original
+            for fd in replacement:
+                try:
+                    os.close(fd)
+                except OSError:
+                    pass
+
+    def test_readonly_underlying_descriptor(self):
+        with policy_open(self.path, "wb", buffering=0) as stream:
+            with self.assertRaises(OSError) as error:
+                stream.write(b"changed")
+            self.assertEqual(error.exception.errno, errno.EBADF)
+        with open(self.path) as stream:
+            self.assertEqual(stream.read(), "policy data\n")
+
+
+if __name__ == "__main__":
+    unittest.main()
-- 
2.56.0

