Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075E26F443
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763679; cv=none; b=SbLU/A3Dk/lSTK5EIver0ICHhAHL6yS2+I2ZadkU6f1QcWVlLMArnmL+6eR0gxT6oWo7lj3ZnUWtre1m7O9UODi6aawyC32RREWIb0wWdt4StildqPmlR1pHS9z+KPGLxCw8MO0YiP3JC7dwSuZ1etPkulUG5RhXPH0qU9C4/rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763679; c=relaxed/simple;
	bh=8ebtQbmQXySHuP+9LJ/qF3J3LkvaWRDgR5aH0xnibKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOgSeKQn7LN4E+zq3+Lp/240Gpe24KK1aglUvpTEMvCNFtPmtTDYdMgajwRWnjNYT7gTEWg3vtx3mG+uMd3UrmU6FDHPec6OGpp9WoWGrc3KQaveRqp5WzVdShvA87YabDXxsrlzzKQcUpzsqjbp2o8q1U2V8BavpzB0zmDSRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lUWFOAXB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lUWFOAXB"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6AB8E3F71D
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 08:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755763674;
	bh=gmhuu+Qaet216BIEqjI98R0ASNch28yN51wzdgPKY1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=lUWFOAXBRa3lqE7R6EovlpSaMrI8Dy1vtIEtqcyQxDNja96TNHUaVCYA66jwHk9yD
	 9rw/fk1ErdW8GsOmiQgwhVgyuAmzWL2BFdzwfbNoINJGTgvtXGQDYJGp9E58ds86UD
	 3IsUmROLnZTZKz8cwcT2T5kJAfXy7jN1lpBAIHneRgGqhBvKB3FA/Dp5/XzOPL8I9r
	 3wAfppYC5rD5HV4dXTBJDvZba37GjvHkQ1PfDJbx9SGVNMm+84WjSUondTk/9G5CXk
	 bRTyHlW7sQEXPqmiPTNQcsGPGT+JIY6e5Ws1XCDvORoly46Yq9pEQKdMKdQj6HgbT7
	 jcbQuGByJ8prg==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32326789e09so1533077a91.1
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 01:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763673; x=1756368473;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmhuu+Qaet216BIEqjI98R0ASNch28yN51wzdgPKY1c=;
        b=Wj7UxaVJIZ+WgmhmGdGUnTLCI77cTYaSmd5OusT54EYvfPuqapUPcbuHI/+PX6T31O
         m3zV1T7577xkxvzfBlVKqaVWDyjN95SKInBJBwR4gmwNIpJMrw9iL+2xqegq+l05WkyX
         ngpVxZvh3Ss2AVkANKpCsVI7YZFP4PNkAZ5h0Z35lS3oUhzyJit7uIafAon0yLVtpojW
         AzCranZb1CLb41wE1TfT6r65aKH+Alb0iHZhy7/9rRWqXAzycSfFVZIRxzm7hNqdLBUD
         zs298Cn2wFraNs2IR3Inh/2PD5o+LKy7xxmQqNvbIxlXylMgKyEl1fyWA53bb3nEVxvH
         V+1A==
X-Forwarded-Encrypted: i=1; AJvYcCXTJ9UiQlqxihkNkvVOhr/Tx+RGXKrt2O3cO37oWmTm0TJZoRe/0NQoI7e4tcFL5YEZ4Dt0v4s0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjv6yLPOaGBLvjyuaTu1/N/u+LLYnX/sOmdiuXbemgw2gO4CjF
	TWz/l+vWli34Om4gPsxPm1OEv3X/gXdWGBA7kSoEOzhaRrXmzj4iJfzckdQK9PYFUh3BG4iglNu
	9o/5JlNMTkuiaSvlWVtBJYgPilVFYgRQMKDvZ35Kyh+gAhhkRtJ1wvqidluDxITqjoT4vBw2Kz+
	I=
X-Gm-Gg: ASbGnctctPpyvbvViH5pVq7h5BEL6xWZekD7gmbv3jm0NYYssQt8D6QZv6P5k9pWuA2
	KKEeX7OV7+I6TGHgG9NnFzuuL6FmLdrBXgafYAZuGC15wXSltX+9HssQR0gtoPIBMQgqD6+42Lw
	oShk9TzkLTgcm0ZbMBGHGbTj3F58oeQHNbUK7HK6Zt4OcCNGwR+7Uf2i8fO9kK/mMULTiUIqRj3
	3bik3m2WVG2s7+mI3Pcvf/I061Q2T2/QJvBQVSVVMS0Sy3RXbcnrofrKfkESCLMu4xI/FJCzHh4
	Grho4twI6TLyRWrNWv5DxZMkaogbMTVK7zmtmaRuM/wyaci8H3I4uw==
X-Received: by 2002:a17:90b:52d0:b0:31f:16ee:5dcc with SMTP id 98e67ed59e1d1-324ed097537mr2346486a91.14.1755763672874;
        Thu, 21 Aug 2025 01:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwJyFyl/gUR8s49RfXu2pl4j40sLMcx8yc7LneWrVbuRfnRN3uAEKe9kRAQzGSS7eS0nMttQ==
X-Received: by 2002:a17:90b:52d0:b0:31f:16ee:5dcc with SMTP id 98e67ed59e1d1-324ed097537mr2346453a91.14.1755763672404;
        Thu, 21 Aug 2025 01:07:52 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-324f283dda3sm1177665a91.22.2025.08.21.01.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 01:07:51 -0700 (PDT)
Message-ID: <06f3074a-5d88-469b-912b-118a3a615371@canonical.com>
Date: Thu, 21 Aug 2025 01:07:50 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
 <aKZ+2NMx+ZQhpySY@mail.hallyn.com>
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
In-Reply-To: <aKZ+2NMx+ZQhpySY@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/20/25 19:05, Serge E. Hallyn wrote:
> On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
>> On Tue, Aug 19, 2025 at 1:47 PM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>>
>>> I think we want to be able to unshare a specific security module
>>> namespace without unsharing the others, i.e. just SELinux or just
>>> AppArmor.
>>> Not sure if your suggestion above supports that already but wanted to note it.
>>
>> The lsm_set_self_attr(2) approach allows for LSM specific unshare
>> operations.  Take the existing LSM_ATTR_EXEC attribute as an example,
>> two LSMs have implemented support (AppArmor and SELinux), and
>> userspace can independently set the attribute as desired for each LSM.
> 
> Overall I really like the idea.
> 
>>> Serge pointed out that we also will need an API to attach to an
>>> existing SELinux namespace, which I captured here:
>>> https://github.com/stephensmalley/selinuxns/issues/19
>>> This is handled for other Linux namespaces by opening a pseudo file
>>> under /proc/pid/ns and invoking setns(2), so not sure how we want to
>>> do it.
>>
>> One option would be to have a the LSM framework return a LSM namespace
>> "handle" for a given LSM using lsm_get_self_attr(2) and then do a
>> setns(2)-esque operation using lsm_set_self_attr(2) with that
>> "handle".  We would need to figure out what would constitute a
>> "handle" but let's just mark that as TBD for now with this approach (I
>> think better options are available).
> 
> The use case which would be complicated (not blocked) by this, is
> 
> * a runtime creates a process p1
>    * p1 unshares its lsm namespace
> * runtime forks a debug/admin process p2
>    * p2 wants to enter p1's namespace
> 
> Of course the runtime could work around it by, before relinquishing
> control of p1 to a new executable, returning the lsm_get_self_attr()
> data to over a pipe.
> 
> Note I don't think we should support setting another task's namespace,
> only getting its namespace ID.
> 
its not reasonably doable without a significant update to the creds
architecture. Its an orthogal feature, being able to set another task's
credentials and as such can be saved for another argument. So very
much in agreement, lets not allow that as part of the design.


>> Since we have an existing LSM namespace combination, with processes
>> running inside of it, it might be sufficient to simply support moving
>> into an existing LSM namespace set with setns(2) using only a pidfd
>> and a new CLONE_LSMNS flag (or similar, upstream might want this as
>> CLONE_NEWLSM).  This would simply set the LSM namespace set for the
>> setns(2) caller to match that of the target pidfd.  We still wouldn't
>> want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().
> 
> A part of me is telling (another part of) me that being able to setns
> to a subset of the lsms could lead to privilege escapes through
> weird policy configurations for the various LSMs.  In which case,
> an all-or-nothing LSM setns might actually be preferable.
> 
> I haven't thought of a concrete example, though.
> 
Not just potentially, and not just security/LSM namespaces. Really

the LSMs need to be able to determine whether/which namespaces (including
system namespaces) need to move together as a set.


