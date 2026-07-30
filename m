Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344736A342
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433311; cv=pass; b=EYNZCzgmdw0ti3zXgGrcUwOud7M9byU8q8ykW6E0C+KkZmEkAtAcnR2rzxG7trXAVm+LhSZ46xxWszOylx7W4+cu2b7SuQU9ipaG0Kfzo1SRabmH1pR2+PmC6dkK6LZGi32KYHG93Mng1dpPj47j94xlswifbFKno0SkH7PC6No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433311; c=relaxed/simple;
	bh=ddmhrxdEM1MscJQ9MX8Fl0s4LvqHUfj9OUWsQej+bkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ5IKPY4sGpP/bqDz6lMqUQ2ohsdpT/ivJQ6SDmTB7t4317UAqyi0DxT7aqKcYc3LzaKop1kVZVpKogBhqtRB5iJ7pTtE8Ry5UOKcb1lSDsyOQVBs/UV9sKtZ8I0kT7Ad6UzJrA7Yt8ELhX5C4fUWhvuUx9rDhDTW/yWqAuSjhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFcqm3fK; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFcqm3fK"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-451d8064238so93142fac.3
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433309; cv=none;
        d=google.com; s=arc-20260327;
        b=N8Iesv13enP6YUWozjToj7xXPqty9DS1KSWddzpK6FOjpbZGcqMYU3Bj2O2a67+snt
         VWHYJLnKpAClFf1FBJw11Q5I9jRu9OQ5+EdqiRmuwcFs40KihEIcI3FoVHa8t+8IxRNc
         2q37sQtPulJBky/Mbo8Au8THkt1YKoj0FRdtnn2Zoc5U91c61SkDmHZODnzdgBLN9omd
         0jKSn4FojLIhvQgr0tXwP+an9ZSuIxVuEyg7IgeKvRRUZBvFxob1S837Q0obeYxx1qno
         X9dZz76tG6yyx2P+tOLcy6++/FHJmO+naRdwWGSw7OIHmoUR1qrveWIaBa2okEcTYcMM
         QYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ddmhrxdEM1MscJQ9MX8Fl0s4LvqHUfj9OUWsQej+bkE=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=a8z0GN5FKkBZMaXmfNpjsPlj6UnjHU9g3U/lIK790a4uEjV/UfyhbYmSGZatmnLQZW
         OoVasYms6fbauLrtYozK6T++9sCUugDQzTEu8GMYjBWzcdrzTRWH5k7SXk4mcAu/Qsu5
         ja5WF7W6najGp3G+v97/3vPqvtgQhfGGSzOX5d8lQRGu7cTtsecHs3ciRraklMacyvMY
         2+gIDNO1BhTIjB3RVn9lIKCdSk6rAQy08knQfnp8sJF8emCvOXR33Td3ZO1mWl6tJaW7
         wXBOkY4YaSp0Dh6TSCMymZqzXRwCGDHAd2iUlT90t4kDAj+avdWHE9MTLnTvIW4PnaqK
         hY4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433309; x=1786038109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ddmhrxdEM1MscJQ9MX8Fl0s4LvqHUfj9OUWsQej+bkE=;
        b=PFcqm3fKuLcTeVDD5s0DAVFL4Wwqb/cjBvhofr/1JpQIGOkRYKu/+ARi52loeCUTmV
         FFfzKkQ+827Us3Y9hWsUsEYbkVeru8R++YXlsw3MDzMMJ3xe8KL+/86JxMkBRlXNSMA3
         bNT0kxSjK69HPNmdxQCh0I4hUF4g8n0Z+O1MoSknHAEj4AMDkMt1zOO2BmpzPSfiLw2W
         ZM+dzuDzO9NymSEyFNkPDy9AwmDdrIYlvyVmOJuWXRp3KJ2IUBYSdsbkvKb09aCFHHTF
         7HkVU81w41Yg9sBmyRpvQljNM6k9yPbQW36dItbdxl9qC+uPNLfzUqIpcT6v/H/9ndK5
         GKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433309; x=1786038109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddmhrxdEM1MscJQ9MX8Fl0s4LvqHUfj9OUWsQej+bkE=;
        b=h6gjPkPoG5GmiYgQsfONDblqj+BDUnpQAGz4ViYNMrFrak79/5nhfhhUGexMQpfGxD
         Ziz6/L5JZWs5EZA1TTAp8qRc1dBQtANDUFbFk+YwOyJ6E0mXMaTTOzq0A/5pX5GT+Loj
         b5S2AWlpZX4K73V7isM0yG6BXdlhSop2/WlW3mxgi5aa+HjDjGg0PwfSs4GcSpIXS8VQ
         V4CLManfzjegb/37FkUnQPxDcfwwoyRJKVwZyaMEkqBzb30VOcynrZFypV77MHDNvqKK
         AcF5MTi4Bh9DrpB+6LGLzBcTBMe8b4sLxRUNwz5djtfMXjGSvX8hEJpm8zz1G/cjSYdP
         PKtQ==
X-Gm-Message-State: AOJu0YwVpMzcQ9JNVx3NCLoQHjAKY9QbBV+n5pId57vLwf5slIWW7se5
	Lvic7K74wkbBi/t1IeuFpAmVAf7ko53zWMacpKvrCt02il50/wsf9tV/n52lhJCMiLHZ1Ir7fu+
	jf07E3ATyELDXaWB12eD342DTe4a0pq0=
X-Gm-Gg: AR+sD10cTUf7/8SD/9tJillmUQr3OENZY3AWcgMyzKV68inwTA9qy/y/5179zAn7pKO
	Xedznab/zjnPgpognTPvG7/9SAKxVTbZrgXPQpgsBGIUPWajv1ZgoqnD2GFejOnuXKyiYKrClFL
	PkjVZXhGA/IZSSHZIxoef96n0KXMp1rpF05KQ9RlRL0Zg27g0Aawv0wfAWpoDKgBo/vh5EWwv8o
	2uAc7oI62TZ/p6bAVz2GnbNvdSqLn5EjzCDksAzfeOzBw515JKB24oMOGLRNfsKC/bLHoK8IK48
	/8vNTDbd6t6oCvqbFCbWpYPZrAGIIR7Mc5/JNUadAHGG
X-Received: by 2002:a05:6871:eb8d:20b0:439:a524:a29d with SMTP id
 586e51a60fabf-458dcfca5c1mr650829fac.1.1785433309170; Thu, 30 Jul 2026
 10:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730124253.3282686-1-akkohli@redhat.com> <CAEjxPJ5sSW3fqQWF_BZO1VDSAjPu_jWoHUwJCp4MbSY62kz1TQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5sSW3fqQWF_BZO1VDSAjPu_jWoHUwJCp4MbSY62kz1TQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 13:41:36 -0400
X-Gm-Features: AUfX_myN8gh_yxQRZqvbCB4VuvHt0FesHwXHwVZwqFBURZyvHzIDq9xsi-dYPm0
Message-ID: <CAEjxPJ602DfRiYVgTpX+VUj3D5-axG_S+e5ydCTfwNbi_qnhBQ@mail.gmail.com>
Subject: Re: [PATCH] semodule-utils: add bad-data tests for link/expand neverallow
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 1:21=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 30, 2026 at 9:04=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> =
wrote:
> >
> > Add link/expand bad-data tests for neverallow and neverallowxperm
> > enforcement at semodule_expand: cross-module base violations, same-modu=
le
> > neverallow conflicts, and checkmodule deferral document tests.
> >
> > Adapt same-module neverallowxperm for libsepol 3.11 (enforced at expand=
)
> > while still passing on older userspace where enforcement is deferred.
> > Refactor link/expand helpers through run_link_expand().
> >
> > Add a cross-module require test: link rejects a consumer module when a
> > required type is only declared in a separate provider module.
> >
> > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
