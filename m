Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3781A83E1
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305213; cv=none; b=UaTPR7q+/QqGZAQPPVVzFwsibAm7MRb0C4EmO0efgNW8VpiGRwLR7jlKbbx+THFsufPUBjXNf1suqY2gDTIpNM+9rZTmy8j8fR8bnejyYDdShYvG/upNUmuW6Z+qSqNVQ0R2PZrED6l72GpFw6WWrG6lcxDH2UF4togEvExphU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305213; c=relaxed/simple;
	bh=dpW07r02+vAWiXyYKKllW9tQ/V7+u4ovL/HDCCgJWQE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZnHiyW5Rpuj+zvsfcEcp4jyo1RekKKEeur4D9zUpz2g5vsqTMTTZgfutNtHgyt1s35nTnBlnEAg9yeSzdF2GPik0zrrAyLQ34wskXvZM+sDYOUDasja+0lDNf4MFfHpUa/8yNX4oGFOhaEKRXqv+XRz2ECN3CtSOgcQrb9EAuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fgm0g4g6; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fgm0g4g6"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6f19a6c04so1386122985a.0
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 19:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305210; x=1736910010; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpwGF4ZPc5zkh/c6DMxwRDr8v/VzMYpFaykW6r71bZk=;
        b=fgm0g4g6k+0FU8jqK1L8bHAW9FGT4neDqBz5K5XzMJKI9R6q1+sKFVzovb8syq2o7r
         Aq+o+R/VAYdQje1xQhF12D5Kcv/3Q5R5+PRsPpSZYKCttM7PMxfUGiVnytfMs0Krm0qD
         3BRpRy1oZKA58V8uVVOQqpoPmUrDdYy/TE1jpOUHNMNGxoH/Lu5Itcs32xtuxhgKLgUI
         kOTiV3g/Gp2ltWkPCR+FprgxnBE9JJOntRAj4yqoz/aX3T4CVaGJyko0K9JXGJ8LDwhr
         wREJLc2z1MWxwDi5tAAoYbG7UT9BXnvXXb3n6kvtNJAb7+0zVTevzGLL2A3FDGXyPUCO
         o6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305210; x=1736910010;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zpwGF4ZPc5zkh/c6DMxwRDr8v/VzMYpFaykW6r71bZk=;
        b=v5zokre13WRF6NlgH9LM1oZKGgkAj1Y71yrfXI+lpkVVlwj5ZSFRfyTUBc1ahGi3hZ
         2NnC3MaRTA8JfkAXF+CpAVG/Ct4nE6ZRuZMVylSYcvRoO8t+wIzY9w8szP7+tTaQUZOs
         wLot4oE0z8nlDfP5VHF866tThOtZa+9Vr2KRVBTYZROu+BnCtMm93AyqLqTpsok82jOg
         AKeDimBRWYbGmgQ81wL1Mhk4XZx6hPzL0FJ+g9WrTCssRcLjVKiYuHY1UKcVAuu8cPjM
         3bfTA/AV1SQg3GiiQtX9ZfbcDS+WkICZXbIfOtXJhuCyRftfK2v/ZQW8yQ6yDBJ+qwqd
         wwkA==
X-Forwarded-Encrypted: i=1; AJvYcCWpP3l78C6BmKUv9+Llw3bQ3IbQjOq0o9K15xuev7ZIwRpJiqAgqk6zxuPtOg3xPdejBWLzM5fE@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGHELUwql+QvDz4QLZ9JTxUIVHSZqGI8CU2l6wpgikQ8hRr1m
	/o6N+w+lyFckFcHlyLxiAq6DrUWE33LP3NGV7OEdiEKKDKqdqizG2JbZ1FKxHg==
X-Gm-Gg: ASbGnctoxDfL3rJqXhD9n+tcX5x42HY7o6uxcxhWqGuYjZ6C8EwxsUIhMy7wqCQCXa9
	/mp1/KC9Z/Ks5WdieLwIJTJINSVjpQ2Ar8MtKr5oBz0SKWWkIgV3SOfzHcThVPcskPI0TC3RJYB
	AuHMMD7oLfnNdbYj4T5IDGwIGY13oEawBahaZPSIceGUoje/Yx+iCZeoao+1klHktCvDVMQvuKF
	pugDyDe6YDrulaJ60iLCmzvbW5e+X0csNcqc14yXaX6hVcxZ/Q=
X-Google-Smtp-Source: AGHT+IG9lHm2hSXpL2ALHMVYpNGR+NPhmNlgxnbcIWTjNSbgzaPtBoqVZFBXmmBFrsxuavT1v+9vtg==
X-Received: by 2002:a05:620a:240d:b0:7b1:e0f:bf9b with SMTP id af79cd13be357-7bcd97afd59mr145106485a.45.1736305210186;
        Tue, 07 Jan 2025 19:00:10 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2f8fe6sm1637237185a.51.2025.01.07.19.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:00:09 -0800 (PST)
Date: Tue, 07 Jan 2025 22:00:09 -0500
Message-ID: <e1e67dea8520f71bc54377a93e26d849@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250107_1610/pstg-lib:20250107_1603/pstg-pwork:20250107_1610
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH RFC v2 19/22] selinux: validate symbols
References: <20241216164055.96267-19-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-19-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Some symbol tables need to be validated after indexing, since during
> indexing their referenced entries might not yet have been indexed.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 94 ++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)

Out of curiosity, have you measured the policy load times before and
after this patchset?  I'd like to understand the performance impact of
the additional checks and validations.

--
paul-moore.com
