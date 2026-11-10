Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310190;
	b=ef4Yyvv4gDd51a1JIooYMWUhTVl85WU5YobOjGF4R1/4B8Cnhr6nKsnC2MRbwkpoNTP1
	 Q3Q3IOV1czU8DuKWvhy4BSfxkHDfxkVIoNOqhL8Mbjpgbp+r2vhvcna8im1i3IGpUGjOg
	 s8lkNyj8J6/3o1plEOkWNXKiS9OXs6iPn7UBCqjOSYHesAWVvNL2ziSIwkzysh+syn63d
	 /DVYrtoPtKAKzKWD6+vcKsiR7zi2udhJLdvwWsHhwlgd5tOk0n5gaHWrcJpUG2moWXUAX
	 yYbBXX+Mq+RBichXJBmI9bGichVfDuHh8dG9HqtMleRAPcNj/8m21c9W5JeTdPZ5StQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310190;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4ytQtbwAhM5JTpFZ/clfIn7JPAVGBH8vroOduCzgrdQ=;
	b=rymlLKEAf32GC5wCmQ9U1Um0+hefThze+V6LkXvrPa3cjO7aaUi/MvjFt9kCeMZGo9mR
	 gdvFniG5yFC/uFTvwxkD8tVPUw4NKVf9GOOGpjd84cJSVicHKxCT3blr7pmv1xHIENwR4
	 dYK3A6ROVOg4pLsBfGtbXwfIJe/3afE+akTGpA80uP9gr8GpQOQ/HA9kj8eLN/GjpaxIh
	 vkyHM0aMKqM5RvQBd1x8tBTzy4SVvvbh3SejYq+8MspaBdM6dlc4BQHYsAcK+5bU3ebUF
	 IKE6UE0kWNmPLYaCwA2HNgsDlkQAkEPAXQ3bYpWnlHnir5jZ4wAL9W3pCpaLppK49jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=eHfHsxsL;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBD606A335
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18BBD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=eHfHsxsL
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794310187;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ytQtbwAhM5JTpFZ/clfIn7JPAVGBH8vroOduCzgrdQ=;
	b=eHfHsxsLxZEcPxAD0ZEvMXNqt8hQsVsi+KiKbQWhyt3HPT3kqMYndUtdTXlgmsMiwqDMqi
	jgeEtsXNDfIlMs226um7O8AYnPMVjQJnNRxWb2b3LaD9sBID9HhpiXsf6DTnF4oIzup5gS
	krnZjsoNRUyq40eqhw9ARACgumSj35xolXCSgJxwLMaOHzR67hfd0ROjLWuEacYSOnNRwu
	ltnwT1mRq9MXmgdKxTudOdzRAgrG2CMP1xyCOzGqnQuGVqy1qSWWvQc/H4baAckOVKcI6F
	h+hl8q2B1IeVC/g4uoWdRni4OyVHP5d/Vf61cz43InSqzkPjhmlCymG2rqddnQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 7/8] libselinux/man: document tool behavior and exit status
Date: Tue, 10 Nov 2026 12:29:29 +0100
Message-ID: <20261110112931.99557-6-cgoettsche@seltendoof.de>
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

Document the transaction, rollback and syslog behavior of togglesebool,
the output format and boolean name substitution of getsebool, the
keyword matching and privilege requirements of setenforce, and the
handling of the fromcon argument of selinuxexeccon.

Add EXIT STATUS sections to getenforce(8), setenforce(8), getsebool(8),
togglesebool(8) and selinuxexeccon(8).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man8/getenforce.8     |  4 ++++
 libselinux/man/man8/getsebool.8      | 19 ++++++++++++++++-
 libselinux/man/man8/selinuxexeccon.8 | 15 ++++++++++++-
 libselinux/man/man8/setenforce.8     | 14 ++++++++++++
 libselinux/man/man8/togglesebool.8   | 32 +++++++++++++++++++++++++++-
 5 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/libselinux/man/man8/getenforce.8 b/libselinux/man/man8/getenforce.8
index 70b9921f..aa0e26d9 100644
--- a/libselinux/man/man8/getenforce.8
+++ b/libselinux/man/man8/getenforce.8
@@ -9,6 +9,10 @@ getenforce \- get the current mode of SELinux
 .B getenforce
 reports whether SELinux is enforcing, permissive, or disabled.
 .
+.SH "EXIT STATUS"
+0 is returned on success, including when SELinux is disabled. 2 is returned if
+the SELinux state could not be determined.
+.
 .SH AUTHOR
 Dan Walsh, <dwalsh@redhat.com>
 .
diff --git a/libselinux/man/man8/getsebool.8 b/libselinux/man/man8/getsebool.8
index 9e36f04f..5a837bae 100644
--- a/libselinux/man/man8/getsebool.8
+++ b/libselinux/man/man8/getsebool.8
@@ -20,12 +20,27 @@ value is changed, then the booleans are committed, causing their
 active values to become their pending values. This allows a group of
 booleans to be changed in a single transaction, by setting all of
 their pending values as desired and then committing once.
+
+For each boolean a line is printed in the form
+"\fIname\fR --> \fIstate\fR", where \fIstate\fR is \fBon\fR or \fBoff\fR. When
+the pending value differs from the active value, it is shown as
+"\fIname\fR --> \fIstate\fR pending: \fIpending_state\fR".
+
+Boolean names are displayed using any substitution configured in the
+.B booleans.subs_dist
+file (see
+.BR selinux_boolean_sub (3)),
+so a displayed name may differ from the one supplied on the command line.
 .
 .SH OPTIONS
 .TP
 .B \-a
 Show all SELinux booleans.
 .
+.SH "EXIT STATUS"
+On success, 0 is returned. A non-zero value is returned on error, for example
+when SELinux is disabled or a requested boolean does not exist.
+.
 .SH EXAMPLE
 .nf
 Show current state of httpd_can_connect_ftp
@@ -38,4 +53,6 @@ The program was written by Tresys Technology.
 .SH "SEE ALSO"
 .BR selinux (8),
 .BR setsebool (8),
-.BR booleans (8)
+.BR booleans (8),
+.BR togglesebool (8),
+.BR selinux_boolean_sub (3)
diff --git a/libselinux/man/man8/selinuxexeccon.8 b/libselinux/man/man8/selinuxexeccon.8
index d0e440cc..29508fca 100644
--- a/libselinux/man/man8/selinuxexeccon.8
+++ b/libselinux/man/man8/selinuxexeccon.8
@@ -9,7 +9,20 @@ selinuxexeccon \- report SELinux context used for this executable
 .
 .SH "DESCRIPTION"
 .B selinuxexeccon
-reports the SELinux process context for the specified command from the specified context or the current context.
+reports the SELinux process context for the specified command from the specified
+context or the current context.
+.sp
+If
+.I fromcon
+is given it must be a valid context, otherwise
+.B selinuxexeccon
+reports an error. When omitted, the current process context is used.
+.
+.SH "EXIT STATUS"
+0 is returned on success. A non-zero value is returned on error, for example an
+invalid number of arguments, an invalid
+.I fromcon
+or a failure to compute the resulting context.
 .
 .SH EXAMPLE
 .nf
diff --git a/libselinux/man/man8/setenforce.8 b/libselinux/man/man8/setenforce.8
index 702041d3..66275e1c 100644
--- a/libselinux/man/man8/setenforce.8
+++ b/libselinux/man/man8/setenforce.8
@@ -18,10 +18,24 @@ Use
 or
 .B 0
 to put SELinux in permissive mode.
+The
+.B Enforcing
+and
+.B Permissive
+keywords are matched case-insensitively.
+.sp
+Changing the enforcing mode requires appropriate privilege (normally root) and
+must be allowed by the policy. If SELinux is disabled,
+.B setenforce
+prints an error and makes no change.
 
 If SELinux is disabled and you want to enable it, or SELinux is enabled and you want to disable it, please see 
 .BR selinux (8).
 .
+.SH "EXIT STATUS"
+0 is returned on success. 1 is returned if SELinux is disabled or the argument
+is invalid, and 2 if changing the enforcing mode failed.
+.
 .SH AUTHOR
 Dan Walsh, <dwalsh@redhat.com>
 .
diff --git a/libselinux/man/man8/togglesebool.8 b/libselinux/man/man8/togglesebool.8
index 8f775ca0..b8dc99ce 100644
--- a/libselinux/man/man8/togglesebool.8
+++ b/libselinux/man/man8/togglesebool.8
@@ -10,7 +10,37 @@ togglesebool \- flip the current value of a SELinux boolean
 .B togglesebool
 flips the current value of a list of booleans. If the value is currently a 1,
 then it will be changed to a 0 and vice versa. Only the "in memory" values are
-changed; the boot-time settings are unaffected. 
+changed; the boot-time settings are unaffected.
+.sp
+The booleans are changed in a single transaction: all of their pending values
+are set and then committed together. If any of the named booleans cannot be
+changed (for example, because it does not exist), no boolean is changed; any
+values already set are rolled back to their active values before
+.B togglesebool
+exits.
+.sp
+The new state of each successfully changed boolean is printed as
+.I active
+or
+.IR inactive ,
+and every change is recorded via
+.BR syslog (3),
+together with the user that requested it.
+.sp
+.B togglesebool
+requires SELinux to be enabled.
+.
+.SH "EXIT STATUS"
+On success, 0 is returned. On error (when SELinux is disabled, no boolean is
+given, a named boolean cannot be read or set, or the commit fails), 1 is
+returned.
+.sp
+If a named boolean cannot be read or set (for example, because it does not
+exist), any pending values already set are rolled back. If the commit itself
+fails, the pending values are not reset: the active values are unchanged, but
+the pending values remain set and are applied by a later successful commit of
+booleans, e.g. by
+.BR setsebool (8).
 .
 .SH AUTHOR
 This man page was written by Steve Grubb <sgrubb@redhat.com>
-- 
2.55.0

