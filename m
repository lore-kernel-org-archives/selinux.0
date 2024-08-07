Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81114374C
	for <selinux@vger.kernel.org>; Wed,  7 Aug 2024 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058080; cv=none; b=XfkMwyE9uBHddzwf2dglHmgY5IZN1olCm8v2k7Gp4zhd0nirHElHbRBsoGchBjey+yo086vTRxs2NO/zDpkxltLwK2vXcJSGHkctdDWu04rn1e6+ncY6az53yPC5ETFuY89NAuY7JxwmzTN2uUViObD2I+mvpR6SePprN1Ig9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058080; c=relaxed/simple;
	bh=xaphICs5Q06Pxl3/IEzJlNzaEmSgprYwNz0lwF3xxt8=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=FsHfqebodPOQSGLHFuVp0DTo9qxtvzZnULgcEso+Z+rZJNM/rGzg6MetS0NJC4PfNyJFPS8JlyaEv3aW1eLffFDf5FS9X1Dcn6vpzX3gTwF8K3KLXyxzm7bIMn+zqsjKrmHdZw4lz4gSUUNdJO2V0ZAFdQw8YvcQwR9unYYZZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d9/SM6vC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d9/SM6vC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d7a544e7so14285885a.3
        for <selinux@vger.kernel.org>; Wed, 07 Aug 2024 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723058076; x=1723662876; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YYBRYs3ScUjdJGDBgb73mVo47iVS/aXnFSQhEqBnr30=;
        b=d9/SM6vCRRDHfKLxhYmFJS5QRwePC2bxRIAoVvIDF/cJVW/Qcd5V3945QoRjeb1/L+
         Y9aTuH+dx2HrnVDc2KIfmWSFmPpK9oEGcEVYzD7qV2yoqxWYS6NUOgGcOaW+L/lqwmVF
         NuNl29uob6ZWbBME3lVRGQm9gnvNcAjt5XhLm91Zt/X69bHsRbAZ5RiYEHINnPYPLXRr
         xIFicxDFYASVeWt6PGyo3c4f9Ee+0+4joTmArvDNkuSrWSCCl8H4DhUOvFcJBpwZkrap
         wNaad+0cAkU1DOVPjxn383RwIZigEAauKHkupNywNZOti+hpSK0uMZKXfxdEd3HioKsc
         rY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723058076; x=1723662876;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYBRYs3ScUjdJGDBgb73mVo47iVS/aXnFSQhEqBnr30=;
        b=YAswo+JKDEU82Bg/IGo8DNnO+BHKnyVMNUs3UbpqRoaAB27RNK9CgYh8BvRwiaGmFa
         RcyQ32XQM2IktHypIERqsENpJG7Dc0oJYB4pbXMxbn4mhoqqNecwF450nrN8zGa+59NT
         Gf7K3Ii6hyzBuSnN3hYJYkqk98dH3Wpc3lCYmj3nRLktT175yj+LIBf3tSOrAQo6KObg
         ImB6r8rFFVrrB+YS4BuSItyISWjvXcqd1EPbqpBL8/cAk9nTO+B+EOql8zH6BVKLtWd7
         SQEkiCePnp3NVkJ9p0M5UQRGYlAQ8g58qXEQNCQVAbKSrT4oZhqxwj0r0ztjC2KyifM2
         z+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLOss7nnheA2Tc0R978Px3Cg6Kz3Vhh+U/SXihblZid8VnYDLRTWEaCxL5JRuA5V2/m2AwQwgBbozmgwhqUo2z3HMHQZaDOQ==
X-Gm-Message-State: AOJu0YzAOICbKCV/QQb6cD6r6vlnUN1s0hoHpL3vsnCYv/mNwjC4GG70
	kef/iMA5ieeMITV7gvz3R1BuC0ZGl557prmx1cKeL5RTePWRMIW/FUyO56JtlQ==
X-Google-Smtp-Source: AGHT+IFBzZBCHQuNdMzqsBwmQeYawZa/Fonhzcxk9qUtThYJx1f5gIFH8iSWPt6v9kTRQLHjRiDjAw==
X-Received: by 2002:a05:620a:24d5:b0:79c:f55:4fd4 with SMTP id af79cd13be357-7a34efd9390mr2390781285a.59.1723058076196;
        Wed, 07 Aug 2024 12:14:36 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a37869450bsm85820085a.76.2024.08.07.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:14:35 -0700 (PDT)
Date: Wed, 07 Aug 2024 15:14:35 -0400
Message-ID: <7063e0206fb6100d94114db6f8a0c538@paul-moore.com>
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
To: thunder.leizhen@huaweicloud.com, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Nick Kralevich <nnk@google.com>, Jeff Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH 1/1] selinux: add the processing of the failure of  avc_add_xperms_decision()
References: <20240807090057.1334-1-thunder.leizhen@huaweicloud.com>
In-Reply-To: <20240807090057.1334-1-thunder.leizhen@huaweicloud.com>

On Aug  7, 2024 thunder.leizhen@huaweicloud.com wrote:
> 
> When avc_add_xperms_decision() fails, the information recorded by the new
> avc node is incomplete. In this case, the new avc node should be released
> instead of replacing the old avc node.
> 
> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks, this looks good to me.  I'm going to merge this into
selinux/stable-6.11 with the idea of sending it, and your other
patch, up to Linus tomorrow, or potentially next week.

Thanks for your help!

--
paul-moore.com
