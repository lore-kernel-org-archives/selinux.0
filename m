Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793992499;
	b=oZpW4BUdEFdxom1LqZHg6QH4uvqXuRt5wW67bUMjzIhS73IfDzhk12wI6y9jMENe9a7E
	 AiTo6mkiyWnqpbKd7vgCeCT5BJnpaIbtlx7o0gqZ4UvUv30TSyLFAuAwqTDOd7EPvLcRX
	 kDJ4HqRfezfMZ8lVSILpHe+OHDmdDUtXkvbla4dk3WzXcl8u8YwXCku30WKRT9vdrlUXW
	 eirP7/5RWzTqn2J1BAhn4iOanMO+uXOVuQD6NJfl90BGAj++koebHSTpUxLXh8tNvr9dW
	 T3TWE4PPtwpIhkTe6tf3Oivr/6TaqZ1PpEmbPmmLnW9Xa03udGmmUnZF3lSDtSQebcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=wfoh1HvPu4wNHZlTFnCn/rHXnxOmUE0pg3iVhjAbsw0=;
	b=Mdw9Z2Tcmbh1iV7438aHIhHakfIDz5TnQwpAnwMFKyAXB7/jtsJGYtiXdIm6H5lG9ThU
	 XejHIdIVjcGwJ9Xo/gt9X8oqaLVebC1SlvmTJ2dtD0L9+Yl2gFxJliZ4FnkB0t8iS7SKN
	 MyNrxJkqVtX+6UAAn7DBHrjEN/fd5XhdNjsoMTVxyXQRYlgOVwvWThckAD82te9WxXPkW
	 VTEjICaTB3jacZg8xwP8uuth8CNF/nd4iIj8YgZBBw4mChAc701v87jl15CoA5dSECaVY
	 Z+I3ezhYepSXEaWEEhbw4OYUCgqCkaXABRKRseGzWXXnfactzQ9jcPBvd24Qmb1wjvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2GAMEVG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BC606A333
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 670BC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i2GAMEVG
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b309147589so9574047b3.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:14:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793992494; cv=none;
        d=google.com; s=arc-20260327;
        b=qvLVVpesj31bG+g9Mx4fVWwINp2PjoKxIuuC6MWTq/uq6//iCfpmX5nLIuhlWoSQlB
         FlDzdVGGoI2E1qJPaMkJWuqQ2eJu52NkfSnhVi1O2K8dghvcC18BqM3jX9fG/la1t1DC
         VUN+9En/i1aKnM+wShJaqIqj+ThBUjo7+OogENaMrICQfRj/9nDShRl37Xu7iXp4c+kL
         tdO4vdErwR9LJREtPmaG3qHtMjUCki9G4SR3V7TlZbbbo3CGRHZwASAtU/ZDPUuUIy/Y
         OAPhwZ/3Jp+QcbNcuTop/v1vdQpeZLwJe6o5l26d3wUCtXYPfHPBXyqSAsgqN8vkuDm+
         t6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wfoh1HvPu4wNHZlTFnCn/rHXnxOmUE0pg3iVhjAbsw0=;
        fh=JHL+dlBtetZKWAunLGWKbt14h50PoOUW6V+T78x38Ms=;
        b=MmMx/PFNKenvntf5E2YaEp3ULsuBO4OnbJ1r6MhBpHva9vzmF/UVoMSM90u5Zs/2u1
         y/cRWJKK8YnfVd2roN5/74/Awapk2T7GcpO+jcBHxb1ujwuAgE4aJ+cze4LMyLoLakCC
         hP0dmgVGwQavH/LphW+KRFVOipajYyYO4XrTW7Zg+7GDyOzfI2xq+jxouA+rN9f5DlI0
         HkEii4TUbjmXmZ2iiZPw9sQqXgKWLpVwCvLY9RLdzCjSY63iXS4qpWaAkMfcL6WX6n74
         ylNmRLY4o4m4wYrjouap4MNtBtohY4iroEBBRVOIW/rzXIeNeE57xRy6LNJ77DvLHYdn
         DvgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793992494; x=1794597294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wfoh1HvPu4wNHZlTFnCn/rHXnxOmUE0pg3iVhjAbsw0=;
        b=i2GAMEVGX8W8P9z/TrGHxbDrvBBhI2Agbr0B6z/5NbryZwaAKX/fQdYMLi43IIJbdG
         o7GVyNnR7usTax4V+wpLWml8eesnhWpVgQfp2uOIroVDI1K3Unfr1RNdZMke5oUkBAAk
         8MIM5L0xtXqt6AUeVHMdLDZSqfeNniFVDlctx7FpCj4RqRlmnePOIJ9eSQQWxNjIW9jN
         EW+ThXf7/1DQJISxrFkBgnNcyJsXshU7zR56OMPP+06KL1K9QBll4xtuRsKfxT/Akus1
         0bz5FAoxbkqqGnaPbLZOhTfouvgqeYfWka95YW5P1rg1Vz+yGlzG0RXqPB3eO1zzThkA
         u1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992494; x=1794597294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfoh1HvPu4wNHZlTFnCn/rHXnxOmUE0pg3iVhjAbsw0=;
        b=BiSA3t7IPJOYjYAQ2QnI3SkmyRKDQPdSWTcEmNw6FUnmfAQh64JPdWO6ActaF/2cPH
         ihzwv16o0uJZdCZD0WnwBy3SPj6kPz61y79I4u09TVZDFaXEA941BL5xTtZeJ3mTCZBa
         0AqmDUbBAjKU1tQt6Du+iqiDHmPX1WRwQ79w0AB4r7DA3R8OD8FXT1en4pABZir9lApB
         CMFAKrFl8KDE13pA+IbVQc1GdVRiyGtQNJj61jPS8qNtfnoNclw0PcYpXoQ2KG6i+JFU
         F675h62TMgXD2rngEzP4pofa5jwQDCHUBbHoOdBDH/xA6fZk3CY7X8qzzJngoFd5jeE7
         /GtA==
X-Gm-Message-State: APuU4Z8iZvcOBdRs4UDQknJNgeylZxjgeGJlB8ELaUeouI5RzY6Rf25S
	j+2W6httUETxBsJfAmJnxA42UVg+UyIMWuElnp6mwQ96Q2ulY0fhF3Fc/W/Ccs7wHtPdewsTtTa
	fOBH96Qu+duzmcvbbzmxttqeeZ3tDMUypWwOZiC8=
X-Gm-Gg: AYBFou0E6ygaPZ0YvvPYg1i6R84C7TqBdhhXfDvANs4zwzlWdVGgr4PYYl0TEpJXF4G
	5ZknGQCVbdM/muCpWqzqZputhqeV75vGyk0nchyzgbDZI9EK9Vr5oskwFB1LpMtuMSL87TUlsRh
	frExH+ARCRUwJ9JezVcf4G9m+N0RrFsW6RjWijrCpBO/kwFtWrP+oKXAFLlRpmt/p+QLghM0vYC
	eUq+6ehqclC1aXkRx8tiMysTIDFMp2bcoXUhudLH2ixeIZrPC5ttWMPC7CT/hBC9XqXw7gE9a4x
	S2CN2OlCBFDFZpsAiLyJoqBowLwc7ve7cEXTA9nkKgASTtVeGrzqq/a5YolcoDgpqAlgsl+ptMe
	/cBu0tOXfz2feLaU2XeyO9zSKpoqA+oQ5AcnxDg3SY9oIogPTmK0hzmYnJ5J78bKmXuO6MAcT5B
	YTSB0yEPjF1zbBeyoCmnBcNHDlHiZ4yTJiEQHsJ1psoKwjyuZ9OgMwBS95Nw==
X-Received: by 2002:a05:690e:4514:10b0:67b:eb11:fe4d with SMTP id
 956f58d0204a3-67c14057628mr1534576d50.5.1793992494114; Fri, 06 Nov 2026
 11:14:54 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928142354.17638-2-stephen.smalley.work@gmail.com> <CAEjxPJ6mP-zsHV5Kj+TM1wJzw0_Vw=aKD=cpe9c6sYhD0EVe9g@mail.gmail.com>
In-Reply-To: <CAEjxPJ6mP-zsHV5Kj+TM1wJzw0_Vw=aKD=cpe9c6sYhD0EVe9g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:14:42 -0500
X-Gm-Features: AclHuK8wF1qxYgW1HKoBwePIY294HgBBhyfeybkKQdpVEsdDd0MPR96PQ8PpyZ4
Message-ID: <CAEjxPJ4NhnXzb-47MGjnp+70so_iADXCZjgVTt54DwGJVX=VPw@mail.gmail.com>
Subject: Re: [PATCH testsuite] Revert "tests/nfs_filesystem: comment out
 failing mount"
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnacek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 1:40=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 28, 2026 at 10:24=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > This reverts commit 0815abcd70b382e13592264ce39bf48742421cc8.  The
> > linked kernel patch below fixes the underlying kernel bug that
> > prevented us from successfully running this test.
> >
> > Link: https://lore.kernel.org/selinux/20260928141917.17577-1-stephen.sm=
alley.work@gmail.com/
> > Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/92
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> This is also now merged.

Unfortunately these seem to be breaking the testing farm runs and I'm
also seeing an unrelated style-check failure but not in something I
touched (tests/bpf/token_test_common.c). On the latter I assume it's a
change in astyle defaults. The former suggests the testing farm still
doesn't have the kernel fixes?
Do I need to revert these two again?
