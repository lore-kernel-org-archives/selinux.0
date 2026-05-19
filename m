Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C04D2EF6
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192917; cv=none; b=I1kS793/FTHxkQfDrxHn7izIciCQId78t/9akvlG5g/+c0JNSL9rVGMCjBJm/a1GURfI2rO//wi6et3rJUv6SJjiDkkwqqa6cqNx5XUmTvvgkHXA1XGPUMh3VOJSOVBCjyV8BO7scQ1lO/OJYPcU2xFgoabjN7D//DnE/FnVgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192917; c=relaxed/simple;
	bh=cxE0VYZJThTem+IreM9kRUdjY3G+ruWl2CYTkD1m4Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbvHDUNma3rCGTB2F1/oWoSHqkA+MVIsmv8SCl562j+Z9VHKqLQVKR5r53fefLO92imOUlPGb9O8H0Ul7y7LSEdMNTUXEuYzlTe9syEB8zOc5UHnyln8jHIBJaaKkv46ZYTVQZdS61/V89g1lPqSHYypA27b1LvrbqAowREZQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJWSAoHX; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJWSAoHX"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899d6b7b073so44192516d6.2
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779192915; x=1779797715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OomWtXNhbUl1UdHciBn2d9go/HKuwrVH7DrMskCP0XM=;
        b=cJWSAoHXeQXR6SMvJJyEiehV3ktKar5U7kgr2hFJUrPzb7fllhAY6T+dyBGN8VRIu9
         h37XBcwNzataOaOvjxl/o60UO/WytW9KGFH05lQiq2eGeP9EQqrEN98+uVcx6nGgkuPf
         cE/C3MeVnNPvNW44a1pd0A/MpO00ODQEtD22E6dIMRzLFhY1KoUz/XakR/uas1JT0soO
         akuhGRLs1O6RkTR07FPc4aHuucNq9DCDyTahxTrQYza/M6zydlPAgiYOEYl/0JZQk8s7
         07ErwHyrczIQPKzche+3OwVmq08xcNffREZKpVLr6ngDt1KKmCBD0d5FJ8UUpNiaFpAj
         9GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779192915; x=1779797715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OomWtXNhbUl1UdHciBn2d9go/HKuwrVH7DrMskCP0XM=;
        b=oUnCab0vA1rwKWFbNvunW5Xz83klAFLh78toM/dP0rKIsuKjEFfGt46RkiWFf4seFr
         MahtpzLOhokxh/uts0Ts23Y1A8D7n5LfcvZq3opYVaSaqhYsVvn2KJUM1C8l/6ICoCWk
         gnInw7CbgS9JE/d1j3vhIZshy+5N7Ruy6dCGwoLgi23NKw7yOvkp9cHDtyQbjzERnuMK
         mEJdULE0b9LUffx2xvnJgfuKmvU0jcSrDemLh8odt4S/dQYYicVUVxO1v4UdpnVg2ipA
         ggJQhto1RHdwieR+iCqPNLpv3boOH2rF9cmYFJmpwcxX1Ar4UweEIwQFXBnJ33pdeDfh
         fkUQ==
X-Gm-Message-State: AOJu0YzZXLaDHbu9909UHzZiYvU5XV7dAQf9zGLCfcwWAUWm822EXpEQ
	QAVPkhCCXTFv1ZvQycfmf4lqZV3IEb0i4cye/85xyHiAYJTGTdEOZZsV0Bvl/w==
X-Gm-Gg: Acq92OHi5/H67Nu6lR7dIQKLJSuPGSC8HNihCag0W/MS9n9QOpJQzgkkQ5mMYs1Tb2o
	tuRvs7i8lMT+uaus3C/Cq01RgEaI5zU2Nm7mO2YQAbgtYYPgEqQh1XH4GUr8c7R+X1xdJcd7cFl
	GeTfh7L1SazddHne+rAZD8hYiclgXk2KrYUoqkjUzo42IKKQAJhsbvNXS0ITDkWf0WTXpu2I0nq
	TcCjZEFXkzCHMDmpkkhhOP4GxhqoSEF7SN4bjXBtT3QFkJFxCn5TcV+NRcZfLliUHC0YTnQLbR5
	vrUu6qTf48H2gcHTLgZ9wTl8piz+evZ3gtPW4UUPtE3mPjfsxnIOOyItteaNQrQvCnJaLy7fHNv
	Ykff47YsopahOGFJae5m8LIBx4+3na0ntTSXAOuxwie6JeV9nNzDAELcTpHoNP3DUnbeaaSAAuX
	5h9P3p6HXaSFOW1mkXyZQHu1F+hZc2VuNgTNAeuHvaeHqR65Z2XeszIwIjwZQOiexWSN+h51kH3
	hGhtWUSG77QD3jTfIalIzmOCyPtOS0WPgYv6KQCzhYz8YZxRH8jlql6U1Xd6Z9qXA==
X-Received: by 2002:a05:6214:4789:b0:8a0:846e:8850 with SMTP id 6a1803df08f44-8ca0f62a5b4mr279238146d6.20.1779192914683;
        Tue, 19 May 2026 05:15:14 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cad98d4e08sm37899346d6.9.2026.05.19.05.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:15:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: fix fd_tmpdir_r check
Date: Tue, 19 May 2026 08:14:56 -0400
Message-ID: <20260519121456.377096-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check fd_tmpdir_r not fd for a failed pin_dir() here.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 3afe1554..7a4233fb 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -1034,7 +1034,7 @@ int main(int argc, char **argv) {
 		 */
 		if (tmpdir_r) {
 			fd_tmpdir_r = pin_dir(tmpdir_r, &sb);
-			if (fd < 0)
+			if (fd_tmpdir_r < 0)
 				goto childerr;
 			/*
 			 * tmpdir_r checks differ in that it is
-- 
2.54.0

