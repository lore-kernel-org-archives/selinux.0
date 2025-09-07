Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5E223741
	for <selinux@vger.kernel.org>; Sun,  7 Sep 2025 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757270821; cv=none; b=Ikc4sUdHivsotJU6S8iwkRuAUTO1j4WE2u9QwhOiaIfNpRz2s7vs933WVNeN4fVoszJA5PwAS1v1l6YhwhqxK4VyE7c+vv16dJ8lX073ygImdXYwN4u7T4DjJrGvFv+OITC3+M2Dtj9IS6yZRjAC2iGTRP+K+S5YSsAlDXWRzx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757270821; c=relaxed/simple;
	bh=T3EwPJtzj1SpjYFQ48lBl+QcPQwCf4Y2eCpeUVXk7Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6iaG8UMGpZztWeYQjhHZsfcGM4OMrcIONAdLYpqWcb+mFw+gD5mHZjHA0uuP18wvmln1n5nILIFowm83QhTAfenA5Z9oEz/3i8iCgHHfUJSjbZchCNErHxQi2jJ3xNpuL3CzafNrAOxHzODZb7GATVq2tBJRy+e749ocHdr03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4legIqKH; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4legIqKH"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88432e31114so285505439f.2
        for <selinux@vger.kernel.org>; Sun, 07 Sep 2025 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757270819; x=1757875619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEQRuei5YFvs4wxgmlDYvTephk2WPSdhzkeIUgzcfhE=;
        b=4legIqKHn0wflrNQKfcNmOqCGUkT8yxdhMEdaqmijgMTOBH8Q3Ue215LkfnV4Ru8cr
         0LFDxb8HDMG+ZlYh4w+JlCeCZJc4OY1HIX/oF3fYFTOE6dpWcig/yfOl5mdex/2e3QYL
         dBZ2xYdaOFCHGRE5RVUjbyme8cU6rsY/aT6gNA671YRj1cGxy1ntiZDiZTW+io/oeXYQ
         IM6p0AAZSRJC/7qqagR+4qKE/KDROR7J/uhW3a5hdKxOooot7aSxMvIJc9GopywxUe7L
         dZs/f1XLxCaCUPFYeecp7j+Y4w97IOHx8KclJ8Cngq5K7zUFCJ24Wq1oYfKGZSiZqDK6
         92qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757270819; x=1757875619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEQRuei5YFvs4wxgmlDYvTephk2WPSdhzkeIUgzcfhE=;
        b=sRIdUE9sQU5l7+td7RsVWsnGRnRQLJT0lqXzJBiMfcH16LI7rnsPhLQGtiF2SqnSHf
         tVHJkBAVr5xL+fgJJly/nJtOme/eosvkaUT9K/qk5OLi5i45dw72c21PNJbJM6IEfwCS
         2qNYRUcFgWcgdTpcKQ6D8uFh2NPNf4bBG8jKYPrvn169aQXJ2NMq95mFCGsIMpUMLXDT
         LcX8qhxV1rY6PMpXblMIuL/HFzGChpSwClUhnxgrVIKdj1FEzijVy+aJJY/3Ihuk/sku
         tC3VKDrSfbDk59lJhc6JjSMuLbifOVHF/O5dd56JSWht7yIJANbshdEaxnSbcct7ef5B
         aqZw==
X-Forwarded-Encrypted: i=1; AJvYcCXlBYnkwoInNzcHJOWOpfHa7/Zd9CsHk3PIt3zNVe416vTs1Pp55Uyg3tqPQixemaGVhVc95oJi@vger.kernel.org
X-Gm-Message-State: AOJu0YzdwtgakXFYoS0xQjmsG/EzwWN4Kd6BGTy4wYpNTMFqvVIbknWg
	WIv1E8vH1u8FaniGH8cBTX0rYA0peZf3yknq9QMm7zyWS8BeoYY+1hkwFxVFRpyj/A==
X-Gm-Gg: ASbGnctB9hhVkzRh2KM4a3wg9etFXGryzG3wXzfAUEtAe/E+tnO2tFpUbP7rQk/3gvy
	RdPCVAuDSeI9Kqpvk+q2TwbrAFw2uN3KSwqfgn8qkLfeAcdgcrhZTBulqr6CFJw3hc1zTIMO+bi
	YRlj0o3mg7EC5xog2dwr1RJoJDgg6S5UKmXHEaP/6wLBVDTKrYkAKzqH9suOOw39gaF+fTrZN0X
	QFLgy3PuVvLfmWG4fw54zxIjC/NuHBnrqVPbeJ95cz0u+CkPo8axfmjL+pi1poK53W3uMHn0LzM
	Ve0c5RtlijO0UAqGvlwxW2SG/6tDSAmS57RY0u4HF2xjtExXjlvONDiNBy/mAk8YZKo6EMp2R+d
	6734X6oen2el164SPdi9KEURKtuszGATY7dIur0mnPMo7hOSvKA0HO6hFk1keFSd9er1W4VLl0p
	4R+2I=
X-Google-Smtp-Source: AGHT+IFP4TFfhBSXgMSup1FEcAD1tiIYNyc16qd4c15z9i573dYTshH/4CnU2TUvpU2Gmbm/2gjnmw==
X-Received: by 2002:a05:6e02:1607:b0:3f3:dd9a:63d6 with SMTP id e9e14a558f8ab-3fd961f424amr86831295ab.22.1757270819059;
        Sun, 07 Sep 2025 11:46:59 -0700 (PDT)
Received: from google.com (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3e0da92a3sm98600735ab.41.2025.09.07.11.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 11:46:58 -0700 (PDT)
Date: Sun, 7 Sep 2025 18:46:56 +0000
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: fix logic issue with per-file labeling for
 functionfs
Message-ID: <aL3TIN9UtGHKELuy@google.com>
References: <20250905222656.3692837-1-nkapron@google.com>
 <CAHC9VhT8NrsXMM-PPZJ0EPLxFHQ1vOu+ASCd+82Xth_mJPnDiA@mail.gmail.com>
 <aLunR_0BPCrATnBP@google.com>
 <CAHC9VhSaAm3G9bnJ86Aj+DnTio19ePE1Pu3voaB3XUvBveodbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSaAm3G9bnJ86Aj+DnTio19ePE1Pu3voaB3XUvBveodbw@mail.gmail.com>

On Sun, Sep 07, 2025 at 12:58:33PM -0400, Paul Moore wrote:
> 
> No need for a v4, it's just a single missing '!' and the commit
> happens to still be at the top of the patch stack.  In cases like this
> it's easier for me to just apply the fix manually.
> 
> Fixed the upstream commit and pushed back up to selinux/dev; please
> take a look and verify that it looks okay to you.
>

The commit with the fixup looks good to me.

Thanks,
Neill
