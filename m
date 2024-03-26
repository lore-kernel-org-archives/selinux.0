Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFD7173B
	for <selinux@vger.kernel.org>; Tue, 26 Mar 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485468; cv=none; b=Md0xM/bVlp3JwfndJBIyk+dQ08IlRxIucA9+lukbwUDY6vLDGUpk5bQfN14aRsM+cOgsFeg0W2aa9ksKmjtqfCFsPpJPKvl4HE3pp0cu4OdNG6G6NP/GKQMmx5ZJ7Qfv+VLUTS7qxzkMMBnBqAGX4I9RYjMz9NF0S3hQm3RbL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485468; c=relaxed/simple;
	bh=4+AjnH3HodgGF0UxAbRhkk/GBs7BCWGD23QG9+SSzuI=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Subject:References:In-Reply-To; b=q5QCHBNAfQFmDFWQRUmbJ7lbAhb0pajDA8QhmJ/RK3FgVrK8tpITjQjMKa6txfWBXAr2hR6UExNTlAI3aEVlKY2nv0qFDT2VdA1NKtO3CB6ZHa54Wqr76QWK0fHcvAKy3hTMwDYKY9v1wUPoDknl0LSE6p5Aj6h3F8caBY7pE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=My2BYcLW; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="My2BYcLW"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d436ab8a36so2141803e0c.0
        for <selinux@vger.kernel.org>; Tue, 26 Mar 2024 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711485465; x=1712090265; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A7ABXXdRES+dheUM9+P3CHRAqpJl70jZYqr5mL1Ww/E=;
        b=My2BYcLWaj9x9Vxwts50Bc+XkYrEkX5zUiItJ//sTDN7H2UqJhrUNHVb+jzO1k+0VI
         ZbsSgOoAC1ZIaqIqV7tW0nf6IofUdrbJuB2MS3ZQUhvBl7ClBF0D4kggOsqH18+UMiVq
         rD14tr0b4hsrQlQwHszM16pKHP/T5Z/Y2NJafrxu4YQeOqI9ZrULPT7D3kjlNjEdCsH8
         Ko5YSze2GMm+yS9OJMsSQmoZ7StqFXgtWKZiX6HObhXDvmcgOdkk8lNqyir3tJt+iDO6
         g0+mdAQalCvyBpMoW28rdlCjoI9nqDNLTq3fne0tmL+o9saVn0B797tlZZRuO2mFw4Y0
         Nmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485465; x=1712090265;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7ABXXdRES+dheUM9+P3CHRAqpJl70jZYqr5mL1Ww/E=;
        b=MkiFB0KHkpx3Mg3zKA2nAnzCl8uOZt5oixsPIYP4uWPc71rMLg8yt0clR7YKaRcDCS
         noIv/RJPtomhzHbn4TygXlnrzpZVvPO5LG0wBUtO10TwAT4owXlbR7iXOzyJpLuD4qcv
         sW5rGp1HFIAdJWsP9rwgx8n3OybwOBrO6qoESg9Sl6Dl7f/o66AJ6f22POO213+jXOS8
         iDMUpvNRVBbnDLfMsve95lCbGG8qH1pNxdYKS78DLVz1UPBBZenOSL9hiHcJIs+zt2c/
         VCRncUZcQb+q3aiTU86ls4nYrmqhHEtFZzqGPq5l0Er4wZ0gse9t5Hc4LAuhelEttA2P
         puzA==
X-Gm-Message-State: AOJu0Yy8fr95miQNeAzgY2YJO1d1Tbm5iP3YRPmRprn2Ugl8lNzYQ6Yb
	uuGQnllW9BZXYeXdyhBlhndUpfbUCi+ttu2skIrTJNwMyxqq7sF/BIJCTOTeLtZuHV+k5mnI7CM
	=
X-Google-Smtp-Source: AGHT+IF5ox/SbnEDRdmRGNaYg6ONEwxGVJdZeNXqw15oZRCVE0QCPxbz6lpd8YYQ2wNAEhLyBRI0kQ==
X-Received: by 2002:a67:fe46:0:b0:476:ef2f:10d9 with SMTP id m6-20020a67fe46000000b00476ef2f10d9mr7468627vsr.6.1711485465265;
        Tue, 26 Mar 2024 13:37:45 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id z15-20020a056214040f00b00690c77505bdsm5596935qvx.37.2024.03.26.13.37.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:37:44 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:37:44 -0400
Message-ID: <def2ded6147dcdf035c88a11ef98767d@paul-moore.com>
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
To: selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: cleanup selinux_lsm_getattr()
References: <20240223212640.305789-2-paul@paul-moore.com>
In-Reply-To: <20240223212640.305789-2-paul@paul-moore.com>

On Feb 23, 2024 Paul Moore <paul@paul-moore.com> wrote:
> 
> A number of small changes to selinux_lsm_getattr() to improve the
> quality and readability of the code:
> 
> * Explicitly set the `value` parameter to NULL in the case where an
>   attribute has not been set.
> * Rename the `__tsec` variable to `tsec` to better fit the SELinux code.
> * Rename `bad` to `err_unlock` to better indicate the jump target drops
>   the RCU lock.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Merged into selinux/dev.

--
paul-moore.com
