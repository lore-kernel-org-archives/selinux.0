Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988374;
	b=rt3KCEVVWSDD3N1d01Um+EA/U/YKyrnJOFKwfan1bJjkjsnyTIvR1dK0ILvhhqS9O99v
	 3byQD85JIJEPPu4oRZrVmPiImdhh65bu+p2QntfAyv/zcXDvmekNDtjnontD2XSKys/Wq
	 7g5asHBJYNJAU9aXSI5GtUO6/43ddrQ4KVLG5gFLVK94tjkRpJPmtsmfU188i9Oz9WCOJ
	 vtlJgZ9qNMPUEU5u0rJmD5F7hxNSoaHluhBVWPexeFFDGFx+4A33oSSBDc7cyJAYy1ZHE
	 +SqV6rEKVUBo6HxA/1q69hMMe4tqQ/UFv/CHJwd06wzNoj58SXeL3l1g84v6NJCicGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dk7blejCgZtJnWiKZ5Znj3vAmKQe2OuLgg+bBi57OA0=;
	b=Yr/sbGwkoR3femsxk3V5L/E7jFWO7wyck7HNwdUNHbiISaATJ0BeAcSMx9yeM1Wh26dt
	 roF5BHGRwvLOwpXBg21qz4tIpAVDwztuQOY1Zg/Lz/ywLGYqx1Lf6AyzcM0w9yWq58dYC
	 gV5VQl8nTs9ZmNN28dyX8m0xkvkOwXw1Qw/hzz4EX75XzaYcmFk0lrRsnISodH05nPKnH
	 e07g9SvglfWZ0/Us9hR5Mqb5bWz9J7Z8rzQ3mb407wtNox+G1U8i8u6SeKEPsoDPeA/3E
	 oTyN/QILIUu0sW86vdNHOjrPhJewJdz4Y4zD2kibJ75C0rbS9WXkVGK64e4cYLR2GBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4lbtJm0;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBC606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EBBC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m4lbtJm0
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5364d86f7f0so10413631cf.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988373; x=1794593173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dk7blejCgZtJnWiKZ5Znj3vAmKQe2OuLgg+bBi57OA0=;
        b=m4lbtJm0zYqYl4VhNJ2U/7PiABZ3DUhWhqrFyVpRy/mQ/0+2x2tJ54LnpzP5XK7A6+
         6zxr36eGpFVHCWwwuyS/HEOUUY2E3lpjkl+G2t7LrIJOKyND4OkTrH+L4k4veA4H62rV
         UxyMP8pOlu7wRzKXcwrIDnUefnWGrRAeYMUMUooOJUn2XgKCMZzFnx2IYuDGMKuAlXmv
         jgNZY4IGIFrP/il/UZqaFooI6FHTO64/2FCW5p+7M3AWNilU3+oBW6zNz4iaP9yoZWVc
         RxN5LD2+5lT+d6poTGm1ccPqTmBV4VeU1wmGNuibcqMY/BP5w41ruygTAHx4nlCyDC1m
         sXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988373; x=1794593173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dk7blejCgZtJnWiKZ5Znj3vAmKQe2OuLgg+bBi57OA0=;
        b=G2h+WuBgIk6lyRhLzhBi54aMChM660oImMxA+ib3JFi/PnZ35oEHDK8S6e1j/7KIvB
         F7s/Zh4GzsvEVhJJjaw6FnEdYb/QC6ULlypmlSo466HU2Wg6gD8UyDWJtoOYBzQEU5oE
         wrkWV+HRSMb9NC6kHR4grYXuqP/hX8LlgS454Zejz0z56u0NXa7sBlWj6BxMIYokpL1F
         lpsRiejs+pqsxiEeBa/++ml7K69C+6RMUx509VhAYyWm+0WrVtyVxkLpKEs9J0kj70uT
         tCt0jCP0LDU5sn6SPb9S92KmlYSBkgzdl43DXr1yl0LQzONHcEYYlJFWSp8layRrjHD2
         yE4w==
X-Gm-Message-State: APuU4Z9H2ONbK3oV4T+HvAi9xwVYaMjQnMTfg3QKuFzE+XWksn6hkTGr
	erSEj1fFH6vdmVRQc/mPGgwwF/VTaFUA7JF8uZBdafxs/EvETdA2/9n0IYSvLUnl
X-Gm-Gg: AYBFou2sxA0RF/lATB0p1E/WokmvP98j9h+dMGFLLXqERqI3D0WfVQPbRE8urIjLOTl
	0Gqrq+TT+1yA9qKqhxr+1uALTQuP78HHzJn2URe+c0nYHkJcsW7+kHuQ+WC23h7vjFRE7L95bH3
	g/KLp0GRFkMDm0Oo4MwOdQUC5L+sMhPfOt3wTE+X6fbzdsvD/EsWb8n0+sLH6BuIs8LCSCJSxM+
	aEzOWBL/WjNVdLOYB6bQthwt6FS2C4rRrbhcYYcjfS8bXn5T7w70FwQwLVvIuth4sW0DmhkuGQK
	QuFCyfYV/HPQmoQd669wDLVUo5C8cz4eXdW6jc1va1FCXQ8PhsP6M6V9csGvsVisttIJZw2GA6y
	U985489mVmwQFnTKTsQxl2hg9KBsmjwqN6m6iRyiVGwomjWtVopS3SiwD/gC81VhBVEWlIVRs5a
	qtjouLLkUhxVnTBNnNU34bE/PabbN2zkoez5IZmFNlbBv0IF8NH3CwWoesTi9bhiQoV/2EzLyY6
	yePf8v4LF7giQqQ/h/m3BbzAMxa0mR5F0GL/vq3YZ0exbKShFbBNCVkxE/eK55sUqf4u4FEQ4sI
	qomw7nZ8R4Wz63Rw9hf/iWSt9uzR+8UEcUuZ7ycffd9jXQ2O6dmDLFQMUbPw5/yy+6wYsY0aHD8
	N58FDFSe84itfQJe8a41DK/57c3BEtKCxSGOxtL1G9Tg5MPGgQC0O95gHbSHtu5aq6xcli6XA5u
	/nImgNlEBoKjuXsU+gAOBgLVBi/4KpmS5LYsB/joZceiMAEOGjB9k=
X-Received: by 2002:ac8:5e54:0:b0:535:855e:6e25 with SMTP id d75a77b69052e-54e146666b2mr51815911cf.47.1793988373248;
        Fri, 06 Nov 2026 10:06:13 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26259cf0sm25893461cf.15.2026.11.06.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:06:12 -0800 (PST)
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
Subject: [PATCH 2/4] libsemanage: initialize Python module buffers before argument conversion
Date: Fri,  6 Nov 2026 13:05:54 -0500
Message-ID: <20261106180556.243798-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106180556.243798-1-stephen.smalley.work@gmail.com>
References: <20261106180556.243798-1-stephen.smalley.work@gmail.com>
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

The module-data typemap initializes view.obj in its input conversion block,
but SWIG can jump to the shared failure label before reaching that block.
Wrong argument counts or invalid handle/module-info arguments then cause
PyBuffer_Release() to use an uninitialized Py_buffer. In particular, an
invalid semanage_module_install() call can segfault instead of raising
TypeError.

Initialize the buffer in its local declaration so every exit path can
safely release it. Retain release after successful acquisition on later
argument errors, native errors and successful calls.

Add an optional test-python-module-buffer target that generates the full
bindings and checks early errors for both installation APIs, buffer release,
and binary length preservation. Native installation is intercepted so the
test cannot modify policy. Inspect declaration initialization as well as
runtime behavior because stack contents can mask the invalid release.

Fixes: 82c7c876fa75 ("libsemanage: treat module data as bytes in the Python bindings")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/semanageswig_python.i         |  3 +-
 libsemanage/tests/Makefile                    |  6 ++
 .../tests/regression/module_buffer_stubs.c    | 40 ++++++++
 .../tests/regression/test_module_buffer.py    | 99 +++++++++++++++++++
 4 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 libsemanage/tests/regression/module_buffer_stubs.c
 create mode 100644 libsemanage/tests/regression/test_module_buffer.py

diff --git a/libsemanage/src/semanageswig_python.i b/libsemanage/src/semanageswig_python.i
index 1729e965..797709e1 100644
--- a/libsemanage/src/semanageswig_python.i
+++ b/libsemanage/src/semanageswig_python.i
@@ -131,8 +131,7 @@
  * Python object exposing the buffer protocol (bytes, bytearray, mmap, ...)
  * as a single argument and derive the length from it.
  */
-%typemap(in) (char *module_data, size_t data_len) (Py_buffer view) {
-	view.obj = NULL;
+%typemap(in) (char *module_data, size_t data_len) (Py_buffer view = {0}) {
 	if (PyObject_GetBuffer($input, &view, PyBUF_SIMPLE) < 0)
 		SWIG_fail;
 	$1 = (char *)view.buf;
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 2162a5e3..245c124c 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -31,3 +31,9 @@ test: all
 test-config-empty: regression/test_config_empty.c ../src/libsemanage.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=strdup $(LDLIBS)
 
+
+# Requires SWIG, Python development headers and the built shared library.
+PYTHON ?= python3
+.PHONY: test-python-module-buffer
+test-python-module-buffer:
+	$(PYTHON) regression/test_module_buffer.py
diff --git a/libsemanage/tests/regression/module_buffer_stubs.c b/libsemanage/tests/regression/module_buffer_stubs.c
new file mode 100644
index 00000000..aad01a34
--- /dev/null
+++ b/libsemanage/tests/regression/module_buffer_stubs.c
@@ -0,0 +1,40 @@
+#include <assert.h>
+#include <errno.h>
+#include <stddef.h>
+#include <string.h>
+#include <semanage/modules.h>
+
+int __wrap_semanage_module_install(semanage_handle_t *handle, char *data,
+				   size_t len, const char *name,
+				   const char *ext);
+int __wrap_semanage_module_install_info(semanage_handle_t *handle,
+					const semanage_module_info_t *info,
+					char *data, size_t len);
+
+static int check_data(const char *data, size_t len)
+{
+	if (len == 6 && !memcmp(data, "reject", len)) {
+		errno = EACCES;
+		return -1;
+	}
+	assert(len == 4 && !memcmp(data, "a\0\xffz", len));
+	return 0;
+}
+
+int __wrap_semanage_module_install(semanage_handle_t *handle, char *data,
+				   size_t len, const char *name,
+				   const char *ext)
+{
+	(void)handle;
+	assert(!strcmp(name, "name") && !strcmp(ext, "cil"));
+	return check_data(data, len);
+}
+
+int __wrap_semanage_module_install_info(semanage_handle_t *handle,
+					const semanage_module_info_t *info,
+					char *data, size_t len)
+{
+	(void)handle;
+	(void)info;
+	return check_data(data, len);
+}
diff --git a/libsemanage/tests/regression/test_module_buffer.py b/libsemanage/tests/regression/test_module_buffer.py
new file mode 100644
index 00000000..13f963a0
--- /dev/null
+++ b/libsemanage/tests/regression/test_module_buffer.py
@@ -0,0 +1,99 @@
+#!/usr/bin/env python3
+"""Generate the real bindings; intercept installation before it touches policy."""
+import argparse
+import importlib
+import os
+from pathlib import Path
+import re
+import shlex
+import subprocess
+import sys
+import sysconfig
+import tempfile
+
+CASES = (
+    'install_arity', 'install_extra', 'install_handle', 'info_arity',
+    'info_extra', 'info_handle', 'info_modinfo', 'install_buffer',
+    'info_buffer', 'install_name', 'install_ext', 'install_error',
+    'info_error', 'install_success', 'info_success',
+)
+
+
+def exercise(case):
+    module = importlib.import_module('_semanage')
+    for _ in range(100):
+        data = bytearray(b'reject' if case.endswith('_error') else b'a\0\xffz')
+        calls = {
+            'install_arity': lambda: module.semanage_module_install(),
+            'install_extra': lambda: module.semanage_module_install(None, data, 'name', 'cil', 0),
+            'install_handle': lambda: module.semanage_module_install(object(), data, 'name', 'cil'),
+            'info_arity': lambda: module.semanage_module_install_info(),
+            'info_extra': lambda: module.semanage_module_install_info(None, None, data, 0),
+            'info_handle': lambda: module.semanage_module_install_info(object(), None, data),
+            'info_modinfo': lambda: module.semanage_module_install_info(None, object(), data),
+            'install_buffer': lambda: module.semanage_module_install(None, object(), 'name', 'cil'),
+            'info_buffer': lambda: module.semanage_module_install_info(None, None, object()),
+            'install_name': lambda: module.semanage_module_install(None, data, object(), 'cil'),
+            'install_ext': lambda: module.semanage_module_install(None, data, 'name', object()),
+            'install_error': lambda: module.semanage_module_install(None, data, 'name', 'cil'),
+            'info_error': lambda: module.semanage_module_install_info(None, None, data),
+            'install_success': lambda: module.semanage_module_install(None, data, 'name', 'cil'),
+            'info_success': lambda: module.semanage_module_install_info(None, None, data),
+        }
+        try:
+            result = calls[case]()
+        except (TypeError, OSError) as error:
+            if case.endswith('_error'):
+                assert isinstance(error, OSError) and error.errno == 13
+            else:
+                assert not case.endswith('_success') and isinstance(error, TypeError)
+        else:
+            assert case.endswith('_success') and result == 0
+        # A leaked buffer export would prevent resizing after the call.
+        data.extend(b'x')
+
+
+def main():
+    parser = argparse.ArgumentParser()
+    parser.add_argument('--library', type=Path)
+    parser.add_argument('--case', choices=CASES)
+    args = parser.parse_args()
+    if args.case:
+        exercise(args.case)
+        return
+
+    component = Path(__file__).resolve().parents[2]
+    library = (args.library or component / 'src/libsemanage.so.2').resolve()
+    assert library.is_file(), library
+    with tempfile.TemporaryDirectory(prefix='semanage-buffer-') as tmp:
+        temp = Path(tmp)
+        wrapper = temp / 'wrapper.c'
+        subprocess.run(shlex.split(os.environ.get('SWIG', 'swig')) + [
+            '-python', '-I' + str(component / 'include'),
+            '-I' + str(component / 'src'), '-outdir', tmp, '-o', str(wrapper),
+            str(component / 'src/semanageswig_python.i')], check=True)
+        source = wrapper.read_text()
+        # Inspect both entry points: stack contents can hide an invalid release.
+        for api, view in (('semanage_module_install', 'view2'),
+                          ('semanage_module_install_info', 'view3')):
+            start = source.index('_wrap_' + api + '(')
+            body = source[start:source.index('\n}\n', start)]
+            declaration = re.search(r'Py_buffer\s+' + view + r'\s*=\s*\{\s*0\s*\}', body)
+            assert declaration, api + ': buffer must be initialized at declaration'
+            assert declaration.start() < body.index('SWIG_Python_UnpackTuple')
+        output = temp / ('_semanage' + sysconfig.get_config_var('EXT_SUFFIX'))
+        subprocess.run(shlex.split(os.environ.get('CC', 'cc')) + [
+            '-shared', '-fPIC', '-O2', '-g', '-I' + sysconfig.get_path('include'),
+            '-I' + str(component / 'include'), str(wrapper),
+            str(Path(__file__).with_name('module_buffer_stubs.c')), str(library),
+            '-Wl,--wrap=semanage_module_install,--wrap=semanage_module_install_info',
+            '-Wl,-rpath,' + str(library.parent), '-o', str(output)], check=True)
+        env = dict(os.environ, PYTHONPATH=tmp)
+        for case in CASES:
+            subprocess.run([sys.executable, str(Path(__file__).resolve()), '--case', case],
+                           env=env, check=True, timeout=30)
+        print('module-buffer: 15 scenarios, 1500 calls passed')
+
+
+if __name__ == '__main__':
+    main()
-- 
2.56.0

