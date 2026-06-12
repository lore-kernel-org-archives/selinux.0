Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2D40314F
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284155; cv=none; b=BRSfKdShsLoV8hEZP4B4JlACThfU1/10PVZtbcPzGJ/F0oKu37XHUACkEdKquSlbKiEVljvqOc+5JsDOGrRhX2NSYc7ZsMd4KJ9xSfYlvCtdXFVCjOHX2nIds+NIoJ0lAZbZwiuG4TpaduAs/TuTYwGqqRxQJOxVbKSw6JgxbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284155; c=relaxed/simple;
	bh=pwyA63RWHZ2d67pUgDgPWqoI02LpJv/Izg2542oDb1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJwjRjfzlcB/dus8titb5JqvflQC+iaN3JPjmBiD8eyz9X6APkIqBKIaEPHm+QwxRMzNv6KajZ5ieckwXVN3ZmiLLPBOw/hRNz2MZyelHuQuhT1ZOfBllXIzJkZrYRmfEh/RBo4mc4bqyPMkgCmUtQguyUTgUFUhNSjO/UnDSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzQWbNuj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzQWbNuj"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so11991966d6.3
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781284153; x=1781888953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gX2qHq3QMZ3p9ZFPe/LhmmamrQUoqObVtoNMGd73jiA=;
        b=OzQWbNuj+HNWGGPu5fxTK9nzVNX/ETqBEeBbJIlj8B7fNEkV6TAP/dZuYsG+/jwVCr
         vHSDB5jrg3F+fWWk9Z87BMQsi9NrSBXLN21D2Gbb6OjK1+COOhRc0svqU3ot720fL4kE
         dX+xvK7u2ageXaktcqbfH1nfju9EHOX1XU8p9T9L5ppb8LStR5xZc7lQH7olPd3ADNcG
         zix6SE5YhyNfH6L+NAF4BA5YieojXCl7Nd6qHGg0WJKSYvJyUW645E03Dx2coxCFP47m
         7D+JKKm8Sxqu+JFbs4uAPZLr+Q9cvhklPBpAFq97CSrPbwCqbwgLmV+bQ/HJCe/XPaAq
         shjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284153; x=1781888953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX2qHq3QMZ3p9ZFPe/LhmmamrQUoqObVtoNMGd73jiA=;
        b=nv9m9IQPZxfYgzCeT7WcSMSsv9sULVK9XFMgVWXHyIvCAwTPdSdBEYHwcDEwVC4NKJ
         mK/OpAofWulOfTZAvVBwjgPo4N0a1Scw0q7vi/0fL8bvkRiXJ1aCHAzjr1LR9ZYemiwB
         pqfkr6zlhxL1+Ao54h/3NQ1C7JJj1oTPqoTb+d38mpr7PYLTMztHaAsbLxrje4Y/fOWO
         e4jRThuw4p4dXuJxQLOh3nHWG9YTiLBPpWO9sTFN4DtUG9nT2KoQMuC8r7VZOM9K1DAY
         U6up7yChe+A/hTWe8Le3RFD+QPBJthW3gdtesonq0U6VvcsjsfMeMEAwPCH0cuMD1xF+
         xfXg==
X-Gm-Message-State: AOJu0Yw6nJfjbBCZvM8D1+seFuXrzqu4zuRrSyr7BVWhqooD1nuFxAy4
	Z4dMsdpTVAszDu0yLAhvyn0DuATJSQwktOEhK6HUPBFdAEm72roT4lBsKbzf+w==
X-Gm-Gg: Acq92OGcfLaIaIkyN6l/yrekGTTw+6kl98Nj/AniOvraqHUaI2yMaz6HV2X1LmGqSgR
	vyKk2+w8tG0PkbtkTep1024NMfdzOt12Goi8O+m53FlB8MRN8etR1uAXdumDn2F0+1UNB2mxy/J
	xGUS+jp6fKfTaddXikudFAY7nLmS6ScOTf1YtNwwwK5Pz8oL2wU7iumGAfQ9lk8AwVnNFociry9
	MuimI2JcG2R1ZkxEOIEOLaJlcn8E6MHw23glPuQb0QclW6p/6t+eRaKymwmMQ6YSJRvl3/QqHzI
	zGntDNyeblRf6ey4Y2rQe+la+qJZZ8o3RAe32RVziRiLK3S8MUWhg9tkeVAb/XgonQSEvdxuvQA
	Qe1292y2FIOysIN/D78lpLV4FtN1JFesJZXjXzawRdWXo2QB4ADCmdNezP/6FmbJlx+gcEZyCgM
	UpWaOkptk6RnxON9Q37jFt6DpZW1Y93p0ZC5qAZEiLvKOC1St+EmTGyFZdQ3+eXiElQXMOOnKgM
	I3DY4PJObAd0SyFvAV3RRgUrM4=
X-Received: by 2002:a05:620a:2310:20b0:915:9aa6:8e3d with SMTP id af79cd13be357-9161bc9e9bbmr390934985a.33.1781284152574;
        Fri, 12 Jun 2026 10:09:12 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed8aa6sm265590085a.2.2026.06.12.10.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:09:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 0/3] Make selinux_check_access() thread-safe
Date: Fri, 12 Jun 2026 13:08:53 -0400
Message-ID: <20260612170856.17904-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a RFC-only series targeting merge after the 3.11 release.series

This series tries to address the same thread-safety issues for
selinux_check_access(3) previously raised in 2021 by the
following mailing list links and GitHub issues/pull requests:

[1] https://github.com/SELinuxProject/selinux/issues/287
[2] https://lore.kernel.org/selinux/CAJsHiNx1E7x1jaBkS0i4L1nBWXp8YXLHRWcCaDaH4LOn=zm+Zw@mail.gmail.com/
[3] https://github.com/SELinuxProject/selinux/issues/335
[4] https://github.com/SELinuxProject/selinux/pull/336
[5] https://lore.kernel.org/selinux/20220120073329.15234-1-purushottamchoudhary29@gmail.com/

Stephen Smalley (3):
  libselinux: avc: use pthread mutexes by default when no lock callbacks
    set
  libselinux: stringrep: serialize access to the discover_class_cache
  libselinux: sestatus: serialize selinux status updates

 libselinux/src/avc_internal.h | 19 ++++++-
 libselinux/src/sestatus.c     | 37 +++++++++----
 libselinux/src/stringrep.c    | 97 +++++++++++++++++++++++------------
 3 files changed, 110 insertions(+), 43 deletions(-)

-- 
2.54.0

