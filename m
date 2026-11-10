Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310190;
	b=HW04ejEKukw1WXXojCt467xMKDDjkCfA30R8ugV/NOzM9Q9YZ87BV99mRHjpX8H/yJvw
	 /4OvMigdBdcVtZK9wvKsU53YVYiRFHLV5fR5BTfwH4kuCcPkWyeSY0ThkCrcLXRjrYHSn
	 tRuX0iO1azdjkH2zr2jfTSsrnDA2b1LqAvY+3wtVZAugxu3kAYa+nx0zxW2EK71luAs6H
	 ZeTDT2YA664saq4cCaPmNdVfro4x3O04mWVYMsfOA6B7H3mQP0jvZb5/SyYXsaQF/oePp
	 UPsEv7d7+tjnH4b9ndn0zb6Vdd9UPAY3/cSPVOQtU04D6WjGGvnfZafbr4Vdlozduug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310190;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8+tuBZMmAVlfdDPf6rwfwTB2poNw2O/PdpLRi5OMFmk=;
	b=br0OOuvTKawdIz7v+g4UsnEmUbnDYKEHxG4M8CEZ5KfUTc7CPQPJvgbGObn3oNB/b2Qa
	 Kz4Pix0UUCiNYVa4DwitPeGhdo8aKMw5FeZbmGg+9D0I9XQtX2L53qfImJfFC5U2DpuL/
	 N58VRykN3ZwznkTA7pKlXR2dLpXpb2g5Lyn1hv7kSp4imtvuU9K3EQ40+yvfnB4PZ66RI
	 HUFUakHFIgssLXYEHRdIxUDht5rwGvA4iFVMSc+Df72Q+Eus77ooG92V7qhdDAQ/PIjRl
	 VlES5z7HxNIB9g6FKnVOGQZFKcNrgXCD4lf0pDmIZVBjx1/fXPuSwqRMhvvb4N1qUiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=dCqJ52uW;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D507606A321
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D507606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=dCqJ52uW
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794310186;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+tuBZMmAVlfdDPf6rwfwTB2poNw2O/PdpLRi5OMFmk=;
	b=dCqJ52uWakWYNITdKThVP46WBpHakaeVsJ3O+TUKWjuLzd/Ga+9GYmdGKcISfsNUpksPUO
	cvyVHcjTavz7HfC6J/SbY1McmT6XzSD6qdznybf9/qMjtFWxjqDbc72rs5mCd+9zrBS9gP
	OzZuhR9ulac4x5tR/CypiqUXX1k9kkr19D0Dzrp7F24Bn01czUo2rpSyWdvciPm3gartX6
	FdV1PaY7BE4YUCAyHRW5Zg4kZijRU2Oo2mXSDAUKSOJ8wzITyC4EmsFiyL0QU+yCsBOCyD
	ALhtUKQTB+vvkX8ZYi796WGqj9YCCvekj5XYLOec0ISSAMo+8P1iSfcJw9Lr0w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 3/8] libselinux/man: document previously undocumented functions
Date: Tue, 10 Nov 2026 12:29:25 +0100
Message-ID: <20261110112931.99557-2-cgoettsche@seltendoof.de>
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

Add documentation for exported functions that had none.

On existing pages, with .so aliases where missing:

- getseuser() in getseuserbyname(3)
- context_to_str() in context_new(3)
- set_matchpathcon_canoncon() in set_matchpathcon_flags(3)
- security_canonicalize_context() and its raw variant in
  security_check_context(3), which also gains a RETURN VALUE section
- selinux_get_callback() in selinux_set_callback(3)
- selinux_flush_class_cache() in security_class_to_string(3)
- selinuxfs_exists() in set_selinuxmnt(3)
- selinux_reset_config() in selinux_policy_root(3)
- selabel_hash_all_partial_matches() in
  selabel_get_digests_all_partial_matches(3)
- avc_context_to_sid_raw() and avc_sid_to_context_raw() in
  avc_context_to_sid(3)
- the remaining policy configuration path getters in
  selinux_binary_policy_path(3): selinux_homedir_context_path(),
  selinux_file_context_subs_path(),
  selinux_file_context_subs_dist_path(),
  selinux_customizable_types_path(), selinux_booleans_subs_path(),
  selinux_translations_path(), selinux_virtual_domain_context_path(),
  selinux_virtual_image_context_path(), selinux_lxc_contexts_path(),
  selinux_openrc_contexts_path(), selinux_openssh_contexts_path(),
  selinux_snapperd_contexts_path() and selinux_systemd_contexts_path()

On new pages:

- selinux_restorecon_get_relabeled_files(3)
- selinux_trans_to_raw_context(3), also covering
  selinux_raw_to_trans_context()
- realpath_not_final(3)
- selabel_cmp(3)

Also add the missing alias for matchpathcon_init_prefix(), which is
already described in matchpathcon(3).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/avc_context_to_sid.3      | 12 ++-
 libselinux/man/man3/avc_context_to_sid_raw.3  |  1 +
 libselinux/man/man3/avc_sid_to_context_raw.3  |  1 +
 libselinux/man/man3/context_new.3             | 12 ++-
 libselinux/man/man3/context_to_str.3          |  1 +
 libselinux/man/man3/getseuser.3               |  1 +
 libselinux/man/man3/getseuserbyname.3         | 25 ++++--
 .../man/man3/matchpathcon_init_prefix.3       |  1 +
 libselinux/man/man3/realpath_not_final.3      | 30 +++++++
 .../man/man3/security_canonicalize_context.3  |  1 +
 .../man3/security_canonicalize_context_raw.3  |  1 +
 libselinux/man/man3/security_check_context.3  | 36 +++++++--
 .../man/man3/security_class_to_string.3       | 17 +++-
 libselinux/man/man3/selabel_cmp.3             | 50 ++++++++++++
 .../selabel_get_digests_all_partial_matches.3 | 25 +++++-
 .../man3/selabel_hash_all_partial_matches.3   |  1 +
 .../man/man3/selinux_binary_policy_path.3     | 81 ++++++++++++++++++-
 .../man/man3/selinux_booleans_subs_path.3     |  1 +
 .../man3/selinux_customizable_types_path.3    |  1 +
 .../selinux_file_context_subs_dist_path.3     |  1 +
 .../man/man3/selinux_file_context_subs_path.3 |  1 +
 .../man/man3/selinux_flush_class_cache.3      |  1 +
 libselinux/man/man3/selinux_get_callback.3    |  1 +
 .../man/man3/selinux_lxc_contexts_path.3      |  1 +
 .../man/man3/selinux_openrc_contexts_path.3   |  1 +
 .../man/man3/selinux_openssh_contexts_path.3  |  1 +
 libselinux/man/man3/selinux_policy_root.3     | 15 +++-
 .../man/man3/selinux_raw_to_trans_context.3   |  1 +
 libselinux/man/man3/selinux_reset_config.3    |  1 +
 libselinux/man/man3/selinux_restorecon.3      |  6 +-
 .../selinux_restorecon_get_relabeled_files.3  | 32 ++++++++
 .../selinux_restorecon_get_skipped_errors.3   |  4 +-
 libselinux/man/man3/selinux_set_callback.3    | 10 ++-
 .../man/man3/selinux_snapperd_contexts_path.3 |  1 +
 .../man/man3/selinux_systemd_contexts_path.3  |  1 +
 .../man/man3/selinux_trans_to_raw_context.3   | 43 ++++++++++
 .../man/man3/selinux_translations_path.3      |  1 +
 .../selinux_virtual_domain_context_path.3     |  1 +
 .../man3/selinux_virtual_image_context_path.3 |  1 +
 libselinux/man/man3/selinuxfs_exists.3        |  1 +
 .../man/man3/set_matchpathcon_canoncon.3      |  1 +
 libselinux/man/man3/set_matchpathcon_flags.3  | 21 ++++-
 libselinux/man/man3/set_selinuxmnt.3          | 11 ++-
 43 files changed, 428 insertions(+), 28 deletions(-)
 create mode 100644 libselinux/man/man3/avc_context_to_sid_raw.3
 create mode 100644 libselinux/man/man3/avc_sid_to_context_raw.3
 create mode 100644 libselinux/man/man3/context_to_str.3
 create mode 100644 libselinux/man/man3/getseuser.3
 create mode 100644 libselinux/man/man3/matchpathcon_init_prefix.3
 create mode 100644 libselinux/man/man3/realpath_not_final.3
 create mode 100644 libselinux/man/man3/security_canonicalize_context.3
 create mode 100644 libselinux/man/man3/security_canonicalize_context_raw.3
 create mode 100644 libselinux/man/man3/selabel_cmp.3
 create mode 100644 libselinux/man/man3/selabel_hash_all_partial_matches.3
 create mode 100644 libselinux/man/man3/selinux_booleans_subs_path.3
 create mode 100644 libselinux/man/man3/selinux_customizable_types_path.3
 create mode 100644 libselinux/man/man3/selinux_file_context_subs_dist_path.3
 create mode 100644 libselinux/man/man3/selinux_file_context_subs_path.3
 create mode 100644 libselinux/man/man3/selinux_flush_class_cache.3
 create mode 100644 libselinux/man/man3/selinux_get_callback.3
 create mode 100644 libselinux/man/man3/selinux_lxc_contexts_path.3
 create mode 100644 libselinux/man/man3/selinux_openrc_contexts_path.3
 create mode 100644 libselinux/man/man3/selinux_openssh_contexts_path.3
 create mode 100644 libselinux/man/man3/selinux_raw_to_trans_context.3
 create mode 100644 libselinux/man/man3/selinux_reset_config.3
 create mode 100644 libselinux/man/man3/selinux_restorecon_get_relabeled_files.3
 create mode 100644 libselinux/man/man3/selinux_snapperd_contexts_path.3
 create mode 100644 libselinux/man/man3/selinux_systemd_contexts_path.3
 create mode 100644 libselinux/man/man3/selinux_trans_to_raw_context.3
 create mode 100644 libselinux/man/man3/selinux_translations_path.3
 create mode 100644 libselinux/man/man3/selinux_virtual_domain_context_path.3
 create mode 100644 libselinux/man/man3/selinux_virtual_image_context_path.3
 create mode 100644 libselinux/man/man3/selinuxfs_exists.3
 create mode 100644 libselinux/man/man3/set_matchpathcon_canoncon.3

diff --git a/libselinux/man/man3/avc_context_to_sid.3 b/libselinux/man/man3/avc_context_to_sid.3
index e66c8913..20a4eb4f 100644
--- a/libselinux/man/man3/avc_context_to_sid.3
+++ b/libselinux/man/man3/avc_context_to_sid.3
@@ -3,7 +3,7 @@
 .\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2004
 .TH "avc_context_to_sid" "3" "27 May 2004" "" "SELinux API documentation"
 .SH "NAME"
-avc_context_to_sid, avc_sid_to_context, avc_get_initial_sid \- obtain and manipulate SELinux security ID's
+avc_context_to_sid, avc_context_to_sid_raw, avc_sid_to_context, avc_sid_to_context_raw, avc_get_initial_sid \- obtain and manipulate SELinux security ID's
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -12,8 +12,12 @@ avc_context_to_sid, avc_sid_to_context, avc_get_initial_sid \- obtain and manipu
 .sp
 .BI "int avc_context_to_sid(const char *" ctx ", security_id_t *" sid ");"
 .sp
+.BI "int avc_context_to_sid_raw(const char *" ctx ", security_id_t *" sid ");"
+.sp
 .BI "int avc_sid_to_context(security_id_t " sid ", char **" ctx ");"
 .sp
+.BI "int avc_sid_to_context_raw(security_id_t " sid ", char **" ctx ");"
+.sp
 .BI "int avc_get_initial_sid(const char *" name ", security_id_t *" sid ");"
 .
 .SH "DESCRIPTION"
@@ -36,6 +40,12 @@ The user must free the copy with
 .BR avc_get_initial_sid ()
 returns a SID for the kernel initial security identifier specified by 
 .IR name .
+
+.BR avc_context_to_sid_raw ()
+and
+.BR avc_sid_to_context_raw ()
+behave identically to their non-raw counterparts but do not perform context
+translation.
 .
 .SH "RETURN VALUE"
 .BR avc_context_to_sid (),
diff --git a/libselinux/man/man3/avc_context_to_sid_raw.3 b/libselinux/man/man3/avc_context_to_sid_raw.3
new file mode 100644
index 00000000..d7c3e66e
--- /dev/null
+++ b/libselinux/man/man3/avc_context_to_sid_raw.3
@@ -0,0 +1 @@
+.so man3/avc_context_to_sid.3
diff --git a/libselinux/man/man3/avc_sid_to_context_raw.3 b/libselinux/man/man3/avc_sid_to_context_raw.3
new file mode 100644
index 00000000..d7c3e66e
--- /dev/null
+++ b/libselinux/man/man3/avc_sid_to_context_raw.3
@@ -0,0 +1 @@
+.so man3/avc_context_to_sid.3
diff --git a/libselinux/man/man3/context_new.3 b/libselinux/man/man3/context_new.3
index 04522366..197fb5f8 100644
--- a/libselinux/man/man3/context_new.3
+++ b/libselinux/man/man3/context_new.3
@@ -1,6 +1,6 @@
 .TH "context_new" "3" "20 December 2011" "dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
-context_new, context_str, context_free, context_type_get, context_type_set, context_range_get, context_range_set,context_role_get, context_role_set, context_user_get, context_user_set \- Routines to manipulate SELinux security contexts
+context_new, context_str, context_to_str, context_free, context_type_get, context_type_set, context_range_get, context_range_set, context_role_get, context_role_set, context_user_get, context_user_set \- Routines to manipulate SELinux security contexts
 .
 .SH "SYNOPSIS"
 .B #include <selinux/context.h>
@@ -9,6 +9,8 @@ context_new, context_str, context_free, context_type_get, context_type_set, cont
 .sp
 .BI "const char * context_str(context_t " con );
 .sp
+.BI "char * context_to_str(context_t " con );
+.sp
 .BI "void context_free(context_t " con );
 .sp
 .BI "const char * context_type_get(context_t " con );
@@ -45,6 +47,14 @@ or
 for the same
 .BR context_t* .
 
+.BR context_to_str ()
+is similar to
+.BR context_str ()
+but returns a copy of the string value of the
+.BR context_t ;
+the caller owns the returned string and must free it with
+.BR free (3).
+
 .BR context_free ()
 frees the storage used by a context.
 
diff --git a/libselinux/man/man3/context_to_str.3 b/libselinux/man/man3/context_to_str.3
new file mode 100644
index 00000000..f4f03a6d
--- /dev/null
+++ b/libselinux/man/man3/context_to_str.3
@@ -0,0 +1 @@
+.so man3/context_new.3
diff --git a/libselinux/man/man3/getseuser.3 b/libselinux/man/man3/getseuser.3
new file mode 100644
index 00000000..4c69fad2
--- /dev/null
+++ b/libselinux/man/man3/getseuser.3
@@ -0,0 +1 @@
+.so man3/getseuserbyname.3
diff --git a/libselinux/man/man3/getseuserbyname.3 b/libselinux/man/man3/getseuserbyname.3
index c231e65f..c0515dd9 100644
--- a/libselinux/man/man3/getseuserbyname.3
+++ b/libselinux/man/man3/getseuserbyname.3
@@ -1,23 +1,38 @@
 .TH "getseuserbyname" "3" "29 September 2005" "dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
-getseuserbyname \- get SELinux username and level for a given Linux username
+getseuserbyname, getseuser \- get SELinux username and level for a given Linux username
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int getseuserbyname(const char *" linuxuser ", char **" selinuxuser ", char **" level ");
+.BI "int getseuserbyname(const char *" linuxuser ", char **" seuser ", char **" level ");"
+.sp
+.BI "int getseuser(const char *" username ", const char *" service ", char **" r_seuser ", char **" r_level ");"
 .
 .SH "DESCRIPTION"
 .BR getseuserbyname ()
-retrieves the SELinux username and security level associated with 
+retrieves the SELinux username and security level associated with
 a given Linux username.  The SELinux username and security level can
-then be passed to other libselinux functions such as 
+then be passed to other libselinux functions such as
 .BR \%get_ordered_context_list_with_level (3)
 and
 .BR \%get_default_context_with_level (3).
 
 The returned SELinux username and level should be freed by the caller
-using free.  
+using free.
+
+.BR getseuser ()
+is identical to
+.BR getseuserbyname ()
+but additionally takes a
+.I service
+name, allowing a service-specific mapping (see
+.BR service_seusers (5))
+to override the result.  The returned
+.I r_seuser
+and
+.I r_level
+strings should be freed by the caller using free.
 .
 .SH "RETURN VALUE"
 On success, 0 is returned.
diff --git a/libselinux/man/man3/matchpathcon_init_prefix.3 b/libselinux/man/man3/matchpathcon_init_prefix.3
new file mode 100644
index 00000000..cd5df2e1
--- /dev/null
+++ b/libselinux/man/man3/matchpathcon_init_prefix.3
@@ -0,0 +1 @@
+.so man3/matchpathcon.3
diff --git a/libselinux/man/man3/realpath_not_final.3 b/libselinux/man/man3/realpath_not_final.3
new file mode 100644
index 00000000..9d9d25a6
--- /dev/null
+++ b/libselinux/man/man3/realpath_not_final.3
@@ -0,0 +1,30 @@
+.TH "realpath_not_final" "3" "2026-06-18" "Security Enhanced Linux" "SELinux API documentation"
+.SH "NAME"
+realpath_not_final \- resolve all components of a path except the final one
+.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int realpath_not_final(const char *" name ", char *" resolved_path ");"
+.
+.SH "DESCRIPTION"
+.BR realpath_not_final ()
+resolves all of the symbolic links and relative components of
+.IR name ,
+but, unlike
+.BR realpath (3),
+does not resolve the final path component if it is a symbolic link.  The
+resolved path is stored in
+.IR resolved_path ,
+which must point to a buffer of at least
+.B PATH_MAX
+bytes.
+.
+.SH "RETURN VALUE"
+On success, zero is returned.  On error, \-1 is returned and
+.I errno
+is set appropriately.
+.
+.SH "SEE ALSO"
+.BR selinux (8),
+.BR realpath (3)
diff --git a/libselinux/man/man3/security_canonicalize_context.3 b/libselinux/man/man3/security_canonicalize_context.3
new file mode 100644
index 00000000..ee93986e
--- /dev/null
+++ b/libselinux/man/man3/security_canonicalize_context.3
@@ -0,0 +1 @@
+.so man3/security_check_context.3
diff --git a/libselinux/man/man3/security_canonicalize_context_raw.3 b/libselinux/man/man3/security_canonicalize_context_raw.3
new file mode 100644
index 00000000..ee93986e
--- /dev/null
+++ b/libselinux/man/man3/security_canonicalize_context_raw.3
@@ -0,0 +1 @@
+.so man3/security_check_context.3
diff --git a/libselinux/man/man3/security_check_context.3 b/libselinux/man/man3/security_check_context.3
index 213ac282..1c94b875 100644
--- a/libselinux/man/man3/security_check_context.3
+++ b/libselinux/man/man3/security_check_context.3
@@ -1,6 +1,6 @@
 .TH "security_check_context" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
-security_check_context \- check the validity of a SELinux context
+security_check_context, security_canonicalize_context \- check the validity of, or canonicalize, a SELinux context
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -8,16 +8,38 @@ security_check_context \- check the validity of a SELinux context
 .BI "int security_check_context(const char *" con );
 .sp
 .BI "int security_check_context_raw(const char *" con );
+.sp
+.BI "int security_canonicalize_context(const char *" con ", char **" canoncon );
+.sp
+.BI "int security_canonicalize_context_raw(const char *" con ", char **" canoncon );
 .
 .SH "DESCRIPTION"
 .BR security_check_context ()
-returns 0 if SELinux is running and the context is valid, otherwise it
-returns \-1.
+checks whether the context
+.I con
+is valid in the active policy on a SELinux system.
+
+.BR security_canonicalize_context ()
+returns the canonical form of the context
+.I con
+in the memory referenced by
+.IR canoncon ,
+which the caller must free with
+.BR freecon (3).
+The canonical form is the context as the kernel would return it after
+validating and normalizing
+.IR con .
 
 .BR security_check_context_raw ()
-behaves identically to
-.BR \%security_check_context ()
-but does not perform context translation.
+and
+.BR security_canonicalize_context_raw ()
+behave identically to their non-raw counterparts but do not perform context
+translation.
+.
+.SH "RETURN VALUE"
+On success, zero is returned.  On error, \-1 is returned and
+.I errno
+is set appropriately.
 .
 .SH "SEE ALSO"
-.BR selinux "(8)"
+.BR selinux "(8), " freecon "(3)"
diff --git a/libselinux/man/man3/security_class_to_string.3 b/libselinux/man/man3/security_class_to_string.3
index 02afa093..03df6128 100644
--- a/libselinux/man/man3/security_class_to_string.3
+++ b/libselinux/man/man3/security_class_to_string.3
@@ -5,8 +5,11 @@
 .SH "NAME"
 security_class_to_string, security_av_perm_to_string, string_to_security_class, string_to_av_perm, security_av_string, mode_to_security_class \- convert
 between SELinux class and permission values and string names.
-.
-print_access_vector \- display an access vector in human-readable form. 
+.br
+print_access_vector \- display an access vector in human-readable form.
+.br
+selinux_flush_class_cache \- flush the userspace class and permission mapping
+cache.
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -24,6 +27,8 @@ print_access_vector \- display an access vector in human-readable form.
 .BI "access_vector_t string_to_av_perm(security_class_t " tclass ", const char *" name ");"
 .sp
 .BI "void print_access_vector(security_class_t " tclass ", access_vector_t " av ");"
+.sp
+.BI "void selinux_flush_class_cache(void);"
 .
 .SH "DESCRIPTION"
 .BR security_class_to_string ()
@@ -68,6 +73,10 @@ or zero if no such value exists.
 .BR print_access_vector ()
 displays an access vector in human-readable form on the standard output
 stream.
+
+.BR selinux_flush_class_cache ()
+flushes the cached mappings between class and permission string names and their
+policy values, e.g. after a policy reload.
 .
 .SH "RETURN VALUE"
 .BR security_av_string ()
@@ -75,7 +84,9 @@ returns zero on success or \-1 on error with
 .I errno
 set appropriately.
 .BR print_access_vector ()
-does not return a value. All other functions return zero or NULL on error.
+and
+.BR selinux_flush_class_cache ()
+do not return a value. All other functions return zero or NULL on error.
 .
 .SH "ERRORS"
 .TP
diff --git a/libselinux/man/man3/selabel_cmp.3 b/libselinux/man/man3/selabel_cmp.3
new file mode 100644
index 00000000..c87511e1
--- /dev/null
+++ b/libselinux/man/man3/selabel_cmp.3
@@ -0,0 +1,50 @@
+.TH "selabel_cmp" "3" "2026-06-18" "Security Enhanced Linux" "SELinux API documentation"
+.SH "NAME"
+selabel_cmp \- compare two SELinux labeling handle configurations
+.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.br
+.B #include <selinux/label.h>
+.sp
+.BI "enum selabel_cmp_result selabel_cmp(const struct selabel_handle *" h1 ,
+.in +\w'enum selabel_cmp_result selabel_cmp('u
+.BI "const struct selabel_handle *" h2 ");"
+.in
+.
+.SH "DESCRIPTION"
+.BR selabel_cmp ()
+compares the two labeling configurations referenced by the handles
+.I h1
+and
+.IR h2 ,
+which must have been returned by
+.BR selabel_open (3).
+.
+.SH "RETURN VALUE"
+One of the following values is returned:
+.TP
+.B SELABEL_SUBSET
+.I h1
+is a subset of
+.IR h2 .
+.TP
+.B SELABEL_EQUAL
+.I h1
+is identical to
+.IR h2 .
+.TP
+.B SELABEL_SUPERSET
+.I h1
+is a superset of
+.IR h2 .
+.TP
+.B SELABEL_INCOMPARABLE
+.I h1
+and
+.I h2
+are incomparable.
+.
+.SH "SEE ALSO"
+.BR selinux (8),
+.BR selabel_open (3)
diff --git a/libselinux/man/man3/selabel_get_digests_all_partial_matches.3 b/libselinux/man/man3/selabel_get_digests_all_partial_matches.3
index 23663755..3383624d 100644
--- a/libselinux/man/man3/selabel_get_digests_all_partial_matches.3
+++ b/libselinux/man/man3/selabel_get_digests_all_partial_matches.3
@@ -4,6 +4,9 @@
 selabel_get_digests_all_partial_matches \- retrieve the partial matches digest
 and the xattr digest that applies to the supplied path \- Only supported
 on file backend.
+.br
+selabel_hash_all_partial_matches \- calculate the partial matches digest that
+applies to the supplied path (file backend only)
 .
 .SH "SYNOPSIS"
 .B #include <stdbool.h>
@@ -24,6 +27,11 @@ on file backend.
 .br
 .BI "size_t *" digest_len ");"
 .in
+.sp
+.BI "bool selabel_hash_all_partial_matches(struct selabel_handle *" hnd ,
+.in +\w'bool selabel_hash_all_partial_matches('u
+.BI "const char *" key ", uint8_t *" digest ");"
+.in
 .
 .SH "DESCRIPTION"
 .BR selabel_get_digests_all_partial_matches ()
@@ -59,8 +67,23 @@ The
 is the length of the digests that will always be returned (even if both are
 NULL). Note that if both digests are returned, they will always be the same length.
 .sp
+.BR selabel_hash_all_partial_matches ()
+calculates the file_contexts digest of all partial matches that apply to
+.I key
+on the handle
+.IR hnd ,
+storing the result in the caller-provided
+.I digest
+buffer, which must be large enough to hold the digest (a SHA1 hash, i.e. 20
+bytes).
+.sp
 .SH "RETURN VALUE"
-TRUE if the digests match or FALSE if they do not or either or both are missing.
+.BR selabel_get_digests_all_partial_matches ()
+returns true if the digests match or false if they do not or either or both are
+missing.
+.sp
+.BR selabel_hash_all_partial_matches ()
+returns true if a digest was calculated or false otherwise.
 .sp
 .SH "SEE ALSO"
 .BR selinux_restorecon (3),
diff --git a/libselinux/man/man3/selabel_hash_all_partial_matches.3 b/libselinux/man/man3/selabel_hash_all_partial_matches.3
new file mode 100644
index 00000000..6cad56cf
--- /dev/null
+++ b/libselinux/man/man3/selabel_hash_all_partial_matches.3
@@ -0,0 +1 @@
+.so man3/selabel_get_digests_all_partial_matches.3
diff --git a/libselinux/man/man3/selinux_binary_policy_path.3 b/libselinux/man/man3/selinux_binary_policy_path.3
index 612d86fc..7e3e7614 100644
--- a/libselinux/man/man3/selinux_binary_policy_path.3
+++ b/libselinux/man/man3/selinux_binary_policy_path.3
@@ -4,8 +4,13 @@ selinux_path, selinux_policy_root, selinux_binary_policy_path, selinux_current_p
 selinux_default_type_path, selinux_failsafe_context_path, selinux_removable_context_path,
 selinux_default_context_path, selinux_user_contexts_path, selinux_usersconf_path,
 selinux_x_context_path, selinux_sepgsql_context_path, selinux_netfilter_context_path,
-selinux_file_context_path, selinux_file_context_local_path, selinux_file_context_homedir_path,
-selinux_media_context_path, selinux_contexts_path, selinux_securetty_types_path \- These functions
+selinux_file_context_path, selinux_file_context_local_path, selinux_file_context_homedir_path, selinux_homedir_context_path,
+selinux_media_context_path, selinux_contexts_path, selinux_securetty_types_path,
+selinux_file_context_subs_path, selinux_file_context_subs_dist_path,
+selinux_customizable_types_path, selinux_booleans_subs_path, selinux_translations_path,
+selinux_virtual_domain_context_path, selinux_virtual_image_context_path,
+selinux_lxc_contexts_path, selinux_openrc_contexts_path, selinux_openssh_contexts_path,
+selinux_snapperd_contexts_path, selinux_systemd_contexts_path \- These functions
 return the paths to the active SELinux policy configuration directories and files
 .
 .SH "SYNOPSIS"
@@ -44,6 +49,8 @@ return the paths to the active SELinux policy configuration directories and file
 .sp
 .B const char *selinux_file_context_homedir_path(void);
 .sp
+.B const char *selinux_homedir_context_path(void);
+.sp
 .B const char *selinux_netfilter_context_path(void);
 .sp
 .B const char *selinux_media_context_path(void);
@@ -51,6 +58,30 @@ return the paths to the active SELinux policy configuration directories and file
 .B const char *selinux_securetty_types_path(void);
 .sp
 .B const char *selinux_contexts_path(void);
+.sp
+.B const char *selinux_file_context_subs_path(void);
+.sp
+.B const char *selinux_file_context_subs_dist_path(void);
+.sp
+.B const char *selinux_customizable_types_path(void);
+.sp
+.B const char *selinux_booleans_subs_path(void);
+.sp
+.B const char *selinux_translations_path(void);
+.sp
+.B const char *selinux_virtual_domain_context_path(void);
+.sp
+.B const char *selinux_virtual_image_context_path(void);
+.sp
+.B const char *selinux_lxc_contexts_path(void);
+.sp
+.B const char *selinux_openrc_contexts_path(void);
+.sp
+.B const char *selinux_openssh_contexts_path(void);
+.sp
+.B const char *selinux_snapperd_contexts_path(void);
+.sp
+.B const char *selinux_systemd_contexts_path(void);
 .
 .SH "DESCRIPTION"
 These functions return the paths to the active policy configuration
@@ -105,6 +136,10 @@ returns the local customization file contexts configuration.
 .BR selinux_file_context_homedir_path ()
 returns the home directory file contexts configuration.
 .sp
+.BR selinux_homedir_context_path ()
+returns the home directory template file used to generate the home directory
+file contexts.
+.sp
 .BR selinux_media_context_path ()
 returns the file contexts for media device nodes.
 .sp
@@ -112,7 +147,47 @@ returns the file contexts for media device nodes.
 returns the directory containing all of the context configuration files.
 .sp
 .BR selinux_securetty_types_path ()
-returns the defines tty types for newrole securettys.
+returns the defined tty types for newrole securettys.
+.sp
+.BR selinux_file_context_subs_path ()
+returns the local file contexts path substitution configuration.
+.sp
+.BR selinux_file_context_subs_dist_path ()
+returns the distribution file contexts path substitution configuration.
+.sp
+.BR selinux_customizable_types_path ()
+returns the list of types that an administrator may set on files and that
+are not relabeled by default.
+.sp
+.BR selinux_booleans_subs_path ()
+returns the boolean name substitution configuration.
+.sp
+.BR selinux_translations_path ()
+returns the context-to-human-readable translation configuration
+.RB ( setrans.conf )
+used by
+.BR mcstransd (8).
+.sp
+.BR selinux_virtual_domain_context_path ()
+returns the contexts used to label virtual machine domains.
+.sp
+.BR selinux_virtual_image_context_path ()
+returns the contexts used to label virtual machine image files.
+.sp
+.BR selinux_lxc_contexts_path ()
+returns the contexts used by LXC containers.
+.sp
+.BR selinux_openrc_contexts_path ()
+returns the contexts used by OpenRC.
+.sp
+.BR selinux_openssh_contexts_path ()
+returns the contexts used by OpenSSH.
+.sp
+.BR selinux_snapperd_contexts_path ()
+returns the contexts used by snapperd.
+.sp
+.BR selinux_systemd_contexts_path ()
+returns the contexts used by systemd.
 .
 .SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
diff --git a/libselinux/man/man3/selinux_booleans_subs_path.3 b/libselinux/man/man3/selinux_booleans_subs_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_booleans_subs_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_customizable_types_path.3 b/libselinux/man/man3/selinux_customizable_types_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_customizable_types_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_file_context_subs_dist_path.3 b/libselinux/man/man3/selinux_file_context_subs_dist_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_file_context_subs_dist_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_file_context_subs_path.3 b/libselinux/man/man3/selinux_file_context_subs_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_file_context_subs_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_flush_class_cache.3 b/libselinux/man/man3/selinux_flush_class_cache.3
new file mode 100644
index 00000000..bda9daf9
--- /dev/null
+++ b/libselinux/man/man3/selinux_flush_class_cache.3
@@ -0,0 +1 @@
+.so man3/security_class_to_string.3
diff --git a/libselinux/man/man3/selinux_get_callback.3 b/libselinux/man/man3/selinux_get_callback.3
new file mode 100644
index 00000000..15a156f4
--- /dev/null
+++ b/libselinux/man/man3/selinux_get_callback.3
@@ -0,0 +1 @@
+.so man3/selinux_set_callback.3
diff --git a/libselinux/man/man3/selinux_lxc_contexts_path.3 b/libselinux/man/man3/selinux_lxc_contexts_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_lxc_contexts_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_openrc_contexts_path.3 b/libselinux/man/man3/selinux_openrc_contexts_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_openrc_contexts_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_openssh_contexts_path.3 b/libselinux/man/man3/selinux_openssh_contexts_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_openssh_contexts_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_policy_root.3 b/libselinux/man/man3/selinux_policy_root.3
index 1c3c5081..f44e020f 100644
--- a/libselinux/man/man3/selinux_policy_root.3
+++ b/libselinux/man/man3/selinux_policy_root.3
@@ -1,7 +1,10 @@
 .TH "selinux_policy_root" "3" "25 May 2004" "dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
 selinux_policy_root \- return the path of the SELinux policy files for this machine
+.br
 selinux_set_policy_root \- Set an alternate SELinux root path for the SELinux policy files for this machine.
+.br
+selinux_reset_config \- reload the cached SELinux configuration
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -11,17 +14,27 @@ selinux_set_policy_root \- Set an alternate SELinux root path for the SELinux po
 .sp
 .B int selinux_set_policy_root(const char *rootpath);
 .
+.sp
+.B void selinux_reset_config(void);
+.
 .SH "DESCRIPTION"
 .BR selinux_policy_root ()
 reads the contents of the
 .I {/etc,/usr/lib}/selinux/config
 file to determine which policy files should be used for this machine.
-.
+.sp
 .BR selinux_set_policy_root ()
 sets an alternate policy root directory path,
 .IR rootpath ,
 under which the compiled policy file and context configuration files are
 located, and recomputes all policy paths relative to it.
+.sp
+.BR selinux_reset_config ()
+forces a reload of the cached SELinux configuration, discarding any values
+previously computed from
+.I /etc/selinux/config
+or set via
+.BR selinux_set_policy_root ().
 .
 .SH "RETURN VALUE"
 On success, selinux_policy_root returns a directory path containing the SELinux policy files.
diff --git a/libselinux/man/man3/selinux_raw_to_trans_context.3 b/libselinux/man/man3/selinux_raw_to_trans_context.3
new file mode 100644
index 00000000..d675a00c
--- /dev/null
+++ b/libselinux/man/man3/selinux_raw_to_trans_context.3
@@ -0,0 +1 @@
+.so man3/selinux_trans_to_raw_context.3
diff --git a/libselinux/man/man3/selinux_reset_config.3 b/libselinux/man/man3/selinux_reset_config.3
new file mode 100644
index 00000000..80776582
--- /dev/null
+++ b/libselinux/man/man3/selinux_reset_config.3
@@ -0,0 +1 @@
+.so man3/selinux_policy_root.3
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index bafa86a2..7d903a1b 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -204,7 +204,9 @@ Set the user and role component of the security context too.
 .B SELINUX_RESTORECON_COUNT_RELABELED
 Count the number of relabeled files or the number that would be relabeled if
 .B SELINUX_RESTORECON_NOCHANGE
-was not set.
+was not set. Call
+.BR selinux_restorecon_get_relabeled_files (3)
+to fetch the count afterwards.
 .sp
 .B SELINUX_RESTORECON_SKIP_MULTILINK
 Skip any non-directory files that have more than one hard link.
@@ -340,6 +342,8 @@ walk over a directory tree containing a cycle can complete successfully.
 .br
 .BR selinux_restorecon_get_skipped_errors (3),
 .br
+.BR selinux_restorecon_get_relabeled_files (3),
+.br
 .BR selinux_restorecon_set_exclude_list (3),
 .br
 .BR selinux_restorecon_set_alt_rootpath (3),
diff --git a/libselinux/man/man3/selinux_restorecon_get_relabeled_files.3 b/libselinux/man/man3/selinux_restorecon_get_relabeled_files.3
new file mode 100644
index 00000000..c0463060
--- /dev/null
+++ b/libselinux/man/man3/selinux_restorecon_get_relabeled_files.3
@@ -0,0 +1,32 @@
+.TH "selinux_restorecon_get_relabeled_files" "3" "18 Jun 2026" "Security Enhanced Linux" "SELinux API documentation"
+
+.SH "NAME"
+selinux_restorecon_get_relabeled_files \- get the number of files relabeled by
+.BR selinux_restorecon (3)
+or
+.BR selinux_restorecon_parallel (3)
+.
+.SH "SYNOPSIS"
+.B #include <selinux/restorecon.h>
+.sp
+.BI "long unsigned selinux_restorecon_get_relabeled_files(void);"
+.
+.SH "DESCRIPTION"
+If
+.B SELINUX_RESTORECON_COUNT_RELABELED
+was passed to
+.BR selinux_restorecon (3)
+or
+.BR selinux_restorecon_parallel (3),
+then
+.BR selinux_restorecon_get_relabeled_files ()
+returns the number of files that were successfully relabeled.
+.sp
+If the
+.B SELINUX_RESTORECON_NOCHANGE
+flag was set, then it returns the number of files that would be relabeled.
+.
+.SH "SEE ALSO"
+.BR selinux_restorecon (3),
+.br
+.BR selinux_restorecon_get_skipped_errors (3)
diff --git a/libselinux/man/man3/selinux_restorecon_get_skipped_errors.3 b/libselinux/man/man3/selinux_restorecon_get_skipped_errors.3
index d1757b76..ea82e0d8 100644
--- a/libselinux/man/man3/selinux_restorecon_get_skipped_errors.3
+++ b/libselinux/man/man3/selinux_restorecon_get_skipped_errors.3
@@ -25,4 +25,6 @@ and that function returned successfully (i.e., with a zero return value), then
 returns the number of errors ignored during the file tree walk.
 .
 .SH "SEE ALSO"
-.BR selinux_restorecon (3)
+.BR selinux_restorecon (3),
+.br
+.BR selinux_restorecon_get_relabeled_files (3)
diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/man/man3/selinux_set_callback.3
index e4d7ffa6..6581014d 100644
--- a/libselinux/man/man3/selinux_set_callback.3
+++ b/libselinux/man/man3/selinux_set_callback.3
@@ -3,12 +3,15 @@
 .\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2007
 .TH "selinux_set_callback" "3" "20 Jun 2007" "" "SELinux API documentation"
 .SH "NAME"
-selinux_set_callback \- userspace SELinux callback facilities
+selinux_set_callback, selinux_get_callback \- userspace SELinux callback
+facilities
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
 .BI "void selinux_set_callback(int " type ", union selinux_callback " cb ");"
+.sp
+.BI "union selinux_callback selinux_get_callback(int " type ");"
 .
 .SH "DESCRIPTION"
 .BR selinux_set_callback ()
@@ -20,6 +23,11 @@ which should be passed as a function pointer cast to type
 .B union
 .BR selinux_callback .
 
+.BR selinux_get_callback ()
+returns the callback currently registered for
+.IR type ,
+or the built-in default callback if none has been set.
+
 All callback functions should return a negative value with
 .I errno
 set appropriately on error.
diff --git a/libselinux/man/man3/selinux_snapperd_contexts_path.3 b/libselinux/man/man3/selinux_snapperd_contexts_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_snapperd_contexts_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_systemd_contexts_path.3 b/libselinux/man/man3/selinux_systemd_contexts_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_systemd_contexts_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_trans_to_raw_context.3 b/libselinux/man/man3/selinux_trans_to_raw_context.3
new file mode 100644
index 00000000..99d7bc90
--- /dev/null
+++ b/libselinux/man/man3/selinux_trans_to_raw_context.3
@@ -0,0 +1,43 @@
+.TH "selinux_trans_to_raw_context" "3" "11 June 2024" "" "SELinux API documentation"
+.SH "NAME"
+selinux_trans_to_raw_context, selinux_raw_to_trans_context \- convert SELinux security contexts between the human-readable and raw formats
+.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int selinux_trans_to_raw_context(const char *" trans ", char **" rawp );
+.sp
+.BI "int selinux_raw_to_trans_context(const char *" raw ", char **" transp );
+.
+.SH "DESCRIPTION"
+These functions perform context translation between the human-readable
+("translated") format and the internal system ("raw") format. The translation
+is provided by the
+.BR mcstransd (8)
+daemon; if it is not running, the input context is returned unchanged.
+
+.BR selinux_trans_to_raw_context ()
+converts the translated context
+.I trans
+into its raw form and stores it in the memory referenced by
+.IR rawp .
+
+.BR selinux_raw_to_trans_context ()
+converts the raw context
+.I raw
+into its translated, human-readable form and stores it in the memory referenced
+by
+.IR transp .
+
+In both cases the caller must free the returned context with
+.BR freecon (3).
+If the input context is NULL, the returned context is set to NULL and 0 is
+returned.
+.
+.SH "RETURN VALUE"
+On success, zero is returned.  On error, \-1 is returned and
+.I errno
+is set appropriately.
+.
+.SH "SEE ALSO"
+.BR selinux "(8), " freecon "(3), " selinux_raw_context_to_color "(3), " mcstransd "(8)"
diff --git a/libselinux/man/man3/selinux_translations_path.3 b/libselinux/man/man3/selinux_translations_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_translations_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_virtual_domain_context_path.3 b/libselinux/man/man3/selinux_virtual_domain_context_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_virtual_domain_context_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinux_virtual_image_context_path.3 b/libselinux/man/man3/selinux_virtual_image_context_path.3
new file mode 100644
index 00000000..175a611a
--- /dev/null
+++ b/libselinux/man/man3/selinux_virtual_image_context_path.3
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --git a/libselinux/man/man3/selinuxfs_exists.3 b/libselinux/man/man3/selinuxfs_exists.3
new file mode 100644
index 00000000..fe9a35cc
--- /dev/null
+++ b/libselinux/man/man3/selinuxfs_exists.3
@@ -0,0 +1 @@
+.so man3/set_selinuxmnt.3
diff --git a/libselinux/man/man3/set_matchpathcon_canoncon.3 b/libselinux/man/man3/set_matchpathcon_canoncon.3
new file mode 100644
index 00000000..b861e1ca
--- /dev/null
+++ b/libselinux/man/man3/set_matchpathcon_canoncon.3
@@ -0,0 +1 @@
+.so man3/set_matchpathcon_flags.3
diff --git a/libselinux/man/man3/set_matchpathcon_flags.3 b/libselinux/man/man3/set_matchpathcon_flags.3
index b9b2fed8..586f28e6 100644
--- a/libselinux/man/man3/set_matchpathcon_flags.3
+++ b/libselinux/man/man3/set_matchpathcon_flags.3
@@ -1,6 +1,6 @@
 .TH "set_matchpathcon_flags" "3" "21 November 2009" "stephen.smalley.work@gmail.com" "SELinux API documentation"
 .SH "NAME"
-set_matchpathcon_flags, set_matchpathcon_invalidcon, set_matchpathcon_printf \- set flags controlling the operation of matchpathcon or matchpathcon_index and configure the behaviour of validity checking and error displaying
+set_matchpathcon_flags, set_matchpathcon_invalidcon, set_matchpathcon_canoncon, set_matchpathcon_printf \- set flags controlling the operation of matchpathcon or matchpathcon_index and configure the behaviour of validity checking and error displaying
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -9,6 +9,8 @@ set_matchpathcon_flags, set_matchpathcon_invalidcon, set_matchpathcon_printf \-
 .sp
 .BI "void set_matchpathcon_invalidcon(int (*" f ")(const char *" path ", unsigned " lineno ", char *" context "));"
 .sp
+.BI "void set_matchpathcon_canoncon(int (*" f ")(const char *" path ", unsigned " lineno ", char **" context "));"
+.sp
 .BI "void set_matchpathcon_printf(void (*" f ")(const char *" fmt ", ...));"
 .
 .SH "DESCRIPTION"
@@ -39,13 +41,28 @@ e.g. using
 as is done by 
 .B setfiles \-c.
 The function is also responsible for reporting any such error, and
-may include the 
+may include the
 .I path
 and
 .I lineno
 in such error messages.
 .sp
 
+.BR set_matchpathcon_canoncon ()
+sets the function used by
+.BR matchpathcon_init (3)
+to canonicalize a context in the file contexts configuration, by changing
+.I *context
+to refer to the canonical form.  If neither this function nor
+.BR set_matchpathcon_invalidcon ()
+is set, then this defaults to calling
+.BR security_canonicalize_context_raw (3).
+Contexts are handled in raw form at this stage, i.e. without translation by
+.BR mcstransd (8);
+a replacement function must likewise store a raw context in
+.IR *context .
+.sp
+
 .BR set_matchpathcon_printf ()
 sets the function used by 
 .BR matchpathcon_init (3)
diff --git a/libselinux/man/man3/set_selinuxmnt.3 b/libselinux/man/man3/set_selinuxmnt.3
index 254f5d55..81312705 100644
--- a/libselinux/man/man3/set_selinuxmnt.3
+++ b/libselinux/man/man3/set_selinuxmnt.3
@@ -1,6 +1,6 @@
 .TH "set_selinuxmnt" "3" "2026-06-18" "Security Enhanced Linux" "SELinux API documentation"
 .SH "NAME"
-set_selinuxmnt, fini_selinuxmnt \- manage the selinuxfs
+set_selinuxmnt, fini_selinuxmnt, selinuxfs_exists \- manage the selinuxfs
 mountpoint used by libselinux
 .
 .SH "SYNOPSIS"
@@ -9,6 +9,8 @@ mountpoint used by libselinux
 .BI "void set_selinuxmnt(const char *" mnt ");"
 .sp
 .BI "void fini_selinuxmnt(void);"
+.sp
+.BI "int selinuxfs_exists(void);"
 .
 .SH "DESCRIPTION"
 libselinux determines the selinuxfs mountpoint automatically when the library
@@ -29,6 +31,13 @@ afterwards, even if it has not called any other libselinux function yet.
 
 .BR fini_selinuxmnt ()
 clears the stored selinuxfs mountpoint and frees the associated memory.
+
+.BR selinuxfs_exists ()
+checks whether the selinuxfs filesystem type is registered with the running
+kernel by reading
+.IR /proc/filesystems .
+It returns 1 if selinuxfs is present and 0 otherwise. If the check cannot be
+performed it returns 1, failing safe as if selinuxfs exists.
 .
 .SH "AUTHOR"
 This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
-- 
2.55.0

