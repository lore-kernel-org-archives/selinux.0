Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E341A92C
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686070; cv=none; b=Gy5GlAzEIzVJoanDZL7rqbX28OfvKbMV728IJZEEJd3D2ULVE8VE1+ihlxKVhL5QY6rfhdrHtXYLe8u3ZjDEU6ONm560kh44lP7SCigQNMHoO7kQnQ+/MlJy7/Dm79djRoQMWgrZXwjdKQuX0J/vzM2Vhc3beNjDSHakFnsBbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686070; c=relaxed/simple;
	bh=BHtSQcYD5Rvc2Yw2557B13iQVIdsUHzNRN5bJOvOc0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WtxAyb9MLVdVX8KhelropTy8V7N8Z8VmCr3c4sIs6FHBMabS5GtRY0i3OSCotTnyDcOUYo0k/2rYYUAYvhsHyRXMYLdEBmaGduuL9qTgTQxSPzeqx98nmH9GB/BT9UDj68+uRLH3Rjp2s5hYZ1cV1hh4PAFoBtD+y6eaDVmG7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uhu8KxIL; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uhu8KxIL"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76ef1d0so35600621cf.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790686066; x=1791290866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9nrdoK0siCEayS8XUe0czt2RAtk4ueTla6MrD3axME=;
        b=Uhu8KxILu3cYpK4DUavGgKLxuCqqUdVls9v9OUgurKi9gWs2EM63FJlZ7zSjdZ7aNb
         XuxDPkMCmWSryIN13bpKqmVTHU79OgAAlWW2NYPv1MdonM5Epc4YoVQeZiHH1t6Z93Ov
         iRe10e+Z6fUiXhtGIwvVqKxMzCnsh7HOt8pd8lAa4v6C6CHn1uOjDvjksXAT/r4o0CX+
         CPtkA+Ot8KxjJJ4YfAcipYQRZHmhtI3BdhfouPpISrBY/JF24IUm3BtdVLKCGZ51U9qI
         28ceyYU2HyfmbFyZCPEJPSBXiKLZP/HlxPHLjRslmwSOfjbUZWsAc2UcZCWsCT42O6Fk
         A3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790686066; x=1791290866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9nrdoK0siCEayS8XUe0czt2RAtk4ueTla6MrD3axME=;
        b=WRbvRzzm0bYzRCT1a0p7iJOQAUWGvddb3aGsJl6XxjZ4zpVihztO6uE/atAMp27+Dp
         qaKyjr3yTiyk/oVu39es2nA2G8ctdvb5oGVYubwxuvlG4V4IPOT1Rohv5HB5BXqeiFmK
         QGLiqpPYUjfWAD1Vd83Svsm6mUrxi6DH++yW79dM5gMXs1L8ZX5UohRwc0HL6hbLrCvk
         tTCOgvcIB73s+OZuFwPEMeYw9JFa7x2gi8CL++PNF2w4ykB9dOywCyljayf+fdYgtJd5
         BIrhw0KL6OVxyZOBXyIjjdc6EZOSUDeUCR9Oxa1vKePoKFJhV4e1SSOpHXWX6MD/jV2e
         I3ZA==
X-Gm-Message-State: AFuF++kLUHwBSKpRXKCQ9FFgLwoeLWkVc6zi8fQFRTA9ssIYguxRUpqK
	X+cjxy79rdI2PUr7euuSR2QGFdMpWWcOFtJ5yhtqcutyc7byOSxeXrTsvFs0mg==
X-Gm-Gg: AYBFou36tF+zQIZAq0W0h3jayyRi9n3RbMvm8HwHsbdTyX9Ba3YDjOpYA7rCndTAvuq
	/3cmC+tuHiZr6mtti3mGMQrOGEcGY+xQsELhcuyHJVuwVXPe79m/c9E5VSEw4aGv+qfB22dwGTj
	rIxUlhX+S6TvUckuaenJM1iCq/6wSV/rMmONbCvgjPPpkeUyyG7sqSVlgsYlgC1WeGn/izb8tJp
	6cPurA67hgJGrhfxvXtmLDlHpZiYs9MooQcMkIdWZerhoCuzSDOaCm7Jx+rK13oPhR6KxSNcyY0
	ZfIo7MZXLSlbW50caRVGcrzKoloMj4sS9gvPhNohGKeksDDzbHY0Ki3xp4EcxJ5xLVEHhDwMSGu
	ZLqmskquane/UFFNfdFjDHNa+YzOJCapQcn1qAQrOWonaiSmSvNGX4NekhD+y6uDavOyfNpz8fD
	2M8OclVC4dhyMCjaxDRPqXqDKGqIvk0pnFmqXqldQMKl7kNN88P6PY3ah3QAHK3+ucrpsWgVe4H
	Sb8P9S74OKgfaU+tbfg65TZZzNmgAEbX/3uqB5pPYviJZlhtx+2unag7F7FK9uvCxU6n7u92ZE=
X-Received: by 2002:a05:620a:2954:b0:939:c71d:8d15 with SMTP id af79cd13be357-93c43bba616mr2551750785a.14.1790686065607;
        Tue, 29 Sep 2026 05:47:45 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d303583sm9490866d6.14.2026.09.29.05.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:47:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] userspace: update man pages for /usr/lib fallbacks
Date: Tue, 29 Sep 2026 08:47:30 -0400
Message-ID: <20260929124730.87841-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update all of the userspace man pages to note the /usr/lib fallbacks
for the configuration files.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/checkpolicy.8                     |  3 ++
 .../man/man3/get_ordered_context_list.3       |  4 +-
 libselinux/man/man3/is_context_customizable.3 | 11 ++++-
 libselinux/man/man3/matchmediacon.3           |  2 +-
 .../man/man3/selinux_binary_policy_path.3     |  2 +-
 libselinux/man/man3/selinux_boolean_sub.3     |  2 +-
 libselinux/man/man3/selinux_getenforcemode.3  |  2 +-
 libselinux/man/man3/selinux_getpolicytype.3   |  2 +-
 libselinux/man/man3/selinux_policy_root.3     |  4 +-
 libselinux/man/man5/customizable_types.5      |  2 +-
 libselinux/man/man5/default_contexts.5        |  2 +-
 libselinux/man/man5/default_type.5            |  2 +-
 libselinux/man/man5/failsafe_context.5        |  2 +-
 libselinux/man/man5/removable_context.5       |  2 +-
 libselinux/man/man5/securetty_types.5         |  2 +-
 libselinux/man/man5/selabel_db.5              |  2 +-
 libselinux/man/man5/selabel_file.5            | 10 ++---
 libselinux/man/man5/selabel_media.5           |  2 +-
 libselinux/man/man5/selabel_x.5               |  2 +-
 libselinux/man/man5/service_seusers.5         |  2 +-
 libselinux/man/man5/seusers.5                 |  2 +-
 libselinux/man/man5/user_contexts.5           |  6 +--
 libselinux/man/man5/virtual_domain_context.5  |  2 +-
 libselinux/man/man5/virtual_image_context.5   |  2 +-
 libselinux/man/man8/selinux.8                 | 19 +++++---
 mcstrans/man/man5/setrans.conf.5              | 16 +++++--
 mcstrans/man/man8/mcs.8                       | 12 +++++-
 mcstrans/man/man8/mcstransd.8                 | 15 +++++--
 policycoreutils/man/man5/selinux_config.5     | 11 ++++-
 policycoreutils/newrole/newrole.1             | 43 ++++++++++++++-----
 policycoreutils/run_init/run_init.8           | 23 +++++++---
 policycoreutils/semodule/genhomedircon.8      |  9 ++--
 policycoreutils/sestatus/sestatus.8           |  5 +++
 policycoreutils/setfiles/restorecon.8         |  4 +-
 policycoreutils/setfiles/setfiles.8           |  3 ++
 python/chcat/chcat.8                          | 19 +++++++-
 restorecond/restorecond.8                     | 28 ++++++++++--
 37 files changed, 205 insertions(+), 76 deletions(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index caaaf675..46aea1b6 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -73,15 +73,18 @@ Show version information.
 Show usage information.
 
 .SH EXAMPLE
+The read paths may be under /usr/lib on stateless systems.
 .nf
 Generate policy.conf based on the system policy
 # checkpolicy -b -M -F /etc/selinux/targeted/policy/policy.33 -o policy.conf
+# checkpolicy -b -M -F /usr/lib/selinux/targeted/policy/policy.33 -o policy.conf
 Recompile system policy so that unknown permissions are denied (uses policy.conf from ^^).
 Note that binary policy extension represents its version, which is subject to change
 # checkpolicy -M -U deny -o /etc/selinux/targeted/policy/policy.33 policy.conf
 # load_policy
 Generate CIL representation of current system policy
 # checkpolicy -b -M -C /etc/selinux/targeted/policy/policy.33 -o policy.out
+# checkpolicy -b -M -C /usr/lib/selinux/targeted/policy/policy.33 -o policy.out
 
 .SH "SEE ALSO"
 SELinux Reference Policy documentation at https://github.com/SELinuxProject/refpolicy/wiki
diff --git a/libselinux/man/man3/get_ordered_context_list.3 b/libselinux/man/man3/get_ordered_context_list.3
index 2a1e08f0..f9daaddb 100644
--- a/libselinux/man/man3/get_ordered_context_list.3
+++ b/libselinux/man/man3/get_ordered_context_list.3
@@ -48,9 +48,9 @@ SELinux
 identity that are reachable from the specified
 .I fromcon
 context based on the global
-.I \%/etc/selinux/{SELINUXTYPE}/contexts/default_contexts
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/default_contexts
 file and the per-user
-.I \%/etc/selinux/{SELINUXTYPE}/contexts/users/<username>
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/users/<username>
 file if it exists.  The 
 .I fromcon
 parameter may be NULL to indicate that the current context should
diff --git a/libselinux/man/man3/is_context_customizable.3 b/libselinux/man/man3/is_context_customizable.3
index ca332dc4..3c04f377 100644
--- a/libselinux/man/man3/is_context_customizable.3
+++ b/libselinux/man/man3/is_context_customizable.3
@@ -9,7 +9,7 @@ is_context_customizable \- check whether SELinux context type is customizable by
 .
 .SH "DESCRIPTION"
 This function checks whether the type of scon is in the
-.I /etc/selinux/{SELINUXTYPE}/context/customizable_types
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/customizable_types
 file.  A customizable type is a file context type that
 administrators set on files, usually to allow certain domains to share the file content. restorecon and setfiles, by default, leave these context in place.
 .
@@ -18,7 +18,14 @@ Returns 1 if security context is customizable or 0 if it is not.
 Returns \-1 on error.
 .
 .SH "FILE"
-.I /etc/selinux/{SELINUXTYPE}/context/customizable_types
+.TP
+.I /etc/selinux/{SELINUXTYPE}/contexts/customizable_types
+.TP
+.I /usr/lib/selinux/{SELINUXTYPE}/contexts/customizable_types
+The list of customizable types for file contexts. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
 .
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff --git a/libselinux/man/man3/matchmediacon.3 b/libselinux/man/man3/matchmediacon.3
index 187e1c14..d76ed8b0 100644
--- a/libselinux/man/man3/matchmediacon.3
+++ b/libselinux/man/man3/matchmediacon.3
@@ -24,7 +24,7 @@ using
 Returns 0 on success or \-1 otherwise.
 .
 .SH Files
-.I /etc/selinux/{POLICYTYPE}/contexts/files/media
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/files/media
 .
 .SH "SEE ALSO"
 .BR selinux "(8), " freecon "(3)
diff --git a/libselinux/man/man3/selinux_binary_policy_path.3 b/libselinux/man/man3/selinux_binary_policy_path.3
index 01538688..4c2bb45e 100644
--- a/libselinux/man/man3/selinux_binary_policy_path.3
+++ b/libselinux/man/man3/selinux_binary_policy_path.3
@@ -44,7 +44,7 @@ directories and files
 .SH "DESCRIPTION"
 These functions return the paths to the active policy configuration
 directories and files based on the settings in
-.IR /etc/selinux/config .
+.IR {/etc,/usr/lib}/selinux/config .
 .sp
 .BR selinux_path ()
 returns the top-level SELinux configuration directory.
diff --git a/libselinux/man/man3/selinux_boolean_sub.3 b/libselinux/man/man3/selinux_boolean_sub.3
index a29a38d5..95cb5807 100644
--- a/libselinux/man/man3/selinux_boolean_sub.3
+++ b/libselinux/man/man3/selinux_boolean_sub.3
@@ -10,7 +10,7 @@ selinux_boolean_sub \- Search the translated name for a boolean_name record
 .SH "DESCRIPTION"
 .BR selinux_boolean_sub ()
 searches the
-.I \%/etc/selinux/{POLICYTYPE}/booleans.subs_dist
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/booleans.subs_dist
 file
 for a matching boolean_name record.  If the record exists the boolean substitution name is returned.  If not
 .BR \%selinux_boolean_sub ()
diff --git a/libselinux/man/man3/selinux_getenforcemode.3 b/libselinux/man/man3/selinux_getenforcemode.3
index 7ed94c11..4242a506 100644
--- a/libselinux/man/man3/selinux_getenforcemode.3
+++ b/libselinux/man/man3/selinux_getenforcemode.3
@@ -10,7 +10,7 @@ selinux_getenforcemode \- get the enforcing state of SELinux
 .SH "DESCRIPTION"
 .BR selinux_getenforcemode ()
 Reads the contents of the
-.I /etc/selinux/config
+.I {/etc,/usr/lib}/selinux/config
 file to determine how the system was setup to run SELinux.
 
 Sets the value of
diff --git a/libselinux/man/man3/selinux_getpolicytype.3 b/libselinux/man/man3/selinux_getpolicytype.3
index b219d421..bb499e3e 100644
--- a/libselinux/man/man3/selinux_getpolicytype.3
+++ b/libselinux/man/man3/selinux_getpolicytype.3
@@ -10,7 +10,7 @@ selinux_getpolicytype \- get the type of SELinux policy running on the system
 .SH "DESCRIPTION"
 .BR selinux_getpolicytype ()
 Reads the contents of the
-.I /etc/selinux/config
+.I {/etc,/usr/lib}/selinux/config
 file to determine the SELinux policy used on the system, and sets
 .I \%policytype
 accordingly. Free
diff --git a/libselinux/man/man3/selinux_policy_root.3 b/libselinux/man/man3/selinux_policy_root.3
index 75ac8ec0..e4f9b794 100644
--- a/libselinux/man/man3/selinux_policy_root.3
+++ b/libselinux/man/man3/selinux_policy_root.3
@@ -14,13 +14,13 @@ selinux_set_policy_root \- Set an alternate SELinux root path for the SELinux po
 .SH "DESCRIPTION"
 .BR selinux_policy_root ()
 reads the contents of the
-.I /etc/selinux/config
+.I {/etc,/usr/lib}/selinux/config
 file to determine which policy files should be used for this machine.
 .
 .BR selinux_set_policy_root ()
 sets up all policy paths based on the alternate root
 
-.I /etc/selinux/config
+.I {/etc,/usr/lib}/selinux/config
 file to determine which policy files should be used for this machine.
 .
 .SH "RETURN VALUE"
diff --git a/libselinux/man/man5/customizable_types.5 b/libselinux/man/man5/customizable_types.5
index 4924f7bd..145cd1ab 100644
--- a/libselinux/man/man5/customizable_types.5
+++ b/libselinux/man/man5/customizable_types.5
@@ -18,7 +18,7 @@ will use this information to obtain a list of types relating to files that shoul
 .BR selinux_customizable_types_path (3)
 will return the active policy path to this file. The default customizable types file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/customizable_types
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/customizable_types
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/default_contexts.5 b/libselinux/man/man5/default_contexts.5
index f63d24a0..b18331b7 100644
--- a/libselinux/man/man5/default_contexts.5
+++ b/libselinux/man/man5/default_contexts.5
@@ -27,7 +27,7 @@ SELinux-aware login applications generally use one or more of the following libs
 .sp
 The default context configuration file path for the active policy is returned by \fBselinux_default_contexts_path\fR(3). The default, default contexts file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/default_contexts
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/default_contexts
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/default_type.5 b/libselinux/man/man5/default_type.5
index 082a5f01..97e8fb3e 100644
--- a/libselinux/man/man5/default_type.5
+++ b/libselinux/man/man5/default_type.5
@@ -7,7 +7,7 @@ The \fIdefault_type\fR file contains entries that allow SELinux-aware applicatio
 .sp
 \fBselinux_default_type_path\fR(3) will return the active policy path to this file. The default, default type file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/default_type
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/default_type
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/failsafe_context.5 b/libselinux/man/man5/failsafe_context.5
index e7032e5f..6382fcb3 100644
--- a/libselinux/man/man5/failsafe_context.5
+++ b/libselinux/man/man5/failsafe_context.5
@@ -12,7 +12,7 @@ to obtain a known valid login context for an administrator if no valid default e
 .BR selinux_failsafe_context_path "(3) "
 will return the active policy path to this file. The default failsafe context file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/failsafe_context
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/failsafe_context
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/removable_context.5 b/libselinux/man/man5/removable_context.5
index f16e8bdc..f7966636 100644
--- a/libselinux/man/man5/removable_context.5
+++ b/libselinux/man/man5/removable_context.5
@@ -8,7 +8,7 @@ This file contains the default label that should be used for removable devices.
 .BR selinux_removable_context_path "(3) "
 will return the active policy path to this file. The default removable context file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/removable_context
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/removable_context
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/securetty_types.5 b/libselinux/man/man5/securetty_types.5
index dbc5c2ea..ac33a725 100644
--- a/libselinux/man/man5/securetty_types.5
+++ b/libselinux/man/man5/securetty_types.5
@@ -10,7 +10,7 @@ file contains a list of types associated to secure tty type that are defined in
 .BR selinux_securetty_types_path "(3) "
 will return the active policy path to this file. The default securetty types file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/securetty_types
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/securetty_types
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/selabel_db.5 b/libselinux/man/man5/selabel_db.5
index 76eb9bc6..9e92b29b 100644
--- a/libselinux/man/man5/selabel_db.5
+++ b/libselinux/man/man5/selabel_db.5
@@ -121,7 +121,7 @@ The database context file used to retrieve a context depends on the \fBSELABEL_O
 .sp
 The default database object contexts file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/sepgsql_context
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/sepgsql_context
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
index 041197d5..a2f61342 100644
--- a/libselinux/man/man5/selabel_file.5
+++ b/libselinux/man/man5/selabel_file.5
@@ -93,15 +93,15 @@ The optional local and distribution substitution files that perform any path ali
 .sp
 The default file context series of files are:
 .RS 6
-.I /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/files/file_contexts
 .br
-.I  /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.local
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/files/file_contexts.local
 .br
-.I  /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.homedirs
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/files/file_contexts.homedirs
 .br
-.I  /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.subs
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/files/file_contexts.subs
 .br
-.I  /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.subs_dist
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/files/file_contexts.subs_dist
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/selabel_media.5 b/libselinux/man/man5/selabel_media.5
index b7c28e32..82a3dadd 100644
--- a/libselinux/man/man5/selabel_media.5
+++ b/libselinux/man/man5/selabel_media.5
@@ -48,7 +48,7 @@ The media context file used to retrieve a default context depends on the \fBSELA
 .sp
 The default media contexts file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/files/media
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/files/media
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/selabel_x.5 b/libselinux/man/man5/selabel_x.5
index 198a3e19..58e2128e 100644
--- a/libselinux/man/man5/selabel_x.5
+++ b/libselinux/man/man5/selabel_x.5
@@ -87,7 +87,7 @@ The X context file used to retrieve a default context depends on the \fBSELABEL_
 .sp
 The default X object contexts file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/x_contexts
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/x_contexts
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/service_seusers.5 b/libselinux/man/man5/service_seusers.5
index 385a3262..ae60e1f6 100644
--- a/libselinux/man/man5/service_seusers.5
+++ b/libselinux/man/man5/service_seusers.5
@@ -13,7 +13,7 @@ The path for each configuration file is formed by the path returned by
 .IR /logins/username
 appended (where \fIusername\fR is a file representing the GNU/Linux user name). The default services directory is located at:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/logins
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/logins
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/seusers.5 b/libselinux/man/man5/seusers.5
index 25125600..7fb341ca 100644
--- a/libselinux/man/man5/seusers.5
+++ b/libselinux/man/man5/seusers.5
@@ -10,7 +10,7 @@ file contains a list GNU/Linux user to SELinux user mapping for use by SELinux-a
 .BR selinux_usersconf_path "(3) "
 will return the active policy path to this file. The default SELinux users mapping file is located at:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/seusers
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/seusers
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/user_contexts.5 b/libselinux/man/man5/user_contexts.5
index fc53d6cf..3c6c5526 100644
--- a/libselinux/man/man5/user_contexts.5
+++ b/libselinux/man/man5/user_contexts.5
@@ -30,9 +30,9 @@ There can be one file for each SELinux user configured on the system. The file
 .BR \%selinux_user_contexts_path (3)
 for the active policy, with the SELinux user name appended, for example:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/users/unconfined_u
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/users/unconfined_u
 .br
-.I /etc/selinux/{SELINUXTYPE}/contexts/users/xguest_u
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/users/xguest_u
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
@@ -60,7 +60,7 @@ This consists of a \fIrole\fB:\fItype\fR[\fB:\fIrange\fR] entry that represents
 .RE
 .
 .SH "EXAMPLE"
-# Example for xguest_u at /etc/selinux/targeted/contexts/users/xguest_u
+# Example for xguest_u at {/etc,/usr/lib}/selinux/targeted/contexts/users/xguest_u
 .br
 system_r:crond_t:s0			xguest_r:xguest_t:s0
 .br
diff --git a/libselinux/man/man5/virtual_domain_context.5 b/libselinux/man/man5/virtual_domain_context.5
index a76fe145..f363480e 100644
--- a/libselinux/man/man5/virtual_domain_context.5
+++ b/libselinux/man/man5/virtual_domain_context.5
@@ -10,7 +10,7 @@ file contains a list of domain contexts that are available for use by the SELinu
 .BR selinux_virtual_domain_context_path "(3) "
 will return the active policy path to this file. The default virtual domain context file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/virtual_domain_context
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/virtual_domain_context
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man5/virtual_image_context.5 b/libselinux/man/man5/virtual_image_context.5
index df1c0e90..25e62337 100644
--- a/libselinux/man/man5/virtual_image_context.5
+++ b/libselinux/man/man5/virtual_image_context.5
@@ -10,7 +10,7 @@ file contains a list of image contexts for use by the SELinux-aware virtualizati
 .BR selinux_virtual_image_context_path "(3) "
 will return the active policy path to this file. The default virtual image context file is:
 .RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/virtual_image_context
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/virtual_image_context
 .RE
 .sp
 Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index 9c466d57..733d9d82 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -13,7 +13,7 @@ information and technical documentation about SELinux can be found at
 https://github.com/SELinuxProject.
 
 The
-.I /etc/selinux/config
+.I {/etc,/usr/lib}/selinux/config
 configuration file controls whether SELinux is
 enabled or disabled, and if enabled, whether SELinux operates in
 permissive mode or enforcing mode.  The
@@ -36,7 +36,7 @@ privileged mode of operation if denied access.
 Disabling SELinux by setting
 .B SELINUX=disabled
 in
-.I /etc/selinux/config
+.I {/etc,/usr/lib}/selinux/config
 is deprecated and depending on kernel version and configuration it might
 not lead to SELinux being completely disabled.  Specifically, the
 SELinux hooks will still be executed internally, but the SELinux policy
@@ -47,11 +47,11 @@ recommended to use the
 .B selinux=0
 kernel boot option instead.  In that case SELinux will be disabled
 regardless of what is set in the
-.I /etc/selinux/config
+.I {/etc,/usr/lib}/selinux/config
 file.
 
 The
-.I /etc/selinux/config
+.I {/etc,/usr/lib}/selinux/config
 configuration file also controls what policy
 is active on the system.  SELinux allows for multiple policies to be
 installed on the system, but only one policy may be active at any
@@ -69,11 +69,11 @@ You can
 define which policy you will run by setting the
 .B SELINUXTYPE
 environment variable within
-.IR /etc/selinux/config .
+.IR {/etc,/usr/lib}/selinux/config .
 You must reboot and possibly relabel if you change the policy type to have it take effect on the system.
 The corresponding
 policy configuration for each such policy must be installed in the
-.I /etc/selinux/{SELINUXTYPE}/
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/
 directories.
 
 A given SELinux policy can be customized further based on a set of
@@ -106,7 +106,14 @@ is used in the policy to allow this, which in turn needs also policy capability
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 .
 .SH FILES
+.TP
 .I /etc/selinux/config
+.TP
+.I /usr/lib/selinux/config
+The SELinux configuration file. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
 .
 .SH "SEE ALSO"
 .ad l
diff --git a/mcstrans/man/man5/setrans.conf.5 b/mcstrans/man/man5/setrans.conf.5
index 4949a502..f63ffd0c 100644
--- a/mcstrans/man/man5/setrans.conf.5
+++ b/mcstrans/man/man5/setrans.conf.5
@@ -4,7 +4,7 @@ setrans.conf \- translation configuration file for MCS/MLS SELinux systems
 
 .SH "DESCRIPTION"
 The
-.I /etc/selinux/{SELINUXTYPE}/setrans.conf
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/setrans.conf
 configuration file specifies the way that SELinux MCS/MLS labels are translated into human
 readable form by the mcstransd daemon.  The default policies support 16 sensitivity levels (s0 through s15) and 1024 categories (c0 through c1023). Multiple categories can be separated with commas (c0,c1,c3,c5) and a range of categories can be shortened using dot notation (c0.c3,c5).
 
@@ -101,6 +101,14 @@ if category bits 5 and 9 are set and the sensitivity level is s1, the constraint
 selinux(8), mcs(8), mls(8), chcon(1)
 
 .SH "FILES"
-/etc/selinux/{SELINUXTYPE}/setrans.conf
-.br
-/usr/share/mcstrans/examples
+.TP
+.I /etc/selinux/{SELINUXTYPE}/setrans.conf
+.TP
+.I /usr/lib/selinux/{SELINUXTYPE}/setrans.conf
+The SELinux context translation configuration file.  The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
+.TP
+.I /usr/share/mcstrans/examples
+Other examples of SELinux context translation configurations.
diff --git a/mcstrans/man/man8/mcs.8 b/mcstrans/man/man8/mcs.8
index aeaf22ef..c76a46fe 100644
--- a/mcstrans/man/man8/mcs.8
+++ b/mcstrans/man/man8/mcs.8
@@ -15,7 +15,8 @@ infrastructure.  They just differ in their specific configuration.
 
 
 The
-.I /etc/selinux/{SELINUXTYPE}/setrans.conf configuration file translates the labels on disk to human
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/setrans.conf
+configuration file translates the labels on disk to human
 readable form.   Administrators can define any labels they want in this file.
 Certain applications like printing and auditing will use these labels to 
 identify the files.  By setting a category on a file you will prevent 
@@ -27,4 +28,11 @@ Examples of file labels would be PatientRecord, CompanyConfidential etc.
 selinux(8), chcon(1)
 
 .SH FILES
-/etc/selinux/{SELINUXTYPE}/setrans.conf 
+.TP
+.I /etc/selinux/{SELINUXTYPE}/setrans.conf
+.TP
+.I /usr/lib/selinux/{SELINUXTYPE}/setrans.conf
+The SELinux context translation configuration file. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
diff --git a/mcstrans/man/man8/mcstransd.8 b/mcstrans/man/man8/mcstransd.8
index 9a5922ba..8d255a6e 100644
--- a/mcstrans/man/man8/mcstransd.8
+++ b/mcstrans/man/man8/mcstransd.8
@@ -11,7 +11,10 @@ This manual page describes the
 .BR mcstransd
 program.
 .P
-This daemon reads /etc/selinux/{SELINUXTYPE}/setrans.conf configuration file, and communicates with libselinux via a socket in /var/run/setrans.
+This daemon reads the
+.I {/etc,/usr/lib}/selinux/{SELINUXTYPE}/setrans.conf
+configuration file, and communicates with libselinux via a socket in
+.IR /var/run/setrans .
 .SH "OPTIONS"
 .TP
 \-f
@@ -26,7 +29,13 @@ The program was originally written by Dan Walsh <dwalsh@redhat.com>.
 The program was enhanced/rewritten by Joe Nall <joe@nall.com>.
 
 .SH "FILES"
-/etc/selinux/{SELINUXTYPE}/setrans.conf 
-
+.TP
+.I /etc/selinux/{SELINUXTYPE}/setrans.conf
+.TP
+.I /usr/lib/selinux/{SELINUXTYPE}/setrans.conf
+The SELinux context translation configuration file. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
 .SH "SEE ALSO"
 .BR setrans.conf (5), mcs (8)
diff --git a/policycoreutils/man/man5/selinux_config.5 b/policycoreutils/man/man5/selinux_config.5
index f391befb..5a5e7f0a 100644
--- a/policycoreutils/man/man5/selinux_config.5
+++ b/policycoreutils/man/man5/selinux_config.5
@@ -18,7 +18,8 @@ Whether the system is to be relabeled or not.
 
 The entries controlling these functions are described in the \fBFILE FORMAT\fR section.
 .sp
-The fully qualified path name of the SELinux configuration file is \fI/etc/selinux/config\fR.
+The fully qualified path name of the SELinux configuration file is
+.I {/etc,/usr/lib}/selinux/config
 .sp
 If the \fIconfig\fR file is missing or corrupt, then no SELinux policy is loaded (i.e. SELinux is disabled).
 .sp
@@ -80,7 +81,13 @@ The actual binary policy is located relative to this directory and also has a po
 The binary policy name has by convention the SELinux policy version that it supports appended to it. The maximum policy version supported by the kernel can be determined using the \fBsestatus\fR(8) command or \fBsecurity_policyvers\fR(3). An example binary policy file with the version is:
 .br
 .RS
-.I /etc/selinux/targeted/policy/policy.24
+.I /etc/selinux/targeted/policy/policy.35
+Note that this file and any other policy file might instead be found
+under
+.I /usr/lib/selinux
+if the vendor ships policy files there; in that case, those files can
+still be overridden by creating a file under
+.IR /etc/selinux .
 .RE
 .RE
 .sp
diff --git a/policycoreutils/newrole/newrole.1 b/policycoreutils/newrole/newrole.1
index 544274d7..05eaab31 100644
--- a/policycoreutils/newrole/newrole.1
+++ b/policycoreutils/newrole/newrole.1
@@ -54,7 +54,9 @@ In particular, an argument of \-\- \-c will cause the next argument to be
 treated as a command by most command interpreters.
 .PP
 If a command argument is specified to newrole and the command name is found
-in /etc/selinux/newrole_pam.conf, then the pam service name listed in that
+in
+.IR {/etc,/usr/lib}/selinux/newrole_pam.conf ,
+then the pam service name listed in that
 file for the command will be used rather than the normal newrole pam
 configuration.  This allows for per-command pam configuration when
 invoked via newrole, e.g. to skip the interactive re-authentication phase.
@@ -99,15 +101,36 @@ Running a program in a given role or level:
    # newrole \-l Secret \-\- \-c "/path/to/app arg1 arg2..."
 
 .SH FILES
-/etc/passwd - user account information
-.br
-/etc/shadow - encrypted passwords and age information
-.br
-/etc/selinux/<policy>/contexts/default_type - default types for roles
-.br
-/etc/selinux/<policy>/contexts/securetty_types - securetty types for level changes
-.br
-/etc/selinux/newrole_pam.conf - optional mapping of commands to separate pam service names
+.TP
+.I /etc/passwd
+User account information
+.TP
+.I /etc/shadow
+Encrypted passwords and age information
+.TP
+.I /etc/selinux/{SELINUXTYPE}/contexts/default_type
+.TP
+.I /usr/lib/selinux/{SELINUXTYPE}/contexts/default_type
+Default types for roles. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
+.TP
+.I /etc/selinux/{SELINUXTYPE}/contexts/securetty_types
+.TP
+.I /usr/lib/selinux/{SELINUXTYPE}/contexts/securetty_types
+Contains securetty types authorized for level changes. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
+.TP
+.I /etc/selinux/newrole_pam.conf
+.TP
+.I /usr/lib/selinux/newrole_pam.conf
+Optional mapping of commands to separate pam service names. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
 .br
 .SH SEE ALSO
 .BR runcon (1)
diff --git a/policycoreutils/run_init/run_init.8 b/policycoreutils/run_init/run_init.8
index d7ff45d0..f4eb2665 100644
--- a/policycoreutils/run_init/run_init.8
+++ b/policycoreutils/run_init/run_init.8
@@ -7,18 +7,27 @@ run_init \- run an init script in the proper SELinux context
 .br
 .SH DESCRIPTION
 .PP
-Run a init script under the proper context, which is specified in 
-/etc/selinux/POLICYTYPE/contexts/initrc_context.
+Run a init script under the proper context, which is specified in
+.IR {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/initrc_context .
 It is generally used interactively as it requires either shadow or
 PAM user authentication (depending on compile-time options).  It
 should be possible to configure PAM such that interactive input is
 not required.  Check your PAM documentation.
 .SH FILES
-/etc/passwd - user account information
-.br
-/etc/shadow - encrypted passwords and age information
-.br
-/etc/selinux/POLICYTYPE/contexts/initrc_context - contains the context to run init scripts under
+.TP
+.I /etc/passwd
+User account information
+.TP
+.I /etc/shadow
+Encrypted passwords and age information
+.TP
+.I /etc/selinux/{SELINUXTYPE}/contexts/initrc_context
+.TP
+.I /usr/lib/selinux/{SELINUXTYPE}/contexts/initrc_context
+Contains the context to run init scripts under. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
 .SH SEE ALSO
 .BR newrole (1),
 .BR runcon (1)
diff --git a/policycoreutils/semodule/genhomedircon.8 b/policycoreutils/semodule/genhomedircon.8
index ecab7ba3..0d7cdfa1 100644
--- a/policycoreutils/semodule/genhomedircon.8
+++ b/policycoreutils/semodule/genhomedircon.8
@@ -9,15 +9,18 @@ to rebuild the currently active SELinux policy (without reloading it) and to cre
 labels for each user home directory based on directory paths returned by calls to getpwent().
 
 The latter functionality depends on the "usepasswd" parameter being set to "true" (default)
-in /etc/selinux/semanage.conf.
+in
+.IR {/etc,/usr/lib}/selinux/semanage.conf .
 
 This script is usually executed by
 .B semanage
 although this default behavior can be optionally modified by setting to "true" the
-"disable-genhomedircon" in /etc/selinux/semanage.conf.
+"disable-genhomedircon" in
+.IR {/etc,/usr/lib}/selinux/semanage.conf .
 
 Directories can be excluded from the list of home directories by the setting "ignoredirs"
-in /etc/selinux/semanage.conf.
+in
+.IR {/etc,/usr/lib}/selinux/semanage.conf .
 
 .SH AUTHOR
 This manual page was written by
diff --git a/policycoreutils/sestatus/sestatus.8 b/policycoreutils/sestatus/sestatus.8
index a89c53fd..d183eea1 100644
--- a/policycoreutils/sestatus/sestatus.8
+++ b/policycoreutils/sestatus/sestatus.8
@@ -67,7 +67,12 @@ Display the current state of booleans.
 .RE
 
 .SH "FILES"
+.TP
 .I /etc/sestatus.conf
+The sestatus configuration file. The file in
+.B /etc
+overrides any default configuration provided by the vendor in
+the configured vendor directory (VENDORDIR at build time).
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>.
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 001039b7..3a8b8ee0 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -71,7 +71,9 @@ options will force a replacement of the entire context.
 If a file is labeled with
 .BR customizable
 SELinux type (for list of customizable
-types see /etc/selinux/{SELINUXTYPE}/contexts/customizable_types), restorecon
+types see
+.IR {/etc,/usr/lib}/selinux/{SELINUXTYPE}/contexts/customizable_types ),
+restorecon
 won't reset the label unless the \-F option is used.
 .P
 It is the same executable as
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 101556a9..88f4ecef 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -343,11 +343,14 @@ with exit status
 .SH EXAMPLE
 .nf
 Fix labeling of /var/www/ including all sub-directories, using targeted policy file context definitions and list all context changes
+# setfiles -v /usr/lib/selinux/targeted/contexts/files/file_contexts /var/www/
 # setfiles -v /etc/selinux/targeted/contexts/files/file_contexts /var/www/
 List mislabeled files in user home directory and what the label should be based on targeted policy file context definitions
+# setfiles -nv /usr/lib/selinux/targeted/contexts/files/file_contexts ~
 # setfiles -nv /etc/selinux/targeted/contexts/files/file_contexts ~
 Fix labeling of files listed in file_list file, ignoring any that do not exist
 # setfiles -vif file_list /etc/selinux/targeted/contexts/files/file_contexts
+# setfiles -vif file_list /usr/lib/selinux/targeted/contexts/files/file_contexts
 
 .SH "AUTHOR"
 This man page was written by Russell Coker <russell@coker.com.au>.
diff --git a/python/chcat/chcat.8 b/python/chcat/chcat.8
index 3e1f7ca2..44ad5253 100644
--- a/python/chcat/chcat.8
+++ b/python/chcat/chcat.8
@@ -59,6 +59,21 @@ chcon(1), selinux(8), semanage(8)
 .br
 When operating on files this script wraps the chcon command.
 .SH "FILES"
-/etc/selinux/{SELINUXTYPE}/setrans.conf 
-.br
+.TP
+.I /etc/selinux/{SELINUXTYPE}/setrans.conf
+.TP
+.I /usr/lib/selinux/{SELINUXTYPE}/setrans.conf
+The SELinux context translation configuration file. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
+.TP
+.I
 /etc/selinux/{SELINUXTYPE}/seusers
+.TP
+.I
+/usr/lib/selinux/{SELINUXTYPE}/seusers
+The SELinux users configuration. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
diff --git a/restorecond/restorecond.8 b/restorecond/restorecond.8
index bb99b24a..82b114f7 100644
--- a/restorecond/restorecond.8
+++ b/restorecond/restorecond.8
@@ -11,7 +11,11 @@ This manual page describes the
 .BR restorecond
 program.
 .P
-This daemon uses inotify to watch files listed in the /etc/selinux/restorecond.conf, when they are created, this daemon will make sure they have 
+This daemon uses inotify to watch files listed in the
+.I {/etc,/usr/lib}/selinux/restorecond.conf
+file.
+
+When any of the listed files are created, this daemon will make sure they have
 the correct file context associated with the policy.
 
 .SH "OPTIONS"
@@ -30,7 +34,9 @@ Use alternative restorecond.conf file.
 Run in foreground, do not become a daemon.
 .TP
 .B \-u
-Turns on user mode.  Runs restorecond in the user session and reads /etc/selinux/restorecond_user.conf.  Uses dbus to make sure only one restorecond is running per user session.
+Turns on user mode.  Runs restorecond in the user session and reads the
+.I {/etc,/usr/lib}/selinux/restorecond_user.conf
+file. Uses dbus to make sure only one restorecond is running per user session.
 .TP
 .B \-v
 Turns on verbose debugging.  (Report missing files)
@@ -39,8 +45,22 @@ Turns on verbose debugging.  (Report missing files)
 This man page and program was written by Dan Walsh <dwalsh@redhat.com>.
 
 .SH "FILES"
-/etc/selinux/restorecond.conf
-/etc/selinux/restorecond_user.conf
+.TP
+.I /etc/selinux/restorecond.conf
+.TP
+.I /usr/lib/selinux/restorecond.conf
+The restorecond root daemon configuration file. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
+.TP
+.I /etc/selinux/restorecond_user.conf
+.TP
+.I /usr/lib/selinux/restorecond_user.conf
+The restorecond user session configuration file. The file in
+.B /etc
+overrides the default configuration provided by the vendor in
+.BR /usr/lib .
 
 .SH "SEE ALSO"
 .BR restorecon (8),
-- 
2.55.0

