Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D65C179954
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677371; cv=none; b=N6SonwAUizsUbrHxa78IFMivmZIEX9VhPLDaJ47mnL5/zAirK1PNL+mSn9KkVYl69HtHAxtrhsP/UJKwLyyz9tOGHI5zAnYO+kj7TdTyq8CQesyQq4/D3p86cpRnm9rGLidpM+wtEzPpsf2lgab/2uIPaGmIOmldFKCDW7eAZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677371; c=relaxed/simple;
	bh=o8lls9EFOsyIOPRxoP+DAWDxN8rUumtXRDXkAFWCrmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjBh9B6liN1QY+i9ye9BT4teg05tx6nXzBaak5YgYjqlJ8F0GTRwpa7lFPJ+NO6DYzA5qQNCkcRGvkbRKC25eN4694kyp4iLqU/6zeczNytJphT4MDzBu3G0sewwVf1LbG170L7ah3mHU6GbE/bPDk/fAd2Gi8MBa//TMFRhNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=CSYQekpH; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="CSYQekpH"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23e0296af17so466400fac.3
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 12:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1714677367; x=1715282167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fozIR0QL8Kf40VkzTMgRAXTX6MAsA7Ps39lFgqWTXwg=;
        b=CSYQekpHeQhZ/N2RbWMP/igXMWfYcP1Vz39+fDln1hc370E8aJoyUpY54vds+4iVrP
         a/UJDHwel/JzDD5k+rPrKtV4bMy4AFPFxZQU5d4U/5ZRV3QWUQL7kG3MPn8I7RYkP4HE
         Q/2r5lB2g3VC9BROxksnFb/coOjWEpFUhJKbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714677367; x=1715282167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fozIR0QL8Kf40VkzTMgRAXTX6MAsA7Ps39lFgqWTXwg=;
        b=uaoqgsb92UmU6nwCb3rRuEMlS2N2mvhVyxGLckDxHac8fpzKH5b1wOhKs4jKsnJIrY
         2n1TrfQmISAc4oshYwmQ+/+H20I/U75CxJK8463FQV9BNT/K5L06GboYH7aONk4ZMFrk
         psaicJq1r3qL5RvFjqxuqw9vnlS4tsFgJLddgUFLtDYbWufvIjkTPFAjEYL2D9A14Nvp
         vdix/BHixiy+S9L5mRrayNRzNVbW/JHDCd035L4nfhauBsam8FMuTsBkwO/4KcsmIZzj
         TS62Z0CU58AEmSwZpvJi9vh5/g+fGfXZxtXEXw3BSFM/+FAvL203Vx9S20isslTB+Nwa
         7NKg==
X-Gm-Message-State: AOJu0YxegGgu/sX00Or6uFrOY8N8c6thCWu+RhzoDUWPDVLaywYwoZ0E
	LZOTqyWMXTWsgXob4TOMcAl3wnuhuzagb6+TiACyUN4ph5GqVKXXsQMTbWVXrA==
X-Google-Smtp-Source: AGHT+IF0tIQtnC0BJ79vbnzlHoQObj2eEgOKzFsY7aXIm9+gDy/XOKDNsKSVUL1khrptjDxL/Z4stw==
X-Received: by 2002:a05:6871:5213:b0:23c:6619:5970 with SMTP id ht19-20020a056871521300b0023c66195970mr982212oac.7.1714677367596;
        Thu, 02 May 2024 12:16:07 -0700 (PDT)
Received: from ?IPV6:2601:145:c200:2c70:2020:2d0f:26df:59fc? ([2601:145:c200:2c70:2020:2d0f:26df:59fc])
        by smtp.gmail.com with ESMTPSA id f19-20020ac84713000000b00437392f1c20sm733156qtp.76.2024.05.02.12.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 12:16:07 -0700 (PDT)
Message-ID: <2f3f2911-bed9-499a-a117-56a404ddbe33@ieee.org>
Date: Thu, 2 May 2024 15:16:04 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup2 labeling status
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux mailing list <selinux@vger.kernel.org>
References: <d3c9593d-fc73-4016-b057-57706e94d170@ieee.org>
 <CAEjxPJ6uFiUjb0siO4+D8a7Z9ZB=WWNdO=54m1RsCO8HT9n5Yw@mail.gmail.com>
Content-Language: en-US
From: Chris PeBenito <pebenito@ieee.org>
In-Reply-To: <CAEjxPJ6uFiUjb0siO4+D8a7Z9ZB=WWNdO=54m1RsCO8HT9n5Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/2/2024 2:53 PM, Stephen Smalley wrote:
> On Thu, May 2, 2024 at 2:37 PM Chris PeBenito <pebenito@ieee.org> wrote:
>>
>> The state of cgroup2 labeling and memory.pressure came up for me again.
>> This was discussed March last year[1]. To summarize, refpolicy has a
>> type_transition for the memory.pressure file in cgroup2 to a default of
>> memory_pressure_t. For example this file:
>>
>> /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure
>>
>> with the idea that we allow daemons to write to this without allowing
>> writes to all cgroup_t.  Unfortunately, the thread ended and I haven't
>> seen any improvement.
>>
>> The conclusion was[3]:
>>
>>> Ah, now I remembered that we made it such that the transitions would
>>> only apply if the parent directory has a label explicitly set by
>>> userspace (via setxattr). Not sure if we can improve it easily, since
>>> we can't use the normal inode-based logic for cgroupfs (the xattrs are
>>> stored in kernfs nodes, each of which can be exposed via multiple
>>> inodes if there is more than one cgroupfs mount).
>>
>> Testing on a 6.6 kernel and systemd 255, I still see the same issues,
>> where most are stuck at cgroup_t, with user.slice entries get
>> memory_pressure_t[2].  Based on my investigations, the user.slice works
>> because systemd sets the user.invocation_id xattr on these dirs.
>>
>> Next, I tried modifying systemd to use it's version of
>> setfscreatecon()+mkdir() when it creates the cgroup directories.  This
>> did not change the labeling behavior.  Next I changed the code to a
>> post-mkdir setfilecon() and then all the memory.pressures finally had
>> expected labeling.
>>
>> This setxattr() requirement is unfortunate, and the fact the
>> setfscreatecon() doesn't work makes it more unfortunate.  Is there any
>> improvement being worked?
> 
> Possibly I misunderstand, but selinux_kernfs_init_security() appears
> to honor the create_sid (setfscreatecon) if set, so I would have
> expected that to work.

Does there need to be an xattr on the cgroup2 fs root directory for this 
to work?  Based on the tracing I did on the systemd code, the post-mkdir 
setfilecon() would have happened on the root dir, but the 
setfscreatcon() version of the code change obviously wouldn't have 
changed anything when it ran on the cgroup2 root dir.


-- 
Chris PeBenito

