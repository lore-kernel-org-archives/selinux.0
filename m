Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262ED2E8B77
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761018; cv=none; b=gOY/sNlj90ddzQW0ZW/gBiTr+PtwZwFE2JElpm57UglGuhKEOwtZuxl7+XS6x8ynTSsGkWeL/xhzCQYKreIXyHJweaUa4ohkyFGwHvVYjinQnVWlTxPBhP78fCfSuGhAWv0vJhSB8gnT5nUmNetu7DXjEGuh8fpK+yl5oVk9bn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761018; c=relaxed/simple;
	bh=D8rrGwDasgphAEpIHrNyQKnQpsy39nxMN7y2rXqfqok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6k5FXyZB1JVj6IY+M1Q4vvgOLscxotsVBBMRtz4/J0H5khR+szVs2xguyGbdeEI3sHvttR2xOxb/jftjjR/rHnSyahjBcsbhIEX2EWQc9F5pnCwcY2kpoEY0FQs+JfoNPHbsrlAZ0lyr61hFWIpcLE343WwvWXTWu5BDBFPk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oZ6sEa1b; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oZ6sEa1b"
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 044523F7BB
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 07:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755761013;
	bh=1UdB6YDwCu8+B0RwSxb1MjcdS1xlgzUS9TquEYnc0lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=oZ6sEa1bCEXTMnFcAD9u4Z/9WQZFoiC1o+Y4H5l3VeFQpLkO7um5i5vAm1tR4o13H
	 JtILoqcE+U12MNSTuBjWh1NAuI2DqhVZKn8mVSTw0yibzXDgIB9rowhTApp4bJEO8k
	 k7T24NjTGxEw1+sgXLRYavI4C9+MI69K9/bSXN7aT8zUmSFFlrPv48kmBYOWrs6ivL
	 29PD2WHioo8E+m3QVanTXXov0XdRaHeBQONpI2cSBsFUM9tcQNBOfi8OGI16u4wn1Y
	 73RCo2gC06QBJ7NtqeL1XGqNpMsAKrJxMAhRjlJJ7M3IQRQKA0rHHATgy+lg8CXnNj
	 v1AdYjW7GylSQ==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4716fa1e59so599259a12.0
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 00:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761011; x=1756365811;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UdB6YDwCu8+B0RwSxb1MjcdS1xlgzUS9TquEYnc0lo=;
        b=XHlS5aZ8FeUMuaGcvNHB4GsYebYJEdnP2zWMG+hf2WK0+nzbbhgiWrVCVq2sktbyn8
         +r4ndkkEVcH5ieIQAaK66rdeqnl3K/N1qWLZELxRmHeCXsoNie87U5L9AylenHPUHrHD
         ZgtwF3qYY8XEKx4kylvtkpznrGscXIloB2OgtUhZdj6yPFwnUBbUvBj4pPltPsHmTImB
         wBPMJ4sa8vdFsZv0aBMVMFzuN+ZP1MiYSAyVcbveu53vHD4BzVE0WNu9iQcv5be3OMka
         nozKk220K1slr7GWw2y4Z2tNW+wa99SEPWdsEHSJD5uPbok1V/5vvRdI0YSS5l/tAkrH
         L8tA==
X-Forwarded-Encrypted: i=1; AJvYcCVibFTTtFJNBgxSo8JI6t5DEIyTYIrZXoK72RkbxFvthaHaoV8oIB5qHoQj8KVIQrNVYdgVsA9C@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtjsSSgfWW29/5aoDiQWrdPtKaKRfuLnpE8NlUXGE4dlu+6Qp
	kQo7bNkdpWVe/4nwxd+mUeJ5HF1SV7nSOlb6igiKZW5gepp3HT8om+CsY0RLaPOdyUdYodlStLc
	9MMmDElorkkyNeUGPLBhpBJBhzxYaLFSuuLl1viYCHOJmlZyMMF1mNbtTPVcQqM4wyfGSKdUCTx
	w=
X-Gm-Gg: ASbGncul5A13bBnwnkT5zcwhdivp6q/dEAI8nNgoosIsErb8Bs08lTq2ZdUYlB3GKaz
	rG67a0evxXlXYRl/rSTJ5TOpbZ8FLh7vloxmJ91BuIFgsIfYZXfRhYX8iqAVj6ZYZbn9ZYQWe6J
	Qs94LMLMWcyQGsq0McFthLRCccZ30f6eKUVrcDmaLCRTGN1zRA45Pm4Jr5Vpw+R+0vdpxYbW71K
	lTCnLIMNPnBJOZFnzZPuklgdp+sOthz9DdekYVytVJZK4UT6vEWFFnmt/iVZOLORvYLtvzbAZZf
	YOMxWLusHLl7lu1obsI6PO04tgeMDiaXmzjGrxCj4AwUR70V5iV48w==
X-Received: by 2002:a05:6a20:729b:b0:240:30c:273e with SMTP id adf61e73a8af0-2433089dd4amr1879040637.15.1755761011517;
        Thu, 21 Aug 2025 00:23:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2kbgR3RWmMnRvSLUDWTTq+4WW7cgjddoxa6NCNLPchL+Vl8xi54jvhD46K4U6W5FWTya+tg==
X-Received: by 2002:a05:6a20:729b:b0:240:30c:273e with SMTP id adf61e73a8af0-2433089dd4amr1879012637.15.1755761011089;
        Thu, 21 Aug 2025 00:23:31 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640d3e3fsm3970040a12.56.2025.08.21.00.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:23:30 -0700 (PDT)
Message-ID: <7d4d60d6-fe50-4646-9f9b-0cb524aef3fb@canonical.com>
Date: Thu, 21 Aug 2025 00:23:29 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
 <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/25 11:40, Paul Moore wrote:
> On Tue, Aug 19, 2025 at 1:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>> The advantage of a clone flag is that the operation is atomic with
>> the other namespace flag based behaviors. Having a two step process
>>
>>          clone(); lsm_set_self_attr(); - or -
>>          lsm_set_self_attr(); clone();
>>
>> is going to lead to cases where neither order really works correctly.
> 
> I was envisioning something that works similarly to LSM_ATTR_EXEC
> where the unshare isn't immediate, but rather happens at a future
> event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
> LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().
> 
I do think something like this is needed to deal well with the two
step process. Without it is fairly easy to get into situations
where you either need more permissions, than strictly necessary,
because of steps in between or as Casey says things just don't work
correctly.

There will need to be an additional call that allows entering a
namespace separately from clone/unshare, but that covers a different
use case.

