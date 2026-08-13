Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36025403E96
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646491; cv=none; b=EhMuU29acO8yxNrnGNqPQKfJcva1i66U8BejiJiiZE3RI+nYT42ZwRENsKfZr0DCC9XRnBBtyb6hYjHkhkr+tA84Rgy91sTJ0V5ffkjx5MXTwadEnzYuq+HpUN1dS/0lm7lV0QwQxn2/et544NN4j7fE6ADvNpGXrCu9UkqLdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646491; c=relaxed/simple;
	bh=6ul1smau2CkNLvnpghd8W1DQgwxBL8M5Evhda4ouLvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YxkDi7dJPPl7+RybmHrHj1UbIovIenmTVLwOxHYuBNTb9cU1B38cVVVPlIYNEy4nC0oFFVewV1rKfUiMl8YYj/FNL4priYH6+Mzj6rkJm/MngE12g+d1LQwv8n42l/7v8j2+QDiAihiFEvnr7gqzDrdCsHF0ktvcF/w1KT8z4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMI7SxWT; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMI7SxWT"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92f03daaa97so13881885a.2
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786646489; x=1787251289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wa6IHymr3zoWUOt2WoGtvJ3GFs+PQu01c/KYDIApwJU=;
        b=DMI7SxWTPLgRV9f73SpNgZDu8icF9YOK7J/0b4573MhL/r1YuvVRIzt4r5dCCvWcFl
         XcA2HHqk7KHj1FbL1avOjLCssq7zpi9TxF00K2cgfg8ooiEqV7W9dN4g32rStmw0ZsBl
         0aYJmTz0x1A5umlHDP0JDjYWwVKPC2Mcysh0aFsJ+qV9dfwIxUmlXxHqNT7RU82cWElX
         iIUFd2/w9GCbQEZrgxqX2YasD1ZFKkbd6qzmNRfpa7eL5fxIuiVUN+IvzxsHh2boXumx
         bI9CFBjULi47IwJb8Z3WnP1trcDLfKL6TkUsDV5AvyAkE00GPfU9ImZo7LpXHgf5tKcj
         KfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646489; x=1787251289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wa6IHymr3zoWUOt2WoGtvJ3GFs+PQu01c/KYDIApwJU=;
        b=ns54DokCXUj/O7KQfjlGXzm6shzuFHKO3FYTpCLdM/VomRwmG2HsN9vo9k8jJp1D2g
         FiCyWqHcALo+BwNPa2Nu/mmFEm9o0WYA0Iuoo2FCHOpouFpMjYWjF0Ahjw6f+r/zydSa
         JJC0rgoivzpR9vpnfXE7sRCIOkXQ0Mz8htTlNk/f5z5/mNX1UBV81JPFFrccwHSN2bqb
         jikJcyppP72TBsO7eDvri22pxMTPFgf7c1pAA1oWvWK/eRo54ql3lhWZBssOL+x11cnK
         roATAJqx1NCc04BM0yTzqEiv4Uoz3uzJQtLRWxt4P++Stzmu9mitfKNYt82dt5mWA/Db
         zzTQ==
X-Gm-Message-State: AOJu0Yzay8uLoMevYBsVfsNXZQtbo1+iHr5OeAGRc0oTAuQF4xzyF3Ng
	HYF1gPHUNrNQZ8YtYr1Y13rFPCnFLEwJVEd4rLkPcFmyGkGbcHZH+hyQF/11sw==
X-Gm-Gg: AR+sD11uGqjR6wGsu4BW/fl0u6ZpbngR8JCVsQPEKiTZcedWipNbv708ylmFCmh1eIu
	CXv/D/a2vBOKIwKoNTV9QIB1NeS/vcl9eot3NLhoSqT2y8xKsgr+RJ2CIZBIyzUrcXBHVXwhyNP
	SWEfcvfKDIeZsYdOWblYdQagnj+nDN764LWFOmXLFj/0HiYrTYt2kFAJPOLAp5ZR5q+tKi0HWCe
	1gCjl4SiIFzJWWVGDlBwCbRuLIwjcd8esAiBvwddVzKVyFcv3DExw7hKqM7X1GOWl6DKQ8TmHhE
	OjjSXzQX8dIjNaY3Z4NbgI09XvOyqnLceBWSk1BfiyvR11Edsjw5DS/V/QT4PZ0xtiS07PLbV+I
	v8bHl7FUbrth395dNJV173qOJycthLQMP/zgD90V7lo/oX15EQVIu8ZLPcwYsV1ISjxFPozJMvD
	I7zD/4P3VG4bG7DBclGZWTiQbNAxQ5QFGhkGhQmwUytlAgx5sFlSPNDSwhhFHEshGsKB55IbnFw
	ZXHhMJeLtKgnvTSnXvF3tHGjfMRqFmCXx6U3ppoQrHFLbtxFHWcK8mfCufgEVYJ
X-Received: by 2002:a05:620a:440f:b0:92e:fc42:2c1d with SMTP id af79cd13be357-936bf94d904mr897782485a.20.1786646488781;
        Thu, 13 Aug 2026 11:41:28 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce21a9b6sm46091385a.34.2026.08.13.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:41:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: treat module data as bytes in the Python bindings
Date: Thu, 13 Aug 2026 14:41:13 -0400
Message-ID: <20260813184113.186092-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semanage_module_install() / semanage_module_install_info() take a
(char *data, size_t data_len) pair, and semanage_module_extract()
returns (void **mapped_data, size_t *data_len). In both directions
the payload is an opaque module blob (.pp / bzip2 / CIL / HLL), not a
NUL-terminated C string.

On Python 3 the current SWIG bindings get this wrong on both sides:

- install()/install_info(): the SWIG default for a bare "char *"
  only accepts str objects and UTF-8-encodes them, so a .pp blob
  cannot be passed at all, and even for CIL text the separately
  supplied data_len is wrong for any non-ASCII content since
  Python len(str) counts code points, not UTF-8 bytes.

- extract(): %cstring_output_allocate_size turns the mapped buffer
  into a str via UTF-8 decoding, which for a binary module either
  raises UnicodeDecodeError or (with surrogateescape) yields a str
  that cannot be fed straight back into install().

Add a (char *module_data, size_t data_len) input typemap that
accepts any object exposing the buffer protocol (bytes, bytearray,
mmap, ...) as a single argument and derives the length from it, and
apply it to the (char *data, size_t data_len) pair of
semanage_module_install_info() as well.

Replace the extract() output typemap with an explicit multi-argument
typemap that returns a bytes object built from the mapped buffer and
then unmaps it, so extract() -> install() round-trips.  Drop the
now-unused <cstring.i> include.

The Python signatures become
  semanage_module_install(sh, data, name, ext_lang)
  semanage_module_install_info(sh, modinfo, data)
There are no in-tree Python callers.

Fixes: https://github.com/SELinuxProject/selinux/issues/502
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/semanageswig_python.i | 43 +++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/semanageswig_python.i b/libsemanage/src/semanageswig_python.i
index 0ca09763..1729e965 100644
--- a/libsemanage/src/semanageswig_python.i
+++ b/libsemanage/src/semanageswig_python.i
@@ -102,9 +102,46 @@
 %apply int *OUTPUT { unsigned int * };
 %apply int *OUTPUT { uint16_t * };
 
-%include <cstring.i>
-/* This is needed to properly mmap binary data in SWIG */
-%cstring_output_allocate_size(void **mapped_data, size_t *data_len, munmap(*$1, *$2));
+/*
+ * semanage_module_extract(): the (void **mapped_data, size_t *data_len) pair
+ * is an opaque module blob (.pp / bzip2 / CIL / HLL).  Return it to Python
+ * as a bytes object; %cstring_output_allocate_size would UTF-8-decode it
+ * into a str, which corrupts binary modules.
+ */
+%typemap(in, numinputs=0) (void **mapped_data, size_t *data_len)
+	(void *temp_data = NULL, size_t temp_len = 0) {
+	$1 = &temp_data;
+	$2 = &temp_len;
+}
+%typemap(argout) (void **mapped_data, size_t *data_len) {
+	if (*$1) {
+		$result = SWIG_AppendOutput(
+			$result,
+			PyBytes_FromStringAndSize((const char *)*$1, *$2));
+		munmap(*$1, *$2);
+	} else {
+		$result = SWIG_AppendOutput($result, SWIG_Py_Void());
+	}
+}
+
+/*
+ * semanage_module_install() and semanage_module_install_info() take a
+ * (char *data, size_t data_len) pair that is an opaque module blob
+ * (.pp / bzip2 / CIL / HLL), not a NUL-terminated C string.  Accept any
+ * Python object exposing the buffer protocol (bytes, bytearray, mmap, ...)
+ * as a single argument and derive the length from it.
+ */
+%typemap(in) (char *module_data, size_t data_len) (Py_buffer view) {
+	view.obj = NULL;
+	if (PyObject_GetBuffer($input, &view, PyBUF_SIMPLE) < 0)
+		SWIG_fail;
+	$1 = (char *)view.buf;
+	$2 = (size_t)view.len;
+}
+%typemap(freearg) (char *module_data, size_t data_len) {
+	PyBuffer_Release(&view$argnum);
+}
+%apply (char *module_data, size_t data_len) { (char *data, size_t data_len) };
 
 %typemap(in, numinputs=0) char **(char *temp=NULL) {
 	$1 = &temp;
-- 
2.55.0

