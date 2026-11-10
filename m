Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310188;
	b=0eqb9SjLVfpxMwA1MCsJM6nHJP50iIWgpqrM/GFEGtRUnMlCkZyfdwwZI4FR1j3t0zX7
	 fT5/nee3DuZYKzLCI6yynvs62jq8bmvmbf7qfpKuUzmLwWCJE4VFeERg+EOiEKjQUKqHQ
	 eHhwavGqyiUdH6YO+uPnegNwAp4C5RZNoNmxejqiGsOm2tKh66RVL8vmvSXKHG9RGBS2R
	 Lhxq/pxM5sB7c6QSk5SIjvZ7exSIAqP4uj5+9L5KSUFVBvChk8fHgyVaLJ3QEy5E8rv3V
	 nE32jZ0t7M3wfPwiqhSAxJNPH27TbVc7r7AYDWjqTzJSYER9n4gvw144SJKlRmTeERQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310188;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Jnvd+1s3akKxyKvu9AuPz2kt8a6zYQInW+MGx6uXyBY=;
	b=rigztM/jBmmCYdDXCid3RRoIRxHw8XlN3nsaAKs0x2r2+j8yhK8ujHr4XGrzpweqAJo3
	 1YsqffbtainvxeQakZCZM1JMsLjdqVrst08dFesQB1pFukgG+/HivqgYzi/tyL2RHKANV
	 GqKHv1Ze30UzEoIqhGhnz1Sdz+RFcB+bA7Mtp/3xVvEtO1i023Qj9EHCN4LH+x+DP7qvT
	 BsoSuc+knJgeJ7V91C+fWWfYvUPDUCderonBCjWhWxc3ibSXqHnoM2Dkp2ppFyUcZmWTP
	 uhhn4c2xydRBKs9gDSLKrfD2eBPuihskcnHfKzoDMpyGVLAoJYl5y9L1OoHDxlvR+dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=PMDEKaAN;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A15606A31C
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10A15606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=PMDEKaAN
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794310186;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Jnvd+1s3akKxyKvu9AuPz2kt8a6zYQInW+MGx6uXyBY=;
	b=PMDEKaANzPAYrrsZOhaf1juhi7i7+sojsN8C8nMGhEoZuptZnRVg+5Qlv48jfWy0bvKe5M
	Rlxa/hjiuFOoKyKDAFFjuvRtc+waxJ1Zqs4lDwfWtwU1zkWfYk+X4S1jnorXmmWM3dRD4X
	WtP509OQOxrdx+5ytLBVf9dCPkIhyvsIUmAGORfg3go3+Q0mkhzhGXLUkiUB0V4vj3Z2nF
	/mdgKTCycHVwM1MNw+Ak+zif0xDYD40gqh88ZkpWWuRw32vMZd7iTB3nf85vBKTDnWIVMT
	BQtM7wx2rcpH7RAWDMq9E3AuN3vNa8p/8jqNgzpjXEM6I+DXo6s6OkwrVg9hzw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 2/8] libselinux/man: make set_selinuxmnt(3) the canonical mountpoint page
Date: Tue, 10 Nov 2026 12:29:24 +0100
Message-ID: <20261110112931.99557-1-cgoettsche@seltendoof.de>
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

The selinuxfs mountpoint functions are documented in init_selinuxmnt(3),
but init_selinuxmnt() is a static constructor that is neither exported
nor declared in any public header, and fini_selinuxmnt() is shown as
static although it is part of the public API.

Move the content to set_selinuxmnt(3), drop init_selinuxmnt() from it,
describe when setting the mountpoint explicitly is needed, and turn
init_selinuxmnt.3 into an alias so existing references keep working.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/fini_selinuxmnt.3 |  2 +-
 libselinux/man/man3/init_selinuxmnt.3 | 32 +---------------------
 libselinux/man/man3/set_selinuxmnt.3  | 38 ++++++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/libselinux/man/man3/fini_selinuxmnt.3 b/libselinux/man/man3/fini_selinuxmnt.3
index d7805c97..fe9a35cc 100644
--- a/libselinux/man/man3/fini_selinuxmnt.3
+++ b/libselinux/man/man3/fini_selinuxmnt.3
@@ -1 +1 @@
-.so man3/init_selinuxmnt.3
+.so man3/set_selinuxmnt.3
diff --git a/libselinux/man/man3/init_selinuxmnt.3 b/libselinux/man/man3/init_selinuxmnt.3
index 6c83698a..fe9a35cc 100644
--- a/libselinux/man/man3/init_selinuxmnt.3
+++ b/libselinux/man/man3/init_selinuxmnt.3
@@ -1,31 +1 @@
-.TH "init_selinuxmnt" "3" "21 Nov 2009" "" "SELinux API documentation"
-.SH "NAME"
-init_selinuxmnt \- initialize the global variable selinux_mnt
-.
-.SH "SYNOPSIS"
-.BI "static void init_selinuxmnt(void);"
-.sp
-.BI "static void fini_selinuxmnt(void);"
-.sp
-.BI "void set_selinuxmnt(const char *" mnt ");"
-.
-.SH "DESCRIPTION"
-.BR init_selinuxmnt ()
-initializes the global variable
-.I selinux_mnt
-to the selinuxfs mountpoint.
-
-.BR fini_selinuxmnt ()
-deinitializes the global variable
-.I selinux_mnt
-that stores the selinuxfs mountpoint.
-
-.BR set_selinuxmnt ()
-changes the selinuxfs mountpoint to
-.IR mnt .
-.
-.SH "AUTHOR"
-This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
-.
-.SH "SEE ALSO"
-.BR selinux (8),
+.so man3/set_selinuxmnt.3
diff --git a/libselinux/man/man3/set_selinuxmnt.3 b/libselinux/man/man3/set_selinuxmnt.3
index d7805c97..254f5d55 100644
--- a/libselinux/man/man3/set_selinuxmnt.3
+++ b/libselinux/man/man3/set_selinuxmnt.3
@@ -1 +1,37 @@
-.so man3/init_selinuxmnt.3
+.TH "set_selinuxmnt" "3" "2026-06-18" "Security Enhanced Linux" "SELinux API documentation"
+.SH "NAME"
+set_selinuxmnt, fini_selinuxmnt \- manage the selinuxfs
+mountpoint used by libselinux
+.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "void set_selinuxmnt(const char *" mnt ");"
+.sp
+.BI "void fini_selinuxmnt(void);"
+.
+.SH "DESCRIPTION"
+libselinux determines the selinuxfs mountpoint automatically when the library
+is loaded (in a constructor, before any API function is called) and stores it
+internally. The discovery is not repeated later. The functions below allow this
+mountpoint to be set explicitly or reset.
+
+.BR set_selinuxmnt ()
+sets the selinuxfs mountpoint explicitly to
+.IR mnt .
+This is normally determined automatically during libselinux initialization, but
+that is not always possible, e.g. for
+.BR init (8),
+which performs the initial mount of selinuxfs. An application that mounts
+selinuxfs after libselinux has been loaded must call
+.BR set_selinuxmnt ()
+afterwards, even if it has not called any other libselinux function yet.
+
+.BR fini_selinuxmnt ()
+clears the stored selinuxfs mountpoint and frees the associated memory.
+.
+.SH "AUTHOR"
+This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
+.
+.SH "SEE ALSO"
+.BR selinux (8)
-- 
2.55.0

