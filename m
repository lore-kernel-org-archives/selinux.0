Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC4443C2F
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801983; cv=none; b=HbbcODkNscbnUrXmaAntQ62e9rYsRA5jkJyvsv9cbH0qp05gGV72EIX5va+0qkdSiEXVmWNmfrUD1LggBazk4+uZuVK68a0QrGs1b6OqkGiO7l7fvFBsx1R+CqdcQsZ3S4p8kUw84yUnCAVVMScf51Nbt1WrqpU5ZVS62jXZf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801983; c=relaxed/simple;
	bh=McG+a3jQYhGOYP4mq2FCq1n670GE5DF9l+vbbYskN/k=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=VuiJgMWyjoigMGAbjjSC3mAwmhBz6nzvy74DmfRE2P+FWp1TxSGvcf3jWO4X+D8TPkoGO+IVDNYhK7BNstoY4SOnKFzXG3FlmMyy32rq0+m+aTm+YA4Q9BGpYG6ZiUc4+b5YLPAle6sKNzFcoaJfS+DKcnEa9NSZvWXtNptbGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NA3ZIwQR; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NA3ZIwQR"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320068d8eso53932411cf.3
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790801981; x=1791406781; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=75FeI7QFBwYihyrq85tBcSakFTyaK0sDHXPDUMuCiX8=;
        b=NA3ZIwQRIL9M21646pBc+lgF/5Vg8vJboHieL0TetJdSkLiViJ54HG7oPWLfkVCTwD
         HcdPwsSWRnbLalWR75I32fC3mBHNoTnoDTBhhg4u1/D2mvWXg+iX8pnjg7kAsgRdbowQ
         V0NQSfz/hog20p3IwZkTQ/Nujv5t9Cemyh1oE9havU7vXLoIJG+dooU2evCEn6mf1ahC
         UsyNxsCmNzgpZLU02lTM/RUf4oL6Bn6ixEYzazJZp9sQMN+kImMjW/vyWWOJYxwsHe58
         SfQ3O7Ag9ePYB0VpNeQwzMPoys7vwiO/8IelWwxsn3YasmsUZrdI2aQAmnG2BA++hDai
         f7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790801981; x=1791406781;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75FeI7QFBwYihyrq85tBcSakFTyaK0sDHXPDUMuCiX8=;
        b=lNljQklhFgy6oPKx0zFPnb4VhsU9/sjYRh0pSmMYCTXVC5Rv1j0bjhLfyb4VZTfzm6
         /B/iUobFHR9pil0hB0Pnhozuqt1HjedMj1TNQYHZO8uDHOGU4EETEVU/ovMNQ/ff7vZ5
         Encd7k40xPdzWBU0th1hmgsg1ISgXAM3JPY0th4j9aPkCzqfd7BmFymG2fKPJ74RxmkK
         8WiwHn5C64hhTQwPicDBFsLlR2yelRYoxCe/uLAFLyxEOlotVBzNIuOlYKhfz0cSA1yy
         h2kW574ACvimRQxcJHwMqVnSMmp4yqoV0erZIAYP0EhCTBhb3/s4YsZDmQsM32Yfys73
         BCOw==
X-Forwarded-Encrypted: i=1; AKwUvBxC6h059aLyEslQqZ1LIk3BLLmvyQhi+ZgAmAR8IQgAEPkl/WPj8Fihajr1hXk7l9b/e5JuzG3P@vger.kernel.org
X-Gm-Message-State: AFuF++kUXtCZbYQsKeinOa/MNkOOUyGUJcRy4xMr5d8liESLySYkbcYJ
	vbCmV1a6yRLWzlP37Vt+K/uWBT9pKDszQQh0YbFO+36XoMBRBWdVr+TevZVbftAmOS0M0UuTys1
	oLLKFUg==
X-Gm-Gg: AYBFou3pMGlCkaAN2vprFZ72K/zOtg5UK1CjV4FN3TqEi2miqbO1Ff8dXV52S1ZvLqz
	il6yf8Zjh0/CwEi2fwCEj0bu1VTKz777GEi+iG/HSa7g4msM8uVzKMGVps/YzXVktPRC7UCseEI
	1RanK5hUKpCF7PNL0P1en0oAMcaWU79O6Y93kT6Qkn+7doU8/zBMRvpdWdP5bWaFSFF/AtmNjbC
	JPWwpc55YyPF7p/3Q6MA2XvVOkLQtUW4sx+7iygMI9wQ4NdAUsxwfEvenmMHrfIUq5aSweoNFzf
	VPC8XDQEK4BLuweC2CjmkVfURmbWKneCF3agqo6F5eb2lx2D/sB0yO6UC/lUs9PnbGiY8V3AZ10
	9vFzrp/tl1A6o06RniQzEDFlzRRBH3cFbPKeY5nVCTH1pZMiCvzuf7tXUo3aj5V4bN+2dS5RDkt
	w53ZtzskPAV0Si6I0IvRKBO0e3gsDBHZWVHT64WpkzrAoMxUW06bMwpJ991kn9qNd8+rOb6V75d
	itE9eScjgcvh0aPjJXavMmLzPix0K2oQuIiIroDkfkpgwIqTLZLN5skqLZnqQ3+fy/V9pSksqk=
X-Received: by 2002:a05:622a:148:b0:533:2271:c215 with SMTP id d75a77b69052e-5337427d2ddmr55783341cf.13.1790801980813;
        Wed, 30 Sep 2026 13:59:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533862fabd0sm2194801cf.28.2026.09.30.13.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:59:39 -0700 (PDT)
Date: Wed, 30 Sep 2026 16:59:38 -0400
Message-ID: <a55e2883ebc528b47660dc30f52bc602@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260929_2146/pstg-lib:20260930_1504/pstg-pwork:20260929_2146
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnacek@gmail.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v2 2/3] selinux: validate user MLS range and default level  at load
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260928165253.2388012-1-cgoettsche@seltendoof.de>

On Sep 28, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> user_read() reads each user's MLS range and default level but, unlike
> range transitions and security contexts, never validates them.
> Validate usr->range and usr->dfltlevel in user_index_check() when MLS is
> enabled, once the level and category symbol tables are populated.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Merged into selinux/dev, thanks!

--
paul-moore.com
