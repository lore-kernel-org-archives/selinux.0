Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA74E36FD
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614995; cv=pass; b=sRfAlc1WzRQ+ZxwAdT/s13TvUDaMkl4KI4rYywN/dKeMjcTFFVp7kN2a7IrPFAEYjMWZa3zFC60xheQ+KZazMP6VMm08hEkskpRRW1sKcFEsUYBTPaIGEqGowqAw8of86rDP+XRXRgdbK/CsXADdNzMpLrpk8GmABMdiB22ii7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614995; c=relaxed/simple;
	bh=xXwPcd9Lt1XBTnrwy6RIkt7nR0nzOi8J48hDe5cldO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gg8gEhIP552ngEP/h4AOKjuhI8QQQQbVg8jUht0A/98wQCc8lrAemdBiY3JARa7rEhH2AOwl6St9A55Vy6HbudeUOjTLxQm0ZeX28JBFe65hgkr9mbMZGs9y/ofoYYos5IZ+SR+O/AqkntotGwoEM+p5PIaxI+VlcANKr8L9uYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIPKyM3O; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIPKyM3O"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-8659af7454eso36796647b3.1
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 10:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790614993; cv=none;
        d=google.com; s=arc-20260327;
        b=R2pin+NmJ9GMylxML3781HpOTbdsUs5WZrwHt48gJN2CI2HqnVTxUB4N0Lv43dHW0Z
         n/GZP8/4pu5Unwm4USF+VEtmlphwb9knUln3J45yaNW/4Vbh6RmrwG/5pmVmIodW4YqO
         rmwd2KFR46Tv2J4CU9E/vFKhWAAmmfn7MwacN7HqCQc4tVbALyPBQ1h5L5xrMSGwZX9y
         eyhqttbUO/SVMQAb63Y8Pg+tQ2a1/j2oX6Y7YyKM0lcaxQ8Ql1wQb/85CZkjUG7Z77Ld
         t2NpMRifoeZ8PoVueW95Yl0m9eDN8EhAZCTTGBxSHXoNwQvz/LRPhh6w5+mx86urcMpm
         asaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gVD8W3Rwf26T55muyAgdwlEQZWXy2MxclXf8QvmDFWg=;
        fh=GeqWTLsnfVZPGHP2v677N5J61VqCgPXgsiNjnWFXa7w=;
        b=f8kOfjbwNtplBgYwUJ7VZIscLIQoJUL7OsZa9zF1Ud0t+BgKe1M3Q0JNzfIDbMRiA1
         xnb4fbYn0qWfBskBM3/L1Ve5S56jkwoiYug8dFfmRNWqZnUPXmZhEOpae6Sp85EhCI0a
         AMuxNiKT1rER2aE96FqCvjqkXjRcU7n1oOZ7KvaBKfzq+sa8yihCZfrcssu6SdDUKAmA
         FKzIlzQoBK1ouymX+7qZGdAal61BoOuzZeXr9aY7z0U/VXP3lIa+PgnO9ffxxFbvaSJD
         +4UI7yL7cuIL3BqE+j6OwGZnSAEW0/H/trGnTLDGjeIUOivVQ07oMiovLbM3h4E8V9Gx
         XgzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790614993; x=1791219793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gVD8W3Rwf26T55muyAgdwlEQZWXy2MxclXf8QvmDFWg=;
        b=FIPKyM3OoE+xNse4fuN4rV2EnmRZovDChgGqIFBez7g5pXvNhUepE7mYIbBMyVsE66
         jTLXylR2wejwnYPa7FtZyYVtikipmyMRKP+74shV3rTNyWdFk26QLVVeacT/eierp23X
         nbztRV5zI574uaw4PuNmBmvKcJ2QZkX6cUup/9lYjwEa7FOEq6YsKnwBg2FiYLlyx1lc
         Qx18eJVEYGImiRtH4JnuEG7C/UDJkVvyPzfUZIr/GabKycmWy6xqeNitgMJdTfhgv+DY
         6EK15FlGQxNrl+BNTFVB+GyxYUgl9uHvkx21I1Gd4DpJ5AWprjs0xy88fOWHqB5QaeH6
         lJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614993; x=1791219793;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gVD8W3Rwf26T55muyAgdwlEQZWXy2MxclXf8QvmDFWg=;
        b=eszeyGO8cREtegtArQn9yXwWL3PWeNmJ8JbmN1DsxKmpWaH6VaJiyjOX8zZ6zNHgm4
         FoXCdof9igdVPjq8C1RR/cwCEqjCZGcovLPlaWu8cbrWj0vehFdIkyW9uluYGhUqGeLl
         uyewSk9YEhSZAcykckRM5C55+S5+xkUHn/e+2RHBNYAn04SKDhA6MIh7UB/X89oRS4RD
         XKTEbUehUl/gbeMBZStAX++79o/+phJRjV+w/EpJ5ys/ZUzBXyBFxU/3ou0byuywHbGJ
         49oS3Hfp79hLr8aM1QFfkzcG6RBMy+PnRu4zlqVK675/v8ZdGP8ikQifndIP8wknAoQx
         efMw==
X-Gm-Message-State: AFq9FYLrkaR3kdSHqPMWApTY5UfqToTkzd/ebHFE+kk6JdC/QZ2YpFqA
	E2LEU5GcrpRsc/At4Jm0pJdagds6tMyoX4JxHzbb4g/zyej1lukSovNIMG3pAQaFXb+vnUbx7SW
	UGGTlPS7Hj9x6nqhae0578uAyjTfzvZI=
X-Gm-Gg: AYBFou2iZsy8A4aTCFyqKcqQhNDzMt2RPiWC/AoDRBwh8O1yRIal8WnqrXDoNcOBUGJ
	CQ2Rrz0NUYrW+f6qbJH5MPMC85Ol4TzgO0E6cg8YpBrjz5ztfckA3qhg5hZLJG/FzKc9S1V08TR
	pZf1BxopHaZNjmHuOfB2CkA3Ob4QK1N1awduxg4JeSg5lh08BAhb3WodhmsD64imC3XNVO2gjBO
	onOURz3HJF3UIvwyHgnC3PJj0+1LjgRdue7Nx/i2j8MJJIc//N1gsbSsbNO+j9Tecy0EmTxWj98
	5S7/WXHEbadh3324cpaWE+FTLsW34D3EiPzTJl5/ivrnPmYXWOFR//8R
X-Received: by 2002:a05:690c:a794:b0:8aa:148:7706 with SMTP id
 00721157ae682-8aa01488142mr18268267b3.8.1790614992511; Mon, 28 Sep 2026
 10:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 13:03:01 -0400
X-Gm-Features: AclHuK_IfriPKtURdw6vrByCM75YqrqNeew0P8Bh4XjTlEuVX_m3fBtagbtjixk
Message-ID: <CAEjxPJ6duYMpUJW8NV_tYfuL_UePPKF3Ct7n2Y_U+KfQ3twhCQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] defconfig: update for current kernels
To: cgzones@googlemail.com, Paul Moore <paul@paul-moore.com>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:58=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Several options have been removed from the kernel or no longer take
> effect, so parts of the testsuite silently end up not being configured:
>
> * Drop options that no longer exist: INET_XFRM_MODE_TRANSPORT,
>   INET6_XFRM_MODE_TRANSPORT, EXT3_FS_SECURITY, XFS_SECURITY, ANDROID,
>   KEYS_COMPAT and NFS_V4_1.
> * SMC now depends on DIBS, and SMC_LO has been replaced by DIBS_LO.
>   Without DIBS the SMC socket tests are not configured at all.
> * CRYPTO_USER_API cannot be selected directly; enable it via
>   CRYPTO_USER_API_HASH for the AF_ALG socket tests.
> * IP_NF_SECURITY and NETFILTER_XT_MATCH_MULTIPORT need
>   NETFILTER_ADVANCED, and the iptables security tables need the legacy
>   xtables options.  Also add NFT_COMPAT for iptables with the nf_tables
>   backend, and the nf_tables options used by nftables-load.
>
> Also add options required by existing tests that were missing: MPTCP,
> vsock loopback, user namespaces and checkpoint/restore, fanotify
> permission events, userfaultfd and the function tracer.
>
> Checked by merging into x86_64_defconfig: apart from the filesystem
> specific *_FS_SECURITY options, all requested options now end up in the
> resulting configuration.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2: avoid trailing comments, move them to the prior line

On this one I'd still like Paul or Ondrej to weigh in about whether we
should remove obsolete
Kconfig options from the selinux-testsuite defconfig or leave them for
building older kernels.
