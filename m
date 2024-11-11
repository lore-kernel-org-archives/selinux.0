Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA41AA78A
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350249; cv=none; b=e4e6Aj7Q+i7B96L6FPjRrpoFHn7W2S2//+tMptfZqCBS3mD0BQRCdhlOmVq9Sw6/LtcXCach0S4FrK535nHHkHDHjj4bNZrYQgUPTfznkbjBwxwz8160IJo5yvjynHW5Kl2cYVa7E8+QBS7c8xnUdT+rZ+6QqMZy4V3MlS8pGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350249; c=relaxed/simple;
	bh=Va38O9zfvQms38wuU4A82iq+NiSPtlH1olBzAKno+/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JewTobat+sD9DJ91+lDDDWx+myIR2pFzHxqOmVLHDiKfd6O7OMT1G4tGYY8kbwO5pS+YJ371+ckEk7D5Pq6m7G0a8PGOSDWjbe/egPOHAkd1Br7iVNSLKnFNBHznJCumLWDO5OlKyNPEkbgnTPx4AH/MK9w/2mwVoL0Pe+b32lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZKgsiNh; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZKgsiNh"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5edf76cd843so2047545eaf.1
        for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 10:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731350246; x=1731955046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyAtVaFiostGUj+LMg3xBTxDt86R+3E95spVQRFcoZs=;
        b=kZKgsiNh4bmX7tiypRxg6Iat5WlXiRXPAX3xQzUAX3r2Vqri3dUu1erD/tUlXQu90R
         9+UsJ2Bca4jn7u0RRjhlQWoOOiQ2yl8iAzA6GtkeEsSNVz3UjatYj3n9KqmrxGlaIW1l
         o9bGKDsXscMyoU8A85tdSHQV12bGhSyQzbH4kWqB2R+Q/LXLwOYOG/HPWMpG6TSl6hlc
         Lw1YEXgr3sKBF827I88A57j0TsB3rdD6krny+FXDYbK332W9tg0ojFsM0Zc+vkpoPyLq
         WBgYK2zj3mJ0ATYpT2kLuHJTcY9e81h0Kh+6Hh8AZbJ7B/tbbEfkvUAa4+cMmJU4m24B
         FYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350246; x=1731955046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyAtVaFiostGUj+LMg3xBTxDt86R+3E95spVQRFcoZs=;
        b=ABJpe8wGvjziPM/9gJhZKZeHHq9TBuT3+KBkcSfy4x3bb5nQkIRYK4Hpfr0Ax+Z16w
         BH5V2QWuxBbz/u57mIFUpAh5vRzx75qBPArznHGMEIlMIbDBPFJRK0PO4n27qscrqG8n
         yIllIRnN5LhGceddmYFFmk8/7UGau/0HaKFneS5a1fTl0p9etnlj6flBqeoqUbdtaRRX
         bFxAilxy7Lj+P9Bm2ubvgYdd81mGpgIS8n/U1mhrVGj7xe/CRxlM36VYKDca0/plA+6S
         OIxsRu+YEvhorUMZOfX6GwVYTa+gGM4JLkCAD/l/VoqHp6NYeCSGc1oyUbHQiOdrr9lA
         ShKA==
X-Gm-Message-State: AOJu0YwjXQktcwxaIKT57IhmToW0GXoenUPyqJACaCg4vh+R7eKhiZ3v
	zrhLvb51Pw99LuERqb0CgMmRnt0zqC6fnnqqKoxuJFH73okDKT/24OXQZOG7
X-Google-Smtp-Source: AGHT+IGKRyTvDK5bTUvPLXQBXHAlAQV+6KrLu7KyCTOeqguR2DUyFW64IIrvi75zO4bklTmgt1YktQ==
X-Received: by 2002:a05:6820:f04:b0:5e5:c489:6f3c with SMTP id 006d021491bc7-5ee57cea3f3mr9227897eaf.5.1731350246090;
        Mon, 11 Nov 2024 10:37:26 -0800 (PST)
Received: from [172.31.250.1] (syn-192-063-109-134.res.spectrum.com. [192.63.109.134])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee4950f85asm2033446eaf.11.2024.11.11.10.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 10:37:24 -0800 (PST)
Message-ID: <3f38459f-f7ec-4373-95af-0b55c1ca1c33@gmail.com>
Date: Mon, 11 Nov 2024 12:37:23 -0600
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to write a policy for a "service wrapper"?
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: SElinux list <selinux@vger.kernel.org>
References: <435b1b8a-a6b6-4180-a038-520d226b88ef@gmail.com>
 <87ldxp8vtq.fsf@defensec.nl>
Content-Language: en-US
From: Ian Pilcher <arequipeno@gmail.com>
In-Reply-To: <87ldxp8vtq.fsf@defensec.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/24 12:33 PM, Dominick Grift wrote:
> 
> Ian Pilcher <arequipeno@gmail.com> writes:
> 
>>
>> Is there some way that I can make the wrapper take advantage of these
>> rules, possibly by transitioning back to init_t?
> 
> You can label the runcp command with a private executable file type and
> then allow systemd to execute it without a transition effectively
> running runcp in init_t just like systemd. Then when runcp executes
> stunnel it should transparently transition from init_t to stunnel_t as
> if runcp was not there.
> 

I like it!

Thanks!

-- 
========================================================================
If your user interface is intuitive in retrospect ... it isn't intuitive
========================================================================
