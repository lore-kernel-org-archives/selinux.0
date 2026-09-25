Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009513B6BF4
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356726; cv=none; b=O0yNv6fihrwJQ9zIFUQ7dIWAKc+1TWhBfZWodTgAXvN4/3aznRGfTCU+pHC3gYo/jif7+6KLyKev6Kl2eaM53nkywS0rumz+0tYC4m2PoCNd9sfr5eKv2EUp083rVF1rQHp7YlNxH4jiKJHmAFBoMnigLcjAP5QcFprWc4ykIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356726; c=relaxed/simple;
	bh=ESV0zeofegSqVHeEmIZW+oEOQPYF76ErcJR8jWLlTZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWCQ5UOLpe9kRzkYTbe1GuZtpywYD1rDVHRnsLcyUZ0f9bw4vii2YmjsgkCmIV635l799cQp7+pUQ0uQ65CH/YFPq00hUrYtAnjKjsWHcgOrs1a2R8cQGtRlPv6DCvg2l+c8iSq9SbDuuPBm8VT/DB+Rp4SCBdAnYZ/SReUVrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ta3ZG4xy; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ta3ZG4xy"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356710;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6HvCNM7XCfbbcg8fNJn66Cry3BIca5l4jXjhks3fcA=;
	b=ta3ZG4xykRk0eH3z7AjMGOvj9fYJwPyloVYH7/QjKCTJljaW41/pCjY2MT+QBosOGBEKYi
	LEzfJWJGVAID6WM45xZPUE/aTSVYuAcCRCM75hZFZalFhCl0gShJGj7CiikPNIn8D/qkkK
	lrDDEBmXUzOEG53YyrgKx15Sz6U6is5GhOaB0/ASUXtGzXWPfo+sBktNknP+6/ieC9yp7w
	yObL4HHMnyw1v3IKvgI4R6o4E+MUNlPfZF2pMabZ6Xp9N2zMBjpUqBDAMhUMPObWhsbUY3
	IWvucQF0izSjQ+4oE14YE1UyPHDv3Lld5LKbzQjc0qimzABc4eZR23X5XC4xvw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 03/21] policy/test_cap_userns.te: allow searching /proc/sys/kernel
Date: Fri, 25 Sep 2026 19:17:35 +0200
Message-ID: <20260925171755.2029271-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
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

With Reference Policy, the checkpoint_restore test in cap_userns fails,
because test_cap2_userns_t cannot reach /proc/sys/kernel/ns_last_pid:

  avc:  denied  { search } for  comm=sh name=kernel dev="proc"
    scontext=unconfined_u:unconfined_r:test_cap2_userns_t:s0-s0:c0.c1023
    tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=dir

Reference Policy's kernel_rw_kernel_ns_lastpid_sysctl() only allows
searching proc_t and sysctl_t, but not the sysctl_kernel_t directory
containing the file.  Also allow reading the kernel sysctls, which
includes searching that directory.

Fixes: f24939e ("Add tests for checkpoint_restore in cap2_userns")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policy/test_cap_userns.te | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
index 2994312..6b6cebc 100644
--- a/policy/test_cap_userns.te
+++ b/policy/test_cap_userns.te
@@ -40,6 +40,8 @@ typeattribute test_no_cap2_userns_t cap2usernsdomain;
 # Rules common to both domains.
 ifdef(`kernel_rw_kernel_ns_lastpid_sysctl',`
 kernel_rw_kernel_ns_lastpid_sysctl(cap2usernsdomain)
+# The Reference Policy interface does not allow searching /proc/sys/kernel
+kernel_read_kernel_sysctls(cap2usernsdomain)
 ', `
 kernel_rw_kernel_sysctl(cap2usernsdomain)
 ')
-- 
2.55.0

