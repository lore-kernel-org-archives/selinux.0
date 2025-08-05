Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8823C8AE
	for <selinux@vger.kernel.org>; Tue,  5 Aug 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754429167; cv=none; b=CB6MlrW1N6VnYxwyEYxtkgkK0RkjotDiKNjeVbjDfFg4ypHo5iowVkUKlDqZgytEFUij9PhBIEoGuiOxDDKAK8q+28EG3eTIQ3+k/RcCmQCtCp15KyKLB7FHovv310WRxuwU/K8g7smYhOtRBrlf+2x4FXdl7NEWmiMrGSN+6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754429167; c=relaxed/simple;
	bh=YB+2P5AcS1SI/00X55KGRmvhjeXiZYqMsJERFTl1NKY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=fy6fgV5euUlUsBvni5x6PPSnCg1ORkMw5SjKy1N3b/XzFBzANdwdNU5AsEVtc3ChOng9p5SF4Yhih8qtDnIXx3P1wLDIoLrdrdr7Fzhpwp6J1TyX9T7cCceLAoFf2gyPYo17wp+94v+7thOqFmPCfcyWBOSXJ/gBkAtjxIHaO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XXw3OkBW; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XXw3OkBW"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e638975262so632832685a.0
        for <selinux@vger.kernel.org>; Tue, 05 Aug 2025 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754429163; x=1755033963; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvbhiDyr0vZog6UZjo4g7YPHdrZhoNzEXy2ckC2C0/4=;
        b=XXw3OkBWa9OH7j3/5MXXP+2m1tGf1HRjJzy94vAPJfJbyLUkJUEBpx4eP4RsMB0jnG
         /9/POXF+UrwkVrlTLOi6JsqShXf/Eu03PlKfZtFrJIbwyUfJrMacSNtvM1AM/PeIcW+7
         0BF+uWHeUd9JorBZpbuPoIJaV93mg5dHP17ghqti1hSuzy5WSM6b+l1Ru4Xi9bTrtlSo
         hXtFCzI7EGOUJO3wOQ5UefJzLk/DzPWElbTFlrXYCAr6ifyc+g2ZgmnFmGUnhdnifokD
         wjBbdLyUrj6+IfLuDoZN0phO0J1NoSaBQ7j6QKdnZBa0nP4sU3GY0oB1Q2mnhpt7bdjC
         G9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754429163; x=1755033963;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qvbhiDyr0vZog6UZjo4g7YPHdrZhoNzEXy2ckC2C0/4=;
        b=Sp3caeiXAan+2p8UUlbbKmC/P6tYSHaxj9wgF9AdhTKpOo8a0IAvGPGCMTls4oGD3r
         rR21ouprTQOrMOGIk8962U9QIMVFIZpjnGOJdV83Z3dOMQz6W3k7osm0eGsPd8mGeEF0
         a4vM+9rWUFfN5dbPq9nwZvO2gVA93xs4rvORhnic6IeJertWtpBg+ukT9TkJ5lRLQpJt
         TRPj7xe4cVdAxZpPvcC2vrj+TZjueBN7v71Oz4vSDCaQORPpyCYLwnIwyWtgZaVyDwQA
         eLfAeGZDdvQSblJxExDeYCXC49pCUdAphgkzw1pnTntPixCZgA/CfYKvGzmD9ESOZbEx
         WwQA==
X-Forwarded-Encrypted: i=1; AJvYcCXMRxr5pWYQvFQut9P6uJgdClfI9HJ2ukQ0PDL4F41cWNyspK54NPWELLVPyd7ETIW+l6lwm7M3@vger.kernel.org
X-Gm-Message-State: AOJu0YyZIBAkqe6B3p3sZOGDM0gqh2eEOw0H0trCWTcpihilpyrd/8nc
	jtoiZx3lkd524n3vdkGS/7e8MzGlasPPwIIFvbqe1/4Q9nUZ934qV0395/hRa/0hyw==
X-Gm-Gg: ASbGncs/4gZAh5NRiv9hAyN6VCIdryt5JpLuvwLfPrBGJggvs5NIycVligSwYdj4xWP
	vAQ5h3DnzjkBBtLMRN13sDvKAHIHXqrISjJjXYnOvC80akZi9NomwXt6wEteJrMfJVOzl3pF9sK
	CwpO9JueSf4w4MKdjUjW4GVjjL7oNCei37AmctFeU5/o8SgPnf8a46DU7TX3V3Ope/pF5zdRXMY
	vV5CtwHupCTIlabJrVSjLrmcn3zeDcpCR+7JN7MgSMfbhUzK621MFs+mA80C/LBShsmJ5FZU5Jo
	TQHn/U42dabnS3wGIECJQkTyhK+8KU0JzW0vsPP62Rr7mtuaidoQ19+1sULWaZ1FTixYzom9V2D
	mRXPttV+UzI1InPr+p+Eb7TlyUIy7KfV10h+C0hnBkOWmMn6OEoDJ3qHvbeoCvQPtexg=
X-Google-Smtp-Source: AGHT+IFOIToWsJNGaGahUbxiQZZEXvXgB0PL58qiQxs52JuvL3CY5dR7fiVz32RjfQYdXWbtvYoPsg==
X-Received: by 2002:a05:620a:440c:b0:7e3:16b7:bf26 with SMTP id af79cd13be357-7e814d067cfmr123967085a.4.1754429162986;
        Tue, 05 Aug 2025 14:26:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f72f75asm729478885a.59.2025.08.05.14.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:26:02 -0700 (PDT)
Date: Tue, 05 Aug 2025 17:26:01 -0400
Message-ID: <f68d69329455b0cd7e69233547a78a8a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250805_1541/pstg-lib:20250804_1752/pstg-pwork:20250805_1541
From: Paul Moore <paul@paul-moore.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH] selinux: use a consistent method to get full socket from  skb
References: <20250729091044.95411-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20250729091044.95411-1-tianjia.zhang@linux.alibaba.com>

On Jul 29, 2025 Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
> 
> In order to maintain code consistency and readability,
> skb_to_full_sk() is used to get full socket from skb.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/dev-staging with plans to move it to selinux/dev
once the merge window closes.

--
paul-moore.com
