Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071AE41C64
	for <selinux@vger.kernel.org>; Thu, 19 Dec 2024 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620275; cv=none; b=k71rygrGPHT82aAPyO57zm1whU+rrNm6AvD96y9CwjWLPME5FNaCEZONibovFraJL5WySK81+yqI/VZyfcvMLKuAG+9Ha0nhpPFNu2+MiSboh+1CgTojFrS+Qj0yCJf2NNJg7jd5L78UJvwVIB8xbN6ZgJSt9+HobaQKL/CAnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620275; c=relaxed/simple;
	bh=S/fs+SiilsJFY7M+wtNsFnghL73EuzyiNTu22uDVReY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNWUzC+V1hF4qp2bo0ky9HuPZeDZmlPpudsQXaweUFvZwsA8YrtDuoDOtxukCrwqi45PP2P8KgQ21OMhKQ3XxKvXRoB+hqWCt7IEaDQrjrV15+hc0zdfdJJzkzZixTEP37tgXZxMOyH+/jevEd5P1HF495S/oMIFadVFXILyH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CyCv7wn8; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CyCv7wn8"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e39841c8fd6so689091276.3
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2024 06:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734620273; x=1735225073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf/Qa5Orc+RuYWevf8tGy8AGAwaJN8hCOGW5OyYyX/I=;
        b=CyCv7wn8+LyFTiop3RoaO6dkOzTUk223bzkiBfKzD1EE4pg03CPgNodR+C/MyLMoOp
         7B/Ol1/e4XJUMi3/TXGOzM68tEIwR0K6c6fZQTzFgKcmQi5BRI1iI5OH0lB1MHcSBDyK
         hbiZMZWIlpRDm6ygTROgn6FlDpciGuI4wdmQ94iHduAOVwssmdHIWrhF13KJd+9PVDGf
         EE4Q8PdpYW/vf4WngSCINOIwFeuYieITysBSkoMXqhaZvTDLSY0FOajyLaiHMb94vGBV
         M2zs7snFH2GEn+SloS1oEIiNMOVrtPNIO0owoLlpmsJcQ5WYZNrt4Bjl/Hp9PZ/K+xAW
         br4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620273; x=1735225073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf/Qa5Orc+RuYWevf8tGy8AGAwaJN8hCOGW5OyYyX/I=;
        b=wOo4HncNd/DpfdO0HFaum3tRh6Ieq1KpJDQTkFkGmBJ2iThXhpAcggwNxyWgvJLQf4
         og3/nh/Bqh2dXcTBqxxeDl5nqFFndiT6pE++0OJbNZSQl4VHnaV5p9t0pbDxGEsQSIqL
         94fmkk9/kCO6BWS4Ikev1YhDA2rZdS3V6RXX3+CeDrDPDbA3v2OAo7VqXtTxWNlKYEmk
         xhv0mUtM05rUlSj6jUl1aqUpBpLO2S7OuuDYZXVY1qlMf/uxRa6yTyWAXdRvyJgA8n0E
         FbIer9E62szbLqTn/v64MXDLfrzbBmKvrTtu7DLZSsUqPurtXZ/BsXNLvB2jwySlCZH3
         2zsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXisUQm2Re8mL8XHCpOOlgZ2ieNOsDPWOI7H32MQqvuIW6HuCpLmRo0KGt/JLsMkIeQ0ECaWx0I@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+bj4/tQeWvUKshvRGnEZw/R714sN1YY7A2C5C4uVdoZyfx25A
	ask4FqME9288o9+JpmkNAL9ukNLxc9EkH9pvTVGexI9Ae/G0h3SEN8C3mNgtuskNQIPN8T8uh1R
	wXUtdC9uVtmdsSaZbRUxOIm/D890+6TL03aZR0/Zk8GQc4QA=
X-Gm-Gg: ASbGncvNV5E4PwsT/hjQsiLSyhtEpfsUTVmCrkn/upUiUR/EpGjwOSrKkxJ+fgW4kR6
	fz8PetpJwt8z18R9Q8R2ykZvvayRDNxEqvA29
X-Google-Smtp-Source: AGHT+IHXt1IMyWvkeKj8sgcZhi26r6NZ32Ie8gGN6q2FYWNHs3QH3L/eZ0WGKQ6Ok+xx+/LStc8a/L/Zsrktcna04f0=
X-Received: by 2002:a05:690c:8f:b0:6ef:90a7:16ec with SMTP id
 00721157ae682-6f3d2697280mr70181547b3.28.1734620272951; Thu, 19 Dec 2024
 06:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNuVK=Pt6Vx8xiUF7WFhCD3VrqjW=dvox4wHWZfHBCEDTQ@mail.gmail.com>
 <CAHC9VhTqe9roT1dySDXDMQzbOSZyA0f34H0a1xinDSLd-TyQTw@mail.gmail.com>
 <CAHC9VhTTGA5LADsn4OxJAUkd4V0auS4LrPQs87JqmRVV4nraxg@mail.gmail.com>
 <CAHC9VhTSeC3NAbAA192ZHQsRZe2aYELHM9inYOPRsR31wSyh2Q@mail.gmail.com> <CAFqZXNvJAQNLWZ795cj64FVG5zVzYtiTTuFzxOS5AwcfD7kV-w@mail.gmail.com>
In-Reply-To: <CAFqZXNvJAQNLWZ795cj64FVG5zVzYtiTTuFzxOS5AwcfD7kV-w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Dec 2024 09:57:42 -0500
Message-ID: <CAHC9VhRFOm9DBXMF2SbwBxZqtPrr5ghbDRqcwjX6TP_79xDT_g@mail.gmail.com>
Subject: Re: kernel-secnext aarch64 builds missing?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: kernel-secnext@googlegroups.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 9:17=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Thanks for making it work again! The aarch64 secnext CI runs are
> passing now. I'm not aware of any bug that could have caused the
> issue, but it's Rawhide where unfortunately even nasty bugs might
> sometimes appear.

No problem, my apologies for taking so long to get back to it.  I
should also mention, in the interest of being fair to Rawhide, in the
several years that I've been doing the kernel-secnext builds for
Rawhide, I think this is only the second (third?) time that Rawhide
broke so badly that the systems wouldn't boot after an update.

--=20
paul-moore.com
