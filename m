Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310189;
	b=wPaB6QJRytIaFhDD+zzOj5lX4zAAI9c1kRdcjnih2rX00WxCK+HsiQM1R8Ss4Yg069Mi
	 fYTF+bkL0WMiPBm/scCKAeIaM0d884P5MOt26kwZrRtOtBJaKvHDhfLITNsJ0/dtL6ddg
	 FfLreFvOG06QNnTJQpSqutGqFDQeNrJnJ5d+cFvyYq5DSp8vaAib6ParPlZ7jrybGly46
	 UVm2omlYfAraFv7X23UFkS99X8Z7w8OoTpbThSI+TWoL/rBoyzWR2UbzJGUNZ1AiVtm7q
	 USRoFKXYiPrfi9HdhaSJewNLzVcVAocXb8u39OGHNffrx3jsG8e/MP+cMz6pFx+Yylw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310189;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/1Ct0J8uUN/1CvJpjOauUrpfOORRkFzHqg0W882cxTI=;
	b=Tbq3U1D8uPypl+GbB9tY1TdzUvKPvPlfMRC7m90YMVvEcNjzJ9o3Y4olScCuOYDA/Eb9
	 273E9WwctlNi3AYlXv+EWbV7M+YZPi6uDKratGNJqDTIyxTLDMhB+81jdvQ4M6nfkiTAS
	 SqUrSmnW3uMVg1sk0PmAoT6g3wIohWVMlQFVEb99sdXRdmKY5B+JVcafNG0uhNDTvPSf7
	 gGkGTidyyS1WrEh+YM1bMd4XPOSsr21GlRlMWfjVOuGRMyGBjdtw8fpAh8vywfXemasXc
	 U5kCikYopnvOKojbQtIi2fVJqaXXd667gfuGkwZl1haBMgp8c9dSMLi8GAWqLbBwcQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=A48ooYMQ;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F2606A32E
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A11F2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=A48ooYMQ
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794310187;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1Ct0J8uUN/1CvJpjOauUrpfOORRkFzHqg0W882cxTI=;
	b=A48ooYMQGNwCW8sAlLpN2EXPKEwkepBbvf1bfIYswXIix5NixIyL8RdNagKigubO/RdSnA
	O4+IGHDRyHM+5RiYFLQFFXTZoFv093imicH6Wa423oh7z7dEFK+Uj4ZE+9kK9dM3G598R2
	Vu99DKdc3R/mTVYaloHkPkLRCL/VKzcGxhXBvH3znUCdNHm5wtfh+PCsvKwTtXl2syih4r
	d2/qWDYktu4ZddWZhz/1xK14yhz/UvJyomVxfMLQpbdjXFjkkCpkKX6ehkc0Oc+S1Z0QZm
	PqGZDKC15LRfKNnwDRMRge6pcdfCwzeAiVIaU+ViXKCtCF2BkAGTa2pLFv88gg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 4/8] libselinux/man: document missing options, flags and ownership rules
Date: Tue, 10 Nov 2026 12:29:26 +0100
Message-ID: <20261110112931.99557-3-cgoettsche@seltendoof.de>
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

- selabel_open(3): list the global SELABEL_OPT_BASEONLY,
  SELABEL_OPT_PATH and SELABEL_OPT_SUBSET options.
- set_matchpathcon_flags(3): describe MATCHPATHCON_NOTRANS and
  MATCHPATHCON_VALIDATE; only MATCHPATHCON_BASEONLY was covered.
- security_load_policy(3): describe the return value of
  selinux_init_load_policy() and how init is expected to act on it
  together with *enforce.
- security_compute_av(3): state that the contexts returned by
  security_compute_create() and friends must be freed by the caller,
  matching the contract in the header.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/security_compute_av.3    | 23 ++++++++++++++++++++
 libselinux/man/man3/security_load_policy.3   |  9 ++++++++
 libselinux/man/man3/selabel_open.3           | 17 +++++++++++++++
 libselinux/man/man3/set_matchpathcon_flags.3 | 15 ++++++++++++-
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index 29459190..7845c42e 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -151,6 +151,27 @@ if an error occurred with errno set.
 is used to get the context of a kernel initial security identifier specified by 
 .I name
 
+The context returned in
+.I newcon
+by
+.BR security_compute_create (),
+.BR \%security_compute_create_name (),
+.BR security_compute_relabel ()
+and
+.BR security_compute_member (),
+and in
+.I con
+by
+.BR \%security_get_initial_context (),
+must be freed by the caller with
+.BR freecon (3).
+The NULL-terminated array of contexts returned in
+.I con
+by
+.BR security_compute_user ()
+must be freed with
+.BR freeconary (3).
+
 .BR security_compute_av_raw (),
 .BR security_compute_av_flags_raw (),
 .BR \%security_compute_create_raw (),
@@ -213,4 +234,6 @@ functions are direct kernel queries with no shared userspace state.
 .BR selinux_set_mapping (3),
 .BR getprevcon (3),
 .BR get_ordered_context_list (3),
+.BR freecon (3),
+.BR freeconary (3),
 .BR selinux (8)
diff --git a/libselinux/man/man3/security_load_policy.3 b/libselinux/man/man3/security_load_policy.3
index 18fcfbd4..d30f5a28 100644
--- a/libselinux/man/man3/security_load_policy.3
+++ b/libselinux/man/man3/security_load_policy.3
@@ -34,6 +34,15 @@ argument accordingly for the caller to use, sets the SELinux kernel
 enforcing status to match it, and loads the policy. It also internally
 handles the initial selinuxfs mount required to perform these actions.
 .sp
+The function returns 0 if everything including the policy load succeeds; in
+that case init is expected to re-exec itself in order to transition to the
+proper security context.  Otherwise it returns \-1, and init must check
+.I enforce
+to determine how to proceed: if enforcing
+.RI ( *enforce " > 0)"
+then init should halt the system, otherwise init may proceed normally without
+a re-exec.
+.sp
 It should also be noted that after the initial policy load, the SELinux
 kernel code cannot anymore be disabled and the selinuxfs cannot be
 unmounted using a call to
diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/selabel_open.3
index 3a496d59..c0978426 100644
--- a/libselinux/man/man3/selabel_open.3
+++ b/libselinux/man/man3/selabel_open.3
@@ -68,6 +68,23 @@ is used; a custom validation function can be provided via
 .BR selinux_set_callback (3).
 Note that an invalid context may not be treated as an error unless it is actually encountered during a lookup operation.
 .TP
+.B SELABEL_OPT_BASEONLY
+A non-null value for this option indicates that any local customizations to the
+backend data should be ignored.
+.TP
+.B SELABEL_OPT_PATH
+A non-null value for this option specifies an alternate path for the backend to
+use when loading its configuration data, in lieu of the default for the active
+policy.  The exact interpretation is backend-specific; see the backend manual
+pages listed under
+.B BACKENDS
+below.
+.TP
+.B SELABEL_OPT_SUBSET
+A non-null value for this option selects a subset of the search space as an
+optimization (file contexts backend only); see
+.BR selabel_file (5).
+.TP
 .B SELABEL_OPT_DIGEST
 A non-null value for this option enables the generation of an SHA1 digest of
 the spec files loaded as described in
diff --git a/libselinux/man/man3/set_matchpathcon_flags.3 b/libselinux/man/man3/set_matchpathcon_flags.3
index 586f28e6..5b0f5be0 100644
--- a/libselinux/man/man3/set_matchpathcon_flags.3
+++ b/libselinux/man/man3/set_matchpathcon_flags.3
@@ -24,7 +24,20 @@ or
 If the 
 .B MATCHPATHCON_BASEONLY
 flag is set, then only the base file contexts configuration file
-will be processed, not any dynamically generated entries or local customizations.
+will be processed, not any dynamically generated entries or local
+customizations.
+If the
+.B MATCHPATHCON_NOTRANS
+flag is set, then no context translation is performed and subsequent
+.BR matchpathcon (3)
+and
+.BR matchpathcon_index (3)
+lookups return raw contexts, as if their raw counterparts had been called.
+If the
+.B MATCHPATHCON_VALIDATE
+flag is set, then contexts are validated (and canonicalized where possible)
+when the configuration is loaded rather than lazily upon the first lookup
+that returns them.
 .sp
 
 .BR set_matchpathcon_invalidcon ()
-- 
2.55.0

