Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CF204C20
	for <selinux@vger.kernel.org>; Tue,  4 Feb 2025 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698030; cv=none; b=QMfs5rvBpUq0TFzS52X7hUHbeeJRUyiB1Dbc77uzZgavJ89a3erdKLoC7fRJva9Uqw6oXXREnKL56z1GvWYL8QZOxIWkiS6TcwOVjsxqndZ1fKZ4g9Ap2cxsjXDFrs/4rxLmRn5FNTmFRuFmsf4gdhuMgxI+G2f947u8Tkuc1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698030; c=relaxed/simple;
	bh=cdGM8kH/xxgAF7oW0/bgae15mno8ZQcgJPZlTYmiWZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ON0VJ/dHj9qHn06hJN0/sZUKdcDBXMmDebUsGAzKo3aYyQcxlYgdnIwIL/qsPCoqR5Cvcsowfy/PK4IsoYXlTaPhZ+UDDdluj7DM9fsDuslNoQMTuBZUMmedOlHiV1SI0pD3+n/WL+f5WXitrRJB74C6PG+RBJqlqqbjbDjo0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d3NXN8oF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d3NXN8oF"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f9625c0fccso22756387b3.1
        for <selinux@vger.kernel.org>; Tue, 04 Feb 2025 11:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738698027; x=1739302827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdGM8kH/xxgAF7oW0/bgae15mno8ZQcgJPZlTYmiWZE=;
        b=d3NXN8oFQqFBWyO+ks0oq+4M809qaZyO2jGqGfNsN+VoGNYYz+0QTB9hVBW2tvpugj
         H6tQTAqBdL+XeCTgwyrQLw933fsmCeQlO5WqYByqTvC58P/OKrqSWE9FNsLgr4yvTmtW
         6qB5rCWqD/xjbcoOP62icgHlvlKltiSlGxAIoSMTgrtodd2F04Z8n3n3/vkO1STlTdqs
         BIclB0A6qCDQFaTRqzJxYXlXMWkjLAJi5T7df6ZDFPrNbdHWpxS3iqQMdRkZmepAJIcT
         d5vjFHA/F6OfdSdyMCYE882LjZFNsZbR49XLtD5Bm1E7k2NFMN94OppGJ3HVbdnk0RFI
         cS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698027; x=1739302827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdGM8kH/xxgAF7oW0/bgae15mno8ZQcgJPZlTYmiWZE=;
        b=AHdraD9AC+Af1ug6N72N+NtQq/I/RlSYItIDAiBvfaqWKPi4PLGR01589iiTYcNg58
         MVWOJH0CqoqT4xF+iMzXSdycJXCMevNWzVfnm9LztQ0lya5CDjinbrUep9U0R4Q4+146
         EeKvwd4ujJbrxJWuoc1bHP62Lcy6wla6MMNEg8QvVs02KQmJ25IAdPnHOJpcqcZLjmrN
         dVX8FcH5Hd1dbEbwhh0bXG4CdcCjITvbch0xFSt1S+Ke1oHHw6fNBd4MhIBoqHVA4NpL
         TCPZ5NNJHG9rPCLYDgyzaOvZ3yE90wkgZU7r4ve3ffAlsMz/f7oIuhV1SNxJLwFeYbA2
         nHtw==
X-Forwarded-Encrypted: i=1; AJvYcCXWzZ9N5T5vty9vr6x+up3gHzKkYWRtFSW+URaGsjL4j9C7yer68IWgL5T1k6TXQtVibk0f6pRg@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRn16Q0rK/hlbviCpkz4Hif6gN/9qOjz0jS8GeJRuyvepkqIr
	69ncVuGpLYFEXq5RllDSFGb/H4ZI/kdjfArzslSeuyAPajpGaRzl+4Zm1kMhoJv1OxuENZmCHYw
	OCTqaFEsqdwBzAKOELrqFFgHHlGDjPeFCEXGH
X-Gm-Gg: ASbGncs8QOpp2ybvEW6Y3bpCnZMUT5O6bC0AKRrs0ouEtmVx6BEqhFw9bFN3G1EvlMz
	9MnV7dAMSZYTmv22b8KBJ8gS273p+OiA1SEfWEl3Pw9vSy58GHnRTFKQFjzAgx17LbMe5/no=
X-Google-Smtp-Source: AGHT+IHWFCt3o0biOX5PlAx1Q1W7sOdakfYdrhJja4liqbRx2tgJL0CHhFhrdJ07R5vN7YVhHWgWbLaOhNespI1IhNc=
X-Received: by 2002:a05:690c:4681:b0:6ef:7dde:bdef with SMTP id
 00721157ae682-6f989f89aa9mr771557b3.23.1738698027698; Tue, 04 Feb 2025
 11:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru> <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch> <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
 <67996154e30ce_d9324294c4@willemb.c.googlers.com.notmuch> <8b81a534-9c30-4123-bd7d-bf3a9d89dfcb@yandex.ru>
 <679a376739b99_132e08294f3@willemb.c.googlers.com.notmuch>
 <04879909-72e5-4ab6-8c28-5d3cb551feb5@yandex.ru> <679bace3a753f_1d35f32942d@willemb.c.googlers.com.notmuch>
 <CAHC9VhS-uSaVmy65oA8p6tCzMZxMsuzdmxO-vf7L0p44ZKO=_A@mail.gmail.com> <CAFqZXNtq7SZSu_JyY5yaiOQy89c=5jG+vqdg3_RSUWm4JNN00w@mail.gmail.com>
In-Reply-To: <CAFqZXNtq7SZSu_JyY5yaiOQy89c=5jG+vqdg3_RSUWm4JNN00w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Feb 2025 14:40:16 -0500
X-Gm-Features: AWEUYZn2hhrCR2-AHfRC_KOGhFrEXsKH0qPJHGGH-UvtSfO7A88HAuI2_QqeHyw
Message-ID: <CAHC9VhRF0bka4zY5y1uNYUGXNSSwz6cdta+c0NH_YDO0MxauRg@mail.gmail.com>
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, stsp <stsp2@yandex.ru>, 
	Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:19=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Tue, Feb 4, 2025 at 1:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > If a revert is the best path forward for v6.14, do you think it would
> > be possible to get this fixed this week, or do you expect it to take
> > longer?
>
> Willem has already posted patches on netdev [1][2] (thanks!), so I
> expect it will be fixed soon.

Great, thanks everyone!

--=20
paul-moore.com
