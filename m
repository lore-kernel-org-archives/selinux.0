Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4149261B70
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778117907; cv=none; b=UVccRsqENxtuyoDfh9qW8MxEExcPd0+NAH/IXspOQ0r39p/WGBWvWQUCp10aHQfVDR6eQ7tGTIzqCqQgzTbwAndThySg9p6l47RuQk3/OMQV1b6A+pmIeiZbVXulPRd5HYXt73gaVoEhKmhUYBL8NmCg/DbNOmNFfkhSL/sPH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778117907; c=relaxed/simple;
	bh=gy+tlqX6VFYkUMbYENwo/xRwkmawlRW8uR4E0tOo/Eg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UJOtJwnar/hQAHkFWrz8QC+2afJi9O2oB1t+ns2GOmAwQjvlH5Mb3dg7bU1y55y0XRgDMteTL9WWxwTnP29BPCUySUKVua4dq3/lqdeAMixZf+fHcCn6eWuNUC/7sSTRzzKPevwZx5tu14tIM3SuevYbni9eBtoMyxZDPlA8OT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=R17+zjeM; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="R17+zjeM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EyBzMH9OzF4rvOH/LhKjdntxjW9ZvYbQgpqgG9ofTPI=; b=R17+zjeMz/AGnvHwcPjRW+IOEF
	Pd9JgqDTdALeIdMwFUTWGmLctgc223i+nHMNlDeBhfrtsNejsLt+KD78HEiizH5YieQiYkWC4DrFh
	UWnPKFZqhczA/VFcC1s6wYS1nfK2Ww0/acPeZlvudNYD3n5D1qVcJYJrTJKjZXInlf6j5aUYLk1NU
	PamwRsydaIWWTdfY8D9tePg2EcI3HAvAg9MUA5lSatm+deWsovrazUsLVxXucMwI9+eroopPQREFT
	H/pgUSxyVd4I4rFGSNPy+SesbJU2WT2hU1Q5nWseiNvXtmIQ2KWiQMNef3ZKSFMQSae/pkZzad7QT
	iZJZx4Nw==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11288 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKngz-00000005AQY-25RK
	for selinux@vger.kernel.org;
	Thu, 07 May 2026 04:38:21 +0300
Date: Thu, 7 May 2026 04:38:19 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux-list <selinux@vger.kernel.org>
Subject: SELinux userspace does not build on Fedora 44
Message-ID: <afvtC0DVQkt6rtAD@14-5A-FC-31-E8-67>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello!

I have problems compiling SELinux userspace on Fedora 44.
I mean the main branch. The compiler is:

gcc (GCC) 16.1.1 20260501 (Red Hat 16.1.1-1)
Copyright (C) 2026 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


The first error is:

-------------------------------------------------------------------------------
selinux_config.c: In function ‘selinux_set_policy_root’:
selinux_config.c:284:29: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  284 |         char *policy_type = strrchr(path, '/');
      |                             ^~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [Makefile:179: selinux_config.o] Error 1
-------------------------------------------------------------------------------

It can be fixed by this:

-------------------------------------------------------------------------------
--- selinux/libselinux/src/selinux_config.c	2026-05-02 01:09:23.084896619 +0300
+++ selinux-buildaus/libselinux/src/selinux_config.c	2026-05-07 03:52:10.344519900 +0300
@@ -281,7 +281,7 @@
 int selinux_set_policy_root(const char *path)
 {
 	int i;
-	char *policy_type = strrchr(path, '/');
+	const char *policy_type = strrchr(path, '/');
 	if (!policy_type) {
 		errno = EINVAL;
 		return -1;
-------------------------------------------------------------------------------

The second error is:

-------------------------------------------------------------------------------
direct_api.c: In function ‘semanage_direct_install_file’:
direct_api.c:1781:27: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
 1781 |                 separator = strrchr(filename, '.');
      |                           ^
direct_api.c:1791:19: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
 1791 |         separator = strrchr(filename, '.');
      |                   ^
cc1: all warnings being treated as errors
make[2]: *** [Makefile:114: direct_api.o] Error 1
-------------------------------------------------------------------------------

It can be fixed by this. Note: I did not add 'const' qualifier to
'separator' because the string is modified in the function.

-------------------------------------------------------------------------------
--- selinux/libsemanage/src/direct_api.c	2026-05-02 01:09:23.095896604 +0300
+++ selinux-buildaus/libsemanage/src/direct_api.c	2026-05-07 04:01:26.969729078 +0300
@@ -1755,7 +1755,7 @@
 
 	int retval = -1;
 	char *path = NULL;
-	const char *filename;
+	char *filename;
 	const char *lang_ext = NULL;
 	char *module_name = NULL;
 	char *separator;
-------------------------------------------------------------------------------

The third error is:

-------------------------------------------------------------------------------
semanage_store.c: In function ‘semanage_exec_prog’:
semanage_store.c:1307:16: error: variable ‘a’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
 1307 |         char **a;
      |                ^
semanage_store.c:1265:15: error: variable ‘new_s’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
 1265 |         char *new_s = realloc(s, len + 2);
      |               ^~~~~
semanage_store.c:1265:15: error: variable ‘new_s’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
cc1: all warnings being treated as errors
make[2]: *** [Makefile:114: semanage_store.o] Error 1
-------------------------------------------------------------------------------

I see a vfork() there I but am unable to determine whether this
error is for real or not. As temporary work-around I added:

  -Wno-clobbered 

to the Makefile.


-------------------------------------------------------------------------------

The fourth error is:

-------------------------------------------------------------------------------

utilities.c: In function ‘semanage_str_replace’:
utilities.c:248:16: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  248 |         for (p = strstr(src, search); p != NULL; p = strstr(p + slen, search)) {
      |                ^
utilities.c:265:16: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  265 |         for (p = strstr(src, search); p != NULL; p = strstr(psrc, search)) {
      |                ^
utilities.c:265:52: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  265 |         for (p = strstr(src, search); p != NULL; p = strstr(psrc, search)) {
      |                                                    ^
utilities.c: In function ‘semanage_basename’:
utilities.c:358:19: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  358 |         char *p = strrchr(filename, '/');
      |                   ^~~~~~~

-------------------------------------------------------------------------------

I did the following to fix:

-------------------------------------------------------------------------------
--- selinux/libsemanage/src/utilities.c 2026-05-02 01:09:23.099896599 +0300
+++ selinux-buildaus/libsemanage/src/utilities.c        2026-05-07 04:24:08.992732849 +0300
@@ -234,7 +234,8 @@
                           const char *src, size_t lim)
 {
        size_t count = 0, slen, rlen, newsize;
-       char *p, *pres, *result;
+       const char *p;
+       char *pres, *result;
        const char *psrc;
 
        slen = strlen(search);
@@ -353,8 +354,8 @@
 #ifdef __GNUC__
 __attribute__((nonnull))
 #endif
-char *semanage_basename(const char *filename)
+const char *semanage_basename(const char *filename)
 {
-       char *p = strrchr(filename, '/');
-       return p ? p + 1 : (char *)filename;
+       const char *p = strrchr(filename, '/');
+       return p ? p + 1 : filename;
 }
-------------------------------------------------------------------------------
--- selinux/libsemanage/src/utilities.h 2026-05-02 01:09:23.099896599 +0300
+++ selinux-buildaus/libsemanage/src/utilities.h        2026-05-07 04:25:03.279160082 +0300
@@ -167,6 +167,6 @@
 #ifdef __GNUC__
 __attribute__((nonnull))
 #endif
-char *semanage_basename(const char *filename);
+const char *semanage_basename(const char *filename);
 
 #endif
-------------------------------------------------------------------------------

The fifth error:

-------------------------------------------------------------------------------
secon.c: In function ‘my_getXcon_raw’:
secon.c:365:29: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  365 |                 char *tmp = strchr(ptr, '\n');
      |                             ^~~~~~
cc1: all warnings being treated as errors
make[2]: *** [<builtin>: secon.o] Error 1
-------------------------------------------------------------------------------

Fix:

-------------------------------------------------------------------------------
--- selinux/policycoreutils/secon/secon.c       2026-05-02 01:09:23.152597184 +0300
+++ selinux-buildaus/policycoreutils/secon/secon.c      2026-05-07 04:30:27.330279405 +0300
@@ -348,7 +348,7 @@
 {
        char buf[4096];
        FILE *fp = NULL;
-       const char *ptr = NULL;
+       char *ptr = NULL;
 
        snprintf(buf, sizeof(buf), "%s/%ld/attr/%s", "/proc", (long int)pid,
                 val);
-------------------------------------------------------------------------------

After these changes, the build completed, but I am not at all
sure whether the fixes are correct.

br,
KK
