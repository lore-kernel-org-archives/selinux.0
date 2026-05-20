Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2E335BBB
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293774; cv=none; b=m1ovD046Ic6/EVD2XGUh+xOXw1btuHrCKZGSR2nvj+n2sysF/0nrwctWrEO6arPX3wo+roGko/YwJ69yf1A+GUBVK9UD8av2+UFuB54igSX3uvSYov501SIFwb2uQGDCP5UdKvm4QvaR2tjTtomZ9BH5nEF/dE/ql5VldkKJZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293774; c=relaxed/simple;
	bh=76yMtgU773bvGonpbe6sJDyYS5/b8Ni7ok4J6qn3gL8=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qvfsz++0+dvrbot5p+eM3d5ZI0/8TBtKNP0l4MpdbCqW6M3q7Ko9S/qnp40LhqadfYK9MEWSpx5HuF+ujzmJ+FogypSnrIBKyaqsjKPpNp56GDxomVUsr70AFsDjWCFHIGFE2mq57RrLENu8rh1xY/828trW5rs07Z9pCbR86c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SJ8+CutK; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SJ8+CutK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7cd35604a95so41576627b3.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779293771; x=1779898571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDOXOpZ2o3bmOCr+w3PDPlDZY3dnyke+2TyHRlyKfsM=;
        b=SJ8+CutKpiv3z3c837TPiftQmzTXt7igeDSu/CwoJLe49ffFJUm8cNcBA7TzCZmq4R
         LYEYTMYAqW/JNCMpEuXSI/gKNXcB8gZC6vQTzSb9w8g+QcRldvZkYFqxKkKm2Nflk1RB
         oPwlLwMltfV5ZjlGdu7azM3iDUNZjroYWMgN12Fa5oofRvVp/F3hIlEka7V8kF57diL/
         I6GsWPj4YURRkp8LCkOS4wc/gbRpVz2cpfek6LvmUd/v2+xl/He8yMJgWe/fRYF14dya
         wcV2l5QfLzePxa86f1910eU8+tJP9W0V6w95rPTv9xvAJx03jDahbWligJCjWd3E7xr9
         FvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293771; x=1779898571;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDOXOpZ2o3bmOCr+w3PDPlDZY3dnyke+2TyHRlyKfsM=;
        b=cx631iZRyns3ENqv/39DseMKgKRbS4yR7hNL2KtNNjm5UvcbjS6yr8RYXWlgMiaO3I
         FimdQ6eyxeT++AfSFWkfKb3IMxUc6SJTXapSmtwa5CrXeBVvE1n3NFivT/avUl6JKRJD
         DIz1u6tozO3KdUyLNBRPNCY4ESecG3VrCxREFwIY2VGN93KzmShEISTrxXMVgXgS1CcD
         azgkGYkyG2WG4ClInDp4080HoHHRMH6nzK516i9mivzUondyZ9bAFHlwtH9EqQi8sChX
         SU3/eLDJEJRNbqNBnVLoZT8YEamrHDnAy02/8QCIBTn9g6diLaOf8tCjxqJAXoEJf+a6
         u+gA==
X-Forwarded-Encrypted: i=1; AFNElJ8rDyg/+1OMRu1hTsVTUz+iUmqtqcWeghe32m093l1hwmRTVTihjTjGZgC6FmmcoW312wktBuj3@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJbyqy5v9BwfDHEg1vWqA06jVm5EZJtT3wXctKlw3+iY58UrD
	4UP1LwEfL9TN86oePkhFWEHKwesJN3x3RGFVN3fcapEs+lb+7eC1w0tYTuThLTeDdAF2cppN1Oz
	edTI=
X-Gm-Gg: Acq92OESl4m7+IoUBuUTc3HwRW4fCJPpRdLFMeRLOsyc1JPBRvOsUGfaHMakW+HXAKQ
	bOgSzAuBl6XtrvwumIU1Yv9LAL+I4gXgfhaWHk68P5HzI+X7fCnb+Zw4isJycgkNx0VkYdkWz5U
	PNGgUIgGM6pxLcSEZSquMe2iJM3XH7drW2I7xmkzkb9bGlHlfIS9zYneUChFdGlH+RiD8j+0n6B
	70iVAYTHJvnPfTHCuvEj6ZAwhSKNlyWeGm8FE18ATHLJqaZfufkA91oZ7x358xDBT5OJKwR35L0
	XlR3RYiIA6CPg/TgMoRqndHKJvVoG961so0E7igviKx72p4Z28in9kgEk9m/etFpjD4Gf94Mc67
	FyTGWxvNs9euHRSjZgXkS3opUgGjjFCiv6h8t/SE4ENBqfQQ6PSTfweJY8IIZnyqAYjB8h1pVwk
	5fY7/1FXPSUnKyR7rqA60r21Xn9gNYX1Rn
X-Received: by 2002:a05:690c:89:b0:7b2:30d8:b680 with SMTP id 00721157ae682-7d1c33899c0mr1976997b3.5.1779293771284;
        Wed, 20 May 2026 09:16:11 -0700 (PDT)
Received: from [10.175.64.171] ([12.74.59.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc997cc32dsm55542197b3.19.2026.05.20.09.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 09:16:10 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, <selinux@vger.kernel.org>
CC: <omosnace@redhat.com>
Date: Wed, 20 May 2026 12:16:10 -0400
Message-ID: <19e462c5110.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAEjxPJ7ynbRQ0OAwFUj7RGH17WBpC9Ekwhkadu=wfq13XjAicw@mail.gmail.com>
References: <20260507161633.15947-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ7ynbRQ0OAwFUj7RGH17WBpC9Ekwhkadu=wfq13XjAicw@mail.gmail.com>
User-Agent: AquaMail/1.58.1 (build: 105801620)
Subject: Re: [PATCH v3] selinux: tighten type validation during policy load
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit



On May 20, 2026 11:45:57 AM Stephen Smalley 
<stephen.smalley.work@gmail.com> wrote:

> On Thu, May 7, 2026 at 12:18 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> Tighten type validation during policy load to improve robustness in
>> the face of ill-formed policies.
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Ping.

Pong.

Just a reminder that there are free things I dislike more than "ping" 
nudges. If your patch hit the lore archive and is visible in patchwork, 
it's on my list; if I haven't acted upon it yet it is simply because I've 
been busy with other higher priority things.  Nudging patches like this 
simply steals and wastes time that could be better spent elsewhere.

There were a few of Christian's patches that weren't merged due to feedback 
and other concerns, but I need to go back and see if it is preferable to 
fixup and merge those before looking at other patches.  Maybe this is good 
regardless, we'll see.

--
paul-moore.com



