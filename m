Received: from mail-qv2-f37.google.com (mail-qv2-f37.google.com [74.125.230.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4C4CCDE9
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283881; cv=none; b=WgNUs4jzSZ+brvTRMzJCY+cIbu00d3KjhCRA+UjxeiDTPqKpu74brWaFYRnxXPWTMwokS4IJAqwVVlSAyl1biLcsogezumXYV86L2wdYJ02PFD484UWorDW5zSnhLNNe5qLowaXJSdd3hP4ymjN0ZtjBsThWHFd+11hzQ/FR1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283881; c=relaxed/simple;
	bh=vXgqYa+Kbk8KpgLNpL8hFAAFCtLOmSW5TJnV7bAjdOg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Vv5PoP1VHMKHTAxJ1zsr1aCbNEz1ApELeupPBxHEWGV92qZAYmiy+bQxEjNoavDfJ14gErdPOcXWIHqt4jsdlgCpiduSUyDAXdM5DEd+jnmEQXNZZDkAp1WgCCAj9jq77b4619ebqmrKVqMr4MvaTFjeqI4iE2nQzuL/O8Lx0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=INv8UXiH; arc=none smtp.client-ip=74.125.230.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="INv8UXiH"
Received: by mail-qv2-f37.google.com with SMTP id 6a1803df08f44-91235f46716so2611636d6.1
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790283878; x=1790888678; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/fwqzYOs9AMS6dCQQhw2ttehByMwOHbA6DlK+I/gQs=;
        b=INv8UXiH25ZpB+3iH0cGloR27iHGwhbLnQ4oV3Y3wdYdN+CqUM8/52g9rmLPi5qh9F
         lW66sKAz8rWJevWtHQkkWM5al+SdC70x//iTfnv9PnnITyqfQiPejtmIdJqZYfJjXmpY
         BNigqkLPt0r52j6z0H8+l5yi1EmwJjAUGoQvD60zAjSWEHtBx8XVW33t6C7jd3AchFTO
         qJNz7j6EG00hG31XdjMvyBYILBCW9p+TXugub2x5hypXpzDTwXE8KNyNwX+wujeNW2DK
         vcaAGJLyH/CEqXUBdHWHCb2dVWzKVCtmDxu3yVPrgdvTgcGA4FtKtjzLU12iQ2eYR17l
         6rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790283878; x=1790888678;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/fwqzYOs9AMS6dCQQhw2ttehByMwOHbA6DlK+I/gQs=;
        b=rDewdphwrPOGFFjA+MM8nw4VA7cG0srZ6Bmy5gO0lMVbpUasfUpqP0L60a/q6KsVw0
         RCAGaICqvXpslBUAMyTDXz7QnDF8kok5wt1CRFW+pCujGSP9B2Wyx7Y8FfLa21YjM5YS
         goc66UFjPl0JpUVjOGtyv2tX2q8myiRY5s7m+jfidz9sp94Tqkf8KASEDSaIWn3ztaR9
         6HsA0+Fk1kvZyhCJ+KRf/7ewubihjxuBxQ63xMa6TZjh1SbwQlCDxPxcQTO1Z4VCJTKk
         oBq672XHNEMlmTxUFkTp1uoTN8Gc9AJkh6GKzARkuUNttcKMNkEmps3Skr55x1OL0oc3
         ZSKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYfj76kbtWxuYemfec5+29ZcX1hQQSCXo6y5Rai5vMcM5J2ys57dN1WuT+1WnhB8BDaEKv2a+v@vger.kernel.org
X-Gm-Message-State: AFuF++l0QhkImqcb6/ugPwIjnHiPBQ1J5Dew/gERRxOQmmh2bQmsRoN+
	p277u/wF86/L9glAYHj9Ceh1t6x1DIkPp6xTg7/V6cPFC6krnPDDwaeXYG4rFzSrYHyQwBDdRuz
	mtSuSsA==
X-Gm-Gg: AYBFou1oGLy2npGM4mkePMYIkqwqw2TM181qq8izylkyUdb1qFEy0sDDGbV8PqRSpGw
	mhMzw4qAtN2vl2iZBR3w46UY+MQYgWlrYUm8H5VSzjkU/RMPKHxFKGAA87wbnZ9P+LSzomcHYL+
	ucOOh1RKNBR4bUDq0bLMq06tP7Zp7yz81/KAUZtDfM8m1s+2kMQwdi9QmHXahNBCswyWyVUVaYf
	HGTCHEaQeZQStUtnSfeTvrJoDkzHQpYR6GoYYRGbcyF2zeicYfNn+fJosUMHp9ra4Od9JJ1eUa5
	bUh4K3/CfmzUu9h6s8UNCBVzLlvOvBrfYPHNNq0f/FtPpCbxszwf6PUW6fwJpVbRnbviX3QcpSM
	Zo8lbvO87lSWOv5GQEP3ZXGv9ntBIzNFExzNk0emxiSxuWkUh6eOox5eVZ+LyutIpKkiJ6nXsqP
	KeCpZacEP9sHf4I6bvthdbTpviJVf6Wv8dFTPrY1Iv2GiV2eUvD4bDryWrrvQPRP/76aHmb3bHW
	jW2V4Q7xw75ggeVpElZZgszGqb9YzFrXiU43fSmJDRj8v2EIbQXFNoG3aJ5rd9asn+Hc7euQC4=
X-Received: by 2002:a05:6214:2462:b0:912:3162:523e with SMTP id 6a1803df08f44-9142f635c8emr10010666d6.8.1790283877991;
        Thu, 24 Sep 2026 14:04:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430dcba2dsm2337036d6.18.2026.09.24.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:04:36 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:04:36 -0400
Message-ID: <684d34ea7bf74d3d8308b4bedc714c17@paul-moore.com>
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
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnacek@gmail.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] selinux: constify avc function parameters
References: <20260917141317.54719-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260917141317.54719-1-cgoettsche@seltendoof.de>

On Sep 17, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Constify read-only decision structs to ease reasoning where decisions
> are actually modified, and where only processed.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c         | 27 ++++++++++++++-------------
>  security/selinux/include/avc.h |  4 ++--
>  2 files changed, 16 insertions(+), 15 deletions(-)

Merged into selinux/dev with fixes to the line lengths, thanks!

--
paul-moore.com
