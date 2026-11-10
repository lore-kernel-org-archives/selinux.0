Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310192;
	b=Rj3B8Np4numoeAi8Cr8puevl5R3y3D0Qo8pTrEUDCLMxmQ4uNpYmax+QptJD0HGrpso7
	 W2lqKqlhQPjws8Co/KaoAJOFAU4CeRCBL+4LAB6Okp6VkktLPlvimK9d7WLkjJ+xmzDdc
	 ynIVjNvyLVA/kfIFu78p96eHaYfjYaTDQk6ertCwKyEv9GNc82lE+IBx98SjrEpIElaNo
	 V590fJflRL8af2I82ZiC1REF450hJEKEIIy5X3+zuj5nS7349fgulcyUqE+SYdmeqDGEN
	 paKewCeueFJzUmz80dYbA+1S6caJpI9YUT/GnUoWjFCajWoQA4bJvvEMb1DJHlPom7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310192;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jKpQeTbfN7KQMIfyYgAzE0r07+U/QNguAAFYY09baV4=;
	b=IDeLuE3+tSjV9TY/WKVBI+IlHqNW2ggsC9ekF9Jv1K6Dq+Yjep9BHFcx0lzsHnSYpleH
	 jfVMmLWyXo7gf8thRsmDSGs2Q0oqKObQ6zYyyahiSeAATW7xz/Dx+v2sEZI98pFSL2Yuv
	 alf3n8P/bgNhCIGJMU59IlxR/XCg1JybOlrmyqEAJb26D+tbbFeig7ZCA1nXvf+/80PUN
	 3qBidvrdS++Y0AXmfyArmXLY8RhXl2KadU5ZT+oiqwA6bgOxFK6ruaIhYHQ0ptmeBzVj+
	 KfXHyP0vuMh65TuvI2LEr9TJkB+PCA120/AwhshOtY3CDEiPJv9ZaKBRwcx1pBwu1pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=pE4GVMSR;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F09606A32A
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10F09606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=pE4GVMSR
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794310188;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKpQeTbfN7KQMIfyYgAzE0r07+U/QNguAAFYY09baV4=;
	b=pE4GVMSR5P9d4VzyDTUgBaYvtRc57Dc1s1iUJr+SCAWD1remtZLnoxgIQSC79f1gtlhbhW
	x2Xi9CXCOzvsQJ6xy1T4PKkVouWnWgRqcIb2F6WdXltflSRx4lTRH7yiH6cgPf6iZfRKsi
	tJgbnI2yFfO+1zPwHGse31ohoABWOB2e292JY4hLROSpy83rSTxdLVhjVqMV+B0SGhs8No
	bdPczyE7mbLKqOTTRJAn9eKi42hSHhjh6bYfuLVMHJiNiCJ0/1kz5HkhcGAHJgdURNx/4/
	PkdXSendWvXluwgwkHcwqyQ+Nr7DCV+d9zRdByeseokS7T8mtLrEucUCC+//Dw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 1/8] libselinux/man: correct man pages contradicting the API
Date: Tue, 10 Nov 2026 12:29:31 +0100
Message-ID: <20261110112931.99557-8-cgoettsche@seltendoof.de>
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

Several man pages disagree with the public headers or with the actual
behavior of the library and tools:

- get_ordered_context_list(3) listed a non-existent get_default_role()
  in NAME; the function described is get_default_type(). Also mention
  the <selinux/get_default_type.h> header it and
  selinux_default_type_path() require.
- Align parameter names with the prototypes: opts/nopts for avc_open()
  and selabel_open(), seuser for getseuserbyname(), tclass for
  selinux_check_access(), aliases for selabel_lookup_best_match(),
  rootpath for selinux_set_policy_root(), cb for selinux_set_callback(),
  con for the getcon() and getexeccon() families, and path for
  matchpathcon_index().
- avc_compute_create(3) referred to the wrong output parameter.
- getkeycreatecon(3) and getsockcreatecon(3) carried text copied from
  the file creation variant.
- The preservebools argument of selinux_mkload_policy() is no longer
  supported, and booleans(8) still advertised resetting booleans via
  load_policy -b, which is a deprecated no-op.
- selinux_binary_policy_path(3) omitted several of the accessors it
  describes from NAME and SYNOPSIS.
- The description and return value of selinux_set_policy_root() were
  garbled.
- avc_get_initial_sid() was missing from RETURN VALUE in
  avc_context_to_sid(3).
- security_compute_create() operates on a pair of contexts, not SIDs.
- selinux_check_passwd_access() is deprecated in the header, but was
  not marked as such.
- selinux_set_mapping(3) showed perms[] as a flexible array member,
  while it has a fixed size.
- getcon(3) referenced execve in section 3 instead of 2, setfilecon(3)
  selinux in section 3 instead of 8, and selinuxexeccon(8) secon in
  section 8 instead of 1.
- selinux_file_context_verify(3): a lookup failing with EINVAL returns
  -1, not 0, and the 0 return with ENOTSUP was undocumented. Also list
  file_contexts.subs_dist under FILES.
- selabel_file(5) labeled the columns of the substitution file example
  in reverse order, contradicting the format line and the example
  below it.
- selabel_db(5): the default contexts file is sepgsql_contexts, an
  object name had a stray "B", and one example used "postgresql" as
  the database name instead of "postgres".

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/avc_compute_create.3      |  2 +-
 libselinux/man/man3/avc_context_to_sid.3      |  5 ++--
 libselinux/man/man3/avc_open.3                |  2 +-
 .../man/man3/get_ordered_context_list.3       |  4 ++-
 libselinux/man/man3/getcon.3                  | 28 +++++++++----------
 libselinux/man/man3/getexeccon.3              | 12 ++++----
 libselinux/man/man3/getkeycreatecon.3         |  6 ++--
 libselinux/man/man3/getsockcreatecon.3        |  8 +++---
 libselinux/man/man3/matchpathcon.3            |  4 +--
 libselinux/man/man3/security_compute_av.3     | 10 +++++--
 libselinux/man/man3/security_load_policy.3    |  7 ++---
 .../man/man3/selabel_lookup_best_match.3      | 12 ++++----
 libselinux/man/man3/selabel_open.3            | 12 ++++----
 .../man/man3/selinux_binary_policy_path.3     | 21 ++++++++++----
 .../man/man3/selinux_file_context_verify.3    | 25 ++++++++++-------
 libselinux/man/man3/selinux_policy_root.3     | 12 ++++----
 libselinux/man/man3/selinux_set_callback.3    |  4 +--
 libselinux/man/man3/selinux_set_mapping.3     |  2 +-
 libselinux/man/man3/setfilecon.3              |  2 +-
 libselinux/man/man5/selabel_db.5              |  6 ++--
 libselinux/man/man5/selabel_file.5            | 10 +++----
 libselinux/man/man8/booleans.8                |  7 ++---
 libselinux/man/man8/selinuxexeccon.8          |  2 +-
 23 files changed, 110 insertions(+), 93 deletions(-)

diff --git a/libselinux/man/man3/avc_compute_create.3 b/libselinux/man/man3/avc_compute_create.3
index ce615bf8..168b00b9 100644
--- a/libselinux/man/man3/avc_compute_create.3
+++ b/libselinux/man/man3/avc_compute_create.3
@@ -33,7 +33,7 @@ but does not require converting from userspace SID's to contexts and back again.
 
 These functions
 return a SID for the computed context in the memory referenced by
-.IR sid .
+.IR newsid .
 .
 .SH "RETURN VALUE"
 On success, zero is returned.  On error, \-1 is returned and
diff --git a/libselinux/man/man3/avc_context_to_sid.3 b/libselinux/man/man3/avc_context_to_sid.3
index 4586b999..e66c8913 100644
--- a/libselinux/man/man3/avc_context_to_sid.3
+++ b/libselinux/man/man3/avc_context_to_sid.3
@@ -38,9 +38,10 @@ returns a SID for the kernel initial security identifier specified by
 .IR name .
 .
 .SH "RETURN VALUE"
-.BR avc_context_to_sid ()
-and
+.BR avc_context_to_sid (),
 .BR avc_sid_to_context ()
+and
+.BR avc_get_initial_sid ()
 return zero on success.  On error, \-1 is returned and
 .I errno
 is set appropriately.
diff --git a/libselinux/man/man3/avc_open.3 b/libselinux/man/man3/avc_open.3
index a02d7e0b..d5769476 100644
--- a/libselinux/man/man3/avc_open.3
+++ b/libselinux/man/man3/avc_open.3
@@ -10,7 +10,7 @@ avc_open, avc_destroy, avc_reset, avc_cleanup \- userspace SELinux AVC setup and
 .br
 .B #include <selinux/avc.h>
 .sp
-.BI "int avc_open(const struct selinux_opt *" options ", unsigned " nopt ");"
+.BI "int avc_open(const struct selinux_opt *" opts ", unsigned " nopts ");"
 .sp
 .BI "void avc_destroy(void);"
 .sp
diff --git a/libselinux/man/man3/get_ordered_context_list.3 b/libselinux/man/man3/get_ordered_context_list.3
index f9daaddb..8c741237 100644
--- a/libselinux/man/man3/get_ordered_context_list.3
+++ b/libselinux/man/man3/get_ordered_context_list.3
@@ -1,11 +1,13 @@
 .TH "get_ordered_context_list" "3" "1 January 2004" "russell@coker.com.au" "SELinux"
 .SH "NAME"
-get_ordered_context_list, get_ordered_context_list_with_level, get_default_context, get_default_context_with_level, get_default_context_with_role, get_default_context_with_rolelevel, query_user_context, manual_user_enter_context, get_default_role \- determine SELinux context(s) for user sessions
+get_ordered_context_list, get_ordered_context_list_with_level, get_default_context, get_default_context_with_level, get_default_context_with_role, get_default_context_with_rolelevel, query_user_context, manual_user_enter_context, get_default_type \- determine SELinux context(s) for user sessions
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .br
 .B #include <selinux/get_context_list.h>
+.br
+.B #include <selinux/get_default_type.h>
 .sp
 .BI "int get_ordered_context_list(const char *" user ", const char *" fromcon ", char ***" list );
 .sp
diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index be60341b..b9d6246c 100644
--- a/libselinux/man/man3/getcon.3
+++ b/libselinux/man/man3/getcon.3
@@ -11,33 +11,33 @@ setcon \- set current security context of a process
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int getcon(char **" context );
+.BI "int getcon(char **" con );
 .sp
-.BI "int getcon_raw(char **" context );
+.BI "int getcon_raw(char **" con );
 .sp
-.BI "int getprevcon(char **" context );
+.BI "int getprevcon(char **" con );
 .sp
-.BI "int getprevcon_raw(char **" context );
+.BI "int getprevcon_raw(char **" con );
 .sp
-.BI "int getpidcon(pid_t " pid ", char **" context );
+.BI "int getpidcon(pid_t " pid ", char **" con );
 .sp
-.BI "int getpidcon_raw(pid_t " pid ", char **" context );
+.BI "int getpidcon_raw(pid_t " pid ", char **" con );
 .sp
-.BI "int getpidprevcon(pid_t " pid ", char **" context );
+.BI "int getpidprevcon(pid_t " pid ", char **" con );
 .sp
-.BI "int getpidprevcon_raw(pid_t " pid ", char **" context );
+.BI "int getpidprevcon_raw(pid_t " pid ", char **" con );
 .sp
-.BI "int getpeercon(int " fd ", char **" context );
+.BI "int getpeercon(int " fd ", char **" con );
 .sp
-.BI "int getpeercon_raw(int " fd ", char **" context );
+.BI "int getpeercon_raw(int " fd ", char **" con );
 .sp
 .BI "void freecon(char *" con );
 .sp
 .BI "void freeconary(char **" con );
 .sp
-.BI "int setcon(const char *" context );
+.BI "int setcon(const char *" con );
 .sp
-.BI "int setcon_raw(const char *" context );
+.BI "int setcon_raw(const char *" con );
 
 .SH "DESCRIPTION"
 .TP
@@ -90,7 +90,7 @@ security contexts, unlike exec-based transitions performed via
 When possible, decompose your application and use
 .BR setexeccon (3)
 and
-.BR execve (3)
+.BR execve (2)
 instead.
 
 Since access to file descriptors is revalidated upon use by SELinux,
@@ -146,7 +146,7 @@ On error \-1 is returned with errno set.  On success 0 is returned.
 
 .SH "NOTES"
 The retrieval functions might return success and set
-.I *context
+.I *con
 to NULL if and only if SELinux is not enabled.
 
 Querying a foreign process via its PID, e.g. \fBgetpidcon\fR() or
diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/getexeccon.3
index edaa6669..ea1b1801 100644
--- a/libselinux/man/man3/getexeccon.3
+++ b/libselinux/man/man3/getexeccon.3
@@ -7,13 +7,13 @@ rpm_execcon \- run a helper for rpm in an appropriate security context
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int getexeccon(char **" context );
+.BI "int getexeccon(char **" con );
 .sp
-.BI "int getexeccon_raw(char **" context );
+.BI "int getexeccon_raw(char **" con );
 .sp
-.BI "int setexeccon(const char *" context );
+.BI "int setexeccon(const char *" con );
 .sp
-.BI "int setexeccon_raw(const char *" context );
+.BI "int setexeccon_raw(const char *" con );
 .sp
 .BI "int setexecfilecon(const char *" filename ", const char *" fallback_type );
 .sp
@@ -26,9 +26,7 @@ This returned context should be freed with
 .BR freecon (3)
 if non-NULL.
 .BR getexeccon ()
-sets
-.BI * context
-to NULL if no exec context has been explicitly
+sets *con to NULL if no exec context has been explicitly
 set by the program (i.e. using the default policy behavior).
 
 .BR setexeccon ()
diff --git a/libselinux/man/man3/getkeycreatecon.3 b/libselinux/man/man3/getkeycreatecon.3
index 0ef27be7..2bc40ddf 100644
--- a/libselinux/man/man3/getkeycreatecon.3
+++ b/libselinux/man/man3/getkeycreatecon.3
@@ -1,6 +1,6 @@
 .TH "getkeycreatecon" "3" "9 September 2008" "dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
-getkeycreatecon, setkeycreatecon \- get or set the SELinux security context used for creating a new kernel keyrings
+getkeycreatecon, setkeycreatecon \- get or set the SELinux security context used for creating a new kernel keyring
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -34,8 +34,8 @@ so a program doesn't need to explicitly sanitize it upon startup.
 
 .BR setkeycreatecon ()
 can be applied prior to library
-functions that internally perform an file creation,
-in order to set an file context on the objects.
+functions that internally create a kernel keyring,
+in order to set a context on the new keyrings.
 
 .BR getkeycreatecon_raw ()
 and
diff --git a/libselinux/man/man3/getsockcreatecon.3 b/libselinux/man/man3/getsockcreatecon.3
index 9795fb65..4deac7f9 100644
--- a/libselinux/man/man3/getsockcreatecon.3
+++ b/libselinux/man/man3/getsockcreatecon.3
@@ -1,6 +1,6 @@
 .TH "getsockcreatecon" "3" "24 September 2008" "dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
-getsockcreatecon, setsockcreatecon \- get or set the SELinux security context used for creating a new labeled sockets
+getsockcreatecon, setsockcreatecon \- get or set the SELinux security context used for creating a new labeled socket
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
@@ -24,7 +24,7 @@ sets *con to NULL if no sockcreate context has been explicitly
 set by the program (i.e. using the default policy behavior).
 
 .BR setsockcreatecon ()
-sets the context used for creating a new labeled network sockets
+sets the context used for creating a new labeled network socket.
 NULL can be passed to
 .BR setsockcreatecon ()
 to reset to the default policy behavior.
@@ -34,8 +34,8 @@ so a program doesn't need to explicitly sanitize it upon startup.
 
 .BR setsockcreatecon ()
 can be applied prior to library
-functions that internally perform an file creation,
-in order to set an file context on the objects.
+functions that internally create a socket,
+in order to set a context on the new sockets.
 
 .BR getsockcreatecon_raw ()
 and
diff --git a/libselinux/man/man3/matchpathcon.3 b/libselinux/man/man3/matchpathcon.3
index 88bc47c0..ce33dc34 100644
--- a/libselinux/man/man3/matchpathcon.3
+++ b/libselinux/man/man3/matchpathcon.3
@@ -13,7 +13,7 @@ matchpathcon, matchpathcon_index \- get the default SELinux security context for
 .sp
 .BI "int matchpathcon(const char *" path ", mode_t " mode ", char **" con ");
 .sp
-.BI "int matchpathcon_index(const char *" name ", mode_t " mode ", char **" con ");"
+.BI "int matchpathcon_index(const char *" path ", mode_t " mode ", char **" con ");"
 .
 .SH "DESCRIPTION"
 
@@ -80,7 +80,7 @@ calls, or to free memory when finished using
 
 .BR matchpathcon ()
 matches the specified
-.I pathname,
+.IR path ,
 after transformation via
 .BR realpath (3)
 excepting any final symbolic link component if S_IFLNK was
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index 98e53095..29459190 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -43,7 +43,7 @@ the SELinux policy database in the kernel
 .sp
 .BI "int security_get_initial_context_raw(const char *" name ", char **" con );
 .sp
-.BI "int selinux_check_access(const char *" scon ", const char *" tcon ", const char *" class ", const char *" perm ", void *" auditdata);
+.BI "int selinux_check_access(const char *" scon ", const char *" tcon ", const char *" tclass ", const char *" perm ", void *" auditdata);
 .sp
 .BI "int selinux_check_passwd_access(access_vector_t " requested );
 .sp
@@ -108,7 +108,10 @@ which indicates the decision is computed on a permissive domain.
 
 .BR security_compute_create ()
 is used to compute a context to use for labeling a new object in a particular
-class based on a SID pair.
+class based on the source context
+.I scon
+and target context
+.IR tcon .
 
 .BR security_compute_create_name ()
 is identical to
@@ -172,6 +175,9 @@ class.
 uses
 .BR getprevcon(3)
 for the source and target security contexts.
+This function is deprecated; use
+.BR selinux_check_access ()
+instead.
 
 .BR checkPasswdAccess ()
 is a deprecated alias of the
diff --git a/libselinux/man/man3/security_load_policy.3 b/libselinux/man/man3/security_load_policy.3
index b2da0256..18fcfbd4 100644
--- a/libselinux/man/man3/security_load_policy.3
+++ b/libselinux/man/man3/security_load_policy.3
@@ -24,11 +24,8 @@ the policy file, mapping it into memory, manipulating it as needed for
 current boolean settings and/or local definitions, and then calling
 security_load_policy to load it.
 .I preservebools
-is a boolean flag indicating whether current policy boolean values should
-be preserved into the new policy (if 1) or reset to the saved policy
-settings (if 0). The former case is the default for policy reloads, while
-the latter case is an option for policy reloads but is primarily used for
-the initial policy load.
+is no longer supported and should be set to 0.
+
 .BR selinux_init_load_policy ()
 performs the initial policy load. This function determines the desired
 enforcing mode, sets the
diff --git a/libselinux/man/man3/selabel_lookup_best_match.3 b/libselinux/man/man3/selabel_lookup_best_match.3
index 985a8600..4d94d97c 100644
--- a/libselinux/man/man3/selabel_lookup_best_match.3
+++ b/libselinux/man/man3/selabel_lookup_best_match.3
@@ -15,7 +15,7 @@ context \- Only supported on file backend.
 .br
 .BI "const char *" key ,
 .br
-.BI "const char **" links ,
+.BI "const char **" aliases ,
 .br
 .BI "int " type ");"
 .in
@@ -26,7 +26,7 @@ context \- Only supported on file backend.
 .br
 .BI "const char *" key ,
 .br
-.BI "const char **" links ,
+.BI "const char **" aliases ,
 .br
 .BI "int " type ");"
 .in
@@ -40,12 +40,12 @@ returning the result in the memory pointed to by
 which must be freed by the caller using
 .BR freecon (3).
 The \fIkey\fR parameter is a file path to check for best match using zero or
-more \fIlink\fR (aliases) parameters. The order of precedence for best match is:
+more \fIaliases\fR (links). The order of precedence for best match is:
 .RS
 .IP "1." 4
 An exact match for the real path (\fIkey\fR) or
 .IP "2." 4
-An exact match for any of the \fIlink\fRs (aliases), or
+An exact match for any of the \fIaliases\fR (links), or
 .IP "3." 4
 The longest fixed prefix match.
 .RE
@@ -89,8 +89,8 @@ Example usage - When a service creates a device node, it may also create one
 or more symlinks to the device node.  These symlinks may be the only stable
 name for the device, e.g. if the partition is dynamically assigned.
 The file label backend supports this by looking up the "best match"
-for a device node based on its real path (\fIkey\fR) and any \fIlink\fRs to it
-(aliases). The order of precedence for best match is described above.
+for a device node based on its real path (\fIkey\fR) and any \fIaliases\fR
+(links) to it. The order of precedence for best match is described above.
 .sp
 .SH "SEE ALSO"
 .BR selabel_open (3),
diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/selabel_open.3
index fa71d27c..3a496d59 100644
--- a/libselinux/man/man3/selabel_open.3
+++ b/libselinux/man/man3/selabel_open.3
@@ -12,9 +12,9 @@ selabel_open, selabel_close \- userspace SELinux labeling interface
 .sp
 .BI "struct selabel_handle *selabel_open(unsigned int " backend ,
 .in +\w'struct selabel_handle *selabel_open('u
-.BI "const struct selinux_opt *" options ,
+.BI "const struct selinux_opt *" opts ,
 .br
-.BI "unsigned " nopt ");"
+.BI "unsigned " nopts ");"
 .in
 .sp
 .BI "void selabel_close(struct selabel_handle *" hnd ");"
@@ -27,12 +27,12 @@ argument specifies which backend is to be opened; the list of current backends a
 .B BACKENDS
 below.
 
-The 
-.I options
-argument should be NULL or a pointer to an array of 
+The
+.I opts
+argument should be NULL or a pointer to an array of
 .B selinux_opt
 structures of length
-.IR nopt :
+.IR nopts :
 
 .RS
 .ta 4n 16n 24n
diff --git a/libselinux/man/man3/selinux_binary_policy_path.3 b/libselinux/man/man3/selinux_binary_policy_path.3
index 4c2bb45e..612d86fc 100644
--- a/libselinux/man/man3/selinux_binary_policy_path.3
+++ b/libselinux/man/man3/selinux_binary_policy_path.3
@@ -1,14 +1,17 @@
 .TH "selinux_binary_policy_path" "3" "15 November 2004" "dwalsh@redhat.com" "SELinux API Documentation"
 .SH "NAME"
 selinux_path, selinux_policy_root, selinux_binary_policy_path, selinux_current_policy_path,
-selinux_failsafe_context_path, selinux_removable_context_path,
-selinux_default_context_path, selinux_user_contexts_path,
-selinux_file_context_path, selinux_media_context_path,
-selinux_contexts_path \- These functions return the paths to the active SELinux policy configuration
-directories and files
+selinux_default_type_path, selinux_failsafe_context_path, selinux_removable_context_path,
+selinux_default_context_path, selinux_user_contexts_path, selinux_usersconf_path,
+selinux_x_context_path, selinux_sepgsql_context_path, selinux_netfilter_context_path,
+selinux_file_context_path, selinux_file_context_local_path, selinux_file_context_homedir_path,
+selinux_media_context_path, selinux_contexts_path, selinux_securetty_types_path \- These functions
+return the paths to the active SELinux policy configuration directories and files
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
+.br
+.B #include <selinux/get_default_type.h>
 .sp
 
 .B const char *selinux_path(void);
@@ -19,6 +22,8 @@ directories and files
 .sp
 .B const char *selinux_current_policy_path(void);
 .sp
+.B const char *selinux_default_type_path(void);
+.sp
 .B const char *selinux_failsafe_context_path(void);
 .sp
 .B const char *selinux_removable_context_path(void);
@@ -35,6 +40,12 @@ directories and files
 .sp
 .B const char *selinux_file_context_path(void);
 .sp
+.B const char *selinux_file_context_local_path(void);
+.sp
+.B const char *selinux_file_context_homedir_path(void);
+.sp
+.B const char *selinux_netfilter_context_path(void);
+.sp
 .B const char *selinux_media_context_path(void);
 .sp
 .B const char *selinux_securetty_types_path(void);
diff --git a/libselinux/man/man3/selinux_file_context_verify.3 b/libselinux/man/man3/selinux_file_context_verify.3
index 893949f1..64b4304e 100644
--- a/libselinux/man/man3/selinux_file_context_verify.3
+++ b/libselinux/man/man3/selinux_file_context_verify.3
@@ -22,21 +22,21 @@ Note that the two contexts are compared for "significant" differences (i.e. the
 section.
 .
 .SH "RETURN VALUE"
-If the contexts significantly match, 1 (one) is returned.
+If the context held on disk significantly matches the default context, 1 (one)
+is returned.
 .sp
-If the contexts do not match 0 (zero) is returned and
+If they do not match, 0 (zero) is returned.  In this case
 .I errno
-is set to either
+is set to
 .B ENOENT
 or
-.B EINVAL
-for the reasons listed in the
+.B ENOTSUP
+for one of the reasons listed in the
 .B ERRORS
-section, or if
-.I errno
-= 0 then the contexts did not match.
+section, or to 0 to indicate that a default context was found but did not
+significantly match the context on disk.
 .sp
-On failure \-1 is returned and
+On error, \-1 is returned and
 .I errno
 set appropriately.
 .
@@ -74,7 +74,12 @@ default context:
 - If exists has users home directory customizations.
 .sp
 .I contexts/files/file_contexts.subs
-- If exists has substitutions that are then applied to the 'in memory' version of the file contexts files.
+- If it exists, holds local substitutions that are then applied to the 'in
+memory' version of the file contexts files.
+.sp
+.I contexts/files/file_contexts.subs_dist
+- If it exists, holds distribution substitutions that are then applied to
+the 'in memory' version of the file contexts files.
 .RE
 .
 .SH "EXAMPLE"
diff --git a/libselinux/man/man3/selinux_policy_root.3 b/libselinux/man/man3/selinux_policy_root.3
index e4f9b794..1c3c5081 100644
--- a/libselinux/man/man3/selinux_policy_root.3
+++ b/libselinux/man/man3/selinux_policy_root.3
@@ -9,7 +9,7 @@ selinux_set_policy_root \- Set an alternate SELinux root path for the SELinux po
 .B const char *selinux_policy_root(void);
 .
 .sp
-.B int selinux_set_policy_root(const char *policypath);
+.B int selinux_set_policy_root(const char *rootpath);
 .
 .SH "DESCRIPTION"
 .BR selinux_policy_root ()
@@ -18,16 +18,16 @@ reads the contents of the
 file to determine which policy files should be used for this machine.
 .
 .BR selinux_set_policy_root ()
-sets up all policy paths based on the alternate root
-
-.I {/etc,/usr/lib}/selinux/config
-file to determine which policy files should be used for this machine.
+sets an alternate policy root directory path,
+.IR rootpath ,
+under which the compiled policy file and context configuration files are
+located, and recomputes all policy paths relative to it.
 .
 .SH "RETURN VALUE"
 On success, selinux_policy_root returns a directory path containing the SELinux policy files.
 On failure, selinux_policy_root returns NULL.
 
-On success, selinux_set_policy_root returns 0 on success -1 on failure.
+selinux_set_policy_root returns 0 on success or \-1 on failure.
 
 .
 .SH "SEE ALSO"
diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/man/man3/selinux_set_callback.3
index 9bdc5573..e4d7ffa6 100644
--- a/libselinux/man/man3/selinux_set_callback.3
+++ b/libselinux/man/man3/selinux_set_callback.3
@@ -8,14 +8,14 @@ selinux_set_callback \- userspace SELinux callback facilities
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "void selinux_set_callback(int " type ", union selinux_callback " callback ");"
+.BI "void selinux_set_callback(int " type ", union selinux_callback " cb ");"
 .
 .SH "DESCRIPTION"
 .BR selinux_set_callback ()
 sets the callback indicated by
 .I type
 to the value of
-.IR callback ,
+.IR cb ,
 which should be passed as a function pointer cast to type
 .B union
 .BR selinux_callback .
diff --git a/libselinux/man/man3/selinux_set_mapping.3 b/libselinux/man/man3/selinux_set_mapping.3
index bb48eb43..cb8279f8 100644
--- a/libselinux/man/man3/selinux_set_mapping.3
+++ b/libselinux/man/man3/selinux_set_mapping.3
@@ -11,7 +11,7 @@ selinux_set_mapping \- establish dynamic object class and permission mapping
 .nf
 struct security_class_mapping {
 	const char *name;
-	const char *perms[];
+	const char *perms[sizeof(access_vector_t) * 8 + 1];
 };
 .fi
 .sp
diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/setfilecon.3
index 6c2ed3e0..621201e7 100644
--- a/libselinux/man/man3/setfilecon.3
+++ b/libselinux/man/man3/setfilecon.3
@@ -65,4 +65,4 @@ The errors documented for the
 system call are also applicable here.
 .
 .SH "SEE ALSO"
-.BR selinux "(3), " freecon "(3), " getfilecon "(3), " setfscreatecon "(3)"
+.BR selinux "(8), " freecon "(3), " getfilecon "(3), " setfscreatecon "(3)"
diff --git a/libselinux/man/man5/selabel_db.5 b/libselinux/man/man5/selabel_db.5
index 9e92b29b..76c2834e 100644
--- a/libselinux/man/man5/selabel_db.5
+++ b/libselinux/man/man5/selabel_db.5
@@ -28,7 +28,7 @@ The DB contexts backend maps from a pair of object name and class into security
 .sp
 The \fIobject_name\fR should be a fully qualified name using the hierarchy of database objects. For example, the \fBpg_class\fR table in the \fBpostgres\fR database and \fBpg_catalog\fR schema should be qualified as:
 .RS
-.B Bpostgres.pg_catalog.pg_class
+.B postgres.pg_catalog.pg_class
 .RE
 .sp
 The \fBNOTES\fR section has further information on database support for namespace hierarchies.
@@ -59,7 +59,7 @@ argument specifies the name of a column object, such as "postgres.public.my_tabl
 .B SELABEL_DB_TUPLE
 The
 .I object_name
-argument specifies the name of a table object which contains the tuples to be relabeled, such as "postgresql.public.my_table". Note that we have no way to identify individual tuple objects, except for WHERE clause on DML statements, because it has no name.
+argument specifies the name of a table object which contains the tuples to be relabeled, such as "postgres.public.my_table". Note that we have no way to identify individual tuple objects, except for WHERE clause on DML statements, because it has no name.
 .TP
 .B SELABEL_DB_PROCEDURE
 The
@@ -121,7 +121,7 @@ The database context file used to retrieve a context depends on the \fBSELABEL_O
 .sp
 The default database object contexts file is:
 .RS
-.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/sepgsql_context
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/sepgsql_contexts
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
index 976cb930..188be883 100644
--- a/libselinux/man/man5/selabel_file.5
+++ b/libselinux/man/man5/selabel_file.5
@@ -185,10 +185,6 @@ Each line within the substitution files (\fI.subs\fR and \fI.subs_dist\fR) has t
 .sp
 Where:
 .RS
-.I pathname
-.RS
-A path that matches an entry in one or more of the file contexts policy configuration file.
-.RE
 .I subs_pathname
 .RS
 The path that will be aliased (considered equivalent) with pathname by the look up process.
@@ -200,13 +196,17 @@ the matched component, so an entry such as \fI/var/lib/extensions/*\fR
 remaps the contents of each named directory but not the directory itself
 or a sibling regular file.
 .RE
+.I pathname
+.RS
+A path that matches an entry in one or more of the file contexts policy configuration files.
+.RE
 .RE
 .sp
 Example:
 .RS
 # ./contexts/files/file_contexts.subs
 .br
-# pathname	subs_pathname
+# subs_pathname  pathname
 .br
 /myweb			/var/www
 .br
diff --git a/libselinux/man/man8/booleans.8 b/libselinux/man/man8/booleans.8
index d4ca9c44..2a4dd600 100644
--- a/libselinux/man/man8/booleans.8
+++ b/libselinux/man/man8/booleans.8
@@ -25,11 +25,8 @@ to make the setting persistent across reboots.  The
 tool provides a graphical interface for altering
 the settings.  The
 .BR load_policy (8)
-program will preserve
-current boolean settings upon a policy reload by default, or can
-optionally reset booleans to the boot-time defaults via the
-.B \-b
-option.
+program preserves the
+current boolean settings across a policy reload.
 
 Boolean values can be listed by using the
 .BR getsebool (8)
diff --git a/libselinux/man/man8/selinuxexeccon.8 b/libselinux/man/man8/selinuxexeccon.8
index 194740d9..d0e440cc 100644
--- a/libselinux/man/man8/selinuxexeccon.8
+++ b/libselinux/man/man8/selinuxexeccon.8
@@ -24,4 +24,4 @@ system_u:system_r:system_mail_t:s0
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 .
 .SH "SEE ALSO"
-.BR secon (8)
+.BR secon (1)
-- 
2.55.0

