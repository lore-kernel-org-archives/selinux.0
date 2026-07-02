Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8B367B89
	for <selinux@vger.kernel.org>; Thu,  2 Jul 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010177; cv=none; b=M/RYyaKgK078zzDdHav6r74EZl4b+6hzTjPuqIpMNT511jRsFTocxCF2gV9ZTRoNqgK3EedmANUenEtgMAoEfRad2wbG14inweVa3vfyX0u7x8CSIwtm0TmFRbwh72zFMy+6QcOXzi9Ydj/C+67v2i4vUzm97Dx3JR8wnFM1SrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010177; c=relaxed/simple;
	bh=RhF3qbJoRCTqpFjc2d0SpztsXxfWqyKyZWf6uDBOj1g=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=FqbBYwO9IhIPB5vjKofZeQPxWmSeOs4oAKGySZaIX9ep6pOR7pAvWchncvk/JmNzwaEPkkHFq9fd2W1/lnxoMRjXjVBu/qQHe03Zv3W+olfr0QJ3vHOA/M6eTGBEYttwXwO7Il6VgNvzP+E4xdifVwOsRq6eGD6H+dcXhe5oOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RykP3qQu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RykP3qQu"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c22c61795so12947681cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jul 2026 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783010175; x=1783614975; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AoeQnDJDexsYnHUyz4lFBOnYotFADfsEiVEjdw1AuF4=;
        b=RykP3qQug6yZcq+EiBvoNOoGFjY2G5I/GaUJSwni9Qk17Op1qOboB5HitZzaMH8t0H
         yrdfXddjjpCKBHTP/4QySGyrHkqJW32JOJ9Ssv6AeBvpVR1MzmT9oXe0v0nyj0rwC8vg
         igexBljjqXgCLDpvKuYr1ukHwCR5kivJFaHN6n72lDwwy4SrpRAwQ84QcwlWdTBDHG4z
         KrGSNpmByavBYYVgfYulcMd7fgVugEcbOXCeZEuDptlAIddUkj+RRA3qyTHVIdw3InVL
         +uWM8Eac+fp+iX9cKNr7nvhcI9uMM7fhdtK2iJCK2FRNgLYJIkgyB8ISJq08s7v/hpvR
         Y1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010175; x=1783614975;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoeQnDJDexsYnHUyz4lFBOnYotFADfsEiVEjdw1AuF4=;
        b=PhoXNlXOpmgGfWeJhNi9jVl9UxOiG8LqQt0RHG33KX/nuFlPwBX1bVw4T/MNyRM44h
         V27hzTiplME51ZtUjhXqQWC+diZzm3CphkldDHy8/Br7Xibm5WyIaHDM0mzhs0TxfGcO
         +57JrnBbLR8ujJPvY2tbcL/nD3tp2NoSgWKhZYRxfKHC5xeapYoSsq+oYHGvpoBeUfn7
         0K7SuSYYdy572MtiGnConESrHNdC+Nf1j9C34MEFYgU2oENYAqsHybAZuiKz2F6FHnCx
         w19vTvM4cF6lOOBpdMQ2wIbCsJ4S1ULevuBzlkTTOJ7A/yARyB6nf6pqZLneBHTXtwCg
         HfpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hJZU4XveJ22UKI6YzbDWXAWd8UZLkwxhzTqAohP//Ay0TYzd1O1ESxkdXeFCA2jYIKqX+kAjR@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbk+QXZ3y/hSkVcaW8bUuBOzFL4OViv3RY7+vL/H9s1RXmub1
	vJetULD71tv5NE/gDdSkG2zVGR4B5aHYWfiy/Q3H6QjxgPgj/yhkfdGSYuSl73PJ8Q==
X-Gm-Gg: AfdE7ckSEakVpAZsBq1MDtwxBkXzMD/VpPJJNQoD419ZSB50XpPR6HrARL4ZRl8NYeJ
	MQwqonvSAigAO6GfHoktX3MTXsAQh4kutuHMAMRl+EXbaeBSeoBc6ppDJFNAyeqF7bUukXx2l91
	OHCwfAas/3B8R1BamJkNtodfNV5rlJr5kR43EOr5m9xmYp1nuTzYrsi6oD6OFHmyU9jZEA4uHe4
	ZizfGNzgkSd/TP6ovhl0LutA5uQ5OZcsrMYoQafaPWuV4llUp8cX67XoeM5SVbQKacm1gLBxYTt
	Ld0ZoMiAM+Lo3nqPkJ7e/uZc+hgIGADQ4lvdKm5+BQHJwLGsVCZ7dnXMjK+YJve7AErW/Qc7BCY
	jymAHt97roXg2bNAEQqcqZE/h3IfCIX/3XzV2mt3HfUMsK3i0TwA5jqIBj9sduin/ro7ozC29kd
	HB7AR7Siju2an6sfdXry/Hcv+estVya44ZmCQ2vUGvtooWqcEnV3Gl4ffAjw==
X-Received: by 2002:ac8:5a02:0:b0:517:72e0:612 with SMTP id d75a77b69052e-51c2aeebb4emr71088761cf.42.1783010174905;
        Thu, 02 Jul 2026 09:36:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30c4bcadsm17600201cf.22.2026.07.02.09.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:36:13 -0700 (PDT)
Date: Thu, 02 Jul 2026 12:36:12 -0400
Message-ID: <c83fc7acbc9470e98bff6d11bb21b8c1@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260701_1640/pstg-lib:20260701_1540/pstg-pwork:20260701_1640
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3] selinux: tighten type validation during policy load
References: <20260507161633.15947-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260507161633.15947-2-stephen.smalley.work@gmail.com>

On May  7, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Tighten type validation during policy load to improve robustness in
> the face of ill-formed policies.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 removes a spurious empty line leftover from one of the changes
> dropped due to Christian's patches and adds the word "type" to the
> error message for clarity.
> 
>  security/selinux/ss/policydb.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
