Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D450262FC2
	for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623585; cv=none; b=qbFDsk9ZDFy0r2RLiaym/W3O7Xqu0TitPtvCZq292/vl083BKd3+RGWPhmlCVBCGEcCkUfHWCLNs+mRdOo+XpBt7npG6ZeFGQ2p11IPr1D+LfVQUaGRyR3iJckohkiYNcrLLAtyQFJy+MYHUDED0890+NbbJkOHO4j0C8BWZwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623585; c=relaxed/simple;
	bh=kdf/opkiaPi1wbVEP0I3N1fEYeXIFC4zRJ1yWTUzcGM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=XZWxgeoMs+tXevyj+ZdYoZ45m3PmF+hpXyRhVmb5Mq8AUPhnELN+lBYZikd+SIvgsU7k5t8Z70fhYolgruX7fyF4Acc6hqBcbTXZeISH1YkRSda1v3AtdfxsZrp2cjTgI7J8ZPz68/YX4XVeW2StIf5iU1rfEG9QPHPx6LWVFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RQEE1ssg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RQEE1ssg"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-811ab6189cfso110836385a.2
        for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757623582; x=1758228382; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNjmDRDjq4fT2fMT3D8inrfJWhzOs4XStOtEvDIlq+k=;
        b=RQEE1ssg9tNWnmRFeE7A96Fzx6pZtRPjKp1JAbXDBCswEBlUgRP7c1G2PT2ISmhAc5
         0Olmt7KzEVn7wJJh9JIFZY/0pv6158prccb4FiT68m6hkQojGReCBsd5pI/QFMYyspZb
         8eoivlZFQTcxZfnJYDBt+C9/0BgKIo7BfP0xbg1d/pB8MSIvZHjP0k/hzwjyNV6ei1fv
         +meXoOCBWb2DCUrf2hwGTN988wEINIwDqdCFqNI0mzfHj81dN6mkL5WDpn92khcVs5VN
         9sSwbQbRpJGvrlJHi3ODgitx3QBFZzgwIvzICb8uZmKFP0HJjhfoVlmLfd+B8u+TNI9p
         TViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757623582; x=1758228382;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tNjmDRDjq4fT2fMT3D8inrfJWhzOs4XStOtEvDIlq+k=;
        b=jwoBb4kNlGItmENpfz7pN3+xXU8tBXByGk7zm1T4RzXq6LPWwzY1qUBmWl50id20MC
         KccopMJ3et9tH/2nnpfM375OGiQc83MHMqIlTmzVDX2nnvQd+EE8IE2nDp4/GQDWAE97
         xrlgFO9scpvjOMI1yHx/tgisEY/b6adIYoeXwSj0bZrGXQ+DLCHXGbXq9JtzKIvRl/zo
         8M+N8zCqJHYj60IIa5JWJCWQdqCSDWvN9axWogbcIDv2qG4zV9zmqavhC4USPuFK/HJc
         YsOVTB7enr4VqIA6A+RGBKZYzFcb9QnXa0+vIi1hMLIh/LhM9m4oBSiHvoBdJ7veZfrU
         Sn/g==
X-Forwarded-Encrypted: i=1; AJvYcCWkak3qUzL26bc0sf1w9wkGfk7OYXxxkyIAA4ItxbBExG1tY5XDpKDh8f1twW1dp1b4VmZlbYsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCd4xyxwcB1iqtwippc2adbCXNxH7tg16HGlA2u+uqQnMrrFN
	BBnTmxRwFfMOj24geupcnhJY1JNunsJ59E43NcOec2OlGdPbjF6mZ9Jrl9Pz/eMadQ==
X-Gm-Gg: ASbGnct9Z0KPvh2dUsOWnwH6LfXyEZxFUgtyMkJHnKMwFyebArxkfKsMoXbKv8NsxLG
	1hovuBMp9lBpm5y1TLcYb0KDHxSei5n5emvOifNsyShx5NxDzaapUUkUJcBPFX3wZPygWezMstA
	wN42aXb4YC3JIrgIMm3BfRXOShGvrI32pMOo3ImM/8l8VHXKL4VSO4/KIrPUnfe3S46V2uG22qf
	+RjkosJGtNV996w8kdCANn9s3J13NHaoV+dQCnqLW6m7EK2kk6REjPC9SE7KpJ6rIMaxRo2qjS3
	8t6UxbdLXQtRfUaQhh5lGXulSLFHph57ZAGF4l/Q4Evb+e+4CEpwyVlZYQ2ulAoCOmkVZKrA5Dm
	lXGfRIT7I9cwsyv9DCTHcMjcMu+yLYnjzvrZPrZpd4o5+8n1XwTiq+KMuNExKeXjIQ5zJbe0v/8
	4tEE8=
X-Google-Smtp-Source: AGHT+IFUfU1kwejubVPU2NBS3h5oB5sUNB3UbWeon4LOL5GqrQWNT7DOGhwAVGTwCEC2VfzuOogDtA==
X-Received: by 2002:a05:620a:a017:b0:816:d061:7d2d with SMTP id af79cd13be357-8240094385amr94531385a.70.1757623582083;
        Thu, 11 Sep 2025 13:46:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cd7041ddsm156936985a.32.2025.09.11.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:46:21 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:46:20 -0400
Message-ID: <23663be0b8dc2a435bcc46a3d52e9e19@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250910_1926/pstg-lib:20250910_1926/pstg-pwork:20250910_1926
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] pid: use ns_capable_noaudit() when determining net sysctl  permissions
References: <20250910192605.16431-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250910192605.16431-1-cgoettsche@seltendoof.de>

On Sep 10, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The capability check should not be audited since it is only being used
> to determine the inode permissions. A failed check does not indicate a
> violation of security policy but, when an LSM is enabled, a denial audit
> message was being generated.
> 
> The denial audit message can either lead to the capability being
> unnecessarily allowed in a security policy, or being silenced potentially
> masking a legitimate capability check at a later point in time.
> 
> Similar to commit d6169b0206db ("net: Use ns_capable_noaudit() when
> determining net sysctl permissions")
> 
> Fixes: 7863dcc72d0f ("pid: allow pid_max to be set per pid namespace")
> CC: Christian Brauner <brauner@kernel.org>
> CC: linux-security-module@vger.kernel.org
> CC: selinux@vger.kernel.org
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  kernel/pid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
