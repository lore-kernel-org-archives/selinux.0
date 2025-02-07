Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D821AAE08
	for <selinux@vger.kernel.org>; Fri,  7 Feb 2025 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960257; cv=none; b=GXSKuKfSz36AfFTLoYI4z4m8KK5vz1h8CN3aQ069ptDOjUgIpDH/tyTSgrao5U1cCnH8sK5+1kaUObom2sncZOxyv8CNrGBJkcS7TR5QOxdvKdmI7+GQ8Q6T/XNOE+Z8IY4IM3unpLHeuJxHpqbpEKh0KmtL6hl3DNeUphqE9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960257; c=relaxed/simple;
	bh=WGBuIo/5PmGYROwV98saHBAVMDcncrnCduTzHx3XDxI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=d1YgMuRqTK1+t/9qR5qe/p9HDxhxDHyoisGRohHli5z+p1jafkvHNekYesNfcajuHJxSPDdpsjJMT4IJwqYjqWVDDeYebV27N/O/B6eZ95OOjmF+7WcFpDs1m8qBFCdXQI2jnyhSp6EWGtuFQcfTzQzxNsYe81d9lDXUvTpWNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=atDtGQOu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="atDtGQOu"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0155af484so333886685a.0
        for <selinux@vger.kernel.org>; Fri, 07 Feb 2025 12:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738960254; x=1739565054; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJIIgkg27tl4u7US0M6zw2ZLjJ41SVV348kW8Ob0gQE=;
        b=atDtGQOuo7Dcr6AayXQmuiz6zieYlaPP6lUGJ0zrcBRJknuPg0o0RPgSqQRMEb/18Z
         qjQuHDFv3e4W+f1sJ0y/OxeqQl4mkxIoTFDaaX7U7TV2ipyPUjGhnLbpDcDdm+MigIFb
         5MEl+qmvvzUnMcswosIFJG1mvlrSl3rs8m7GkK6Bw0HSQgA07UwrH1yadSSJ4KKg7ALK
         UaEuNIwYwuEH3cGIheDNT424rugJQFxZpG5sDgKWML8nGV9TunVVrdIlNKAhzZiuf7sO
         PJ3NKQmx4unTpxTq/XmC87nX94nsQh+AnCibArJ7WcN9b6hx73I1D+M25QaiE2naWBmN
         v/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738960254; x=1739565054;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UJIIgkg27tl4u7US0M6zw2ZLjJ41SVV348kW8Ob0gQE=;
        b=kJHGmCeDemTL6BlccpxTPN9P9PW9F0TgftgZb6hLgCA9haMknXB7U+F2yFdRFw+NVc
         gSodklPa+kps0+XZdgJuKOQpTK5w9rjaWJCQ1m9HwWNaScgz5RaMq6c1pZ4XuS1XOH4N
         8Ixait5ccFBihqfVMYMwdOraIuzDIgK+g6ZaN18V2Q6mivbivVakLQ/DlukDzPXX/xJf
         zB2E3Aj+LIkqJOIUyEFEbu6Y+m7E3k7F8XrAIgnQkPGKMrAwF4Tbq/KlU4Pn9Ud+IPJN
         4YDqywXuCzaXL7QifxriDlMykIlbPaR4fR+RFSCca15EWzoaJSIt9bmKLw10F/NmXlqs
         m40Q==
X-Gm-Message-State: AOJu0Yw2DIhQjQj9lO3+44QtqGpw3CEkvFPw8Sbm2ttX3Mv3jl6lb+Um
	u4cA2ZIKcPvjo5oabrhsRmJgnWbJJT6YfKIbsCdhlls1bGffpR1/oaXn11/SOqNu33nc5Y8Ij0c
	=
X-Gm-Gg: ASbGncvGVkk5sj3EwaqCA+WYZursci4XRYlEU1spN8xtEJVmx5GZy9wKBntpH7KyDUn
	mB1gDgBgGgKZJRfDBVSxE6Sh16aF35OLo2wFiCjc+0w4nWe/Ok5jjIi22A/pYJZFAF7ddVuC1p5
	CM+4Gc1pbq6SsResQynEhPMJhaYrCva9HseOiJbyUNbKaJak0NH8GLR8WqFvgyOUFWNF+vJJp4I
	+80muFV7bijpkzSlQ6SHDlCT3m97EZgjgZrHeimi6jp36IFAZIxeTuV3ee9euwrsc7+loAhZqyi
	reHKdNoRnQ==
X-Google-Smtp-Source: AGHT+IEEaVO/mTjtKxBcPOlJMtzoqI6XtNXrfrdONbj9LDNUwbsazZR5GjAxArKYW5LIEJaKz3IP0Q==
X-Received: by 2002:a05:620a:2591:b0:7b6:ece3:825d with SMTP id af79cd13be357-7c047bf22demr648256085a.12.1738960253795;
        Fri, 07 Feb 2025 12:30:53 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c041eb776fsm229764485a.91.2025.02.07.12.30.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:30:53 -0800 (PST)
Date: Fri, 07 Feb 2025 15:30:52 -0500
Message-ID: <a1e4d23332815baf08d3c29cdd7f837a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250207_1530/pstg-lib:20250206_1624/pstg-pwork:20250207_1530
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: always check the file label in  selinux_kernel_read_file()
References: <20250207033019.479292-2-paul@paul-moore.com>
In-Reply-To: <20250207033019.479292-2-paul@paul-moore.com>

On Feb  6, 2025 Paul Moore <paul@paul-moore.com> wrote:
> 
> Commit 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
> added a new flag to the security_kernel_read_file() LSM hook, "contents",
> which was set if a file was being read in its entirety or if it was the
> first chunk read in a multi-step process.  The SELinux LSM callback was
> updated to only check against the file label if this "contents" flag was
> set, meaning that in multi-step reads the file label was not considered
> in the access control decision after the initial chunk.
> 
> Thankfully the only in-tree user that performs a multi-step read is the
> "bcm-vk" driver and it is loading firmware, not a kernel module, so there
> are no security regressions to worry about.  However, we still want to
> ensure that the SELinux code does the right thing, and *always* checks
> the file label, especially as there is a chance the file could change
> between chunk reads.
> 
> Fixes: 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/dev.

--
paul-moore.com
