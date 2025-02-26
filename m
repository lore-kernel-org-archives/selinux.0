Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6736258CE4
	for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560498; cv=none; b=GPv1rqktqIDP4hiOiRUJzBfS0WBaNtCg1cLSJSP/6OAAWEY1gO+9Q8X/7yLqkjCayxDjtN4FAStLfSCCrUdqHdbV/xRjRTc0iUp0BUKP+3fzsMWDMPFs+24XcPNfIyrnbvYWR6kh++EJGCcpr+YymcG6hHItpBHN96NitTzt40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560498; c=relaxed/simple;
	bh=ITtJ1uKLI3tV5XvGYIOC/glqVM5vK0MQMgsUX4vc3Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FxBLmHPH8efI+SKFqWp352z5XDosRJa9GZA+1PysJUP1MydfT0VGCWGGnaRXYFV19QNGySlgLGocEhVUUSVW8A7QfBgRvWIDjXyGLKIfr0hiBTG/9YaFR4LBzD/RqG8drUXAzASAZucdUGhkNDyDpVTgNZA39C0DbIG3WovdbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=VmfX+3i+; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="VmfX+3i+"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740560491;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=19MxxPIC+2LXrxB1N0PZwNtRaMMjiuXfByMQRCiU1vc=;
	b=VmfX+3i+BSJuLJXnVr/XRCxA/RhB4csHFkSsNKsudshBI7RiEsSjPXNhP5VcNLFGb45wfO
	pJDrMvu5BYBKEOFP3lymtq/BQ639uOlfZVWriwZcCT6XAysvuo6S999c3rMQdLqsUveZFo
	P2b+7vOftWFB9LgAwvRRAVaUKvFmfnSttTYgIxS9IpWGGDfc85bDDAAh1p1fyQ8rY4ACQY
	gDQ6k8PbGD5I2mNFimUiOoQWjGbBEMKlMDBsB8uDsJ8EGpUhAc0i/1JiP2YZwU1sXjSaI8
	LmCcO0+WtevUrg38goTOt0Ra8QdMld2F3VlQb+I5IWz9ROhM6o5KhT0qZYTYAQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] setfiles: add option to modify user and role portions
Date: Wed, 26 Feb 2025 10:01:26 +0100
Message-ID: <20250226090127.25701-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Useful for data of MCS separated applications, like containers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/setfiles/restore.c    |  1 +
 policycoreutils/setfiles/restore.h    |  1 +
 policycoreutils/setfiles/restorecon.8 | 10 +++++++++-
 policycoreutils/setfiles/setfiles.8   | 11 ++++++++++-
 policycoreutils/setfiles/setfiles.c   | 18 +++++++++++-------
 5 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index d045e948..2c031ccc 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -36,6 +36,7 @@ void restore_init(struct restore_opts *opts)
 	opts->restorecon_flags = 0;
 	opts->restorecon_flags = opts->nochange | opts->verbose |
 			   opts->progress | opts->set_specctx  |
+			   opts->set_user_role |
 			   opts->add_assoc | opts->ignore_digest |
 			   opts->recurse | opts->userealpath |
 			   opts->xdev | opts->abort_on_error |
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index a5af81fe..95afb960 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -24,6 +24,7 @@ struct restore_opts {
 	unsigned int progress;
 	unsigned int mass_relabel;
 	unsigned int set_specctx;
+	unsigned int set_user_role;
 	unsigned int add_assoc;
 	unsigned int ignore_digest;
 	unsigned int recurse;
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index c3cc5c9b..1134420e 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -11,6 +11,7 @@ restorecon \- restore file(s) default SELinux security contexts.
 .RB [ \-v ]
 .RB [ \-i ]
 .RB [ \-F ]
+.RB [ \-U ]
 .RB [ \-W ]
 .RB [ \-I | \-D ]
 .RB [ \-x ]
@@ -30,6 +31,7 @@ restorecon \- restore file(s) default SELinux security contexts.
 .RB [ \-v ]
 .RB [ \-i ]
 .RB [ \-F ]
+.RB [ \-U ]
 .RB [ \-W ]
 .RB [ \-I | \-D ]
 .RB [ \-x ]
@@ -60,7 +62,9 @@ context,
 will only modify the type portion of the security context.
 The
 .B \-F
-option will force a replacement of the entire context.
+and
+.B \-U
+options will force a replacement of the entire context.
 .P
 If a file is labeled with
 .BR customizable
@@ -88,6 +92,10 @@ for
 Force reset of context to match file_context for customizable files, and the
 default file context, changing the user, role, range portion as well as the type.
 .TP
+.B \-U
+In addition to the type portion also change the user and role portions, but
+not the range portion.
+.TP
 .B \-h, \-?
 display usage information and exit.
 .TP
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index ee017250..eabf0a1c 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -19,6 +19,7 @@ setfiles \- set SELinux file security contexts.
 .RB [ \-v ]
 .RB [ \-W ]
 .RB [ \-F ]
+.RB [ \-U ]
 .RB [ \-I | \-D ]
 .RB [ \-T
 .IR nthreads ]
@@ -52,8 +53,12 @@ context,
 .B setfiles
 will only modify the type portion of the security context.
 The
+.B \-U
+option will also modify the user and role portions of the security context.
+The
 .B \-F
-option will force a replacement of the entire context.
+option will force a replacement of the entire context, including the range
+portion of the security context and modify customizable files.
 .SH "OPTIONS"
 .TP
 .B \-c
@@ -88,6 +93,10 @@ Force reset of context to match file_context for customizable files, and the
 default file context, changing the user, role, range portion as well as the
 type.
 .TP
+.B \-U
+In addition to the type portion also change the user and role portions, but
+not the range portion.
+.TP
 .B \-h, \-?
 display usage information and exit.
 .TP
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 88a27241..ad09f840 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -35,14 +35,14 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
-			"usage:  %s [-iIDFmnprRv0xT] [-e excludedir] pathname...\n"
-			"usage:  %s [-iIDFmnprRv0xT] [-e excludedir] -f filename\n",
+			"usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] pathname...\n"
+			"usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] -f filename\n",
 			name, name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-diIDlmnpqvCEFWT] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file pathname...\n"
-			"usage:  %s [-diIDlmnpqvCEFWT] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file -f filename\n"
-			"usage:  %s -s [-diIDlmnpqvFWT] spec_file\n",
+			"usage:  %s [-diIDlmnpqvCEFUWT] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file pathname...\n"
+			"usage:  %s [-diIDlmnpqvCEFUWT] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file -f filename\n"
+			"usage:  %s -s [-diIDlmnpqvFUWT] spec_file\n",
 			name, name, name);
 	}
 	exit(-1);
@@ -146,8 +146,8 @@ int main(int argc, char **argv)
 	size_t buf_len, nthreads = 1;
 	const char *base;
 	int errors = 0;
-	const char *ropts = "e:f:hiIDlmno:pqrsvFRW0xT:";
-	const char *sopts = "c:de:f:hiIDlmno:pqr:svCEFR:W0T:";
+	const char *ropts = "e:f:hiIDlmno:pqrsvFURW0xT:";
+	const char *sopts = "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:";
 	const char *opts;
 	union selinux_callback cb;
 	long unsigned skipped_errors;
@@ -298,6 +298,10 @@ int main(int argc, char **argv)
 			r_opts.set_specctx =
 					   SELINUX_RESTORECON_SET_SPECFILE_CTX;
 			break;
+		case 'U':
+			r_opts.set_user_role =
+					   SELINUX_RESTORECON_SET_USER_ROLE;
+			break;
 		case 'm':
 			r_opts.ignore_mounts =
 					   SELINUX_RESTORECON_IGNORE_MOUNTS;
-- 
2.48.1

