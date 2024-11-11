Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635B4C66
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341647; cv=none; b=fhHgdXjOZAJyrqJ+d1LJ958ANU80wz381jBABFrGOyLvC4l9hGXLC5h6fGevO2KokjicUutlfEZXbu089oSQbPnZ1TmJiu44HESl1DX3WDZEBi6EN1fLhOiWi1ZbDD+MwDHAeCNmS6S6BsSXW3DzHklpkv0tLxQskRvcVjL6XpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341647; c=relaxed/simple;
	bh=B2NThZxQShAdeaTMi4HL1KtFG2pXvjOG0QuwpT1J1Dk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kbstObaG62GaHoG/lU7ckVylxL9pfEtmWKOKvNGXM8pHvPFRLgdsh3h8KJZxmNGNxmyklhHOMQzLvTa6+Wo94xIC0r06fn2c7hYbPNh1XbZXIZDBLtH9GhISqV7bz6TqjYlJqUIYbVUhIWzNFPYdyi0zt1GNGYjOHuSEQtV74EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9ONWpxw; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9ONWpxw"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e5f6e44727so2982493b6e.0
        for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 08:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731341645; x=1731946445; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/uKV/Af5nriU7p1mSTmUUvZblcMMU33OHK3bziZX3g=;
        b=I9ONWpxwSe86KHw4/kXlirIFHdjdYv6SVle1v5Otmbzgbgsfmvz0Pm50C13XQGcacv
         vim9zHpTjy2qAeCYVZXYFgDznSSXqDzvsTRovMkOjcXp/Vf9yVXmuSWS1dsN8xEToKTH
         dElmRQgh1xRLyATsv44YRnx/ECVGxm9vYdCaxSHh3WRoY+9qBvkrn0e0iwGbyQhUdGIl
         SPnsD+NVPZPSP6O2U7AbtiSuF+Ewjkm/Wu35yQaVF7ICJJQwAiYxMOmac7Ac2aQTABJ/
         mtjF/M4HoF+rMsPa90dDRTb2TtiJ1xHMTzD/M9VnWANOtsWNJuM4Wa6X0qDTZYmFhPMS
         SySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731341645; x=1731946445;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d/uKV/Af5nriU7p1mSTmUUvZblcMMU33OHK3bziZX3g=;
        b=LFKNxliHRs5EYcjoXUtDdv+qhmjatzC7ttZN5mYXvtB37h7Z2FX9kwh69flk4EAus4
         xpxuN9cvK4it+77uSlvkusagRimG/GctH2ueA86/R4/0CMuynM3b0Dox/ScmLSpbBicb
         /XC/plwanE4h7WBIuvBbskaVIvM7p86Q+etsrEEMamK02N5B0R1JjPo2QhYHnPSDZZJS
         XlKdO3Y+9hmDdlm7gRTx0iw3nz0+Hx9Vdyjt3MsTc8GhMdvVPGmI6xyC7sK+oeOJGFcE
         V6vusOewGvXdJXdn5ABkyy49TZoffg1OlGxyU4QUkI2eeFk4OYqB0LBAjTXnvuminAQq
         KXzA==
X-Gm-Message-State: AOJu0YyJ5bCk+NA2o6gJT1YF1+hdrZRSY7S+0CBM6r7gaevDeCyx9EIX
	nOpI0oGjgeC0FlOWMCbyOzg6UOCB9DOqJtVJE/ce2dGoYcnF7yzKnoxCEVl/
X-Google-Smtp-Source: AGHT+IHfNxajEaX5Vsf6T68BkeQBtKBomwRV9CcZlHzZfXZKAfzHj0TgvBXynojbCbhP1btReGd+lw==
X-Received: by 2002:a05:6808:2103:b0:3e6:5663:3324 with SMTP id 5614622812f47-3e7947210a7mr12297345b6e.36.1731341645104;
        Mon, 11 Nov 2024 08:14:05 -0800 (PST)
Received: from [172.31.250.1] (syn-192-063-109-134.res.spectrum.com. [192.63.109.134])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd294a2sm2137871b6e.33.2024.11.11.08.14.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 08:14:03 -0800 (PST)
Message-ID: <435b1b8a-a6b6-4180-a038-520d226b88ef@gmail.com>
Date: Mon, 11 Nov 2024 10:14:02 -0600
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: SElinux list <selinux@vger.kernel.org>
From: Ian Pilcher <arequipeno@gmail.com>
Subject: How to write a policy for a "service wrapper"?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have a service (stunnel) that runs in a confined domain (stunnel_t).

Due to changes in Fedora's systemwide cryptographic policy, I need to
run this service under the "legacy" cryptographic policy, using the
'runcp' wrapper[1].

So my idea is to create new domain for the wrapper (runcp_t or similar),
give that domain the permissions required to perform its functions, and
then use a type transition rule to run the actual service in its normal
domain.

It's simple enough to write a type transition rule for a specific
service, e.g.:

   type_transition runcp_t stunnel_exec_t:process stunnel_t;

However, it would obviously be nice to allow the wrapper to be used
without the need for service-specific rules.

Any service that normally runs in a confined domain presumably already
provides a type transition rule for the init system, e.g.:

   type_transition init_t stunnel_exec_t:process stunnel_t;

Is there some way that I can make the wrapper take advantage of these
rules, possibly by transitioning back to init_t?

[1] 
https://gitlab.com/redhat-crypto/crypto-policies-extras/-/blob/main/runcp.c

-- 
========================================================================
If your user interface is intuitive in retrospect ... it isn't intuitive
========================================================================

