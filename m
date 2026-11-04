Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804986;
	b=xrVXL7KE9SBH6q8UYRBEEJxAuaNHuF4vXk6ieqsfnrHW+GVk5848G+HBOYMgoOzTPznC
	 xoGmcc3VsLQ1OUEsy8SdHrHiQO2Sqm6pXkkYmhVETGqKTM+aTD7C65LETgiqs00zKoKRX
	 hpCf7chZSF+FCehGGyNzbgngvJE27L8QMrS0VYYHj7HYiPC3FzEuvgbaK+/8pfkbmwKX/
	 V2bZI0QzBixhU4pdpd23pa68PQrj3XZVZ+l44ni7p7CtVrPCSY6jtqVHF6VAhSVHjSc1X
	 eY0vt6aOVarNpSFGUrNsGtGRwe5h2y5VTR791iV8Zv53Q6u8Y+zu30eC4wRJ1uCU8uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FzvqNitBoY2jxyhHq+DZU+eiZDsF+y0XBm26cBq2WVA=;
	b=XWd1Lei1IqsLnSIyXQVjCBqLvX+ICmP8oiUQhM2UIrXoHj0nzkByEHOTzJeZXUjmX9fe
	 L5nXnmWxzosArJAxFZOX+sQARV6WM/kWU328vs5SsNIANasdCg3co70ur+bgZre3BXbb9
	 MzNf6tibmJPXBDRGZ1CVBLej99PUrmiWjfksKXi6jC6WUAjoQp65dB7jwb2olpkXpX29G
	 JZ4cCZGpqbo8F+egJadvgDf7i2+o95gnzhr06L7OAMujjmvfE5nmhq0MRXjCRMwjChFMN
	 0b/fBIkYe7o1aHoWw/rvexmUQmQszOoBaoEDmGoS/PWu0/58SWPAc89v+lNKygGp4Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OnmdvhAK;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA418606D816
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA418606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OnmdvhAK
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5351d76e1baso7646051cf.1
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804985; x=1794409785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FzvqNitBoY2jxyhHq+DZU+eiZDsF+y0XBm26cBq2WVA=;
        b=OnmdvhAKy/xLC5mOT/WvnLfZ5wuL4rbDltktwdSWHJ2Anl8O9+dcspi1J54WwA/ZVK
         KAU4M1Z/KLda5mFisCNy0pN06ZTKCbpbpb2IQmlseGCxC/+M4zoNWb6GIfhoPYv5Wln9
         qX5716xSTRNQctkqo9ZlYDRZpb3YUCRF7SrLpNrpezL7JlvbFF0Wq3iz6scOum4wC2Xe
         xNxOm+di6n+Ej6/ZGnnP6D0SoX2EDyYORExH7P5QM11529rqa2LJGnLvXjKoAOYhHSwG
         Q99cxheUpBieebraQDMsJlZD8ihgCHlWp3w0n8f4WTQ1s3jG8watBBrk8fzgqq5dFBPV
         9DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804985; x=1794409785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FzvqNitBoY2jxyhHq+DZU+eiZDsF+y0XBm26cBq2WVA=;
        b=FjaDQ/dZIJoJATYwWsckpL7El83gdgP1xtuHSpwpOQ8P54+VvgUjUpklGrrGsvZ6v+
         hDRIZiAopXY2jChYV29a7/TxiTPeCGHDb8G6RuDraJu5gG1Y8om7xiUmW65bF9i8Lb6d
         2zPG6ROZaAVDrJe1FHnGEqkOdJtCcTjcRWiJfoIkl/lvWjIrxMqWhQlSvr/EsqcGsuDD
         azlCRDVwBpIdkjhvt0QLjnHrGEclAMc3UuTHYbFloGxvF59G8LNMOF1/GAnr4F9kp6dF
         EQ8EbgVxgI0OBdLE9Ai89VHwFNM6sdTUstNcTU0zUECkkwAe88wwWf/Ty3JSxUWpbmoP
         IjMA==
X-Gm-Message-State: APuU4Z8jIa2a6UuRmtONrNwHvN1i+kKCnBd3u/NxdrzO932yKOm76XkG
	8YLM4SCTSzk5DtADet8jLrvE7P8R1jbnp3DvBH6YsgZr+UBF39v5a4S76geSR1To
X-Gm-Gg: AYBFou0IVQ2h20Nc6VyjoqmSOLxrTMeB47t1TgdYo/UfrwLMM+taVHXae4oLmSYk1vE
	fiRmWRbFMqHD8Mh6Ihw2KWzplyQlQafkeJZ8GGjX19nh3FthisthU2gN63o0qiKgjoRMz8UHXTq
	FuQp3cuoH/Bt/yEECW2y95gTKHc9aJU10s7Xhn3gHUhXCbuLvQznYXqJwf4nJbcah0/qXd/Gfta
	WH/A384Uudp0uxhd+n3ywztDVXqsVxxc/MynoA2umfjf6Kqrik5782MatxcxaZy9nWlwja0n0ns
	XKIi5BipmE2vUEn2XNRSzhusu1OL7lLvTh8Cfxo6ntksvTSnSgaf1R+SC40IAd6KtEpaOo5NOKK
	7NZDIWgF99aermNyHt5XRZKVhmWQEbQru3UmJVzI0hCfcaJEtvJ8pBQFUDb+bWC5Qzw92pkJsEw
	JAUNd9WP0R4chrqXdRQsv+wN7G3etNQWJFukQ9lm5BtG3sICQ/6cEyM65uoUCe4z1bUMdLWzgD7
	1yeJh4CbIf3qxf9ggIAoDGQc8JyighSvw2E6+TtU/WeGo+dq/KH2+uUWpodBFS7Nt84H+y9VSuK
	YM+AcLDhtBOIxoI6F492lpwhJIeLVRL75JVKEyglw/dW9e4LnLJZ374p4137bj1/AZ9Fj9rBsMk
	kCT0z2ZQFuyfsLvactYlNkvAvRONdpD+OuFqC8CjwMTKNnkUFhR3+OUGXL2/Gfw8Yj2iR1WLi6s
	C2XLMjvjZoaDh6iBZaqhVHuDEhNNrVEWvBLG5sh4ofMlpjwlJJbD0=
X-Received: by 2002:a05:622a:2515:b0:535:1b18:211 with SMTP id d75a77b69052e-542b7336a71mr259754811cf.19.1793804984597;
        Wed, 04 Nov 2026 07:09:44 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:44 -0800 (PST)
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
Subject: [PATCH v3 14/20] libselinux: let Python own policy_open descriptor cleanup
Date: Wed,  4 Nov 2026 10:09:09 -0500
Message-ID: <20261104150915.175923-14-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104150915.175923-1-stephen.smalley.work@gmail.com>
References: <20261104150915.175923-1-stephen.smalley.work@gmail.com>
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

