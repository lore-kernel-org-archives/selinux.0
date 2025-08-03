Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EBE259C98
	for <selinux@vger.kernel.org>; Sun,  3 Aug 2025 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754224146; cv=none; b=W/XhEztqb5hUj8J0b9Z0e88Dw03p6a6F5I43orLVsDP6EsmW/eFrEyzunebqFKGNWJjmpDyjBkr8k0D6cxIr3SWcNLlmAEP5iR9zGvYJ8lORHu+i5kFCd7RgQgeVnr0YXYOLPiB7nhVy7squS1pQ6AO5rudwVjxgnvp/8xQyDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754224146; c=relaxed/simple;
	bh=jZONuA8Ofkm2TC9oNNAGTRYf4axm+rq0wA3rFSfZeIU=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZtjKUO5zb/ABxlJOuc/gIYedGLi9S3M2C1ZTMaLmJBULi50rKLFjJwujtPrNDOHpsRUzBTXI2ZObEwrx1RpBpzoAVzg0OzHM6uBEFi9kDN4GzQIylfxwCZj1SNuSelqjLMw38P3xmU2YNFJ4q+DMaVni9X3J4xRNlZkbTenjbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A9kDfVr6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A9kDfVr6"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e29616cc4fso330431885a.0
        for <selinux@vger.kernel.org>; Sun, 03 Aug 2025 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754224143; x=1754828943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7HA0pRVM9SoTu+ksBDIzzQ8tXpjz+c9fJTyLgCZuno=;
        b=A9kDfVr66Y2fEK8n6bMi+/OvmhTlzTaKf7vRacefB/A9nu1KOy7xe+E4yNwXkD4DbH
         0/Gq1gY5IV65oMGB4kpHHoDtuWLKgTHzsOlPsYGj0m3N+6E7JB/jZDWCWBLWB1ZUu/1o
         Z9N1/WPaHBDUFO1IQO7+/AQyqCvIVK8EjFozURlUNsNuswWo8gvbkvsKHOAOmAzheR+H
         PwsvXHJQJh1xXy6Z1U9Ki4J8CJo0Ntg3WviVe+mSwz6odxVJxglrDK7qBw4aCPYr241H
         5kwdvnOtXLAhnx/yBiKiyyRpS5tc+9MyeJfC2Kav3C3agvf+ZHuscAvijZ/zd87iLtt9
         L0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754224143; x=1754828943;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7HA0pRVM9SoTu+ksBDIzzQ8tXpjz+c9fJTyLgCZuno=;
        b=UQk5suW3PDB8VMNZSjwTti+28jkW/SpPoUhPjuQnosSZmLC3MrOkPj5tu0ZEfS51RU
         8DU367vKJ6AJz54p8Sj6QQX3cdR/ioXVhh0gnhWkZ3ctr/XcwN0Ex2L4W7zBoZOa0GHU
         xwfoWz12yxp0KFQVEgWKs3ccV/QNKwQjFmaDFht6E5tYDlsZH9aAaaBjtRm51W4OLMV8
         ht3VkZReTb/e6goO9X5SP1rewsGaU8MwEYClzrPFTKZ/TpI4SlutrstSi2kuchFi5g29
         5WX8rA7s1SUfn93OAN+wKZIWDPG2gAaXf4HVCiGPLd6wcAeYZ9y6YGAgZ7WVXjBy4Iho
         nmmg==
X-Gm-Message-State: AOJu0YzARKLImsLa0qPUBPi5mhg5rek2D3sdBxCRcbkJeQQQidzs953P
	xPspKmHl+i01WePq1wuvHWGhfjaBPFrp3XErValp0OM9i0IqO3Jpdt3oC1MjLcM55g==
X-Gm-Gg: ASbGncutcB84dxACNxqUDTJ/iEgVefaVABBmKxdURIqSWLX+OWHDyNR9wOupSY3lByJ
	mTPeFSyOuWt7/Uu3DYm8b0qHxXeShfBfQhPOD3tdtGbDQNVluALi82EC8mbRIm7i5LMv5ocpEfd
	gGZq4v0jSeHoQifLCHakcaO+kO4ujP45bkwfticdziiK2eCUDnt5ANeHQIQXUPfaroDBC/W18ry
	o+DvSI1y1bk1UgihO0w+jwpJPTZmx0U7K6miQkYurFXVYAd6D6rMbxgCYPij3VwjdVWILmgonTy
	WGQPnrwfqFrzs8SzccNaMdZHXJAmv4Goph/z/1J1gybd5Q9MwMquc/4UZ04TwDo4kW4pvpGXPZx
	Ob5W+WbxqyBcrbT4QmqRru8Bf42ho2dv+oQghckfiubvKwVBK1LEXrx4y0zYkylPD8kza4F5l3/
	5wZOT61lxaz3kz5A==
X-Google-Smtp-Source: AGHT+IFRXdbjZDUhy4Y6C0hpgtnCXPlHfsmM+O1EHd9Xzd8J0FfdwHLeL+iafuezJcw9fI8UB0EOcQ==
X-Received: by 2002:a05:620a:208e:b0:7e6:3802:9b38 with SMTP id af79cd13be357-7e696268400mr726536885a.1.1754224143596;
        Sun, 03 Aug 2025 05:29:03 -0700 (PDT)
Received: from [10.73.150.193] (98.indianapolis-14rh15-16rt.in.dial-access.att.net. [12.74.60.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e681c8c727sm411213285a.78.2025.08.03.05.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 05:29:02 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, <danieldurning.work@gmail.com>, <ericsu@linux.microsoft.com>
CC: <selinux@vger.kernel.org>, <omosnace@redhat.com>
Date: Sun, 03 Aug 2025 08:28:59 -0400
Message-ID: <1986fe81af8.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAEjxPJ7d=LJ=Rxyiy6TpjEETVhkAkKxJci0Hog1v+55V8jvpdw@mail.gmail.com>
References: <20250801154637.143931-1-danieldurning.work@gmail.com>
 <CAEjxPJ799AYzKGMJr5vmcP+b_ikPncy-vwaKZudRMRokwyuXMQ@mail.gmail.com>
 <CAEjxPJ7d=LJ=Rxyiy6TpjEETVhkAkKxJci0Hog1v+55V8jvpdw@mail.gmail.com>
User-Agent: AquaMail/1.55.2 (build: 105502562)
Subject: Re: [PATCH] selinux: implement bpf_token_cmd and bpf_token_capable hooks
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On August 1, 2025 3:30:02 PM Stephen Smalley 
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Aug 1, 2025 at 2:38 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> On Fri, Aug 1, 2025 at 11:49 AM <danieldurning.work@gmail.com> wrote:
>>>
>>> From: Daniel Durning <danieldurning.work@gmail.com>
>>>
>>> Implement bpf_token_cmd and bpf_token_capable hooks for SELinux.
>>> For both hooks we check against the token SID, to support
>>> delegation. We could add a further check based on process SID
>>> when the token is first created.
>>
>> I agree with the approach - it is consistent with how tokens are used.
>> I suppose we could perform a process-based check in
>> selinux_bpf_token_create() if it was generic, or add one to each of
>> these hooks if we want a different permission for different cmd or cap
>> values.
>
> Ah, actually that doesn't look viable at least for the token capable
> checks, since those look like they can occur from outside of process
> context if I am reading the code correctly.
>>>

Eric Suen has also been working on a SELinux BPF token implementation too, 
and I believe he is planning to post it upstream for review soon.

I do expect we'll need to have a discussion about the access controls, 
especially the labels involved, as BPF tokens are quite bit different from 
many of the other SELinux access controls.

--
paul-moore.com



