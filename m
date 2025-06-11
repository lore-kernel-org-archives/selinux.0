Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C092951B9
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672560; cv=none; b=VZJPvY8hOW9hhuGtl6MGHPaX1Oo3JhEyqtCn1qyzexkdvHAbHpQKUCrF3rgjgtm2B2uV0/K8WGaWLVoHQ6OdmewezpxY5GONreNHrBXgxVmO8lIWU1tA9VZgmeYw7WYzWxp+fRWgoEourJSHtGCV8K+T4XS6Bna4f7DAGc/bI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672560; c=relaxed/simple;
	bh=ko4ZzWeLSpkRKKS4I/5acMnQrGGb5k4EuLn9YB1+rSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaifqMKf8ohR8J0u5YOUW4NPx/x09fge1KAg19vhPV0GO350teEO67Jp8GHw6FxQTqJPxBvzM9X0rlzMgWDw46FyoQD53qjt1Uxa9z6FxVe+wuFYaYNrRsiZebY0C3fOULO08fYs/I/4hZTWcXSCy0oAgspKIPm6O4WYHwokQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NeM11b8M; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NeM11b8M"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e1d8c2dc2so1563517b3.3
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749672557; x=1750277357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXehlz0TcJ2MRYwkUu3vKGZPwVZpInL2Z8eZexHN4Fc=;
        b=NeM11b8MriBTvKbKTWYzcshsyTcOwpztyfZIQAvfsLGp9QHQLUyJG1SDKNriYTtiBD
         BezwHXpwW0Iy3zGIfNAw1BODTXnTcvF6ZXOlBuq4CmDEpVtxBT5DrN+xamM45vf4QDZ+
         smmHJr2GPQYbmBGiAx/uImxTgU9fIRAtD5v0yoF1RFXAfjqHnY2UCFZM+APIAqLRzXiw
         IlBJmD7qGewDM/1aG7IOST12DqfwD4VXK5wge4abO4nne1BDGJ5UhwZhfquM+uuN4ssp
         5sImCcLPcDk78P/BMG/cslOaxy20YbGjr5U8Rf0iNU+u6Kje8LxHw+FJpW2YVJncfp8i
         tmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672557; x=1750277357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXehlz0TcJ2MRYwkUu3vKGZPwVZpInL2Z8eZexHN4Fc=;
        b=om+2J5ksst5Yo7nAZxKoqYjnWc3NaqGm4L3RR2/M7LSH20s3LZRtScXky9ceK1zozn
         Ao736I3QIk3TdJLr36MOOnJou/owXnYmuiJk7Ebyhmk8KvMKFHgjbE6tQcHeZ2rIX/DG
         DnTbuUmEEyQ2YG914qrGp4r/2fVRN9KTtN3FrtXgNLSvlNYPLsqKkg1ROBS/Wy/siLp3
         pjUO8NJ6tFIK0EAUFOyj0PKkTJ3sj+gqZLudYjOBla0snl0luJZw1cZRMwlgbqSshcJK
         U7r5WF2OvwHPbUQE2E+3woWP4DltR2obiWzDTdtGX3jiB/A9B0F4FGqGPBeQlOMz0USZ
         3UOg==
X-Forwarded-Encrypted: i=1; AJvYcCVWZdz1TzycYJJKTBQ61BrdWWHaGojEXP+Vb7atb9kSMIDSfkh5NH+OtYXc1cvYBe6l1ttIfbxh@vger.kernel.org
X-Gm-Message-State: AOJu0YyxS2yhSSCy0c6hlYiEk1WKj4KaAX/S82wJxfb31odM0V1E0UZS
	z4p6xmWKw8B15LOAgJHv+wI05t4dXX/kp/g9MQh1UIUKbgU64KIZm9Br14D5kWbHQjrNagTaOkG
	yr+xmWaSI1EdaDDbKs1nu+mIHueiP1bUrYzCmvlxr
X-Gm-Gg: ASbGncvfKZea6AL3xLREeU4MV51ITCcZidcEMxli4N1OI0w0Y6Wo+iwN7f5SL36vYJb
	T7TT7vlguTIyCK4hC5i1iSzb6SeT7GUZnznKR6vEViq/T5IAK/KeHJGeP/IaRiuJ22QNTYr2OGZ
	iEsjvtUqP4KOtpjmrcxrrcffC8ZpcCSDZoAyGBiJSBSQc=
X-Google-Smtp-Source: AGHT+IFSTlmXkicDh/rc8hIjw4BeQctWC+TZser3y2hLKqOO14q5kDO9NAjyxUEt0yHzdF5W3ZUuUeKf6zr/7iF9vdU=
X-Received: by 2002:a05:690c:b91:b0:709:176d:2b5 with SMTP id
 00721157ae682-71150940190mr8454507b3.2.1749672557683; Wed, 11 Jun 2025
 13:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-56-paul@paul-moore.com>
 <5cfa9bca-27e4-4012-b152-90eb8435f0e9@canonical.com>
In-Reply-To: <5cfa9bca-27e4-4012-b152-90eb8435f0e9@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 16:09:06 -0400
X-Gm-Features: AX0GCFtzUDgvy41at1X_Y7lAWngPflPf-xI1SA28m3Kk1-XzbssmHiHnTK-Hspk
Message-ID: <CAHC9VhQbAzekDmDzWys66NL_bzZFe-PHYMbDs-fsmkRfczxa+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 25/29] ima,evm: move initcalls to the LSM framework
To: John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 9:06=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> On 4/9/25 11:50, Paul Moore wrote:
> > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > mechanism.  There were two challenges to doing this conversion: the
> > first simply being the number of initcalls across IMA and EVM, and the
> > second was the number of resources shared between the two related,
> > yet independent LSMs.
> >
> > The first problem was resolved by the creation of two new functions,
> > integrity_device_init() and integrity_late_init(), with each focused on
> > calling all of the various IMA/EVM initcalls for a single initcall type=
.
> > The second problem was resolved by registering both of these new
> > functions as initcalls for each LSM and including code in each
> > registered initcall to ensure it only executes once.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >   security/integrity/Makefile                   |  2 +-
> >   security/integrity/evm/evm_main.c             |  7 +-
> >   security/integrity/iint.c                     |  4 +-
> >   security/integrity/ima/ima_main.c             |  7 +-
> >   security/integrity/ima/ima_mok.c              |  4 +-
> >   security/integrity/initcalls.c                | 97 ++++++++++++++++++=
+
> >   security/integrity/initcalls.h                | 23 +++++
> >   .../integrity/platform_certs/load_ipl_s390.c  |  4 +-
> >   .../integrity/platform_certs/load_powerpc.c   |  4 +-
> >   security/integrity/platform_certs/load_uefi.c |  4 +-
> >   .../platform_certs/machine_keyring.c          |  4 +-
> >   .../platform_certs/platform_keyring.c         | 14 ++-
> >   12 files changed, 147 insertions(+), 27 deletions(-)
> >   create mode 100644 security/integrity/initcalls.c
> >   create mode 100644 security/integrity/initcalls.h

...

> > diff --git a/security/integrity/initcalls.c b/security/integrity/initca=
lls.c
> > new file mode 100644
> > index 000000000000..de39754a1c2c
> > --- /dev/null
> > +++ b/security/integrity/initcalls.c
> > @@ -0,0 +1,97 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Platform certificate / keyring initcalls
> > + *
> > + */
> > +
> > +#include <linux/init.h>
> > +
> > +#include "initcalls.h"
> > +
> > +/**
> > + * integrity_device_init - device_initcalls for IMA/EVM
> > + *
> > + * This helper function wraps all of the device_initcalls for both IMA=
 and EVM.
> > + * It can be called multiple times, e.g. once from IMA and once from E=
VM,
> > + * without problem as it maintains an internal static state variable w=
hich
> > + * ensures that any setup/initialization is only done once.
> > + */
> > +int __init integrity_device_init(void)
> > +{
> > +     int rc =3D 0, rc_tmp;
> if none of the below config options are defined then rc_tmp is unused and=
 the build can kick out with
>
> ../security/integrity/initcalls.c:21:21: error: unused variable =E2=80=98=
rc_tmp=E2=80=99 [-Werror=3Dunused-variable]

Thanks.  I fixed this by adding a __maybe_unused annotation as that
seemed like the cleanest fix.

--=20
paul-moore.com
