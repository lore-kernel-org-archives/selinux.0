Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657D4E9C02
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611117; cv=none; b=JMoEtQrEofkkg+HWQMthD06F4L0SOm6B9fkK3KC1D5OyXQE8QKPeEuzbRjiWCclm993sOHEudgs8Z9iRj6w7CtFvCmQ/ZnCRnSjZPd9u+ZSJ1caM1RbUBadcrQSxC0r/ryF6RhTu51rozJCv2n6bVeLFnFjmXcig7jt2dlFqPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611117; c=relaxed/simple;
	bh=qA6vOfHL0I/I/5ZWEHw+fs4dP9dWyzbP3UfjG8WblOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhzhzr7SBnpZYqD3felne0dPfNzHjif2Nt7szezJQJiNBvoihU9/SpXoC+D6CctHnlJ5AR1/Da2LEVDNY79Oz/F9s/SSN364ecUOxgcExYm1VS9+R1r3hrAPEjwvrLO59J++aiCUiUIgv7MLNWrRSuJIqG4wKCdSKG3AkSgEu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Mq1OTQwI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Mq1OTQwI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611104;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcVjSRl9GYFxlfe95V7XHywO6a4riTm2u8JjojWknu0=;
	b=Mq1OTQwI/OPspxBmnuiqXVM7fVh2x0D2DlJpAxHAAmJeO4zXzeoALCv3V+fAOJXE0QZS7O
	nB38pZXx96IipX23ab7P29irHRS403caRGkb1nUPhTX8wRXwoPtHjgY4xRgdDYbfbrTAwx
	Wo2wj3AreLbpjWHs3g3VVtYJYeB9+X87OH9ZtJ9LhHatGTqStQr6zhgE6/9Y/Vzyjgxo/u
	PxX5Kywsb829M3of3pVI4p4Yx52eBelrM/r9lQw0aH3Oz9FJYzNqvYFYCFl5ApH7WwPc2q
	qgtA7ZfMaCqsl4I6+wyO67JIMbYKWvqPcM6LCSnc7sL5HBugihunNk0/N32GsA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 17/21] tests/inet_socket: skip mptcp if not supported
Date: Mon, 28 Sep 2026 17:57:48 +0200
Message-ID: <20260928155753.2259807-16-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
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

tests/Makefile only checks the kernel version before running the MPTCP
tests.  On a kernel built without CONFIG_MPTCP, the server fails to create
its socket and exits before opening the flag FIFO, while server_start()
blocks forever in open(2) on the FIFO, hanging the whole testsuite:

  perl inet_socket/mptcp/test
    wait_for_partner
    fifo_open
    do_dentry_open
    ...

Skip the tests if the running kernel does not support MPTCP.  MPTCP
cannot be built as a module, so check for its sysctl directory instead of
trying to load it.

Also fix a typo in the unknown protocol case.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/inet_socket/test | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 7d4989a..94037f9 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -9,6 +9,11 @@ BEGIN {
     $proto = basename($basedir);
 
     if ( $proto eq "tcp" or $proto eq "mptcp" ) {
+        # MPTCP cannot be built as a module; its sysctl directory exists
+        # if and only if the running kernel supports it.
+        if ( $proto eq "mptcp" && !-d "/proc/sys/net/mptcp" ) {
+            plan skip_all => "protocol mptcp not supported";
+        }
         $is_stream   = 1;
         $fail_value1 = 5;
         $fail_value2 = 5;
@@ -21,7 +26,7 @@ BEGIN {
         $test_count  = 11;
     }
     else {
-        plan skip => "unknown protocol name \'$proto\'";
+        plan skip_all => "unknown protocol name \'$proto\'";
     }
 
     $test_ipsec = 0;
-- 
2.55.0

