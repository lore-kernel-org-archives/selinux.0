Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923AA2DECA1
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348344; cv=none; b=i02F8KiLnJQCOrQH768cZx5uAZxbnGhl0YwVidy6gIfyEHrNr/n2jYHMJiO8TgA1K9a6lPhZ1oahfatTcWP/TISvQEaGoIDZbctpkrSVd11JUThjkMFmMed01fqEN0dlF3nCWN/3LhD3+RwUkyqKuuA6cmMtB2DX/2mNqUojtbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348344; c=relaxed/simple;
	bh=24/jF37MC/A5SvcklZVJRzacL94bvJGBYaIqVcu4C8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoVN15zeoOFkuAg4VhCwmWvmnvdxM2N2Ue1grLUqwaZXAsUkjgtdwJGNqyicgPHXbFeSBqWrCZtlQro6K+uy4gJk2t4Y6EU+I3/A8vVQhCpc14rBOekqhGxGF5XSFbYZeKFgTAze1Rabi5Ti/uyVdwL2wXDTxO+CBnIa2yVSnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3RJTpEr; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3RJTpEr"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51a868b6962so34106911cf.2
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348341; x=1783953141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ua03WyH0CM+IFX+69tYQqx4IDA8Xtl2FFWtwzU6ZRUg=;
        b=g3RJTpErbviBvcsjerQVCVSzZVluc1xNjhgrZs9x1tk2dZCW+JaRUTEmqKLBhVFvmi
         Z8PTzbm9M7lHOXUWOrc7aJJNnuOeIu9CmTRvMyizQOzHh2g/NW2hK20Q7MTQBS7zQI+H
         71+kx5mOdQHa+kR+zlC8qmwGwJO6QYDNciCb5uCP8/mjLL8eokbhtuANd41Kiz7uoH3C
         WON2tW/nzcfc0DNGi0uwjfxEPPBegNzzPJ2puNBVCT7ZTofrUYRmRZA3UEjlH17jxZFx
         fvo9R44PNi7injcUdrKjTuHz5lJNPRmn6E+t+AFtMLwxUYTT8f4NjLwnZA7NcWJ3wxk6
         D72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348341; x=1783953141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ua03WyH0CM+IFX+69tYQqx4IDA8Xtl2FFWtwzU6ZRUg=;
        b=I50EAmBsI5Kbnh2HanTpLAjyWDIpSFznmtGZGwv/GspzL5OnHkwMS9nv6+FLqSrXRM
         ewj259ZIHZ+aLeEbnrVtK1WB4cyGPWyTI+6ycSM84cWJfKZH/rEQ+gYZVRFtFVQdUvhZ
         39xDu49aocFzdKvj1it3dtcyaMmEk6D4jjNPLQJWzroDrgiFwZQDEY9C8LFzFyH2rq3y
         Gdjeb9vsNJJoXgiISvswwD3esWvcSCMzAKshZ0QxUZR0XFGHy+T6Uuprt01FLZZLIYYR
         6kAXBSqY557fAyeMdF4No85T+vkKuvqIzm61d5Wyt7eAQkUQtf0ZurBfjCrhFAO4VlDc
         bP8A==
X-Gm-Message-State: AOJu0YxC4tdbrWZo6H3qie2K2M4GdaeNmCfS91Sp/DdwlHCsMk1bPuvw
	JFquJzdXIYeHUwyzLIBhwnqVAYn26dOtSnjqa094REgKgKdFhzWFSZ7TnZGcJw==
X-Gm-Gg: AfdE7ckv12SeCWmQXFUeUI8pbcJ4DG9WOBakvdaw16zIEOzyadtH7n7UZ099kLONNb4
	rfY2f03nXym0PPOwNKHaMLHrLgDeCtB3KVDiqs1cD6kXgN4tqeKrtcNi/RKBKF018S4W95ItYLW
	/+qggc8fG0ARk86W5a7999GkyX6XtHw/jqlGIYal4RQISRTq3y9B9SiMIwImPWgdGhEw1KSSFTG
	wXhSs0cae0LLTsjzL0ofulwswpd1g1CeWUMHe8cWUXWRK61BmMWyuwfOqcublrgkIwzqdZs8HKP
	LwCK2n1BGp64yU4zQVsH6Ry2+0ocH5O1Zys19dlsbHXkkhQ/8DCa0clbPmZBFtVEe5v2dvW1y8Q
	yPdJ0IZ733RuNNMm6cxfhNJGyFiqWtspQ2c7JcFhN+PwRshqnPpVsYzRXb/oXAVYpNB/XSyZJDH
	QggjzDWf3fGVNlKx7JVfdYGGjBe8MAs0Uspp0o+mOApD4tSbEnK7U/satrGNamkeeZWxWKvgIGN
	RjIC8940StYifAM
X-Received: by 2002:a05:622a:4019:b0:51c:18e4:38ab with SMTP id d75a77b69052e-51c748e0864mr8578961cf.66.1783348340989;
        Mon, 06 Jul 2026 07:32:20 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41ab77e7sm92790761cf.3.2026.07.06.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:32:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 5/5] libselinux: update man pages for new thread safety guarantees
Date: Mon,  6 Jul 2026 10:31:55 -0400
Message-ID: <20260706143155.36629-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
References: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new thread safety guarantees and callback constraints for
the AVC, class/perm string mapping, status page, and access checking
APIs.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/man/man3/avc_add_callback.3        | 12 +++++++-
 libselinux/man/man3/avc_init.3                | 15 ++++++++--
 libselinux/man/man3/avc_netlink_loop.3        | 14 +++++++++
 libselinux/man/man3/avc_open.3                | 20 +++++++++++++
 .../man/man3/security_class_to_string.3       | 10 +++++++
 libselinux/man/man3/security_compute_av.3     | 20 +++++++++++--
 libselinux/man/man3/selinux_set_callback.3    | 29 +++++++++++++++++++
 libselinux/man/man3/selinux_status_open.3     | 22 ++++++++++++--
 8 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/libselinux/man/man3/avc_add_callback.3 b/libselinux/man/man3/avc_add_callback.3
index bdbbadf1..ede2c907 100644
--- a/libselinux/man/man3/avc_add_callback.3
+++ b/libselinux/man/man3/avc_add_callback.3
@@ -177,7 +177,17 @@ may be executed in the context of the netlink handler thread.  This will likely
 
 Support for dynamic revocation and retained permissions is mostly unimplemented in the SELinux kernel module.  The only security event that currently gets exercised is
 .BR AVC_CALLBACK_RESET .
-.
+
+.B AVC_CALLBACK_RESET
+callbacks driven by
+.BR selinux_status_updated (3),
+(the default when no netlink handler thread is installed) run with the
+status lock held and must not call
+.BR selinux_status_updated (3),
+.BR selinux_status_getenforce (3)
+or
+.BR selinux_status_policyload (3).
+
 .SH "AUTHOR"
 Eamon Walsh <ewalsh@tycho.nsa.gov>
 .
diff --git a/libselinux/man/man3/avc_init.3 b/libselinux/man/man3/avc_init.3
index a5dc7c93..9740b0ad 100644
--- a/libselinux/man/man3/avc_init.3
+++ b/libselinux/man/man3/avc_init.3
@@ -153,7 +153,18 @@ The
 .B func_free_lock
 callback should destroy
 .IR lock ,
-freeing any resources associated with it.  The default behavior is not to perform any locking.  Note that undefined behavior may result if threading is used without appropriate locking.
+freeing any resources associated with it.
+If
+.I lock_callbacks
+is NULL (as it always is for
+.BR avc_open (3)),
+the AVC uses an internal
+.BR pthread_mutex_t
+per lock.
+If an
+.B avc_lock_callback
+structure is supplied, all four callbacks must be non-NULL;
+supplying a subset is not supported.
 .
 .SH "KERNEL STATUS PAGE"
 Linux kernel version 2.6.37 supports the SELinux kernel status page, enabling userspace applications to
@@ -195,7 +206,7 @@ events will have the same results as for the status page implementation, but all
 
 By default,
 .BR avc_open (3)
-does not set threading or locking callbacks. In the fallback case, the userspace AVC checks for new netlink messages at the start of each permission query. If threading and locking callbacks are passed to
+does not set threading callbacks. In the fallback case, the userspace AVC checks for new netlink messages at the start of each permission query. If threading callbacks are passed to
 .BR avc_init (),
 a dedicated thread will be started to listen on the netlink socket.  This may increase performance in the absence of the status page and will ensure that log messages are generated immediately rather than at the time of the next permission query.
 .
diff --git a/libselinux/man/man3/avc_netlink_loop.3 b/libselinux/man/man3/avc_netlink_loop.3
index f03d7813..41928be6 100644
--- a/libselinux/man/man3/avc_netlink_loop.3
+++ b/libselinux/man/man3/avc_netlink_loop.3
@@ -83,6 +83,20 @@ with a return value return zero on success.  On error, \-1 is returned and
 .I errno
 is set appropriately.
 .
+.SH "NOTES"
+After
+.BR avc_netlink_acquire_fd (),
+the application owns the netlink socket.
+.BR avc_netlink_check_nb ()
+and
+.BR avc_netlink_loop()
+do not take the status lock that serializes
+.BR selinux_status_updated (3);
+the application is responsible for draining the socket from a single
+thread (or under its own lock), and should not mix direct netlink
+draining with concurrent calls to
+.BR selinux_status_updated (3).
+.
 .SH "AUTHOR"
 Originally KaiGai Kohei. Updated by Mike Palmiotto <mike.palmiotto@crunchydata.com>
 .
diff --git a/libselinux/man/man3/avc_open.3 b/libselinux/man/man3/avc_open.3
index 74f85593..a02d7e0b 100644
--- a/libselinux/man/man3/avc_open.3
+++ b/libselinux/man/man3/avc_open.3
@@ -81,6 +81,26 @@ and
 .B policyload
 events will have the same results as for the status page implementation, but all status update checks will now require a system call.
 .
+.SH "THREAD SAFETY"
+The userspace AVC initialized by
+.BR avc_open (3)
+protects its shared state with internal pthread mutexes by default, so
+.BR avc_has_perm (3),
+.BR avc_context_to_sid (3),
+.BR avc_compute_create (3)
+and
+.BR selinux_check_access (3)
+may be called concurrently from multiple threads after a single
+.BR avc_open (3).
+The
+.B SELINUX_CB_LOG
+and
+.B SELINUX_CB_AUDIT
+callbacks (see
+.BR selinux_set_callback (3))
+are invoked while the audit-buffer lock is held and must not call back
+into the AVC.
+.
 .SH "RETURN VALUE"
 Functions with a return value return zero on success.  On error, \-1 is returned and
 .I errno
diff --git a/libselinux/man/man3/security_class_to_string.3 b/libselinux/man/man3/security_class_to_string.3
index 1b1b88d4..02afa093 100644
--- a/libselinux/man/man3/security_class_to_string.3
+++ b/libselinux/man/man3/security_class_to_string.3
@@ -86,6 +86,16 @@ A class or access vector argument is not recognized by the currently loaded poli
 .B ENOMEM
 An attempt to allocate memory failed.
 .
+.SH "THREAD SAFETY"
+These functions share a process-wide class/permission cache that is
+serialized internally. The string pointers returned by
+.BR security_class_to_string ()
+and
+.BR security_av_perm_to_string ()
+remain valid across concurrent calls to
+.BR selinux_flush_class_cache (3)
+for the lifetime of the process.
+.
 .SH "AUTHOR"
 Eamon Walsh <ewalsh@tycho.nsa.gov>
 .
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index af8797b5..98e53095 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -181,10 +181,24 @@ function.
 .SH "RETURN VALUE"
 Returns zero on success or \-1 on error.
 .
-.SH "CAVEATS"
+.SH "THREAD SAFETY"
 .sp
-These functions are not thread-safe, you have to protect them from
-concurrent calls using exclusive locks when multiple threads are executing.
+.BR selinux_check_access ()
+may be called concurrently from multiple threads; the underlying
+AVC and SELinux status page interfaces serialize their shared
+state internally. See the re-entrancy constraints for
+.B SELINUX_CB_LOG
+/
+.B SELINUX_CB_AUDIT
+/
+.B SELINUX_CB_SETENFORCE
+/
+.B SELINUX_CB_POLICYLOAD
+in
+.BR selinux_set_callback (3).
+.
+The remaining security_compute_* ()
+functions are direct kernel queries with no shared userspace state.
 .
 .SH "SEE ALSO"
 .BR string_to_security_class (3),
diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/man/man3/selinux_set_callback.3
index 75f49b06..9bdc5573 100644
--- a/libselinux/man/man3/selinux_set_callback.3
+++ b/libselinux/man/man3/selinux_set_callback.3
@@ -116,6 +116,35 @@ The
 .I seqno
 argument is the current sequential number of the policy generation in the system.
 .
+.SH "NOTES"
+Callbacks run while a library-internal lock is held and must not call back
+into the interfaces that lock protects:
+.B SELINUX_CB_LOG
+and
+.B SELINUX_CB_AUDIT
+are invoked from
+.BR avc_audit (3)
+with the audit-buffer lock held and must not call any function that reaches
+the userspace AVC (e.g.
+.BR avc_has_perm (3),
+.BR selinux_check_access (3));
+.B SELINUX_CB_SETENFORCE
+and
+.B SELINUX_CB_POLICYLOAD
+are invoked from
+.BR selinux_status_updated (3)
+with the status lock held and must not call
+.BR selinux_status_updated (3),
+.BR selinux_status_getenforce (3)
+or
+.BR selinux_status_policyload (3);
+.B SELINUX_CB_VALIDATE
+is invoked from
+.BR selabel_lookup (3)
+with a per-specification lock held and must not call
+.BR selabel_lookup (3)
+on the same handle.
+.
 .SH "RETURN VALUE"
 None.
 .
diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/man3/selinux_status_open.3
index 5592487f..696677ed 100644
--- a/libselinux/man/man3/selinux_status_open.3
+++ b/libselinux/man/man3/selinux_status_open.3
@@ -92,10 +92,26 @@ On error, \-1 shall be returned.
 Any other functions with a return value shall return its characteristic
 value as described above, or \-1 on errors.
 .
-.SH "CAVEATS"
+.SH "THREAD SAFETY"
 .sp
-These functions are not thread-safe, you have to protect them from
-concurrent calls using exclusive locks when multiple threads are executing.
+.BR selinux_status_updated (),
+.BR selinux_status_getenforce ()
+and
+.BR selinux_status_policyload ()
+are serialized internally and may be called concurrently from
+multiple threads. For a given setenforce or policyload event the
+.B SELINUX_CB_SETENFORCE
+/
+.B SELINUX_CB_POLICYLOAD
+callbacks (see
+.BR selinux_set_callback(3))
+and any registered
+.B AVC_CALLBACK_RESET
+callbacks are invoked exactly once.
+.BR selinux_status_open ()
+and
+.BR selinux_status_close ()
+are not serialized against concurrent callers of the other functions.
 .
 .SH "SEE ALSO"
 .ad l
-- 
2.54.0

