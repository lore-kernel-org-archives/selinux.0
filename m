Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B3034C98C
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610182; cv=pass; b=W9MVvMj6gZ/DkZGzyRi2klIJvc+rwD8pIRG6GxkSAxL3YiMCi1nlFLelnSZq5Lpu7tzy4bgaPt2hq3gmjbeZ1XYOzo+JWalR5263PaLITlM3XeI7LT7se5yxp1XZICqB672vpfef6QZrk7WEJn2wnr6Qi2zRlqF8wbPVHTtEz4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610182; c=relaxed/simple;
	bh=U2cdBtfeRLjOeAZQlJJO2bDbE6EC6/JN3pY6KZCa02Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5Wi1RmJH+7sqp3+P+o9jWdFz9FQoP/iG3WhH1rE5v3Fo9G2ahdJ+mdglleTeZGQQ6TCEhrcyS2ZykHzGJREGmkOiDQPmhf0DTfnpcVW5RmMVXHW0KV3Zfisdr1IihZNJ3b3W0lUnxM2yuUhwVrgxj2l+lWKC+8EpT0yJPKVXho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZGk9ymys; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZGk9ymys"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso30412615e9.3
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 08:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610179; cv=none;
        d=google.com; s=arc-20260327;
        b=hcE3UCprFjed6Y58wa71WEK3aXvLjs+kvFWRv2AURBLTsaYvAUIgDBzb97EwQ5UPS6
         EcNAem1nnpNDegqwj26/yrk1BQLko0EPgBdumNiXaaCv/N1HBKFbY20bfWjBmfbK5I4o
         dK0xluSoF/mlSrnGO8gXpPPt5FCEFNm68QfUvxL2lUyp+QIS/7GHvV3dUOTtSFYheOSo
         ZnwuX1Sp0YY1FzzF5G+gpXBREktQ+3twOvbWby4Neh++LgF4DlM4Gl6F+jciJdhS1UXR
         pkLmGLmKrZ6R/lf99jaucQHnnyIl8037yHbhIy3q/1Dipgz3GVlczp+0ExuoFM1alJLp
         wPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZtLGWyqYFqZYYGwFIDWClrjfdJEwEU1j//h6wMWJu4=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=Mfj6InaHaMS/I+YKGOoa0oaoZHdcBNxTRwLQQMpg3Zi+jDZ1aCva7ve7iKVcfWEheK
         R/eVbYqS1prsfDiGe++ogp9qfrC9wBAVPwKg3X2m/zl+TQ9pv8+er2O7aDEmlJw6AQbr
         iVea+Q61a8Nz/UG+PrRXgf7Zp/dSWOwwUF3ns4R2RGxy9DamWQK/TSANdD5L2uC/MBMm
         YEujOoK8hhnVI/A1lM4JfzS1pY9iHh1+WjRIPj//VGBgY9JTXWu0YhIIsw2hbD6uZKvB
         oQ0LMwrsgVYE6DQEG7IUSIDi/e/bAoJTuWoG+x3Zy/A8333F2zdPIeNm2P4It5PfCxCc
         /ulw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790610179; x=1791214979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IZtLGWyqYFqZYYGwFIDWClrjfdJEwEU1j//h6wMWJu4=;
        b=ZGk9ymysiX3beRXCQ/jacIjcVeopX5PpC4/aGDcvmaZHZfeltY2A5SElVRrJSgcQVu
         MyzchcZMnzJpDOUHfNrSRONen5eOkDUzi5RCTtkj7vPaNkeHpBmR7caP/3y3ANGJpxbl
         hIEiSFs4hFzveDH4gbrAIttl8hKCYX/htqzVFs0rFRyYKOqJkcSGIUBd5ARlS04oWoue
         h94OiLQvKk2JjLWpFndmx4NNTmwcY1Q6mIouvVOXxo5dnqdAlCd95eWDbsa4EqiEVgdi
         nSdmxbeEY7O7nYbv31C2Wp5bZNKFb+cy8s/b1nGtCm3y74TrRMJz2JExVBeaFY7Reknc
         BNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610179; x=1791214979;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZtLGWyqYFqZYYGwFIDWClrjfdJEwEU1j//h6wMWJu4=;
        b=yneEr26lMmFl3OqHLq//toQn52N3xFRAY0N2M72+hzOHwRXidltjc2YS+gwEKaQpAl
         p7ESzme+AaaWJ/prT5D/aKNqnWXD0MUdNyzh7oTrgNzMlmTiVkfad6O4ByqyVmOiopa9
         VAnx1VFFs1e+npU7W5HuCrXXT9OQ/+9tWY5qeSTcL8OXEKoG0W7iwJ5Yiry+0ri08iGw
         zkdvDhoqUNEdnm1A3NGTD/Ve+NJOqENf5Ta7gJzeE9XCJNLq2FnytoSj7AVpFMLX44rL
         fW72ikTgYT58Jgf2p/+Lh74aaaOdiXByj2kDsJ9ZEKteDgEGlHIqNNt/owe1maLsuHH9
         3nkQ==
X-Gm-Message-State: AFuF++mjbf1TWRdpQVzrJ1dM+hSYC8RDv1pLPbBopULbMRgD9NTmavmb
	tMKqr0T5zsvfhRbkU0eai9y8G+vjkPJx8gT2QXSjCN7GczGpGCWuPKnKrxa57m7TjmaQx0t/N4F
	xezN7l2Sr03hH9KMnn/JUBcl7Ts8NKKO6kwvs
X-Gm-Gg: AYBFou3VplRIAn6grZA0D/DBaG5uJkTS7oVkEsjyShGwuH0FMq5wHX7Scjof4cgRlw+
	rQsBtBmCuza7duhKF0zUVYoPWMYWKoqKS9DQV/qyJH4bxyLNLgZgSeWbAnYPRAtxgsPoJMRk251
	0Rtyc/2Y1VzBV/ICB5pydHcOqd87jHTT0F5TwpcEFipN4+TZ0pYnj2+UDsnAuSyFXqamYr8Wzf3
	lHD5SRulq3+2F3WFKA+TfSJDoI2OL3ri2TzAfaIBZvrTHgqBYIhKIQ4Ad5/+MHUdIye7xNOQV14
	iWKoT/b2Qu7Xcee9aakXjbPoEt+vcz2zrg3mNtpFsoeyV9vJ4SM2ii5W9I8+DHWos8mOtQ==
X-Received: by 2002:a05:600c:4705:b0:49f:dde2:3906 with SMTP id
 5b1f17b1804b1-49fe66d95f2mr236099475e9.15.1790610179085; Mon, 28 Sep 2026
 08:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
 <20260925171755.2029271-2-cgoettsche@seltendoof.de> <CAEjxPJ5oAD0NJFsL5XaZZktM8xsnkt71T=j9fmVXB_qsRkLnYg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5oAD0NJFsL5XaZZktM8xsnkt71T=j9fmVXB_qsRkLnYg@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 28 Sep 2026 17:42:47 +0200
X-Gm-Features: AclHuK-GGFUvaNcThptmzTclA0rbQ_3ja13KJsHL7IpwZU3I2EvPe0dZZEDSIjw
Message-ID: <CAJ2a_Dc2FxU9ZUm0m+awtabTcFgNT6ZYpY1YZSpPJV3L=roCew@mail.gmail.com>
Subject: Re: [PATCH 03/21] policy/test_cap_userns.te: allow searching /proc/sys/kernel
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Sept 2026 at 20:49, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 25, 2026 at 1:20=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > With Reference Policy, the checkpoint_restore test in cap_userns fails,
> > because test_cap2_userns_t cannot reach /proc/sys/kernel/ns_last_pid:
> >
> >   avc:  denied  { search } for  comm=3Dsh name=3Dkernel dev=3D"proc"
> >     scontext=3Dunconfined_u:unconfined_r:test_cap2_userns_t:s0-s0:c0.c1=
023
> >     tcontext=3Dsystem_u:object_r:sysctl_kernel_t:s0 tclass=3Ddir
> >
> > Reference Policy's kernel_rw_kernel_ns_lastpid_sysctl() only allows
> > searching proc_t and sysctl_t, but not the sysctl_kernel_t directory
> > containing the file.  Also allow reading the kernel sysctls, which
> > includes searching that directory.
>
> Isn't that a bug in refpolicy that should be fixed?

yes, see https://github.com/SELinuxProject/refpolicy/pull/1256.
will drop this patch from v2.

>
> >
> > Fixes: f24939e ("Add tests for checkpoint_restore in cap2_userns")
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Otherwise,
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
