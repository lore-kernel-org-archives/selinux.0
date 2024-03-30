Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC62E3E4
	for <selinux@vger.kernel.org>; Sat, 30 Mar 2024 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711805718; cv=none; b=LJnhZ7xdprP0Rw3nxs5GYzrZCFDYAuOwtNqgW1AdyIR3pH/kMOJ0/sy0LFuFtSlJRR42WLL7/SLL2nKC5aYD6awo/b0y9d4MvQxiheobBnvs0lLM0OUVczn7wWBflr1BG8g/jESrJRJobwlYA87rWzcK7tvvWvlv5c67Vp2jLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711805718; c=relaxed/simple;
	bh=gZRR9CsiuvkA+Vy3LZNwCJnPTFZTbHOWIuKpeo9ia7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W758fWP/PkuXN+M8RiGJ37HkWUagrbm+bsCaFhgHYO1uDgXnfpdkAJWpMecuvz9X+tk5qwcWZ1wyLiHzffctIUkD3dJLfW8/EJx2HWqr7GlgKYHfGSAq2fIhuEAM+wICwMuT9BvkXgB/hcqCkBiYccnD5J25BJb/yDR/USdCzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=VCD7PcFr; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="VCD7PcFr"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1711805706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1eDyWIbCSk02+IwtxU+Gmq9Umx4cr7MgmOK/4ZaB6Ac=;
	b=VCD7PcFrSFu+oZFH5zDQ9mtaldVo9UjDziGTkeoG9UESknzFJwnDk3sWYlxwLiJkCARtKN
	iLC0u1vRj0ZSVE5HuZPXvmZNhkjjFbRvrFFmC0eCWqe1TBgGk2Ioqo8hlTNM9Ha6dssszF
	yjYOcvfJCl4+uLeyeEkcEyWt5wdejxd9/LO5MFkAp1QEoLGaNyDRmEIaE/Pt2ug1BF/Hmi
	gdP0cS0akILUqf1tKqbwq0iNRcSMfQce7EgOp0KGtlavH4ytByJHEz8P0Kb9gs77Exrbct
	0C5iuaX4Cbts9pEr4aIMDj2fumrKB9jSN4Xg/MuUPl3C9KnuMYDWfodtIOEV6w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] checkpolicy: free identifiers on invalid typebounds
Date: Sat, 30 Mar 2024 14:35:01 +0100
Message-ID: <20240330133502.72795-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Free the two identifiers on an invalid typebounds in the error branch,
similar to the success branch.

Reported-by: oss-fuzz (issue 67700)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 0cf938ea..92d1e5f2 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1477,8 +1477,12 @@ int define_typebounds(void)
 	}
 
 	while ((id = queue_remove(id_queue))) {
-		if (define_typebounds_helper(bounds, id))
+		if (define_typebounds_helper(bounds, id)) {
+			free(bounds);
+			free(id);
 			return -1;
+		}
+
 		free(id);
 	}
 	free(bounds);
-- 
2.43.0

