Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D09193
	for <selinux@vger.kernel.org>; Thu, 28 Mar 2024 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711584538; cv=none; b=NZkRS6PfBt2tnH3l8CapFAx98LRxKJWl6ojYDWNq7Mdsa2md+vuJb7mgjOqX7f1DIE5XPKVWHJ2SkCmIZhT//95L1TysAh4HRphru1zUYdwHnxoJVzCGLoS5Zs6JnKmoo4yyhMnhlpK5CU5bpBJ1SmilT1pYt1lGNQzB6PbnBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711584538; c=relaxed/simple;
	bh=+hVgvJhRkV9zAky4dYe3lOHAIoU37e/j8bI++LQDzpM=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=a/Trm+i1WrFrjptynIxZp7AYU5xlFXhPPunAWmdzTXeagJf/BI/AdSn/YgEM9u4B40xiLQZG+E+Tt0bXOWu6wfQZUaFC9C4UeVe4MT3SkY4YEdK1TJ19oqfGXgSm9l5zzDJ5CCIiSvL5t/VlNoVG+VCZp4LMukmQQjbFkxBpVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=etO8HyR4; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="etO8HyR4"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-789db18e24eso21562585a.1
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 17:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711584535; x=1712189335; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hqu5KZ7ANiufBKIVwu8ItEdmpm8TUn3oazGE5q2jtwQ=;
        b=etO8HyR40NrGl3wB4MpxK+0TU/OOsBLu43JRTLcH4VslHBbYjw8X7N9foIwpJ9Ua8O
         EF9+NzNG7IzQchCIJsFZLG61V7PjxCHoX7opurPv8az1jH8Brvq2PcvBvMsANCD0f6X2
         bk/LhIgtXZlvTG1ot4z0BucPeBZWgKpXAe7T3MRmlMSAVbozzqvihr87n2ud6qN6f5E3
         c3VfbNuyiTKbwhsrG/nzlE87vkyWt4cGfz3nWwH9oNe7BGt235q8i+u53X7BVDZnZ2iN
         FQ6s41+YSvATGuZfUDBNgpor/uLJ5FqFlxmLMyL8WW9rhJzipwty0RuWNWrEynDQfRm2
         tUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711584535; x=1712189335;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqu5KZ7ANiufBKIVwu8ItEdmpm8TUn3oazGE5q2jtwQ=;
        b=pw7rYZMw9kpHLqtq1iTZqQbM6sFpHKlHQVvu/1fELG3nTrdBi8g2ZUKgKIUiL3opBX
         QW5iXEdNMA3Z0kmaOTaY0QqeJdMlbG9zao2FU79UMCcHWj4+Elj5IGuVW+YX3n4OjJw3
         LfyyhRwHI4l6GCcnJZbAoam9N+s1Yv2+naeIKeY5A3Bx++/bI9YI0eP5caNUcW59W6zc
         8MTlAVtBXqWiG29fbHDoPxyIhrUZRcKhQwXX59l5VVwkWoz6XEkZiqewWVpTHQQkRKGq
         6Z1kF6H0kq/5n1T7MMjm5eySaqfkYTAaKRt5OplnmlmRiDQOz6VaYOlZuGBeuENb3vWc
         cikw==
X-Forwarded-Encrypted: i=1; AJvYcCUcyeLSxSG7Q0VznEi4q0nBraOlkUC/dhlR6r5dpXa1ZWYZoF4S/SDvjR3v3gF18spshbWAhlm2UCnke8xwm5x3UDII7zw++A==
X-Gm-Message-State: AOJu0YzyouBSVZaPII7FAtX7aL79kaMnmYEbHsUGG+djZBYrkzALmcMt
	RDNt+nQ8F9gLzz7ksDGZBtE4CyZV+NMuyl3cY/O6f1Nyp9dC1fgv85wuNS+Ggw==
X-Google-Smtp-Source: AGHT+IEuIiA6yL+s6fMX+s9dyz58T/Y6tcHTA6rblF3C6b6P+/XkoqUiOpYvjDoJ26nVCFVeRsH9Lw==
X-Received: by 2002:a05:620a:2016:b0:78b:b5d4:d86e with SMTP id c22-20020a05620a201600b0078bb5d4d86emr760810qka.40.1711584534784;
        Wed, 27 Mar 2024 17:08:54 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a146f00b00788481cdf4csm111872qkl.111.2024.03.27.17.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 17:08:54 -0700 (PDT)
Date: Wed, 27 Mar 2024 20:08:54 -0400
Message-ID: <54c3ff6d6a7c8e8aed0e5e3facf00271@paul-moore.com>
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
Subject: Re: [PATCH] selinux: use u32 as bit type in ebitmap code
References: <20240315173234.637629-1-cgzones@googlemail.com>
In-Reply-To: <20240315173234.637629-1-cgzones@googlemail.com>

On Mar 15, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The extensible bitmap supports bit positions up to U32_MAX due to the
> type of the member highbit being u32.  Use u32 consistently as the type
> for bit positions to announce to callers what range of values is
> supported.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v4:
>   - apply format style
>   I hope i addressed all comment from [1] in [2].
> v3:
>   - revert type change of unrelated iter variable
>   - use U32_MAX instead of (u32)-1
> v2: avoid declarations in init-clauses of for loops
> 
> [1]: https://lore.kernel.org/selinux/67cee6245e2895e81a0177c4c1ed01ba.paul@paul-moore.com/
> [2]: https://lore.kernel.org/selinux/CAJ2a_DdLR40CB6Ua5cNjYhtexNmGkzQRsVrJn+dhVaZO-aVKsA@mail.gmail.com/
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/ebitmap.c | 31 +++++++++++++++-------------
>  security/selinux/ss/ebitmap.h | 38 ++++++++++++++++-------------------
>  2 files changed, 34 insertions(+), 35 deletions(-)

Merged into selinux/dev, thanks for following up on this.

--
paul-moore.com
