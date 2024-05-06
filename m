Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314215ADBA
	for <selinux@vger.kernel.org>; Mon,  6 May 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028731; cv=none; b=PcyFvWHXynBtkA0rTvfyePQ0rif31YCL1mZygkXDNzz3M/MtASAgCxGn4h/9TkQw7PJrhWkj06usgn8/9DRgnIjU1qq6sF7MH0ak6nGf68PeXlLpH5VTh0HVzCol7LVT8lIdoJD9RvXGOUGZbuyoIDMLx1/WBfC5JQsk1WchU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028731; c=relaxed/simple;
	bh=yCMlnDHuNBx/qGNlq8EvYeBs5TQNlNp2+Evuv2MUEr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBX1gVIgDkKxaf1JOMw9VlX9ABavT87O1RFBaoh6bDw74GJLmXrRsO+nKDmtCG/N2sj46kpBENRFA9J9Vo3II4D/21iAV+o3yTIJds57BSWiUS/ZbkLvp+kF/oJC+VUvrc/rI9HUiH0bd6r0gxl6LWHx/cf/oNaL2NxqPO3m4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gt8MPEO2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gt8MPEO2"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61bed5ce32fso26902517b3.2
        for <selinux@vger.kernel.org>; Mon, 06 May 2024 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715028729; x=1715633529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0aJldxObbqmwqRdokwOXsjkINM3Yq1p+ZO6p6LLpxY=;
        b=Gt8MPEO2qHWJ2stCzOWna5dNZ1O0qOonRuibtrYqYbsgnNpr6Z05meLxSTGs/5FdIi
         I+SA65HrZOv/ZBQYoV8kJsawBf73kqZsVlMGmUAd2g3DokCdr4p+BAAK+f2+2juR1r75
         3LOlc9/LS35Mz1h+vcJdWpxa8J8uxq4jFHA5YIrg+oHW96CUk6Ji14iu3WnD/apHPFDK
         1kq/gibn2HNy3ET38RIBMFfbd5JB+2eyi6Hb+ocztnXapRNcpRNGzRO0uk1T6uNQ4COn
         9enHzHigD3tumB6hmwu3q3d8uyFqisoK7B1ozmutjePwpkdHOenNJWSLAtb6bUBHu+oB
         ZGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028729; x=1715633529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0aJldxObbqmwqRdokwOXsjkINM3Yq1p+ZO6p6LLpxY=;
        b=n2xNwJtWaj+Jb7Fxq7ql8m4xWdnLJIe59gaae4TkBT5hedV++VXNYgi8i7flbZyg9r
         n4rLE0YtVUEdTb741LRxKU2ngIdwq4leCANtsgp7DgX8ZgQIO4cthY84mmc7uL/5Mahr
         aZd8Jvd1X3dOAX6/V7F0WfgqKVs38IiyvaUkhEtvud6Uq1ktlV0/IAvkA+Zygs0zos5A
         PFTDNVX+GBRAOismKYv9mGbabFt8hc5XCQScHwfZm/6K3g2oOZxog0LdLMP6ezrB3K1t
         U8oS/2zOwF5nTLQCGPqsJmbGfCE2kxMkupyRib/u6uCl0dITDTJlyS2Z9ZOWVxRW5aiZ
         ZJVA==
X-Gm-Message-State: AOJu0YwoyXOCHf1fAdTKtEwOA3JDdppW/I/sOu0gzydzTXFZLH2QZth2
	Te0Mw4bmDrFGb9Ndb+RuGA1ZmrZvtrF9W7VSbGYmSsGxJ/Y33XSebEqE1CXmlU97zUX5cEHodr1
	fPntAnSUEu6/9bjj5p9SiVpazhzwgFADDbyr1
X-Google-Smtp-Source: AGHT+IGGFF3TGiRUMqSCC2WlHp4ApQwoT7T5/bWXwE/yklkvddWz3a47WbLGzgAyNG5Ymg5QfgMiGuECEknHhVdfwc0=
X-Received: by 2002:a0d:ccd1:0:b0:61b:33c8:7bcd with SMTP id
 o200-20020a0dccd1000000b0061b33c87bcdmr10805724ywd.21.1715028729248; Mon, 06
 May 2024 13:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005850.466144-2-paul@paul-moore.com> <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
 <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com>
 <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com> <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
In-Reply-To: <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 May 2024 16:51:58 -0400
Message-ID: <CAHC9VhRdwgorXdBt7jUuQ7tLNbtCggGrbrhxw-Um7aCmk0JgmQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 12:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> I also need to track down the appropriate commits for the 'Fixes:'
> tag(s); I'm not entirely convinced that some of the other patches were
> targeting the proper commit ...

Looking at this again, I'm not sure we can easily narrow this down to
one or two commits as the current flawed situation is really the
result of a lot of things.  If I had to pick two may be the addition
of the BPF LSM and the introduction of the LSM hook macros?  I think
this patch may just get a stable tag without an explicit set of
'Fixes', which should be okay.

--=20
paul-moore.com
