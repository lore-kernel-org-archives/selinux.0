Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8833745C6
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197803; cv=none; b=c0r9Amb6gIGG3fjhiGsoYbFuDybRnFIT9oVrpSrbR6XbPmbT2t24iBryrXMJkl2ds6nvBKdEkheZSh0jNsotLbYvF6/JerHA3taATNRMHweqWIiO/HeLolZCLIG0pk9rwmb0zLeMVDFMNr/cSqfF0/NxxulFHcHz6lGrCUIE0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197803; c=relaxed/simple;
	bh=ognnrHnvT6yn4GqQ2NAzqG35lyfuelgaA7Ov1iIFOHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGviUibm8aHcEB76Trixl2bVhYkplIm/Mldo5VyFhb3iaQvHvehKIP8ZtEtkQQjm6b6Uq9+pqyUwNY8mbNOHc/YIok5chujB56zBTzEYc1QZaCEidg65S0/uX7yYJ8LEFJDhGmSMUVL+NbnVtAqsm9TJZsSEoUeVu1mUChBcQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZfOBomK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZfOBomK"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6daa89a6452so5006472b3a.2
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706197801; x=1706802601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ognnrHnvT6yn4GqQ2NAzqG35lyfuelgaA7Ov1iIFOHE=;
        b=YZfOBomKyuBcoEuG9WsRP4cEfT8mY+B+y6LTE0Tdw6NlTOoJQ3YuvUShgVWmE8K09z
         F5Pd7s8i6w9iMCnKXrOLR8OEeIBmIf0Irv2pO3q70pcNPCwsiwMXKdZRblch2ew++uYE
         B1tynN1o+zA7IoAG+8Nj0v9DULhzck3YmlvQGwIsegYA6S9TSw8bWBKGbAW0g9jjqQZm
         Ukr5+sta5/9U2a5WaDxdbtVDXyM7Y6WWUVYOFebk30B4Xuf+9cFX7SZq6IwspebgVCEb
         LmTgXe4YWTZqP6EJnEGOs0r5iE16yfj7ouyoBFsaLijzIZL5V6eX9i3hyAzIjVTM2niu
         e5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706197801; x=1706802601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ognnrHnvT6yn4GqQ2NAzqG35lyfuelgaA7Ov1iIFOHE=;
        b=DIosHYhNf/AsZZbNBP9fW2fTJMIvtpzBXa2HKzIl00/QEoZCRrdUuqFxZnQj6rfgrp
         8T2W9osQmvZxMSqD05emtj2q/sK+46tlwQMGzwyoOFT1dW1vpGrnnLUgRKW6oYuccDJp
         wU0GE8h5DddIBYuJnFlT4mUuVLnjSZ32cHMoSxQWLaR+xbHnQ/XWGkhoy+VwaELVKYMb
         Rb8mX2e01asrRsFP5EhoQprwyL2t6wvK+6/dZ/5V/1r/RqHlnotCmnIZWHiHZ2tcSNtl
         RmBsf9x12/LlbD551wuCiVPcJBmbQtgUAXmSih4RSa8Ttlwzwx1FGw1Kq81rqvOEK/iR
         L/FA==
X-Gm-Message-State: AOJu0Yw4B1CrxNwockG5bQmV6LS74VZ2e4+ZeW4vT/uIbA6G8618a/o9
	WAB9Psnj3fSBBYVuwql6GLRFs2L5MBx66JVoydd/I7LTzrxz/QMq+me4+FCT69G0BSNI6fBNwaA
	Y+IWudjXFkzRq7UWusDCqs4juIveU0qg5
X-Google-Smtp-Source: AGHT+IF9Rsqe9ViryFbBsYV+u95L3OEss1cyWci//rnZPk8eA7VJcn/HAB9QiWorwbe1zIImwF11mX48UIcA9I85XFg=
X-Received: by 2002:aa7:9e0d:0:b0:6dd:9f9b:1594 with SMTP id
 y13-20020aa79e0d000000b006dd9f9b1594mr872397pfq.38.1706197800835; Thu, 25 Jan
 2024 07:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
 <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
 <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com>
 <CAEjxPJ5_SQDmR9b-+0woBLg25omtERSLBKawTV9AqLpZAHFvcg@mail.gmail.com>
 <CAHC9VhT_zOjJpg-JOaJQ4s9ybArfq2Ez_OiFAk0siPiqEC0KiQ@mail.gmail.com>
 <CAFqZXNvSn-Ct04ghSxiceKkRBgfyUeWJc3J0tjnU-Mm8mfPtAg@mail.gmail.com> <CAHC9VhQ4hopKwh6y=M2kZfgM=cdcWvqAbGAD9HMRhDDj88R_xw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ4hopKwh6y=M2kZfgM=cdcWvqAbGAD9HMRhDDj88R_xw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 25 Jan 2024 10:49:49 -0500
Message-ID: <CAEjxPJ4LvVr8w3bPLXrB7Aw=RS=CVnVwH0q7egQTP+F1Qzq1jw@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:16=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Jan 25, 2024 at 10:15=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
> > On Thu, Jan 25, 2024 at 3:52=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > Ondrej, are you able to post a fix for this?
> >
> > Yes, I'm on it. I already have a candidate fix, but my kernel building
> > infra is currently acting up, so it might take a while before I'm able
> > to test & post it.
>
> Great, no worries if it takes a little longer, I just wanted to see if
> you were able to put together a fix or if I needed to do it.

FYSA, reverting that change does restore basic labeling of NFS files
but ./tools/nfs.sh is still failing later, or rather hanging during
the Unix socket tests on a NFS mount. Not sure why yet.
