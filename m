Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C5376
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990395; cv=none; b=JKTDho/FrFV/F65eWarOL9wUnDwQp9NjZ+hrLIRqYmlJbgbzYQamgKg23lBfzkItjCJK0tQOhfch6gSJ9nKM/e7OkLLiYFRH6ws1e+9W8P6RitRs0uFAqsJMQicL/vnmBdfLwPx2zCz+eTfpNWvQyThCcHtPmfIoCCnubD4g/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990395; c=relaxed/simple;
	bh=ZqkBOyeRfGppZfskN8Jmt2A/gCxLbSvpMdlbZXzUzMw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=l8B7RnXUGaq1XdX/SApM0ibuA52zKx4aRWwrL0BmOVvP8d9HHeEx6pTGha1VP14a7SAkgE73UXZIvZbomrzKLS0aCpqSWun5Qsp/Axp9GzzmKqbySoX7fFD7DEE6yvDTdaFFjNIN/49LZ/x4IpQMwIjcCHipXt4hEnjXgo4Vyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX9pkaUH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX9pkaUH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4560d176f97so1701685e9.0
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753990392; x=1754595192; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgzhaI1f+5cde53WIneO+0LK53PJMQL7Yl6Yt/83VvY=;
        b=KX9pkaUH0RJnueoHZjWgrPmojNdD53elP4jHL0BzdepbWoSkTogJMFQf9OgEQb/xR8
         JYzR80AD45UZfE5Q7/QfkoYQJ+bQBfb0SxqeHebDXU+xMJLJVNCWqxkmS1MtWpPL77pN
         taCiNYZBB3YyQ5JCOFa/pETEwcf+liro9s7rnfWy0WlJAFBKaQKL+CG5NL5GjYebNSHJ
         8gTj7F3i2Kged0GExy8aNCLLCuezubVju8b04eGZya+s+bJzS+z2ULnjrOrd0qo8kdCz
         mJ3q1LERLH6RRWdCf5WohhXUdiodUtaQReQcQmzAuMPQUk8T//UBRTVs4uMYqmq6bi8Z
         aELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753990392; x=1754595192;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wgzhaI1f+5cde53WIneO+0LK53PJMQL7Yl6Yt/83VvY=;
        b=NviuvMiD8qsk5oXkA2z75V+5rS2kD4HJNdatv+5lhwiY0yPWPF60sQxHbqtQPe5vo4
         35Ve3OU2ck1eFeAG83PZAGkHxklisruByf1hHYxAGoHp2i4H9IynAkfg9wu4l/gqbS04
         YRzHYu+lKcAQbRVODGP8qybQliDtXMyGmW8NrYQL33jZrHmBZx4ZngAVZWnlsd/RpObo
         kufn8s74QNx7WHSo/CfqszwLL+b50Lv4SQ51LtwDjjy6PQlk4M1fhwOasB6a1wpExjuB
         P38xtlfy5t3XBlCE1BuOMB2CHa0BdrnEJI/VIXjdm9XjIzIeU4K64AQs7P/7RdADB7jJ
         O9NQ==
X-Gm-Message-State: AOJu0YyKmw1wwbFqSBX9plD/1KnFh2WXeoIusIVcBWevnR+dwE5nGd8r
	O79G2qmOpNeaF5od3Xt46s938thnsi6bX+lzuSSSFVsbMf49YSxDLxpbxxoLVw==
X-Gm-Gg: ASbGnctMwgBqyWo/WcjICxqXZVH5uR3nOCKdBpDUbvOt4M84+iHZA5t8ixrNulW82kk
	utVI/az1/1Wm7wgWE/8gqk3M43aOH/tybctevQoa+JaK1FxArbeAWcsleF53wFxgpQPIEp68GVH
	3aqWAxCz6i5axjR1dL1LDj7hkGvSh2Uctk8YuSv9IQDL55XdgpiDV7m08dO5TAvOPDdjBNDxUAv
	vEo4lgI2y071dAifHNkXhTQW+bhX1W0ljt2QzS5b4+vNoDZJiyYxaRG41rOdeDZ+mEk9UR5idfP
	MGu7GTbzDlTMUoJLDlDEdsaEpO9prszO9dGK51/aVpouy/70pNg3qcRZdNGo95hXOoOIJbserST
	8qQ/9tqjDN7axRq/1
X-Google-Smtp-Source: AGHT+IG8kbu6vjrAe3WFKirT/l6stg/Z/gD+GyMrkr+NRcCOOUtGB0GFOUkl6mPmBcE/qmiiVvYA6g==
X-Received: by 2002:a05:600c:34c8:b0:455:de98:c504 with SMTP id 5b1f17b1804b1-4589af00000mr76703825e9.0.1753990391569;
        Thu, 31 Jul 2025 12:33:11 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaf08sm73756065e9.26.2025.07.31.12.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 12:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 20:33:10 +0100
Message-Id: <DBQHP9O2QZP7.15GAYG3PERBJ8@gmail.com>
Cc: <selinux@vger.kernel.org>
Subject: Re: [PATCH v2] seunshare: fix the frail tmpdir cleanup
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <nvraxn@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <20250731191859.1091884-1-nvraxn@gmail.com>

Actually thinking about it... symlinks are probably a concern?  As an
example, take a symlink to /root in the temp dir - as we're following
symlinks, /root would be deleted.  However, I don't really think it
even makes sense to follow symlinks here, afterall we want to delete
only what's actually in the tmpdir.  I'll send a v3 in a bit that uses
AT_SYMLINK_NOFOLLOW which should resolve this, unless anyone else has
any other ideas?

Best Regards,
Rahul
