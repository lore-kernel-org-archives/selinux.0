Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E445C6EA
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883903; cv=pass; b=MnCA/OfUP0YmCs6krKy2l1mJsCkRy28g0iG2+FVqLilhShzTNGa8j2DUyLZfk9UGbwNx68yFVE0IlVrEP7FqZGIFO6TlsGWyk+AiW/AwQj7l8iC6/4coldsMrkl531OGanA1BzHF+togcL3bLm369NfSncHryfipqnIWJRenDec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883903; c=relaxed/simple;
	bh=gznHXztvbmetY2aWj5E+3ZIVS81ZnFdOPRsmJVjOirw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ij0Mm1FB87ZgkoG2ivI9t6oKvvCCq8hSWDc/kQCEO3wg/DVOus8nhV66IhXKVpjqyhSM3O/6/7QQkeH3v2hifDTZqvquCa/IFlVxnoipIS2O/cK17iyy5dqQPZHBy1ceKTmnNuBEufr+rffTYRjcUKLcIgJVYk/gofpdy5WDx8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N52RX5iS; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N52RX5iS"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f516c271so6312223d50.2
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2026 12:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790883901; cv=none;
        d=google.com; s=arc-20260327;
        b=LmIqvj2MWbeA7yV/J/gp919hYtU/IPzZj0Uc99m6ziEgradnFr2eXK81V938Ctrs4Z
         ay/yxQG6sag+f1J5Ewe9OtB2KZjDIY1hUDutzBiMdMV/IP+VzmHMrO0hKfPcnSSxdkNj
         StNAUuA32Cshwe8q4dKX3bMtEa/KLRIGP6adT5F1db6txfdQQRP4rmNKp0FjQUbNE5px
         vZLqo7QT/6OdlF2yAOW2IoQY+lQoGKm37TNcrSB/EXThSQxdVEGVqsqd3uCaGZqOQ6jd
         tsocLpQ0NQt/VBzUwS83Wt39TMGnuqoFYqf1yO2cnfxhF/PXNyC5QvpfHJ75ER+VPxU9
         pxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q20lyS88J5g67zeMmkIxVJCpb1vsB2Y4w1KYoJvV+HE=;
        fh=+/jkIbTpILq22bdT2iyNUDyKgmv7eCl5AoATw4+EBko=;
        b=MjskhQOW5NBye3JVKzb0YJHtClNOv7GyzNUJ2UCku8fAJ8vT2lB3Epk8zCUDMW0qMP
         pvfbdKXLtZQmyfSq+3gUjSXagWsTVNgg9bTtJsUYoBNejhGod0s4j4/tTnyhKOdGsdt/
         GqPecyAOsH+DJnaO1gunPVgDS5HqUspsi1HT+9HYZcqTAFSWGjSRsdOYw90N15LQPJ7M
         255j+QaFGnWyfbDXU8fQPQkBWH/H50q8IyXqzHbnYNECD84QhKNKQiK99ZGSdEEQqM5Q
         GcWnyHCuSFTvGbM11uuHKzIyFZqDogwLrh4nf2AM6B4YJnNHrAtpynRttxeiWe73J9UM
         X/Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790883901; x=1791488701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q20lyS88J5g67zeMmkIxVJCpb1vsB2Y4w1KYoJvV+HE=;
        b=N52RX5iSOyL/X4CFDmfCn0OU2hJVM5ISWlMlMSFdAmqmofyxpcMJhaAIUs+8PpGhDX
         2t7pQUJjxcHOAMZ9sghkZPJ4gJF4wcAWJcpK7VmaKVDHEdV1da0gSj1W1oGmyqQUMumd
         /+4YtlN8Ow8lG/V0g6P6fgXnKlCNg4rSsyY87fvigcXHTpK/qTsXfNgQlWO/xz9e1xKY
         P/tNDzcG+k5H7M5aKw0I+0JnL1VkYIZrtXx9HzxqLdvw8xg36KxZXA5b/Uy52cMtS/bq
         pgATSLoVadhLFgxrn3psPJg5Pn+rlgdmtW1w/tqqs/CIz8/AJI5TxrPn1exvAnBUcejG
         8ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883901; x=1791488701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q20lyS88J5g67zeMmkIxVJCpb1vsB2Y4w1KYoJvV+HE=;
        b=YO3ZeaX9UHg/ZEFjzUlNT9JhXxECfY3o0+eUUl7GsQWfBJZWGXU1vELS8XA3vft1pf
         dsMK19ZJnbrO/ThuJHXziWqJPuMCJX11yMKBJRQ//l1Rlwp7E7ypNhVUOe14ngtIQ+xV
         GXBjumqBxWkK3BklydBkPqHM0/qf4jAEFVeTua8B0IBUu9oKbHjTfEBm6RoVaNj7gIzo
         ihnnLqGlLmjLSHmcD9BChLZBHfj/2L2zu/Z16V9xCI1RVfsC9dybbKHVMGswf7NS526Y
         HEbyldbBBqeLrs9FTn8N3LimvdGIBQMiZcJZ2AnLZUHlZfNaAsCv4c0oZFInjFUScwcx
         EFVw==
X-Gm-Message-State: AFq9FYJlHtSJ9j9RupbHLpf67ArzbpTF5KLEQJW5KmGR/FqTmLcC8uB1
	LvK67DwkB2OnsgXtMs6Kr9m2BccYNkBpoa/GuCcd4zYe5lJy+ITcDHttdEQqpMZ8gowAQpRFq29
	cZq+yaBkw149WFf3dVzz1OQ92skN+mRk=
X-Gm-Gg: AYBFou20xj/KrMfGb3WY1OorlLJmN5hepPdRrKsZ0neawsWSANvSRf+/axrukwxYTO+
	bGeZdL4RsjHhv9YlbOZtfT8M5XUzimUSM9c6gHqey+0km5isfTMbAawo1I9k3nzv4zpMQXgZlpV
	FlF99+eBzmNPZEcIw0L6L3KLQ9hgdDhk/gO8w8j/HURyeLtyHN5CQwJQsjDpM4bTVh/tU4h6CJt
	u74y88+Kg4g77xw8BmW2aLv+OH8USJBkBovdq0ROLC1vlqkF+kARcSGQdS0sbWNuMbIl6mLdGgR
	IfeqnbNKZaCbFcuLr3C0TZoZg2qKyBQUuP+ktcxdvXmu6Xh7ken5Yvs=
X-Received: by 2002:a05:690c:a584:b0:8ac:b192:c8d0 with SMTP id
 00721157ae682-8ae3a00d43bmr1247267b3.34.1790883901153; Thu, 01 Oct 2026
 12:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710081533.451115-1-jonderka@redhat.com> <20261001153456.104370-1-bgrech@redhat.com>
 <CAEjxPJ7E_dVUF6XRJ=zS2fBh9QM_aw+k_9fWyxB77nUKQKiNog@mail.gmail.com>
In-Reply-To: <CAEjxPJ7E_dVUF6XRJ=zS2fBh9QM_aw+k_9fWyxB77nUKQKiNog@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Oct 2026 15:44:50 -0400
X-Gm-Features: AclHuK8Mdz6iemlYX09aZZmh9Rv1T74WMJayAF8pdjyCvbrhbSw8L4BxTBQOA4U
Message-ID: <CAEjxPJ4c_k3EyRGoe+wRcsv_==WZE76UujJXp31KjSs847qXkw@mail.gmail.com>
Subject: Re: [PATCH] skip inet_socket/mptcp when MPTCP is not supported
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org, jonderka@redhat.com, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Oct 1, 2026 at 11:35=E2=80=AFAM Brian Grech <bgrech@redhat.com> w=
rote:
> >
> > MPTCP is supported since kernel 5.6, but only works with SELinux
> > since 6.5. tests/Makefile currently adds inet_socket/mptcp whenever
> > the kernel version is >=3D 6.5. That is not sufficient: some kernels
> > meet the version requirement but are built without MPTCP.
> >
> > Gate inclusion of inet_socket/mptcp on both:
> >   1. kernel version >=3D 6.5 (existing check)
> >   2. the net.mptcp.enabled sysctl existing under /proc/sys/net/mptcp
> >
> > v2: use the net.mptcp.enabled sysctl instead of grepping
> > CONFIG_MPTCP out of /lib/modules/$(uname -r)/config.
> >
> > Signed-off-by: Jan Onderka <jonderka@redhat.com>
> >
> > Co-developed-by: Jan Onderka <jonderka@redhat.com>
> > Signed-off-by: Brian Grech <bgrech@redhat.com>
>
> I'm planning to take most of the patches from this series:
> https://lore.kernel.org/selinux/20260928155753.2259807-1-cgoettsche@selte=
ndoof.de/
> some of which may make this and other patches you have redundant (or
> break on conflicts).

I just merged the subset of that series I acked so you can now re-base
and see what if any of yours are still relevant/applicable.

> Might want to wait until those are merged to re-spin. Or if you think
> yours are better, let me know
> and I'll look closer.
