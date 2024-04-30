Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E661BF6C0
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514919; cv=none; b=qLP0dM1xd8XxqSmL6qqNJT7CPYo7y6YL3LdlO4JTLq/2Eef6vrLrZUoDr0Mj/ygDrOG4VFxrXA+zqV0V2PWmlT0hMcptfsOpFD3NBtmXwbIAMuJrQbMNJeX/akr15busvjMuZUFEhZ2PBPLNDV8UKqNmJfyJs0hNdbT1vYdb8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514919; c=relaxed/simple;
	bh=N4cxGspuVh5/6l7lC3Yw/kAKQBId5WXnsfVDery05YI=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=snH15Tu7rSJ/63qNKT1vSGhLkA7l4kjIJal45byyo31eMTobRb2BqO0QiFek1TUagGoTmLDCkN8nI8QmiYLmgwXnv9kJEQG3qcUAheFiK6d9tHR6hT2OMFG/eUUCD+7tvJwPOeAh8jsmO3OnOSIOw3U5hiaPjeVWZimcECPxhaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=elvub7/F; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="elvub7/F"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61be74097cbso17414887b3.1
        for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714514916; x=1715119716; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b9DAKYfmeeQ8mayJxvyIvmC50I4tzZHNxMCydSi6/Gw=;
        b=elvub7/FTextCta2gjlPOOUgqnTrp5SDm3+DpmPKxBigNR7E5D7JfWNH9iYxKMOmTM
         jTnUho8g1DXWpXhPGGpGu2fzY5bgcrnknzVm8f4YqlrNQNmHqvLkQb+86M53xwMaCVV9
         NL8sOkF8IC9rJahCWQjMNWIBQzxWaKGrgWngFiYhIZsv09B2yWEdAzNSSbQeVZPH5Uxl
         Y/7oPqlKn133z1yGF/hV0DO74Y8/nNZ1OKfnAcOFoXfIpli4S/I0Xog4UnE1NDZs8o+4
         Nz5xVERdmMYEjavFU5SDbcR+GPZw3KRp5rqll1yjKXqRIq8oz9NX+ruGszpQ4bu4AzE/
         Oyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714514916; x=1715119716;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9DAKYfmeeQ8mayJxvyIvmC50I4tzZHNxMCydSi6/Gw=;
        b=hDZYyWFGyc3Cu6CPB99XtuF2V/O7YIq2uZv6SJ4KIzWxHnvAMbmwBRI6AZXfmpDdOf
         vf1mCIPh2bUXTTPzVytmCTT5v5jtZWzsudbolqpBD096pUDlqGAjBCZRNL9nU2YC3ZuC
         Vm88iwI++bKGwI9eXkMKCcm356aC5WoCFBDd8truHd6KZENsMUnSkFeozEa71T/sSr1M
         tqAH+rA/b8GbzIf6aRGcSKjDTc0RRLddZIns92jdfn3/XMZEKwLIySpt/0nWUhO9s8lC
         QaVpC7849Tn2GKTY13jiPnGbxU0/zfVKHM2DkYoXgXIseBHK0kWVlQs6BF9jGd/6Txrs
         VHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKkzd8ZI6fhwk2elGAdCmYYD5duMAjZeOz2axC/V1DNeXh13+Wb1+gli5Wce7uRuoZ7hFuNs+cmt9VPMlkvOkiSj1FGzKVqw==
X-Gm-Message-State: AOJu0Yx59KXKspXGq56MfuZ9Mu6RzdPpzXeoYwfRFDVLzLt0vn3q9Yww
	PteRq9559OTA2pcHaz0KTqJetniQ8/WuW8Ff7qMZyvaPIe7ES60Drwy9yjJFGSn0MGFhqP7lsUc
	=
X-Google-Smtp-Source: AGHT+IEN9mvRqEX5fn4OukhMAT7WbmPg9N23byyAmcyQ5HT1Wg0peq52URs4GdZY/p5CZCekpd6gDA==
X-Received: by 2002:a25:dc84:0:b0:de6:1643:f3cd with SMTP id y126-20020a25dc84000000b00de61643f3cdmr932188ybe.44.1714514915731;
        Tue, 30 Apr 2024 15:08:35 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id v10-20020ac873ca000000b004378b8ef629sm11746716qtp.31.2024.04.30.15.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 15:08:35 -0700 (PDT)
Date: Tue, 30 Apr 2024 18:08:34 -0400
Message-ID: <3a8fc30894098e58ade92861efa44230@paul-moore.com>
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
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] selinux: avoid printk_ratelimit()
References: <20240405151523.92010-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240405151523.92010-1-cgoettsche@seltendoof.de>

On Apr  5, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The usage of printk_ratelimit() is discouraged, see
> include/linux/printk.h, thus use pr_warn_ratelimited().
> 
> While editing this line address the following checkpatch warning:
> 
>     WARNING: Integer promotion: Using 'h' in '%hu' is unnecessary
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/services.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks Christian, merged into selinux/dev.

--
paul-moore.com
