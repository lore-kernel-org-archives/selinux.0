Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A42F12B3
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778110992; cv=none; b=Wp1DDzowZ60CE4mDPZP3gtaJ/MlRIp0YyfVE9Zl0mr0LVqIMQTn6xEk1RHIH3/XT0jzuy6tmoeC6S8bcLnz8r+z2XH3gud6m3Mhw9mB7ixsFiiTZIlygXt1XINUb0Qxh2h6e9duVd86RSlfzfA4zRtmoh3hVNa/rKIGgQ/ZL9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778110992; c=relaxed/simple;
	bh=ko0FE6HN3JOBBmuOOUgRR1lm2/IqV6g59OTO56IiY6w=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=UycGBXWL1SQ6VA5dJnJzh5xjsFM6BgUrGjtv68MjHMwfFCD6TuXn6weyvgMermj4QnO/9yWQ0HIZmiiKyo0LT/yABX+dmrTvyw8BkuplvK6nWjpmPbKOXtv1uBiPNP7ewnFI5qXRPmL/HqdpbW/As8tAair43LXzl9AjDrJUNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TlntH8Ue; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TlntH8Ue"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so13124956d6.0
        for <selinux@vger.kernel.org>; Wed, 06 May 2026 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778110989; x=1778715789; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Vx1BzAfJicIj4c2bHfx83kwqOK78RnIoPZQfJ0g0KI=;
        b=TlntH8Ue5R0J0sxOkIbXY0zg2ijgwV4wDQjK4g9JZAFRNrYxxN3rajCnLK53jQD6SI
         LarPvtNhnhV7Wu/DroSsmKeSvQdLyNDL+UIkUYrzas0+eHDgHqByELvXRuNB1d6nuh8I
         6sp+BGEBmJPPawyo5jAJ1xGXAbENbxu3P0W2zTMBhvDl/weMasdC7W86syNY4VQ1ajoh
         dmyQsHH6RcBtYgWT7l3IcqJ+2bTGx8uh+5LxTUjgLbZ1rj/El6uRUZPYMQy/1YP/zh7F
         yjlleAg8CBmd9A+HgoQJp7nN0+mlZA6Wzlsk0x2C4aHXGH/0up30/vTokwd7Eu0esgEV
         Imeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778110989; x=1778715789;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Vx1BzAfJicIj4c2bHfx83kwqOK78RnIoPZQfJ0g0KI=;
        b=frCtTtfDC7rDpClVns8+XNEpURew4S+62+z/1gxlofYsQ4BGUBn9huy0oeJLfV5N1J
         CYr8LC9X4PzBeEIjiG18b8k73+n4OnB5fbGMbQlTYK1z16pGsvSbLixpCcmmP5EEGKN4
         AIr3x5CGPrVbK3NVnnT5LJdrkQ6KQbNK9G+vs3+UnEMYexUy9Ad9dIWtiBODltojBvM+
         dbdW4FFsOxE7JmGxXP+0qLfkw/SO9ygpWIiRu5OIrZ5euFp/vTBF+3Q0ttMXz44uYdh2
         /6TOFcXWwFq6Y+3vjCJIltBd7fMSrRknaPFwIAmYfL/ourIYd6hLqQyDra3FYKjHjR4U
         CxeQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gAvao85SzlBCkV4O9vXssh6nifDg4BOKGh+fwcGWWfSzfuE1WJaAl59s6X2COn8alhN/T9YAg@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkECQE7gPS0hA3XtXGDqrzh/XECZqKQDL6RfSIllWDnq54TA2
	mP7J966O+CTzS0UbuWUh3d3RaDbcx1RzZjqDopGBU80kn1an+OXjfPhYcu0jeu6ydA==
X-Gm-Gg: AeBDiev4rzFGW8n4Pg1zU+ga8mm51564UlErevDCV1wuwsi8PnnQ2SdVXs1HsofIdQQ
	XnRDgHRG6SF73Hwt7nbHij84M5luvU8FU/x0kTS+x3qlJBpEEx3klGxiOnAZfr1Y9LQJKJRq3fG
	gQzS+yJhDTbe+sS8HVowcBuZS7Xz8gurGbLsZtX/kdlPC4C89Je274Zk02d6Pq1bTcbRVsaEULj
	bh9GdA+J8hglUa33+4PWQiMbbOzYVu5gHXX5ziM7ygizN9SbhK05reKDu+Yiewn9FB3dyD49Qey
	EqRbRsS1Pz6Hk7Ah6C4AHaIYxTI2Ns7YVU2RBt0pJcpJ0bGUkYFfirVBkkX0fSbF2cqjjBASQbe
	lk9pFk8/zv2Kd3E1y39eOha82J5fsKsjuQSHZN9jWNgP8ZJ9FKj6PWJpFgH9mIFJeO4UihvNcIy
	Qmuke84NKLa8At7gtCEzsopiMRWFb1t5xokpH53y6P6soHmfhaTrtaT11xD3Cjp+FLRzYWMhqfI
	vJiOIc=
X-Received: by 2002:a05:6214:1947:b0:89c:4b37:7106 with SMTP id 6a1803df08f44-8bdba9e69e9mr9178906d6.34.1778110988799;
        Wed, 06 May 2026 16:43:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e6d72sm213636626d6.26.2026.05.06.16.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:43:07 -0700 (PDT)
Date: Wed, 06 May 2026 19:43:07 -0400
Message-ID: <3fa2020d427f18f9c34c9651f1a5496f@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260506_1600/pstg-lib:20260506_1556/pstg-pwork:20260506_1600
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Eric Suen <ericsu@linux.microsoft.com>, Casey Schaufler <casey@schaufler-ca.com>, Canfeng Guo <guocanfeng@uniontech.com>, Takaya Saeki <takayas@chromium.org>
Subject: Re: [PATCH v3 3/14] selinux: more strict policy parsing
References: <20250511173055.406906-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-3-cgoettsche@seltendoof.de>

On May 11, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Be more strict during parsing of policies and reject invalid values.
> 
> Add some error messages in the case of policy parse failures, to
> enhance debugging, either on a malformed policy or a too strict check.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3:
>   - incorporate the overflow checks on security classes from the
>     previous patch, and permit U16_MAX as class ID
>   - minimize the usage of magic values, by using macros or trivial
>     helper functions
> v2:
>   accept unknown xperm specifiers to support backwards compatibility for
>   future ones, suggested by Thiébaud
> ---
>  security/selinux/include/security.h |   1 +
>  security/selinux/ss/avtab.c         |  35 ++++-
>  security/selinux/ss/avtab.h         |  13 ++
>  security/selinux/ss/conditional.c   |  18 +--
>  security/selinux/ss/constraint.h    |   1 +
>  security/selinux/ss/policydb.c      | 196 +++++++++++++++++++++++-----
>  security/selinux/ss/policydb.h      |  23 +++-
>  security/selinux/ss/services.c      |   6 +-
>  8 files changed, 233 insertions(+), 60 deletions(-)

I fixed the checkpatch.pl warning in pr_warn_once_policyload() but
otherwise this looks good to me, merged into selinux/dev.  Thanks!

--
paul-moore.com
