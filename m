Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308364;
	b=IjLNP0waOH+rg2zP6Q8+iT9LfTzomtmvC4v3hV31gnCmHR/2PqOYVNe0LA00ERVtfXum
	 Wy9X//zyZnQ9isgt10JnlyRDESuI0tBnKyH8Lcpiq8m8MI/+n3a5gQ4scBNx0XvUbTUtx
	 fP7EH8Kb/xUPQNuDyxedogcKKxw6RL9YozQ3YT4I8XzSXFHGAR3uB5ga9Pj5iaT53rfS6
	 us058+k8qoMBc9PnzoARJqDLJR5Oz6kBk/64L5HLFzJYH/71ppRDQc/YtMpUu83+yzRwo
	 ggIR8KhnYjEzlzypR3gL5ct928i2ZpP23HJylJLgK0w04nIsk02HAcdDTHK8Da3EE7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308364;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Yv96u5D1USAL7B2qIujlX8Oxggq4WUeu90jUnny3nKQ=;
	b=UWrI4ckny1EM+fcG5nLr+w9BkAF/JXtJ/08wPK3UKjV6pIMN3IxbvQ06aVUorAtn/R41
	 WkMuFLRtmTeyEjlCS3fbf0+8kIJfXSPXHXTf/R6LPci6Vuc18TX+aWu9bS+qCwahxHiaJ
	 yK4OiMSlJChXAuuNw6rixvFBZyBbId2YarmRf6aL8eSnie5XP0NA+xOZjVBF4HEC0m+FL
	 ILzwRJU8Pm7cIPlio9Cl/OsREq+f6GHRoJmLMdxDfdVMwnlGY3DrnIBe9REXAEkbZlhIK
	 DM72xzyTX3+3IfU/VPbBefbSqSRbxxWFbsSQBfKy6nT9HzCyc00QAhI0yXcVFg/dsCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=j8AWe00D;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEF606A331
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 10:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EFEF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=j8AWe00D
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308360;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yv96u5D1USAL7B2qIujlX8Oxggq4WUeu90jUnny3nKQ=;
	b=j8AWe00Dz2p1ViNpHe1p6rjU1wX6h0j42UHf61z0m1t7vdg53BpPEz5gvraXn58DO4HfIs
	/FnJ07GBL/7lOe9qOzvzZ/a3qWgTLeqr0iWnjvpPj3wVAsvz2tmdIGXymCY5sJRbc5sW+G
	bjwaS9julK8MhlA7gsCTcEZCiPYxcmILjtEOtx9Ca0Zzp7+AvQklYwXST5Dq24vCaq+cuQ
	XJpjdJGhiWYaHnsv8vpeWm/BWaHgPsesSH3S0xfq5UY1Pg52pJ5D4bv5ncOdy4RTgP6riN
	ecMn1v+K6+ISowpcwPQOT9+gHrO59HFYIgNqkDXhZSzxImeOPzLZ0FOtyv/fbg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/7] libselinux: set errno when the failsafe context file is empty
Date: Tue, 10 Nov 2026 11:59:02 +0100
Message-ID: <20261110105906.58509-4-cgoettsche@seltendoof.de>
In-Reply-To: <20261110105906.58509-1-cgoettsche@seltendoof.de>
References: <20261110105906.58509-1-cgoettsche@seltendoof.de>
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

get_failsafe_context() returned -1 without setting errno when
fgets() hit EOF on an empty failsafe_context file, leaking through
get_ordered_context_list(). Set ENOENT.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/get_context_list.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 06cec418..4c9b6118 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -287,8 +287,10 @@ static int get_failsafe_context(const char *user, const char *level,
 	ptr = fgets_unlocked(buf, sizeof buf, fp);
 	fclose(fp);
 
-	if (!ptr)
+	if (!ptr) {
+		errno = ENOENT;
 		return -1;
+	}
 	plen = strlen(ptr);
 	if (plen && buf[plen - 1] == '\n')
 		buf[plen - 1] = '\0';
-- 
2.55.0

