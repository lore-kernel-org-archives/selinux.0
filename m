Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974B8F77
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346212; cv=none; b=tiSYSuqcvqqCorTB6ehdIf8kaE9cNMwXKvU8N+Dzb9+j1lpa94BJ1aziVQdR/OvZF51LX+UFiHn3TNSZfgzySyMqN6lcW1VDJPU8+wWVUUqG9Wcq5yiQaQsgm0aK20WsXLTiFEaSpRjDZ8K8QyQOGDFpBOU+jHyva0fL6m/EgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346212; c=relaxed/simple;
	bh=4nZucfLdk7KIR7E5rGssF/DkWp3Sz4hjcm31HAxfXlA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=UwZPbXZGYFesN/bP5adZ3WGpyCmjYJGC2ffvxPTd1zn1wHIFYx7RdFk1CC1e6qDnqM27nTxYvKUKkNzRW7p1bRAwhKWKAbxOWV/sSGxFi+8x0WhAN9+v9UDpWDhC8kcrJ+iwsZi7E+E8a08RjHtYKUzhOdUn8a2rDlDRydEMc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7zlUS25; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7zlUS25"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7180f2f5fb0so2789178a34.1
        for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731346210; x=1731951010; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBweZQskCVNgb1sI5FINkpI6YZC9BhfG3ocDQ8fBmko=;
        b=V7zlUS25Iu6kdN9UapQcFut8ajywEZ4p+OgFCYFfFFsqoSXYelGoFarbsVasHF24JD
         6t8zw6GY+vvVvHg49hort2ssDWIu2gEC75i09F9BdYN+DoZSghKs9G2/tz6khWN9u7yH
         3EZ9S7QLyRzZVJF0wuw3sT5foA7rzRwuRSOK4qx/ZIvWQAZQykN9VUjnWyYniMsu25Da
         ZKEqpXMGCkDZsjLxxYxpxzHOWQaWLoqllHJ5cw19kvJt7YHXi34LDT5aF5WbXTF9EwO3
         Ua/nY0ze0DCVb4maEB1YD/ib1vvvl0FwDI6/td53qahEz3MwO9bNEJGyzapmwHBSQA9D
         nA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346210; x=1731951010;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XBweZQskCVNgb1sI5FINkpI6YZC9BhfG3ocDQ8fBmko=;
        b=VMyaIEJ2arAn8mAYyhS16EBEYu4pV9pneXWxSS1D/CatXaGyNS8x4+QVY5Nk5/eD6a
         ZhVPxNlm7WiRGzClmMOnUvsf2bhs1oMx2nOouur6smPDzVrRjkufS5gMVLg2deMEneNO
         r9RPw4Ns9Liwjb9cYCCnQE9hUgy8mTWn8/zBntkydzX5SzLJ4XaVtoRXHFVaccNtDW+T
         AVnCNGM32cVm/N8Ts9p3ut+3OrfIwrpyGIEouPxsciLO6CBhM5il/RFAI+VEvMJHlhpP
         w4BaIASm88RItQHj3PTLTJb3dKR7Iffs+m2pAUJ9SB7GEWU0eOFTXh2JPZxsUCKB4c8v
         i0/w==
X-Gm-Message-State: AOJu0Yw6UypJlOsqprxNlSYb4ipKeX3dgpSgrjyTBneJ9aobUTJELixC
	S6MBZxJ6eVijdtAVzikl5vyeb2hIG1MYA1nEC5C1LREcSSqg4/sd8De9yexb
X-Google-Smtp-Source: AGHT+IE6DNqgf5q4QoQe+Cnj3QDlsDK4nolELRQQOvaBwH90OQvRrjXyjLdSH86wLx8g+MKuT0aTvQ==
X-Received: by 2002:a05:6830:4182:b0:715:4e38:a181 with SMTP id 46e09a7af769-71a1c2839eemr12124885a34.25.1731346210204;
        Mon, 11 Nov 2024 09:30:10 -0800 (PST)
Received: from [172.31.250.1] (syn-192-063-109-134.res.spectrum.com. [192.63.109.134])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a10920002sm2293329a34.65.2024.11.11.09.30.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:30:09 -0800 (PST)
Message-ID: <3df128ad-cd76-4fea-a905-60d7f02ca4ee@gmail.com>
Date: Mon, 11 Nov 2024 11:30:08 -0600
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
Subject: Allow rule not having any effect?!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm either missing something incredibly obvious, or something really,
really weird is going on.

I have a policy module that includes this rule.

   allow runcp_t etc_t:file { create write setattr };

And I can see that the rule is loaded.

   $ sesearch --allow -s runcp_t -t etc_t -c file -ds -dt
   allow runcp_t etc_t:file { create setattr write };

Nonetheless, I am still getting this denial.

   type=AVC msg=audit(1731345803.780:3765): avc:  denied  { create } for
   pid=289668 comm="cp" name="config"
   scontext=system_u:system_r:runcp_t:s0
   tcontext=unconfined_u:object_r:etc_t:s0 tclass=file permissive=0

AFAICT, this makes no sense at all.

Any ideas?

-- 
========================================================================
If your user interface is intuitive in retrospect ... it isn't intuitive
========================================================================

