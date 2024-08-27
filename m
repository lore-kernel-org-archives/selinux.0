Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648071D4164
	for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800872; cv=none; b=dvpP8IPyrLRSmSwMWg0cGorBGJ9sHghO1nBhnXb0qfVKYOCa7OOnAN81aqcBG7OLKLy4e5CR7eZWLSZERL6oYcGsCpf8DUmxUN5JiHka2kr7XV1x2pNQ2G7hu9Q+G0vQN8Ts/TwR04nRf1Qwj6e9+BL6y/U3tuOWHLET933VzbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800872; c=relaxed/simple;
	bh=FuDNkY+uSpuYPew/32LGWl2xNMxMVFyiWNz4YKSjOlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5uOyoNaXEusQcJaIHfRpT/ihpVYld/pyU6Ab0DZ8eSEJhIPJCB/79QI1sySYXUuPZ5ZRnI8q9g3mNl0fMoP26Rz1SVEZkzfQzUqEqQu7jAVQGDAzh1NZvsIAC4TZDU5bfEo8tnLSbgXjTn1K9Uwi9LPEL0tyCxMzcIUdvTcIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JcmGxJsE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JcmGxJsE"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b5c37a3138so54459997b3.1
        for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724800869; x=1725405669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyfSsM1kWmLy0fivMTkjdvz46hfeP5aLbodjn1Oq3DY=;
        b=JcmGxJsEKVm6iLeqDBRr9Gs8M+EfELFgEk+Pi+x1EZAkZp4yFsuAFdz0/bY5Ga5VVf
         YevmuiTjx/KvIp07ZIRyxydQgTQX88arxZCQSCmPSYax+UrLWaIxWqZnKc2knxslyNSj
         nMO+gHDMZaw40lMAF27/0Q9kxm9YRbwtOnBTkOZ8SDb7/AAPopyGY2d6mmK8iyUj2Xix
         yoO1PEAowzbg2pEYEstpNFA+9Rajh6Z83kCnoDe9TjqFrI+ogrcUGX7OLgA4gr1+b2uS
         BPvykPbNTDLY3Afy+4pCkCWHkz+D8ih+6cQ0+YTnQYxrVZXl46vHCUjJFQDTtn1nuwoA
         jYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800869; x=1725405669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyfSsM1kWmLy0fivMTkjdvz46hfeP5aLbodjn1Oq3DY=;
        b=bI48warY22S2WnBuV7swdLJrJfODFUAWI6+AqdApHotByiPTkkzbRpbU5wnb6JRQRJ
         TtG6YM8W0ov2tonw0sZvdf85nL1s+lMfXdmz+sJ90Reahfl+U8Lqgo+CGHWgy9Cph3az
         ZhXhrzU2ZDG5ODg27Jf9yP5Pz/IJsYNTScOYnfwK9JLvUQ5Vb2OUdsMbw8HDgJxL7QpX
         RSX+dRYgYIthNK0u6MVlGBeLHHvS/JyaDNlJAgItYHO6C0MXmQIE5qmoIVo6HDRj9sbL
         H6Xhe88jzbEkyKee5bAAiGOEh2+vNWlyg/25ul861rcNGD35WR6x2JYhC3XMoQotSuSh
         X8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW/v2aHUKMeg+5/QI5mVTfh8EACsY7MxpWbEEkE/pZUiIJhc4+m0zSMIAnemvBySI/l/cjVme5O@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0BfeIqlwa3Wxaw9IZ25n1DLKkYUQ4+m389qITHzAsW7OvlJDX
	gPUYgVzOaItG3Zpz9mnYftedfvBg2ngpF2m6PV+J5OKSh4NzU7aZaIK9WBGT+lhGOvb1HxhUajw
	TV5jPOWe/AclGDGPJez0EhthR7uAvo7epKlph
X-Google-Smtp-Source: AGHT+IGtjzAhyrZwchJ5S91zBSvF0K/mC+GuXMXbe0LAFX6ZoLlxNnafUGdCPkBDqzGdma6ROv4c2MUeRTI4Zy5itVM=
X-Received: by 2002:a05:690c:ec8:b0:631:78a1:baf with SMTP id
 00721157ae682-6c624fb6b9emr171684047b3.6.1724800869371; Tue, 27 Aug 2024
 16:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813230300.915127-1-andrii@kernel.org> <20240813230300.915127-8-andrii@kernel.org>
 <CAEf4BzaiAWzAU8w11w3C+ws7rdSONZ5S3_7OOXy2_AW1Rwf3zQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaiAWzAU8w11w3C+ws7rdSONZ5S3_7OOXy2_AW1Rwf3zQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Aug 2024 19:20:58 -0400
Message-ID: <CAHC9VhSetig0H1B+zAm_Rk8g-spn+WW8OL+g238Zn5pKEZZiww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] security,bpf: constify struct path in
 bpf_token_create() LSM hook
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, viro@kernel.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, 
	Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:02=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Aug 13, 2024 at 4:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > There is no reason why struct path pointer shouldn't be const-qualified
> > when being passed into bpf_token_create() LSM hook. Add that const.
> >
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/lsm_hook_defs.h | 2 +-
> >  include/linux/security.h      | 4 ++--
> >  security/security.c           | 2 +-
> >  security/selinux/hooks.c      | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >
>
> Paul,
>
> I just realized that I originally forgot to cc you and
> linux-security-modules@ on this entire patch set and I apologize for
> that. You can find the entire series at [0], if you'd like to see a
> bit wider context.
>
> But if you can, please check this patch specifically and give your
> ack, if it's fine with you.

Hi Andrii,

Thanks for sending an email about this, many maintainers don't
remember to CC the LSM list when making changes like this and I really
appreciate it when people do, so thank you for that (even if it is a
teeny bit late <g>).  To be honest, I saw this patch back on the 14th
as I've got some tools which watch for LSM/security related commits
hitting linux-next or Linus' tree that don't originate from one of the
LSM trees and I thought it looked okay, my ACK is below.

> Ideally we land this patch together with the rest of Al's and mine
> refactorings, as it allows us to avoid that ugly path_get/path_put
> workaround that was added by Al initially (see [1]). LSM-specific
> changes are pretty trivial and hopefully are not controversial.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM/SELinux)

--=20
paul-moore.com
