Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D63B7A8
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627695; cv=none; b=ObC1sqPCfYbxZFpr4D4910KS2Ydrh17lzbqn4OfbBrPSdLrgUXQClZ7ITLaeJqaZpxha8J+88qxv4M2N1I5rq+4hg+WHUPi2TU6vTn2mIGsBKUXT3x+9u89pgGziQvvJfc7t17g6fF+eis8NrEu+CkeI9jNggsVgIvymlWVGBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627695; c=relaxed/simple;
	bh=RgXWMQ4i+UipZYNj6hNBW+Zewd1tlNG33jcWZhe6dZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWvbzRDxLJV4Scg18HmclaJMmPVEBlzRynIAyM/vweTgbEX/klNhtM6TBG/neMOzGNMW18hHG+o9W1jPAYQgeGqJRtH6L9Y/YqEwfBbAl7h3NuIyeakNMShuMsh0y0l3q+ayNu31aO0vB8t65xA9cDAr01wUWHRiVEptgwe44EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHKRrolm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHKRrolm"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c149c5722so2169231cf.0
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2026 13:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783627693; x=1784232493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+cG3cj+bfWWhAvMnEqPWMcYxLzvS+WnZje0CtbP2Nq4=;
        b=gHKRrolmZWC//8R5BlVrAPNehjailgh76tZnFWZOHFuzmSBmJ1ISu8Cu5KnN9eu+cC
         6S61UNE5gpcAb0y6yahMaDS58zEtn5PbuPAEJ4t4kJ/+3RB5Bk2/Z+OTAzojsgJTXXOX
         xBs6rR1KFmJy5T8FmjlDTqcAjgv8A+sui45HaewH7J+vvy11vMhp0gF7mAjYW33RBZyL
         pyKXf5/yHHgfxYycr+bVoSSPmcnTWSJgeV3SqxsEDxHZz8m39fypxbHSneu6sdsJm+ET
         XNUEzb3Ecz2ISsy8k+ESQ0My6OHYFzg/AUQz1v44w5fFqXV+EsukkZOabxyGL2nFsQQ1
         wmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783627693; x=1784232493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+cG3cj+bfWWhAvMnEqPWMcYxLzvS+WnZje0CtbP2Nq4=;
        b=oEAScTowvAkX853rvhjLOu9M7tQMIle19ayh3fudNGm6P2WdJqrOa4nXfHpMduSpcX
         MkIxf25Bz6UpX79YDvnG2+f/7aZfhpiZY2roOXuuBKGeUXla+JYm8c+mZHRcTRMIuGK4
         7EK0G4hb1HBXH+QtfF32HPLOngbBPLAUhzB0xWtLlUC89f63VNc9X/0EFa2PGjAzZun9
         JmbhLkD0aNIPFX7P4OSzeNS/Le0bPkgLfXkZAqqmUObXfTcU+xqtX/lDRlvcNWqgcQ2V
         dUaIukj+/S0BS1/oiH6KJ/ruOs6G/u7FOdQ84HVwekmcANN1L+b7cym7HOhN0r/aNWG7
         aaCQ==
X-Gm-Message-State: AOJu0Ywvjjp/V/z0GdLMRC1YUmxXUXR+nBoFfte/Mel4p/XwmXFeqDm0
	tqgtCjFWy9smz2djJinQZO8XBCjz1PvNmFL1I8+dW4rSMJQzOr2/eDhlO69y3Q==
X-Gm-Gg: AfdE7cnKEo4H6wyjcLcaItrOVzuDgDWS6FKOleMxYpncN08hEnyY2og2LewE4UdwC/p
	xaQpA7ovUs9GYbOhIOEepv8ldPRpM36Nu/YeV4MXqfXOOB6ObC2+83quh7wLBcwAly6e4gOEHIu
	9he6RCajFbClIBOvHgixbPUA8zSgP80Scrpe+AuAKSNw8DYsv43GauST6naVVKdAAHvHTAqKZe7
	Iv9MpFjI9LzGsTOOJnK1iDurk0LCsJvvxY5v1LEZoW8ptndaFUXzlCBtvScrLkmoYCsGz+sjZzR
	mZ8uWFDE50j9kCzbZx64MKZooU/rdZBOqOiqiAe1TVJcuiOSDag7koyn0QdEsJZy2mKz7VKBLrN
	+EtVmlJeqrlvPwkoRBG6WmDQkKD1j7zzKMkVFQm9WXjliS11JKUrCMLx8wETqx35H7VmRpsCQ3R
	iaFIvUxrNoFTwf0yPyzpSCrAzzKA0n1yIHPOJYRVwFgEbdn6gdIC+a+n6SsdWuM21vfDAghO3gV
	yguMNUp2K20yBWm
X-Received: by 2002:a05:622a:1e91:b0:51c:7aa7:e0eb with SMTP id d75a77b69052e-51caa4ddfecmr8102831cf.40.1783627693193;
        Thu, 09 Jul 2026 13:08:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae20a40sm2287841cf.15.2026.07.09.13.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:08:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] policycoreutils/setfiles: introduce -j for skip_multilink
Date: Thu,  9 Jul 2026 16:07:56 -0400
Message-ID: <20260709200756.2172-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new -j option to setfiles and restorecon to enable the
recently introduced SELINUX_RESTORECON_SKIP_MULTILINK flag to
selinux_restorecon(3) to detect files with multiple hard links and
skip them when relabeling to avoid unintended mislabeling of such
files. This option is recommended when relabeling user-writable
directory trees.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/setfiles/restore.c    | 2 +-
 policycoreutils/setfiles/restore.h    | 1 +
 policycoreutils/setfiles/restorecon.8 | 6 ++++++
 policycoreutils/setfiles/setfiles.8   | 5 +++++
 policycoreutils/setfiles/setfiles.c   | 8 ++++++--
 5 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 1e3644f5..edce44b5 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -42,7 +42,7 @@ void restore_init(struct restore_opts *opts)
 		opts->xdev | opts->abort_on_error | opts->syslog_changes |
 		opts->log_matches | opts->ignore_noent | opts->ignore_mounts |
 		opts->mass_relabel | opts->conflict_error | opts->count_errors |
-		opts->count_relabeled;
+		opts->count_relabeled | opts->skip_multilink;
 
 	/* Use setfiles, restorecon and restorecond own handles */
 	selinux_restorecon_set_sehandle(opts->hnd);
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index 36f73059..bf3979f1 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -38,6 +38,7 @@ struct restore_opts {
 	unsigned int conflict_error;
 	unsigned int count_errors;
 	unsigned int count_relabeled;
+	unsigned int skip_multilink;
 	/* restorecon_flags holds | of above for restore_init() */
 	unsigned int restorecon_flags;
 	char *rootpath;
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index b7ff9715..982701c2 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -10,6 +10,7 @@ restorecon \- restore file(s) default SELinux security contexts.
 .RB [ \-p ]
 .RB [ \-v ]
 .RB [ \-i ]
+.RB [ \-j ]
 .RB [ \-F ]
 .RB [ \-U ]
 .RB [ \-W ]
@@ -30,6 +31,7 @@ restorecon \- restore file(s) default SELinux security contexts.
 .RB [ \-p ]
 .RB [ \-v ]
 .RB [ \-i ]
+.RB [ \-j ]
 .RB [ \-F ]
 .RB [ \-U ]
 .RB [ \-W ]
@@ -88,6 +90,10 @@ contains a list of files to be processed. Use
 for
 .BR stdin .
 .TP
+.B \-j
+skip files with multiple hard links to avoid unintentional mislabeling,
+particularly when relabeling user-writable directories.
+.TP
 .B \-F
 Force reset of context to match file_context for customizable files, and the
 default file context, changing the user, role, range portion as well as the type.
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index d43e4ad2..d55b42db 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -8,6 +8,7 @@ setfiles \- set SELinux file security contexts.
 .IR policy ]
 .RB [ \-C ]
 .RB [ \-d ]
+.RB [ \-j ]
 .RB [ \-l ]
 .RB [ \-m ]
 .RB [ \-n ]
@@ -117,6 +118,10 @@ enable usage of the
 .IR security.sehash
 extended attribute.
 .TP
+.B \-j
+skip files with multiple hard links to avoid unintentional mislabeling,
+particularly when relabeling user-writable directories.
+.TP
 .B \-l
 log changes in file labels to syslog.
 .TP
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 2d38ea8f..567d519f 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -145,8 +145,8 @@ int main(int argc, char **argv)
 	size_t buf_len, nthreads = 1;
 	const char *base;
 	int errors = 0;
-	const char *ropts = "ce:f:hiIDlmno:pqrsvFURW0xT:";
-	const char *sopts = "c:de:f:hiIDlmno:pqr:svACEFUR:W0T:";
+	const char *ropts = "ce:f:hijIDlmno:pqrsvFURW0xT:";
+	const char *sopts = "c:de:f:hijIDlmno:pqr:svACEFUR:W0T:";
 	const char *opts;
 	union selinux_callback cb;
 	long unsigned skipped_errors;
@@ -276,6 +276,10 @@ int main(int argc, char **argv)
 		case 'i':
 			r_opts.ignore_noent = SELINUX_RESTORECON_IGNORE_NOENTRY;
 			break;
+		case 'j':
+			r_opts.skip_multilink =
+				SELINUX_RESTORECON_SKIP_MULTILINK;
+			break;
 		case 'I': /* Force label check by ignoring directory digest. */
 			r_opts.ignore_digest = SELINUX_RESTORECON_IGNORE_DIGEST;
 			request_digest = 1;
-- 
2.55.0

