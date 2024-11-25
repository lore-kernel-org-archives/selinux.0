Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5D1990CE
	for <selinux@vger.kernel.org>; Mon, 25 Nov 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533531; cv=none; b=PfLhONRT4a11IVHkcU1a5AOCalVup0nN36sYsJsuUBC7OFFm9NxSuADVJwLDYCQTNTbpcZB1JbpFgVWAQ+dvuOIVjaQqM7BKCkcXU74FgLWn5PQsMZB/9ZTpJSH05uX9ELHVxGWmwTS3jlauhGE+Y8ZoNZN4Zqci7QmQ39eNZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533531; c=relaxed/simple;
	bh=CBICRA3m+l8pwJk1yVAGvMQgxVQSgNkoOutadCnNSw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUi4wqfH0k+DB1PXgWnSJBcXBC1NN7rZNbVgGDs6sLoGDUF6zW79DDstohjZ6jBmIvXrm0hAJUhjgWVB8Zrz8z8ErVYiVQi3ecMmP+TsXigrLxDq7xzJ6JkHrl6xbQw02ZVOHczcWCDAigvLO9BOZk9yrOrvHROc1cQMOtvrwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=SJkJyXrw; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="SJkJyXrw"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732533526;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2CeE+Dw0DNxNGWi7bvPJ4DaRD93fdA/Svgjm6kizRY=;
	b=SJkJyXrwhNO5yzWilwlWASVRSjkaEGy6iOLj6w+LYxxackE7CFF9/kXj9ysZtMnM48/Q9+
	TIvYCaNwhnDumRlPZHtTe7zT9r2NyFhQwLT1FE+6GMBniYpWsuVHfoesTq24p/EBOv+8jN
	krunVL4gCh/GOPY+hzSddJUThTHgHYQh/QJz1q2HhYPyw8qyzob52VPW1E0qqzDqcEH0do
	04UuJxD0mxQhN0rdzJu2z70HvHxZ26sgRqTBoZm3z3KgmAYX1byhVwWNPBVnN8UhR3FnkD
	+bwRKKV0rzPwONOPIWzrD2DIMGDvWvLv92GJhmMElG4N0J2X/oAe+V/dnZbaRA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 8/9] libsemanage/man: add documentation for command overrides
Date: Mon, 25 Nov 2024 12:18:39 +0100
Message-ID: <20241125111840.63845-8-cgoettsche@seltendoof.de>
In-Reply-To: <20241125111840.63845-1-cgoettsche@seltendoof.de>
References: <20241125111840.63845-1-cgoettsche@seltendoof.de>
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

For example fedora contains the following cdefault configuration:

    [sefcontext_compile]
    path = /usr/sbin/sefcontext_compile
    args = -r $@
    [end]

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/man/man5/semanage.conf.5 | 79 ++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 6a1afc13..b22e65bd 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -131,6 +131,85 @@ It can be set to either "true" or "false" and by default it is set to "true".
 When set to "true", duplicate type, type attribute, and role declarations will be allowed.
 It can be set to either "true" or "false" and by default it is set to "true".
 
+.RE
+.PP
+For certain tasks the SELinux Management library resorts to running
+external commands.  For the following commands their path and arguments can
+be overridden:
+
+.RS
+.RS
+.TP
+.B load_policy
+Command to load a kernel policy.
+Requires no argument.
+Defaults to
+.IR /sbin/load_policy
+with no arguments.
+
+.TP
+.B setfiles
+Command to verify file context definitions.
+Requires two arguments, the path to the kernel policy and the path to the
+file context definition file.
+Defaults to
+.IR /sbin/setfiles
+with the arguments '\-q \-c $@ $<'.
+
+.TP
+.B sefcontext_compile
+Command to compile a file context definition file.
+Requires one argument, the path to the to be compiled file context
+definition file.
+Defaults to
+.IR /sbin/sefcontext_compile
+with the argument '$@'.
+
+.RE
+.PP
+Either
+.IR path
+or
+.IR args
+can be omitted.
+The argument string must contain '$@' for the first required argument,
+and '$<' for the second one.
+The syntax for overriding an external command property is:
+
+.RS
+
+[\fIname\fR]
+.sp 0
+path = /path/to/command
+.sp 0
+args = --flag
+.sp 0
+[end]
+
+.RE
+
+.TP
+Example
+
+.RS
+
+[sefcontext_compile]
+.sp 0
+path = /usr/sbin/sefcontext_compile
+.sp 0
+args = -r $@
+.sp 0
+[end]
+
+.RE
+.PP
+Optionally the SELinux Management library can invoke external commands to
+verify source modules (\fBverify module\fR), linked modules
+(\fBverify linked\fR), and kernel policies (\fBverify kernel\fR).
+The syntax is identical to the above command overrides.
+The program should exit with a value of 0 on success, and non zero on
+failure.
+
 .SH "SEE ALSO"
 .TP
 semanage(8)
-- 
2.45.2

