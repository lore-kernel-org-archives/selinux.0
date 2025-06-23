Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72881275B15
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691408; cv=none; b=dLYBMhBaEw4lWHukdE0xTAWpWLROExDFX000Mgq0aizFl3ETpAFJVPlsqS9U5YIj+/iG1mEstMTrmtQFhOzK5RULeDMaqwUo7GLFd23HB9bcBpHHBXlTW5/IFFzzjDg5C4nWWPAjvJqeDkpVCBPTwc7HJ4CNq9dcsaLf7JNt55E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691408; c=relaxed/simple;
	bh=HazBlh0XsmNByu/vRFFqgQQjJDyRrVYjdvZbtfH6brY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMw/eHYmlKKUWRw8vvUqOMCO/TLYDQktAtY/I/SI7KAg34DW5rGoJvxeH5yhlcit0aS0GbYmuaAILPKBNTrO8SKsxRcxSs+NBvOR7og/iOS9lKDj27Hnrg0Q5qdE11R+IF7hzULbsc30JlkoPZCCurdIsGBv52BTQD8v18d69oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EZF5gDsl; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EZF5gDsl"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7086dcab64bso35909677b3.1
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750691404; x=1751296204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHbyqPz74VkWcZYrWw/x7PtaErCdXAYfKar2DqwwJgs=;
        b=EZF5gDsl6DzJtkrRYyuNOsz2NAHmRsSsWJV1RlMF+JD5NNi++GZpWOUOMntz94xYAN
         egLQ8Te1jpgHoBhiXYrdlmq0y65Vf3d8V/YuIlHzJvzv2rCUtq9iSufxO055fSM2FgM/
         Dk4j6o3iH/XqRF2l4/sHteKt1kLyek20rI8avrUS8F5ujiN9p3UFaTjziwMlfgKAL9Zy
         pdixXvJNoxKIrgMnWULn+bvKgzsPKVj2fv4owHAQQyctM6NeLTkk24jX/ltjKqkuBfuT
         1oeyRuVVOawMHQUO/3w013VB+kIKjHaqFIVuqScfr4Opynfzy2pyezfaHS0/KQmvJcrI
         uc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691404; x=1751296204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHbyqPz74VkWcZYrWw/x7PtaErCdXAYfKar2DqwwJgs=;
        b=ls26K+BDCGB/5ClbnKq7C0fMy1T6B7AGGGffKyRp/8Qf9zbN1JGOlt5CwnUZTtrInC
         1iEvjrGXfnuP0fOmi4Fb/C/vF2n+bWDwrKdmf4mnJ7GHEBq3Eit+lq4APMO3Zooc/Juv
         URD0GRH0c6BLg7yHV0OQJ45BiB31rsPJZJwS37OKga3Pvluvg6vC8/rXgLh7/WOuZwEn
         6RP+6abKuL6Ol16Pg9+JDDVlbyAv0ljgHAoeZfwG0bAa4tJcBv8Ye1CiwxHvLjdZW454
         O2wF3jmX8U/TFeNlQdsEDH6M0y1E2TS84siBfYkzmH9mrBZcZRVXcydw3zGJ4DdQud9K
         LJ2g==
X-Gm-Message-State: AOJu0YxoVGRQoF6k+c2H3YqQkQtTLALFHk0qWOontQIk4cVW12LoEL+x
	4y/WqByRa2OvvvYcv2NdwJFiAW/NfIRg+SpQSTeziwGw6jCyq4SopOcJ7NRQfNh1VztDJDus9AO
	oIfmMRWhQHcSdn6DwznTanwmGyzbQm3PljY3CXh2f
X-Gm-Gg: ASbGnctvPAZ/kZ9GFnlJysoPBEdKpBBm5ZsXmL4nxJMQFzN3UuCu/eaVdLdVNJL/ttA
	/dVUFQsgl+JldrlK1b6dgE5PGXM1lp4UCNwjocBHg4vJ4nuact0mhO40b0f7iIog5dGQu40LZ2j
	dD0Ey2elipn6kut3xfTCc8iKiUa06Rnw3f1AIfVJd/IPU=
X-Google-Smtp-Source: AGHT+IHeZ6j01nWJ4CsvoEYlMin5fNE7aixGG2M3og7LgG0oCTt+CcTRVRTYvM3OosQYJ+qW/O1wHueTILme1NmmVj0=
X-Received: by 2002:a05:690c:708d:b0:70e:7882:ea97 with SMTP id
 00721157ae682-712c63afd4emr186229987b3.10.1750691404371; Mon, 23 Jun 2025
 08:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616132724.22406-1-stephen.smalley.work@gmail.com> <CAEjxPJ5bn6NJwAWsjcfuPhUHuhULjxwxiK3DdY-KHJjBQjxX0A@mail.gmail.com>
In-Reply-To: <CAEjxPJ5bn6NJwAWsjcfuPhUHuhULjxwxiK3DdY-KHJjBQjxX0A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Jun 2025 11:09:53 -0400
X-Gm-Features: Ac12FXxRhbK6obElF2IazkRfZNyM0j6GFBBw_3SVQWHrLNeEYKmZ5YElYSfnKIs
Message-ID: <CAHC9VhRfFUYiMjZZV4CG4L1UwcfWLYjk0gTVb9Ndqvu7RWmmHg@mail.gmail.com>
Subject: Re: [PATCH] userspace: replace all links to selinuxproject.org
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 9:37=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Jun 16, 2025 at 9:27=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Replace all links to selinuxproject.org with links to the
> > SELinux userspace wiki or the SELinux notebook as appropriate.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Any objections to merging this since selinuxproject.org is dead and I
> believe I have replicated all of the relevant content over to the
> SELinux userspace wiki?

No objections here, I think it's a good idea.  Thanks for doing the
work to update the docs.

--=20
paul-moore.com
