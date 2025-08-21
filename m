Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B728DB59
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760509; cv=none; b=YAybduaxAwZAUgOPVHFJ4iErY6yyc++MYvWnqRa1iENKE9ssWxFnQZ+VJgE95xgYn2NOKtGVy8jq7Hs4DbG8BLSv5c9NAAPmRSwBpyJDPazfSv4724dDdaaUxTyMPInpPxmRXQ6uEOZ4TqLIES/7Jq/HTBZ3Z+o7l6mF7IzgsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760509; c=relaxed/simple;
	bh=KOQXIEW9wQ7yBHp69Cx1jtZu56m3vJsZyuNO6q0rWVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7W2QFCUn5l8YOj1qjT+p05u/WX5qXotNuiLpDNKYXwJW99dxZV8Q1CknoPf6Bstcp4SKemBcl12nmHhqwf1EZcp7D5bctkSPIeCdQaizBZPYgRgRmNn6+HsYbk4jCCd/vDTU1QkReo4qOcM0bW8yc1isgw8axgYEVH+eFmpXKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=s/7sz6c2; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="s/7sz6c2"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 391C93F71D
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755760499;
	bh=U/fhBqlfQG/+dkxMXqc9eBLCUORyMRgIwwTk8to/MW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=s/7sz6c28JK1EYjtSiUlNfkw0BJAuEjN0vJQbyKX+bmx4ZDWxOn+QHXUFQUnwZo07
	 qsCzvFqmzn86Wz1YMgRxa2743RfTyxCF9iratLkjjslYq3kGABuIEfVPhbBAWDuN9m
	 2h9LkiB5kr5VW5vQI82DB5r79nuoRJlLxo9ud/DcesibdozkF0JaVB6tcZLAKvlJt6
	 6LXaoaskavlgbo5xEGNey819Og7eIkXdkADq0KduiqD68kHXTkdjHQOpGWTr6UMXk1
	 dtjaeofhWT84CpkM7mxYcjB9h8FhgKc8yhhm4dRw+SKHZn5Z92HOBUJ9M+twU4uIDo
	 75vfLDohDjT/Q==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-323267b6c8eso1496054a91.1
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 00:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755760498; x=1756365298;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/fhBqlfQG/+dkxMXqc9eBLCUORyMRgIwwTk8to/MW4=;
        b=wQySe8CXw1u/pcwBXs6m8wGNAwbT1R3wgn7Ubhe2LW0td01dFpcPG12Ar23T6tNsn5
         lByXVVv+hT843SGncZg9SDHdmPnRkFb8PplpPPWvRuNwDnvwrYsmAtSSyJ020jefVOJ4
         aUgeSxQO+agthSpCyWVmt4D6DY6xR7YZSet1O+XYEkzmXH3uZQzWloIn8BqVY5JFCGNz
         Fr5A+1uaqRaz1S6qMdZmnNxDvlhrC5cQEW199ocXaRpK2M9vf3T2R3kD7/pXJe6BZ7f6
         afo3BMN90eaiJCtN6z1U0SiyZ6CUY0i7AYIfffCQD4Xkl6yK3a75YXiH3T7MWHyNK1sq
         h9pA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/9o/peflYyXhGgmQo0ky2rJ9l/43Pir8AzAx1xmZxfn8sTPMTnRI5QMfAMVs1DsBN4LW/WqR@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOmkOXAl+vw/xSuOzZhYA5h5Gyb+MYc7xu/bpDAIyNTQFM2ii
	NNFLGu2bmuYRhbxrRQ2Mhik/mVn/3jnB39JQHojwyg4MqWbk0nELy192aB3ULUnJG1+IJw6yPC9
	QYh5DY5BjuRyXFg0xOM9xOxKnMbN3Fv04CmOD6CZ0hWhDgsyigrsVGHVTTQdKReowsoIWJGrW0B
	M/Cob1SQU=
X-Gm-Gg: ASbGncvABfv1T2N5xN9ipXyCwLwtV1TQBtFvHAkzV+Q6zmKryIaBdUgImEPb1OCZfQT
	A7MFVljJe6Ssd6hSgloxHvn+4GjAFzP0vM5IqlLRgT+M13/f6T/oG6AGm6AxYMe4+loiECOHS8s
	/m1P57RDFFF9oSoBFZxd2qWWUewwo7hrGTcHJ/oOVggroRlskd/EmnjloRBfSb6UCiYWLZ7yHNq
	/+4VJdWOVgPacQZEj0BHmjSHVcq8Xv6o50Lnh7UX7kExdXrta93ST2QLXR65L1H0Tpa1wOpIO9v
	ooYkHUzZOXwZ8Tdcy6IyKmlTbk1VN9FcvB19Bx7afDgFwQC+HibGRg==
X-Received: by 2002:a17:90b:4f8f:b0:31e:cc6b:320f with SMTP id 98e67ed59e1d1-324ed0d9872mr2003017a91.5.1755760497555;
        Thu, 21 Aug 2025 00:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO0MzDwJT11ZZAj4/bklRzTr03bZM01jMnYZBuDCOrdhc/HqfJFPuE5sinNRI3dsQUVK1TFw==
X-Received: by 2002:a17:90b:4f8f:b0:31e:cc6b:320f with SMTP id 98e67ed59e1d1-324ed0d9872mr2003000a91.5.1755760497068;
        Thu, 21 Aug 2025 00:14:57 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-324f93cedfdsm375584a91.3.2025.08.21.00.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:14:56 -0700 (PDT)
Message-ID: <f0067d77-991e-484b-9b4a-8688f9dbbd2e@canonical.com>
Date: Thu, 21 Aug 2025 00:14:55 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/25 07:56, Paul Moore wrote:
> Hello all,
> 
> As most of you are likely aware, Stephen Smalley has been working on
> adding namespace support to SELinux, and the work has now progressed
> to the point where a serious discussion on the API is warranted.  For
> those of you are unfamiliar with the details or Stephen's patchset, or
> simply need a refresher, he has some excellent documentation in his
> work-in-progress repo:
> 
> * https://github.com/stephensmalley/selinuxns
> 
> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
> about SELinux namespacing, you can watch the presentation here:
> 
> * https://www.youtube.com/watch?v=AwzGCOwxLoM
> 
> In the past you've heard me state, rather firmly at times, that I
> believe namespacing at the LSM framework layer to be a mistake,
> although if there is something that can be done to help facilitate the
> namespacing of individual LSMs at the framework layer, I would be
> supportive of that.  I think that a single LSM namespace API, similar
> to our recently added LSM syscalls, may be such a thing, so I'd like
> us to have a discussion to see if we all agree on that, and if so,
> what such an API might look like.
> 
> At LSS-NA this year, John Johansen and I had a brief discussion where
> he suggested a single LSM wide clone*(2) flag that individual LSM's
> could opt into via callbacks.  John is directly CC'd on this mail, so
> I'll let him expand on this idea.
> 
> While I agree with John that a fs based API is problematic (see all of
> our discussions around the LSM syscalls), I'm concerned that a single
> clone*(2) flag will significantly limit our flexibility around how
> individual LSMs are namespaced, something I don't want to see happen.
> This makes me wonder about the potential for expanding
> lsm_set_self_attr(2) to support a new LSM attribute that would support
> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
> provide a single LSM framework API for an unshare operation while also
> providing a mechanism to pass LSM specific via the lsm_ctx struct if
> needed.  Just as we do with the other LSM_ATTR_* flags today,
> individual LSMs can opt-in to the API fairly easily by providing a
> setselfattr() LSM callback.
> 
> Thoughts?
> 
sorry I have been deal with a forced email migration that uhhmmm hasn't
gone well.

So yes we could do a single clone flag, but it does have significant
issues, and is not generic enough for every LSM, at least not without
some form of providing augmented information.

A single clone flag means each LSM is completely in charge of its
transitions (needed) but without any hinting from userspace container
managers (this is a problem). Under the single flag, policy would have
to drive what can be done, and that would be fairly limiting. It would
allow for something like the current MCS labeling approach but not a
finer Udica style approach, at least not without an addition call
similar to setexeccon(), or as you have proposed more generically
LSM_ATTR_UNSHARE.

The more I have looked at it. The single clone flag approach is wrong
and is just going to lead to problems.


