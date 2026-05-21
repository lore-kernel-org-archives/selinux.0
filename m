Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98153CCFAA
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370849; cv=none; b=Bc5tuxqwJrMxeAwverkIlQTrbm/vUBU3iqpriMi8/cB4SVM73pt4O1zpf0N8EEdHfVHIvHsWye48lMzUOYKVaeBBCGQL41w9fO2fbqP3lQE0y+ERODUuPia7byWPQZC75VsOHcNyca4DUfLFot622A1y7PZluJtFsqCdfgSYxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370849; c=relaxed/simple;
	bh=/kuxO2UJ+JxTFHUb/kg8SEnxFMnf4fcroggzwOf3sfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDDTdM0jv2no2syWyaibp1+Z+2EXoBRmvkqNveq468vrU48LHHw9ZE1gdptZOR0DeGIeI0NOyT9tWTw6qP2O5K99c01E5dDTgWyUVP/hSnNxih2ZnazjtQWAOK9vff8MdTy0LFOAVENosspjNWKig8YDKuamYB/3o+8B/eTdKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8zCG02Q; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8zCG02Q"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5751770a178so2009950e0c.3
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779370846; x=1779975646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y27BGuD+hIq4wKKSaOaOU5G9KuxNCXqd5MoUyDnKi1o=;
        b=r8zCG02Q0gAb39/cnYySloX6lehB8AcsLMLfSr5/ctbNug/LtCJihK2Ae0dPvaPjs3
         rEG5orgWLLlQNPqAl2q1c2tiZagZqjok4M2911+MKinPgKIMJTsKzvb7Qm8LfzC6GJoC
         ikna83JEn4TkPaS6Q7dTVb7MzKwK+mgpWLmnMbqTtC4LghDAI1548q1uGeifMICOrHQ7
         8RTRFrDBORtblla4MEl6GNNDDsbzdZ8JZkP6Q6nkL8Gyex3UfTNprRNKJ1xIzVjtcBg7
         6aO1W+tlOzPR6YHH6wu9goW1WQhc8dV1MYJolqHBmWlSz70V6zfCuZyJ5bd9w30WQG0z
         73Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779370846; x=1779975646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y27BGuD+hIq4wKKSaOaOU5G9KuxNCXqd5MoUyDnKi1o=;
        b=ZlRhC6d5mN9DeHD4GFfjrGEtm7IOdVwQ/uXYV0WLJ2nHnQLv4H/+nfdwK/lMQ2h5qN
         a6DAxltw04/IuqoPs2BNJH0h0hgo118doTZIb+XrQOeacFhB6oI4BLcNgcfg/2rekNgR
         e1F3ugzMGH1Ygq3GJbKwL8OtkOSCOyiQNmNWXWUVA5oBN6oA123cLdpzsT6o4l00js22
         0KqlwXdGAWMyedrAdC1ukT8qaZaA7ABNEYMniRN/PrssXZc31V8PluL9Wougl3WxMSCm
         crvsl28Zhz/LpmGp5OUk/WRN2c+obFFCZV3uks5TxZMinl/ax0NTZnMVnokiUnTFSzFT
         SrsA==
X-Gm-Message-State: AOJu0YwxB4XjUwMfscArecWubOJBaoqbZNBoHUH6YajeGkU9Q0/rZkU2
	2SUB9uxpYdjXaclj2/wBG7XunCatgaczUydN1bVKVNUfnwetvEXSAcv6IQ77RA==
X-Gm-Gg: Acq92OGyCBuurH8KGtP/l1QVgHjtgZj+clXEQik5mvgqvkxGy/X12n6EiR68wiYufOI
	B2IvxLXBAXJckaAzYpD98sNAjlFa2GntKK8CIEFrEasAWqPhHHBgk3ng8c0LogL6MoFwa+NxFOX
	ysIIBvdXyQ3jk/zKD/kQOqqBKbICkCt9RZNBI3Ra9W+VYU3PfRT1Q0rRzflfhWwrta34W96v0D1
	D0KWKYIYy3B6QBgrddI/H7LSExe4MPTjTDXHY6fQr4Si8pd7432qSM0PUQMFZQYXKXxKLX/suy1
	aQF/+fCjvqvk8BPDKTnLemzAipULdNEpNceHr1v85Z7PP6VOo/rF/i8Wm5LGCA7d0axBfikmfQK
	8bBYYVEIIFoXo2qEzhIhbrVjz+c8jVjsKY8ujlW/jCvrafyoBgKyeC2PikdnIPZxL5vB2OeaNWL
	mZQezMT/Fjf5NUzJx9kk1LdSfl+3My82WqatqGzZ4kW9NRX+2Lv9KaUdgN6kcO55AAuw8cnnjzf
	5oRZfY6bhLR/pDvSL2A+5IZUPQR/y5RAMAw1YEJf67GWEgf5emZqk4=
X-Received: by 2002:a05:6122:235:b0:56b:8e1c:582d with SMTP id 71dfb90a1353d-58428092a19mr1327895e0c.14.1779370846546;
        Thu, 21 May 2026 06:40:46 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc781b428csm5027756d6.23.2026.05.21.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:40:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/3] restorecond: don't set gl_offs for glob()
Date: Thu, 21 May 2026 09:40:22 -0400
Message-ID: <20260521134024.11581-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gl_offs field is intended to specify slots to reserve in gl_pathv,
but is only used if GLOB_DOOFFS is set. Since this flag is NOT set
and we never set gl_pathv[0] explicitly, drop the setting of this
field. It will be initialized to zero by the memset that is already
present.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/watch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 466fc1b6..40d30e53 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -183,7 +183,6 @@ void watch_list_add(int fd, const char *path)
 	globbuf.gl_closedir = nofollow_closedir;
 	globbuf.gl_lstat = nofollow_lstat;
 	globbuf.gl_stat = nofollow_lstat; /* never follow symlinks */
-	globbuf.gl_offs = 1;
 	if (glob(path,
 		 GLOB_TILDE | GLOB_PERIOD | GLOB_ALTDIRFUNC,
 		 NULL,
-- 
2.54.0

