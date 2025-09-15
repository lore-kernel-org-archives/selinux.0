Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07340199939
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967377; cv=none; b=RHWc/YS/RQC2oNGkwzzXMITla+eTtVAUvbat+tU4sQ+mp9dac5JsvUNp42fb+3r4jB5c3lMkIsG01PTlg1w43SDdnESmiKrvwnPbjLEtB9idK5nZmIjf/+eT7Hq4H3gyZ/lpj7XbwDkqxg47UEwBda1ilI+PObhx8PHTmlJl5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967377; c=relaxed/simple;
	bh=BpFop+7dERzO0hTitX/Naad9wuh1X1WHMVwgNynUP3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieqJpWI3VeXONTy5csHU+0Mttbe2UbSfNWPLNKAV4UMCDkI8GsxwHwc6+lL61tZ697Q7JRevaE2R2vNxfP0vSH5ZzEHggLpREJWwdR/Fjcf50yLxknWY9tSgB2UWRWf80Bv2Sc5OHzUs4MubG/u/jA2/K2XhODvQQZ0WtejGR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=ZWceR6cM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="ZWceR6cM"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b61161dd37so36452511cf.3
        for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1757967374; x=1758572174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w9KGKfv/QBGz0Ummjj2T1B063yYg6gR+dRTCft/6tWQ=;
        b=ZWceR6cMY/qH+AwsTqR2wd6/VwFALCdwXrQV6eyaHukxNFYlLsFrnOD8jyHHCUNizQ
         05MibxOY3VA34EJJdYiEuFMe2SXk2gFzHj8++ZmLSDAE7HnQbjaApEXW2yeKcr423QSw
         gm2HsC31mSGuh3DTVwLdE4f5Xqoztl64BTqt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967374; x=1758572174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9KGKfv/QBGz0Ummjj2T1B063yYg6gR+dRTCft/6tWQ=;
        b=i2HYRVv+FGM3IgELefXY3AvzrlZ33R98EhgK+DrzW6884iTGmM+HPD4jLrgIavF/Jt
         xrjomPXAzO846D7CzSDsHFqQk/SKInrqniOt4py3hE480Du1imU+SseiW0lIRHTvoWom
         h9zrckuce37d+HvYxMb6Ow82cGn4x7VpG12/+4meZnMuAddHCgiLV+gj2xQckdREvVEc
         LdMlQm1IUXqv7JfOCbMj3pmtKnBieG3wiLR/KBiHZpJqCapTRtdwjz9o7D3U6gpQzojz
         /hERwIwphhanjqxOiDkMO/GcNEWWh6Z1sWCYucR90UJp7jAKk1b6aFZcikXd8uNdQYRb
         jI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFKKE3rruMJJ5eQGQImuTCc8UxragzHIuh4hsuIStj84T5LZBuqIXuA1R2jjHLwZolXM2FRf5o@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4BDW8vZAh/X7yMGWUyyeYu/Gr5yYwTGkqqlFGgN+CgMTmvu3
	ngQw4ZgAvXTZ/ubij/S5GqsVZSlrLM32MFka2FUuGXKvtT37uArbqZOvm9wC9etpXQ==
X-Gm-Gg: ASbGnctkD16Law4nuBFS7gf+sBSXOBp/Re1C+zE7Is0nSxmcofDc8N8MkKCmdBD2Sim
	TxyYAMwlp7vbwdTvUd4kn+qivVJwZv160rfCxXpsA5xRc8R9U6h4+JoXJSvs9SOYPzf6HUugncH
	GHEwpCxC3pDBUowDNhHZcBTfCS41HlpC5ywqIUY7QhoqfZ71SxlFyViOmGdAoNKNsuTudeZ7eKF
	3hQQw2ytyOJ9b1TRyDhhxP1pOkHf+CJlmfdTkMVdmF2j8ikjtS34tukqeOr20mHf4beIenk3juX
	/3ulomo0vJdYLwwxU+WhMBIrAQ+nfDiVVsSrBtlOJj4ActjjBhkGhWVwqmzjjys58zU5wFBwRd4
	KNFwmsli4Zf86LAmCIWXnTH2UX6DseyKQ6Q2bLOM9ARYKsj5aRsfVT9RlCRUwbb0h4jBv3iB2XP
	Ub
X-Google-Smtp-Source: AGHT+IF1J8Fy56P2k/SebbtRw4BGsxW+loHnC5UovXLzS5EhLDiaaaGi4RgPh8O8eV0GDxqeddMBhg==
X-Received: by 2002:a05:622a:1104:b0:4b4:eace:d0b4 with SMTP id d75a77b69052e-4b77cfdbc5cmr214273161cf.16.1757967373382;
        Mon, 15 Sep 2025 13:16:13 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:b902:615a:edd4:262? ([2601:145:c282:5650:b902:615a:edd4:262])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b7a29cb0afsm25781021cf.36.2025.09.15.13.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 13:16:13 -0700 (PDT)
Message-ID: <d3a2e381-1814-4d14-978a-8a2ad02063a3@ieee.org>
Date: Mon, 15 Sep 2025 16:16:08 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Lack of official hosted macro documentation
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: Ian Pilcher <ian@penurio.us>, SElinux list <selinux@vger.kernel.org>
References: <7a27eed6-9554-4f6a-9f2f-2cb1efc522fb@penurio.us>
 <CAEjxPJ5F5YtqqOb+KTiC4-ED+0YMAOLfKnABNnggjK_N2hhzjA@mail.gmail.com>
 <1ea8829c-7b4a-4048-8045-768b5af70218@ieee.org>
 <CAEjxPJ692h1RbJfHLGfVye7diVW1r5WJz=P0iZeNet0gf8Qusg@mail.gmail.com>
Content-Language: en-US
From: Chris PeBenito <pebenito@ieee.org>
In-Reply-To: <CAEjxPJ692h1RbJfHLGfVye7diVW1r5WJz=P0iZeNet0gf8Qusg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/15/2025 3:38 PM, Stephen Smalley wrote:
> On Mon, Sep 15, 2025 at 3:26 PM Chris PeBenito <pebenito@ieee.org> wrote:
>> On 9/15/2025 2:01 PM, Stephen Smalley wrote:
>>> On Mon, Sep 15, 2025 at 1:56 PM Ian Pilcher <ian@penurio.us> wrote:
>>>>
>>>> TL;DR - Writing policy modules is harder than it needs to be, because
>>>> the documentation for the macros/interfaces in the reference policy is
>>>> not easily discoverable.  This could be helped by hosting the generated
>>>> HTML documentation in a location that would be indexed/processed by
>>>> search engines and AI chatbots.
>>>
>>> Great idea. I thought we actually used to have something like this but
>>> am not finding it now.
>>> Chris, any clues?
>>
>> We did have some generated pages, but when the project moved to GitHub,
>> there wasn't a place to put them.  There hadn't been any requests for it
>> to return, so I never looked into it.
>>
>> `make html` in the repo checkout will generate them in the doc/html/
>> directory (from the repo root).
> 
> Maybe we could put these in GitHub pages for SELinuxProject?

I have no objection.


-- 
Chris PeBenito
