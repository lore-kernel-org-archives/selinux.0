Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523DA30EF88;
	Thu, 11 Sep 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593174; cv=none; b=KIhWV4NIL6zUNXhO/MWlPsalkXUx6GWPMSNjQ4cSXCX3sd0s0IEXzxLV6Whj21hXHiEMlx26Hf6HvU8qIp/uaKZtV/f/FIvdokiCLEB0pRLO12noyt3PmOi1Dr5IViPytHxyT9pKxOX3+KltmlWkENvj3LUbovCkXd9EJEJE1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593174; c=relaxed/simple;
	bh=lWtR/Gen2p00VdXWiJ+YA+dkVfXa9jO+BioMxIij8wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5WvNilzsx/5UtUrVLM2lklaDo9UHZXuGwK7a26BnJX1JE7x7QNlZuz2gM9FqsbCn7AQgqqwiyaPMNALElsRVuSe51v578N9Vk+D4CGQde0jeb4eZwH9Z6SWGeV3Hw2vtz07GrP5dkDmmv2tEjCdwY6FOgQEbU+XzNWmA+qBiC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP89TnGH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP89TnGH"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4d4881897cso437413a12.0;
        Thu, 11 Sep 2025 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757593172; x=1758197972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWtR/Gen2p00VdXWiJ+YA+dkVfXa9jO+BioMxIij8wo=;
        b=NP89TnGHAHovDQQW/cr0S8rV0HOy6XU6lONd9YtiJDh8HT3xBkFBep4taV6y/nW5I5
         gz0gf1ViOJ3QyCGcxXAZTQ8xmXNeKa4AH9XH0AwIUUUj7+ETZqBP4IUdhVtLDvLJkJoz
         b0AIQzOyVNLGHIyIkupTHGuChuAawTynT2RfxJXITNX7ENVy/0nvcbnfNhWSaDfxiVCV
         w7OfkUAgOI4APGrgCSZZJqlrquqchQu8vdaohMZqlhaFFNo/fEafKqCn938BgHgI19iH
         Cd/xEWVzZpNyAI2ncKtgJ7MMuLcpAluoce8FVzz8meRmXpTFZMYNROTYKRVM0ZHxtWuE
         U6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757593172; x=1758197972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWtR/Gen2p00VdXWiJ+YA+dkVfXa9jO+BioMxIij8wo=;
        b=Kv8qMeh5UBuso5kv7VnFEB25uuTqKMzBxBi8yWC4Pe52Ns0QSFXKMLr09tt+P3qVzD
         nEwRp6RHuLpaEHGo5cRLackHeCb7G4NCiNcnWKVsxAd3sRroIQqUQeMikIRDZZkewGue
         RQ8ih/JFuF5VD1M9Wad/vmjvI9YxY0JzE97ojQT3dSITZsGBtqEiq4wz18/2gvByOtlh
         ah/j9pCYc+2MF8HleiWSpH+jfNDm/L9TN+1WrCEIXxW29IC2zbl0XippI8jchC2ks7RC
         CQ5PvYAk8Fs3QlYzgCtGGyxP1w8U6B9Dbmfoz2ZldUwqy6Y+qVAd6TuoWdwQIl/5+lZE
         mI1w==
X-Forwarded-Encrypted: i=1; AJvYcCX/YJesqB9GY+RYhPxu3vFS4x85FCbmTw0ae9jJOAAmT7U4J5k96jNqQ8Ii0lgMbqiF4vsuFUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qCG5pAYlXLhPF2+6L5YeH+RW6sX3csALNSqjW2c8Xt6jSNK6
	I95l4yW+U9r3g+gxfqKlkfnzbU5rtDUqKcSXMR0xdOyKV/WvYNXnLpN8ssRvCK026TiE7cpKSdI
	ULtFdDXvw8kA3XHcJHNpXH1bYoYPjPU/DJMKS
X-Gm-Gg: ASbGncuDvpsEkdZXcOsOH5d4mFNeHDtVtupJuqbMybP4P6XQ3Nui3Nj5/5mI6rjtqGR
	7CoggeYrJwzryFU6Fqxgr96WuRqWtpBPcKlw0wsva4e5qYIv8TWOxmJpWLHf6MO1J5k2GyKX37p
	gssXb6vLcw2pftEfhChBKOMwqaBd5if62eFYISgfW3Wa1O3mIMUSuvW0pjmV4gUz1MU5z9EfRDE
	D8c+4jm74EdU0UpaA==
X-Google-Smtp-Source: AGHT+IGGuy1wVQlXKaUW3Yopk59LkHeJDzt8DEdVaN1TIufpl9eGokUpZNY3LXPrK0xJWZNsrIqtCk0NFuNS+NwRklk=
X-Received: by 2002:a17:90b:3c85:b0:32d:dd7c:c3d8 with SMTP id
 98e67ed59e1d1-32ddd7cc580mr1008395a91.25.1757593172462; Thu, 11 Sep 2025
 05:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
 <20250814132637.1659-2-stephen.smalley.work@gmail.com> <6cfe4uqtic6ga3ch463zflke2wp5hobd7j3r5ctyp4puwbjiet@xgi6jfi7au3c>
In-Reply-To: <6cfe4uqtic6ga3ch463zflke2wp5hobd7j3r5ctyp4puwbjiet@xgi6jfi7au3c>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Sep 2025 08:19:20 -0400
X-Gm-Features: Ac12FXwAiovuXwx5vA7Sdc_GZCzODjR2jcx4RP-81Fp_mXyPLTv4mjF9qkeI-BA
Message-ID: <CAEjxPJ4FYD2zyOCiUSnOzf7eP5_aN0d86=R7scwUueyCMQzF-A@mail.gmail.com>
Subject: Re: [PATCH v7 01/42] selinux: restore passing of selinux_state
To: Maxwell Bland <mbland@motorola.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	netdev@vger.kernel.org, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 7:12=E2=80=AFPM Maxwell Bland <mbland@motorola.com>=
 wrote:
>
> On Thu, Aug 14, 2025 at 09:25:52AM -0400, Stephen Smalley wrote:
> > This reverts commit e67b79850fcc4eb5 ("selinux: stop passing selinux_st=
ate
> > pointers and their offspring"). This change is necessary in order to
> > support SELinux namespaces.
> >
>
> FYI, thank you for this new commit. Some "fuel for the fire":
>
> Turns out, e67b79850fcc4eb5 makes it hard to enforce immutability on the
> SELinux state / AVC cache from EL2, because the compiler likes to put
> them on the same page, leading to having the hypervisor track spinlock
> management issues, just to ensure the core selinux state remains
> unmodified.
>
> In the past (pre-2023/e67b79850fcc4eb5), it was possible to set the avc
> cache onto a separate page from the other critical selinux_state data
> during early boot, and it looks like this *may* restore that.
>
> As you likely know, the issue is without EL2 enforcement of immutability
> on the selinux_state page it is possible to just flip the enforcing bit
> via EL1 write-gadget. It may also be possible to address this whole
> issue using ARM MTE or something else.

The reason for e67b79850fcc4eb5 ("selinux: stop passing selinux_state
pointers and their offspring") was that Linus was unhappy with the
extra argument passing throughout the SELinux functions for the global
selinux_state.
Until/unless we merge my SELinux namespace series (of which this is
merely the first in the series), we don't have a compelling reason to
restore the passing of the selinux_state.
That said, placing selinux_state on a separate page from the AVC cache
should be doable via a separate patch independent of the SELinux
namespace series itself, so you could always submit a patch to do
exactly that.
