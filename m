Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49AADDCD
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408298; cv=none; b=bxNFLGRkHAHbcPlB7oVZ0fQBk9WqzDvYoB22DY+Tyt0QUZ4SPatMZ/5w8qQ/B5JBHTpVyS78BrpoiIutGv6Jh1frSXsH3UvqfhGtay0T/xbY7m1Jp3l0LM2Cn+3lhF4wEwe34KR53vpT7VX4R1QZ3OavMmTywC05tRTGtf2la2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408298; c=relaxed/simple;
	bh=rTal/q4ghqT7cebwWpOAqJ89DKx379P1Kr54bzwuoX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LO7Zz53sJafXOnpDmh4PqCZsEh+bH3CdMgn1R4ZHQHSki1KGjDSihQyAZ0Hh3VEORA4khCUOJqYR2qj0YnAWrMh5NaMymmAHMHBfPHOrsWLdFX8Ald4PrI3C/KvVEAuj1XRfouKZHFWN4+IqWytrO9NkADAhGLbQ19HAH9YAW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=iAQE/iUD; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="iAQE/iUD"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1714408287;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1HUhJK5Bwccwd+BmaVdJnm6u8u0waWo9On4SQkcM30=;
	b=iAQE/iUDOyde2lsnUKyUmP/syy45oQ6feeCmWEpfcGjm00qja8E08uUwfTSamroTV7njTK
	yEnyI1exHGZx5PlvKLQAC8inZ5az+N5I4fQ7lz5yk+vJpkRCLKV1zewSF9y2zi3RpV554t
	3v1FIZEaLS2C1NxXAdF3tqR5ZpLfvUhPMaIyYBQ/xDrjSwx9AOWHXT+7YZoxP0p4S0gsNR
	GijPNpBJ+w67/LeLnebE7EHXXOIs+rIV8xe/ZL324ATQIyAJ/iGvQNYoMXZKK/TTZHng7R
	EBE43MIlMT+KxQ/KmWmUWzhIWFiIQx8mhvsMwwHwN8JAQIwWV713/xwSqVKOGA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/5] libselinux/man: sync const qualifiers
Date: Mon, 29 Apr 2024 18:31:18 +0200
Message-ID: <20240429163122.63181-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240429163122.63181-1-cgoettsche@seltendoof.de>
References: <20240429163122.63181-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Sync the const qualifiers of parameters with the actual implementation.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/avc_context_to_sid.3           | 2 +-
 libselinux/man/man3/getfscreatecon.3               | 4 ++--
 libselinux/man/man3/getkeycreatecon.3              | 4 ++--
 libselinux/man/man3/getsockcreatecon.3             | 4 ++--
 libselinux/man/man3/init_selinuxmnt.3              | 2 +-
 libselinux/man/man3/is_context_customizable.3      | 2 +-
 libselinux/man/man3/selinux_raw_context_to_color.3 | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libselinux/man/man3/avc_context_to_sid.3 b/libselinux/man/man3/avc_context_to_sid.3
index 5532d6c5..4586b999 100644
--- a/libselinux/man/man3/avc_context_to_sid.3
+++ b/libselinux/man/man3/avc_context_to_sid.3
@@ -10,7 +10,7 @@ avc_context_to_sid, avc_sid_to_context, avc_get_initial_sid \- obtain and manipu
 .br
 .B #include <selinux/avc.h>
 .sp
-.BI "int avc_context_to_sid(char *" ctx ", security_id_t *" sid ");"
+.BI "int avc_context_to_sid(const char *" ctx ", security_id_t *" sid ");"
 .sp
 .BI "int avc_sid_to_context(security_id_t " sid ", char **" ctx ");"
 .sp
diff --git a/libselinux/man/man3/getfscreatecon.3 b/libselinux/man/man3/getfscreatecon.3
index c6faadc1..47ec30f4 100644
--- a/libselinux/man/man3/getfscreatecon.3
+++ b/libselinux/man/man3/getfscreatecon.3
@@ -9,9 +9,9 @@ getfscreatecon, setfscreatecon \- get or set the SELinux security context used f
 .sp
 .BI "int getfscreatecon_raw(char **" con );
 .sp
-.BI "int setfscreatecon(char *" context );
+.BI "int setfscreatecon(const char *" context );
 .sp
-.BI "int setfscreatecon_raw(char *" context );
+.BI "int setfscreatecon_raw(const char *" context );
 .
 .SH "DESCRIPTION"
 .BR getfscreatecon ()
diff --git a/libselinux/man/man3/getkeycreatecon.3 b/libselinux/man/man3/getkeycreatecon.3
index 7887b9b8..0ef27be7 100644
--- a/libselinux/man/man3/getkeycreatecon.3
+++ b/libselinux/man/man3/getkeycreatecon.3
@@ -9,9 +9,9 @@ getkeycreatecon, setkeycreatecon \- get or set the SELinux security context used
 .sp
 .BI "int getkeycreatecon_raw(char **" con );
 .sp
-.BI "int setkeycreatecon(char *" context );
+.BI "int setkeycreatecon(const char *" context );
 .sp
-.BI "int setkeycreatecon_raw(char *" context );
+.BI "int setkeycreatecon_raw(const char *" context );
 .
 .SH "DESCRIPTION"
 .BR getkeycreatecon ()
diff --git a/libselinux/man/man3/getsockcreatecon.3 b/libselinux/man/man3/getsockcreatecon.3
index 9223f60f..9795fb65 100644
--- a/libselinux/man/man3/getsockcreatecon.3
+++ b/libselinux/man/man3/getsockcreatecon.3
@@ -9,9 +9,9 @@ getsockcreatecon, setsockcreatecon \- get or set the SELinux security context us
 .sp
 .BI "int getsockcreatecon_raw(char **" con );
 .sp
-.BI "int setsockcreatecon(char *" context );
+.BI "int setsockcreatecon(const char *" context );
 .sp
-.BI "int setsockcreatecon_raw(char *" context );
+.BI "int setsockcreatecon_raw(const char *" context );
 .
 .SH "DESCRIPTION"
 .BR getsockcreatecon ()
diff --git a/libselinux/man/man3/init_selinuxmnt.3 b/libselinux/man/man3/init_selinuxmnt.3
index 8466f9ff..6c83698a 100644
--- a/libselinux/man/man3/init_selinuxmnt.3
+++ b/libselinux/man/man3/init_selinuxmnt.3
@@ -7,7 +7,7 @@ init_selinuxmnt \- initialize the global variable selinux_mnt
 .sp
 .BI "static void fini_selinuxmnt(void);"
 .sp
-.BI "void set_selinuxmnt(char *" mnt ");"
+.BI "void set_selinuxmnt(const char *" mnt ");"
 .
 .SH "DESCRIPTION"
 .BR init_selinuxmnt ()
diff --git a/libselinux/man/man3/is_context_customizable.3 b/libselinux/man/man3/is_context_customizable.3
index c858a026..ca332dc4 100644
--- a/libselinux/man/man3/is_context_customizable.3
+++ b/libselinux/man/man3/is_context_customizable.3
@@ -5,7 +5,7 @@ is_context_customizable \- check whether SELinux context type is customizable by
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int is_context_customizable(char *" scon );
+.BI "int is_context_customizable(const char *" scon );
 .
 .SH "DESCRIPTION"
 This function checks whether the type of scon is in the
diff --git a/libselinux/man/man3/selinux_raw_context_to_color.3 b/libselinux/man/man3/selinux_raw_context_to_color.3
index cfd564df..fb657f81 100644
--- a/libselinux/man/man3/selinux_raw_context_to_color.3
+++ b/libselinux/man/man3/selinux_raw_context_to_color.3
@@ -5,7 +5,7 @@ selinux_raw_context_to_color \- Return RGB color string for an SELinux security
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int selinux_raw_context_to_color(char *" raw ", "
+.BI "int selinux_raw_context_to_color(const char *" raw ", "
 .RS
 .BI "char **" color_str ");"
 .RE
-- 
2.43.0

