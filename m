Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5615853B
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761223; cv=none; b=g9kkv1U3Bdw143GFUo3JzI9eeoRRqXRqYn7M08gsyqUayrDbeg+V34Kx+nD4p2u+SuieACQKm6MWFg+PnTEpEua9cfnmIUXvmbQJrnh5rCqy5mzbovNbGBicHtwnVZZb4BnZKDab8P+XBa6IgUoCCuRMBPduS+aE7phmaqBaA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761223; c=relaxed/simple;
	bh=hfvkqTAOApD9wjX8xERqq7B9PhJVuhrMgW8OzvJfo8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Za9gLBdhK6k1BlKx4S+1FRvbjetSC/uMVjHC9z+hhTKTyTrahaQuzgkU9gSbacXRKOhUxO+9bG2sMzVQbNtSJhGPcnVhcxrHBon9dwOymJmKbCp3GfuYxeIakkyINID2Nt3wigmw7cCVrrXd3BpHD+DvdZJkQldmTyw/kJhJIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WVZURp/N; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WVZURp/N"
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E09633F7BB
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 07:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755761217;
	bh=ue+OkzzV4KiLpEQiFbe32AtZ1fJoFqD1qTwNljdERLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=WVZURp/Nlw7Uifs1017xsT22qYbrv8FO5kivpB7v78zgF1Kl787CUEsolW/5nSPXz
	 GqnD/SKAJrOKD9BHxdPzjIoMz7liS6/sS0lsyeM2aC8RAUqBpAq6nkPoMxv1Bsyu/o
	 gNL1FG2b2FIFyh6MP25y+gSaMXdqOaeFUOpw6jEMrL3bALrkgq9nAn+pD1gYGI41On
	 uaVjl9gw6RUzA5S4mieYMw3ISsLth6WNroPl/IDSvk11e2F55tIg+DZh8yH5cRxRv9
	 jkGchMTUOjMPP8vckOO6uzl5YX5dlIWeHhZYOiN7J8gX+T2SqTdMhXCXwUg01ua3d9
	 QXMKTwdQ9mppg==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471757d82fso585483a12.3
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 00:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761216; x=1756366016;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ue+OkzzV4KiLpEQiFbe32AtZ1fJoFqD1qTwNljdERLI=;
        b=au7W2cDvyW3EE/JzWKrsroP0Vrx0BkftLnpEg5HlvxwTU3o74WAiWzL+MxuiSHN44n
         YyQSn4Xl0YA0xfLN3tBLKStADxq2Enp3Ykjxz150tzGj5j4iRrd3QXhCuQjnrfMSJfhg
         3PvjC5tKF8c7BOiN9PStLj/D8Fmve+E1DfCAge9quEZ9Vjeog9M9NheRc5ZPulgudq0p
         nWdcZ0+ZLtmrFrTNihZqGnFChjVjRSfB8eRc6/8r7DeDxi4Li7TBIP1WQ0FBOC8nCMIx
         btGKJDCQ8Otof3vGiAxZKVKaUv/vy2q8wARV9nV/PMyp17SXkl5itCQGx/orBKIZgRxy
         b9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNnIsvMu8hunWd8jVRURf4pyXLS+TSjEZbGohz0xYX4SHkJe04AjP93C3el+krdV3Vv0BBmjy1@vger.kernel.org
X-Gm-Message-State: AOJu0YyAHpwtjDWgPPYDTVlrEB/sxHVve4Y3AWXAfy9jaWGPhfNvjJdm
	vCe18xmdPpS7xtPdNE/67R3jj64pdMRKbJwvk3Y6IIOJ5A3TY4khUt2hGnzOxptYTnAHrbAl5+f
	6UPWL18S0IDhGPtkqHgR4JgpQgmnE24C+5VkaAUNfNb+VyUSDSmF01Bp8B9Yc6UcLJ2phGMydS5
	s=
X-Gm-Gg: ASbGncsdlFp1erbwXl2qGNLSESaTbY+FNS/JK+louOZs8/G+omPMgouo6uh8q5k0D+S
	bUP2tuAaoPCQ4TcWvMGZWPkWOwmnH08dzsiJIeW8C4L4HheJD97YdH2Zvhv9xWpqien3EOIF6me
	wUbxjHbsoyPHp4UDvu0vvN8uzFp6ap5GgAWmAuN3EtPoxNrt7bDX1dpid36zu9gMNHaCWubUfK/
	Wlt8Ym+Hb51SBWsuFrg32eiOLHw4xrZcpfuF3OQQaQkijoA7MqjdFCTLq8J5CQkEjEdGjayRgrX
	4Od+EFUju+7csOOjUcfjD4dg5WBU4JCoUmyDm9DGFMYK+9HmUiT7Fg==
X-Received: by 2002:a05:6a20:5491:b0:243:78a:82a6 with SMTP id adf61e73a8af0-24330b3d501mr1985589637.60.1755761216177;
        Thu, 21 Aug 2025 00:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjCWtMRF+Hu+oQrp6a212vrecViVy2agy7+gPfMCUx2OtWLBxQ994MtDvOa5rf9EuEWC0mLA==
X-Received: by 2002:a05:6a20:5491:b0:243:78a:82a6 with SMTP id adf61e73a8af0-24330b3d501mr1985543637.60.1755761215241;
        Thu, 21 Aug 2025 00:26:55 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-76e7d0d98dfsm7375246b3a.17.2025.08.21.00.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:26:54 -0700 (PDT)
Message-ID: <bd0733d3-02d1-4543-9430-af685b644f24@canonical.com>
Date: Thu, 21 Aug 2025 00:26:53 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
 <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
 <CAEjxPJ7NpSdfUZzzj0SnN8WuUv7E9SEj5v28x_y8R178_JMESA@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAEjxPJ7NpSdfUZzzj0SnN8WuUv7E9SEj5v28x_y8R178_JMESA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/25 11:58, Stephen Smalley wrote:
> On Tue, Aug 19, 2025 at 2:41 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Tue, Aug 19, 2025 at 1:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>
>>> The advantage of a clone flag is that the operation is atomic with
>>> the other namespace flag based behaviors. Having a two step process
>>>
>>>          clone(); lsm_set_self_attr(); - or -
>>>          lsm_set_self_attr(); clone();
>>>
>>> is going to lead to cases where neither order really works correctly.
>>
>> I was envisioning something that works similarly to LSM_ATTR_EXEC
>> where the unshare isn't immediate, but rather happens at a future
>> event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
>> LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().
> 
> I've only implemented support for an immediate unsharing of the
> SELinux namespace, not any kind of deferred unsharing until the next
> exec or clone.
> Not saying that would be impossible, but since I was following the
> example of clone(2) and unshare(2) I didn't do it.
> May be some complications in doing so, but I haven't looked at it yet.

if the hooks are setup correctly I expect it will actually remove some
potential complications. But I haven't deep dived the selinux code
yet so call that an uninformed hunch.

