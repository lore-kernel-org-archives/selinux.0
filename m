Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1F7485
	for <selinux@vger.kernel.org>; Mon,  2 Jun 2025 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866929; cv=none; b=NnOOqjyURRefeNKSkNeza6K027eQ+POyRCrlWW0xdp9bBLtDJ94904D2ZNiJ/4Ppbv0ecwsFSbSG594X+y4aXNcAnr8FWczuv5JcxkmuIzG2XNjOPzvQhqo9T7zzbp9ja/AglA0tMwVo6huoUtlgGBBCqyuZ6hWeUovPz+elXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866929; c=relaxed/simple;
	bh=vf9TguqNZ1Sh9W0g0k/OZnEGDF9w7y2GNgv+GzGq2+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klOBD+ksPZC6epTYUg2Rxl04+yEYyISS91wF8UY1stvavCXi/MLoCL0AJliw1altK0SPcUhuLC0Xt37uJEI0jsFeM0Nl8o348t125X5drv/hG1Jtqh+4wgE6HZ9cwwwvgfIehyHgsBPM/7rT9zy2zKw/AVQ1KOxnntBPwRpnat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2SjpDfr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2SjpDfr"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso3310033a91.0
        for <selinux@vger.kernel.org>; Mon, 02 Jun 2025 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748866927; x=1749471727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf9TguqNZ1Sh9W0g0k/OZnEGDF9w7y2GNgv+GzGq2+k=;
        b=W2SjpDfrAIKQHET9t9Mqx93eaL3+9o3iiRB/IsTshr0CO+Wpx8BOCMJYix/R/TiBvO
         gAxtmTtMhlPEPm1/ko4W6YcnsPWQ3eDsenamxSPZPENbAN1GYYMIGTXsUy835Ciaa95y
         F0ZZrPxB3YtAOG4r29nasN0RZgiuZ7teUSWwt4XS/ugG9g5ky/vmnshAE7AOR9ZvzMA9
         +YM3kqJCm8MzH0TBEuzO1uwvFhBBUDFpm8OGbzrBp3P+C84KeKfN9aNjterK2Xbv3JMz
         gxmbaL0NvDu51MW9BM+kaHj0Q6lq4SDUd9uJDc3OsPSuWKgoynoYFXe0ux3xcLdsBpkL
         YqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748866927; x=1749471727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf9TguqNZ1Sh9W0g0k/OZnEGDF9w7y2GNgv+GzGq2+k=;
        b=PyRnWpMpQsQY7MgFTa6caelSyPT/0V2Us65iXusgqmk8EmCFNjSyhpAa8tpexZr4Dk
         R4swpB61Cu2Y5VuuRBOh/HDaHxrleWRDSqkQbFu18lF4Uup4ZbIT1j4Knx3Z1J2DJluO
         1GJve1/8YxwrciqidN7OP/2piNxYFa9w/NzirNQ3U+pdD6jdsOW6fdubeWJXW808nOSR
         GmcknovB2WifALAhWpPiijAJu4gxiIQflpia9gR8BjGBdO24254jgN+aFFpSUtWHB4R6
         CwSHwn4z2AtGSIzZpf1SBikb7MygIhUuA1D8DEi7OVgUvTzcTX1S6bxIYw+V5uF7ZxN1
         bLfA==
X-Gm-Message-State: AOJu0Yx5ZawZFjwTf5wJm1rTQo7/E/hGmrEp283NWgmsAxmQthc4J900
	KzJwKWi2ZygUNJ5w4xGCToCZBeVIap2ZNhPNxtffiWrTgChb6o2DKvpvDh4Sb3S1tFtOw+Tyk5p
	J6xdwtbrkYtV49JxLBnXcaUGtRD99dMZ3IwcZ
X-Gm-Gg: ASbGnctUxUTTpb3B6ByD40K0pQEskIz53m6sJy8jwOOZSls87YMR+BP76Jlsc/CzHPu
	pFT02pZNTdTpZH1LTm8eIThtfA2KZEP53dsnwsyrgm0zXnYFLt8Mq5uW4aOGjzTdlyoJaUahmdm
	ISi9fbC0PC8w6Fp++dudi1Fs1EO3xNIea/
X-Google-Smtp-Source: AGHT+IEcpOH8Cn7+PCnkB/Con1//Axwn5CNhcHQ1GQ9EuZy3CUQbfHHbXrha/8SK52UpPRKr1yqa6p+7npXfLLnwJxg=
X-Received: by 2002:a17:90b:3d83:b0:311:ab20:1589 with SMTP id
 98e67ed59e1d1-31241532a05mr23672596a91.12.1748866926547; Mon, 02 Jun 2025
 05:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a34cb17-3290-416f-bea8-bd743e18ff3b@suse.de> <CAEjxPJ621C3V3wiPwaYvUVUMs--590iGjE5Q=ZScy3wYuZtXQQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ621C3V3wiPwaYvUVUMs--590iGjE5Q=ZScy3wYuZtXQQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 2 Jun 2025 08:21:54 -0400
X-Gm-Features: AX0GCFuxlx3T79tz6u_Nq90GIml7PAqrnVEVty4Y_nFjCT4W0SwKy8Sg3tUBVFI
Message-ID: <CAEjxPJ6Yin+JiSz9ZHjgtOewEy6xacpKw9KDd=mEfFYnv4JuNQ@mail.gmail.com>
Subject: Re: selinuxproject.org down?
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:30=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 21, 2025 at 7:39=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
> >
> > Hi,
> >
> > I might have missed something, but selinuxproject.org is down.
> > Is this intentional?
>
> That site has been mostly unmaintained and archival only for a while
> now. If there is anything there you are relying on, I would recommend
> copying to the github.com/selinuxproject/selinux/wiki and updating any
> links.

Also, you may find the content available at
https://github.com/SELinuxProject/selinux-kernel/wiki to be helpful.
