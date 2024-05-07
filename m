Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606916D9BC
	for <selinux@vger.kernel.org>; Tue,  7 May 2024 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109483; cv=none; b=ajaJj0PLS5xyZnZra/te35RPhdJt3cg7LMvGPYKbCppfS7iRKQLot5y1W8b+uHdGCj3t9USq8ZLtthTYZ3ZCeSqXydxVgsaCc1D2RK+pBRG4Tk+jKeCyoUDhzEGpq//aV4lKPwZrD6IXWHk7iXG0OPtFRUAO7VdmuqdfbSsruSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109483; c=relaxed/simple;
	bh=gJG2RhP5yjo+VUpaj6pMQlkab5QI2HJRpPvMeNdy28c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVgBKpbzLbEX/qSUpdya39aeBXO+brHLutS02ct0ImWG02+3YLuo3RfZ042B7d2IvRQMhHn74Iba3muvXwMYNdo0ZzYli1AorOn7OxKLXrNd4JbOzercNRRnDJgIf5zMqrAvvYNWABxsZ9L/LyFlxNNOqHsb5gIRKRYsPwIp5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bUCJ2sIU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bUCJ2sIU"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61be4b9869dso37225267b3.1
        for <selinux@vger.kernel.org>; Tue, 07 May 2024 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715109480; x=1715714280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkUnJY0EFDu9PZambZs1IeCNxuSIB/aK1oktUOoldtY=;
        b=bUCJ2sIUiNaWigwdUVTOmpH5p7brYDKQmax8OPLuBgx256LQr9kpl/c+WaND+L+kLC
         GXf7aVlYDkZLXHI4ZWDfIszdBOg3Sc97ng3xKLhRPvPDT+geLQgiI2CrHlYynGRQOUtb
         XBgBB9X+dL5NQE9QS9S2UWdFk96DFoqBGn0J/jLgqJZVhVUVeadPTbHKrgmaL3w2AJKz
         v/kjeLqf3m2bjWmgDJp8xXWQAaY/YRcgyo77MX//OjRH2fAtfYjRTcitt+bmHKBL6d9/
         2awKbvwKksINC4R2c1Nr96ZyE8tLoSkOyn/pUo3ReIXXdCOXXnXNhKl4RUerwzCvnYnQ
         sSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109480; x=1715714280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkUnJY0EFDu9PZambZs1IeCNxuSIB/aK1oktUOoldtY=;
        b=RSiGjAnVh3oU37c9Iq1i/vhY2tq3TzNC6B1tU8Z25AYU561lE66VhgN47jKwP2M4pp
         SX3NV0HIReI3rRI+lpesiAuG+WJhsW9VdmCq8Y22qXZDkBqNi+4jSALcmkDo+TCsR6VB
         CsvwNYwfzhgNuTSBsf2RHufm0SEZspPXCicr+XloGkLGtpsNPKzEvd25K2OiZakxyxPk
         kt9TVGOw4a1I+hySXAYyKDhOAxBEAOwMWP+OSkrjjqKNmgmOA0xXjmzstYHup2EZ5n05
         k0+4vqbyn+bigtQpS8ewrVd0p3/omN8+VcG8Oa5PJG6nGrCiwPDhFsOeQr7fu6LvGoZX
         HO7Q==
X-Gm-Message-State: AOJu0YwOw++Mu6CZDCc9g5+9V3f5J4zbV8NGOzCWpN46FkfrdcgQXqcy
	8+Pq43pXRUEhzEe17JwK4Vh2Nj4ZOJMYIESblxpigkU/DpFivk/xNNPufW1pvchwOoTBvqLvy0J
	8xDDVVJ16XdDUrVYefjWaZ1AbElZlvTVBvnZB
X-Google-Smtp-Source: AGHT+IHFh6fuPBDaALHcRGT86x6XUd5Gly/WjOFrrTl9D0oTiWSCEWhjSAxd+tkJ7qiDY205bvSs1K21OSV+FoXwzUQ=
X-Received: by 2002:a0d:c803:0:b0:610:cd34:439e with SMTP id
 00721157ae682-620862f530dmr6343667b3.49.1715109480658; Tue, 07 May 2024
 12:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005850.466144-2-paul@paul-moore.com> <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
 <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com>
 <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com> <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
 <CAHC9VhRdwgorXdBt7jUuQ7tLNbtCggGrbrhxw-Um7aCmk0JgmQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRdwgorXdBt7jUuQ7tLNbtCggGrbrhxw-Um7aCmk0JgmQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 May 2024 15:17:49 -0400
Message-ID: <CAHC9VhQUi8vo+gZ0OXYXGSbLpuSaCaNx+7CzXw0eAJyQ48X80w@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, May 3, 2024 at 12:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > I also need to track down the appropriate commits for the 'Fixes:'
> > tag(s); I'm not entirely convinced that some of the other patches were
> > targeting the proper commit ...
>
> Looking at this again, I'm not sure we can easily narrow this down to
> one or two commits as the current flawed situation is really the
> result of a lot of things.  If I had to pick two may be the addition
> of the BPF LSM and the introduction of the LSM hook macros?  I think
> this patch may just get a stable tag without an explicit set of
> 'Fixes', which should be okay.

I merged this patch, with Casey's ACK and a stable tag, into
lsm/dev-staging.  Assuming no issues are uncovered during testing, or
mentioned on-list, I'll plan to merge this into lsm/dev after the
upcoming merge window closes; I'll send another note when that
happens.

--=20
paul-moore.com
