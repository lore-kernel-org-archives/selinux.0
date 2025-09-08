Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1F79DA
	for <selinux@vger.kernel.org>; Mon,  8 Sep 2025 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293714; cv=none; b=RjxMOgjLqgr0c55fmaWMF6k0faHanFOwcW7XM08x5PXXK7nhXUHH8/mOxqV1L6sseIicf8p8sZ/xe03af6UJbU2LEa3mPoYkWy2ya1BmfTX0ngYWrJyd08ZjApzvUKZPWTbEy0qK0VquwaAnJ5ao6h9h7PZz9h5FUIWbyStBR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293714; c=relaxed/simple;
	bh=dcTHWeC8QncDPL2EeofbWQ4zwx90vxy57HeJd1rlNc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntemmwRj64UjB7N4CgvE/YzZzYBlhpkhhTXRmD80oSGYOok1qgtqNXDWoECnCFYfxawiikzd5E9MdJzZZJUcedDR00AgwaxWE9Pc7VxlZfRVxrvTOEQ7Y/DznJ2wtc5TBucngKxNx76FeKGyY5o1HjWizWjqt4Rhom+pDm/yR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M03Jwoh6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M03Jwoh6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24c89867a17so36382825ad.1
        for <selinux@vger.kernel.org>; Sun, 07 Sep 2025 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757293711; x=1757898511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCby98fuHykeF9/gIJ4wJ1zBkioxK2Pnyqoe8ZEv4HM=;
        b=M03Jwoh6NfEc12jdGDdv0x80hRkJj/wAzmveuZBSqXf7fBoIjMSrtYttOLP5pqRw23
         CkJEQwxwPIZKr+H2KDMnewAItDIt+UU/YFRvJESQPtY6rt+pyAVvCFE9aGy3fpjK/CEs
         1UPHW3JKrbmn6IWmfLp/nwpd8fUgvZIlLBXetLMVEx2N9WlTCoq7dsNFMBgf9NHaoks6
         c9CK6C1DzV0V+30YiEINEZo8h/B5Lno6v7vmRlJ+6vFxJB9puWYtrFyjKKqbaTxAS6yd
         ciVRgVuLZsIKeXiGiEVsoKkL15d5ZKNvTTkh6sdeZxTA96ytjPVZVzcuTmQoj/99g0px
         PgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757293711; x=1757898511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCby98fuHykeF9/gIJ4wJ1zBkioxK2Pnyqoe8ZEv4HM=;
        b=FosGwz4biV9QGALAQRAoEJSlviJVgRgPY3IXpcisETTxwsnlPRqxp5vMAKuePCafL5
         d/g+O1CoTM1I1gamCV3cVbxKLUsWbih46kNVidOUg6fUAmOMha0NJUEWhHGtChS66D89
         MuMurpofqhxOlVBpg6/iMmCStW3UFr7wRPOMYA8CsY88jgjxMrL7544b+OUNu1WVdmKQ
         ffr/67TbVIeySlsiJ/LidR2y5YIjy6VmkQE/yP7hhfWO2M6KO8Y5IatJAGCm50GX/Sfo
         7QgQjXtvhOg0HbgGwLUJybjvOdErrWJ7uVhz9A6m852xHqrowMpjA+TI8XeCro9/30c1
         lFtg==
X-Forwarded-Encrypted: i=1; AJvYcCV/u8ip/oSEQQ+x/FRqQOiH6rXtKrZtDPM+9szAWO2YXpMoeZ0ffQIQPx1CM9xSl6n8mypkJWcn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+auw0PhTRBF4v+Y1UMrr4mFsqUOvthZ2EHYZ7sH4jByblc5to
	z43QZpJOB95RZ/qpt4/YRsYh2wcmQbY0Icf1k9Tq0xIkG/IpeOB+HiekWJqwPKWwy6+VIXAaoIv
	r/wJe6jKPrnBdIf9bgdp3oAj1qH//hk+70LKP5NdK
X-Gm-Gg: ASbGncuFZjvYLTQsCry85B7aKvOuEg2RKtVEZpTgAC5Wec11F3/UTTM4WI+bib1fFZc
	NWTvGazCS2f4+T8EacSTDenje03wkGTPqJ1sboImJXvk5WAKkZD85p/6VpyHq5/3lt31PoNklZ2
	fxYsD/NnetjXk2BxkuVaOYSal7vCHu1/g/bPlsSWVhIAEfhot5ud2uyhmH1PWmgI6knhfBNsgAI
	TOz+fNbYMqnKNDhruFgYhCTjtp3
X-Google-Smtp-Source: AGHT+IHOMpUmUGvARznOaHD6cjYr8eVlW646Pw9KSgkliNtnjdUIH/ScSsfYujUC7X5+4fGLUufMT9jln/j7XHfC6WI=
X-Received: by 2002:a17:902:e802:b0:24b:1625:5fa5 with SMTP id
 d9443c01a7336-2516d33edd9mr102319205ad.11.1757293711530; Sun, 07 Sep 2025
 18:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com>
 <20250902125457.2689519-1-roberto.sassu@huaweicloud.com> <82f22f97486622408bec772a9b025e301c8fa2f4.camel@linux.ibm.com>
In-Reply-To: <82f22f97486622408bec772a9b025e301c8fa2f4.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 7 Sep 2025 21:08:19 -0400
X-Gm-Features: Ac12FXwoV7fb06gH8Z5E4U6UlqLB13nK6Eu7J_q-p88Bs4R0h8-YzVl3W09F4Js
Message-ID: <CAHC9VhTGAcMTXHReinybpLzer7seCN+NUTHcFte+aU2oRNtNNg@mail.gmail.com>
Subject: Re: [PATCH] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, john.johansen@canonical.com, wufan@kernel.org, 
	mic@digikod.net, kees@kernel.org, mortonm@chromium.org, 
	casey@schaufler-ca.com, penguin-kernel@i-love.sakura.ne.jp, 
	nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 5:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
>
> On Tue, 2025-09-02 at 14:54 +0200, Roberto Sassu wrote:
> > From: Paul Moore <paul@paul-moore.com>
>
> Remove above ...
>
> >
> > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> > evm_init_secfs(), to work around the fact that there is no "integrity" =
LSM,
> > and introduced integrity_fs_fini() to remove the integrity directory, i=
f
> > empty. Both integrity_fs_init() and integrity_fs_fini() support the
> > scenario of being called by both the IMA and EVM LSMs.
> >
> > It is worth mentioning that this patch does not touch any of the
> > "platform certs" code that lives in the security/integrity/platform_cer=
ts
> > directory as the IMA/EVM maintainers have assured me that this code is
> > unrelated to IMA/EVM, despite the location, and will be moved to a more
>
> This wording "unrelated to IMA/EVM" was taken from Paul's patch descripti=
on, but
> needs to be tweaked.  Please refer to my comment on Paul's patch.

Minim, Roberto, would both of you be okay if I changed the second
paragraph to read as follows:

"This patch does not touch any of the platform certificate code that
lives under the security/integrity/platform_certs directory as the
IMA/EVM developers would prefer to address that in a future patchset."

> > relevant subsystem in the future.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>, but not yet tested.

--=20
paul-moore.com
