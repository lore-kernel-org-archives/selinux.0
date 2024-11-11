Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66601A0BC1
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334647; cv=none; b=rBWXKAVSpXc9psC46mpTxuD3R2i9bmHrs5AZYA7Jm9Wu3Yd1qzY+ryFuSjVz59jc11MQeDOqFmdHo50DV8Ma/r4YDKoCEvInyk6XTtkO63vQVlAzceZ+1W2tuerMysqY2hQP4CcV2LzJP5OKJz14he+mkDP3TZvVzb9nkU67rww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334647; c=relaxed/simple;
	bh=Qh+jzn1rlZHx8KrTWJrr2EFL44hKYJoctwv32LxQc6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8cSxEqbm7NN3/T+yNYt/vbfEH/jyoYhq6rqpWd8JRlkDKO+WTU4bhxdFQm7ZTX1zXHddkuQpcZYS85IMjS+tUky+dM0JIe0WJjTJuDljrM71RaVBjzX0mYT660WMLkkY4TiRQriqGbvWGItn1GSs9mezV8aCS24qKUOg6JCM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Dk3rL1Wx; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Dk3rL1Wx"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334641;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dz5WPcEybWLeItbioPRD/xbOSwAUAkO2uzjWrJ8shGs=;
	b=Dk3rL1WxK+8z23tLoRwTvUmqPsNw/vfrkic1z28TPpCuBEf+2PO7FCiHhB7f9JpquoDsop
	gdxOzXOPd1DTsIqQjOL6xcpN6m7LOEz5Ue4wO+ChwRl/PPEBcZhFXLlC0hd1yzj2ZsaMio
	8H0THqpqWIXu7hfqSoNT1Cvu4sc0qPR+xjg22Olwn3mUGoYQ4R85pZSRdPmDrVlDAV6kr3
	QS4n1OLchEMp/V2z+2Q43bhqnFClrSvdtbzvQ6ymfEqCeFhQ/M0Q3Q4X/PnWht4zux7Pn2
	qayJjphx34xrGZs0mJg8aLhQWVluF3kiajM8tehsBhbGjr+Gifhl8x+VbwRQrQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 44/47] libsemanage/man: add documentation for command overrides
Date: Mon, 11 Nov 2024 15:17:03 +0100
Message-ID: <20241111141706.38039-44-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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
 libsemanage/man/man5/semanage.conf.5 | 80 ++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 7ac45c96..9f4b0454 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -126,6 +126,86 @@ In order to compile the original HLL file into CIL, the same HLL file will need
 When set to "true", the kernel policy will be optimized upon rebuilds.
 It can be set to either "true" or "false" and by default it is set to "true".
 
+.RE
+
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

