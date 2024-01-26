Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A032833CC5
	for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307543; cv=none; b=WyWqm6fS97hRpxdWwDNc337EbjefMEfJBTQqxnYL8YU3ubdMloeMozPOTK+evPDJ7F7E3BcpjDGyx0gbNKNjIGLIvgSlWBgI/PdqRlilvDBy6WZoa0FP3/rRMxJ96VNFiU09WT+o9UwK1uf+dyyN1MKGiHDDrqtirloxfxzeEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307543; c=relaxed/simple;
	bh=qpzQw5s6Dqxh+Qc3y41Tq123yZfxoXEp3OvaOWhv/ek=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=VaRPDAdcAjvDq05uduElT1c74ztZDOAK+tc7gyaRubw/dgRJfDI4XGBhKSLvLvGoypLbuLFJWdUgxuSv8b6x1inZkmdpfdRxP5Pk2tdbAt2SXR1I7arw9tCSurvxkRNH+4DCmn/KgG6VIv5LzgP08We97b2xa7lO21R18HG851k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WgzItryM; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WgzItryM"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-781753f52afso61964585a.2
        for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706307540; x=1706912340; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bp1h2UkOsHruZ6BwuUmNXr6zMZJ5tkOoiZnpdhJ7b4I=;
        b=WgzItryMpIwDRwVR/AioiJ+wyB812W6Ts9lA3VMu/+IGmFuJWP4jylc2OcIyZ580dv
         8kaiHGyYZSgKLbn04NUX2VIGmEJjfjJhgLNXfW+3leHezMH7c0XvmO50uscd1rdiXkxW
         sjjtHpp0HdVuqQCKBbJC348cFTc0hq09pbcU7MyrH4WPZ319wDn4pSFwyLHhtLOmG9A0
         PzFDvjknZG0Ifv6ZfX1AFsMkqH8DJiudvwwmjm5z4VVTFKdo9+whR/+CU8EnLirJX0Az
         nwAVsL2C0PME88RelFM6c4JeGjhXsdANG84m4uNzvXWIleQvZ2XS2cx5NFNXlxcdEe/M
         FzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307540; x=1706912340;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bp1h2UkOsHruZ6BwuUmNXr6zMZJ5tkOoiZnpdhJ7b4I=;
        b=ATcNigIunroJERf4fhf7Gkwrqsry3qTWZ+cS6nOxK84SlTXISowxLtBHcC9EvxA7nj
         AzJ9O7DcepIezW9/17iIAguQfJ3ux+f/W0MPS8QbPUtSs4XXDr4KdVROniaX0YekdDmC
         ogYRwDPGiW4ZxS5OSkc2eeu1QSyHgqaV24rC2YdnvziWAAst8CMVgYb5YaNgJ2eL1HZ1
         jpL2ZzapQfBP7XCyGQ0PSaIbVAXqJxJ0QHXs+SY8x5LlAiB2rseGH3DkvDGyPGM6hcvV
         1RC758ygaJ5PjbYkZcaUnQcMM0/5VlA/1pAZt9f8Drsn2Fqhr5duAiCUgqfsIf587RY0
         IdsA==
X-Gm-Message-State: AOJu0YwJ7SfEMA8oTnaI5gFEPDOlMiueK3hGRVxN99cpBK0kGUTEF61Y
	zOWA1kK3fGOqa/C4RPZBK4xRKRceCtktnRnUD89TMHoElh8vnbR7ieTXbojh6Q==
X-Google-Smtp-Source: AGHT+IFgBnXc0hgyvmYRe2ni5uzRKRcYJb9teEW+YwzPApVx696blu9ZWpPZsfHPxIfO9nBt6nBsWQ==
X-Received: by 2002:ae9:e513:0:b0:783:25ef:818e with SMTP id w19-20020ae9e513000000b0078325ef818emr460280qkf.116.1706307540461;
        Fri, 26 Jan 2024 14:19:00 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id f15-20020a05620a20cf00b007832b17f3eesm929603qka.41.2024.01.26.14.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:19:00 -0800 (PST)
Date: Fri, 26 Jan 2024 17:18:59 -0500
Message-ID: <b3e1fdd22be4d2abbaccba73f6dc3e38@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
References: <20240126104403.1040692-1-omosnace@redhat.com>
In-Reply-To: <20240126104403.1040692-1-omosnace@redhat.com>

On Jan 26, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> The inode_getsecctx LSM hook has previously been corrected to have
> -EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
> behavior. However, the call_int_hook()-generated loop in
> security_inode_getsecctx() was left treating 0 as the neutral value, so
> after an LSM returns 0, the loop continues to try other LSMs, and if one
> of them returns a non-zero value, the function immediately returns with
> said value. So in a situation where SELinux and the BPF LSMs registered
> this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
> returned 0.
> 
> Fix this by open-coding the call_int_hook() loop and making it use the
> correct LSM_RET_DEFAULT() value as the neutral one, similar to what
> other hooks do.
> 
> Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com/
> Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecctx")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2257983
> ---
> 
> I ran 'tools/nfs.sh' on the patch and even though it fixes the most
> serious issue that Stephen reported, some of the tests are still
> failing under NFS (but I will presume that these are pre-existing issues
> not caused by the patch).
> 
> I can also see an opportunity to clean up the hook implementations in
> security/security.c - I plan to have a go at it and send it as a
> separate patch later.
> 
>  security/security.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Merged, with the RHBZ link tag, into lsm/stable-6.8.  I've also added a
stable tag/Cc should this should get picked up by the stable folks to
fix the breakage in the recent stable kernel releases.

Assuming no problems are uncovered over the weekend and early next week,
I'll send this to Linus next week.

Thanks everyone!

--
paul-moore.com
