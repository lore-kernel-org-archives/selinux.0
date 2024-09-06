Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F601D1757
	for <selinux@vger.kernel.org>; Fri,  6 Sep 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633772; cv=none; b=AAQMuKLrF+njdLER1fyqLm5fvy7yJS7vfZFnf3FVKMkkXW1gdf8P8WqQQA2BbudRAiDv4tLnAb+hWJ3HEScM19PfW2lhqSKH4IDaZVvYphE2/6kGowEA6lWI75/N1mEDLtE/+q1ZbxlaUiEPl928hTrxFciKfd2E3nNYO0ySJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633772; c=relaxed/simple;
	bh=LJU9AgRZafbRGKRwX9Z9gh0a4h6DSxuz5293f/4NqIc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t2xl7UQ4Yv2NKWDIYyZD56Y7O5e0NHd25DzTevtGEwKRS7rAhnbXRa94S0xNalBRhgPEEwuSa50HKGpnJppwm/B0XXmmzdNU1m1g0uxN2Cymr2VJS996KtuzVFpwWi8+gzm8LBvzgkIYytdY4Q/ii5sj7m/zDSiwyH2Otdmc8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P3r7zYAr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P3r7zYAr"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6db2a9da800so18822407b3.0
        for <selinux@vger.kernel.org>; Fri, 06 Sep 2024 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725633770; x=1726238570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OdvfsRmG8gWy8ITHHRQX+/j857fwZkk9D0jFjQ3zW8g=;
        b=P3r7zYAr96F//KkxOCOuOGPLnkLuxkKz1uN7Ct3IxWZaka2u+QdBwSYnW9jqv/7nFF
         N8eYfaQglYSFN7vnmemHCxqJcs29BgRlHDA+iNodNn6qL6q07FddVQpo5YFYGWnxDjO0
         fYvTuLtKyRg+dn+g/LQi7iqCeP5tZ4t6se32+vNJC7FpGcGjZt4399AcxxEUgYDiNm9R
         0Jxw2Ozh3BsDB1jRs8oTLBPXYMcY5rC0+IV75R0/cr28n+/hSmnnhWtc008O6J4xxw7w
         0iTUF+ZKo3rCWqYV6Z8f1KsXECn1JhXTjdhx9vY6GJLpbRRcpsHwgUlZVKrYjHEARfZi
         R95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633770; x=1726238570;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdvfsRmG8gWy8ITHHRQX+/j857fwZkk9D0jFjQ3zW8g=;
        b=RW+MOs+JKKwKp984Izhfvh9xkPQFxxH/i9qaP1VaVoTJfTZjMRzPBftzpoHztHYUk4
         XqFRWH+5KqDTZLxf4Wcnkv390P8B3vhLO8AQnQmZEy24OSEi/l7Pc0xytczuLa0+0z4i
         WxY2SkD+NF+wNfOTdnz9GC12NUlkNqB9+zWlw5WwD3llKEBV1y4WVKlrWvi5U/TJLkRp
         uAvo3UqDAG6uZCnRHS2O2dPs0NQSv1AuHmLUiYjpz1K+vLakjN7M1IpIq8hxI1e7XHgV
         uBBfoh8ibikXerhP9FyZGZRecDnrrPe4levZGqoYZFraE7NG4OioIvQqBKUHotRo0lto
         W0gA==
X-Forwarded-Encrypted: i=1; AJvYcCUKs0QW5n3rN4YYPyBE69qx4VSdNZTb+B7TuLatbn0mPRLP4otxbPnY7Y2C45u6MfEA/AP6M93A@vger.kernel.org
X-Gm-Message-State: AOJu0YyyYPgi50bwLm+udlZFpadaeRqnx01RrSuGony/5hntVU6iHYkn
	CAiLiGeTU3wCJP7CHNQ9o0F6CbAOjU+usFQI7RRWVfKrbpUmaw2ynM6JZnp6n5CTXbBfGWHGCYf
	78EDBGcQU+OL0MjiVfZT1Hxcl3fuVZTYM1bvx
X-Google-Smtp-Source: AGHT+IFyloP//56s7Tf2Mkhp9TXcL4TAe7nGoLAX93C+OtFA1ZbwJ+YSP4o3ZpN6+R8XILp2R72j+bk+ZnyMbtqi/sA=
X-Received: by 2002:a05:690c:4d82:b0:6d9:d865:46d0 with SMTP id
 00721157ae682-6db25f4767emr87625127b3.4.1725633769789; Fri, 06 Sep 2024
 07:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 10:42:39 -0400
Message-ID: <CAHC9VhQvbKsSSfGzUGo3e8ov6p-re_Xn_cEbPK0YJ9VhZXP_Bg@mail.gmail.com>
Subject: linux-next commit 0855feef5235 ("fsnotify: introduce pre-content
 permission event")
To: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi VFS folks,

When you are making changes that impact a LSM, or the LSM framework
itself, especially if they change the permissions/access-controls in
any way, please make sure you CC the relevant mailing lists.  If you
are unsure which lists you should CC, please consult MAINTAINERS or
use the ./scripts/get_maintainer.pl tool.

Thanks.

-- 
paul-moore.com
