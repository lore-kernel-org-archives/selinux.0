Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF2320F
	for <selinux@vger.kernel.org>; Mon,  7 Oct 2024 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333334; cv=none; b=AqoA1wJDnojuZpHlG17L3sff5ey8YCqsYPKBz9Gr9vekpVe+VR6bjhJnZc+Ks/Ec5MenUXU/KGrKZUvqzRZt34b1D0ZnQ+FW+HpPCnSkndCbw3Hz302Cl1RKqGHt5nvIPH+X+CfiUU84x7ZoT0dkEBuu56+B/fSc3e8s02/EXnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333334; c=relaxed/simple;
	bh=byZc3hnvdVTVnadHbI3ST4OhFllo5wQxEw4wiFe1lwo=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Subject:References:In-Reply-To; b=XC2hzqS22s0B+CMJcErEYsAUshaD1eUQvPB3mCEord2hXJvGg6xa49oAQWQOkQW3t2WqihzKJGlNADmCBh4t8e/P8qEb5Ydv24lWt1oZtdrRWV9oq0rmeBoOYvqkbRJtTQzMaB+32gcjSPNpcwTXxUkq7twJQdb3ECF1CdOOYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XQsmnuOb; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XQsmnuOb"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb4f1137a8so33703696d6.2
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2024 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728333329; x=1728938129; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8rNQLlIdDiWwxROUW6wqKsIblGKvqyc1fdRu7Ep/4c=;
        b=XQsmnuObnMof7vAdNExxbIdt4QXRWap2N/K+ncVnzZ2gJcEfDtwI6i6yjOTA1DaEnz
         okn9eR5RC0joIMa/4cLvyu9lXyF7HzyXdmmiP64sf9+ThAvWsDxbF1R1yxZD2nz7V5Ey
         cYpw6b6aOIjgdg9cnI+1uTuTLjugs5rhH4pf4/2lyXULAF53NOXrRg2G6uZ62ycXSdq3
         fywsu6xqZkWK7iQHB2itcA+YSCxHn1qeRtZfeXk/ubxYahAA4cQAVuLZtboYGP+SNnnV
         woVJ1P2bbrQuAd0ZRSKfNwemuUoDgVDj28oBYEfN5NSVU0dmY/YkK7Hzs53aF/WqhvMz
         ylkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333329; x=1728938129;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8rNQLlIdDiWwxROUW6wqKsIblGKvqyc1fdRu7Ep/4c=;
        b=iLwPawO9a4xrFxyMLm6M9srUkUjJ7IGuOlzjE5sZt32VffPxoduf8GN75yorf2SDOm
         Db+sXiusi2AI1cvx+UZ1XXwJ22cN09m4oYbtUX7tYOj2EZxCogN3IhonDLhZoZhmIgHw
         +riDEz3bOsRbCWVUQaFSA1mAVY/i5H+vtLIW5t+4yYVktNhCrfUpYLZFQJ0gLpYl30IH
         vHc3UFRacmoiOK/Hbmu+4XFvEdqo/IoE6RGJGz0ZTPuLmVyzNeTQoEAaOIV+Y5NeE9F0
         /iXfMVeOVNPWQE9Sr8JhBJI2yYc53PyA/11K8lO41QlJ9edaDFNx+xrDYHtrh86y/7ip
         GxQw==
X-Gm-Message-State: AOJu0Yxaon93/r3nZXtzTZsuvxHha5sfvDcFsLsIzNXZQ3K5DNRaUXZI
	lu2ju/ZrnTawBak9NFA1UszQ/iqo2O4HsekPgaunmJ7KWp+ghqFXwzsD2ScImczu3wGOAc5xWMs
	=
X-Google-Smtp-Source: AGHT+IGKwyGst5rCUEvYx+y5XN8ZIcnkOhV18gclXzaX8sXoqae6x26NnqdmjpRDY0kRMqnMCXj3OQ==
X-Received: by 2002:a05:6214:54c7:b0:6cb:7e60:2ba0 with SMTP id 6a1803df08f44-6cb9a45fcd6mr211988246d6.38.1728333329447;
        Mon, 07 Oct 2024 13:35:29 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46dfc13sm28871016d6.49.2024.10.07.13.35.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:35:29 -0700 (PDT)
Date: Mon, 07 Oct 2024 16:35:28 -0400
Message-ID: <fbfa3eefa45b5cb5129edc531a2ad82d@paul-moore.com>
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
Subject: Re: [PATCH 2/2] selinux: apply clang format to  security/selinux/nlmsgtab.c
References: <20240925201106.16134-4-paul@paul-moore.com>
In-Reply-To: <20240925201106.16134-4-paul@paul-moore.com>

On Sep 25, 2024 Paul Moore <paul@paul-moore.com> wrote:
> 
> Update nlmsgtab.c to better adhere to the kernel coding style guidelines.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/nlmsgtab.c | 236 ++++++++++++++++++------------------
>  1 file changed, 118 insertions(+), 118 deletions(-)

Merged into selinux/dev.

--
paul-moore.com
