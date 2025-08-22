Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAD312823
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873049; cv=none; b=IEu4G/FMMjB8zos+lzINpokMKprna87hyNu/5gWi/nd2GYLUhy4karZj8XJ3h+cnv/KGysMTzpecd7la71VUA2t2TwHRIbFvHTvjU3PZsvT0f02ysypSwv7Dko8vAwxOeqMdTR/FiNbR39VX9Nxjfwk2W/IVDPo8nTMRgcE4H5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873049; c=relaxed/simple;
	bh=iRndM5FfOawFp+OiB0T7Al1t5wy7FyL+BBm+Uj/s7p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/eQ2OzXo4cX+VexVYlDMgAWNrBZE8+w24uhNHiWOTRfoT7Sa0NSe4GlyBGa+MDGy+Wa6DoDnveEpEd0bh4q6F5IRboAW9Mi9C2Noca1kaLQ59Hw1OMrCZGVNnJRY/CcQNnIfnYZ3SloH8TY4bWhOT+UhcGO7dXsfG5P7acx5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uyU6Kf2l; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uyU6Kf2l"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 720053F884
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755873039;
	bh=zcF9wrOBOHTWiE8hvuYd54OqWuj4thPgaSvF2cpf70c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=uyU6Kf2ljUDNrvRH6x9faWP8ckOiLQRla7fb7CIEJ9bmT9YGqFsF0vg06WVGEWwHc
	 j+Yt+gQHvxsu9DtPJMgczByeDCzTyuTr+FEm5Tc2PSY+53fYhuiqyv4s+hyN9fdA5o
	 adEWsNgj1btLMu38qHhmukwH6rb8Ime8ovboCWPGyaKMLIsLaOYGUvePqmJ8ciaa6d
	 50Kfg4EhFfm4jRdEA6DySdxDX62bnfT/+22Fphr8akbgYhQ2/RODRRNbxaI/ZS9pSf
	 dkeaXSWDxEgFKUqBspDeTqolMV90+w36WKdVxP7zLwEjEGZ4ybaybBfDH7Czt+uZBo
	 bIBYks9HbETUg==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244582bc5e4so27773135ad.2
        for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 07:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755873038; x=1756477838;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcF9wrOBOHTWiE8hvuYd54OqWuj4thPgaSvF2cpf70c=;
        b=ItPLq6sb/7Flm2uXJpiSJH+jZG9Mu4MsMUXY5BOX3duN4QcxEjorewKjxUz45y+wPe
         tkKoamtym0lKntxXNwTbykO8apX8zewHPVeLbeZu83dJoGq9wddaWZclkmGJHtsYLj0e
         YVXlxO+hpevpiYZkLBPkwlXka49PpXmkq/YYTtn6twiL0xim8HIUTEw904HPsmZFO+NF
         8FdpF436bdlRpaHwBSNm/WBjQfBfIU7kmPgmC6AEW2LrRda1SqhnXMFWfeYay9ulxwP7
         2UHr3Qb86ZMmYh6+DeflVW3VMhpgd7adl5BJ5hmYI/HPXDVYErKI5FfcujyrtVIa2pth
         5r7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYIl+K3iYQDVJFUh3xRyjB/MFvc878Sro+FZ6srAETsyl6P81JxkYo6EDh3vqAa1nndXd/LrP0@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkC3k8bKxwcP+giCdk0kEz3+DUVzBUreYXKnnK+9a7wNT5bYw
	U7e4qeoE5hOXXlyUfAJMeb2TYqhBMZyY4B7FVOp2GyaurV/3mxQoGqjRl1zsByJw1HOWIZhqp0w
	W5fnEugi4Aaeh+zubX7eLthNsFdSV6yEP7bHsL1tpXaQ8MXCNgi8YL4zW8+LmQ79O38MXkSCCBj
	Q=
X-Gm-Gg: ASbGncunX4v/3lDjIB89+9RvTF88ZS6EZ+hiaLUPExNnN02Ho24E8OShN6X+55ZI7yd
	5TCi3pNK7uN4hb6gez5TSeZ3UdxuPhEgCkCjy6okcdsvcHkZhX9OnSDnD+2jqzgpmn3bwdKZc0D
	vS8NDpIhbT8LZK9c48WiwKGmUvI64nPOzIMT3IADD0k5SpK9VDjkqECzoNRUSTtyGJ6eViIXokR
	zpDl9QsQWA/A0bYM9lg3hvFhaDstH5x5q0OQklEnBld7uDcWS3xnjeYs6yNTdIZgofSdFJdP4nK
	XRiH0QwYEivOar20DXlRNqsINiUZJqpOLqmIgje42IcfoG0QSOrU3g==
X-Received: by 2002:a17:902:e84e:b0:240:1831:eede with SMTP id d9443c01a7336-2462ef4cc1amr38798555ad.32.1755873037851;
        Fri, 22 Aug 2025 07:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElcaaqjfzDSp/2o7V9c4RZgS+QptD+cA/40E+yE4yQhpaDoeAWPQlVGXiBDJpiqB3KRRP8yw==
X-Received: by 2002:a17:902:e84e:b0:240:1831:eede with SMTP id d9443c01a7336-2462ef4cc1amr38798245ad.32.1755873037428;
        Fri, 22 Aug 2025 07:30:37 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-246648eef65sm717875ad.57.2025.08.22.07.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 07:30:36 -0700 (PDT)
Message-ID: <3ae0b057-ea0a-49c1-aa61-bbfa07c9a458@canonical.com>
Date: Fri, 22 Aug 2025 07:30:36 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
 <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
 <7d4d60d6-fe50-4646-9f9b-0cb524aef3fb@canonical.com>
 <CAHC9VhTE3cf80U0BRJLhYcWj9vc6+S_8fotrEHo7eRfFkLnveA@mail.gmail.com>
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
In-Reply-To: <CAHC9VhTE3cf80U0BRJLhYcWj9vc6+S_8fotrEHo7eRfFkLnveA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/21/25 18:57, Paul Moore wrote:
> On Thu, Aug 21, 2025 at 3:23 AM John Johansen
> <john.johansen@canonical.com> wrote:
>> On 8/19/25 11:40, Paul Moore wrote:
>>> On Tue, Aug 19, 2025 at 1:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>
>>>> The advantage of a clone flag is that the operation is atomic with
>>>> the other namespace flag based behaviors. Having a two step process
>>>>
>>>>           clone(); lsm_set_self_attr(); - or -
>>>>           lsm_set_self_attr(); clone();
>>>>
>>>> is going to lead to cases where neither order really works correctly.
>>>
>>> I was envisioning something that works similarly to LSM_ATTR_EXEC
>>> where the unshare isn't immediate, but rather happens at a future
>>> event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
>>> LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().
>>
>> I do think something like this is needed to deal well with the two
>> step process. Without it is fairly easy to get into situations
>> where you either need more permissions, than strictly necessary,
>> because of steps in between or as Casey says things just don't work
>> correctly.
> 
> I think we're starting to all coalesce on this basic idea now, at
> least for creating new LSM namespace sets, that's good.  As the only
> LSM that really has a namespace currently, would AppArmor be able to
> work within the lsm_set_self_attr(2) approach, or would you need
> something a bit different?  If so, can you give us a basic idea of
> what AA would need to work?
> 
>> There will need to be an additional call that allows entering a
>> namespace separately from clone/unshare, but that covers a different
>> use case.
> 
> In this particular case I've been thinking of not allowing the same
> level of arbitrary LSM namespace composability, but rather limiting
> the caller to the set of LSM namespaces already configured for a given
> process, using the procfs/setns(2) mechanism.  Does that work for your
> use case(s), or do you need more flexibility?
> 
yes it should work,  I think the LSM/security namespaces need to move
together. In fact I want even less arbitrary composability as I think
switching LSM namespaces should be able to force system namespace
changes as well.

Their are all kinds of potential security corner cases you have to
worry about when trying to move them independently.

