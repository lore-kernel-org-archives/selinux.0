Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310191;
	b=XHHvmVx95mLVhFxITBTq6IvWjp7t2bP/vmEKfgSOmAgvlLk9BpdjXrh3E4dNEmDJIyNQ
	 iP9zm3CoOIRM5tjBm7+aO9+K+DbzqX3oXzEFjTi0+WZzSZw6/5CKZHOYL+h9l1zkFV2O/
	 J/n5HlobwAhcr45BKUUrPp1uC4LlGXxR48Uba1snpOzJXX+fc1ugz/uKOdMO8HzEK5PpM
	 +VNCtEmPqwIu3tSc/FeD5VPwKB4TDtbMzBpcecaui6JGGJAvY9/uyGMeJfP1jiZB29sPz
	 D/cBWNgppxChD6YNa0qdfBcwqejgA86K4M78KtO+rpV2KoPxKG1IGW9ODaJgA3zc8KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310191;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oEAzyC6zOxQ+edPMaUnfndaevSzt5zUawKXGJpA/3vQ=;
	b=eaXuY9K4IdfHoSj8fdm3EuEoYelGtdcqQuDuu/S5MF7tlY9gaqySlFwXGmTSfRVI8uxx
	 Jy82by8eTg95mkZMyCBd/HyZtpE3zHxeSXmTMovGLFe37HBBEDYG19fzUxiLPHs4Hvd9J
	 DOufQSeWKpGyUGhzq3zOCiKq94L+sQmGY5Q2o9YzIOHScsdhMWC1iNqTvqdqMPo1n78V3
	 B5v3QuHu/eD8WFIj35t6yH77LfQvPDUBLzZGYYw4BT1nofCZ6BIHKMusHqb0ZHI5v58tM
	 bbPYnsauhgY9WzTO41McAjLI22GrblgyjYMsHSCfdrAADZPNS426IW7d8z7GkVT1eUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=aRVo6pIb;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9F606A330
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18B9F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=aRVo6pIb
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794310188;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEAzyC6zOxQ+edPMaUnfndaevSzt5zUawKXGJpA/3vQ=;
	b=aRVo6pIbnjbAU5ufkeSWK8f0fNNoTj85M2EyEq4LdbS3C1PFCXT/NinshNglORoA+J2vJN
	B9O0rXAColZA9sq7fGysPL8WHTwj8a+W6y8j1+f6NosRqmUCcmkg3dSIbbyaGjmCiaP2ej
	w06aRoMcMBtaJzhroK+zjfEKCXHYxts7oauK4VnMi3Cy3/RaASKfiFDqP5CtWpUuQEVJ93
	6ngSdjXnVnTeqYgMQe0AS5T4+Vr1PwtwNDbRrmXVcj5z3PYN3ZcAIVrlb57oKp19g8pXGJ
	6b1TCzP0Uk0yWnPoZq45nFG0NAxl2g9tyDrI6bED0NXDP0SzwPxGjKl4/Ay79w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 8/8] libselinux/man: fix typos, grammar and markup
Date: Tue, 10 Nov 2026 12:29:30 +0100
Message-ID: <20261110112931.99557-7-cgoettsche@seltendoof.de>
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

Fix spelling and grammar mistakes, unbalanced quotes in SYNOPSIS and
SEE ALSO lines, cross-references missing the space before the section
number, misplaced punctuation in font macros, and a duplicated NAME
section in is_selinux_enabled(3).

Unify some wording and formatting across pages: upper case the
"OBJECT NAME STRING VALUES" section headings, write the bool results
of the selabel functions as true/false, drop the "GNU/" prefix from
the Linux user descriptions, and refer to functions and parameters
with the usual markup.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/context_new.3             |  2 +-
 .../man/man3/get_ordered_context_list.3       |  6 ++--
 libselinux/man/man3/getcon.3                  | 13 +++----
 libselinux/man/man3/getexeccon.3              | 11 +++---
 libselinux/man/man3/getsockcreatecon.3        |  2 +-
 libselinux/man/man3/is_selinux_enabled.3      |  6 ++--
 libselinux/man/man3/matchpathcon.3            | 12 +++----
 .../man/man3/security_class_to_string.3       |  2 +-
 libselinux/man/man3/security_compute_av.3     | 36 +++++++++----------
 libselinux/man/man3/security_getenforce.3     |  8 ++---
 libselinux/man/man3/security_load_policy.3    |  4 +--
 libselinux/man/man3/selabel_open.3            |  2 +-
 libselinux/man/man3/selabel_partial_match.3   |  6 ++--
 .../man/man3/selinux_binary_policy_path.3     |  6 ++--
 .../man/man3/selinux_file_context_verify.3    | 12 +++----
 libselinux/man/man3/selinux_getenforcemode.3  | 10 +++---
 libselinux/man/man3/selinux_policy_root.3     |  2 +-
 libselinux/man/man3/selinux_restorecon.3      | 10 +++---
 .../man3/selinux_restorecon_default_handle.3  |  2 +-
 .../man3/selinux_restorecon_set_sehandle.3    |  2 +-
 libselinux/man/man3/selinux_set_mapping.3     | 10 +++---
 libselinux/man/man3/selinux_status_open.3     | 13 +++----
 libselinux/man/man3/setfilecon.3              | 12 ++++---
 libselinux/man/man5/selabel_db.5              | 13 ++++---
 libselinux/man/man5/selabel_file.5            |  8 ++---
 libselinux/man/man5/selabel_x.5               | 14 +++++---
 libselinux/man/man5/service_seusers.5         | 16 +++++----
 libselinux/man/man5/seusers.5                 | 15 ++++----
 28 files changed, 139 insertions(+), 116 deletions(-)

diff --git a/libselinux/man/man3/context_new.3 b/libselinux/man/man3/context_new.3
index 197fb5f8..246f91d5 100644
--- a/libselinux/man/man3/context_new.3
+++ b/libselinux/man/man3/context_new.3
@@ -79,7 +79,7 @@ structure.
 set a context component.
 .
 .SH "RETURN VALUE"
-On failure
+The
 .BR context_*_set ()
 functions return non-zero on failure and 0 on success.
 
diff --git a/libselinux/man/man3/get_ordered_context_list.3 b/libselinux/man/man3/get_ordered_context_list.3
index 8c741237..35943b58 100644
--- a/libselinux/man/man3/get_ordered_context_list.3
+++ b/libselinux/man/man3/get_ordered_context_list.3
@@ -32,10 +32,10 @@ get_ordered_context_list, get_ordered_context_list_with_level, get_default_conte
 This family of functions can be used to obtain either a prioritized list of
 all reachable security contexts for a given SELinux user or a single default
 (highest priority) context for a given SELinux user for use by login-like
-programs.  These functions takes a SELinux user identity that must
+programs.  These functions take a SELinux user identity that must
 be defined in the SELinux policy as their input, not a Linux username.
 Most callers should typically first call
-.BR getseuserbyname(3)
+.BR getseuserbyname (3)
 to look up the SELinux user identity and level for a given
 Linux username and then invoke one of
 .BR get_ordered_context_list_with_level ()
@@ -101,7 +101,7 @@ authorized contexts could not be obtained. Caller must free via
 .BR freecon (3).
 
 .BR get_default_type ()
-Get the default type (domain) for
+gets the default type (domain) for
 .I role
 and set
 .I type
diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index b9d6246c..eea86b07 100644
--- a/libselinux/man/man3/getcon.3
+++ b/libselinux/man/man3/getcon.3
@@ -42,26 +42,27 @@ setcon \- set current security context of a process
 .SH "DESCRIPTION"
 .TP
 .BR getcon ()
-retrieves the context of the current process, which must be free'd with
+retrieves the context of the current process, which must be freed with
 .BR freecon ().
 
 .TP
 .BR getprevcon ()
-same as getcon but gets the context before the last exec.
+same as \fBgetcon\fR() but gets the context before the last exec.
 
 .TP
 .BR getpidcon ()
-returns the process context for the specified PID, which must be free'd with
+returns the process context for the specified PID, which must be freed with
 .BR freecon ().
 
 .TP
 .BR getpidprevcon ()
-returns the process context before the last exec for the specified PID, which must be free'd with
+returns the process context before the last exec for the specified PID, which
+must be freed with
 .BR freecon ().
 
 .TP
 .BR getpeercon ()
-retrieves the context of the peer socket, which must be free'd with
+retrieves the context of the peer socket, which must be freed with
 .BR freecon ().
 
 .TP
@@ -115,7 +116,7 @@ would fail if there are any other
 threads running in the same process since this would yield
 an inconsistency among the security contexts of threads sharing
 the same memory space.  Since Linux 2.6.28,
-.BR setcon()
+.BR setcon ()
 is permitted for threads within a multi-threaded process if the
 new security context is bounded by the old security context, where
 the bounded relation is defined through typebounds statements in the
diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/getexeccon.3
index ea1b1801..cbad9846 100644
--- a/libselinux/man/man3/getexeccon.3
+++ b/libselinux/man/man3/getexeccon.3
@@ -17,7 +17,7 @@ rpm_execcon \- run a helper for rpm in an appropriate security context
 .sp
 .BI "int setexecfilecon(const char *" filename ", const char *" fallback_type );
 .sp
-.BI "int rpm_execcon(unsigned int " verified ", const char *" filename ", char *const " argv "[] , char *const " envp "[]);
+.BI "int rpm_execcon(unsigned int " verified ", const char *" filename ", char *const " argv "[] , char *const " envp "[]);"
 .
 .SH "DESCRIPTION"
 .BR getexeccon ()
@@ -83,13 +83,16 @@ verification (0 == ok, 1 == notfound, 2 == verifyfail, 3 ==
 nottrusted, 4 == nokey), although this information is not yet used by
 the function.  The function determines the proper security context for
 the helper based on policy, sets the exec context accordingly, and
-then executes the specified filename with the provided argument and
-environment arrays.
+then executes the specified filename with the provided argument
+.RI ( argv )
+and environment
+.RI ( envp )
+arrays.
 .
 .SH "RETURN VALUE"
 On failure, \-1 is returned and
 .I errno
-is  set appropriately.
+is set appropriately.
 
 On success
 .BR getexeccon (),
diff --git a/libselinux/man/man3/getsockcreatecon.3 b/libselinux/man/man3/getsockcreatecon.3
index 4deac7f9..787bce86 100644
--- a/libselinux/man/man3/getsockcreatecon.3
+++ b/libselinux/man/man3/getsockcreatecon.3
@@ -59,4 +59,4 @@ On error \-1 is returned.
 On success 0 is returned.
 .
 .SH "SEE ALSO"
-.BR selinux "(8), " freecon "(3), " getcon "(3)
+.BR selinux "(8), " freecon "(3), " getcon "(3)"
diff --git a/libselinux/man/man3/is_selinux_enabled.3 b/libselinux/man/man3/is_selinux_enabled.3
index 16b7cd3c..a1febc2f 100644
--- a/libselinux/man/man3/is_selinux_enabled.3
+++ b/libselinux/man/man3/is_selinux_enabled.3
@@ -1,9 +1,9 @@
 .TH "is_selinux_enabled" "3" "7 Mar 2010" "russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
 is_selinux_enabled \- check whether SELinux is enabled
-.
-.SH "NAME"
-is_selinux_mls_enabled \- check whether SELinux is enabled for (Multi Level Security) MLS
+.br
+is_selinux_mls_enabled \- check whether SELinux is enabled for MLS (Multi-Level
+Security)
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
diff --git a/libselinux/man/man3/matchpathcon.3 b/libselinux/man/man3/matchpathcon.3
index ce33dc34..e585b6b3 100644
--- a/libselinux/man/man3/matchpathcon.3
+++ b/libselinux/man/man3/matchpathcon.3
@@ -11,7 +11,7 @@ matchpathcon, matchpathcon_index \- get the default SELinux security context for
 .sp
 .BI "int matchpathcon_fini(void);"
 .sp
-.BI "int matchpathcon(const char *" path ", mode_t " mode ", char **" con ");
+.BI "int matchpathcon(const char *" path ", mode_t " mode ", char **" con ");"
 .sp
 .BI "int matchpathcon_index(const char *" path ", mode_t " mode ", char **" con ");"
 .
@@ -61,8 +61,8 @@ is the same as
 .BR matchpathcon_init ()
 but only loads entries with regular expressions whose first pathname
 component is a prefix of
-.I \%prefix
-, e.g. pass "/dev" if you only intend to call
+.IR \%prefix ,
+e.g. pass "/dev" if you only intend to call
 .BR matchpathcon ()
 with pathnames beginning with /dev.
 However, this optimization is no longer necessary due to the use of
@@ -72,7 +72,7 @@ is deprecated.
 
 .BR matchpathcon_fini ()
 frees the memory allocated by a prior call to
-.BR matchpathcon_init. ()
+.BR matchpathcon_init ().
 This function can be used to free and reset the internal state between multiple 
 .BR matchpathcon_init ()
 calls, or to free memory when finished using 
@@ -85,7 +85,7 @@ after transformation via
 .BR realpath (3)
 excepting any final symbolic link component if S_IFLNK was
 specified as the
-.I mode,
+.IR mode ,
 and
 .I mode
 against the
@@ -108,7 +108,7 @@ If
 .BR matchpathcon_init ()
 has not already been called, then this function will call it upon
 its first invocation with a NULL
-.I path,
+.IR path ,
 defaulting to the active file contexts configuration.
 
 .BR matchpathcon_index ()
diff --git a/libselinux/man/man3/security_class_to_string.3 b/libselinux/man/man3/security_class_to_string.3
index 03df6128..71654aac 100644
--- a/libselinux/man/man3/security_class_to_string.3
+++ b/libselinux/man/man3/security_class_to_string.3
@@ -113,5 +113,5 @@ Eamon Walsh <ewalsh@tycho.nsa.gov>
 .SH "SEE ALSO"
 .BR selinux (8),
 .BR getcon (3),
-.BR getfilecon (3)
+.BR getfilecon (3),
 .BR stat (3)
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index 7845c42e..9c2c5195 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -63,18 +63,18 @@ global permissive mode and allow_unknown.
 
 When using any of the functions that take policy integer values for
 classes or permissions as inputs, use
-.BR string_to_security_class(3)
+.BR string_to_security_class (3)
 and
-.BR string_to_av_perm(3)
+.BR string_to_av_perm (3)
 to map the class and permission names to their policy values.
 These values may change across a policy reload, so they should be
 re-acquired on every use or using a
 .B SELINUX_CB_POLICYLOAD
 callback set via
-.BR selinux_set_callback(3).
+.BR selinux_set_callback (3).
 
 An alternative approach is to use
-.BR selinux_set_mapping(3)
+.BR selinux_set_mapping (3)
 to create a mapping from class and permission index values
 used by the application to the policy values,
 thereby allowing the application to pass its own
@@ -116,20 +116,20 @@ and target context
 .BR security_compute_create_name ()
 is identical to
 .BR \%security_compute_create ()
-but also takes name of the new object in creation as an argument.
-When
+but also takes the name of the object being created as an argument.
+When a
 .B TYPE_TRANSITION
-rule on the given class and a SID pair has object name extension,
-we shall be able to obtain a correct
+rule on the given class and SID pair has an object name extension,
+this allows obtaining the correct
 .I newcon
 according to the security policy. Note that this interface is only
-supported on the linux 2.6.40 or later.
-In the older kernel, the object name will be simply ignored.
+supported on Linux 2.6.40 or later.
+On older kernels the object name is simply ignored.
 
 .BR security_compute_relabel ()
-is used to compute the new context to use when relabeling an object, it is used
-in the pam_selinux.so source and the newrole source to determine the correct
-label for the tty at login time, but can be used for other things.
+is used to compute the new context to use when relabeling an object.  It is used
+in the pam_selinux.so and newrole sources to determine the correct label for the
+tty at login time, but can be used for other purposes.
 
 .BR security_compute_member ()
 is used to compute the context to use when labeling a polyinstantiated object
@@ -144,12 +144,12 @@ instead.
 .BR security_validatetrans ()
 is used to determine if a transition from scon to newcon using tcon as the object
 is valid for object class tclass. This checks against the mlsvalidatetrans and
-validatetrans constraints in the loaded policy. Returns 0 if allowed, and -1
+validatetrans constraints in the loaded policy. Returns 0 if allowed, and \-1
 if an error occurred with errno set.
 
 .BR security_get_initial_context ()
-is used to get the context of a kernel initial security identifier specified by 
-.I name
+is used to get the context of a kernel initial security identifier specified by
+.IR name .
 
 The context returned in
 .I newcon
@@ -178,7 +178,7 @@ must be freed with
 .BR \%security_compute_create_name_raw (),
 .BR \%security_compute_relabel_raw (),
 .BR \%security_compute_member_raw (),
-.BR \%security_compute_user_raw ()
+.BR \%security_compute_user_raw (),
 .BR \%security_validatetrans_raw ()
 and
 .BR \%security_get_initial_context_raw ()
@@ -194,7 +194,7 @@ is used to check for a permission in the
 class.
 .BR selinux_check_passwd_access ()
 uses
-.BR getprevcon(3)
+.BR getprevcon (3)
 for the source and target security contexts.
 This function is deprecated; use
 .BR selinux_check_access ()
diff --git a/libselinux/man/man3/security_getenforce.3 b/libselinux/man/man3/security_getenforce.3
index f339b8b0..5ba36222 100644
--- a/libselinux/man/man3/security_getenforce.3
+++ b/libselinux/man/man3/security_getenforce.3
@@ -8,7 +8,7 @@ security_get_checkreqprot \- get or set the enforcing state of SELinux
 .sp
 .B int security_getenforce(void);
 .sp
-.BI "int security_setenforce(int "value );
+.BI "int security_setenforce(int " value ");"
 .sp
 .B int security_deny_unknown(void);
 .sp
@@ -34,15 +34,15 @@ permissions as being allowed, 1 if such queries are denied, and \-1 on error.
 returns 1 if the current policy was built with handle-unknown=reject and SELinux
 would reject loading it, if it did not define all kernel object classes and
 permissions. In this state, when
-.BR selinux_set_mapping()
+.BR selinux_set_mapping ()
 and
-.BR selinux_check_access()
+.BR selinux_check_access ()
 are used with an undefined userspace class or permission, an error is returned
 and errno is set to EINVAL.
 
 It returns 0 if the current policy was built with handle-unknown=allow or
 handle-unknown=deny. In this state, policy queries are treated according to
-.BR security_deny_unknown().
+.BR security_deny_unknown ().
 \-1 is returned on error.
 
 .BR security_get_checkreqprot ()
diff --git a/libselinux/man/man3/security_load_policy.3 b/libselinux/man/man3/security_load_policy.3
index d30f5a28..589c24a6 100644
--- a/libselinux/man/man3/security_load_policy.3
+++ b/libselinux/man/man3/security_load_policy.3
@@ -44,7 +44,7 @@ then init should halt the system, otherwise init may proceed normally without
 a re-exec.
 .sp
 It should also be noted that after the initial policy load, the SELinux
-kernel code cannot anymore be disabled and the selinuxfs cannot be
+kernel code can no longer be disabled and the selinuxfs cannot be
 unmounted using a call to
 .BR security_disable (3).
 Therefore, after the initial policy load, the only operational changes
@@ -60,4 +60,4 @@ Returns zero on success or \-1 on error.
 This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
 .
 .SH "SEE ALSO"
-.BR selinux "(8), " security_disable "(3), " setenforce "(8)
+.BR selinux "(8), " security_disable "(3), " setenforce "(8)"
diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/selabel_open.3
index c0978426..b131f86d 100644
--- a/libselinux/man/man3/selabel_open.3
+++ b/libselinux/man/man3/selabel_open.3
@@ -59,7 +59,7 @@ include the following:
 .
 .TP
 .B SELABEL_OPT_UNUSED
-The option with a type code of zero is a no-op.  Thus an array of options may be initizalized to zero and any untouched elements will not cause an error.
+The option with a type code of zero is a no-op.  Thus an array of options may be initialized to zero and any untouched elements will not cause an error.
 .TP
 .B SELABEL_OPT_VALIDATE
 A non-null value for this option enables context validation.  By default,
diff --git a/libselinux/man/man3/selabel_partial_match.3 b/libselinux/man/man3/selabel_partial_match.3
index 80f5a6c6..035c6e93 100644
--- a/libselinux/man/man3/selabel_partial_match.3
+++ b/libselinux/man/man3/selabel_partial_match.3
@@ -20,12 +20,12 @@ possible on a file path \- Only supported on file backend.
 .BR selabel_partial_match ()
 performs a partial match operation on the handle
 .IR hnd ,
-returning TRUE or FALSE.
+returning true or false.
 The \fIkey\fR parameter is a file path to check for a direct or partial match.
 .sp
 .SH "RETURN VALUE"
-TRUE is returned if a direct or partial match is found, FALSE if not.
-TRUE is also returned if an error prevents ruling out a match, so callers
+true is returned if a direct or partial match is found, false if not.
+true is also returned if an error prevents ruling out a match, so callers
 do not skip potentially matching descendants.
 .sp
 .SH "SEE ALSO"
diff --git a/libselinux/man/man3/selinux_binary_policy_path.3 b/libselinux/man/man3/selinux_binary_policy_path.3
index 09ae6b84..f470763d 100644
--- a/libselinux/man/man3/selinux_binary_policy_path.3
+++ b/libselinux/man/man3/selinux_binary_policy_path.3
@@ -1,4 +1,4 @@
-.TH "selinux_binary_policy_path" "3" "15 November 2004" "dwalsh@redhat.com" "SELinux API Documentation"
+.TH "selinux_binary_policy_path" "3" "15 November 2004" "dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
 selinux_path, selinux_policy_root, selinux_binary_policy_path, selinux_current_policy_path,
 selinux_default_type_path, selinux_failsafe_context_path, selinux_removable_context_path,
@@ -95,7 +95,7 @@ returns the top-level SELinux configuration directory.
 returns the top-level policy directory.
 .sp
 .BR selinux_binary_policy_path ()
-returns the binary policy file loaded into kernel.
+returns the binary policy file loaded into the kernel.
 .sp
 .BR selinux_current_policy_path ()
 returns the currently loaded policy file from the kernel.
@@ -116,7 +116,7 @@ returns the system-wide default contexts for user sessions.
 returns the directory containing per-user default contexts.
 .sp
 .BR selinux_usersconf_path ()
-returns the file containing mapping between Linux Users and SELinux users.
+returns the file containing the mapping between Linux users and SELinux users.
 .sp
 .BR selinux_x_context_path ()
 returns the file containing configuration for XSELinux extension.
diff --git a/libselinux/man/man3/selinux_file_context_verify.3 b/libselinux/man/man3/selinux_file_context_verify.3
index 64b4304e..904c2713 100644
--- a/libselinux/man/man3/selinux_file_context_verify.3
+++ b/libselinux/man/man3/selinux_file_context_verify.3
@@ -17,7 +17,7 @@ The
 .I mode
 may be zero.
 .sp
-Note that the two contexts are compared for "significant" differences (i.e. the user component of the contexts are ignored) as shown in the
+Note that the two contexts are compared for "significant" differences (i.e. the user component of the contexts is ignored) as shown in the
 .B EXAMPLE
 section.
 .
@@ -38,7 +38,7 @@ significantly match the context on disk.
 .sp
 On error, \-1 is returned and
 .I errno
-set appropriately.
+is set appropriately.
 .
 .SH "ERRORS"
 .TP
@@ -56,7 +56,7 @@ if the entry in the file contexts series of files or
 are invalid, or the returned context fails validation.
 .TP
 .B ENOMEM
-if attempt to allocate memory failed.
+if an attempt to allocate memory failed.
 .
 .SH "FILES"
 The following configuration files (the file contexts series of files) supporting the active policy will be used (should they exist) to determine the
@@ -68,10 +68,10 @@ default context:
 - This file must exist.
 .sp
 .I contexts/files/file_contexts.local
-- If exists has local customizations.
+- If it exists, holds local customizations.
 .sp
 .I contexts/files/file_contexts.homedirs
-- If exists has users home directory customizations.
+- If it exists, holds users' home directory customizations.
 .sp
 .I contexts/files/file_contexts.subs
 - If it exists, holds local substitutions that are then applied to the 'in
@@ -83,7 +83,7 @@ the 'in memory' version of the file contexts files.
 .RE
 .
 .SH "EXAMPLE"
-If the files context is:
+If the file's context is:
 .RS
 unconfined_u:object_r:admin_home_t:s0
 .RE
diff --git a/libselinux/man/man3/selinux_getenforcemode.3 b/libselinux/man/man3/selinux_getenforcemode.3
index 4242a506..acbc7ba9 100644
--- a/libselinux/man/man3/selinux_getenforcemode.3
+++ b/libselinux/man/man3/selinux_getenforcemode.3
@@ -9,18 +9,18 @@ selinux_getenforcemode \- get the enforcing state of SELinux
 .
 .SH "DESCRIPTION"
 .BR selinux_getenforcemode ()
-Reads the contents of the
+reads the contents of the
 .I {/etc,/usr/lib}/selinux/config
-file to determine how the system was setup to run SELinux.
+file to determine how the system was set up to run SELinux.
 
 Sets the value of
-.I enforce
+.I *enforce
 to 1 if SELinux should be run in enforcing mode.
 Sets the value of
-.I enforce
+.I *enforce
 to 0 if SELinux should be run in permissive mode.
 Sets the value of
-.I enforce
+.I *enforce
 to \-1 if SELinux should be disabled.
 .
 .SH "RETURN VALUE"
diff --git a/libselinux/man/man3/selinux_policy_root.3 b/libselinux/man/man3/selinux_policy_root.3
index ed06e253..cc09112d 100644
--- a/libselinux/man/man3/selinux_policy_root.3
+++ b/libselinux/man/man3/selinux_policy_root.3
@@ -2,7 +2,7 @@
 .SH "NAME"
 selinux_policy_root \- return the path of the SELinux policy files for this machine
 .br
-selinux_set_policy_root \- Set an alternate SELinux root path for the SELinux policy files for this machine.
+selinux_set_policy_root \- set an alternate SELinux root path for the SELinux policy files for this machine
 .br
 selinux_reset_config \- reload the cached SELinux configuration
 .
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index 7d903a1b..e7d59eca 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -89,8 +89,8 @@ don't change any file labels (passive check) or update the digest in the
 extended attribute.
 .sp
 .B SELINUX_RESTORECON_SET_SPECFILE_CTX
-If set, reset the files label to match the default specfile context.
-If not set only reset the files "type" component of the context to match the
+If set, reset the file's label to match the default specfile context.
+If not set only reset the file's "type" component of the context to match the
 default specfile context.
 .sp
 .B SELINUX_RESTORECON_RECURSE
@@ -244,10 +244,10 @@ unless the
 flag has been set.
 .RE
 .sp
-.BR selinux_restorecon_parallel()
+.BR selinux_restorecon_parallel ()
 is similar to
 .BR selinux_restorecon (3),
-but accepts another parameter that allows to run relabeling over multiple
+but accepts another parameter that allows running relabeling over multiple
 threads:
 .sp
 .RS
@@ -286,7 +286,7 @@ for each directory in the
 path.
 .IP "2." 4
 To check the extended attribute entry use
-.BR getfattr (1) ,
+.BR getfattr (1),
 for example:
 .sp
 .RS
diff --git a/libselinux/man/man3/selinux_restorecon_default_handle.3 b/libselinux/man/man3/selinux_restorecon_default_handle.3
index 52f5ad3c..32f97ae2 100644
--- a/libselinux/man/man3/selinux_restorecon_default_handle.3
+++ b/libselinux/man/man3/selinux_restorecon_default_handle.3
@@ -9,7 +9,7 @@ selinux_restorecon_default_handle \- sets default parameters for
 .br
 .B #include <selinux/label.h>
 .sp
-.B "struct selabel_handle *selinux_restorecon_default_handle(void);"
+.B struct selabel_handle *selinux_restorecon_default_handle(void);
 .
 .SH "DESCRIPTION"
 .BR selinux_restorecon_default_handle ()
diff --git a/libselinux/man/man3/selinux_restorecon_set_sehandle.3 b/libselinux/man/man3/selinux_restorecon_set_sehandle.3
index 978945ee..78936e88 100644
--- a/libselinux/man/man3/selinux_restorecon_set_sehandle.3
+++ b/libselinux/man/man3/selinux_restorecon_set_sehandle.3
@@ -16,7 +16,7 @@ selinux_restorecon_set_sehandle \- set a labeling handle for use by
 .BR selinux_restorecon_set_sehandle ()
 sets the
 .I handle
-to be use by
+to be used by
 .BR selinux_restorecon (3)
 when relabeling files.
 .sp
diff --git a/libselinux/man/man3/selinux_set_mapping.3 b/libselinux/man/man3/selinux_set_mapping.3
index f12027c5..1f9f204a 100644
--- a/libselinux/man/man3/selinux_set_mapping.3
+++ b/libselinux/man/man3/selinux_set_mapping.3
@@ -22,15 +22,15 @@ struct security_class_mapping {
 establishes a mapping from a user-provided ordering of object classes and permissions to the numbers actually used by the loaded system policy. If using this function, applications should also set a
 .B SELINUX_CB_POLICYLOAD
 callback via
-.BR selinux_set_callback(3)
+.BR selinux_set_callback (3)
 that calls this function again upon a policy reload to re-create the mapping
 in case the class or permission values change in the new policy.
-Generally it is preferred to instead use
-.BR selinux_check_access(3)
+Generally it is preferred to use
+.BR selinux_check_access (3)
 instead of
-.BR avc_has_perm(3)
+.BR avc_has_perm (3)
 or
-.BR security_compute_av(3)
+.BR security_compute_av (3)
 and not use this function at all.
 
 After the mapping is established, all libselinux functions that operate on class and permission values take the user-provided numbers, which are determined as follows:
diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/man3/selinux_status_open.3
index 696677ed..0a9db49a 100644
--- a/libselinux/man/man3/selinux_status_open.3
+++ b/libselinux/man/man3/selinux_status_open.3
@@ -32,7 +32,7 @@ access control; such as row-level security in databases, it will face
 unignorable cost to communicate with kernel space to check invalidation
 of userspace avc.
 .sp
-These functions provides applications a way to know some kernel events
+These functions provide applications a way to know some kernel events
 without system-call invocation or worker thread for monitoring.
 .sp
 .BR selinux_status_open ()
@@ -53,8 +53,8 @@ Thus, we need to pay attention to the interaction with these interfaces,
 when fallback mode is enabled.
 .sp
 .BR selinux_status_close ()
-unmap the kernel status page and close its file descriptor, or close the
-netlink socket if fallbacked.
+unmaps the kernel status page and closes its file descriptor, or closes the
+netlink socket if the fallback was used.
 .sp
 .BR selinux_status_updated ()
 processes status update events. There are two kinds of status updates.
@@ -75,7 +75,7 @@ except with or without system call invocation.
 .sp
 .BR selinux_status_policyload ()
 returns times of policy reloaded on the running system, or \-1 on error.
-Note that it is not a reliable value on fallback-mode until it receive
+Note that it is not a reliable value on fallback-mode until it receives
 the first event message via netlink socket.
 Thus, don't use this value to know actual times of policy reloaded.
 .sp
@@ -104,7 +104,7 @@ multiple threads. For a given setenforce or policyload event the
 /
 .B SELINUX_CB_POLICYLOAD
 callbacks (see
-.BR selinux_set_callback(3))
+.BR selinux_set_callback (3))
 and any registered
 .B AVC_CALLBACK_RESET
 callbacks are invoked exactly once.
@@ -119,4 +119,5 @@ are not serialized against concurrent callers of the other functions.
 .BR mmap (2),
 .BR avc_netlink_open (3),
 .BR security_getenforce (3),
-.BR security_deny_unknown (3)
+.BR security_deny_unknown (3),
+.BR selinux (8)
diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/setfilecon.3
index 621201e7..c1d1cecd 100644
--- a/libselinux/man/man3/setfilecon.3
+++ b/libselinux/man/man3/setfilecon.3
@@ -22,14 +22,18 @@ setfilecon, fsetfilecon, lsetfilecon \- set SELinux security context of a file
 sets the security context of the file system object.
 
 .BR lsetfilecon ()
-is identical to setfilecon, except in the case of a symbolic link, where the
-link itself has it's context set, not the file that it refers to.
+is identical to
+.BR setfilecon (),
+except in the case of a symbolic link, where the
+link itself has its context set, not the file that it refers to.
 
 .BR fsetfilecon ()
-is identical to setfilecon, only the open file pointed to by filedes (as
+is identical to
+.BR setfilecon (),
+only the open file pointed to by fd (as
 returned by
 .BR open (2))
-has it's context set in place of path.  Since libselinux 3.4 a file opened via
+has its context set in place of path.  Since libselinux 3.4 a file opened via
 .I O_PATH
 is supported.
 
diff --git a/libselinux/man/man5/selabel_db.5 b/libselinux/man/man5/selabel_db.5
index 76c2834e..93ea8012 100644
--- a/libselinux/man/man5/selabel_db.5
+++ b/libselinux/man/man5/selabel_db.5
@@ -90,7 +90,7 @@ argument specifies the name of a language object, such as "postgres.public.tcl".
 .B SELABEL_DB_EXCEPTION
 The
 .I object_name
-argument specifies the name of a exception object.
+argument specifies the name of an exception object.
 .TP
 .B SELABEL_DB_DATATYPE
 The
@@ -126,10 +126,12 @@ The default database object contexts file is:
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
 .sp
-The entries within the database contexts file are shown in the \fBObject Name String Values\fR and \fBFILE FORMAT\fR sections.
+The entries within the database contexts file are shown in the \fBOBJECT NAME
+STRING VALUES\fR and \fBFILE FORMAT\fR sections.
 .
-.SH "Object Name String Values"
-The string name assigned to each \fIobject_type\fR argument that can be present in the database contexts file are:
+.SH "OBJECT NAME STRING VALUES"
+The string name assigned to each \fIobject_type\fR argument that can be present
+in the database contexts file are:
 .TS
 center, allbox, tab(@);
 lI lB
@@ -159,7 +161,8 @@ Where:
 .RS
 .I object_type
 .RS
-This is the string representation of the object type shown in the \fBObject Name String Values\fR section.
+This is the string representation of the object type shown in the \fBOBJECT NAME
+STRING VALUES\fR section.
 .RE
 .I object_name
 .RS
diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
index 188be883..05f88eb9 100644
--- a/libselinux/man/man5/selabel_file.5
+++ b/libselinux/man/man5/selabel_file.5
@@ -55,13 +55,13 @@ A non-null value for this option specifies a path to a file that will be opened
 A non-null value for this option indicates that any local customizations to the file contexts mapping should be ignored.
 .TP
 .B SELABEL_OPT_SUBSET
-A non-null value for this option is interpreted as a path prefix, for example "/etc".  Only file context specifications with starting with a first component that prefix matches the given prefix are loaded.  This may increase lookup performance, however any attempt to look up a path not starting with the given prefix may fail.  This optimization is no longer required due to the use of
+A non-null value for this option is interpreted as a path prefix, for example "/etc".  Only file context specifications starting with a first component that prefix matches the given prefix are loaded.  This may increase lookup performance, however any attempt to look up a path not starting with the given prefix may fail.  This optimization is no longer required due to the use of
 .I file_contexts.bin
 files and is deprecated.
 .RE
 .
 .SH "FILES"
-The file context files used to retrieve the default context depends on the \fBSELABEL_OPT_PATH\fR parameter passed to \fBselabel_open\fR(3). If \fINULL\fR, then the \fBSELABEL_OPT_PATH\fR value will default to the active policy file contexts location (as returned by \fBselinux_file_context_path\fR(3)), otherwise the actual \fBSELABEL_OPT_PATH\fR value specified is used.
+The file context files used to retrieve the default context depend on the \fBSELABEL_OPT_PATH\fR parameter passed to \fBselabel_open\fR(3). If \fINULL\fR, then the \fBSELABEL_OPT_PATH\fR value will default to the active policy file contexts location (as returned by \fBselinux_file_context_path\fR(3)), otherwise the actual \fBSELABEL_OPT_PATH\fR value specified is used.
 .sp
 If \fBSELABEL_OPT_BASEONLY\fR is set, then the following files will be processed:
 .RS
@@ -187,7 +187,7 @@ Where:
 .RS
 .I subs_pathname
 .RS
-The path that will be aliased (considered equivalent) with pathname by the look up process.
+The path that will be aliased (considered equivalent) with pathname by the lookup process.
 A path component consisting of a single \fB*\fR matches exactly one
 non-empty component of the input path.
 When the last component of \fIsubs_pathname\fR is \fB*\fR the
@@ -239,7 +239,7 @@ unchanged. Paths outside substitution prefixes retain per-directory digests.
 .IP "1." 4
 If contexts are to be validated, then the global option \fBSELABEL_OPT_VALIDATE\fR must be set before calling \fBselabel_open\fR(3). If this is not set, then it is possible for an invalid context to be returned.
 .IP "2." 4
-If the size of file contexts series of files contain many entries, then \fBselabel_open\fR(3) may have a delay as it reads in the files, and if
+If the file contexts series of files contains many entries, then \fBselabel_open\fR(3) may have a delay as it reads in the files, and if
 requested validates the entries.
 .IP "3." 4
 Depending on the version of SELinux it is possible that a \fIfile_contexts.template\fR file may also be present, however this is now deprecated.
diff --git a/libselinux/man/man5/selabel_x.5 b/libselinux/man/man5/selabel_x.5
index 58e2128e..bb240f4e 100644
--- a/libselinux/man/man5/selabel_x.5
+++ b/libselinux/man/man5/selabel_x.5
@@ -92,10 +92,12 @@ The default X object contexts file is:
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
 .sp
-The entries within the X contexts file are shown in the \fBObject Name String Values\fR and \fBFILE FORMAT\fR sections.
+The entries within the X contexts file are shown in the \fBOBJECT NAME STRING
+VALUES\fR and \fBFILE FORMAT\fR sections.
 .
-.SH "Object Name String Values"
-The string name assigned to each \fIobject_type\fR argument that can be present in the X contexts file are:
+.SH "OBJECT NAME STRING VALUES"
+The string name assigned to each \fIobject_type\fR argument that can be present
+in the X contexts file are:
 .TS
 center, allbox, tab(@);
 lI lB
@@ -120,8 +122,10 @@ Where:
 .RS
 .I object_type
 .RS
-This is the string representation of the object type shown in the \fBObject Name String Values\fR section.
-There can be multiple lines with the same \fIobject_type\fR string that will form a block of entries (each with a different \fIobject_name\fR entry).
+This is the string representation of the object type shown in the \fBOBJECT NAME
+STRING VALUES\fR section.
+There can be multiple lines with the same \fIobject_type\fR string that will
+form a block of entries (each with a different \fIobject_name\fR entry).
 .RE
 .I object_name
 .RS
diff --git a/libselinux/man/man5/service_seusers.5 b/libselinux/man/man5/service_seusers.5
index ae60e1f6..ec3226fc 100644
--- a/libselinux/man/man5/service_seusers.5
+++ b/libselinux/man/man5/service_seusers.5
@@ -1,17 +1,21 @@
 .TH "service_seusers" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
 .SH "NAME"
-service_seusers \- The SELinux GNU/Linux user and service to SELinux user mapping configuration files
+service_seusers \- The SELinux Linux user and service to SELinux user
+mapping configuration files
 .
 .SH "DESCRIPTION"
 These are optional files that allow services to define an SELinux user when authenticating via SELinux-aware login applications such as
 .BR PAM "(8). "
 .sp
-There is one file for each GNU/Linux user name that will be required to run a service with a specific SELinux user name.
+There is one file for each Linux user name that will be required to run a
+service with a specific SELinux user name.
 .sp
 The path for each configuration file is formed by the path returned by
-.BR selinux_policy_root "(3) with  "
-.IR /logins/username
-appended (where \fIusername\fR is a file representing the GNU/Linux user name). The default services directory is located at:
+.BR selinux_policy_root (3)
+with
+.I /logins/username
+appended (where \fIusername\fR is a file representing the Linux user
+name). The default services directory is located at:
 .RS
 .I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/logins
 .RE
@@ -52,7 +56,7 @@ ipa:user_u:s0
 this_service:unconfined_u:s0
 .RE
 .sp
-Example 2 - for GNU/Linux user 'rch':
+Example 2 - for Linux user 'rch':
 .RS
 # ./logins/rch
 .br
diff --git a/libselinux/man/man5/seusers.5 b/libselinux/man/man5/seusers.5
index 049be6ea..7f0a82f4 100644
--- a/libselinux/man/man5/seusers.5
+++ b/libselinux/man/man5/seusers.5
@@ -1,11 +1,12 @@
 .TH "seusers" "5" "28-Nov-2011" "Security Enhanced Linux" "SELinux configuration"
 .SH "NAME"
-seusers \- The SELinux GNU/Linux user to SELinux user mapping configuration file
+seusers \- The Linux user to SELinux user mapping configuration file
 .
 .SH "DESCRIPTION"
 The
 .I seusers
-file contains a list GNU/Linux user to SELinux user mapping for use by SELinux-aware login applications such as \fBPAM\fR(8).
+file contains a list of Linux user to SELinux user mappings for use by
+SELinux-aware login applications such as \fBPAM\fR(8).
 .sp
 .BR selinux_usersconf_path "(3) "
 will return the active policy path to this file. The default SELinux users mapping file is located at:
@@ -15,8 +16,9 @@ will return the active policy path to this file. The default SELinux users mappi
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
 .sp
-.BR getseuserbyname "(3) reads this file to map a GNU/Linux user or group to an SELinux user. "
-See that page for the order in which entries are matched.
+.BR getseuserbyname (3)
+reads this file to map a Linux user or group to a SELinux user.  See that page
+for the order in which entries are matched.
 .
 .SH "FILE FORMAT"
 Each line of the
@@ -31,13 +33,14 @@ Where:
 .RS
 \fIgroup_id\fR|\fIuser_id
 .RS
-\fRThe  GNU/Linux user id, or if preceded by the percentage (\fB%\fR) symbol, then a GNU/Linux group id.
+\fRThe Linux user id, or if preceded by the percentage (\fB%\fR) symbol,
+then a Linux group id.
 .br
 An optional entry set to \fB__default__\fR can be provided as a fall back if required.
 .RE
 .I seuser_id
 .RS
-The SELinux  user identity.
+The SELinux user identity.
 .RE
 .I range
 .RS
-- 
2.55.0

