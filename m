Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1813B14A5
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694878; cv=pass; b=CkcKQZKDvPzpD/iBgsnsG25gVRgU6Y50MrpBw4trnQc8h0Y/GZv5d16nlFZwJtkb9B0Zbzi2QSqEhr0AVNHCNVD2IEXylMGzLUE9nbFZEkip5CJ14NyH41afoP3VInzrUHySySAY5xbHYfRCxrScbRIotkBOC2LV5nA4SqHN2Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694878; c=relaxed/simple;
	bh=57RDETaEQnfFIklBUiZh2VyZUHCCnG7tnyCoRCEDsb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owvWJaM3YznbWACQDx57mwVdWxli2GuOPKkk1YOveEUO1BeDFBeZgoZ92vT062Xd07QG1wy+LiNuTyvRB5Hx4Ny7Ldrz8wW5SnALShd7SgZYpaRJewk2oXNgIoO10SBMTsNsK9Jir1zBKfsc8GyuAlXJZyfCJvjRwPMkeC7M31s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxFjRe/u; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxFjRe/u"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6756acdc3a8so592364d50.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790694865; cv=none;
        d=google.com; s=arc-20260327;
        b=kVBIuzpGdy1oFqi9tBwWIX7AXdXe0+6RSdhnQNFDK6PUckh9huAWIH67EG3N7D2fEW
         70JV8KnD89svj+hPvI050ynFl/s1SLjIzaZLSrevRXr0vKd4g1qNP1EjKv10kJoBhWBr
         z9or0ThbQP2f465EHW1NHDR77hTH6wcnhyRBvhm5/9jSGnATp8K6mkAHF6AEO2QxXP4h
         utUEsbgbVOo75E5yTypuve8J7psLlwnzSjx3/MMeDDvBoUYx3CHsKgwjn4cecX6dMqix
         3W29oKzi1KnktziLPupi7/fPMY2CQxQLUtH/LpCOTmlbSHuI0my0RU5VaQ1+tyNaMXri
         B7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ax3ygdyc/8BlIRo17BxWSuQjSYmMk4bTUGXpu0D/Hjc=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=f56iWHfYVozVc44YdR/ZaQT3xu2UqeXz/o+hV+zj8EoU+iSu+oVlxBmKCZZpibgqhi
         AuECUN4hclFuN1xIbRabX6XQhO/qixQk891iloWuGEyiTUqCSzPDJ1AbsgxpQkWOScft
         qH0Fc0PuCFsZsFFj+XvMYMHKlaxBJMmhw6YA6MHc38eJOH4Al6F2Yr7dqh7a5v9tzj7U
         j90eL4zR2+tLVPz3bh7jVS1rZmAidVdKemA1H/6t2FmjuQadI2ar0s2hiLbddl+VY+lk
         vSp86uwouITqdQ9YJMwsrM0vNMMn3Ju7cr9BWUeCW70K7zlsH/7fFFlcGr5+NzSse14H
         YXQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790694865; x=1791299665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ax3ygdyc/8BlIRo17BxWSuQjSYmMk4bTUGXpu0D/Hjc=;
        b=YxFjRe/uNk+L+CpSQG3R5Xd3vaQC7iffw3L2ZoCrHuTxLYRzMLDI8hD1OqxoQeXV+2
         TmWuPRL+emAhuvQZ4yFlcrZMMTXm2m9uHQmKoROwfrGZ/e9G27vxvEsu6FyfAIWPrftN
         +ACKr9SdcfyfN3cniVHMBAVeg6T9R8GVhFrU4yxBDuGI0cGTR8NiA/WzJPn9l9Y7WdE9
         duv16VNhwgtnlIYmEybGMTa32L4pJfR+R7IIPKtDuJEsRBD0I7CL5wHbAySoy5ti/Mr5
         rRn51k+0ZcHxKd0Z52sAHObnzw41dFg0K2oWSNLNZBzkhv0jCU3H61tg5JuidEi3ofV9
         y8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790694865; x=1791299665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ax3ygdyc/8BlIRo17BxWSuQjSYmMk4bTUGXpu0D/Hjc=;
        b=cfrPZYiLKLR7x95qW9LNVwRLDOWOsX7nm3oebPtjf5WuGGUBy3g+wRNbYADGMOM0qj
         g9RVO2HPbKoTmorTUrntGzJaCuth4rcdpHfhH0DAqdt+oWVzqsljeB4grRrsiy3HZZvo
         Dj4rY5qpYOUrabZaPqaDzcna8eR+TRokxLbL1W08FIwEwBpJ9Go+jcV9mJ4X9WJ56NEe
         dF+xoY0sI2FPI/kswHcmJsG3znKdQUR1P4hwtHsasJTlXakRperByQKBx27BXCL1Wd93
         ODXBnPM/nsjvxsRACcr7vA72nk2Kgu6W6H64OjF8Qvw7LKgSXOX2a6bzypUllTy2nqAb
         Jslw==
X-Gm-Message-State: AFq9FYK6r+2V2EvxdN4sIgcexenOyrNbc76766L9bEWyTbJvIVVRvtZR
	uENqEvph7sR2JpwIHJ6+atL9DMMZfEP8PqW/3CagPn0VlZlwArdWaOOLcMgyNXn8GfyWnOQAdby
	4gtpdGtLlvN4kVim7G+fHTqsc0XbZCD8=
X-Gm-Gg: AYBFou1D7938mRp41kQKR5Si6ga22FFnf/1BoauDiPKn1sK8bRtRavw2C5byUMNp9pL
	rEyeQtrTfD6Dvx4aD6Q4fXeiWjsCwmws6af5GO8KvRtr/BE+FICx3LaWItuSavnQoTTV2weDI3O
	vJJjB+1Rhbx83lg8bA1LIEd8KYR7jl7pTffeEhSdjQANB1IFHSq0N55+UUBl2aTQx1A0XBtlAM9
	f8VO8Zz4IJBuqZA6Kaq1q9FMrJxjcb8qZf0/zDewpyHQJKN5fSMXOJXksx2ikIGI5sSPM7KmFVT
	GXLNw/gFiIETRMVRBeyGUkA5h7A+ZlCnifZoH0rK2aJGUNf7ZbqrVNk=
X-Received: by 2002:a05:690e:4093:b0:675:3585:242d with SMTP id
 956f58d0204a3-675358528bfmr3020495d50.123.1790694864790; Tue, 29 Sep 2026
 08:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-21-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-21-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:14:14 -0400
X-Gm-Features: AclHuK94Q_o003-v6Uc3wBg16X-9kFGnBu5xr6j8sEOXW643gCDLcckAX3BGz1k
Message-ID: <CAEjxPJ5BYBkugQAvZD8FzUidGV8tA5zv7WG-EQsTEhk0F3L=WQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] policy: allow io_uring allowed in the io_uring
 test domains
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 11:10=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Since Linux 6.15, io_uring_setup(2) is subject to the SELinux
> io_uring allowed permission, checked on the calling domain against
> itself (kernel commit c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM hooks
> for io_uring_setup()")).  Policies that define this permission, e.g.
> Reference Policy since commit d4084b9fa ("Add new kernel security class
> memfd_file and new kernel permissions"), do not grant it to the io_uring
> test domains, which only get the minimal testsuite domain rules.
>
> io_uring_queue_init_params() then fails with EACCES, so the positive
> io_uring tests fail and the negative ones pass without ever reaching the
> check they are meant to exercise:
>
>   avc:  denied  { allowed } for  pid=3D3493 comm=3D"iouring"
>     scontext=3Dunconfined_u:unconfined_r:test_io_uring_t:s0-s0:c0.c1023
>     tcontext=3Dunconfined_u:unconfined_r:test_io_uring_t:s0-s0:c0.c1023
>     tclass=3Dio_uring permissive=3D0
>
> Grant the permission in the common io_uring test domain definition if
> the policy defines it.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I shouldn't have to re-ack the patches that didn't change. Please
carry my Acks forward in the future for unchanged (or even trivial
changes like updated patch description or comments or other
non-functional changes) patches.
