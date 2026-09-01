Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7848382C
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280532; cv=none; b=MoAOL4TmGgOUOb4KMaHh663DoP7PTRhlIq0Ysxfpfk3t8FtV9B9t5X+qqBpfV2MfawpbCOqTjBGfZXpOEoaxl4u0bTp6fI5qyRSLjXONZspiK/bYkByFSm+0NX6CvsozY9T0c24xqX1/9yQz7Z5BhibezBhBAsR/5It8lO0GrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280532; c=relaxed/simple;
	bh=CtC2PxwOdI4VoKyPOFupZyaGYviOj75TQ4rR21/oOoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXPg4N48WMgbjXpY14JwCSVuy9Pl/HgcWByS4wqVX5SIteLKVFnvxlkw/fmEkYh8w7tcE7Jgpoz0bv+PW2bzSevvAYXRGLU1piWjHskYKxcFL7RsA5Xe86vKw1QLyEzKCJKCWVWTB8c97TZsXjvyBIkyirJ2y1OPLfL6Jaq0hsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByQ5r1i5; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByQ5r1i5"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90e7fd978beso843166d6.1
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280530; x=1788885330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0vrNgYhnT4cyUfPzEnvvRpsZUtoiJ6b0J6EZbW+Ots=;
        b=ByQ5r1i5J8sTLexZNM3iZe0j9s4M1Pu7WuiAyjsiHSU8FlkgUUh1HluZeZJyUAbD5/
         f6ovCuUy8OYg1Pf0orI0YrhCtLChcue7o3GO46ZgFb/P0VVpnxNgn+3tWUcTIrMNQfig
         /LmA86/jbmD8ubsJyQRuX1KtJfxBaUPlvaTVIdZDPIIw/bdCycFneMUzcT4Gx3Vc6Prr
         CBNMXetm6iweOi904J3ySaazdbM26ZkRn8yxOL8wnRjGdTT/Bp4G8iSOtJb5RvH8y6gW
         64+5k1+8XasmQiwNOlZ68WBfMHw/7KWc1pi79LhgVvbZnQVI1cbDXnhNudnoE83bLIOm
         U8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280530; x=1788885330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0vrNgYhnT4cyUfPzEnvvRpsZUtoiJ6b0J6EZbW+Ots=;
        b=FNp6GH4OgYkuoXYNOHlfyPmsZ2GOJzPo9zPA8aA6mcb7OX+fuNL8PSKok/QiKgcqnh
         Su0jZN6Dc5KjYG+CKQAOiYgF5dI7A88IrBrinlr8AVXIt385trT5uBWQ/8tB+bBMCE9A
         YvLJtZD+3NL9EsVdR8laQi/SlQkjfWlrroYd8XbvBUTEvfkIoPa8GSqzjVaDDVtpB0j+
         XyihmqlfQVE5LCy1PrEVdemfMgJrVGffU4x74GHC8nnEmmDPHSzs75AU19A/pqSNHMnN
         lnr7dNo3JxsI9NHsKov+TyTs32LPgI4i+5utJIWEj8JIKve42cKgl5/Nn65pKkSMOoCZ
         /vsA==
X-Gm-Message-State: AFuF++kopINyVeXjg4eaYAJJTJC/2Jdozmx9XnV595mqLhB1eil3CaRC
	ozlMgreFKr+XANCytpPVYkjs7Y6rlO7wxFg+Y+nBpeQhZPILpY2FenKa7FS1uQ==
X-Gm-Gg: AYBFou3HpEtb8aew+KU9pAvsx4sUnB1RvKn7fo26/yaP9FKOW+hDwc7MPJZeVivZShI
	HXIW5MPs67bz41y0qaZG+N4rUHKMhcIYru8pHK7Ql04G7GU5xtb+UUS/nMDEmbvjoCcYe6THutO
	mxJOcAnE7WntHH2XhOj5JkG+KcfBAUO20YRkvGlm3ei9rFG29c43fE546pGgo4niCxcP+aSYt8V
	q47TbA7R3YQgFhuUFnpMSQZthfJYfh7oyUT4OVRwzHksHAIKZsZb6s/odTmXT2Ri9IIVU6maaad
	pWr46NrILhpbrytMO/t8Frh4j6Z4xi0oRcrvxX/wK5HswE7RZJ9jAQuGp6wSGi2ri48JjQ8gF90
	xLpmBuHmHQUU5w+MvtibC6msX/QDUJdF2uVRSgY1Jli1LlIrYb7rv4qIDmBqcJ/CXDFmoFB7gH+
	xj4hFXmxBCzZJKvD7JGU+cQJEdrXuCSbMyegoAGEOAsz9EV5yHkYCEa/AltLBmXkGG+9taeRMmT
	2MT4mvLNfgnC69xAV9aEO5zphU+llgaoMMen3iwXSMLQ8PskpCwrnhXXZKfGhhd
X-Received: by 2002:a05:6214:460a:b0:907:bfc0:781e with SMTP id 6a1803df08f44-90ce0f1c9b3mr510237216d6.30.1788280529831;
        Tue, 01 Sep 2026 09:35:29 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce8769b76sm103461946d6.13.2026.09.01.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:35:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 0/4] libselinux: add a configuration-root search list
Date: Tue,  1 Sep 2026 12:35:09 -0400
Message-ID: <20260901163513.43186-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is the first half of addressing
https://github.com/SELinuxProject/selinux/issues/33

It adds a configuration-root search list to libselinux so that it
searches an ordered list of configuration roots for each configuration
file. The list can be overridden at build time via
-DSELINUXFALLBACKDIRS=.  There is no change in behavior as long as the
files are found in their default locations under /etc/selinux; the
fallbacks are only used when those files are missing, e.g. upon a
factory reset.

The second half of this series will address libsemanage but is not
necessary to merge this half.

Stephen Smalley (4):
  libselinux: add a configuration-root search list
  libselinux: search for the binary policy across configuration roots
  libselinux: fall back through configuration roots
  libselinux: search file_contexts files across configuration roots

 libselinux/src/booleans.c                     |   2 +-
 libselinux/src/get_context_list.c             |   6 +-
 libselinux/src/get_default_type.c             |   5 +-
 libselinux/src/init.c                         |  12 +-
 libselinux/src/is_customizable_type.c         |   2 +-
 libselinux/src/label_db.c                     |   2 +-
 libselinux/src/label_file.c                   |  49 ++++-
 libselinux/src/label_media.c                  |   2 +-
 libselinux/src/label_x.c                      |   2 +-
 libselinux/src/load_policy.c                  |  24 ++-
 libselinux/src/matchmediacon.c                |   2 +-
 .../src/selinux_check_securetty_context.c     |   2 +-
 libselinux/src/selinux_config.c               | 179 ++++++++++++++++--
 libselinux/src/selinux_internal.h             |  40 ++++
 libselinux/src/seusers.c                      |   4 +-
 15 files changed, 283 insertions(+), 50 deletions(-)

-- 
2.55.0

