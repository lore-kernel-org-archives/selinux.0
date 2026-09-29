Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C43B9D83
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698955; cv=pass; b=EfZTH5nBu52gtZPM3QoyULLFd4xaKoHmXnQgf0l/mYC3BGEXl/Xc5KnXv6hO8nNL5ahHPrgBL0ieG3KzYXGhcIQ/Jm4+5RuLvRAXS0AxOwAL8cYuf7JB9KTH9kjFjxVlhC/MzfrO7ar5tbS5EM9mMwN9n/3/ScF7SQyqGL6e49s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698955; c=relaxed/simple;
	bh=B+jU1IsHpQBC23kcHj5GZbpbdSASI/AyvWax3/B85EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epwrxZs6QB5uXEqMTlRYRG1Rdb2axxmS90Q15la+D17bg/wpDrUBZYXMD7Y18OczEKcFBD3ktCRt4FZUQjFikIIv5/OV3gn6zkP+VRvY5Vn3upW1Q0U3gmWTYDE03S7PmO2gla0xdP74NF7E0UZwLM43TV45IoF1PYL+j4/3J/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhEa7hpO; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhEa7hpO"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab42612328so10329337b3.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790698953; cv=none;
        d=google.com; s=arc-20260327;
        b=kSNNK+6B4oevKhFkUCKqqLjSWruqbWD/aFlei/nW2SHTHsdlUkJP73fmfG04JN4hg1
         Ss+QqYD1+o0p8e1arXb7uTbV4GtMLsfovNaF1rH2BBAKUpadby6pOVrgBDvPPPmkEwPV
         h9PlrhSeDO6G2qi1PYX6D+9WSx4G+AbpuUMoARTJa110madh3+8GsItxto6SOrk5nOKd
         k7QNA7/u3zV5M2wzZwHBREHSh7IVIy3GkdsipUV7BkSrdfscKi//gaA8wxZPXYhxVJJn
         KJqrJhwRabqF+z82Gtmpv3yN9AEQKCXsOyt9YXCpyutiDrrJZnaZt31EQ9XgsL/oyaAB
         oAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GwfG42ilXiMdMbwrWwVoscBkJOxOrGgFuegjxcjqyFY=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Wv9drwTsZ3lwynM3EfmpA2hFZRQ5pI0bY8xsr9zNjwrr3Iweg3vvDEYhLQa9DC3IYr
         zsqJfiAyyiZRS4D46tSESLu4/wyQsGYJmpvbSVdACjWri7hbeFqBnh4vK/YKc4ERqufY
         mm/26NATEw3tH59Ym4tsF8QiN28cshKHo7333r0CVUolW06ETs/1p4zl6V3DPnAMklv/
         emHDVESZLvLRAZSL/Qqniw+KQMkLDlQTV1naX7rvQLKpJOqX5eNNwX86HAVv7YhuI9BP
         BtG7kNb3KWjqO6AXP+MmxiLRGkqrhGUmyF0mUY8CF8ro6B3gwnqEuyQ13S4WtLbnamLs
         bziQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790698953; x=1791303753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GwfG42ilXiMdMbwrWwVoscBkJOxOrGgFuegjxcjqyFY=;
        b=fhEa7hpOgSwJnrrxSkLzz9v59/Ow7oVCRS40sDJ4hxKohyWEmi/XgfaTBSM9eTQtso
         AH9NhH2kv6AuiQTXJw7ZfVu6e8yujR4Rf4gtZTZM/EkwvfLBBbE0jw8l/Gi8ilH7/num
         ZUmsOdgJPWfCyki3CiYHvRl1awfIgmj3vzoSscRCMEMsfmApvY711EnqQrI2Kk5Pl4KY
         jEgUR2Wfo1c98f1Lq1VPcE0burBO1JmIYGQ4fnzolCMM47PpYkHlqmxZB5UFAJCATWoJ
         do1KN+MAgHhwNTaT6tCFY1geabD/UtainGc8bTvUuMDezxKKGDGzpHrHzPBP7c+LhPHS
         ptEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698953; x=1791303753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwfG42ilXiMdMbwrWwVoscBkJOxOrGgFuegjxcjqyFY=;
        b=T1ZkcBSsoTQNH96Q/d3HYyc7MS5Armgo5ANmmqn0YytZujq6Vll/mRVBIaQT9sbL4U
         3py3/I7mY+NbBGnCz1CzbVaf50BtejB+GytD4ejHgewhhyuayQY/9WQArM5JO0jraGF7
         elLPpFyhoR7+tpJj5I2+6MKNOiXHMgm0eKSfmsQM4vVmW5lhZOmq2rCemSdUWmUIvXkS
         l3K6bu/ROl6lutwl4FUPktdU/wj9vy3jzkhcIckCtHptWGYrqUcNT16slJv3N/P7Yh33
         eG3n9faul7fwuyC5uPfbL+Im36rZnLbBTcFRYSV/vyFoh7I9Lxx/vWVF6dmz9KqhwaeQ
         +M3g==
X-Gm-Message-State: AFq9FYLaKnjVojGCwBK/sRd0E62IASeJqm+LU3fmW7TG3Am2q7eaQhBI
	q00Igsl32rM3m8Loq0kblIhDnuWlGlUmpAKhksnMfRDSERHl8J8E8cqw65LzvG804/S3o9waMiT
	IfMbTvBSzAbNtWqaTQtlR/J03418LmKE=
X-Gm-Gg: AYBFou1LSz1CnUsJwnnmlkPd0CdF5BtONxvDr1O2kqGMMewbTAfd1Y1j15iLe4/PGSC
	j7Tuun0xoLkc8B5cI7K5K52A1ldCYn14n4MKtKQHHzwcHqE00mSlLS9TWPccRYdglBxIZNXnR9L
	lwEyH6RVvWxNAlzJjeXi4UiK0hIQdGjCnwyHhe45H85Srofg2EBco06f/6GfvU5BB/oQ+GchACU
	hn83ETKaxqqVR6Rz/zg5otGeSGBd/WhhT3oDUTcurSffyncX4bA8mfltGWEEE+sXFl84/tpCIB2
	IJH/XjK6iN9+TMlk0xev56+mLqnCg9BKSJMGF8+3QtbAplfmvN9U/kc=
X-Received: by 2002:a05:690c:4:b0:820:b01:9d6 with SMTP id 00721157ae682-8a64c343281mr60709397b3.11.1790698952695;
 Tue, 29 Sep 2026 09:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:22:21 -0400
X-Gm-Features: AclHuK-GYnNYdZKJ4Wju8OgsyGpPbMf6DZcCtD9eTCLUOkpYhQo4ZbHILnxsWYs
Message-ID: <CAEjxPJ63qi7C61P-xiC_zpSC7xS0_SPxN_N36Ng17CsPu=9FoA@mail.gmail.com>
Subject: Re: [PATCH v2 06/21] README.md: update the Debian dependencies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 10:59=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> libselinux1-dev has been renamed to libselinux-dev after Debian 13
> (trixie).  Also add packages providing tools used by the tests that are
> not pulled in by the listed ones: make, lksctp-tools (checksctp),
> keyutils (keyctl) and f2fs-tools (mkfs.f2fs, as in the Fedora list).
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
