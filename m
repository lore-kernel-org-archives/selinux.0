Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255832;
	b=UWUnP2NmKO7FoS6pjNnnueQIq2+qLo2+/+oow7C+WW1nKCtbQmbsx5FwcCj/x0ao9ddd
	 ekjglamQwEB1R0x79zfHp44mA+FUy39xM2hUJ/KcLRdb2MCquKyrqM89W5w0zb1X3d04v
	 Ig1vHZxWD3khM2gG2bvKimAF5pp4D9oESqBmTrCzmu5bc7m1xjzm01WcIgyElEsEEFtm5
	 968xxQiIQqkraSnnPbO1mlBYHnB3jxdS1WVY4PVDJ/vR6AiVJ9Qi2Z+4ZxbsUlK05adk6
	 OppZTHrS95UbcarCs7LQOAZ9UV59l705WCCsLI5SOVzpxUDlJekkwmus4qiLhYqalmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=m4ur+G70f7fvkA9LisNaKuIwf7Tt0wWjUgIXPmtuqo8=;
	b=1gU45UK+FS1GGekfoaQ2Ga65Vxwz0TKN83LL+gRmoWq40oImeT2ssLFwozebm/vU+cjC
	 4tKcMApPAWExmUUDDRPmaoxuSMB+o+jYJUTPSQElH3+Gy8O8+qvDai0Aag7XlF3fkltfx
	 XIc0dMOGvL/aEgCOoU7AGKUIvb3290NpwdxRbhpEatiagQ0HMYtzqSpev+0Ty2m1/EI+S
	 NEG0pPEYh9w4G7M3UrXnbrYNmhI1oHRm41gLt1xMYUpJXa8CSqpDw5hhedzlvwglDFnos
	 aWV7gZ9aBlRIFa7yOgG6S2WctgR6zHnwBjZDY8wJK2naBWULcpNx+6xP58QX+troAuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="E7v/Yqg7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EAF606A333
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 20:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83EAF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=E7v/Yqg7
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9995ce866so9140565ad.0
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 12:23:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255832; cv=none;
        d=google.com; s=arc-20260327;
        b=jkL0tg+byM/wbFS8X5v9ExdFtm8fo0c/cgxpwBg3P9m2ulKRUOaa9CeQ32rzuhkR+q
         DaScrRQquJCIdXcVE3UvbuvSJaAYfunFjT/ZejTpOfIeTadNY7YvmzLIfq0KlG+GP7FI
         Jxu1zONRjSGo30Nkq5oaw+M9wuY2jjaHaObGFK5C6F4U2B+3fla1KVjAuLhunx4qbCzV
         5IcysrdQbyFPuPIQZDw9mtrzLk628Z1Eribhx3U/WzVpz+h+Jgy4UlaOPACfHnFLPX3/
         zTgfB0FqiU0dJHH/1QahM0gtKwCkqubNm86gDAsbULGOYeMABgVaTf14Vxj8WW3eKDwY
         bN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m4ur+G70f7fvkA9LisNaKuIwf7Tt0wWjUgIXPmtuqo8=;
        fh=W9p/Z+ngMGqOF2kRSXAyL2hwFRWhOWBSk6rBFW8b0Kk=;
        b=lNNFlB8Csf7+lclMGqjJxdrNtVRIzd+Wo1v5mLUmrRk0zD8MyWNNo4EWmyNiRqwgQH
         RRYiRkZEbeUKrecnGpEvS2c98yze+DKMBJsb4NBvTigr1j/KBNI3aiscwVKbZFHI91Sr
         D7IoJMrHGus4ezVE6U45F8w0cu6t7ojDVWlQESNQdl4xntSauw15M5WvFUHLI/PIasgC
         S2WdLGQDV0vqN3whEww5dGaX7GrhEI5p95WYjNadTPlEYP7rScs9kdLLMPDkAqLndI33
         8CgsY4+DK2C6V1ZdPgfSGWOQpENIbWLrcyYKciDb6J2d3jQVGyD1J56W//hywMz5C8JH
         9ZcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794255832; x=1794860632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m4ur+G70f7fvkA9LisNaKuIwf7Tt0wWjUgIXPmtuqo8=;
        b=E7v/Yqg7D8Zt6n7LEVINSST/3OMVyAm1+a53FiMi5R2sko+bWrPIk5jEHtQLBVyJw8
         LeRmN3dZ94pl85YrZLTPly1MiJUeZuP+zmWsnWmlF2Umnm/SA395gjCpDtG7V49UUedh
         ixK8EtGU2xaSQjs4bWWsSVc0BW26DWhlN3t4WjnZ09fVOQNXfdvKkVmL+LeJbJmr5oRy
         LQ+WAGDY81G7zC5ClVkq1lMY/4EC0ncSWPXbq1Vd3cLu6iwFNyGNuW0vlGACxVZTpJsR
         B/yt04i+019PrqFHzZoj3wv/oQ5DH48UNFQ3n5C+GTT39rUtAHHVl3Q7GaTAsOouOxgc
         fskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255832; x=1794860632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4ur+G70f7fvkA9LisNaKuIwf7Tt0wWjUgIXPmtuqo8=;
        b=VP1SCiyzY/lm+qMi4GQl71NQWmazy02EDbTzNF+svW9QSV8d1c/slrZWOUP97FJx3+
         5sEnwfclMmXWU06gZteHQ6DyXB4Kyiu+opxJkQ9bm1s/oSB9MlQc+l3PQ0OKcn34GfO7
         /EQLfSo7AVNB7RyG3rl6ADpEwBqKZuOblc2CKPCodM61UU4sfSGHg7yBXf6H+BslCVh+
         hakUFtSaVSnecyanrimGNy8EfHej+9HvGLpWgeV2Sl7ht/Uit4KB5Dn+EQocOxKkSE8n
         pRNUI5Zx9/rH0Jkcp8BSxkKW/oDCF1W0vWMDLnDOSXbISUKdpZ1LGtScwi78lGxwQbNS
         q5yA==
X-Gm-Message-State: APuU4Z8904JvP0jYs22koqFzyvztmCKXril3J6iU+MZLGwA5wZCnZIfL
	xdUjrP3NohwB7HIP5HKQNTZnO/D3T4BK0K5roc9B20hAXa6CLvhXzdMqSlmsQWffnxT7fD1DEhS
	O2jU0V9vx/cj5kXpkSfrRlWKzon5iBzRRuOaTmGnE
X-Gm-Gg: AYBFou2YvCxzr6UYWDC0L+/2LlEGFzunxwmPMpmjYMKLyB4ZqEAWfg/i2Ey/miqDVFU
	2yBio+p0nCye4OUg+ZURIbSY6kOlRZoGwA5KTALdoXi1eYeA50w42HUhbvFdeyZMkI+F7tb1dH4
	8FvI/JOET9Q858DH1P7XJ8QSMiN10/xmptaoMIU7qkFPAB4Z32BafCsMbGpR64cy/JZB2tg5gB9
	m8aeoeLrLwC/In7LHO5FcMwup/SO8CAkv8BOe3xf7g1cK1gve4W2+NcaN3Agt8vsFR1mry2DIWM
	af3UWb0iRMp/uWLByjSzvlUx2ykhYSIv/xkmZgWBwrxEJ5jA+ERGdM4ongx9p78h/HTyveZeVXg
	tWKgfS/7ZAHf/pv0TdMTYUlDAWcn6dGdz1QDeJwSbWpBy1My+VJKQT/vQP2LGncc+kxZPqA==
X-Received: by 2002:a17:903:370b:b0:2e9:8b2f:3561 with SMTP id
 d9443c01a7336-2edb925a553mr2248275ad.54.1794255831851; Mon, 09 Nov 2026
 12:23:51 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928142354.17638-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6mP-zsHV5Kj+TM1wJzw0_Vw=aKD=cpe9c6sYhD0EVe9g@mail.gmail.com> <CAEjxPJ4NhnXzb-47MGjnp+70so_iADXCZjgVTt54DwGJVX=VPw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4NhnXzb-47MGjnp+70so_iADXCZjgVTt54DwGJVX=VPw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 15:23:39 -0500
X-Gm-Features: AclHuK98RFxX208b8667cmqxG4635A8o8qDI5NHyydR0pIDPmbgW-JnBxJBrQ-k
Message-ID: <CAHC9VhToDPGaN9LZxdxvjMNWnqQiGzSCf7Bf0ue-eL095b+1xg@mail.gmail.com>
Subject: Re: [PATCH testsuite] Revert "tests/nfs_filesystem: comment out
 failing mount"
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnacek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 2:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Nov 6, 2026 at 1:40=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Sep 28, 2026 at 10:24=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > This reverts commit 0815abcd70b382e13592264ce39bf48742421cc8.  The
> > > linked kernel patch below fixes the underlying kernel bug that
> > > prevented us from successfully running this test.
> > >
> > > Link: https://lore.kernel.org/selinux/20260928141917.17577-1-stephen.=
smalley.work@gmail.com/
> > > Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/92
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > This is also now merged.
>
> Unfortunately these seem to be breaking the testing farm runs and I'm
> also seeing an unrelated style-check failure but not in something I
> touched (tests/bpf/token_test_common.c). On the latter I assume it's a
> change in astyle defaults. The former suggests the testing farm still
> doesn't have the kernel fixes?
> Do I need to revert these two again?

I'll defer to Ondrej on how he wants to manage astyle version
differences.  On other projects when we have run into style check
failures due to a astyle change, we've either explicitly specified the
associated astyle option in the config (not always possible), or
simply used whatever was in use by the GH action as the "right"
answer.

As far as the kernel patches are concerned, the kernel-secnext builds
have been running clean with the NFS tests (link to the latest
completed run from Saturday below), which is what I monitor on a daily
basis.  Although I do have to patch out some of the binder tests due
to the failures noted separately on-list.

https://groups.google.com/g/kernel-secnext/c/vQwNumcsl2c

--=20
paul-moore.com
