Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44E37CD3D
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222156; cv=none; b=O1wVGxmGT5Il5AidRcTHoNK3E3Qy8Pq3hJBsIRICe2witPd+3AmaIKArXjUUE6Dba5KbJShb5EfifmcDIFtveyq2G8K2uJpK2fjVXMSDb0aZty2k+pckDK/hRR38YHJRkYh/SmaafVQUzsVTVKB90hh97KoNR8HbyFeBdwr+C50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222156; c=relaxed/simple;
	bh=24f1Uqh7Z2YxmhepasBJlDdy+9Pp8LX3//fh8WUC4Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKf3K/NK0PMvfOHkemJKS4yd6EniarEuDSF2yIv8pNYT8sN9LXUDDYdfAsxGmKyQPmRx0P1FsMe//i4dHaazvtxVPCNNDcZNAed7Ap+Nh3cXE/Ora9e9j1/RtSRXeYA/U3P7vv8kpIWhHzO2uwaoNv/1LjH3TAVlEGPoVMvo0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=SF7Gj+y6; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="SF7Gj+y6"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222151;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1OT0Ln5nYrUoiHGRnSb4oj/kXGaKlJek+IYcABwrIw=;
	b=SF7Gj+y6qh4zwTFWSSd3jEaWCUvkzMbGbMlFztdzDZMhZAUPl9SRBRLV32f5Mzs7kHhYM0
	l7QvM913qZ3jDIu42R6tHo+PsJALd4Pw6nO0HuX80xMwMc9xk1KVBTN3DWjSGfcSJnFOXv
	Nl7MCs8scFP+7PBD19uDmkls1sJeMeVMeXTOf/H1wjAHb2A4vaHgQSjihLeGR4OFmb7+Q8
	9qKXV9BSNyMFlzV3XAHcqQno6TygDgCtOKjEC7AWmcsLpb+OSRGlEQaaWbtF9rvpbJ+yeQ
	OxryxgerVPPsxo7S8OqzJPKGGGEdjurWwcJ4bEy2jJJK6KDmHI4id8a0ucxGbw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 10/24] libselinux: initialize output context in raw_context_to_color()
Date: Tue, 23 Jun 2026 15:41:59 +0200
Message-ID: <20260623134215.98273-9-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

On an early failure (e.g. setransd_open() or send_request()) the helper
returned without touching *colors, leaving selinux_raw_context_to_color()
to return -1 with the caller's pointer uninitialized.  Its sibling helpers
raw_to_trans_context() and trans_to_raw_context() already clear the output
first; do the same here.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/setrans_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index 2b550a92..b0adb308 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -254,6 +254,8 @@ static int raw_context_to_color(const char *raw, char **colors)
 	int32_t ret_val;
 	int fd;
 
+	*colors = NULL;
+
 	fd = setransd_open();
 	if (fd < 0)
 		return fd;
-- 
2.53.0

