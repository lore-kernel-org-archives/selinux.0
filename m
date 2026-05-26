Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2253DB658
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802907; cv=none; b=pEyPMDVcEYK54ihPFFN0wYMvDAkr8KVB/aB4/ACR/p/kNVcY3aUi0LS+mZGjew7KZwXj9y14/wUFLJ9r2T3tyWmit0FOrt3vkzja90cGTUxgP5sCuZuO5Dzmp1bsnk52BRuVAn7cCNuj5s+06YfnosDRTVoFrpSLwQ410Y60x7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802907; c=relaxed/simple;
	bh=nF3qM60eYVrnqSVB5XrcCB68Iiep4RlBrW15aall6I8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pwHrwIDl3Wk/RvDEWsodfhH3gTFrclzt/KQP1ViJpmwtnaBbXIK+ISCf+2B7nhGNA4EO1qRa2ACz/YXEEQ3IMkg5C3PKUHBvpdOMf0Wp1gMIgeM+Pj6srP7+MdLzemMbu7RA29jWclEpq7gGFD5/MR8DCdBLDvDkeuVIPOfmESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlmJjjM7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlmJjjM7"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-367c26471f5so6797903a91.1
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 06:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779802906; x=1780407706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF3qM60eYVrnqSVB5XrcCB68Iiep4RlBrW15aall6I8=;
        b=OlmJjjM7vK0Mc4htmc8rWx/1r0bBXRxSpe+GtXgyDi5jnmKsjOaPHuPXd4twxHyqqI
         pOpBxYAIOcd0OpL1uLqc1RVfy4K6aqVUS7KSFrQZGEYr6RYXhpiUAJA3mt8PEpCU+7cT
         TX4xsgtCkP+Ln+0J3LR7WjaY+Ds1qXAbV7lsXQHJOfNUjunkVNMVsxNWurHoI+R9z+Dk
         UiPDYB6Cyuvb/oHimHfZIpOy4km++sdayctahdIQ1I/ffJtp/0g+kltUItUzLHtM0t3y
         YxdpeVGWreEk5yVTKu08ugfKdMxFa+PoTEsb9BVCcHeFrzwm+kNxRFiQl3xU10RQj2/S
         iAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802906; x=1780407706;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nF3qM60eYVrnqSVB5XrcCB68Iiep4RlBrW15aall6I8=;
        b=dMRKOSkAewFpyMdg5tsckvSV4E8KTVEQV882TSzuMNqYFAw5H9c9rXyGg+3KeDLvwt
         kIXCcTJhk2AJQNFgDB8nPyoSHUqs6Bz0eyS0ku0xFOlFZjBiOS4lUr0V47F+wbNXmWwl
         eVrWV4MLpPCSbUmayjP+e2aYXWSu9zml+87E0j9A2NPuOusjkeXVK7+0+tWM5W9eRCQq
         oMlx27rWW/ctBiZ7KLwvRrc2pT9s0fHgMfsS2AdL5XHWBZ9DDKD2TAkLy6L93Jw3wA5B
         I64RCsXSQ1j85BgWKwmfUrjL8zpCi/g8ufX3D8KgOdYBt1+yNHst7tiXxCfTbJnTDuat
         868A==
X-Forwarded-Encrypted: i=1; AFNElJ8MixO3Qt5T3ZWKDji/vZIX2yIZHAg2c0VkmkWE3a7mUTuLMG6IAtMV+zXuK5j6eBHchb2oFCNr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cVXo2vESkBbRYe3QFVZKmUjHVkkBpt9eMwwuRXSWG6US6TP4
	qapudu7gmGHYd+PkVYkJvzPQfhYCKbfSf5tQIZP2ufuW9T8VblSSzsiv
X-Gm-Gg: Acq92OEjyPEhCQ7+oi+afow+wSiKjU9RDANy4rGb/2aSCtjYeLSLVJf/1uTtH5G6RJ9
	4GKoHtNs69bYXX3uYDPkhR5+MASAnxfjr6bjvLFoWLqBbEUQ7Gf5QJEB0WgdxAo4dtjcnCqv8Ig
	wXcgmsWcFumUavxiqxyjYm8au0Y8TlIvs2W2MIEA9hxSbcLSTVJ1gxeRBNy6gJ0sY+fQwnMxGt7
	uT6VpFpGioBpxG4Hyopu1ECfmcaAQ2oEJLQk06onT0Fuc3i83Hdjb+Q3ds/tm+e4jJcimMZxLf7
	k/v3uoJPKoZU99ixOAfeABe2CFy4aBkiMUQkD4GFFtoSOMeGWYmhD+BG0J+c1NvC2kiEdDpThLV
	q/9lEwgmrIv8RtAe9HL8l2F+3Ah5pdm0x12hnO37z++DGJirwQDYoE7WHT1vT6ltyB3VuuhoukW
	41ofiv/ug7gVDICmC3hBh+2y34N2kmTp9Wl+5fxNdeBL1Cgg8HrOU0nCjwi0is4AfPLw==
X-Received: by 2002:a17:90b:360b:b0:36a:88b3:cd5f with SMTP id 98e67ed59e1d1-36a88b3cfd4mr9868813a91.19.1779802905857;
        Tue, 26 May 2026 06:41:45 -0700 (PDT)
Received: from ?IPV6:240e:39b:ee1:f550:1055:2536:37cd:e603? ([240e:39b:ee1:f550:1055:2536:37cd:e603])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a723cf27csm12643242a91.13.2026.05.26.06.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:41:45 -0700 (PDT)
Message-ID: <afd2e7c1-d9dd-4bb6-860a-0380b39dc39e@gmail.com>
Date: Tue, 26 May 2026 21:41:36 +0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liem16213@gmail.com
Cc: 2541289564@qq.com, anton@enomsg.org, ccross@android.com,
 cgzones@googlemail.com, eparis@parisplace.org, keescook@chromium.org,
 linux-kernel@vger.kernel.org, paul@paul-moore.com, selinux@vger.kernel.org,
 stephen.smalley.work@gmail.com, tony.luck@intel.com
References: <20260520150054.27994-1-liem16213@gmail.com>
Subject: Re: [PATCH] selinux: enable genfscon labeling for securityfs
Content-Language: en-US
From: Liem <liem16213@gmail.com>
In-Reply-To: <20260520150054.27994-1-liem16213@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,all

Please ignore my previous patch "[PATCH 5.15] selinux: enable genfscon
labeling for securityfs". It was submitted by mistake.

I will re-send a corrected version later if needed.

Apologies for the noise.

Thank you,
Liem

