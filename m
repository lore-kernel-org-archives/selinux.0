Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74DC2868B4
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824624; cv=pass; b=BPaDXAzTuke5W8SMGolJajNuzSyac4UyG+K7710AA/OWQjly9qAWX36hZRXNFM04PP+FH1YXdmd6lZfZNYIX9U5Ijp3NHC/q9J+p1DXYAEjVrfTl0w0q0o6FS+BRg8+jenPeHI7YVT7pogUMAdYP4tyo+yF17D35CvJFus/eTXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824624; c=relaxed/simple;
	bh=1N9WJNlfbqWYxWXXPCwWvzPYe+PYUl/CABuFBFOwmJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q913Xz9XeLziqLb9yEwudoVxrJ3qLC3fkIxIJ4kZTFr3xWj+ARIoDZeuiHWCOUPXLTfnob4WOHKYN5AS7QzSZNWAowhVHYtjMXk7k5PExvY3BLC5kszrJ3NxZtVEHOrQ9cDAblYkW/reyFF0yQRAEnJGJqP/H9lZZdQGf7UGRKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPjFyQvA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iy/jKuwt; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPjFyQvA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iy/jKuwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778824621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1N9WJNlfbqWYxWXXPCwWvzPYe+PYUl/CABuFBFOwmJU=;
	b=ZPjFyQvATgX/MgPTKUH0pHrw9iaZDyLDj87YAam1JY7j9Oedvhy/gPj52MNW+VUvRpYdLN
	DRzbWeB6SzatQUv0G3EvnlMM3O/9jyPphW2J0fNXPq9phVfX/9uH1m3gC0wpbscvFyi2vY
	y1GlYz8TINr84txBTe+YYGPo7VYPvls=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-ceW_cYk6N0CK01XTgjhJfg-1; Fri, 15 May 2026 01:57:00 -0400
X-MC-Unique: ceW_cYk6N0CK01XTgjhJfg-1
X-Mimecast-MFC-AGG-ID: ceW_cYk6N0CK01XTgjhJfg_1778824620
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-65db7715a7fso15036455d50.0
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 22:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778824620; cv=none;
        d=google.com; s=arc-20240605;
        b=RCqlx5Gt+InDanebiqR2p6YraO+2ufFLBFLRGz9W9SxjGML917yrTsXAEmVB8DH9C+
         pAL7969ggGd/hIJtTG9acp3zV5OKl6qJWUDqP2e3LywMwMa6KgX9/KSk94t1lHLKKoUK
         Xx2ifVZqLTLOAvOgRAX+HVafeRap9LUSWga2aseOz+Epd31ns9KA+YnnV98XRWBv7+42
         5iDkyNlaXJNQFXuOpnAo98wr2AvTorP4201BnjsS4nVl1NMXG8MsHkMWrdCti8M2Z+Ec
         862l7Bz/V9xcC+GpCKlmdJLIay5mKuZFxyPKLsrZB54v655R2sk4komNlIhAdCfR/hzf
         HtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1N9WJNlfbqWYxWXXPCwWvzPYe+PYUl/CABuFBFOwmJU=;
        fh=PvVq3dmv8yvnCRJYSTWWanBfOaJzW2R+gufroGOSnBQ=;
        b=f1GqHgqokPMCdS+LYFHdUtxNFMsqaGhP7SZEP8oiWlsDIAb8+WzWwLf5S6XRXTzxOf
         SVrpHgjKsMRP+TOSM/HPCidc4/RR9rFqa5avrMA3ifbwwxdtWQZT4aKw5FAyrGECx+Hq
         4mNNjuv4hVKDvbwFn/s02nmfoMy1+CkwL+kjXq/8h93cz48cWxWAFR7tfvpXEznx2jR8
         QcXRUSNcbkcvHg1KDJEcvwHksb8eibzhtyC7TgHC5vgbQ8duUl//HL8aqvnYZ5wsRuZ5
         wyYb1A4QRUuqtWlC5k9jaEg3QqB/353ryre2ixxe0vKvpTeXoWgk5W/DN2P8jr2z9x2n
         F7BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778824620; x=1779429420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N9WJNlfbqWYxWXXPCwWvzPYe+PYUl/CABuFBFOwmJU=;
        b=iy/jKuwtcV9wISmKJi6ut3muraKHuHq8Juc+8KRR3FySHarhTfB743L28j76Bkaijs
         yBe3mqlLPZgPmuEgIpBssDqVRa/g/TYZy/Yq0FN8J3KG5Oa7rmDKpXOHfPQnS/Mfavsv
         8B1ETEHDsg08SfT5MAXBtJ+jUeeV7yHHv5Nyjast85PfF2H/hUpKGobm128nD4qiI2SI
         4ej29TDtNKZhuogV13U2kBjD9mw/30LgNjW+mBBCJ+l3uyTORopZstpf385QnqBWt5V6
         PxYq0FLojioVq6U+RnwgYsr/oYnzENA44ZcP0PJ2kK+jPBbWupN0rg1K5Eyz07zRJBrP
         urcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778824620; x=1779429420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1N9WJNlfbqWYxWXXPCwWvzPYe+PYUl/CABuFBFOwmJU=;
        b=P0zOmzShwvEPMKkiyC8kKrw6s2hzvl6e+5cBpvMo4eQrD4OfzzX4tRKqoaV4viEm+U
         5Ck7ove91eWUNcCs1ASQzHt3kU7cmbRdfnzvgo8Qju2PBQs7CcJbBJxL5a8LwJxCpGAU
         UI5Of4LpCIdIF42SvHz92GbkhUN6zXDOjr4rqiv1VgCAYQw+s+Mwz4fWQ7lKEfxePHJb
         ejDnBTPvGfFL/jLUanzQAnH+Zqlw0VfIsBpRsHHz54PGvVXcwthB42gxszT9EgAYp2rs
         MFpyoQ/ROT3WygdaPvwp3heNhQB5F1dVy7qMVWidJ2KuadrZy7ipaElfiPWHJUOMQEDZ
         abFg==
X-Gm-Message-State: AOJu0Yy+niVxeP6wh0oPUIzehjJW+IsufAyKQg1HJEx9ruJL2bGKLXfH
	Rqzys8ZZ/wUS8EJ3M+DcFv/RWkz5e80h8OVnCKfgTBCvxJF1l4tkQaXvRNay1Ix9A0TQIJVtQgG
	DejWbcXe55GHOIwJaB55D8G7zgbmFZxrzg5l6kUWxxVahzglFE1wN6pBXkym/Zp0xlfFAqXwzGW
	D8d1MLsVti2zB9xWxruoTU0pg6EOcAuxqh5zBfnUv7nw==
X-Gm-Gg: Acq92OH//qnY2298/O1XATH/nkETFoRLc+fqYFvS4UdrILXx5lPA4PL4VGiT1MMzyt8
	mUwulrPTYNGO8EAuP9lMxypWqNeM1UUvQsjOOmzK6xKkP7uspsgjtnKlSimGnVqmuDkSWiq+YUQ
	zp/Ed88MUd9jx2XXOKh0QIPBYa0cEgHFmNV/m4SZl+OeVEIbXXjzm5FDos6A46gGVqk/Z/74xoI
	yG5GA==
X-Received: by 2002:a05:690c:610d:b0:7c7:5111:5f05 with SMTP id 00721157ae682-7c95caea271mr29099527b3.48.1778824620161;
        Thu, 14 May 2026 22:57:00 -0700 (PDT)
X-Received: by 2002:a05:690c:610d:b0:7c7:5111:5f05 with SMTP id
 00721157ae682-7c95caea271mr29099377b3.48.1778824619810; Thu, 14 May 2026
 22:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOssrKcz2w1A465OUGr9jnWDAd+AN-Mt_AL_xxuWQOqAz8PRAA@mail.gmail.com>
 <CAHC9VhTzDERE4phHRXTOFmaRJp_xuX3HgGwwRU0sxJJierPUDg@mail.gmail.com>
In-Reply-To: <CAHC9VhTzDERE4phHRXTOFmaRJp_xuX3HgGwwRU0sxJJierPUDg@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Fri, 15 May 2026 07:56:49 +0200
X-Gm-Features: AVHnY4LOoZPPlj-04icCXH3v8hpRVc9RSjaAQpks9YHF38FFDLFIDKjXSSys6m4
Message-ID: <CAOssrKfT3vojCZheoR9R3KR2qZ76b4Ob4SzEPCb3K=oYP2jVqg@mail.gmail.com>
Subject: Re: selinux_inode_init_security() weirdness
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 9:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, May 14, 2026 at 9:47=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.c=
om> wrote:
> >
> > This calls lsm_get_xattr_slot() at the very top of the function, which
> > increments *xattr_count, but can later return -EOPNOTSUPP, signalling
> > "ignore this LSM".
> >
> > At this point, there's an empty slot at the front and any xattr added
> > by other LSMs will be ignored by the filesystem.
>
> Take a look at commit 1e5a8eed7821 (" selinux: don't reserve xattr
> slot when we won't fill it") in Linus' tree.

Great!

Thanks,
Miklos

