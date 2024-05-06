Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD076410
	for <selinux@vger.kernel.org>; Mon,  6 May 2024 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002378; cv=none; b=ojQa6m6raiNI1GzWkFwaA3h+5eeKxgpEqzsW+UcqoVXOPQSJHZQc4OCMOwc8/GMZBoHMlJNxfUcqVdSx2LQIm3Y72xYP7pS4MZycx4Ry4CbabRvNgCduQuuk1aEHnbdyygO1IA7EkZhREkpbfZAJMwRmu6B9l3Jls/1JNy6F5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002378; c=relaxed/simple;
	bh=qrx0MfyDpm5OOF0ed394+bCzYso2aK0diQJsP+2bpWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IH2mEoTkjHeJWGNboTWMxKPxuCM/meJChd1s0XT4H9T0CXFOpEb6jY1w1zAJEC5fjv+W4nj5CgqePrDS7HCSPD0I8z/woO1gA8rZuo3PGBI901mJDbCKzOlvso/OVBL0KQ7ZLkqaiWbDn+mtUfCZq95V+WUKGKJ52YFWviqVJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=Jrcb7E7x; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Jrcb7E7x"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b6c2e9ed9so7766476d6.1
        for <selinux@vger.kernel.org>; Mon, 06 May 2024 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1715002375; x=1715607175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAZ33dW+Fk9wcRrFJJa9x5mvT6yDVkknJ1g4uODUMrs=;
        b=Jrcb7E7xxTQJ893DVqMrcaPSYDDIJCbafRKdRO5COw8Lz3hEOf8jv9PyCnuNjf8Orh
         2zxQww5BFp94qW0M3DwVcMiilUUhccfVaGoA3QGueG8HdRGm3dmbcTfd4oR3Z0Yo7RhE
         1srrJBBTaDJ2/zYWOQVH8sWjk9Br7oBYpoH/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715002375; x=1715607175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAZ33dW+Fk9wcRrFJJa9x5mvT6yDVkknJ1g4uODUMrs=;
        b=ogS5RAtCDzY6LuZDrzd+qBx5pKT4R5jiyd147PQgnR2bX0EPs+us4L+RffGEKMLI9K
         Ieyw7LWsDmU0+BnoyCgQMV8nd/ceKCP6O4nKsRcZsOtzz5T1B6NglCNReKeqyCIfYzRB
         rFWXIj8yB19tZQFC4rqX4GsCq+6tknT/DCRExCtaT53P1KNeL/6fD6LEs4OzXP4P+oOe
         4V31uD3Tr5L2D7eVJhpvZHdorcLsjs2jV3apB5/eQhQfHLc10iN/rhom2Sy13rS/qoB5
         eFcWpRn+f208xM7tE31n93lgh/MrunCQmpShniDPu/yA9rsCzqMpO39qluxGRvPQhidB
         cyMg==
X-Forwarded-Encrypted: i=1; AJvYcCXg7ZvVEYNJYlwJKF/YOZ5ZTfyqZkbZD6b4rqK6lpHrlqEYW5orextA0884Co5v6q0/W4+eWEm0/5MLkbluYOyBNkpvQ2OQyw==
X-Gm-Message-State: AOJu0YymgB24850wQOfyhIAdlh2zm9HOHEhbJ1LctXCdjp3m2lYGUC7h
	r52BwOAmgVtMyTRazEFAq+lwfV269lFcobFByiLjY42qZioPv+J5RKgPUGzaiNFXqgBzzmClJzU
	=
X-Google-Smtp-Source: AGHT+IEm7s0Eb11AVwtLOR+i9Tj3k2oWi3P53WEptV9ONO81YZqDyothyklpzAJfLs606Ez/6JeDhw==
X-Received: by 2002:a05:6214:cca:b0:6a0:cbab:771 with SMTP id 10-20020a0562140cca00b006a0cbab0771mr11609393qvx.35.1715002374757;
        Mon, 06 May 2024 06:32:54 -0700 (PDT)
Received: from ?IPV6:2601:145:c200:2c70:1d3e:7cfe:cfb0:535e? ([2601:145:c200:2c70:1d3e:7cfe:cfb0:535e])
        by smtp.gmail.com with ESMTPSA id y5-20020a056214016500b006a0cb461f89sm3725398qvs.6.2024.05.06.06.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 06:32:54 -0700 (PDT)
Message-ID: <485379b5-93c2-4f24-86b8-e101ed7bc3c6@ieee.org>
Date: Mon, 6 May 2024 09:32:52 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup2 labeling status
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 SElinux mailing list <selinux@vger.kernel.org>
References: <d3c9593d-fc73-4016-b057-57706e94d170@ieee.org>
 <CAEjxPJ6uFiUjb0siO4+D8a7Z9ZB=WWNdO=54m1RsCO8HT9n5Yw@mail.gmail.com>
 <2f3f2911-bed9-499a-a117-56a404ddbe33@ieee.org>
 <CAEjxPJ66_2jic8erKo6RBE4psXxF3AK=1jvS7ERpB7Hmot0PCw@mail.gmail.com>
Content-Language: en-US
From: Chris PeBenito <pebenito@ieee.org>
In-Reply-To: <CAEjxPJ66_2jic8erKo6RBE4psXxF3AK=1jvS7ERpB7Hmot0PCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/3/2024 8:00 AM, Stephen Smalley wrote:
> On Thu, May 2, 2024 at 3:16 PM Chris PeBenito <pebenito@ieee.org> wrote:
>>
>> On 5/2/2024 2:53 PM, Stephen Smalley wrote:
>>> On Thu, May 2, 2024 at 2:37 PM Chris PeBenito <pebenito@ieee.org> wrote:
>>>>
>>>> The state of cgroup2 labeling and memory.pressure came up for me again.
>>>> This was discussed March last year[1]. To summarize, refpolicy has a
>>>> type_transition for the memory.pressure file in cgroup2 to a default of
>>>> memory_pressure_t. For example this file:
>>>>
>>>> /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure
>>>>
>>>> with the idea that we allow daemons to write to this without allowing
>>>> writes to all cgroup_t.  Unfortunately, the thread ended and I haven't
>>>> seen any improvement.
>>>>
>>>> The conclusion was[3]:
>>>>
>>>>> Ah, now I remembered that we made it such that the transitions would
>>>>> only apply if the parent directory has a label explicitly set by
>>>>> userspace (via setxattr). Not sure if we can improve it easily, since
>>>>> we can't use the normal inode-based logic for cgroupfs (the xattrs are
>>>>> stored in kernfs nodes, each of which can be exposed via multiple
>>>>> inodes if there is more than one cgroupfs mount).
>>>>
>>>> Testing on a 6.6 kernel and systemd 255, I still see the same issues,
>>>> where most are stuck at cgroup_t, with user.slice entries get
>>>> memory_pressure_t[2].  Based on my investigations, the user.slice works
>>>> because systemd sets the user.invocation_id xattr on these dirs.
>>>>
>>>> Next, I tried modifying systemd to use it's version of
>>>> setfscreatecon()+mkdir() when it creates the cgroup directories.  This
>>>> did not change the labeling behavior.  Next I changed the code to a
>>>> post-mkdir setfilecon() and then all the memory.pressures finally had
>>>> expected labeling.
>>>>
>>>> This setxattr() requirement is unfortunate, and the fact the
>>>> setfscreatecon() doesn't work makes it more unfortunate.  Is there any
>>>> improvement being worked?
>>>
>>> Possibly I misunderstand, but selinux_kernfs_init_security() appears
>>> to honor the create_sid (setfscreatecon) if set, so I would have
>>> expected that to work.
>>
>> Does there need to be an xattr on the cgroup2 fs root directory for this
>> to work?  Based on the tracing I did on the systemd code, the post-mkdir
>> setfilecon() would have happened on the root dir, but the
>> setfscreatcon() version of the code change obviously wouldn't have
>> changed anything when it ran on the cgroup2 root dir.
> 
> That could be the case, based on Ondrej's statement on the earlier
> thread. So it isn't a limitation of the SELinux code per se but rather
> the cgroup2/kernfs code.

I think I've reached the end of what I can debug from userspace.  I 
changed the genfscon to no_access_t so it would be obvious where the 
genfs label was still in use on a file.  It indicated a relabel is 
needed due to entries being created during initramfs, despite systemd 
supposedly relabeling /sys/fs/cgroup (still looking into this) just 
after loading the policy.  I added a tmpfiles.d entry to get the fs 
relabeled and retried the setfscreatecon() version and the results were 
quite weird:

root [ /home/pebenito ]# ls -lZ /sys/fs/cgroup/*/*/memory.pressure
-rw-r--r--. 1 root            root 
system_u:object_r:cgroup_t:s0          0 May  6 12:21 
/sys/fs/cgroup/system.slice/auditd.service/memory.pressure
-rw-r--r--. 1 root            root 
system_u:object_r:memory_pressure_t:s0 0 May  6 12:19 
/sys/fs/cgroup/system.slice/boot-efi.mount/memory.pressure
-rw-r--r--. 1 root            root 
system_u:object_r:cgroup_t:s0          0 May  6 12:19 
/sys/fs/cgroup/system.slice/chronyd.service/memory.pressure
-rw-r--r--. 1 root            root 
system_u:object_r:cgroup_t:s0          0 May  6 12:19 
/sys/fs/cgroup/system.slice/crond.service/memory.pressure
-rw-r--r--. 1 messagebus      messagebus 
system_u:object_r:cgroup_t:s0          0 May  6 12:19 
/sys/fs/cgroup/system.slice/dbus.service/memory.pressure
-rw-r--r--. 1 root            root 
system_u:object_r:cgroup_t:s0          0 May  6 12:19 
/sys/fs/cgroup/system.slice/hypervkvpd.service/memory.pressure
-rw-r--r--. 1 root            root 
system_u:object_r:cgroup_t:s0          0 May  6 12:19 
/sys/fs/cgroup/system.slice/hypervvssd.service/memory.pressure
-rw-r--r--. 1 root            root 
system_u:object_r:cgroup_t:s0          0 May  6 12:19 
/sys/fs/cgroup/system.slice/irqbalance.service/memory.pressure
-rw-r--r--. 1 root            root 
system_u:object_r:cgroup_t:s0          0 May  6 12:19 
/sys/fs/cgroup/system.slice/sshd.service/memory.pressure
-rw-r--r--. 1 root            root 
system_u:object_r:memory_pressure_t:s0 0 May  6 12:19 
/sys/fs/cgroup/system.slice/sysroot.mount/memory.pressure
-rw-r--r--. 1 root            root 
system_u:object_r:memory_pressure_t:s0 0 May  6 12:19 
/sys/fs/cgroup/system.slice/system-getty.slice/memory.pressure
[...]

In case it was due to entries created in the initramfs, I tried 
restarting auditd and still got cgroup_t on the memory.pressure.  I 
added a type_transition for all domains, but still get cgroup_t.  I 
can't explain why some memory.pressures would get the expected label, 
but others not.

-- 
Chris PeBenito

