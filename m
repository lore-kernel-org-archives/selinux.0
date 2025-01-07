Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B01EE004
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257587; cv=none; b=PivVjv9xyKkxCh4JNbtGbm5ohKivizgNS9i5mfF7J8cF5alLx88S7fwEx6jJt1/TW8G80df+mLYdy6r8mpTvay7aUZ7b+JM7r2IsSnX12/oaoSJv9PLesZR5Q0Bt2EyJjufi5LfSB2WLEzJlkrsr/LxvRCeFzX/B2cw36qs6v8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257587; c=relaxed/simple;
	bh=BQz1lOJi7ohU+XD1SNQFNpkjbIG4O7ewzzIUDiJesx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyv4pDI2oADL9gaIl9NtJoKG0VrpN6jMENo9raDzlnA+dD4/mxXnVmZuGaqVvI610Af0czqy/VbYxWGUD+pys1DA5tdxrweqyMr1ARjBpG3dYYCRkn30z0fN0PcrOJXha1RTOoN1+/X22r3K+wInfp3gPvgUetpxZY6SBIcnmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=pqVj9ElA; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="pqVj9ElA"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257575;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhQ0cC17Zp9i6MTbcnqFntOdWP6BygOzE2LlMi5Y4hA=;
	b=pqVj9ElAhRVQ02riRr9iBnuczNZRjhhELfvjdcwkJ0Yx4zFVsf3FS0M+nRE6kP5pNZGj96
	GbuL82u3tUqqbHK0bsJXfPp1KtzRRYBcZQw2+PbIl6zpayXSjDo3diUmI7FQuk6A9Xt6jx
	GzLgpPPP9kJTjKtqyh48eVaDumQ3ojd6rDWzy4ngI9Zu/Z75+4Nh/NAVt/M+nAjJGzziNW
	nsgfJDwZiAtNr3zUx1Pa9jTLRe3tN9JO7C4Glnsh7UF0Oipn6ragHxerA5h85VyuMMuyaX
	MgFnCBBY8fFkzPKOUdilMu6dA5NEPgv5bYguc8gcP1C/2AS3r79biqY+bnPePw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 11/17] tests/inet_socket: skip mptcp if not supported
Date: Tue,  7 Jan 2025 14:45:59 +0100
Message-ID: <20250107134606.37260-11-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
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

Also fix a typo in the unknown protocol case.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/inet_socket/test | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 08c7b1d..71bc7dd 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -9,6 +9,9 @@ BEGIN {
     $proto = basename($basedir);
 
     if ( $proto eq "tcp" or $proto eq "mptcp" ) {
+        if ( $proto eq "mptcp" && system("modprobe mptcp 2>/dev/null") ne 0 ) {
+            plan skip_all => "protocol mptcp not supported";
+        }
         $is_stream   = 1;
         $fail_value1 = 5;
         $fail_value2 = 5;
@@ -21,7 +24,7 @@ BEGIN {
         $test_count  = 11;
     }
     else {
-        plan skip => "unknown protocol name \'$proto\'";
+        plan skip_all => "unknown protocol name \'$proto\'";
     }
 
     $test_ipsec = 0;
-- 
2.47.1

