Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F96228CB8
	for <selinux@vger.kernel.org>; Sat, 30 Aug 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563306; cv=none; b=Zc380RQzoQ5h/Tc800EF/Tc9k8IQW9FeUpwv73+gYUQ/z1VDW430v8JYn8uQBCqsbw/4Q4r3uDZaRhoRNt3NUGCJ0T/LsvoxZJYF2JgiSPHEC/s3iC4RYNh8ft1dYrHQDn92s1EkdQ7epwdoHdj+/HmNBcUImP3OvH1kk4aYK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563306; c=relaxed/simple;
	bh=KuCuDDtbZx5h6jDsIe6rWJMOFMPLouEnCPQ+GeEgm68=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BameplyM4c8nidK95fW3ByH3wtAVikCYjvadM6X8VSZFjxzz2Xp+3ML1WHe/DhfyUcNikHffLmveY0LHlrsH6Mkt9DST+pLb8p2NFhNSbrdytH3C/9Oz/LcCSmXbenWj3GtTfq6K1/RxqxQDw5a2Np7WYwGph5edLdwGb+YYgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MBobF58f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MBobF58f"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2487a60d649so34685305ad.2
        for <selinux@vger.kernel.org>; Sat, 30 Aug 2025 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563304; x=1757168104; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuNEhmGQmH8LY22b1eTjsCKfnCbGAYyebNq68E85dss=;
        b=MBobF58ficgNIc4oGrX19WVOGq6XLpZ8mh3kNK71TfrwdMap53XGAezhYuuypnEfQS
         6FexMpO4xuB1mVdLrLyyrAqCbIOauty20DTaXNgZhZNR+sw5C+RFK8NYqp3Oks1SLMSa
         8+P+kYFI+CCfQkAbMWU6m94Y84k+ntXZ+4MpDs5iZ0738PmdI1P7fKmxCb+nt/PEaQ8x
         V8LQAxvINYAlqLC2edlBjecg/ZIezwiXS1WP1a1V1/UiziUXUuHCOFsC43wdP150Td3B
         SqfKR0l7gJHVAZgfvYyUC847n0ZFZiuiITi9EbirCmdhtNgP81fS+0plKp1C1BScJ7Rf
         szBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563304; x=1757168104;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yuNEhmGQmH8LY22b1eTjsCKfnCbGAYyebNq68E85dss=;
        b=mj9LbOTvrJkYDhphBYg//zmqv5XFy4CqADdMGgaLf1675wIhAFV/F43lj0r8deAhRx
         5yABOJgI77z1vYmg2igYyfy+FkznJHI8Xucm1mu6SLAfbn/a575BR/o7+CJxLKmrPYsK
         MQ4MdC4DHz+8w8Ea1MYswZvpOt5ukoki2zlThVClMY/G6htis28b8yCn8PPvpFPgcfka
         dLiIE5frffvuo9AghhreAH9I5idzr6keX4eKA346z+0SAedexIjhxrOcIi4QYZlTGgkR
         wJSeEgQHCWodKCDGHt5o31Uc7gfwT5RGoR8g/bIrCTN/0lsJqVNdP63wSoSV4IwKrqbW
         rY5A==
X-Forwarded-Encrypted: i=1; AJvYcCWLekfX9BgIN5oDOomOTsqRqIiQUHVCKgX7wdh/vxnEKbZkYZrAdT44fgqB2Oye7P2T3QuInPA5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jiIlvgPpIYMAkhkN8V6oB/+n+sYtB9/n97iJdv3+FPrO8TuP
	T4zEdi4+mOZzkkhPNprqw3G3ldn9jtjehJx76jtbAMWlGKduSqTskVYLq+ifK4GmVw==
X-Gm-Gg: ASbGncshIvbwF4MtE9n1tEIXdDWlmyIH7vtDMzKSKYcBLmh7U8cMBzW0vvOnvihD4FF
	vcGqw2LfIxml9alka9dImyLWKDxT4bKGpe79NaMkX6BiG2+XElcr2zXFCb3Rl/FN+6HPMLBfxOz
	hAEgzrow66oUm8lxHjZNxgoBnDl5F7Oo02GBfsNxbPfrOHYIEiKooSXYoOAnLoyWImzIecCY1sV
	AyIo5i/9pn3M24xUs/f2/zTP4Qat1N8v8VheNvFwIqunhakChQ9Pg7Ig2IrLwUOJG9tER25FZZa
	Oi1AODTGaSafaZrPyavZBXi5axcg3xnSheVtWEh090UQ/F/kAQOxX7uFdjAaSxy7QLSeimaADfS
	dhcBdEjDzBiTddu450SXxYzjOGzHNo1R2Wno=
X-Google-Smtp-Source: AGHT+IFUA0BMN/ai3dblgX7nblxDAuW0oE4xAqPZKSyFbzHuCVTxFcaKqlDAd115j7vy2b6O2zjdFQ==
X-Received: by 2002:a17:903:19e8:b0:234:d292:be7a with SMTP id d9443c01a7336-249448803e6mr30907495ad.1.1756563304324;
        Sat, 30 Aug 2025 07:15:04 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-249065a8036sm54004145ad.129.2025.08.30.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:15:03 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:14:55 -0400
Message-ID: <808e70d5fe73e23bcf95bb445d2f91ef@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 2/4] LSM: security_lsmblob_to_secctx module selection
References: <20250816172859.6437-3-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-3-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h     |  6 ++++--
>  kernel/audit.c               |  4 ++--
>  kernel/auditsc.c             |  8 +++++---
>  net/netlabel/netlabel_user.c |  3 ++-
>  security/security.c          | 18 ++++++++++++++++--
>  5 files changed, 29 insertions(+), 10 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
