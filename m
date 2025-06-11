Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A106FBF
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670491; cv=none; b=JMV9ZHqXq8pgyG5/+A1RRM5lkdABntVJIxJr0Jr7DMRgsNiZyuwyYQXdFDXkOK5nWNzJdc+ZfOexK8obHsaJnk6SLapKkQj9fK1DXpVx18CyJq9Ev9yvOs1DJrqkS1d9OVDQqkTHPYUjhu5rZ8X/0pq0knPktSRgfdNwQBRYVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670491; c=relaxed/simple;
	bh=i9ZW3w4wayvWL+j4pgsPJuvR+al9MJ0z83Qmfhu6Uu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BD1Dy3JzZmsYIR8TV4DnCxFqxX+sYJhZ9iDENwzlzMl4w1QDsHSeGhkThcNhCmB0nfFMopFzPzVrjUaFaJiPsMmb4t0/NKp4dUiatDJHdr6l1Pu2BWE2/3mFtMAeRiR9U29b6n50vIY+RbrdUiWQSgCWfDe2Zdnd8QP/9YPE6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls5JhQYx; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls5JhQYx"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b271f3ae786so92609a12.3
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749670489; x=1750275289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU7kHo9eyrLxmCSxsGIkgOLPvs5DRGochFwLI7ZFMOY=;
        b=Ls5JhQYxjr/W13cK8v0fvJsSBW5T82ZhGP046ClwiUArsku8phVZj07kc5E7Dl/jAX
         MSF6hWxoVjjpsVfn0boWndwbhwucxNH580PzhOS76PBjJmj8iC40AUuTGW2xuSVxt4OC
         i9pEvndAYrV9oRz1+v4ipYTjcL8x+jgjUZqvhjMr3pfCKGxMU0w53jfbccfEl9YlLEIB
         LljHr5KuI5DpKHXDe4uQtuEgH+DT2PsdXO6c2LrP+s1U7UISBaq3yN6v6Hq+8Gz9v5td
         R0nLWN+8jO80Q4527QOPcdIoRjaS4JCHocfRWYxSwXyXfyvTyin9EJfWmWqiSTRbbVsG
         A5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749670489; x=1750275289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mU7kHo9eyrLxmCSxsGIkgOLPvs5DRGochFwLI7ZFMOY=;
        b=BZL3PEM6gipJTUBVAfoJfQn5d3SY0Xd8E2aKsWanacKaKedSLZvbR5EJgrSZ8FXr+5
         c1Z3ah79d7kRZORWK5eC+7tICOWJ8hs7kY0bKktrWvQUvSkzh8CPjTTCji31FEY+t9Ml
         L/9Xs9mryQFhpsNdQKT9lDCWAfa5bL/Wgt8DVofH+4De3BX+Ki/apsqV/lwQVRszk7qj
         xZBU658ENKYqLsLK0+VQEwrn0/251oIzA9HwS3Fry6r0GpWHuhkw7sNVA3W2k5vyZ6Rg
         sH3MMpBDiLqjCJ1IPsC1bRQbnlshM/0kJ0UizpAYYmwk3MT3fCGSRGc95XMqPSD32i/a
         A1kw==
X-Gm-Message-State: AOJu0YzN2P8bLJybW9AlJqsoZ9aaqczRv+vKg7l7lnhqlTP+JGTOjR0X
	9x+mY0wNOsYXIchv2aTQilhBhOM4sTTfJipu/abDMrnXi2ljLQcM5iJMabaaCmenwkRpISGF5qm
	9d7rQic8ahCrUISpLisFFOY0WyKpAEj1Mcw==
X-Gm-Gg: ASbGncsmPQ07HE9yHZr7UzIwZg7s4lV43SLTqqeW2jFc92g0f012Go3uekhKHH4azLh
	M0liAsl6gPdFUetj2j3Szu2JIW3NavjAoSwAOLqVbai/GEkh5B3V446tp2GJts+fgNmRAfjTpin
	qo6vir/ecBRrl8ZC62NZdDN1pJHNdQTyqWvv05ubewt8U=
X-Google-Smtp-Source: AGHT+IE6sfBL4ZdE5oOnegtWJCaAf+2hs2euvS6kVgGIceDEVqSZ5//H+GKlXw0GZisz4saMdedmfnBqnh7akaOW6rs=
X-Received: by 2002:a17:90b:4a50:b0:313:220c:b63b with SMTP id
 98e67ed59e1d1-313af22d4eamr5874007a91.35.1749670489468; Wed, 11 Jun 2025
 12:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
 <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com> <CAEjxPJ7JAJ2aypxVyjw4KKAvGBvUVK6eCzbXF3Wd8huTSPiSFw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7JAJ2aypxVyjw4KKAvGBvUVK6eCzbXF3Wd8huTSPiSFw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 11 Jun 2025 15:34:38 -0400
X-Gm-Features: AX0GCFsIwGV68bp6hNn6nZAXMaZOXRC2-bfGZSajC3DNKm2VBFdnr-T4SdFYxE8
Message-ID: <CAEjxPJ7YixhZOmHVq92EBVoXO5ZO9__YXhhyD7iAWMkQNV-xsA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:25=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 11, 2025 at 3:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Wed, Jun 11, 2025 at 2:34=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On F42, iptables and ip6tables are no longer provided; check
> > > to see if iptables-legacy and ip6tables-legacy exist and use
> > > those instead if so.
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  tests/inet_socket/iptables-flush | 20 +++++++++---
> > >  tests/inet_socket/iptables-load  | 52 ++++++++++++++++++++----------=
--
> > >  2 files changed, 48 insertions(+), 24 deletions(-)
> >
> > It's been a while since I hit, and worked around, this on my Rawhide
> > systems, but if I recall correctly, fixing the problem was a matter of
> > installing the iptables-legacy package and perhaps ensuring that the
> > "alternatives" config was set to point to the iptables-nft
> > implementation:
> >
> >   %  rpm -q iptables-legacy
> >   iptables-legacy-1.8.11-10.fc43.x86_64
> >   % alternatives --display iptables
> >   iptables - status is auto.
> >   link currently points to /usr/bin/iptables-nft
> >   ...
> >
> > FWIW, I think there is value in testing with the iptables-nft
> > implementation simply so we can test the new code paths.
>
> Ok, I had iptables-legacy but not alternatives set. We might want to
> note this in the README.md file.

Actually, I had alternatives set to iptables-legacy but no
/usr/sbin/iptables or /usr/sbin/ip6tables symlinks for some reason.
Switching alternatives to iptables-nft causes failures during the
tests due to "Extension SECMARK revision 0 not supported", so I think
it has to use iptables-legacy?

On a different but related note, wondering how long we even want to
retain these tests and the corresponding config options in the
testsuite defconfig fragment. Ditto for some other config options
there that aren't commonly enabled anymore or may be blocked before
too long e.g. SHA1.
