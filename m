Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751116D9C8
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675037; cv=none; b=EgYj8r6ixZ/nIBF/W2+aeqwhRxPerPDQxydu78Rbylpg0Rmrn7dB4018nJ+I6eauOLpASen4yvIH68BNj81FRsBW4K7AcZaPMMbtzFNg/HnxXVmrfsdufXnb/t3NmzyMGvl94rcJmm9XObQ5t6lzbjnLCCvjZjpPxw6mJnluaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675037; c=relaxed/simple;
	bh=3FOf+XqV/VxlBjepQuVNCnwEh/6cuy+dHEINaaodVrM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=HJn/P8khUcdDWShmK3oIESMN2BU/tbXqM+xUcqvnvyv+dq0m1zWzR4J1qSI/YHOj6ion22f22dahV6YKZcvveiCDhXjg2Lm0/0WCWA3sa9zBNs7YGnI+Hv9OE2H9QtyI4Aia4xU3vQ36aCTtJieHL+dDnfvqzreGJZ6I2SbVQPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=eDMpcpBc; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="eDMpcpBc"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78edc3ad5fdso183970485a.0
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1714675033; x=1715279833; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cal8r0cL+yRVOKYyttBoOhGC7r6E5ZDnN13gIj/u0Ew=;
        b=eDMpcpBcaLrdfFp7f+7czZdI0m2IyfWEcUZJgEBa9+jvjjP02UNDt1uiWqqv03Zm0C
         fHbCkQCgn9Mv2GENfOUbJe5b9zO0bbu/YlbKc2g+Cj1goYgXuugwPJOFcE2J25qA8SdG
         Rq+JHMtimJo/zBNmp4qVKfBnmQHB23JaMmRHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714675033; x=1715279833;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cal8r0cL+yRVOKYyttBoOhGC7r6E5ZDnN13gIj/u0Ew=;
        b=iesF08ukhXW2KqameN2zfL2Lf7CSfJd9x9ikhOcBw+abOIRb2LyccnS1cSryV6gf8r
         UpPNqTzdkuzfGNIhXaVfKBZGqCmTOetGiaJyCjDgCO9yHQqA5pNs8G9qbexg1LOiM0AE
         ZKQe+d5Z16QX89aBtgq+hz/L/dacocZE1Hkz8kp5XNGfmnukOwe8MC4TW/LVVTVNuDPM
         o1XbRxKiUinMy1qem3iZsmb4a4heFDx0w19KPRCdOfWqGeqVccYJLtYiwPnp1sR7VF84
         +erFTKZ3DbWP2Cs5TrBU15zvxhtqE7RGwIt1nS/jvg6Vf157sHGaAWYX9l4thIyl+Ls6
         PPPg==
X-Gm-Message-State: AOJu0Yw00TWiZ+oNFXy2udy9a1Arb04C9cAbsKLQJQm9Winjv2pOsguQ
	skoo2dJO2Cx47AEcDg2JQ+MOlnJ2EsUz4JWGeTXl2rysrpv46O9lMD1rh1Hyd9ZAzssdvKiv4bV
	BL37bLpqemx9Wff90Vy9Dqpxo2MJoll97wWqx9ZbK++D0vTymhmwjYbf//8bgFVn391S96wRtTO
	GVOP4UUnDVgTg9HZN2EbGApwo+PihOe0im
X-Google-Smtp-Source: AGHT+IHMkiIUUcUB4uRvIxzB057Ldu6SE08y+QU57UcVeKD0dXhvg6oVB7IocRLWC6syHGloIExePA==
X-Received: by 2002:a05:620a:5a44:b0:790:839c:b7e5 with SMTP id wx4-20020a05620a5a4400b00790839cb7e5mr1067016qkn.24.1714675033263;
        Thu, 02 May 2024 11:37:13 -0700 (PDT)
Received: from ?IPV6:2601:145:c200:2c70:2020:2d0f:26df:59fc? ([2601:145:c200:2c70:2020:2d0f:26df:59fc])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a201900b0078d5b3b5b4asm562650qka.125.2024.05.02.11.37.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 11:37:13 -0700 (PDT)
Message-ID: <d3c9593d-fc73-4016-b057-57706e94d170@ieee.org>
Date: Thu, 2 May 2024 14:37:10 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Chris PeBenito <pebenito@ieee.org>
Subject: cgroup2 labeling status
To: SElinux mailing list <selinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The state of cgroup2 labeling and memory.pressure came up for me again. 
This was discussed March last year[1]. To summarize, refpolicy has a 
type_transition for the memory.pressure file in cgroup2 to a default of 
memory_pressure_t. For example this file:

/sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure

with the idea that we allow daemons to write to this without allowing 
writes to all cgroup_t.  Unfortunately, the thread ended and I haven't 
seen any improvement.

The conclusion was[3]:

> Ah, now I remembered that we made it such that the transitions would
> only apply if the parent directory has a label explicitly set by
> userspace (via setxattr). Not sure if we can improve it easily, since
> we can't use the normal inode-based logic for cgroupfs (the xattrs are
> stored in kernfs nodes, each of which can be exposed via multiple
> inodes if there is more than one cgroupfs mount).

Testing on a 6.6 kernel and systemd 255, I still see the same issues, 
where most are stuck at cgroup_t, with user.slice entries get 
memory_pressure_t[2].  Based on my investigations, the user.slice works 
because systemd sets the user.invocation_id xattr on these dirs.

Next, I tried modifying systemd to use it's version of 
setfscreatecon()+mkdir() when it creates the cgroup directories.  This 
did not change the labeling behavior.  Next I changed the code to a 
post-mkdir setfilecon() and then all the memory.pressures finally had 
expected labeling.

This setxattr() requirement is unfortunate, and the fact the 
setfscreatecon() doesn't work makes it more unfortunate.  Is there any 
improvement being worked?


[1] https://lore.kernel.org/selinux/87mt47ga29.fsf@defensec.nl/
[2] 
https://lore.kernel.org/selinux/CAEjxPJ77ZiWTwJ=hj2DFoNCg4XZMfiU6VNSNAnyCKc0Rd+nM6Q@mail.gmail.com/
[3] 
https://lore.kernel.org/selinux/CAFqZXNtLFsmb3n+H=7Jcp1g_sLEFdRL75fzvjMvTU1rXvaQXMA@mail.gmail.com/

-- 
Chris PeBenito
