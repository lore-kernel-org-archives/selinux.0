Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9B31ED96
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561345; cv=none; b=jjLJFe83++Z9gLP9MWzICmeT4BDma0eW6OGtANz2Vwds5m9vhZFiOsnC9dtbg8uQ+Fs+u/IVX3JZJG8j50G408wKdw0ELq+vWJbWjUWLnUTC2APQWhwzXrXGHgRqCf4mYq9xZppy2MIkvRUOofD+PK4bvhKqEBc10Bx2WxA6G74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561345; c=relaxed/simple;
	bh=NkmEpXSuwuLhgk3lS0PQKXSpIu4CRN0uCwVXZNwYT+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXM/rPdDdMXYx9y4p4EhWhj06BAnxCcABdeukkNojQwke+J57NO3noScL2tKaltQKEa3RToMexR9AgiPjZ4N00uSnAV6GxbfeqPZpjFnW5InwQ6MQcSBJSN/keBxSGVkrBd2ZEcqQ+qn5edpfiVaFfumuwr0qMhMPplDdh5pGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpzmJTBt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtqQg3rg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpzmJTBt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtqQg3rg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763561342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sRv4gN6lbv1SmMMciAbtKT3jfXKjBM1qenldjai+GsI=;
	b=SpzmJTBtmNdfu7vSC05IFr4dg7ehox7d29a0lOQ3dxv9L/UtGLzPVwSp7wlmgHceMyrQnx
	eabs0v1xonnjvQtculHns2uNyvFlWJ10HaPFt85+2TyNKD9AGJ6Fh6gvODhunEBUsD0DeG
	HpDhhJDC0iufHRTRxsHG0TBM1i+6v1o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-1QtULk_oOTWuQRihvS5HLQ-1; Wed, 19 Nov 2025 09:09:00 -0500
X-MC-Unique: 1QtULk_oOTWuQRihvS5HLQ-1
X-Mimecast-MFC-AGG-ID: 1QtULk_oOTWuQRihvS5HLQ_1763561339
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340d3b1baafso12773425a91.3
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763561339; x=1764166139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRv4gN6lbv1SmMMciAbtKT3jfXKjBM1qenldjai+GsI=;
        b=gtqQg3rgFxMRvEkC6UTmEB63pajC6ammzUYSCCIeKpGiBwhtMDGP91V3KYzvhLaRQ9
         5/EXzzdxURF5kfyOhYlqEpYpVDbGI2nWgFQ/Ebc0KAzK7aHoiWOKH1lTNOHcZm0IqgRA
         BcDgHss+BRtoCDdDSLtHBT37+GkbljqBwg982ylwUWXnj60Us52KiMhY3sZBb91oeD6A
         81QNU+cyVig01Nqkkki50GtfUrcVglNQ/xsHPWR8Tr0wWbHD7VVQTTiCe6XnbZbk9z6v
         5ReVj/UTfm+vHFeyoNrZinwkfr0NC+OSN+8dLb0+mn/5ImpXPMmxXz5FTrQGEPGtl+TX
         pJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561339; x=1764166139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRv4gN6lbv1SmMMciAbtKT3jfXKjBM1qenldjai+GsI=;
        b=NlwQ+OLI+Mj/i6tvHTKq3VkFP2gBoMlw7bkOnpQ49A9P4H8mSguP5Rd/ylRgHXGHjI
         EG5ammW3LieN/gUJ1N2itDmZECB+tU87zedpgCf/y+nGAMs2uFWMSeruIbky65KJT/2d
         I31EN3xogAlbJTUFj86p/VsmsLOzqLDv8t+UvkHrDukbBmWX4z+Vf4cGyhMAVhBUFiqs
         zv8ZcNoXjV5Bk6UT54ubVWgET7jCK9I8Rado8NUQYBE2HXNHHIeQzTgEsBFCubUsdlIi
         HzG7q8IBZ52CVnz4MvIOGMAXCuLvhWJmzI/0of52k6DUL8CnUJDWga3pamkZUT+rMzgH
         hveQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLI/CH+fB/f1d5mwJNxJMmmX2Y0pNXmf7YivYc6lfpULZ5qZITkgQT+qaUv0OTmnvLbNuYf1ET@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxfRIE0hlDSM3/ACN+u4gXCq2hsycNwq9T0pwTe4YMq/3bcxD
	fTh8ChREhK1tZmvN6Qp0fxKNWVIbUYW9KMm1mZ2O9zjMSTFzBfV7/UcWaIkgnXjR0m/n1rloVGt
	Cp02/HjsZ+v/ebPdzmIbZC3AhkyUTuDRx8V1lPJLJlnt7m4Cz/owSIrk/NkA=
X-Gm-Gg: ASbGncsiz1UeMSaOFKEHKKFTG8yJ+MuqLKjEgVUu9Quscpfc+VMdLa7WLtb1Av65aAq
	yIiyWuqsfrH3Uxw8A+M3CwL7+ggky7rE0M1g8vlPthcCIYQEuDBlqzPIODLUPlokXr0s6Qc7rvX
	6CeayUlQ/WcZIysLRdwidpmHMjopakNrpNrc/dfMl7ab2EO19SbSWqN6Y4TtDfcXEWt1azpGNtS
	DYxvgoYv+UqiShP4+PmhR8YMRGI2xzs4Vi6Op3Of7Vp233Ka2HuSnYr0wFyNlRBoaR+UnY+RiXf
	/uQMwxiBEI0FJWD7U5wjS8AwCUbeajgbtc+g7quETI8nnuLgdBHY5ZxLeGcDvwp8MfUJAaZGfAK
	/
X-Received: by 2002:a17:902:dac5:b0:295:39d9:8971 with SMTP id d9443c01a7336-2986a6b8d39mr259786905ad.1.1763561339364;
        Wed, 19 Nov 2025 06:08:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoYZmE59xp6Ipi5eyc2g8cV1kiLGsM5qO/CIP4bd1FKcfYa3EkB3JPo0oIjCnqmz99Neumpg==
X-Received: by 2002:a17:902:dac5:b0:295:39d9:8971 with SMTP id d9443c01a7336-2986a6b8d39mr259786235ad.1.1763561338591;
        Wed, 19 Nov 2025 06:08:58 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c23487esm206193675ad.20.2025.11.19.06.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:08:58 -0800 (PST)
Date: Wed, 19 Nov 2025 22:05:50 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Karel Srot <ksrot@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>
Subject: Re: [PATCH v3] ima: Access decompressed kernel module to verify
 appended signature
Message-ID: <yiwtnidayji53irhrowznu75ajedrsu6pwh7xzjplcyzmifz6u@7epealeg3ssa>
References: <20251031074016.1975356-1-coxu@redhat.com>
 <20251119034718.618008-1-coxu@redhat.com>
 <fc1d67e411ef53460517db4c03bdcf1b9d9f8a8f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fc1d67e411ef53460517db4c03bdcf1b9d9f8a8f.camel@linux.ibm.com>

On Wed, Nov 19, 2025 at 08:29:22AM -0500, Mimi Zohar wrote:
>Hi Coiby,

Hi Mimi,

>
>On Wed, 2025-11-19 at 11:47 +0800, Coiby Xu wrote:
>> Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
>> is enabled, IMA has no way to verify the appended module signature as it
>> can't decompress the module.
>>
>> Define a new kernel_read_file_id enumerate READING_MODULE_COMPRESSED so
>> IMA can know only to collect original module data hash on
>> READING_MODULE_COMPRESSED and defer appraising/measuring it until on
>> READING_MODULE when the module has been decompressed.
>
>This paragraph is a bit awkward.  Perhaps something like:
>
>-> so IMA can calculate the compressed kernel module data hash and defer
>measuring/appraising ...
>
>>
>> Before enabling in-kernel module decompression, a kernel module in
>> initramfs can still be loaded with ima_policy=secure_boot. So adjust the
>> kernel module rule in secure_boot policy to allow either an IMA
>> signature OR an appended signature i.e. to use
>> "appraise func=MODULE_CHECK appraise_type=imasig|modsig".
>>
>> Reported-by: Karel Srot <ksrot@redhat.com>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Suggested-by: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Thanks, Coiby!
>
>The patch applies cleanly to linus' tree, but needs to be applied to next-
>integrity.  Please re-base.

I've sent v4 which has been rebased onto next tree with improved
wording as suggested.

>
>-- 
>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby

