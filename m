Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310189;
	b=UXSqLlJRAzuieMYYpG8z57wJ/+3KxUT+++MmBX9cWZSll9TodvBHp4CxLpw1PUyXWSyE
	 MKKIF36KF3maYUUrjk+1pSWOtqA1xwzUnQO3/UF4uAtG/WyVRySlrZBGt5hclKFoJlTgT
	 7iWOt7OaU1aatCtoMyMhkk3LDa5nzO01fDpNmn3WbW6uXFky5Fsyje7DVfNG0mhIlAixA
	 0SBlGnE7CepkLaGq4QRSxD/18dLB/02JRlRcmFGZrq3PfMjHe3Y3IL3ir53lzGywjgvLo
	 +txCQZEgff3rXJloTI/4VRZzkG5Kr2CTUvlz3QUNh+acL7dlFnEH8go3RkPKqpG5Q6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310189;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=d7FkP83XB9fJESgYpPTCUOqui/RMk9adhgeEW5BH66E=;
	b=4+9mRgGoI+z4RmrCiKD/6hYJwp5DRvFsrytUAFAy3Hyt8Y8KalvfwB/GXdX/r0Vik9mx
	 vss8pgg7S2dF7ESQWgv0zrqAGyXPKkbqk2AXRpdwTV1l/m0npiK+dU2/k73nprIzU8JRq
	 H0SUsvVJXDrup+vQONBl0zKRp0y45WUMINvpNLd4CAlNhDfFCsathfQtMQbW23d6u59/r
	 mDx6954c9BlwkMTlqWRdRtkdcHo8v0OlVXpRt2gKdf3pAYrN4IpJhEMRja5RvKDM85VEI
	 WKxnuKCNbJAkHyxPL3UlUqVMyVsLipOQj5ABt+be9xaJJnhWC6QdxCEDmKWiYoe4Png==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b="upNc1/NP";
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3C606A333
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FC3C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=upNc1/NP
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794310187;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7FkP83XB9fJESgYpPTCUOqui/RMk9adhgeEW5BH66E=;
	b=upNc1/NPTGtZ8Jmo2kcfD6Zoksc4hdRdoHt27yGInka7YYR631c8cmdV6VUvJM2hYbzFXf
	yyfnrAI1Kze4pLBWNh5xbZ84JqYhM6AmnbRDFBpKHTYEZNp9k3nAZYfTJ38OvRSW5Nj763
	DytAnwG4yjjPINC27cg5vA4OLJP1sf+aDHtUGne/bC+juTx7sR1PpdqNP+4PK67UC8oOjn
	8AH7pHC9yUT3blsrSlu0PuqSk1RNxnN5xQ/jIRttk2+THTBoco0XlpHAoU6Qmf7WRocrUV
	mHopr0LXObAuXX1yyGZxq6NXMpfXWru3nKQUHPzhH35M/Ye0YTmeD3xhbRhzYA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 6/8] libselinux/man: document thread-safety caveats
Date: Tue, 10 Nov 2026 12:29:28 +0100
Message-ID: <20261110112931.99557-5-cgoettsche@seltendoof.de>
In-Reply-To: <20261110112931.99557-1-cgoettsche@seltendoof.de>
References: <20261110112931.99557-1-cgoettsche@seltendoof.de>
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

Add CAVEATS sections for functions operating on process-global state
without locking:

- selinux_current_policy_path() returns a static buffer, and the other
  path getters return pointers invalidated by selinux_set_policy_root()
  and selinux_reset_config(), which are themselves not thread-safe.
- set_selinuxmnt() and fini_selinuxmnt() modify the global selinuxfs
  mountpoint read by almost every other function.
- selinux_set_mapping() frees and rebuilds the class and permission
  mapping.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/selinux_binary_policy_path.3 | 13 +++++++++++++
 libselinux/man/man3/selinux_policy_root.3        |  8 ++++++++
 libselinux/man/man3/selinux_set_mapping.3        | 10 ++++++++++
 libselinux/man/man3/set_selinuxmnt.3             | 10 ++++++++++
 4 files changed, 41 insertions(+)

diff --git a/libselinux/man/man3/selinux_binary_policy_path.3 b/libselinux/man/man3/selinux_binary_policy_path.3
index 7e3e7614..09ae6b84 100644
--- a/libselinux/man/man3/selinux_binary_policy_path.3
+++ b/libselinux/man/man3/selinux_binary_policy_path.3
@@ -189,6 +189,19 @@ returns the contexts used by snapperd.
 .BR selinux_systemd_contexts_path ()
 returns the contexts used by systemd.
 .
+.SH CAVEATS
+.BR selinux_current_policy_path ()
+returns a pointer to a static buffer that is overwritten on each call and is
+therefore not reentrant.
+.sp
+The other functions return pointers into libselinux's cached configuration.
+That cache is recomputed without locking by
+.BR selinux_set_policy_root (3)
+and
+.BR selinux_reset_config (3),
+so these functions are not thread-safe with respect to those calls, and a
+previously returned pointer may become invalid once either of them is called.
+.
 .SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 .
diff --git a/libselinux/man/man3/selinux_policy_root.3 b/libselinux/man/man3/selinux_policy_root.3
index f44e020f..ed06e253 100644
--- a/libselinux/man/man3/selinux_policy_root.3
+++ b/libselinux/man/man3/selinux_policy_root.3
@@ -42,6 +42,14 @@ On failure, selinux_policy_root returns NULL.
 
 selinux_set_policy_root returns 0 on success or \-1 on failure.
 
+.
+.SH CAVEATS
+.BR selinux_set_policy_root ()
+and
+.BR selinux_reset_config ()
+are not thread-safe: each replaces the cached configuration (and the paths
+derived from it) without locking, so the caller must ensure that no other
+thread is calling into libselinux while either runs.
 .
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff --git a/libselinux/man/man3/selinux_set_mapping.3 b/libselinux/man/man3/selinux_set_mapping.3
index cb8279f8..f12027c5 100644
--- a/libselinux/man/man3/selinux_set_mapping.3
+++ b/libselinux/man/man3/selinux_set_mapping.3
@@ -92,6 +92,16 @@ and
 .B file
 class) will be identified by 1, 2, 4, and 8 respectively.  Classes and permissions not listed in the mapping cannot be used.
 .
+.SH CAVEATS
+.BR selinux_set_mapping ()
+frees and rebuilds a process-global mapping without locking. It is not
+thread-safe and must not run concurrently with any function that reads the
+mapping, such as
+.BR selinux_check_access (3)
+or the
+.BR security_compute_av (3)
+family.
+.
 .SH "AUTHOR"
 Originally Eamon Walsh.  Updated by Stephen Smalley <stephen.smalley.work@gmail.com>
 .
diff --git a/libselinux/man/man3/set_selinuxmnt.3 b/libselinux/man/man3/set_selinuxmnt.3
index 81312705..edb9dcca 100644
--- a/libselinux/man/man3/set_selinuxmnt.3
+++ b/libselinux/man/man3/set_selinuxmnt.3
@@ -39,6 +39,16 @@ kernel by reading
 It returns 1 if selinuxfs is present and 0 otherwise. If the check cannot be
 performed it returns 1, failing safe as if selinuxfs exists.
 .
+.SH CAVEATS
+.BR set_selinuxmnt ()
+and
+.BR fini_selinuxmnt ()
+modify (and, in the case of
+.BR fini_selinuxmnt (),
+free) the global selinuxfs mountpoint that almost every other libselinux
+function reads. They are not thread-safe and should be called only when no
+other thread is calling into libselinux.
+.
 .SH "AUTHOR"
 This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
 .
-- 
2.55.0

