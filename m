Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1530BB80
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609069; cv=pass; b=ZRuSuo4nN4N6YW9w4aV7NsSy3W+dmHaZ0WRUlbSKp3lis3Hp5svLFY05IeslzLEj3MuGC01qaxRDR7gGXcOU4SnnafrW5tpZYSx/rj2eEMjJs2sOAl4RYAId6xpVzSRUBH53+yB0ybOAZLkuHQpm7EEL0HnrGVcoVTgrbm0SXEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609069; c=relaxed/simple;
	bh=bPtTpK9GlJYyojwGcJMMZ9ehSbG2/0bmPRf4ZzwhV38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo6nPsSDoF/6UZhCXBVOXBVGJIjIGVarn3DkQSODy2JFWmL5KdWavEHMVRgMNSLJmGeadULB71IaGNZR2868qa1Hy/DgN7L42c/CCkMZVb5uJlwaCc50u7VYXgCDf2SCp7536Dxwfxp1t27s/HujoYg0BRXYlgI8gtVbI/pg3GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR7QJR2f; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR7QJR2f"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba21d32776so39631405ad.2
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 11:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778609067; cv=none;
        d=google.com; s=arc-20240605;
        b=A0ePjXfjyaFNeYFJYfUJfbGd5zC9ZApUuuQ5aiplcAVUmjqWBcKBBaoLtZnpVgTfm8
         Je8Wt7njeRppGgX4URZKBFfsnoRwFgigJ5ZlnlpzW8oQie149K6M/xG0cq2p3vNHlbzk
         6z5Dc4biglFHJYkNnoS9FoSnUxjfSf+ZGzbDqpoPAQ4fI2zjbgQRb6L3eBVyqhm9dX1D
         qImjAjf3WH/hM8PEBP8UEMIX816rCHQyJ1hTgYjObsVWN3nKX28K2HauOykleMVgdKLb
         ttpB8vfj6ZJHqruHYAgsaTLdastHWLltXDd51qanOQZ3uMsS5o74NjoZ+FuZXldbRojg
         WDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZTiBlcJHEh4RdQ3Uuqc4+N3/hAXv3QgIu85nwijBRpA=;
        fh=PQ9c0cqNZEx8z6DXNbb0bdcSA3mtTzKxO1NP01n5Va0=;
        b=FA+tdAV+GhgabfvIuiqIZ7uQX2yOqjv/9rDFCTLx9r6s6mQRHth1fVRPUtCGy6Z7La
         VWJu/4/eh8lMpBORAHTQCKyOgxLXK/u95QtgFPcy6QDQuyrtADC7m8CXO1cqv0OeWghP
         xWoVmMwvrlLoMLTMF162rp6PynW2ZtPvrWFjpL3dHO2qVb9OuqtWOMRVBrGJ85diDPI4
         lLX+43Rje6LCFYzgImIidEQqZc9uIkgjWDee/WgQsWCvaCn6ZTsyUhn8maRIDKHvIU41
         S4Cw284HyCRRyxpvONFSS7t9BHHbnPWpzwwQNfl4F4IUO76ZDf13YriBQ5KbVNYarAaF
         2VSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609067; x=1779213867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTiBlcJHEh4RdQ3Uuqc4+N3/hAXv3QgIu85nwijBRpA=;
        b=ZR7QJR2fRKjCZ5W8QKGUFH4yjO4CsB35u0GEJ/PyVLOPNFGW5tDnkRiewV3yIYrCYX
         y2kRty3Nxt4XpyJzbQaRQr8/3wtvg8ZEI0E9G40qTyU+J+svV74qzfopajsgEz4f20eG
         wEu1O9AqZV2vwik52bIKpabcOMG7QtvyA9zYpIjoVHHEGWhvzG5l3d5e63qOYkqbuceS
         jsBcwunkl85A9HNTdqL2Kqc5RkAtUGQqv2iMxyS/9PDGCMI95Dv0UunqBfkuoaBjFpM9
         aSIWrh+R4q5Oym8LwCtMHwNdQNBDdynCjSpfxwd449GK/ZtAdRVLsEMCH76S24fyWmjj
         NQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609067; x=1779213867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZTiBlcJHEh4RdQ3Uuqc4+N3/hAXv3QgIu85nwijBRpA=;
        b=RYX2RcycO4C5taxNE0iwYSf4KOnn0d1qTPKAXPAG3g224Aws0ZYcNziTA4iY10Ygyu
         9ySKBBgGtgFp9W7m9RhDySZApJHu7yQABqjeCCWyTufT39lv0vHJtYMAhHSRhlZOUTDg
         Kf98lWMrs+WM4Plgd02qvex/j8gj8AmlGQfvgZeaWzlH1up0j2UrbiTat7KXD1wFTB0S
         +mlpgOXSt3zlwtlaQYYUKhwHHAo1OMP4xMOj/3Lv7UsPsFgeCaQtGSERvedxdEgAC+wo
         2PvFj3WYKFKkquMHYr8AyiS5yDbOkrGst55Jb0Su+GZTHmLTt4I+I4SG6fQEoriuvzk1
         5EfA==
X-Gm-Message-State: AOJu0YwRvD/+2mh5NEberzHsc6xqUuwrTn+vKPxlPxg3eXgRbbVgkjVk
	t1BNMW90CKCtB/DR64eXajVIKT/Y6enkhnTmHrC4aX8s+nGhf9Icp5TCoFUCg6bsPwGZFY6jYaD
	6Ru1ymXPbVOwtmc4/DNORiV7XnGQTby7wkQ==
X-Gm-Gg: Acq92OGbdW8kxoTbCipNp7p8AlOjLIaUrNjEmCzwu/1kPaVIFPunoZcQnXTMxfgCSyE
	cOsvqeTsx4n7O51x4rxYSJyfSVxCvdsQKjBoe71+zH0R3b/3HEnNw1V9wVrxC3hv4PvnlIT5bRB
	SGYhvcCkhNIM1ksssxta3+7tfZNg1FwqmoSp2rOr38NjNrgKXM9pGAZYurtINRV/Q4elHAdrV3Z
	065yKKiuFciPaknm8anNzdS79a2VgyQd6hTJ5mxAs6SLyzRmFcW1oLIpetN+VvbH8u8vjSsQPgI
	R+Jkvv8=
X-Received: by 2002:a17:903:22d0:b0:2ba:4eee:6c1e with SMTP id
 d9443c01a7336-2bd2716a288mr1273515ad.15.1778609067136; Tue, 12 May 2026
 11:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505140637.2468-2-stephen.smalley.work@gmail.com> <7bd65e903c99f25d9e866f7d5f097973@paul-moore.com>
In-Reply-To: <7bd65e903c99f25d9e866f7d5f097973@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 May 2026 14:04:16 -0400
X-Gm-Features: AVHnY4I-WEZtMgTb6NlpoEWcoi2MmOnj8VCeaTG-XCYSwANV1V1Oo27BP5fY5hc
Message-ID: <CAEjxPJ6H57nUSqg4yO49+U+Hku_1GgVxYSj+z+gMToH1g3v9bQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: allow multiple opens of /sys/fs/selinux/policy
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 3:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On May  5, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > Currently there can only be a single open of /sys/fs/selinux/policy at
> > any time. This allows any process to block any other process from
> > reading the kernel policy. The original motivation seems to have been
> > a mix of preventing an inconsistent view of the policy size and
> > preventing userspace from allocating kernel memory without bound, but
> > this is arguably equally bad. Eliminate the policy_opened flag and
> > shrink the critical section that the policy mutex is held. While we
> > are making changes here, drop a couple of extraneous BUG_ONs.
> >
> > Link: https://lore.kernel.org/selinux/20100726193414.19538.64028.stgit@=
paris.rdu.redhat.com/
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v2 shrinks the critical section that the policy mutex is held and
> > removes a couple of extraneous BUG_ONs.
> >
> >  security/selinux/selinuxfs.c | 27 ++++-----------------------
> >  1 file changed, 4 insertions(+), 23 deletions(-)
>
> I agree the single reader restriction likely is doing more harm than
> good.  Merged into selinux/stable-7.1, thanks.

One option if we are concerned with the kernel memory allocations
would be to save a reference-counted copy of the policy data when it
is first loaded (or upon first open of /sys/fs/selinux/policy) and
just have sel_open_policy() reuse that rather than allocating memory
and regenerating the serialized policy on each sel_open_policy(). NB
This would mean however that if the policy data structures were
modified at runtime (either via booleans or kernel write vuln), that
wouldn't be reflected in reads of /sys/fs/selinux/policy.
