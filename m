Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B177F36
	for <selinux@vger.kernel.org>; Wed, 24 Jan 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121733; cv=none; b=Bf2oc8+LM8awve7n9JLBWGU8RJL9q0BOhPo3g2WjW0NBXDuDu40p1ZySsBFV/96ipFwP9xxkAqvIGDX2lkC6syINQ4HNgTLIQ0Fxpot/riJYnPPtc3MG/t/Gfgug/3uZ8XnD5/k+4LzK10Dvzy9y25CJ5/5L9rJJh8RiiTn27Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121733; c=relaxed/simple;
	bh=FOxdHXunF7YGpg7YDK26d0GbTb37TAzL6+uN+aZwgnw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lt28/XgtcUPAtHaYVray8zUxXNQi3cOHu2IsHNLW2Wudc8PErOJTHHwhXu8v+jNxMF4jKQtz0mIcF4Vuad1CT21oFR1N07sirAKe3PGHZBdBxFmXbQSRp7Ocan4UbyJhFc4wk0BkR4WsUFhgVn8j4TT/lMc3liopbcNRLFzDzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsFtE3W+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsFtE3W+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d70a98c189so35784065ad.1
        for <selinux@vger.kernel.org>; Wed, 24 Jan 2024 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706121731; x=1706726531; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FOxdHXunF7YGpg7YDK26d0GbTb37TAzL6+uN+aZwgnw=;
        b=OsFtE3W+6B34E/0JAvc5Ogb+A1F+UC21nt07t0A0myyvvU1/d8sDlXPzJLi6Y5pDOd
         c1W4JSouQNgpmDeCD3Pfk/6eIB/Ts2INWFtSStN/xZeDfWOLnfiTnC0P6bEtanbdX5Fy
         bIUGXdv6puOMiml4AQmvIPF5LirgJHJZjX6jTvjev+33LjtYssZyw4C4c184GSwUTIAy
         Uclvn92l6tl/FvfyOgOUPx8YhmlgdHD0SEY9QU4/iMmsON4CDrTDCmJ6Q6T412ltK/BG
         /e1U62Yg3zvWaReDaJXyZ3cNkxIl9uIT0QbO4DJacdGvgBMy7W25AmmbWsQvqDcFJeCp
         YpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121731; x=1706726531;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOxdHXunF7YGpg7YDK26d0GbTb37TAzL6+uN+aZwgnw=;
        b=KQo6Wt6G27B8Xh1AHlAN2ECueZp3/MYqA2uHT9cdKKg1qDOsZzjm8sLbRc9WPMehiH
         nnBsLFwFKVv+1yojlPs6UkbrXAn+0Vg4nujfTQ9dfUWdPlnXrLoyOtCFgBxN+/c2m3ky
         Fo237RxqwhHiBavdQM+5SpBhvhkj9AEN5HiVU8ATZXcGofbfK8bkVk3Mr0lXfM1cmL1X
         +mjoHSexchAf7GryiipA3xTlWbUEKW/6N1t+YaIVq2TSFqAU0pcztAgKVlXXKsJPXNGK
         AVvFYE6z21Ub2swOaT4hPcY6Qxwv9xd/FI0xdqAYhX+7nl2bvUBH0XeecBlYiB/W4c43
         HHhA==
X-Gm-Message-State: AOJu0YxxhZ6fteTmv8kvSjl0vazKgQLZii49tIihKyA05hAD/cVJdMUm
	y3DhualIaao/LEW4vQilXQ9FQnztks4GhtrDOOcOIX6PTxpwKpvHbyrbiTnl9cZJJ0MDcrmx0kU
	SBUGWsjd+YDuB76/cmCUKOOldthh2nhUz
X-Google-Smtp-Source: AGHT+IFGEjPJgOGBjQNIIJz4f/F5/uLBZzqnNmAi41qhltDmNny1jbGWeBRfMKgbXrW/+ocH8v1n0bJCam2+lhP8oaM=
X-Received: by 2002:a17:903:2302:b0:1d6:f263:5698 with SMTP id
 d2-20020a170903230200b001d6f2635698mr1100561plh.28.1706121731296; Wed, 24 Jan
 2024 10:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 24 Jan 2024 13:42:00 -0500
Message-ID: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
Subject: selinux-testsuite nfs tests?
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

So the recent discussion regarding questionable setting of
isec->sclass in inode_setxattr and inode_setsecurity that was
introduced by the labeled NFS support patch made me wonder about the
state of the selinux-testsuite nfs tests. Trying to run those on a
current kernel fails even before getting to the tests themselves
because the attempt to relabel the files to test_file_t fails with
Operation not supported errors. Anyone know when this last worked?
