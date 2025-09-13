Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A125CC74
	for <selinux@vger.kernel.org>; Sat, 13 Sep 2025 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757797212; cv=none; b=GQP9WoqJ/MQRM1q7luWHjD53cF4ue7DzBxiVoFrq+yR1KM7kalCqQ063HzG1HHHJI0amt5I7kjLV85D8GTSKym3VXQEq9RphqS+8ROc8VrsepH565pHYHu5EzZw3EL89j+u4vfpy7XMrO6iYhjAl3LMhtHsv+Lo1mRoqSvMpGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757797212; c=relaxed/simple;
	bh=gDiGjb4ZpO3D87yjNU0pojdOXxYvL773xT7BSDw9X6U=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Q5auiX0Lty09znukc57aWByxp5tHbUhh6e6Fds5siJjIguGQaxusWYwfAF+8LV102GtFVSvJY/OqJXwmhSBRSteun8AavqhtmGHbYx7gd0qVhe6MEeONcaIFrw4IcxNSNpC8Wo6xw0IUSU8E0ndDagtgRr6RxhvSiOWb442jxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORYl5FXG; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORYl5FXG"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-746dae5ff93so3243711a34.0
        for <selinux@vger.kernel.org>; Sat, 13 Sep 2025 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757797210; x=1758402010; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Nf14KE5hxUbOxfkzafNghR0ImHQO3HD23PXe7jvra8=;
        b=ORYl5FXGGyZLo2JnS8IVSdWmH6LqLI+Ik6VM4dTNVH5+sHlBns3SCtQHYt/X7phQbH
         UXd/TIoX7pZ7Oi5sWbYDk4Owr29tv7KCs/Mh1Rgew6+fwXo2yPAgLyznrihPMIshiZYR
         6D5OMBaJ8jz1SCBUm0/HMOK4gD+3ION8y39fa6PdBXLWu/4bH+qEwdGNgUHT2mOu6Ahz
         QCujuf6MCR8Y1qPlKk8LW9SkGomliPwdomb9fDGzKzBSRnZog6kbs/mhq6IzsJwtKRu/
         4ddaAhyrXfIiqKAjQgOTvZaisKyEJNFWQTqEP9AwHMJvcDuS9viV6lV4BPCtyGOkvNWb
         ydcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757797210; x=1758402010;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Nf14KE5hxUbOxfkzafNghR0ImHQO3HD23PXe7jvra8=;
        b=w5vDBgiCtAUMupO3U4BWvODkeJW4Qvdr86RtE9H0Ft/SlKlrPvJbmHNzu/w4bqoBb2
         n94OPIBi44aMXPpF+rvw2Ful7ZFnbRuZjy+YNpXyvk19+GsbQ5eONMHML0laR7Ykl0w9
         3qbgajWeFfxk2xpXq1bYHAyjIbKsdtMB2s8JuoHnlwI4PEgvJHQjaUFVXjOT/nFZC1D9
         GRyniB5gXnxspSBVDODWrEoFa9qZnj0cudlIorLYVDrF/mFIKi6TfjUoHKDMuZ5qjtZC
         Yq4I/q7shgJLEpl3tN/Vm/D0RzMGMtR0Klujsc2uEkTeiPSoofxCfvFY3EDShUcCtIU/
         wKDQ==
X-Gm-Message-State: AOJu0YxrbsmfqlSJv8XUfY+qLRvtFk2RdQVabQepCRhzZfgdHP7Nerze
	S0WepwkWnTYP/rwy2P7UGSxTmnziXKE58Kk2mF9bxhMxDUUO6w2ipKNYg3F2ug==
X-Gm-Gg: ASbGnct1ulwnl0YfIgqVjR0IeuBuhse74gUzYmcoqfVZ6BKozrRSpY7zjy4scCA7NZu
	ySk7xN+FU70PPYkUc42cTNw3cUks9/QcYPTovAq82aVmrFHIbAEcDm62ePRZDYQGDgpLkizTEvm
	dQUn759LhuRWA4E2yTxJFwnBVZECX/3VRN+B5mNtCGLu8pvLA51vHN/WZN0XdbTGFv5wzJUqL6H
	inEptfd9Q8mqpC+PxpK7mhijxlQsCT9Nuiz1WestP21yIzOGjBHHdTrq6xWqcbOXi6sNdgxAJa6
	0INkEMFVKWFHjg2GNHCV3viVSCtw/nO3U1aIVmVeHdVSe0eqMez/16AHdi+Cjtqs+J0qV28tPWK
	e/Hw/CBLWe19Xu13yCjOejcylKq8DMa199rxlYLEmpun+X7LBsJzaQp1RUDNPg1bWBz8xLKxtBH
	AlhkBfLsv2FO3EJQ==
X-Google-Smtp-Source: AGHT+IG7xYYGoh+YrYTo7y2m+631u3z0JAImBHYFFyTGKFu2ERkK6Jj9x6F+Dhkaq2heE27EM5Fscg==
X-Received: by 2002:a05:6808:18a7:b0:438:2440:a594 with SMTP id 5614622812f47-43b8da71b5emr2712857b6e.47.1757797209843;
        Sat, 13 Sep 2025 14:00:09 -0700 (PDT)
Received: from [172.31.250.1] (47-162-145-207.bng01.plan.tx.frontiernet.net. [47.162.145.207])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b828d370esm1516735b6e.3.2025.09.13.14.00.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 14:00:09 -0700 (PDT)
Message-ID: <78602e06-7db0-4e0c-9415-75098682e58a@gmail.com>
Date: Sat, 13 Sep 2025 16:00:08 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: SElinux list <selinux@vger.kernel.org>
From: Ian Pilcher <arequipeno@gmail.com>
Subject: File access macros
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm writing a policy module to allow containerized and non-containerized
services to share content.  (Basically to give container_t access to
public_content_t and/or public_content_rw_t.)

I don't normally make much use of SELinux policy macros, as the
documentation seems to be rather difficult to find, scattered, and
sometimes conflicting; instead I usually just use the denials generated
by the program that I'm confining to determine exactly what access it
needs.

In this case, however, I'm trying to do something much more generic.
I don't really know exactly what permissions a given containerized
service might need, so I'm looking for a good, standard set of read-only
and read/write permissions for files, directories, and symbolic links.

It sure seems like this must be a solved problem.  I.e. there must be
something like this macro, which Google Gemini so helpfully
hallucinated.

     fs_read_access(<domain_type>, <file_type>);

Thus far, I've been completely unable to find anything like this.

Am I wrong that macros like this exist?

-- 
========================================================================
If your user interface is intuitive in retrospect ... it isn't intuitive
========================================================================

