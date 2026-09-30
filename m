Received: from mail-qv2-f30.google.com (mail-qv2-f30.google.com [74.125.230.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181115187EA
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801985; cv=none; b=bgMTyy5qimL2Xg/xHgJVZBca0cuJ8vPvy+9FVKJ1yV61XRszBQUHqKyLCR9ti7kp9NheoogAAhfoKxd0zve7ia7u2qxBG/WC4Lmm1O6RpgoIzmGquNtUm7DrJYvETcZ3+4Gf2g4ODoBN1vVBd3u+XtP7d0+kFykwyaCUTSk9cjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801985; c=relaxed/simple;
	bh=Li2hp7CJYQtBBs9pKoX1qIVbhU6BSFYMktBqFo4Nslk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=SDHUa6Y0Q2O46XTff513F7Dq5A+laQDZ8FU3LiiBCQAmk0YFSMMWIn/PRCDRITRzT/fP0ftYHmGKJLnmIzN5Vam1NsFuH2PURTu3Hb8o0x3X0Ke+3rv9bSVXP6e1XRP1FjQgzwlJGFiD6PsnIPZP2lsru42hykXzznOgsEUKlYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ej9CEeds; arc=none smtp.client-ip=74.125.230.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ej9CEeds"
Received: by mail-qv2-f30.google.com with SMTP id 6a1803df08f44-91795ef1d14so6821056d6.1
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790801983; x=1791406783; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qE7JGiDSoM6G5VdAMXTQRNtQjhHQOullsIdc8uzGCQw=;
        b=ej9CEedsDAy58xFHlveISQui3j7RqqTUCZs5hgycdHr/LTsgFhsqWl6AML9e88e2PE
         OmjCJlBmC5Pc9UoxYfWBMVuz3FZI7OC8mzR9i1rP2t5BJGKdZ/fEQ0e8O7j8VYNmZKXn
         hdI65s8p6tpiQUAKjkOmaYc9/XSfJl98SaGJohcoZU1d/8AQflVX9+/ndP+MG0vBgmA9
         BpUU1XL6aAtgtgH9Ses/GJdheZTtFZ6XnfFD24HORYO03zuMK9M3X+tYgrwuW5KiGgOV
         xheBBex6ppBxf67iiYxF5/LrjUe2Ko5cuYFQs7jRlWkWclrqtBAvmq1fTw37t4qWeFct
         b50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790801983; x=1791406783;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qE7JGiDSoM6G5VdAMXTQRNtQjhHQOullsIdc8uzGCQw=;
        b=VWKNZbPO2M8zZ5yFcr3VroEtoRw1kqm1qhwH6dtS9s/w0mfjKh0N59qULqCvCzmSqK
         Fwci14oFVJeL4M5DHoa9QPNvSmf++KYXiDAXwMe6ex/9uCQOmL+UDC6Dj0bdYvwqs+Oq
         3nRPwN0cSS9rqbbiP/A4FrdAv4Gn9Zt1TKmYFvWW2CQPg4Zny71kbX18GlzsrQgm4n9w
         L2Ri8aNbX101GOuijiF5eL5JvTGoU0OtVCxpzqlHH28ehEqhhwgPWlaOxbbcYOHRdqJu
         9X866T25qAf/AMxXHDrGwWso1hdytr+YNjnzQ93xQuMajMu3JAGVejaA+qGOg+/M5UOt
         e7HQ==
X-Forwarded-Encrypted: i=1; AKwUvByDKVMgPLfMT5pERJvfgJyQBmeuy+Hy55gBHvYw7JFF6UkIFKoVAxAk2woa1n9m3RiAXCbIcqLr@vger.kernel.org
X-Gm-Message-State: AFq9FYID6uS/A6j+zI3UZPZ6POeJLc1LwigClz9ZgQTi2G6iCQ1fEQBw
	ZcSQTfADNZHm/rnmv5T/6kOAmvQxXbGTHEBCmZMTE3tmuU9Vi5HoSmwPRPU/jHqF3+KSK5ZqUVg
	scKUaUA==
X-Gm-Gg: AYBFou3394Z+50pOL1mV7J5k/vWFQTshHfbju7etzsE3MUQRbF7m1nZgEBwFNhxtaiM
	H+KSOPsndLWz5tgJe+q11Yo84YqjYTDLv3L5TqW0pY/s4QCzCWIdS3X82jep5JQeH24D8qDX1fA
	lVTw+yRC7OYrlcnOWIEIGvqRHi2xPCNv481XfBxegLMs5M7lLJCxOYBntlRjM4lXwa6Mg5aKZjn
	Nj+2KPlx5zmIpxt+FYUWjT7QxcRVRky0nwwdF3UtEiWze9MtYRsQCXQDz96ecx48CbV+XJNgVIb
	KDhr10hS32YXJX9sgs/5rnKuvb1PeMLzURv2rqvriiJFvkPdJMDCwCmnn3HbpYkQOXHaXZDFOz9
	wzDTf8010lAZiSiNe0cMjTmT95K49ZFa7x5hghivDN7OTU3x/klVs+5zvUtE60wAsTOmjleAlfv
	8PVHcGlb07Zndzk+I+8SNZu5MM71q3AjUg4Q1bF9b6k7nsN2PuMNhWFj+YzMCTWHxX1rJQBKFlu
	9oay7s3hPFzfc1blCHwD5msAa9OsuqAJ16mpW9HcZ9oge0DmYJYTKfyAq5nFhj5wwfpulk+0Co=
X-Received: by 2002:a05:6214:5992:b0:914:40f4:d4b9 with SMTP id 6a1803df08f44-917aa303f08mr16434146d6.12.1790801982874;
        Wed, 30 Sep 2026 13:59:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a4e9d1sm8490116d6.36.2026.09.30.13.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:59:41 -0700 (PDT)
Date: Wed, 30 Sep 2026 16:59:41 -0400
Message-ID: <7f21bb964f2fffe41597476653515ac9@paul-moore.com>
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
Subject: Re: [PATCH v2 3/3] selinux: validate permissive and neveraudit map  types at load
References: <20260928165253.2388012-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260928165253.2388012-2-cgoettsche@seltendoof.de>

On Sep 28, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The permissive and neveraudit maps are read as ebitmaps and indexed by
> type value, but their set bits are never checked. A bit that is not a
> defined, non-attribute type is silently accepted. Validate every set bit
> of both maps in policydb_index() with policydb_simpletype_isvalid().
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2: inline block scope
> ---
>  security/selinux/ss/policydb.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Merged into selinux/dev, thanks!

--
paul-moore.com
