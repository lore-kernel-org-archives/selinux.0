Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC130153801
	for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578320; cv=none; b=K086JtwDImryiZJIO61rheFaj1IHVIDtXXfCL/E75LxdrnTmaGJ2/uCVXLMTaOEn4Ao9IRrPxllHZoeVJtmIQYKbO+cTeVmh8X9GKjurFFPz07gK1vgWgwsN9RtCGQkutCj+ujdziptAORXZU6R86pBZ/cWc80ExtAuFCSC0ALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578320; c=relaxed/simple;
	bh=zvblnRjqyr9T+Xx2ZmU4DdKOyZ8u5C7pMHb7A/mXvSs=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=T6EzW6CcRn8dHZgVUnqJL6m5kW8wFwvWXO7ckCItQwCSSYH1HdwRYT+mkV3bx4YJm9pBp0s0jA1TxVkqV/fdgiFXgdaV+POF8umSaLFKP79FyMAuIJfGrkaau0odu3pXcpPt2qf6vbBlR2ztQY1alZfmh/Ah6imGuGvurmcuid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f+QJukT0; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f+QJukT0"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690de619293so2257816d6.0
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711578317; x=1712183117; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lJ3wjFaeU9Ztiyd+gJSW6nXLmVJwkYytMN2nUftxCkU=;
        b=f+QJukT0jAngv/wLvWrZEm9Tk64blPq02R1Vk1PdvmYqtilE/L4ngpmMJf0q1Okjvp
         HSpyKX43ScrDYCZiWSt9o+yLkKwasOFewwr9+4Ullrb7713SDlfmFC4eAiH4/3URqkX8
         xh/3qJ+Dcx176AEFolsGV8OvH/dwBf8wENIAJ4iIfXXh+1UHfB9k9iAyhF5FL7sL706q
         gKpyp53YkPwmiQ43/PWJZJQ3OLxBj94C7oqoBHe0MzvhqwJB8SBVJYk/tcYDmS/m4tx9
         M5J0ooSyGwKoi9BbeXm7LZBRajhsHRECp8Qy5zm/OJs+po/Egten2KN2eBSZ6iuAfWwf
         JYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711578317; x=1712183117;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJ3wjFaeU9Ztiyd+gJSW6nXLmVJwkYytMN2nUftxCkU=;
        b=Zq4IhHuA2Gx+K1DQiGTlLpewQPuEHx3Epe0SDfrDemZ3/qnNHicgJ/imPuxCjjaphM
         lDpCP/51U9wFk73pzTgV5Lg4shvkTBF1wEK9CN66jtDTYP198h6iFTh/9kLpO1i/E32s
         MYPiAzGv9klNpyu1n4P0+yIn95x6qIZvpFSalTns7l3x8/ikBpVCWrL6OIcXJxOVbvB0
         rtIhcxWvRiIMnRKDKqme+weIxwM8JUs+rjDa59QF12mOP9w71A39qDtALvdRWMCIz0uE
         UclL/GPsyNAUSXKcVirp22IIPuWQjuQU90dPbcJpwHTUXJrzVbOUSG+929YSeMGypqv9
         saiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu6/xPJKpLdt+XUGtjGMK7/qnBM5gt+RCEwfYAGTGn+Te6jb+43U40aDuTVPGhqtVq7jlA3Z6+HIRrn7ZQuMLbuCJzV8/Fkw==
X-Gm-Message-State: AOJu0YzdqoyxyDkuxvE8bBrC631UGV+zkycAgnUomesX8jZ4mT7mqGYD
	oEc6G5MV+bohKjk2hz6YRxg8RJ/yh0EXw7wBeWZipV6qyQNhJfYNraxT/3mkiA==
X-Google-Smtp-Source: AGHT+IEB1EtlYhSzjbkFAJS6d1yVX/gJOyNrRi/7DgIyCMvcLad2G6ZK7a6iGO+wA6rZSHqS0SZcJw==
X-Received: by 2002:a0c:f847:0:b0:690:f1e3:ca7c with SMTP id g7-20020a0cf847000000b00690f1e3ca7cmr990364qvo.16.1711578317661;
        Wed, 27 Mar 2024 15:25:17 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id js5-20020a0562142aa500b0069686d63c1esm44265qvb.69.2024.03.27.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:25:17 -0700 (PDT)
Date: Wed, 27 Mar 2024 18:25:16 -0400
Message-ID: <5da09fb04d92d9a4a9d7d5cc1ab14ebd@paul-moore.com>
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
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selinux: make more use of current_sid()
References: <20240315173105.636749-1-cgzones@googlemail.com>
In-Reply-To: <20240315173105.636749-1-cgzones@googlemail.com>

On Mar 15, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the internal helper current_sid() where applicable.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 22 ++++++----------------
>  security/selinux/xfrm.c  |  7 ++-----
>  2 files changed, 8 insertions(+), 21 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
