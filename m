Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238710;
	b=LjYsofnyaqDpDRj7q+cLyIwR2SrQz5y+IXb6kOGcL4AWYlTOW94IlQRuCacVqGKsmCNm
	 q5icFCBdoyZYSJJRYEz6brTdHuv2DfnrGKrXkCJwplijW5xy/YwW7hlLIClZl8+Js9qFY
	 unMY2F6eSIMF6tziX3OMPyuky4vu0r0g1gpKrNxzMCfDBKAkNO7lMhRSCxSXEecet+vFZ
	 Q9u4qRKfqpC8jJQ4foPinzbelxp0mniBREzPmf6nulrKcv7E9eRWB6NI0xheNAblYFW7S
	 5Qhs67T9PhtAjrwleQ1o7KVIfS62JoJtBja7XMY9F///MXlo/rA7Y4q+CKeP4ZmO6LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238710;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EXQ7fCxXt1UtQmnjd9HOhOqzRpd+OK3FYBBFF1+6kbo=;
	b=GZCpa2dGcphU+kthjUoH3AMuoM6Zw3N8/Wny+FsNBXVUiuDTNlHGwvRF63Ru8I7pwPr7
	 bGqKtVZodfYbMdbsfnks57F3vbGMMpyFe3ZRbNZCu7k5O02HLE/4fWILmPXgsuVto/qJV
	 DKLU3ycVzCXRNbIjTmgtbXXNuGGB2j3o2yFbu8bSOt+rg/LNUp0E7LcLg0Kfx0VeFeeau
	 gXQh1L/nXwQ18e0qCrNm8MU4oicfC1xCtlndS7MbRA5qQGqhwOpNgaxTQqnLZ4akhZrwy
	 0YEUD4PKKHoZ70Rjw1ZsoLtFZByIyqMOV6LhLD9XlRjkWHxzDl0Ngrh6T28XBUqpPDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=E4r53cwN;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB182606A325
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB182606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=E4r53cwN
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794238699;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EXQ7fCxXt1UtQmnjd9HOhOqzRpd+OK3FYBBFF1+6kbo=;
	b=E4r53cwNAgnGpOLCKEGwub6XVdVEuqgJPVcvLtxiJugde4eXjqDqeXo1d131DMiPamAM65
	PU57Z5MNE0KLLLPM1nglYys4W2tVTDu0qB6jeCP7Rqder6RuwVYVZwFbQSVmVMidQzTSSQ
	r3EVzFxuatXY8dMZyOQvVfyTPmLPrvWZdcCeBXIJNcu1rTblsuhPlSGDNTST4A1lLuvIld
	M7Scm3ot6r47NrJa/7EkySHEykVbVAdOm8WiHTMSZjwFozkipw4DPZD4qyV2Ix3rnGLAgm
	ZKq2KJx76CDoy0eQYLtkUKyc1rTDuNQsvtBIBbQTBokU+M2wUtClde3eMCWhYw==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 2/5] selinux: restore the context string on -ESTALE retry
Date: Mon,  9 Nov 2026 16:37:58 +0100
Message-ID: <20261109153802.76176-1-cgoettsche@seltendoof.de>
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

security_context_to_sid_core() retries the conversion when
sidtab_context_to_sid() returns -ESTALE because a policy reload froze
the sidtab in the meantime.  The retry passes scontext2 to
string_to_context_struct() again, but that function mutates its input:
it replaces the ':' separators with NUL bytes while parsing.  On the
second pass the user field is followed by a NUL instead of a ':', so the
parse fails with -EINVAL for any context, including a perfectly valid
one.

Without force this makes the caller see -EINVAL for a valid context.
With force the (pristine) saved copy gets stored as an uninterpreted,
unmapped context, so a valid context is treated as unlabeled until the
next policy reload.

Restore scontext2 from the caller's buffer before retrying, as
services_convert_context() already does for the same reason.  The
buffer was allocated by kmemdup_nul() with scontext_len + 1 bytes and
the parser never writes past the terminating NUL, so copying
scontext_len bytes restores it exactly.

Fixes: 9ad6e9cb39c6 ("selinux: fix race between old and new sidtab")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/services.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a6e4bf262a9e..b1987367e8b0 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1614,6 +1614,8 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 			context.str = NULL;
 		}
 		context_destroy(&context);
+		/* string_to_context_struct() mutated scontext2, restore it */
+		memcpy(scontext2, scontext, scontext_len);
 		goto retry;
 	}
 	context_destroy(&context);
-- 
2.55.0

