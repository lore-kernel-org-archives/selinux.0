Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E62E401
	for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597015; cv=none; b=h2R9ei6EQBbGGBntqoqZ42PaA+Suqg8/1EDy7/Byl7ZVEohoKA+2GqwvIZrKikMEvaTC7orzQVZIBSa5RnqN9TiBst1PBDAogevQktDJeeVsvIaGIFw9dRvXSHOIe7wAFnAXEN9l5wzpPzhqTHiCPkthGo0/UaVr26qcd4PcGnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597015; c=relaxed/simple;
	bh=ILd6AoO/Vzfm3lniJYA7jVJUimFQ42DfyFd54iH4owU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWXTGvLtG8D2xQJc06E9wruRayH2Xx4KBvOFNGm/bjqUqyt/AiXZwQmPiJIDBUtJoVzm8QLspdkTHTh5ZW7SnBaa9jPxSEPf/5dCbzMFfWiKilcvTMNjjvGcBUZBn0pkn9UV3TOdieg+eqYF8ZVkMwFxNt2VXsEAPvV2PX2Yz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no7dR/aj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no7dR/aj"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32d3e17d925so634877a91.2
        for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757597013; x=1758201813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6ymZmvGcwqVr201+2/9iequakcC0qkHxj9+m5M5hyk=;
        b=no7dR/ajyEqr2Cujqm/+FdnOe+CbLO94yZrTdm6jd+Auz+XpqXHkdlWgzC1ayiydoh
         sCZCf04C3OsyVDzWEmUs9cyqV7i848MOkoI6bPBVeWJNpA2mfcsKfqVndw5lzOT8JQGv
         sxFAH5wiAPAXIKer4ptLR5Lk+MhBgUd35oPNI5CS94VkHWxJiX8yCkKzt6k0hGakfQbY
         fyb/mEZvWELvxK8ipS5Y7yh6bdUJwWP8csQs0EkJdwtIZY2MBjxs7Qm0GIl2tFFwSbzV
         DEOgV3ktmjJbtBq1JooJ/HKsBykBWqNeFsrlWRTeC5IJ5kyT2WfMbCpHNo5hJaVSzSNA
         d2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597013; x=1758201813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6ymZmvGcwqVr201+2/9iequakcC0qkHxj9+m5M5hyk=;
        b=P2H5w56Jxr8wcJ2/Z4SjvH3/Pya590gDnTkCbNs/NHXTC0alSAUzh8ADyWbLU93vgg
         38dWn2OcPPEVsmckf+doBTN3Rl8A941Kei3YBSDGGoIRbH5ilaJbwHS159oE5wWdlEZ7
         pqGX+1zuLEVVv/qEKnqqHtc1NE10N/I+EXO+QUIuLxe/AW3Loz/1wf+dtiMmUjhLb9yG
         4EiT6dQxZXwjRUwXGM59iSHKpAosqckiWN6E30Zfyq4QTqbnzvJJZlpcNfEif15joH36
         uTgHCAUtpW5u8hnszjK3sDF0dVH962zPW8K01V2kdMnKO2+YDbzSIJEbfgJuBiY2Ahes
         jF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwfG0ssiw6GlQDxl+L8yPoBGyvz2s16NeUNUY+N3Mmp3OzDf1lptRwcSjkE/FP2WEapJNavgJP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61GYy7q7G7NIrAP3rRhz0qoe82vqwLuyHwLQ/GM+n0+k9T0VD
	QGlUcXCLKsustA/orhwJLy6OmbcSrerbCjVZhFQmGj8nY2XPUQ4lbt9/sGFkfxpITC5n11vLSXd
	px9s0ifz6Amv3VRpdy3BisWaoIl1xp2o=
X-Gm-Gg: ASbGncvnirM1W/hNdvP1P1ZRIq48yxMAmBItGqhY03rLsC4Dj+7HmQ4571p0ywGBDCA
	Q1w7AmrMT94rpIsTzqWdp0LqdbLU+2ZfBeT8229uiurP6fC7rlkSLM4o3iE9CBw5we4mE12tWyH
	+FvZSAiGPOfG1mvfDOPDgtJNvVoRuVP12osDzmsoAI8X0hH7h3k+iWQ5ikO7bx20az4OW0gBZ+Q
	QPUnt4N+p5bcXIbikBNhaKrTfBH
X-Google-Smtp-Source: AGHT+IE0fCHUJBZyLWfLL6NHxo0c1V0gVO6H2lI8rIpZlNULNyRYtxb1MghxXTwxbDrWyEB+kS+XLAcH2klufL8f6Zw=
X-Received: by 2002:a17:90b:1802:b0:32b:ca6f:1231 with SMTP id
 98e67ed59e1d1-32d43f05005mr22897820a91.1.1757597013058; Thu, 11 Sep 2025
 06:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4-+WfGPLev5QU_+_NgBx68zdBBQ6x_+aonzbk4f9BNEw@mail.gmail.com>
 <20250911130653.967139-1-zhanghongru@xiaomi.com>
In-Reply-To: <20250911130653.967139-1-zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Sep 2025 09:23:21 -0400
X-Gm-Features: Ac12FXxczdBxkZ0DHcWwMtzZjg9qMvci9_-8tA8VfmWk7TD-1Qaz5Ek7HY0P9Ho
Message-ID: <CAEjxPJ6upN5e7XD9HC970pKvHox-qPjZLdzm=bV-tu8GgFrYoA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:07=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
>
> > >  static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
> > >  {
> > > -       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - =
1);
> > > +       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - =
1);
> >
> > If you are making the number of buckets adjustable, you should also
> > change the hash function to better deal with multiple numbers of
>
> Thank you for the advice. When running the test model, I sampled
> /sys/fs/selinux/avc/hash_stats once per second for a total of 1800 times
> and analyzed the distribution uniformity of the hash algorithm using the
> sampled data.
>
> Baseline: 512 nodes, 512 buckets
> Comparison: 8192 nodes, 8192 buckets
>
> Metrics (Average value over 1800 samples):
> * Bucket utilization rate (higher -> better, same chain length assumed)
>         * Baseline: 52.5%
>         * Comparison: 49.5%
> * Max chain length (lower -> better, positive correlation with worst-case=
 latency)
>         * Baseline: 7.5
>         * Comparison: 11.4
>
> Experimental results show that scaling buckets and nodes from 512 to 8192=
:
> 1. The distribution uniformity under the current hash algorithm does not
> degrade significantly;
> 2. The maximum chain length rise significantly, potentially degrading
> worst-case performance (ignoring other code in avc_search_node function).
>
> Details:
> url: https://gist.github.com/zhr250/cb7ebca61ff5455098082677d75b1795
>
> I will modify the hash algorithm in the avc_hash function and collect dat=
a
> again to see if we can achieve performance improvements.

If you look elsewhere in the SELinux code, you'll see that others have
been converting other hash tables to using the jhash functions, so may
want to try those here too.
