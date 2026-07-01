Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E234C141
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942055; cv=none; b=q+GYqJxptS13AKAycCKspf59eLuAMIZBchbSe8jyE59n8LhgnDjsG9B8lf+VIjlrSZAh5dt90pyO2ywEpYkrHox5iqEFEuqyFDz1+M6gdCgvXZpqgEV4NyPFAvEgaTwp7XQPNPeuAEIbKUgnjztx9SkVOOC9/ljkure6UAQBhkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942055; c=relaxed/simple;
	bh=jkxnHbMTl5E5MX2AR4wKQquYRCMtYACxp0r33hGppu8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=LwZMX38pWuuUrY2djKskZTbMZTdC+5XEAzkRUFFi9Md85eN8dpjAY4pT0mjStMRaRf7tBTfuEYXK0iPYr+3n6hispIEOGDONT1jqbKmc6OGUMiqS/OYm2QUe2ljypRJ+SJBW5v/pedOQOhtIfyTG0rbuy0h5Na8CYdf4XCLtdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AC/4tmes; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AC/4tmes"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ea93125ad1so8328216d6.2
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782942052; x=1783546852; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9ViOfNNHf6ufO0KQ/3EYtRaRMeo0KnlfdOWxnjnAuY=;
        b=AC/4tmesUoaKEYMVuB5v8LokV64uC2+OS3OIpjWfZWlBmivkwldXRbyYoa9FZrUyhA
         E1cebzmtCcwHhj+9mj9wFMg3mMr18qEQKzL3hlLWmT2bnV8SFJvhAUHJo2A9kSxQmbDI
         T5+o+lkeeirAzw0ePe7W/68cnb1EqFIVKKTJsu9EaGx4tOxfeys4RxnzTvkpiYfM7pDp
         MvGZIKsaYUZ0BrKCWEQI3p3b4glN0K/r+RhpFxwwbWzZFs9JisWkoKJtES3+LT9g+X5R
         AMlhKi6+2gK366BM8MFwsjDGzvpxvpTHQzXrjO5ypqZVODC81Pq87/gh2obhn7i9ezQB
         uOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942052; x=1783546852;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9ViOfNNHf6ufO0KQ/3EYtRaRMeo0KnlfdOWxnjnAuY=;
        b=MPOBRXqKHen7I4NyQw70QhNdAVchdsqrMkJiWZCCmh8XR3MAVpIlIEtOY9bZZ7Mkl5
         YVC3NP51BrIW3ke744yWrPiEvqi+glW851LMyU1j7A8pqSCga556NsNflc2Mc0iW7dEW
         plNQbTwbylAj7cr7gqdW4aBT6oQjV38lg9BVkLiZOvRf7bSY6tcUg6wcglXj+LTrt571
         7Eg0jKqDKrqEl2ie42XUkdW9bXfbpVM0gqxI1x/3NaiM87+uIFXt13K29J9MMJdezFqQ
         AfjuraOW/bmqjpxfT2jHXUYclXxs2uobKd8Gl6RcG/7+zeOVeZbRuzoz3cUUqGX8H7Bt
         VKGw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7e7RZtMEe7kAbmJxQwOUS0e5r7azDPjMs97mSyfX3U6RQk/rvhe5g/FKIT17Pfa7kZFKO2fWg@vger.kernel.org
X-Gm-Message-State: AOJu0YyCTTK1l8Xc/R7z/BNLrl0SXRav00GCii32/3wmmNoEup8QfqK/
	4UnOQAbnwH/y0HxiAcww0PdjYnPCORYteonAX9cpo3i9tPKfhl2IAdDJBizPsuCSnb2NJ6n3DDK
	S3oDKOQ==
X-Gm-Gg: AfdE7ckbg/rXMce3fYcSryo2kvKzc+AFfyUFl23zMtYM7w97QqgszZczCARlLcIrT4y
	zT+Ah3kEXKUXjdlxieHm456oxxD6wauHGbWLwWNPA4kPg3Yy8mcAWMpYGTOrmAFbIJLC9xXHnrs
	4rJ4yUCiBFA+T5Ivnknx57u9IyKUm//pfgEnfQ+Uc9RkdjYTVJLmvT+pKWYtpmbDn3BQXiqaNvc
	dq7I1VJqMxSK1QLmen8tpOcPpiDflLBGwbytjmLDMjwVKrCvtgEZJSC+WKQ7n+X2f7XUa/W+jYM
	wtZaTxzUeAFqecL7z+207+NZQAZyEfxpAUwFHkSh/KcebfSKlOjqaAXU09p11/qs6tBPE9W4eMO
	vXQR+qasMroKKbS219nv6HYGMbpJqVWEXZ+Chk8am4R0DHJijNlCx6XRv+QERBifjWUxMpTjxsh
	6FI/RiYTzA/kZydMwXSooQgpYMllK5aiSdkoAyWPVsDTX6AbXXPiaUdqH9aXCSWRxQImg+
X-Received: by 2002:a05:6214:2521:b0:8ee:ff2e:c2f4 with SMTP id 6a1803df08f44-8f3c6bbaa56mr47271546d6.17.1782942052405;
        Wed, 01 Jul 2026 14:40:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de93a1sm8363966d6.34.2026.07.01.14.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:40:51 -0700 (PDT)
Date: Wed, 01 Jul 2026 17:40:51 -0400
Message-ID: <9eb23fb8bb4c20fdad023df38d88b5b8@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260701_1640/pstg-lib:20260701_1540/pstg-pwork:20260701_1640
From: Paul Moore <paul@paul-moore.com>
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: Re: [PATCH v2] selinux: use bool instead of int in ss/services.c
References: <20260622174218.92190-1-kalevi@kolttonen.fi>
In-Reply-To: <20260622174218.92190-1-kalevi@kolttonen.fi>

On Jun 22, 2026 Kalevi Kolttonen <kalevi@kolttonen.fi> wrote:
> 
> Updated security_sid_to_context_core(),
> security_context_to_sid_core(), and their callers to
> pass boolean flags via bool rather than int. No functional
> change.
> 
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/services.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Tweaked the subject line and description as suggested, otherwise this
looks good to me, merged into selinux/dev.  Thanks!

--
paul-moore.com
