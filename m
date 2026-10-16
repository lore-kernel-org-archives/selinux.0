Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1B46E017
	for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144962; cv=pass; b=bImf+WYOqizIK0a69B8b2RZUOv7cn/TORaS40JIeugXBKpVHP6+C24ScOoF4tdhkSRWxLUKEZc7H/p86cFn+fPyzRzW4KNORWfoisSby8RH0bxP5kfHZLoWY+nlAP4HN5J4U2QuuSIDRK4XPZRQrN3YXyBY1IBcWe/5ay69dc/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144962; c=relaxed/simple;
	bh=QM7szHvzwJth3OelTiUDrqIld0K5QiUvs3TrWfWeR4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5P5Nl0AHk5Pafu1KrlQGPznFwgbkIk2cNZdTxrqeF2gKUfmesvjdaigmVK9XIHfxt0l9C/Gs3ZjXWpFpX7yyfNaTHAuPjcqnGCIoAuf1oL3RStleUnhgA4KW8nc+Vl2qOHI+kX6q5gjwcaW17d0PM8tSUmqyGbcJIP4xsmaiOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVrSDuic; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVrSDuic"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-885cf67963eso52918627b3.0
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 03:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792144959; cv=none;
        d=google.com; s=arc-20260327;
        b=GaQIEIZKrOK0wChuJRX8+pmzldE7iRzc3kDBlAiJOwD7X/PINpzek+JyJoqT6+SNwU
         2e25LKUFfDf/2Awn+PcxpgL4+sm/l0E1eY2lgziynyah6GuxFBd9gach+ZYJ4uSbprSb
         1fWWMRc3sDhdIUEoJTO0l1Da2ZQzm2JDAsD3cd4ayC80LrPIADnLXWJ8JzGxyly2gIyv
         hZqOS6hjPVwuKr5MrbhPtJhvDmRGglodkvFIOGR9oSjg8ZGGmOGieieFWKFjWyx2G+jh
         RQIOUAZzRSfdG8NEo2Xpx9JApPw9Xa6c65IS1aYl04/XfPi8UIwkdksJpwCg5/Iq3btj
         vpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U3OqCfqXVSgBFLEaio2H88IrwYlBEhtnBpp5SnKxAmY=;
        fh=iARkaIzCJcxoe2asD+wHHANHbue5FnCdLQ6A/NRR40I=;
        b=oaK/EQoom9iy6deOSDbHZwdA5uCOMmDlpV7hgNO/ZJVqlOYML6upwEQxsP7/jQpVEx
         szc040FRMcTRQkDfo0NzbkA1eJ7QwOEaFYp29Hsu6pSdJUlRuH14k3gMkJcBCgygjhmw
         7PAs+h3/wnGvDsGJvnbqJdppp4UERQqx5LR5GoknHgizV5J5ZEDNj70qRToMwFK5gTNW
         HA1/LnRXymxYFnqBgGsbVtpvmUt4Rzc5bDXQ2EGvewH9r1CTaX8hw80oA2dShOpL6Oof
         KFq4M8whWm5RVzZJtDpY9NDeLBg27r38nqh7KjNpvcilu3IBvgc1X/8dUU8ttgefDkE/
         xnbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792144959; x=1792749759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U3OqCfqXVSgBFLEaio2H88IrwYlBEhtnBpp5SnKxAmY=;
        b=jVrSDuicWZL8DBs9EFihJ5GUkBbSP0ZgJJG1qQ42hYgLUP4/sV3eAsgnykNmGPNWgh
         8w4RMJlabmrgE1ZL8pKr1SUX6Vxn1FHWKoFup1R0oPHXq0XayeCrZe8QM4verqjypYbb
         rxoTCJRz4a8J+75DqRQvUgSnJDBa0H3+WM0RxRopDpIiaz1hxh3o3JTAvdsD/byeDLyp
         WkDd8N8L98vU7PMhLeqrIhTH3FTggS+KZZ9Rr1ZnkyZNnWCVHmNCnbhHduG+p5mccMQ6
         FHhYSq95wjIAB8fwdaixvUAAtiCFJcZgcGu4OZs3g7QTjKfDavz1e813Ilea6Xzp4Dnu
         /vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144959; x=1792749759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U3OqCfqXVSgBFLEaio2H88IrwYlBEhtnBpp5SnKxAmY=;
        b=ZJd2qFpgOiLdQA98XGkCgCV6xd5XfdLIOFuXC4JyVh1GQ0t0gHoW4jiUsjFLEUpSQv
         I6DNWLpo1SuF87hh9VXpz5GVlls5GYau6JdvXQl22fNoO+AWzk2Zwmsvdqe3BvBdjby0
         8ENl9oET1DT1paAtWvSRnk5atw3d40mNsJFO4TvH7YbLH3w5CPLdkPAJ4MPu1WRIHTQo
         rQR6MW9FyESHpQSGGWSHQMXUQlgDhaq3rBJydnt0UyVu7WJhUv6fnAEWR/jDaBjKkrjQ
         nYs4BXIuBKDYviXIHCyOL6GwY+HDt6ozrMliGy/yUUjqkr7lJFCaOspQi2JzibVa6owt
         wFaA==
X-Gm-Message-State: AFq9FYJV6EQMzArR7I0J0jcw9CbBgmoLK/9Gl20E6obYgWRTJgOXTpRp
	QmgqtXBiISuGQtUgWo5zijqY530KjUIODkZP3wLRXkTKTdEAYyQSx9sxN2g2vd57dSrgLc47khZ
	drTVfcuIZLobtVhdZJtCWH4RPRfj39nG/aQ==
X-Gm-Gg: AYBFou30UXecb1APdbhCU7wFqV/uE939aHX6WqG34GR41Q9IssxZ5fVmiRgs9AL52KH
	gXmBkd3m+IAz7n/P7VnBF4YZ56iKcd1QcWhCbXKrF8hKw0cLLr9sYgTtsY0Cy+a1yDZSrYXhmpz
	sxV958CalfyAie6yVMRvcWG35bE7nSx9uuvIycytwrY6wSjg8WpEjoIWWgLIQg8oylOt1L2t9nY
	ftjJqVv14sTnSL1Sbblyy7+oLOYClSwXQsoI0z9O5YKea9v1dDt6YXN3N/4mewuzhKpv1xIURDe
	BiBJxGJ0M87fdUetrH8x/Kd2jbe0juD2QxtqAm2ZSISO7r/ur9YtwpxUMUl0OVY5sZ5HUGqOG3m
	39hqb3xG0
X-Received: by 2002:a05:690c:3489:b0:8b0:cc41:a124 with SMTP id
 00721157ae682-8b0cc41a429mr24907697b3.49.1792144959038; Fri, 16 Oct 2026
 03:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054535.844874-1-omosnacek@gmail.com>
In-Reply-To: <20261015054535.844874-1-omosnacek@gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Fri, 16 Oct 2026 12:02:26 +0200
X-Gm-Features: AclHuK8uRtQ4v5brTuG-YGl-0Y8QM-N9pQW8l7S94JDf2OA9JCER3RC3SeO1MVM
Message-ID: <CAAUqJDv9fqxqyomeOL7ZOEX3tquLcEvXV1e5AaRFYUHTDZ72ww@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/5] Misc CI fixes
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Oct 2026 at 07:45, Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.co=
m> wrote:
>
> This series works around/fixes four issues that are currently making the
> testsuite CI fail. The last patch additionally tweaks the Testing Farm
> settings to make the CI a bit faster.
>
> Ondrej Mosn=C3=A1=C4=8Dek (5):
>   tmt: raise duration of the prepare-system test to 10 minutes
>   nfs.sh: work around NFS hangs with nfs-utils 2.9+
>   tmt: rework sysadm_t testing
>   tmt: work around missing rule for sysadm_t
>   ci: disable guest setup in Testing Farm requests
>
>  .github/workflows/checks.yml |  2 ++
>  tmt/tests.fmf                | 47 +++++++++++++++++++++++++++++-------
>  tools/nfs.sh                 |  3 +++
>  3 files changed, 43 insertions(+), 9 deletions(-)
>
> --
> 2.54.0
>

Applied with Stephen's review comments incorporated. Thanks for the review!
