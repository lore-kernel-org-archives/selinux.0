Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460542571C2
	for <selinux@vger.kernel.org>; Fri,  7 Mar 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376318; cv=none; b=Ck+jAAbePUzClCT75IbRdVs3IUFMcXbOYDFJ5DdLo1OAszvxuHfDapl9VFl8aVHp9YadFbsXtIvwypoyiriAVCctUeBw0vWAE904wHz6HXGsFfbd+Cjx8qycowUNuDLW6dfMk4OXCw9L6fMwnZFwdgi3Rr5E09Bg4EEnVIB7DGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376318; c=relaxed/simple;
	bh=1ZI28/lCSvGnh96hlD+BJ/dGZVhUIKQvcBo7eAC6zwM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=u49IsQdVyKtN4ksZdUHJkP6BovFh7AiTgr9mE9G54+ZUW6PULgy/fhbJ+AsrXJX06ylCkX7al08QEq37CAV+JuLP5piqTvC113nyuMA1XFj4F5NH46BAwLh0rqGYbtIbdeh65jeC1Rvmh4bxVw+zlU7AFydAk8Fn/M2LQkMuuC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BVPPwIRW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BVPPwIRW"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c3b63dfebfso253437585a.3
        for <selinux@vger.kernel.org>; Fri, 07 Mar 2025 11:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741376314; x=1741981114; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5igKSTxPFTOS+xKkR9/4WsthgWnkE2Mlv3quJUlVtk=;
        b=BVPPwIRW2ghmQcoIDPZeU+9/lWwojSNIRbcZl1LY5JrFKSbIV2i0icUaDnI4Gs7E2C
         rEI9jd64zXzIX6LN0ryop9Ks6bH6Gl4GXPTZT5Dvql3vKTTDWUHQqJggV1DIkizxGPJM
         7sGcrs5x66PU9/XipCpN2r3MG1gxCAMoMd2OskVnMqWUBBvaIPp4rh3NLryD0Km9IVaI
         VGpLc9GSkokOIiJRrb75ThBIFN9I7oTTl6Fidhn/DSGaLZnQCZS6lpmPPrqXh0SmKXBE
         TtkUlHOzBVh1avqW9F+e59x1p1J6mIFxahDJlMVCt4C5HJL9llntIi/YKB4mbyMUk4o/
         4HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741376314; x=1741981114;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p5igKSTxPFTOS+xKkR9/4WsthgWnkE2Mlv3quJUlVtk=;
        b=txGerLko55veViVzVe5wENWGuaODFUJs+3VIKo3bAgoXZ0J2sAqlSwPolJPFOuUqwQ
         4vI1kubEt7sTmKd7I9C03dEl18vET2sgGo/P/3PW+sv/lqokRudayTpzGW7VPY6MOjv3
         VR+JOGLn3teQMsnIz6omYCBZFGsp/PSSuWsnlfm/Bmal3F5diiFNdH3Ntj9xeiWyRFNG
         uH82CARn9Q3y60alaB2MV4wThcnpVcGI35pmo4EPkXDWw6STC5IV7goeyr4QPp1ZCCkZ
         zEThyG4CT+YL2UWEREM/oOQ1duryDhHtqMRM0YQ6HkNJLrXmww+GAJtV+Tq7d3JAHWmY
         6G8w==
X-Forwarded-Encrypted: i=1; AJvYcCXax0kPMYxEQbNV27OpTLscWF2sbnuqA/qDtEeDf80VJvyMFfAjhkbF+m4Za0xEnJFJQKy/FAPF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdgex2mHM6WztziXY8r3z3/UIpA2xCjsvWsR9ouFvKRslaKXJA
	46Wl6mZSna2M+RWQkQhBkfd7oJB/VL6YWC60JopUMkR3yStd5GrETTGnEvc9s4of7Z5X2NmVeb0
	=
X-Gm-Gg: ASbGncssRbCIBMuNTpDaAbVB0XYBHdtq1TgLOsx2unkeL4nC5+SE37ldXKaxgpdYubV
	dEgfnKnPMHPyUnNe1MEVlQnVcgZY2Zs6ZGYOMVj4aaT+mnIh+Bu8Wl9JTZiTVfsml+r6TjcAQA9
	prlBfiVlSgqLw8HJGElMMzyci1qQ4mwcSFgDIq14DslMiUK80LTGCq+4BslFmt+BH0u33+R1YQd
	HrggMWJLg8D/Jd8STPKaSkmMHTP4/XSl8Kd1t28TtMAA+vjDl/8LJYmOLS1kSG3v36CgmMB61im
	Xv+QWjFJSK9ULWxwqum1pPseE2bZ6Y+b04zfVvkOq2f9tT6tJI5cNCqxthymxRluGHDj4aK5Tbg
	dq5N+zORAVZKDxg==
X-Google-Smtp-Source: AGHT+IFkaMYQx1ylHwG/iz2um/dPEpd79CYsvVILlcJOk6aOGsNMrx8/W8JzuRmdiXyhUsZ9RsL0vQ==
X-Received: by 2002:a05:620a:8017:b0:7c3:c1b4:c8f5 with SMTP id af79cd13be357-7c4e168267fmr655768285a.15.1741376314157;
        Fri, 07 Mar 2025 11:38:34 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e538448fsm280105385a.63.2025.03.07.11.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:38:33 -0800 (PST)
Date: Fri, 07 Mar 2025 14:38:33 -0500
Message-ID: <aa05b93c973149a86385a6cb7f7c1138@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250307_1437/pstg-lib:20250307_1437/pstg-pwork:20250307_1437
From: Paul Moore <paul@paul-moore.com>
To: Tim Schumacher <tim.schumacher1@huawei.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Dominick Grift <dominick.grift@defensec.nl>
Cc: Tim Schumacher <tim.schumacher1@huawei.com>, Stephen Smalley <sds@tycho.nsa.gov>, <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selinux: Chain up tool resolving errors in  install_policy.sh
References: <20250307095645.326982-1-tim.schumacher1@huawei.com>
In-Reply-To: <20250307095645.326982-1-tim.schumacher1@huawei.com>

On Mar  7, 2025 Tim Schumacher <tim.schumacher1@huawei.com> wrote:
> 
> Subshell evaluations are not exempt from errexit, so if a command is
> not available, `which` will fail and exit the script as a whole.
> This causes the helpful error messages to not be printed if they are
> tacked on using a `$?` comparison.
> 
> Resolve the issue by using chains of logical operators, which are not
> subject to the effects of errexit.
> 
> Fixes: e37c1877ba5b1 ("scripts/selinux: modernize mdp")
> Signed-off-by: Tim Schumacher <tim.schumacher1@huawei.com>
> ---
>  scripts/selinux/install_policy.sh | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Nice catch, merged into selinux/dev, thanks!

--
paul-moore.com
