Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63A79F5
	for <selinux@vger.kernel.org>; Sat,  6 Sep 2025 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124795; cv=none; b=KGcJHo6DAf8X2u9pwKP1M6zoZu83M1tz7sp/ve4yR6tQY0D0LiRXZLQchXzQohbrvWlZco/2xO9UkkqeoJKpleySYsXJWpSDxdjNa0n72WiWUotPkNbbP5JTu9A7Abget9N4Jy1RTpl2AHoDOrHkP3MToLdd/eqKmjzr+0E9wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124795; c=relaxed/simple;
	bh=9NrwfOPHgYRLFnDlIWX7EiOvZy0mIg0YZcKwWQhi2P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSz//BRNAhHpBggnX923vhDra3+uKiim8/zQr/sPxuYVKo/qXbemmzYk9ZCqQ7vt2QMkcmxnt5hN5Fmv9uLlIHfErF0rj3WaNyuSckSqAYW9OmIX5/cZLp1XgkT+ItNL7hqMuMUyIZv79Uktm7JtbssI2OzoZchbyubEyM+HBRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QkqSz0pY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QkqSz0pY"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b476c67c5easo1839047a12.0
        for <selinux@vger.kernel.org>; Fri, 05 Sep 2025 19:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757124793; x=1757729593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1pL8bTYf3cFMEJdozUvsUvrpDNfWNl6DypfSxz8EtE=;
        b=QkqSz0pYUXh3uXy9BExCY9H77/YCH9hyb7PKtbWbPaXSSvmLKLh8OTODHDqd6nr48G
         s4n6cRJG/YWxZ90xGBzPQc+QaFGc5N7C8R0cAOYz2HUGnRAb6WLqTMYxQ2sVHJ78d85k
         oD//AJcoA2LWNFhrv4K3KRoSJthxyCHHSAnP2UxLNsAF7r66ueK4vQjMa8o8+gPVSkkW
         wxlBvbH6p0EV1sNNzu3esI/+0EB0MjxiYCnvj0gBLEDSYFmLHy8Z/W6QeT4oqSL+TZRL
         hiOMT5vEGo/a6CS43UvE2G05f7/HH3TKRAwiblxgMw6SdQAVRZFMQZmnUjTlmUTctiEv
         rBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757124793; x=1757729593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1pL8bTYf3cFMEJdozUvsUvrpDNfWNl6DypfSxz8EtE=;
        b=p60Xvj50e19JaZQHdJMlTv7J8BqF6mKLyY6LBOurBDNxwb6rrbZpVJ+sHmuyFAILQR
         MEBxZDBFDwU9GZT94Z4bNk8FhzJS2QRt6XM+mHAJ9qbLrwLGuNi5KxzXGoyAfQWhsPJs
         IQ/A3cBa2As4U8jpLieVxeOiUv2ZdomZTZwRVgUlxaP5DXr4VF4dyqkRF/U3Ie+4zumK
         VsrgPgZlRme32bPUcrl/2efqoCyWGrUcZEj5XJ/4ygErWNrv8QB9BFhxf80dANK/3aLk
         I4zthZHmJiMQsYJsSnMoMa93mgS8NO+d9pCTC2aARYzZ1s5NEY8hMO3vnWMcEuHIyjLK
         KduQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9oI68HKWbjNUcAQ41lE7fNHmp/KQnb9T1hTC7B0f/GmQgnVbNXWDgw1OmcZwx5pu/oVDRqNGu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa8jPtlCMvxmo341Hsu0SSkIMtMeSAobnzEV3a/ATVBozWOa8x
	ryLVO4CTzopKZsqAog5Qt6sH3dNu8VDpGR2/TGFTs+Rl2Q9Y0S8nD0jTBet+xzRCFlk05O5t52i
	aH7Vb/ErAg4IN1FxgdZGSMFVeZmdgJZbgT2D63QjL
X-Gm-Gg: ASbGncsEgt9xOPWzewnEnMLRsgKNi8XUTutxjwxkwMCHUKIjXLoyDw30oNHJCAAnekC
	o3lBb65kwTH5L+swok1266Da5X2EZEFlVe1dzlqTh5G+MmWmrJR5/66GLjNZxKSEb7Mv5gK25B/
	X/1wLJ2A57uGxjCKm5/0JBgDK8Fh6j/V4CD2QfVdjVS4nvH1i0qGVj82NabyIBwt2kWM5npJASd
	6xdcoNiTu5t3li1xw==
X-Google-Smtp-Source: AGHT+IEi/myKnyBGcUaz9kKLmPHDx0tAAOxFqlYZaJrAtcZw0dRkAUN9iSOqdhe2KCACDOYK4usfLZF+9IEiHa8olEg=
X-Received: by 2002:a17:902:e885:b0:24e:e3bd:11a6 with SMTP id
 d9443c01a7336-24ee3bd127fmr34267895ad.23.1757124792885; Fri, 05 Sep 2025
 19:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905222656.3692837-1-nkapron@google.com>
In-Reply-To: <20250905222656.3692837-1-nkapron@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Sep 2025 22:13:01 -0400
X-Gm-Features: Ac12FXwqmqbrwtGWFiMzNcuv1t1UFv_o1QgH9SWzK_JphbAkEpScv8DY3Kh96yQ
Message-ID: <CAHC9VhT8NrsXMM-PPZJ0EPLxFHQ1vOu+ASCd+82Xth_mJPnDiA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix logic issue with per-file labeling for functionfs
To: Neill Kapron <nkapron@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	kernel-team@android.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:27=E2=80=AFPM Neill Kapron <nkapron@google.com> wr=
ote:
>
> This patch resolves a logic issue with selinux_set_mnt_opts when
> selinux_policycap_functionfs_seclabel is enabled. The issue was
> introduced between v1 and v2 of the original patchset.
>
> Fixes: 1b22454bb5e6 ("selinux: enable per-file labeling for functionfs")
> Signed-off-by: Neill Kapron <nkapron@google.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

With the original patch sitting at the top of the selinux/dev branch,
are you okay if I simply fixup the existing patch by adding the
missing '!'?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 333bb6cba25e..0e47b4bb8d40 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -745,7 +745,7 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
>             !strcmp(sb->s_type->name, "pstore") ||
>             !strcmp(sb->s_type->name, "securityfs") ||
>             (selinux_policycap_functionfs_seclabel() &&
> -            strcmp(sb->s_type->name, "functionfs")))
> +            !strcmp(sb->s_type->name, "functionfs")))
>                 sbsec->flags |=3D SE_SBGENFS;
>
>         if (!strcmp(sb->s_type->name, "sysfs") ||
> --
> 2.51.0.355.g5224444f11-goog

--=20
paul-moore.com
