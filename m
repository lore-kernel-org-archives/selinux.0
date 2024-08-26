Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F289B19B5B5
	for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711958; cv=none; b=nK7qc9CCwUIHnGN1NNfo9OQhYT46CxTj7tH4Hk8ekIULF+1cHMBefYKyieEz8Y+h+dCcWDvCZVR4hvyh3+/MX7ponTqbhz72b3YTNkm5ciajwHGDuSfEmqTgw37oBhiTS9ZOSVtZTyWJieLzB30FpSGsjxMezDXbS7H2/Raot18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711958; c=relaxed/simple;
	bh=ACMBgJ5jazQoNXByUixv8HW7VgyePfVhsUb3MT24jkY=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=e2p2XSFKYpoQVj3IbhgdXuJBSDzOcXvSXU8fdLHyPnFJ1J5iZYba0oifz5mnxSEoC/CiMRimC0OQkGOEU1uJPseMsoIQbxO7dfgFHMK08VtBA8bTNb68fjAomZSPRYwen2ZW19Q+u+p0U7LLB8ayIdhVZ/3IuFPIo6vPJOEGjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FL7J/Dx+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FL7J/Dx+"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-450059a25b9so40937361cf.0
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724711956; x=1725316756; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cSamOqYMtgPTjo+IhpHZOBkz1CzFELFeAqTlSsCGHts=;
        b=FL7J/Dx+tW5JYwgCw7qzIEoSoNC0ibrYPHOMaTpLT8T2rhibaizaK8+68SFgPoqzBC
         oI8Rn2swq56tLSv2NVPwxO8BaaueTK2JWTcFJh7N1Iwi1nypYNl0ae/MJEe4YGOiWGcS
         pEYL5NxfzChRzTuVQbcxuSecvTsAVCPUpmOmPhaqn7e5nQqkZ97rJeDS1MD3abi9RMaf
         oUhSjTEQkh8zn9q/7sGcxIvKfh/R1JtIvx4VofyNu7MQMH8FfRxtB0jqBzDEISlkOVui
         bMC/bYvyK1ehImM8XZE/Zrdk2qTiQ8Nszzaceyflu8eoU8ohMh47QmLrAcRGTdVsZFAM
         CpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724711956; x=1725316756;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSamOqYMtgPTjo+IhpHZOBkz1CzFELFeAqTlSsCGHts=;
        b=KXYAfwY6uyLdKZE93GgKmsE/fOGnSmktb2Ol25rUQU68m3N0uvmphcN1sahZ3xgzZo
         tFvdhexnh7WEBAsVgeDIKEa6ltpWm1C4uphm8NOyjlWAQQ09QsncPkc6na65s5hBxjFF
         NCWw17Jhs9xLS1rpQSBbleIG33f1ud++tZqSp20V7KZUQML2tPZPFWnwiddOP/1LlBNH
         E33ugPK3yqUMuluiwp3N2O9G1GzyrHjfBcIrcGZ5owg1MBTvBJRVuwFzEJd6lsAZPNW2
         0kAcGTSeGs9eB2ykH8s6ED1666aiV1zXIY/6M+KW8pz29Nc8fwd2vccUFR502zwl398F
         aBuw==
X-Forwarded-Encrypted: i=1; AJvYcCXQPK7D574fD4ZjffEMgRmu6VmxP/lDuAaKU2vfSURXjet0UIcMplQShpvKPJxucmRiiKswoBeK@vger.kernel.org
X-Gm-Message-State: AOJu0YyMp+cEcdZ3BBV8F7k4wterqs3Fctd0hw1mS4zxjfJwe24tQMr7
	jgujZpVVbfYGecv3nO7B4z+MbVLU/JBD6UpxiuthLQwaAhNzzVxeRU22K55jC7jwfIPvL1/iVV4
	=
X-Google-Smtp-Source: AGHT+IHPqEwf+SUU0ZJ41YgDV/Eae64hBwQMEG0wA9v4GNtvssYbH0FVmV3iGcwEmVUsMIOrHbX+aQ==
X-Received: by 2002:ac8:6203:0:b0:454:f2ba:1237 with SMTP id d75a77b69052e-4565ff7893amr16983811cf.4.1724711955839;
        Mon, 26 Aug 2024 15:39:15 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe196845sm47785831cf.72.2024.08.26.15.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:39:15 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:39:15 -0400
Message-ID: <723e199a660a3d9558289abba84b1408@paul-moore.com>
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
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>, syzbot+319ed1769c0078257262@syzkaller.appspotmail.com
Subject: Re: [PATCH] selinux: annotate false positive data race to avoid KCSAN  warnings
References: <20240826124709.23530-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20240826124709.23530-1-stephen.smalley.work@gmail.com>

On Aug 26, 2024 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> KCSAN flags the check of isec->initialized by
> __inode_security_revalidate() as a data race. This is indeed a racy
> check, but inode_doinit_with_dentry() will recheck with isec->lock held.
> Annotate the check with the data_race() macro to silence the KCSAN false
> positive.
> 
> Reported-by: syzbot+319ed1769c0078257262@syzkaller.appspotmail.com
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Merged into selinux/dev, thanks Stephen.

--
paul-moore.com
