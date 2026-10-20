Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792486687;
	b=hg7hBHwjtrFr5dRSEDPFzXZMIMCD7QUeYPAikpYbrNM0nob++UUAXqj3BLkl7zy6w1EL
	 Jfc/HZOTi/O58bQMSDfGThqbYYQIQxzSt5XhGXmqDnZYCuhQ+14FIKsN0l7G12y2q6M7V
	 W/78ubUzgC5rPc81TAr9KRJMe0y2LfPj3fe5YDDj6vasaz7Z0LDmWQ+/aDo+2EzcRNZGs
	 r1JSGK2c4lJqqbQAnHe7kz1xQHx+Bq2smQJqwK1FjdsWHxWaTu45ZcSNyhmK9pOMdDxUw
	 T1gqsyAE3UAuwiQDPOtsZoyphzN7V2fwoyImOPA6g2g3Q0DIwldfp/IsDz8SgTIVmGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9aUHTgQzEfQ6Sfeuz9ccraiLrRuU9LL7ogb4r7d6tek=;
	b=zX/sTzXht5LO0GzCW6CMLqa0V2pLPod8yLqv6E2A5tVtYKtUiC8k/lZrffguUj8B97ep
	 +LzQ+kSU55Dsdrp1FpQdVMSwleSuozQCp91ksjvRQ3tT+3SdRbCmNkNVqqpgJpGRZROVz
	 McDh7/h/Ug32wLWLnKJpWw/wNLXJ9zDyC9SXGozIDurtlDQyabnam73uzJZtuLwhrf7Dd
	 NSAmSq1IoFwAKBwVEYXyKpi1h+w+1sC10yAWYflq6MZUH9HbklNhvFhfavSfSl7bg8k3H
	 YahUq+2xwozYhxbIv2dgf9FIep4ooLEJkbzh8MnK8vHYQqmtEhFxmajWdv5RIBjOOmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GwVXMbdB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552A6606A322
	for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 08:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 552A6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GwVXMbdB
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15dd124bbe7so108152c88.1
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 01:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792486686; cv=none;
        d=google.com; s=arc-20260327;
        b=EoS9w/LWgvtNBdOylJ0OdMurTKFDkou+X0Jl177mI7TjiD6+ATawxq1KuUPHsMBx28
         JQV28BUJd4mL9bCltLpXIDmNse0nk14jAsI9iTvz+o8CooqzCEDP/yK85JPnOJLfSNhj
         t8U1/z1Wx51mPglNvISof8pWR/EWGSQ1VUklx2QUO1mh3pVxY2v8UO/s6qaRk30zujjC
         j0snr0Xhn5TKQGKp+jsoaOX1A3yh6sJUcNAxjJY4dUoOIYL7opwe9zM9VF4iwWTUu4tW
         x3Z8uhUeJnscqfNphvIzWv91Zma3HsqrEAkVRnl9XfyrXNAviWY6GUn8MQROQn6MTMcl
         RoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9aUHTgQzEfQ6Sfeuz9ccraiLrRuU9LL7ogb4r7d6tek=;
        fh=OYYLSdKdCb1E2hU04QiDJsDCCeLIx0b5+nT1ENbKYx0=;
        b=YDgDVJ7llKTtZsuMXlZb8LBLLtA5HeL7ZY4DgdBx0+z9LaV0HpktCfHUpurmg92/2S
         Y1yfTcZPS1nlMZfIhgdfXCiZ6fz/WujHp+HJhJIl6G1XvZZIQJPU8Zdxoa9CKEbTln6R
         PmGafH28hhwaClt0Djs3xuMBSb7cLtF0Noazde7yqYehog+B/FkC/ins2kbF8iBI8VTP
         MKLoEybheyZd2C4qD6fupimBuMkzINKCoyUHU/c98VwqbuBll6aprcN+nDLqJfXdxNxY
         tMcq5eCs2eBBdAG1jBYMy/5Pk4yoJFrlTOJ5xtbvf2NoCcfwU9gGwjwe6mR8O0Ip2kAr
         3zTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792486686; x=1793091486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9aUHTgQzEfQ6Sfeuz9ccraiLrRuU9LL7ogb4r7d6tek=;
        b=GwVXMbdB+vJhO6RnoxdOMmJ97b1ypd3FQCJJqPnB7QZTmaxWzveS6hFe8vJ2Mmiimr
         4PHJMSqhf4sVkD7jNjZV5tJLw1J+iVG4kW7VllP2Lc6ESRN7J/UW7LzB4tPunwvtxmZS
         nKkYOC3pmLoemfrdM2vtUnYI/Fkg32h8xV8QsPJyBKRf3sWyAMXb+1hr+i5+9QVfpL/t
         2GtHEAdFrCtfUObFIWk6xiVRZ44Gmj5fO7En7LnaGJzGMLDxiAZdtUFPZfqQaKT/Aiqc
         PKVDCBXJNW673s0JEmlfyK+EnS0MqZnEZhjZ7jWECwx0LTYl90IGjj4QYN4mDorDjLDg
         VIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792486686; x=1793091486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9aUHTgQzEfQ6Sfeuz9ccraiLrRuU9LL7ogb4r7d6tek=;
        b=vwoJgEdhOyf7AgFhgm6w2YEXcmLb2ddiyaryFNkF/PKUXqwlDxy793cXu96mWGZz2/
         FonUkuQIm6hqTP6ZSM0dQ6XMzt8tZihl7e/ChmhgIe/QXbK2XBTkDP96yglX0UURCUgz
         8YtxH3JT7uqqRLavIpoKqbc5CVPZnr/DJn3fNLId/OFTwOdPn3LuOSA6MflsRCLb3bXO
         uPQ6kS/AuXOF5hnORj3h8ww9ebOxqyjAi1hU3T8aB4hQCq0h9UpZHCGveONSY9WPPEr3
         3kOynx2ZinrFgb0EZtjBDm532lt7Ui+TC0sqLtfed7cZcoXSskon6M4U+d+Xxq/3tdOH
         3aJg==
X-Forwarded-Encrypted: i=1; AKwUvBz8/uFkshXSH50Sje+In3x+32C7GDsmYnprueXj9VIw/hCEYATTlhTEIGZTe7Gxqkr79IW/XBmd@vger.kernel.org
X-Gm-Message-State: AFq9FYIGKceDxBofXCZtgyP+XTFPK+AjXj59D+pQuu41k3KiZZKK28ex
	bdVC8iTfp0b6XGgh1lNtX0BXph94z3fhIbSOQBStB1H8PIeV2mv2fDBGH4R4nag/1sRXWA1Pe7E
	Nufmh0N7YB0mm8WS8wpK1XWZNglPAQs9szoD2
X-Gm-Gg: AYBFou0dD6m30G0ItHSJ6Ila71TrqrrQNQci4XqN9uFPXwM7DVfpMsomWGx1M3glBPG
	hVl4sioBLyeXIsfOufj3hW02aX/2OEgVOJJWFVEsM6P0LbGMUoRZGDRLyXOsKgqPu2mhj7V3xxR
	drbGf/LZTpMqlSyCIG7w+XpHB1N3yHn8nW2eUZRBZJuAhRE5hKYGLSLPkCLJN3Tep8E+cY4Sn+F
	Z82yHAuAV+RW1k7vun/Xm45ME3VjqZNcYVAhwwj616newjCRJirijakgr8dmuhZ6yjkOJyUG8K3
	DKBSmej2A/n6WqRpLqV5khznw4ShVu4JPxIWKtImZnXIeAFDhdAtq7dipGxuEXj3hC0BmNjb3Pi
	HwukliqJW
X-Received: by 2002:a05:701b:2903:b0:177:9a5b:a89 with SMTP id
 a92af1059eb24-185134ddbd3mr15890994c88.29.1792486686344; Tue, 20 Oct 2026
 01:58:06 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018012909.1795176-1-phugen@redhat.com> <CAEjxPJ4t=_CDnXYqSf2atEG7WODadR1zKMJVvwXWG5g+zBb0bA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4t=_CDnXYqSf2atEG7WODadR1zKMJVvwXWG5g+zBb0bA@mail.gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Tue, 20 Oct 2026 10:57:53 +0200
X-Gm-Features: AclHuK8aGQskaPj-TEDgIZNgwXsuZXGvD0W7djpwnjWuCoGcTXtkoGtz8GopLBI
Message-ID: <CAAUqJDsKaSpS=rzNA7dTgs9rLg5vNdTot+eu3p-rOykVkCBCGg@mail.gmail.com>
Subject: Re: [PATCH] tests: fix format string mismatches on s390x/ppc64le
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Pablo Alessandro Santos Hugen <phugen@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2026 at 19:13, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sat, Oct 17, 2026 at 9:29=E2=80=AFPM Pablo Alessandro Santos Hugen
> <phugen@redhat.com> wrote:
> >
> > Cast printf arguments to match format specifiers across
> > filesystem/statfs_test.c, binder/{binder_common,client,manager,
> > service_provider}.c, and perf_event/perf_event.c. Types like
> > __fsword_t, binder_uintptr_t, binder_size_t and __s64 differ
> > in width across architectures, triggering -Wformat under -Werror.
> >
> > Fixes: cb49040 ("tests: fail on compiler warnings and enable Wextra")
> > Signed-off-by: Pablo Alessandro Santos Hugen <phugen@redhat.com>
>
> This looks like it was prepared against a tree before Ondrej's series lan=
ded.
> As far as I can tell, all of these fixes are already addressed on the
> main branch except for one residual cast that isn't actually needed.

Yes, this is already fixed by:
https://github.com/SELinuxProject/selinux-testsuite/commit/705ddfdc5ae52173=
44eecc8d4352e7f3dc52e772
https://github.com/SELinuxProject/selinux-testsuite/commit/6fa2143aec27d0ac=
3ad4cb3fd76f747ab198ac1f
https://github.com/SELinuxProject/selinux-testsuite/commit/bf477b4e3df60b63=
553712fce6e07c97881dc6b6
