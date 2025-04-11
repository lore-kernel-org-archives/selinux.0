Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69DC28D83B
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403381; cv=none; b=K6d1Tfk+9CMs9g1JKN8M0sH3p8vvN5wA5oXbU3O3LOrq4jPJi5kEnHfYWHqh28pKR73/6sglbU796m9FA4R2Pa4dMYIPu5oAYIZOPrD54cxndP8VcdapQl9jPlBFRJ5rAvmL8clJGFx9MmwyQUy+U1/CJ12xlmcVEYyEE2/bvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403381; c=relaxed/simple;
	bh=yfZ7tSoVUlgX2zAOigOxPAbHH5o70chJtfqLZj811rc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=clEKXDUk884snQ9vgWTjzxm2JWGY8lkxN9erTp0qSmqWf8Pe+gicdprX4jyIMxtKaLHYqZB4ky88rzBDVAek1u4WY0NeB3FWL6zNnco11Vjy4qzTzat1pbJAdZAxucRquVvQtGX2E3Q/YQyjXk7yVvOCHYLiRCHKED26HOnB8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J4q3tkaN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J4q3tkaN"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c07cd527e4so233309485a.3
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744403379; x=1745008179; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udx8P5NQgti6FOsmWgVm69I0Zh1i+WolhwcYzN3WDvs=;
        b=J4q3tkaNtRFIicpeJxa6YNjci735jlGkg7rFCar+Z7sYItlaqf9gNPaHrC5N93OSmy
         J4GOmAAy4BLExOa3Trys1UgredqQIB+3aOTWsc69uV0JnqaYepZT4QbcqTXTAsBXruaP
         u239HmOj+NQ3SF+XZelllTGa4KNEA1IJd+GLBtwoTg/XIkTWjZQFKO7Iq1GT57qo3jOe
         af21Ggzs55yZasGLMizrCnD2LnHodcUKDdz0OmIYWtxt0JvIksJng58ghnIY0sUFV3fO
         3TjoJ3XqAgmk6KPGvGek0ybhKJ4EN//MiNZHXshDZfLCkf2dyn0oZllVCJsQRAjxFsdl
         c8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403379; x=1745008179;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=udx8P5NQgti6FOsmWgVm69I0Zh1i+WolhwcYzN3WDvs=;
        b=P2EKKEaZyTJyDZzTiyHs5r4vW7fIiWTMycs8JXDtCe17kpcS4bWf2t6bOa6vkHosYp
         6QrlAcwiLwiZp9/SSkRExHSdEwrw282EIvnQlATRAUzHFT9SZyfs9qiPLFweqlyi6UJq
         q9EaR2hiQ4tj10mv7La5c+EUWp/x3CfPDKASoUp+tfkJoyz//Jzv3wCc5s3S2l3vipnz
         ZpjVotp8DecFFCirCL9CUBmmtF58+Q8qWPZiUwU+UISauc/vTamXZD8aululg2MM9vkf
         UJjjgTDC7O7SNCHqgEfSjKN+gT6on7o6xvw+AP/e3rW+DJlghbTMUHNaHGV/dmI0y6NA
         62PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXqV52YCGUTXqe4P0gUvwIOSg5tBQqQOCL8c0DpEYCk7oSbPrd3PBkFPFVOZKf2H95n+qfVbE6@vger.kernel.org
X-Gm-Message-State: AOJu0YyHa0TxAZVglXD1kX5jeIC3rdlp95pG5XouYvliX/MfG+iO/cB3
	ob/6zeVP7Z16J/34A28UGedQsz3tVPpEvhtlm1Vl8LZdqzWT2yajjnHRNRqCBg==
X-Gm-Gg: ASbGncsmFbWjda8IMNeD9vRdLxl8TtBiygOByDMGRQJspuToQBS5bWMKMfGKhlBqU2R
	Ncmz4h0q8b64lG44HzBrEb998DYtY3EgZL/0tkEvGPx71ZTMrFfWve4wTEg0z7ja8X+8TOcAp7Y
	gWDKZs07ySlS9VKay9JT7dlv0McUOnRgJ6kdUcJrE39eetpVo6nMBn/37aOnoj0ivGenTjCBIO0
	XQujaV3Ht54vMfX2E0mh8ua42wYSHr+m9xw74LlNfiHS18E9rwgAFom9q+vn4RDQEUNYwH7p35y
	qaU3IvZO1nyChj2u1khQGf0JBQ7E8Sp7g7mH+luoXU9XZtl8EdIKaXLy36uuSDpmTlUIEmjyu00
	o4PsCjamr1Q==
X-Google-Smtp-Source: AGHT+IHAZKi3da6H9ZT6r5+1QkoznXgFAO4EgfroOWd3yfn68Dolte8fO5VnmxOOmYKtTSskUzNiQQ==
X-Received: by 2002:a05:620a:4554:b0:7c7:739d:5cea with SMTP id af79cd13be357-7c7af12dc20mr617096885a.35.1744403378650;
        Fri, 11 Apr 2025 13:29:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a896a15dsm308067185a.56.2025.04.11.13.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:29:38 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:29:37 -0400
Message-ID: <4e6ec6918748074d1f081320eba38eda@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250411_1552/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, Chen Zhou <chenzhou10@huawei.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 5/6] selinux: unify OOM handling in network hashtables
References: <20250318083422.21489-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250318083422.21489-4-cgoettsche@seltendoof.de>

On Mar 18, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> For network objects, like interfaces, nodes, port and InfiniBands, the
> object to SID lookup is cached in hashtables.  OOM during such hashtable
> additions of new objects is considered non-fatal and the computed SID is
> simply returned without adding the compute result into the hash table.
> 
> Actually ignore OOM in the InfiniBand code, despite the comment already
> suggesting to do so.  This reverts commit c350f8bea271 ("selinux: Fix
> error return code in sel_ib_pkey_sid_slow()").
> 
> Add comments in the other places.
> 
> Use kmalloc() instead of kzalloc(), since all members are initialized on
> success and the data is only used in internbal hash tables, so no risk
> of information leakage to userspace.
> 
> Fixes: c350f8bea271 ("selinux: Fix error return code in sel_ib_pkey_sid_slow()")
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ibpkey.c  | 11 +++++------
>  security/selinux/netif.c   |  6 +++++-
>  security/selinux/netnode.c |  5 ++++-
>  security/selinux/netport.c |  6 +++++-
>  4 files changed, 19 insertions(+), 9 deletions(-)

Merged into selinux/dev, thanks!

--
paul-moore.com
