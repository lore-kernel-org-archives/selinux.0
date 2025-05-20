Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7D25E47F
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747785586; cv=none; b=N7M5Q4wycwF9pie46QKozlTt05BNmiHL0ePhJiuR+D1a5mRKL/JQO42tGRT0tN6SWul2nF2wOMZS7GINpsER9Bw5oyAtF+3oMdJ+6fw6psIVFTipgZg4Ln2UglysZ929H1ZmTlDLqp/8aFR3lSH9AD/8eY8IVu0sJxHzVmXxuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747785586; c=relaxed/simple;
	bh=eUHj9fSbxSc1k4Z3XHlz4iuWHnWkwDcrvltnIccCgzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZG48Kt0MkUtarO/mXPGH4sO3rln6tC6zQBYSr8Oszj7I5oWk8lsZtEJ4dsMYzJ/Io3MwH0Bdu5KrEpzTCpYbjxgvkiMQS2MZlunaDVGcG4B0SJ4kBdUvRI+9TRIBApYDsu/VR9AxPDhKS5Jkk1ck/91IfUdwFVbecsJpiZXAl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gd5/sTzG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gd5/sTzG"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70ca2888e99so39818827b3.0
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747785584; x=1748390384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1nG72rXdkIhAo7FLE6YAhqTM0G+iygF5sC4VEEhEp8=;
        b=gd5/sTzGuLbkaCUBx0cBrXbp2bjUJARPNFhnd8QxeKDavp3XrYB8ii3Vd998xNnRa9
         y4EvmbFZgPtvOUBVjg4Kw6YqhD6hfJKTgYf+wmwYB/f1naXXbr1pEwOP010zXULvWVS8
         QcBimstOxXjkw1ye6X68EgOTIuerhBN92OHTNOTkM9Jib9aC6yc5Ionxxt1Kj5F0Y08j
         lhox7wdcyG7DJdxBNdA21va564G3S0uf8Ph+Y1EtinITgdLkUOItrpSsJYcMCntNN55Y
         dJCa4V09BBMF1ftZa7OGF4A2jBPjYetTXZ+uotbhxNXhaqTeSvMJfBBvMJfKx0HxcHyv
         ngvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747785584; x=1748390384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1nG72rXdkIhAo7FLE6YAhqTM0G+iygF5sC4VEEhEp8=;
        b=lL2huQILoeZluOGFdFHLZFk5Bx23LDGZjXg5fYqBpmdMc6VinhR+hVuN4OAMlSwmVO
         jtyYDtUKPefcduNzZ+BeAsNEKxvpRDPa4/LQcv+gVR2/nQBU0PiNqlbEf9en0h4rP/Ag
         rPGrUyrx/3EpqBqs2SbKNZ4cZcEhpIPDboPiNcJ6KZRomFJDBFuJEP8jaRe4oXLYvqZc
         iSMBsLCwTbIi0R59o4KZqbyS3TrzsNvmNiVA3Y9SQjobGFKm3In6248BZlptPHy7VNud
         ZZZMGp6IwZ9jlpFWZath++NrNm3Q9a+k4uWrMaGe3lpKTvirCnRX5ebjyZ1g7nlWEOFo
         Aq+g==
X-Forwarded-Encrypted: i=1; AJvYcCUlQwAy4mCBWJxfI+UXPxDQx47nSrqcIxm8Lf/GXANZAgJrQtJ0e4qCnPqWXDlPxoz5IUl4kWRE@vger.kernel.org
X-Gm-Message-State: AOJu0YyFTF7BW+3o3UD90T6Zq38pQhdCILnYqVMTTh1SOb4hsXLLDq6B
	XhRRHfHGA/a0piVj+fRxuHmsVUOTv+XgLFo2gkdqFt3FhNJIzx0hkT7lD6ChOS1tnZeavkn/1ak
	+82LV+2c2+y5WlVqR+bgwYOEYS47ZDlR71irSpLF3
X-Gm-Gg: ASbGnctk/xaTh+44Qde0q8kP1G7eAuSU655H1bGlo4Tp1zb2p/OtFaQ8euCAo73auYw
	TNAwF/e3qoz+PJbVrA8sqjbRcn0wcQIUiK2IXFMCWIONmyFcHM/bbXScfLBooYEBywY5nv7PVxz
	insUedq8vgVyrBM3uu91t5VUJKurudOCPhnZZnYWQ6Uo4=
X-Google-Smtp-Source: AGHT+IFi+IZ01q+HOPY1Ma+AGZsFDJtAdfmu1RjW4Fjy7LQNI5ccrRqq9xG0xCbDVRNVk5IfeVOu+go2CwJxrS774I0=
X-Received: by 2002:a05:690c:740a:b0:700:a913:854 with SMTP id
 00721157ae682-70ca79574b3mr229077797b3.5.1747785583931; Tue, 20 May 2025
 16:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502170450.27160-3-stephen.smalley.work@gmail.com> <a0842c097e2b73c93954e2a414b3fad2@paul-moore.com>
In-Reply-To: <a0842c097e2b73c93954e2a414b3fad2@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 May 2025 19:59:33 -0400
X-Gm-Features: AX0GCFvHP14rA2lgS9TQi8p1G4V9fwfTukMijd7ytj-OjcQHTa8HGh9mf-WJ9_E
Message-ID: <CAHC9VhQusHFyzkHHYwi2=6-HRBZ8VnRWO6NXdjEjD6PRPe3U+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: optimize selinux_inode_getattr/permission()
 based on neveraudit|permissive
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The second thing is that since we have this logic in at least one other
> place there may be some value in encapsulting it in a static inline:
>
>   static inline bool task_avdcache_permnoaudit(tsec)
>   {
>     if (tsec->sid =3D=3D tsec->avdcache.sid &&
>         tsec->avdcache.seqno =3D=3D avc_policy_seqno() &&
>         tsec->avdcache.permissive_neveraudit)
>       return true;
>     return false;
>   }

As a little birdie just mentioned off-list, this could be simplified
to the following:

  static inline bool task_avdcache_permnoaudit(tsec)
  {
    return (tsec->sid =3D=3D tsec->avdcache.sid &&
            tsec->avdcache.seqno =3D=3D avc_policy_seqno() &&
            tsec->avdcache.permissive_neveraudit)
  }

--=20
paul-moore.com
