Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DDF20127D
	for <selinux@vger.kernel.org>; Wed,  9 Jul 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078000; cv=none; b=VvwO1imMLlfGqoMNW63fVFqpb2pcmSviMadGV/qPmllMew01YpmUq2yLpEb+Q3C1V7jw0v8vXRAD1IhvT8Z88OL6ArCgLhYeIrmeV67pXbA69WeKXT8Fyky6bn6xhdR3Eqru/lCOgVHOACCPZxSsbgbR5R3h3VM25zJvbXgxdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078000; c=relaxed/simple;
	bh=+cxQi3ynMCKIkfOyiXInlVFSM4ntWSePp6VeXgdg6OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohrC+buYX0pJlNrWe9QH2opygKlt+ZvUyMRd0nFCX0YdDAYhL9PZC8mwJelm9ZkPZVgtoaT9XFKGdHFt0Di71zkCn567Mo0PK/FiiE0ZBI1N9VS81Zy7oeO/9zR5e7OvWkMtEY9U+Ci0o4qud124u/cHXkvawfAddQkW/5ZOP2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nc1pcX4w; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nc1pcX4w"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e5e6ab7b8so1171587b3.1
        for <selinux@vger.kernel.org>; Wed, 09 Jul 2025 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752077997; x=1752682797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsgzY8xfyshJp6kedWcotO9EV3maLpm33bT8sc9VD8Q=;
        b=Nc1pcX4wGuOnigE0ZITLn08vZfPPTiOcHoF0gYNshRdaB05Tg+JExxGabHBL8wpS8x
         GeLX9gPoJ0iT3U5bFZlXnR7s9KEr4Sak6rbfRTTllp7DKsyX97YtWaQ2ph8Wah0plH39
         lujzBL7D+fyxf4AgQVuCwcMUIgrOYDlUdW5etKEFEumj7ZmkDU5XpbzBMnNVzg8/eo0y
         J0+2HMXONuf847r/d5VcfjJBztmgQyHSNyE6KUb0duMs7MtmNUo8zCqxR+6b0FPg9pTp
         TBjtwnkaFKh5giyx940rrENQvotxIexgxiKoW3paAN3XGgNNcBoLT2gfooHhL+0NbOIG
         as+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752077997; x=1752682797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsgzY8xfyshJp6kedWcotO9EV3maLpm33bT8sc9VD8Q=;
        b=XVtuBKDZldvXrgxe5wsV24PLEglvy5cf9zd/TqNvVMbW3aLVb1PRdMNtygdMEsG+zq
         I6zBXp5OR2aD8Kws2sqOy8gQQZWMGwd9lhYKMJky7HL4B4Rqp48PfE2cxYAcBjvM6cl9
         XCNX0Qk3t6FO/Nudy+Nek+iJZ8zTtlwvO0+oJJ20kGa7y2sPnYXOnczEAjVvIXD7eO/G
         ybrQwFfT5mbys3b8ZZ1BSsYvoH3T6ce9GLWpQFkD4Mze3ZTdd9Jc9/x+19I2hZKmz3A0
         eh1Ka1+fVLG2Kddb+7Wtk5vPyzJ9316Vkuq2l94b1o139eeGSh1jAteKX+Hhsdra6kZ3
         nGoQ==
X-Gm-Message-State: AOJu0YzgSpEUiV3rmKxtasZd0Ipc7Wu13RzqK8VZtOQ8CpsCQ+nm+bCx
	jcQghjYq9noRGfCa12A76fLF8wE5mNHQi+U2QoLy2qKvjTiGA4M+j+pq0SvWiN3XfdvYqlNb3Nx
	mW66Yl9wb1+G+0yr3wcmTBtIKwM3QBgX7o7qzPd/Q
X-Gm-Gg: ASbGncv3f+vnvjTJw6aRQKwLgAN4H3oQ1kqWYoyHEe16i14P3sFCSdXjqUB+ZaL3eIE
	PNg26yLyChvNwBO7kidwc9YPKaqAP1ScVQAbWsuYw6D2fpjkq5MCjEnFoVF6m1mu7U6GYaJ04Ih
	JE2R7R50Mwrn7/H+c1ERFmJ7AJCriE9aYXOQrxf9SJl3M=
X-Google-Smtp-Source: AGHT+IHG40ux+6d3CwX0DjPimkJlhtJAcy5EtrUo0FH3EnJWwQmsiTnK905mVLDl19vIf1tgkVyaa7OVMjQScPMgmzY=
X-Received: by 2002:a05:690c:ed0:b0:715:969:ce31 with SMTP id
 00721157ae682-717b1a8bfd6mr49769027b3.35.1752077997306; Wed, 09 Jul 2025
 09:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708210748.8782-1-paul@paul-moore.com> <CAFqZXNvDNAtukRPhKFiQmN+koHOevx75qGCK0uE5nWX+afTPqw@mail.gmail.com>
In-Reply-To: <CAFqZXNvDNAtukRPhKFiQmN+koHOevx75qGCK0uE5nWX+afTPqw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Jul 2025 12:19:46 -0400
X-Gm-Features: Ac12FXwAyIiZ9iT3yqjU718kWVCoivXBw_iWrLYFGPjN_N_n5xs--pcNtbqHHHY
Message-ID: <CAHC9VhT=BG_3H=JAuJzcWKABM+eHBZYRHjVoeomRnH0OHkR28A@mail.gmail.com>
Subject: Re: [PATCH] policy/test_secretmem.te: add anon_inode perms required
 in Linux v6.16-rc5
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:35=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> I'm going to merge the patch with the extra permission dropped, since
> it's a minor change. I'm also going to add a Suggested-by for good
> measure, as Shivank originally drafted the patch. Thank you for taking
> time to formalize and test it!

A more careful reading of the other thread would have shown that
Shivank and I arrived at the same/similar patch independently; the
Suggested-by: tag in this case is wrong.  If it was the case that
Shivank drafted the patch, you should have contacted him about adding
a Signed-off-by: tag since he would have been the original author.

--=20
paul-moore.com
