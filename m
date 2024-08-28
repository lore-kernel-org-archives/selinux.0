Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCAA42A8F
	for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866933; cv=none; b=mSKU+DEk/UjhiZGxYf07xG/BtEJwsWvzzXWPlBXuBBOFnqXpfZL4OHZJ/x3ivTLCTgMf7vI1qnHQHY7GQIWt6PqRSojjpP+3+BX1GI0xbFPrMGbJ9XqqqxIUnt/ptCf1QOYtYSEzjjzPL5JVt//N1OS6YyQkEjin1+yeHvgCkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866933; c=relaxed/simple;
	bh=6sJuclRag21uFtJ/65qjts/K8N+xM6U/kSObYcqdsBk=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=piXXxoN6qmVlHs1w3Hj/+lUApR5Bixy7BmaJcSeaz3BEXNVkS9nxQCPByp2hJnei2GCxre+pJNXqvg8bg/CIgv0pFs3JVnHegqrTrE9yNpO+PjB+6pB+S1BHk3CI5/q9CPbGL5gfa1QVP1u1/ryRMM0WTk/lO08YsesWDdaB0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dan7nYmd; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dan7nYmd"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27046394c9bso4080863fac.2
        for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724866931; x=1725471731; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l0LS34y9FNgp7CeUUEOHvHKYwbGPvsi/kP5Wc73C6eY=;
        b=Dan7nYmdCipb8VcfVQqrsQzN9lCdPANwVdDlEzEgtO4bRrFeCLP6M8GK/NxwvT779W
         UixZQtEvc/WA424UHTEkttWWdHWMD2SJGZSig6PrELZMg8TRXWOcLRidnmMkUDLBqdAh
         6Fdyv6KRc3pH6E/9sCbfx7AaZ2GBVy7UhvOITUcVn+D6QJiC8a1z7mKBn0N0tqxTXzNS
         4nuGT6tlyrNDQb305Is7eK5+MpVICJ8ySdv6Kv694UQZl3bF9jp/tkioy6BbMntCq9Vc
         e5/7l/q9E7NjT1ptsa+UvUswY5v+3505JCm3vbzxsuAtsKKXlswvCxDpuSTXRvKJnkJ4
         qk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724866931; x=1725471731;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0LS34y9FNgp7CeUUEOHvHKYwbGPvsi/kP5Wc73C6eY=;
        b=Q7q+kNox8vQsdFVP2tN+QSzjkmdjAYqwgZv6BcxTFOQHovVAhirVptPWHxgcQxlumo
         BAg/YOZrYjYUXl2VK26yIX2NWy1oc5MNzkYwOTw627bioTv5RCKPjDaHHKjNTzyjE4Kn
         aPRyfgaTy1rEgXd8a/1TIAEo8QT5TCUE1vad5Mo6QxGXUkU+C8hBmQBAMG6fwbI7ECyW
         O44Ion3WJOdGaSLaoMTGqnP43bMoNiEiB4INUMr2d4HVDJXwYeqtbUeNPVMFd2eiCgeE
         O2UbXC2MyZthF1T79EtLkMzckrRHdnRUZCRvQe+oMWf2cCasZZcbbvVD0bkd7P+cENEI
         k5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXVvouNtcR5AxUJAPl2339jNRkG64aorBwTwXjXbNiJ6j8TBLjOwi0In0IkslJ9/dIl1ZikBXO7@vger.kernel.org
X-Gm-Message-State: AOJu0YxRH9Tns9D5evefDrJCWSvdyBtCxQBth7tLNeUZitIN+5ut8v3u
	VE+5adGRSttlwLSgfvv0BCIQvs4vQaMYcXZ2HLHItdUjboBXnrsR0rqgiCf99Q==
X-Google-Smtp-Source: AGHT+IF60W2ezbSV3pqqIsEGk6YQW3oqG7+k3EIiwJzJkjnGNJsVIJxaYuxkMOkfo6a40udSN+41lQ==
X-Received: by 2002:a05:6870:4708:b0:260:e453:5368 with SMTP id 586e51a60fabf-27790321839mr364416fac.46.1724866931173;
        Wed, 28 Aug 2024 10:42:11 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f34233csm656813385a.35.2024.08.28.10.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 10:42:10 -0700 (PDT)
Date: Wed, 28 Aug 2024 13:42:09 -0400
Message-ID: <f3e7f421323bb99c12507299a658d572@paul-moore.com>
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
To: Zhen Lei <thunder.leizhen@huawei.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] selinux: simplify avc_xperms_audit_required()
References: <20240822140858.1998-1-thunder.leizhen@huawei.com>
In-Reply-To: <20240822140858.1998-1-thunder.leizhen@huawei.com>

On Aug 22, 2024 Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
> By associative and commutative laws, the result of the two 'audited' is
> zero. Take the second 'audited' as an example:
>   1) audited = requested & avd->auditallow;
>   2) audited &= ~requested;
>   ==> audited = ~requested & (requested & avd->auditallow);
>   ==> audited = (~requested & requested) & avd->auditallow;
>   ==> audited = 0 & avd->auditallow;
>   ==> audited = 0;
> 
> In fact, it is more readable to directly write zero. The value of the
> first 'audited' is 0 because AUDIT is not allowed. The second 'audited'
> is zero because there is no AUDITALLOW permission.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  security/selinux/avc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good to me, merged into selinux/dev, thanks!

--
paul-moore.com
