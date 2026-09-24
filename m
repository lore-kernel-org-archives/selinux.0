Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A84D4868
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285423; cv=none; b=WrG9WpFCqJnPOZlJ07scmZKE2NDo5/RVwioZnYBIgFNXoal3qoMSLKXGv3O0wqFoOjzEmX0mZbqOj5TpxutG45JOEIYA4catcDU/hGpuN3DQhqXf5VpZkp1GRpgpA98ilaJFDToP/Hcg1tVcxjNB7vZ9ognBncWzzoKuUz5DkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285423; c=relaxed/simple;
	bh=ItJwqKOKwNUEOmcIhOKHN5SX7IcD3o4feQcR9nlQ9K0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=TrOu+YiOasdJX7X0jib1k7JoIhu9ZFteeCccNPHBWNIi5je4NO7kkv9YwmJ1MCvD6kJ/FD+mMU+ThikRbPsKMsLXtJSlTx/4XGiWj1fzTcse+hjEwEX5LbaCz3d3e7ejt3JZvQy7RBHc13HUF9tBqDEBpAu84o0OUMXfuuqgkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gIodzDsG; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gIodzDsG"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9104649a5dcso3226196d6.3
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790285416; x=1790890216; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBLFxg35hBnjTg3QlcBDZhTFxykhaenuOm1EJEqDZLA=;
        b=gIodzDsG58/2lVv7IIvV3JeMeBM/ztiUa67WQ1B4sXkcaBqNqHbmbUU4JSFEhgtW3Q
         g+LxoVhPJJsCvTF/gM5Qcg9UKFN/kwJuyyZfYuCzQqTL5YxTGqNua688IJVPgCKd1sGa
         +M5RDwneT+iXAMcSTX7MzdLvi7MOxkRwmlFO/3RYoX3d0JY925klJ6YcR+04slO+8b9D
         PRl8iERNQVbdlnXFyn+Zr/Zj97gfaCAj6kiEPyO70UBUVBQGGbBTt/+IEzKnoNiniwS2
         YAhp27c97K2zEd0NKaUrIt9FETg24tJ9XABCf1YrKlsR+SVAvnXsh0mYKEREg4sl9N36
         gKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790285416; x=1790890216;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OBLFxg35hBnjTg3QlcBDZhTFxykhaenuOm1EJEqDZLA=;
        b=R5NtY0vNWAFkB4t+gBrwnt9lXu2UhFko34XctecWnHIm0TQTG/RAt94uOGU8KIiuG7
         dMkhsYHqNYLWv105VK/iTdM+ukrpmLsyDKBpRWe2rO3z5Wp7FOy3E7ORbaL9wB5dvTm/
         qo2BYTvGOeGZUIEuq1KLEvcf1CEWTNmPViDG1a4NdFmmh4JDu9XfQB/4fyx3Lxeb3K6O
         wooJRXubN4GT/nGiV2HC783zWAJ9zEIjRngMd7+B6u3UhIYMMaWZMXqrRw2z4mkowd/u
         HEoJKcC74UqtJ/T1nHxLtZlCMkF9tz3ar5l+V2VssEMqqpqBqMms5/bu1wAo4SUgXt2W
         p1DA==
X-Forwarded-Encrypted: i=1; AKwUvBxPJbxyj34spuofgZfR7YWBfWtPu6HcEuP7xMg3g/JoK1RbLASJQ6aMX0AdG8q0wk3x03JPINpR@vger.kernel.org
X-Gm-Message-State: AFuF++nabxjP5HIPiVL1KHFr46zi4a+B7L0PhH7UZbI26dNE+Ea1Tr6u
	htMJ7Zj/BylZOwAtGzFAk/sXYMe22PlwfD886I5YLubpspVHwr/08Dg1dh9fTMspYg==
X-Gm-Gg: AYBFou3QUyZR4wyj5Cml8vhPLLYl4lI/yMSGfIB9nkWxhAnETVfUqhdu+3DMNgITwJ7
	AdtHBrkYvSNEv1xWwVgf0EfVLQCl1UtSLf8oZG0n51UN5Xc3IHCNGAagXO9vPNfK1hhW2eYwkcM
	hh1vnt33v5m77zXfgnsONiy1WWmriiXJ1afdrZRzMk6nGqkCpnr1GlpAGsQnH+ZCHTH2y2MowiN
	W1Ndrul63qU4Dsl6YN079SedUO8TtVm/vHIlr4NdKr9152oX5MZUP2TGEtoc5w7QLm9JwHlvh8O
	rH1p7y99vALmYlECV6X7TdpUaGz5y8MeNnbQxHxhF5n7/U70rn2GHqVDrEfnLA/8qAm4cQCDINn
	sTXNfkYFoLxwE6py9nga3+2F/j/zrOuA2JxhLZp1X8grR6ql4buVfsLAkLO2gutwVwtgozZtxjs
	ggnrYaTzaBhpwb1yI4HJi044PtxKjymU2MkPxzEEp8XsvJvQhvFLVqVBro79y+7/+VPz6h/OJvX
	KTIyR+sFqikxY9Q4x/HFUzNbSQI3Qgpd52OndXJ2IY/WdRabKm2hYx0LTFTyAoGzl9KPqemHFw=
X-Received: by 2002:ad4:5948:0:b0:914:2be7:866b with SMTP id 6a1803df08f44-9142f92b29fmr10401466d6.32.1790285416383;
        Thu, 24 Sep 2026 14:30:16 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430e2adf4sm2705616d6.34.2026.09.24.14.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:30:15 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:30:14 -0400
Message-ID: <afa3d1bb28faa38291563424fc735585@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260924_1657/pstg-lib:20260924_1656/pstg-pwork:20260924_1657
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH 1/5] selinux: reject duplicate symbol values during policy  load
References: <20260903113538.72942-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-5-cgoettsche@seltendoof.de>

On Sep  3, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The symbol index functions assign unconditionally, so two symbols that
> share a value silently overwrite each other and leave another value with
> no entry.
> Reject a value whose slot is already populated, for commons, classes,
> roles, types, users, sensitivities and categories;
> booleans already have their own "declared but not defined" check.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)

Merged into selinux/dev, thanks!

--
paul-moore.com
