Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAC3101B7
	for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628866; cv=none; b=PTBIRREgOpfgAF5emRQBKFEI6uxvxSXAQW+bMdPRkVFticlInTrbqgnA3JwZBUWhKgr4EgHRf+AzbBaZHi6V3RcU3XzMP9kp7VAH0xzJSjfpq//+PWiTtZaxTnumqeVeApzf1KJbaOG6kIuUxfCTfTt6rCBr8pSCjxoDIucpKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628866; c=relaxed/simple;
	bh=W7sVkeb5pWE1Au3Nc9LfMt6/vUKKnkVU2aVsvV7RFLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8vsn+ddYM9C1QaR2BzH5XYUUCAqAMF2SmRPPPpIyd/XhUoC4mt1w8ht09oIfwSJGTVEMfXzIalcyqlpg3ULS71/RmZaen54EcDIBqxceObo/wpC5vVspbAxQMAqlkdSJmER8b0NAerg8m0ksZ5OyhQab0VlJ5Er++qYgNXtWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f7LG8uy+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f7LG8uy+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so3682510b3a.3
        for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755628864; x=1756233664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxA8r6gICCYCTtmqt0g1TsD+OxRWGjOL0XWuu12ws+0=;
        b=f7LG8uy+jW859njIbV0NYezcZeWb9Gv4XkrtAPhhzvEClcQBeLiiq3gUecKUY29vP7
         oqRfkF4dwx+Vfh/VgTtXOsUSGZuHb3VrlYlAubHLvXunlFpsBTfnR8zUmauXx7ooHntu
         gVRATnyuLC3KkiWw9rIwps/ql20s/xn0Vwy3J8pxeu9N9+j5wl8uzuhemkcFrDJl0kOj
         Gcq5XbXvy+jztRfhxQJroVUwDb5H+mvwBYgcvrQu+zPcdFOI2npFSJC7V1h++b8T1OXa
         7PPUcgwXDqqMFrF2naCpHR0uHO7amdk+yNDTjDLHTu6S5lsDwpz5dFxg/ghcVUQ1wAUc
         vlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628864; x=1756233664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxA8r6gICCYCTtmqt0g1TsD+OxRWGjOL0XWuu12ws+0=;
        b=dt3cJZ0KuuTnMZtPjha4zbS06yI9HhQ7si1ktRO9hJUW0tqufsrPDG5cS8tJWsRzdN
         8qumKhdEJkxB9II7Z8kSut8s5poybN5qu/8+etNshHtbSkfK87WQSbPcA9BVHhJhsiCJ
         D8+iL/hpUmgZ3SDIcHhYq9TzwzEV1AxeguZaVFHB/3kMYs/M5/sIUG30Ga32ve6Zrg5M
         Wd3YJSW70OAaoecnFili+XB8oPM8xQ03337eHLU5ybU4b6YZhvcX6NVgDUkVEdA0bVjg
         Kd7MBoqGKucXSNlNkNpwxsBg44mJcJWZcjFlMhirw3Z/t05gN1hxRoM3vBSn7O9twh7u
         Yv7A==
X-Forwarded-Encrypted: i=1; AJvYcCWzblWThosVJC7QfSJKsmMPhDdGeX4awd6+b9fa8+THif930np+twsenBtRAUEDmOSeRro7bDTD@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMDSY8/leXmcNW4EPJn9bQfqjAmxS9wB/fWSy22gbbpxMZwQO
	+59SOE5Ucq0ESwd4D4yhaKiNU/D0lFnfk29Zn241mG7seG6E9/0k5aHjZFjo9UuPs6/4zUuKgpX
	aORBf8KFYGXm8iClsIE8a6FCUTbz8MWs5orXlD85J8HTIlgn8bOI=
X-Gm-Gg: ASbGncv0w8VmVnntn6klWzjWVPHK7ZvYwoZl2nqdafgisYWoBV9Jc/3jBOqBs9hf59m
	4TXLIpLWQxXI1pHXqlZ1Xxf5HLAC4hHmcXEbHch0AiMFUO+8UTu2ORsCQvWaWtNcpp4xfNmfB7V
	LATMxabPMyODjfHIGetvbeWT/k6Z0/dBYhhdRcfoxaUa8YaoP5fvN3z7B620gF2xo1lAPPNAzlR
	o1ZA7vIOfK+rG1WMQ==
X-Google-Smtp-Source: AGHT+IGDF8x8XEUQ3Vh7YwBSb0dBdB7J+oY3SecooHs7eRSM+kdsUUtwvJPYWr15d0XEfLOWM95fsdf/TD2BJtOBss4=
X-Received: by 2002:a05:6a21:328b:b0:240:1a3a:d7bc with SMTP id
 adf61e73a8af0-2431b7e84fdmr475390637.3.1755628863867; Tue, 19 Aug 2025
 11:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
In-Reply-To: <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Aug 2025 14:40:52 -0400
X-Gm-Features: Ac12FXxZgeluVuqZS6ryRgI2NbH5NDlrWjuMdFfxKc0UiPQ_AAWyDeG46s5bB9U
Message-ID: <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 1:11=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> The advantage of a clone flag is that the operation is atomic with
> the other namespace flag based behaviors. Having a two step process
>
>         clone(); lsm_set_self_attr(); - or -
>         lsm_set_self_attr(); clone();
>
> is going to lead to cases where neither order really works correctly.

I was envisioning something that works similarly to LSM_ATTR_EXEC
where the unshare isn't immediate, but rather happens at a future
event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().

--=20
paul-moore.com
