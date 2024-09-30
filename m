Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF62199254
	for <selinux@vger.kernel.org>; Mon, 30 Sep 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719941; cv=none; b=HStht5LAZn+HqNcfr+BXBaWh8U/keCaSP1wv2mBhQzg73wlFbFHR9XSAPckMwI6lvsLGXTIFaD1LdillQWHKxD+uWDuiXP0DWnunvXmOD9+8nWoqXFJh9bXKpxrHcczyMo/Eh5yjAlA0ue6bG/UDVRIR1g+++OuAi5/wZp8V9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719941; c=relaxed/simple;
	bh=WDG50jRwV6IxMjd3T/8e2m3B4DdhmKkMvP4gjTQvjNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMheKSo6fdWoBR6cNPLtzt9WrO1CWrq43FHMPqMVNC79LLN0zw3pWrmj/fpo4ecKipzaOLGUSbXTfq7SN4RweTiPc92603BFBKF8MXXl/thMIcG5n+9CHV/bq3QhDKzJCwg2Z0ZNiqZznpUAzZR5ObkmYtoT2iaOJgPBXLP4JYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lf/VRF2Y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf/VRF2Y"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398a26b64fso2993478e87.3
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2024 11:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719938; x=1728324738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8pOy0om62HvuyaGV9tTsQv35sz2SwXHWRsOTdJKnk8=;
        b=lf/VRF2YhOgxwFCeXV/i5tgD6VwnU/teiib2CDNQhKTdp0uLGxUnPqG59DSv2v4Q1L
         3URyKmA8Vx7MWmGI+UZvKy6+vJZZC0xqLbZJX/WobBJfTmZnJRnv+2VfddHxRRV+fEZ7
         eGNmYiv2yT3B2Reax/yh5Z86b9s1pE006M4qdHZT2u/yeJn7mTnFegCs37Fj7cqP9OD/
         QgxAUA6sWjLlEhYPpbl/LccNjOnEuj7BYKvmlAWXpIH5EXlZdHAIZh/Ss7C4G9GuViW+
         PeMKqgEy2con4ModCIhtzgS1+zDzlmkMYtD0rkr+IBKPOL7usNOs5fUCg6tUWdCNUCPx
         61QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719938; x=1728324738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8pOy0om62HvuyaGV9tTsQv35sz2SwXHWRsOTdJKnk8=;
        b=qSieiYQNQP3S794GzCVHljr2KCyxMVedzeS2pulPL1B1Jv+Uq9ZMcbiwG0S9MKhD2L
         mKJU9KR1/bqCYqn4fPOuxY9wbA0811cDyklxv7imO8H9UTh2GbxltJ1fZaeoJmYYaZXu
         XKdEe19j2KsFHCZwwGk5IDPZ3ZkeEcjBUJaRci792IPhByV+XogtesTOkwwA+slqhL9A
         8lZIV6ZCdeemnPzm7pZIccKkK+76au5+kIWYu1XxHydJWQQNS1Qu7pPc2CFriBkLx++l
         RAhhC6VgKPrZAzsVI3ZUauMGljB8f3PaUcJfGwOTs7cVTIG9pSFze7uStB3POhwPVL7A
         xh2A==
X-Gm-Message-State: AOJu0YzcQzk036J5m7fQItkHwO5dFTi184d8VeqjA/KgH//Lg3+xpDw4
	k6WxACRVkY2uVuuRBcLt3ut6kWCdFl+M2KeGeqk/tIKGPkiIVJRD5+tmZg==
X-Google-Smtp-Source: AGHT+IEhHWPP0cJpaFBl2d10UH+f8SL0rP3lfbCn7diDHyGJ8EZ9FTNBom7ldbKEL3UuuXu3B8SnMQ==
X-Received: by 2002:ac2:4e14:0:b0:535:d4e9:28bf with SMTP id 2adb3069b0e04-5389fc774ccmr6137017e87.46.1727719937310;
        Mon, 30 Sep 2024 11:12:17 -0700 (PDT)
Received: from [192.168.1.65] (85-156-69-24.elisa-laajakaista.fi. [85.156.69.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a0444274sm1308944e87.285.2024.09.30.11.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 11:12:16 -0700 (PDT)
Message-ID: <8992e65f-b1f6-4376-918d-c7c81a649c53@gmail.com>
Date: Mon, 30 Sep 2024 21:12:14 +0300
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SELinux namespaces re-base
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: SElinux list <selinux@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com>
 <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com>
 <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com>
 <CAEjxPJ7C41QdEgAFYVdTyZE=TjGq+pyzCmy7BbHMss7=njvJmg@mail.gmail.com>
 <CAHC9VhRDF0DBAWM-=ynks1=Zm5LcQYq0_4xfQy4pKvHfW6FoBg@mail.gmail.com>
 <9aa53afd-efd8-4552-8239-14f99ff7a1b1@schaufler-ca.com>
 <CAEjxPJ6vyDjmwxEpwnb+JYKiWXYFo5g_suZiUZb6L+aepHxZiA@mail.gmail.com>
 <CAEjxPJ4nbCuntgTvrGk4LHs+ZYjm95ZwwSwwAycWWzS9dt9Tyw@mail.gmail.com>
 <CAEjxPJ76MdNwgXtGTgVYGKE87=7GmZywQ1GJn5Vz8jjCdVATWA@mail.gmail.com>
 <CAEjxPJ7Qp9Q4RUYH8vb-xQOe0=YsN=nbyM-4FV6hvYzZwKX5Og@mail.gmail.com>
 <CAEjxPJ4Opxv+HU6cbAfKNT=ZXnUZ=0Ac8ZM5fQj=wnO_JPy-zw@mail.gmail.com>
 <CAEjxPJ7Zpw9i6OXZ-Kz=WXVuCaas5TOtxCAmK-rxGDhm1-zwDg@mail.gmail.com>
 <CAEjxPJ4UsFbFvuigZ+WZD0zuPQ-mY9MRQ-3+SYp_bDwBE_1z0Q@mail.gmail.com>
Content-Language: en-US
From: Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <CAEjxPJ4UsFbFvuigZ+WZD0zuPQ-mY9MRQ-3+SYp_bDwBE_1z0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I wonder if SELinux namespaces could be used for sandboxing, 
specifically with systemd. When enabled for a service with a directive 
(something like NamespacedSELinuxPolicy=path), PID1 could load a service 
specific namespaced policy and apply it to the service as it starts. 
These kind of policies could be extremely minimal and hardened when 
optimized.

The implementation should avoid interfering with other sandboxing 
activities and also avoid AVC pollution from them, so preferably there 
should be a way to set up the namespacing and load the policy in a way 
that these will only take effect at next execve() call, much like 
setexeccon(). However, errors should be returned as early as possible 
though so that the error can be associated with the loading. Also it 
should be possible to enable SELinux namespacing independently to other 
namespacing options as they are controlled by other directives.

Would this be an interesting use case? Would it need major design 
changes? Systemd already loads a SELinux policy at boot so there's some 
infrastructure in place.

-Topi

