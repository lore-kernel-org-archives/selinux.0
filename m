Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B601B806
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517713; cv=none; b=Yix1f4j/LZniddrroDfRLbNDmwYBRwyOUWWDfWe8fTY0tMZ3TBq0zZVnw/uXlxeWusFQcRLRs922UyXHQHEA7a7Jqm4Wf0ewGTNmcPD8d+FsNMfdMfTYeD7T3jgLHcfi2KYKvLjiZ/ggRqtXfv4KsojGkP8fThk+5HgKalVVaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517713; c=relaxed/simple;
	bh=ho9UgidLiuIiBiXIVvh/lWotAt12lUioguVCFMrGAmc=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=MqzicsvWTMy0aGaXDzDj7dhsvsKwoxbZ26rBYUA7RrTVHqt3eRH8QTzNr4yXDwVBvwOylFirlZZpMBaA8IJBwqWOU4HILfYSzN/ROoXfQuWFPL7dX0jRg8agnFJKBrmvTpJKcAgCQg+rWwrI3ICAaOd+i1FIshYDNn36JxCZqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LR1+SD3b; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LR1+SD3b"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de603e3072dso2651233276.1
        for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714517710; x=1715122510; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qAxmFkbAsUiCyvuOdki7NFBNiRnXQiLD4GpfQPzTS0g=;
        b=LR1+SD3biqdcF6A6o9pUxIPnARLIy/lqOU8lmNIDYmyGTvDQoCNNta3I47of2ph6fW
         eGU8a2VXkCc9WQHGyIrUzkQUy42/i03fHhhhxKgdYFtByYb2hheXB01p5erwO6Dxtr+Z
         WdczpBnzj389dx9qVi49wWn4YB1UJx18mPj2LD0Yj4+TCjqOAIWbnfMDFhufIUjGH5BD
         wBTrckUCqxK0i6Sk7ZX0TxfeStHOWZlLvpEpY3KTiH60NL5z0/CBwZiHzP7tBhMUN3+6
         211G1wr87B4266HARbONbsivvTlga/RmPxYfxE31efayQkQPqQLAwh/sbvSQN+5xKv/g
         79jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517710; x=1715122510;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAxmFkbAsUiCyvuOdki7NFBNiRnXQiLD4GpfQPzTS0g=;
        b=D1najM9i0MfkjVx4Q0+ry5o18ylnLuMTjTgvRVKggIJgOwcCX4L7kqQ8VqGSshPyyD
         Ivik5Mzf2zp3HDrve6ao7xC1dtG3psm55oRkFEayJAVyQDHRaFROM7UKTIKEhI1tgftJ
         E2Igs/BGa3om/A5+801NzFLFZCzfpqKFgWhix22cpvKKZEBOWC6Sl5H6PrMQlSjV6tyX
         ELJfhbiawSii3RSLo7fx9EiEqJS59Yx2zOqcWnICjmDTXgG2uKAlRKxapfm4F6d5UQ+7
         u3Tv3Sln9irg+MLmjhZcuhFMTxDovet88wsNVTsZ65nTndq230lVsCn0KzCIjRBj3QHo
         B0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIU2xzcE69bqmMcE7DuXQlsl6H3sMbKUQQu3ZEx5H28faD/XGjeUh1hjAZKbVPTn1IqAEtQvYOWcGlKZ5155UwepulYSytHA==
X-Gm-Message-State: AOJu0YwZmM6bHiQS38PSSS4XU6vESQSZkVuFwnOwyOe7qHve5OsE5058
	2MVNRg//jVX2xHcp60gDCLaD4EeaffVXPqKARSh2NsI8Z68eFd61xfVry6rmLg==
X-Google-Smtp-Source: AGHT+IHK9ZYLCG8b4npZTwuIzKwuk6dxY3kvvWa4cO4t/DUmBAbDvkYeEA1Yoj55aGkAuQsGiPcMbw==
X-Received: by 2002:a25:e08b:0:b0:de0:f74b:25f3 with SMTP id x133-20020a25e08b000000b00de0f74b25f3mr1085836ybg.60.1714517709840;
        Tue, 30 Apr 2024 15:55:09 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id do7-20020a05622a478700b0043999fccc10sm8941117qtb.62.2024.04.30.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 15:55:09 -0700 (PDT)
Date: Tue, 30 Apr 2024 18:55:09 -0400
Message-ID: <6a578214df994a783c067644c62aa443@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selinux: constify source policy in cond_policydb_dup()
References: <20240405161042.260113-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240405161042.260113-2-cgoettsche@seltendoof.de>

On Apr  5, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> cond_policydb_dup() duplicates conditional parts of an existing policy.
> Declare the source policy const, since it should not be modified.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/conditional.c | 12 ++++++------
>  security/selinux/ss/conditional.h |  2 +-
>  security/selinux/ss/hashtab.c     |  9 +++++----
>  security/selinux/ss/hashtab.h     |  4 ++--
>  4 files changed, 14 insertions(+), 13 deletions(-)

I had to do some line length fixups, but otherwise this looked good
to me, merged into selinux/dev.  Thanks!

--
paul-moore.com
