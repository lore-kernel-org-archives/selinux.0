Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78B2D3220
	for <selinux@vger.kernel.org>; Wed, 15 Oct 2025 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564386; cv=none; b=tEsxw9cWJf/lrfO7qTsmNZTlW4wnBoBk+vzYQlWuCsg2x27gG7BKgZp2ByQzEFws3Bz8wqKyaTXANspZBEiY3+IaQUeGvd7JUDFILIIcHYN6pMJPdpepp6WT3R5IhgEKRVQTtnnV2NUfzO84aqN0NeSWhSh+x0oaIFGraUySWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564386; c=relaxed/simple;
	bh=A4NiBgVZNJJTzwX0wm64RPAsnngS1JqWAqTP2YMVXLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzIDieOig5fN8CYlSgGKQxXzdjxITTvEw/gs0SUpgDK81lzhG3Fg241gBOv1hjy3M2yHyOf/kXt9xYI9H1tDacFnkZGHS2kpuyMf6xSHQj0IAftw44UZ0ToNhSwToVwERlj8tcMJi3niOgbOzqn6KwYix6Cu5hEbKvATdMsbhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XQClTKVs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XQClTKVs"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so95818a91.0
        for <selinux@vger.kernel.org>; Wed, 15 Oct 2025 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760564384; x=1761169184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdFvM9mNewjkl6LIp8rw5Yhfk6aSWQSg2yJiuBGtrV0=;
        b=XQClTKVs+AzQJCKHNectUokEFcvYrJG0SekR7ZZ8wJcXGVq8ycjPMwT0pm4BlOLm3n
         u3mVkzOoGjsiFvZIEM1g1pA679l+C6XZF6D7bP3EvW3P06ikUUCNAP1fg9hs69zQEprh
         6tLZXJUCO498lx6TtsQTjXSV/2GadhFg9GFpa1bYvWUGZ4l0BC8Bu2J/rgGZmdCHT3ah
         xAoyuLrd0iZJdL4TaznHvO4K876XnPh8718qtR3krQkh1TZ/IrTh2HL6nRw0Lkaki7ma
         fNgWQ6WZFDjvl4HqEPoYIr9cWBn4F2pSNgrYUqWCBdsRww0rhb/hokfLsi82KaojLOGq
         5tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760564384; x=1761169184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdFvM9mNewjkl6LIp8rw5Yhfk6aSWQSg2yJiuBGtrV0=;
        b=k8augEq1o8ElkqGdloGT2ksZpFyYCHnh3kOwVfjT0p3qKCnBczvq4OH9rKx6hmCz62
         0IlXb7BblcRPHoqpqZ6DGqFyNSxNJIS31Ad00u3IVHdxa6cd344wuLyqyMmrufTUe7r3
         wYkBqgKjB+Mdk4E4bsUk/sHb3+wAwZszYr3MZLr7ykz8AhnMvgapEdsdX4GX9JzNQcup
         +0l+PjwMhB6P+tAnBU2uxcfjEt4XD7uwby/vsm2bKAxjitLPJn7lKv4KzEgTd+e6/zg6
         nyYJ7c91HSwunRzcRpWQpjba2Ol59YljB2Qh8PjH31iIhGinkOt2IHV2eyYuxyhoPM/a
         obVw==
X-Gm-Message-State: AOJu0YyBdyUNoj9bvKyjgO1Vfe0DuziwlhhoyRDByY8yIzQQeccBvrGr
	W+mZczH/jy4/gbgJxT+0AZIbZfyvQxjB6luLf/kCGEY5t653Bu4fUP2hicYiZnEC5kjXMVvS804
	CON6+55gk7WhmPZ6ZufOW4poXgQFaQ1xd20fk5qi5+9oWs8zekYXruw==
X-Gm-Gg: ASbGncued2jmmgQTbaMjxvrzdsSrZ32VBOrH6e5/ESpvJUPXATq1cvoq5K2+hKU1WvK
	Nm3BXSxD2/Fbt24+FBeLJ6zlALx9SPE0OwzWrQ2otuKMVLjXnZHK/+Dk/iu6RluV4GJK86OCnxl
	ow4u4PfTVGJCroOmG7UEPpEM7N3gReFhutnyHmpnfXk4fIzhYdEVHfmeVDW5XLrWT3VXA9wXNCh
	e5QDsM3zgnVGRCKcq7fDiXoLtLIlTI9OgCs249LpETqJqxU4ctyO9Xb+qlC
X-Google-Smtp-Source: AGHT+IG3U+6eHlJzN3s5aT9PW6pMgtwwl6cpOeWYQRrh9ReaJEW/kQjH/mqTaW9Vmu411S8ltm9AxAAyjI9vXfVVUSo=
X-Received: by 2002:a17:90b:3b8c:b0:32e:3552:8c79 with SMTP id
 98e67ed59e1d1-33b513cf79cmr40057195a91.29.1760564384292; Wed, 15 Oct 2025
 14:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4CNH91Vh-5dF=43Xwg7WpSq8obKn+iAyg0HhqWqBzAUw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4CNH91Vh-5dF=43Xwg7WpSq8obKn+iAyg0HhqWqBzAUw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Oct 2025 17:39:32 -0400
X-Gm-Features: AS18NWAN83SNyBhZraArZHRpvwsVPosWUsBpWputK6op5b0HYz0LynTMKapbPPY
Message-ID: <CAHC9VhQZ9wdb9Tr4V40kXu_40xF29+dizae2oysPL5LKnkfU0A@mail.gmail.com>
Subject: Re: Fix for v6.18-rc1 udp test bug
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:03=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> For anyone else encountering problems with v6.18-rc1 triggered by the
> udp tests in selinux-testsuite, this appears to fix it:
>
> https://lore.kernel.org/netdev/20251015052715.4140493-1-edumazet@google.c=
om/

Thanks, I've definitely hit this, but between some kernel-secnext
build script breakages and patch reviews I haven't had a chance to
debug it.  I'll add this to the kernel-secnext builds now so anyone
using those should benefit on the next version.

--=20
paul-moore.com
