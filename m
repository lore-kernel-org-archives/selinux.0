Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63655E6F
	for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686074; cv=none; b=Gg6EGC5Z88wY/mDqxj3vXdMuVW6CyauYuFUv7iA+e/BgP1RGi811x0g5hLmO0vKOWejLwZhi2d+Gu2xe55oUl7u2XS+30Y10fUdEli3KRaG/EOm4x3h5JD+26HOC5x1HB6ljlYfDOnW9iVhWmvNOZ0RbvAQXxi+P/BSOm9FYpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686074; c=relaxed/simple;
	bh=TSiAoITa+M2mAlzOu+O+IwZ101ZG+8Ntl6vKvS5LQPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/+PWeF/0zBBpSa5s0KPVo3ITnGIgGZNtgBQ56t7Edr4bOjocf3ZcT5MGuduH7CXWTudoiIcl1aZzS56CY0QYalgwDDgrT2xoCT4UL72/rShvrKn97eOa4UYNskECn4Y2SI0XZkWpav0iDoUrdqih1oAUQkvEF35SuSl44lF0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OBpVHnTF; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OBpVHnTF"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so14968339f.0
        for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 09:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705686070; x=1706290870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/le8kuI8ZSrDfjIjX1HxI1ueVfhTAOLfRLakiPaaFrs=;
        b=OBpVHnTFnjxQig5rSi+DH0VnpmLJ4ZuPfxN8GRknu24bNTEiL583RmgWU6e78oDxEZ
         SHqFVQvRxuNq/EaoWdBuDL0SFxOkV+jr3FxBzNKUsS4CXZEbBUhlrpo7eBnrFyU7OUJF
         ie1qJws3phRYcr6UbtunbntpHx9y/8m0ZI3piQV+c9zTVmC87XFl32a38zp2Z6vHBwq+
         bB4tc/3RCJBWSzjhsDcPugN0K5cVhhGto3rFHjT8IbtSi5e/3YHKQtoC855uM21ApmW9
         xmax1xjYC+Y7hP1XBINuE9vEQRUzVWertM66EkSHRA6tMT7TUJkuO+dffjRmhSx2nn1x
         VP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705686070; x=1706290870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/le8kuI8ZSrDfjIjX1HxI1ueVfhTAOLfRLakiPaaFrs=;
        b=MAGL7EFXN7W7+RXfIiDvl8aSNa8h3F19B9djQlNHjOHYc5jw7YOOAJJe9mikQdrsMl
         9pOyPV8pnAbKku4uGRykqKR/0D23StWax3Wxd4lWVym+iK5W+04riTU4MWiWdKtIadD4
         TlfK00Rf9QWRGi8aR8DVCPe2CkvZMNPhagUF6y0FyxwLWGvoyO2G2juFhZyR734k4l6T
         GCr+/sDpZcV7QqcjtdshWz2yyw05Hesp/4VUyEfd3NwDhI9vxNky2XFtmpDGMCo48Zk4
         KbbPTrdTVGWt2s3TfSOsJm0Cwt2s2LPJnYTKm1kSBt+la45PeQwImxHSW1Ciu76MFsMh
         HFTg==
X-Gm-Message-State: AOJu0YzftL+qRAoAkgdEqN2obw+W1fvU3LWipubz8V5Cdm0RItszmCo1
	oSeUtgxWlm8Xx45+xP8ot+tzVdlrl3s+XWZu0sPu+zYOCPijlvKMW7/VBhcOfqE=
X-Google-Smtp-Source: AGHT+IHmQ4RjGwRzYrYp5AA9gZKB0mysqf90X2GLnAyMw7GmqWhEvBlrizk4F8G1GkLHrhI58VIqLw==
X-Received: by 2002:a5d:8942:0:b0:7bf:3651:4c6d with SMTP id b2-20020a5d8942000000b007bf36514c6dmr66915iot.2.1705686070615;
        Fri, 19 Jan 2024 09:41:10 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g1-20020a05663811c100b0046b451e7b57sm1646469jas.45.2024.01.19.09.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 09:41:10 -0800 (PST)
Message-ID: <610f91a7-9b5a-4a07-9912-e336896fff0c@kernel.dk>
Date: Fri, 19 Jan 2024 10:41:09 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IORING_OP_FIXED_FD_INSTALL and audit/LSM interactions
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, io-uring@vger.kernel.org,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org,
 selinux@vger.kernel.org
References: <CAHC9VhRBkW4bH0K_-PeQ5HA=5yMHSimFboiQgG9iDcwYVZcSFQ@mail.gmail.com>
 <80b76dac-6406-48c5-aa31-87a2595a023f@kernel.dk>
 <CAHC9VhQuM1+oYm-Y9ehfb6d7Yz2++pughEkUFNfFpsvinTGTpg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHC9VhQuM1+oYm-Y9ehfb6d7Yz2++pughEkUFNfFpsvinTGTpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 10:20 AM, Paul Moore wrote:
> On Fri, Jan 19, 2024 at 12:02?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/19/24 9:33 AM, Paul Moore wrote:
>>> Hello all,
>>>
>>> I just noticed the recent addition of IORING_OP_FIXED_FD_INSTALL and I
>>> see that it is currently written to skip the io_uring auditing.
>>> Assuming I'm understanding the patch correctly, and I'll admit that
>>> I've only looked at it for a short time today, my gut feeling is that
>>> we want to audit the FIXED_FD_INSTALL opcode as it could make a
>>> previously io_uring-only fd generally accessible to userspace.
>>
>> We can certainly remove the audit skip, it was mostly done as we're
>> calling into the security parts anyway later on. But it's not like doing
>> the extra audit here would cause any concerns on the io_uring front.
> 
> Great.  Do you want to put a patch together for that, or should I?

Either way - I'd say if you have time to do it, please do! Probably just
include the REQ_F_CREDS change too. FWIW, I'd add that in
io_uring/openclose.c:io_install_fixed_fd_prep() - just check for
REQ_F_CREDS in there and return -EPERM (I think that would be
appropriate?) and that should disallow any IORING_OP_FIXED_FD_INSTALL if
creds have been reassigned.

>>> I'm also trying to determine how worried we should be about
>>> io_install_fixed_fd() potentially happening with the current task's
>>> credentials overridden by the io_uring's personality.  Given that this
>>> io_uring operation inserts a fd into the current process, I believe
>>> that we should be checking to see if the current task's credentials,
>>> and not the io_uring's credentials/personality, are allowed to receive
>>> the fd in receive_fd()/security_file_receive().  I don't see an
>>> obvious way to filter/block credential overrides on a per-opcode
>>> basis, but if we don't want to add a mask for io_kiocb::flags in
>>> io_issue_defs (or something similar), perhaps we can forcibly mask out
>>> REQ_F_CREDS in io_install_fixed_fd_prep()?  I'm very interested to
>>> hear what others think about this.
>>>
>>> Of course if I'm reading the commit or misunderstanding the
>>> IORING_OP_FIXED_FD_INSTALL operation, corrections are welcome :)
>>
>> I think if there are concerns for that, the easiest solution would be to
>> just fail IORING_OP_FIXED_INSTALL if REQ_F_CREDS is set. I don't really
>> see a good way to have the security side know about the old creds, as
>> the task itself is running with the assigned creds.
> 
> The more I've been thinking about it, yes, I believe there are
> concerns around FIXED_FD_INSTALL and io_uring personalities for LSMs.
> Assuming an io_uring with stored credentials for task A, yet
> accessible via task B, task B could submit an IORING_OP_OPENAT command
> to open a file using task A's creds and then FIXED_FD_INSTALL that fd
> into its own (task B's) file descriptor table without a problem as the
> installer's creds (the io_uring creds, or task A) match the file's
> creds (also task A since the io_uring opened the file).  Following
> code paths in task B that end up going through
> security_file_permission() and similar hooks may very well end up
> catching the mismatch between the file's creds and task B (depending
> on the LSM), but arguably it is something that should have been caught
> at receive_fd() time.

If there are any concerns, then I say let's just explicitly disable it
rather than rely on maybe something in the security checking catching
it. Especially because I don't think there's a valid use case for doing
this, other than perhaps trying to bypass checks you'd normally hit.
Better to err on the side of caution then.

See above for a HOWTO, if in doubt.

Thanks for looking into this!

-- 
Jens Axboe

