Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264C35838E
	for <selinux@vger.kernel.org>; Tue, 24 Mar 2026 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387883; cv=pass; b=KSC4leJixNU7oIOTvhH+6S//JAY7Xtc2m+VPw23GBju2IWFCbf2aFlk6RVHi+KKWJ7rpnVucAm0Vd0TYCi5RQkOTqe/yXbrpKcCbCu0LI43If6USHbTK2TsyBQRTLuNinp/7cbTsbD263289HMrsoZREn9YlVHvF2Xyg3e6LLxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387883; c=relaxed/simple;
	bh=Hm1dR7au5P+e5JwWReyx1Mro5MQiz3tvFOVbs+Mlmm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5UEwU+p8VlzXVka0ryTHlsrJkCFLYPxv6taqWK8EA+0boiW32XWKLQXQAjEPQU/TEORWAxQyYrCnMs/L+gVXwOdf8vBMjpM3HtPFPr+C9I52WZSdC2CMHwXVUxcn1EwM27yrP4BYGtbeo6SEf4SVy8EEXntGpmnWPR2plecYws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R6nGHowX; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R6nGHowX"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a02f3b8feso2487041a91.3
        for <selinux@vger.kernel.org>; Tue, 24 Mar 2026 14:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774387882; cv=none;
        d=google.com; s=arc-20240605;
        b=kClwol9orrDvAfecRa55obn6r0rQgd1mpY4FGpgd0ZsrzII+3zwBABawA0YFR+r/ng
         nzmcI+JSN8mLxj7Egk3Zx4WETopNs7kPPal12d3crX5waznJGhPk7NWEE+wr+AC7Xvbs
         4nKwFPU6ETufisLFH43fA/emDKPUNJoOu+pWElwZO+tMLA3G1J/vAG5EClN1FeWpwBjp
         yNne9+9OsMjq9tdiikqr87hR/2zL5ZH9L6MW8IufGpa3gvJ8rajs3c8Mz/65CVtN/Ogf
         xpQkQ+REgCR6uCETyAdXWkmvduvxOfft77ETs7GCj7Ax5MBJleTb42U1pxxb9G8+d1p/
         6S2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=01YkIR3aFC7r0WNhjXFTgr1gQLf1wkJY5iRpaT1roY0=;
        fh=GFUdBsmGrK/HQaaSmfbx8LOMgen4ZSpyaXuj/XO2DRE=;
        b=jC32miXhd8x9GO+OpgwgmFXw1dTpyEfM4IuuOuQ1wNLZ87ipRProGL5zzzFJnk0+c+
         zPRpv1Lx8C+PEWdjoX3X+HsqpGVTT01gPX2l20qeyFqPQg0HqRfXoT+DAssKjeILKgQd
         mvtZhzTcC/Vu9wVNppQTajjMTIRw8jy/3k4AbRfKcMDKxFelMXXjkj+0zkHi2JQz+wOM
         BsFZJfwo+/k+9AMN9wTuEc6ia6WgU8P+zhzxZIxVegS2VYKlYLrh3t9gzZQBgd6H6ZGZ
         mtp38BCEpqqFNlyfYuQmVEdEvcDVgOMISUOn0/3J67MElMKah67zcEC8zX/bc0BUzewr
         NvJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774387882; x=1774992682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01YkIR3aFC7r0WNhjXFTgr1gQLf1wkJY5iRpaT1roY0=;
        b=R6nGHowXrV/VFdDdZZHkvCArA8xsiK1p/ZFxBbWTOq+1vZ1Ju0MVXBMa3mOiDFvxby
         AQKDFvtu0zZy1rrtn46+48AmCAYudWLK0GPJL52HIy0hY00sEuCSquViVVPx2pc7f94l
         ZmURWk9QE4FaCIk5x0PzGXiGucd6kFAikpZb3cJPDcvqJBQFxU3Tdj1aARtwFul1O+75
         5RlaWxn1BWmGeXb/7upUOHR2JTa7OvIj1BiaU6PDyjENYtX8+Zk/kv8s+X72CRyfjZYy
         iGHDPJ+4Y8G/Pi7NlIh5ziIyxrlHt7OxSZi4Jm+X0ExQo5PS9QvXdDDcvaVAL1AgfWWG
         cPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774387882; x=1774992682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01YkIR3aFC7r0WNhjXFTgr1gQLf1wkJY5iRpaT1roY0=;
        b=Z+k+udJMeZ6MX0gC+7klD5CChUq9IvTJ50RpNNTgJ5JTUI50Oc3FyQIped+/fepdJN
         yRVIu8HTcjQsnXtPTc51z9Gw2j+a60HvVM+TCmajFuL0AKkb3qQqzsjkDeYFWdrvwKJ9
         x079V2vKkYyqOkPIKtyoELzo66mSIXpeZOFxOWppUCTgdgIp1PLzlQnzws7dKI1laZUB
         /jvPh/BBovnUkJQxT7X9qfeDKp+o/ir4QCDLwPquKaKFrR270BDAClXXe6tEVnWCn/pZ
         x4vPt+GAiXO9eun4yJegn8eEU7nwSLsJ0objMHFPtVoDcPKLt4JYa3ZMfV+fStLjW0ws
         qPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7XfP5c117SKgM0eOhKgtYGF81O0kq1t9IQyEFeAmbAv5F67AQ4o72L8km+Wm+cxQMxUH5RQii@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8p3Bt0ACD/6Gg/AkCtW4xrrCYKAoiV5+YrN7NcNoFaG38G5J1
	EwEw/HDcB5Ffm/b+0KkE+3fNKcHKAd9hvIQkcMvcUajtVzSCQwiPD98/aKKcLiApsEiOaqV3fuc
	0FS3L46T8Q6uA5209XSqs2lt/zjux6NeguEwqJ/cW
X-Gm-Gg: ATEYQzzNb0NfKSKvJFoZbL5tXLCaVI37njPe0vB5u+crERNOgD1Uh5o7iR1LbWX4tF9
	bXCO1tsJFoMCB+bBwJIcvV1/Mo/Rg4h6EEEqU53We2AtxRLfNIPWHDAlpQ6DyI1RIYqCpZ/+cxt
	YZZGhST/fXbQ6EOzIHPOO5T1x1SE9p0KgM4rCFozLN+RRX+nfMioMxi58gmm5WVDV94TKcTask+
	qlsTNUxqCTduLFTPWL4M1CP/v1qo2lIzkamAlKoem0wY5sU3Oczy4hIFBke18H9uJFM8q/3MMz9
	UjneJrg=
X-Received: by 2002:a17:90a:fc45:b0:35b:e51b:1936 with SMTP id
 98e67ed59e1d1-35c0ddb20cfmr766067a91.16.1774387881757; Tue, 24 Mar 2026
 14:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com> <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
In-Reply-To: <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Mar 2026 17:31:09 -0400
X-Gm-Features: AaiRm51f402GZXFLfjQp9lpoOMUGhMYulpZL258uSDKKLIGIRxrcxNY2DsM4x1g
Message-ID: <CAHC9VhRgi8_gdx0nKwkOws1VD6EFG+bHNTN5Q8YCxZ3HOCu5PQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 11:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I'd really like to hear from some of the other LSMs before we start
> diving into the code.  It may sound funny, but from my perspective
> doing the work to get the API definition "right" is far more important
> than implementing it.

It's been three weeks now, and I haven't seen any strong arguments for
supporting the clone() API at this time, so we can leave that out for
now and stick with just the unshare() API for an initial attempt.  We
can always add a clone() API at a later date if needed; going small
and expanding over time is usually a better decision anyway.

So to quickly summarize, here is where I think the discussion landed:

* Implement the lsm_unshare() syscall

I expect it would look something like 'lsm_unshare(struct lsm_ctx
*ctx, u32 size, u32 flags)' with @ctx specifying the particular LSM
being unshared, and @flags being 0/unused at this point in time
(unless we can think of something we want to specify here).  Like
lsm_set_self_attr(), only one @ctx can be specified at a time, so you
can only unshare one LSM at a time.

* Implement /proc/pid/ns/lsm and setns(CLONE_NEWLSM)

As discussed previously, this allows us to move a process into an
existing, established LSM namespace set.  The caller cannot
selectively choose which individual LSM namespaces they join from the
given LSM namespace set, they receive the same LSM namespace
configuration as the target process.

Any comments, corrections, etc.?  If not, if someone wants to send me
a patch{set} implementing these changes we can merge them into
lsm/dev-staging until we have a LSM which implements support for the
new API.

--=20
paul-moore.com
