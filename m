Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC94AF9D3
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443250; cv=pass; b=qeUQ2pJzBMFKGDEX1wVqeUtSVBWqK617V0S0JC0ONSJlz609jdxiAdhUXWvWLnBeElQ+A7BA5ZMcVo71riEESZE9kVBySUx/duyRv9o6cL4y873mr1ZJ2XMQGjdgXQ/NKefoI7U0C8wpqxYQYjZEhQ+IQITGJ+MBQwV0aD+frjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443250; c=relaxed/simple;
	bh=M3dxXn1uQRBl/s0WwQ5yE/lFAVzEzWS5ke+uJHcm1Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9egCz2wgUhS2u18/X0X4NgK608DF17jjkzdHuQ5lQ4qcTYPq3aKPeumq5rlMUqPjZU+GdjXYM1+5RSuPhxXKpsLO3Wk3O8zQo1Kh/3Pj/GpWPLofmFqkDZHzIvOhHaUb66l5SsOoOfLbtj6znT6bUGLYbgY+SqXJNnKBWpVVmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMDug+BB; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMDug+BB"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-46adfc80ff6so1257862fac.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 06:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788443239; cv=none;
        d=google.com; s=arc-20260327;
        b=Nave0Jp4W0I+FEdkpnOfLzw9u5uqXCPwtQOaX9BAJJVCjUwS4k06MxJ05R1gPJqwbN
         NwYeN67zAostgiVChmJ+0Xj8opi5NxLrtVfTkAcipqLjZ1a6sliF38p3WWHI1fFuCiKB
         41c3HI1zapZnyuHx6DjUf4XUjr4tDdq0x98nWsdBCvp9Ge12k6FkBNLyjuLmMmfa7tqd
         lbAivFEHW8ydiXoh9Zfm7Oxi+TT3fNHOR/EUz6hMZBdrQRbYl2QuODyMIvaDjI+vaCvM
         mfN+mXoEsdJHuA9zTXQIrQHLFkWTDfdLS3/2wwAEMhGgLbebJmxA1LaXBNfYzbrTqKo9
         8cMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M3dxXn1uQRBl/s0WwQ5yE/lFAVzEzWS5ke+uJHcm1Xo=;
        fh=aUbqRQkq61ZAI0AgKTda9vTeDxp/LdA3hosIEHHauP8=;
        b=aeZBzxFT5pnsHkCcMY/1Qgps9bjet9QHoPm8x8/SEJWlDt74wkchZfTVD4yBM/HOqL
         sfHhvL0CWHgCRhff15xpNco//baQwQBkZ45qUklMPEE1mnwHzhZE4d/P8v6xq0hp+Tnc
         0xSoQq5Uf8N0Ds9PqUFPv60mO+H/ePCspMMxVF7fhJktbfHRJj2kuENen+ludZ+WF5j1
         MFiqCILynzhCvr9FzadnbzxnEiXuUgRRG3j58x62wYhAhKy8HM+TAX61L/H/KAsJUvvx
         l0FdYEr8CvZRkZHQV7KVD9MSnxcd5RX83O4j8juvJub2aa+s34wtpleDlG4OM519PtDo
         RBdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788443239; x=1789048039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M3dxXn1uQRBl/s0WwQ5yE/lFAVzEzWS5ke+uJHcm1Xo=;
        b=PMDug+BBmTMCKSjm9E9VyYCfQSp8zywDREQhbkAalfY29diU7s4MUFn80PMPbZc4Ra
         HYfGQn+xtyggplUCghjUyXu+K24eysRb4MRUGhrisJ3UA9Mn3zGpgzTrizFakJPp9Ngi
         eyw26VB1I8g2W03KgB66BSHjlBUywSozV4tw78hD/jXpjNytxl0qDs8rcKCNll2Q142X
         TVXAAryjg5/DjGTekranGyTOTrkw1YPAYkZYXr9nrTUw0b5T7pAWLYtCqoQn8Pk0GMAK
         YkHc+kSUjOOwCA9Cwp8ddXTTFC08IqLaI1tpxQHHe/9HMTxWVSJB+bXzcFugaObCFoiJ
         rEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443239; x=1789048039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3dxXn1uQRBl/s0WwQ5yE/lFAVzEzWS5ke+uJHcm1Xo=;
        b=LR6rMGRfrkLaCCuft+syXmBhDQkZca8BrWanxoVQ10hKnzUp3c/Taq1uvIicMFo7Ae
         DfyxPwF8XNgRh0DqOfX10m9LdF2tQVtKYPqn+hco01TzkJDJvaf9W5bAeawEBh3Zg/V3
         y6h2U5XW8UxowtNK+hXTOjVE4ww62vEywxHNjruCOanUH3Ahb5nt1MmpWMcwHVW21A1A
         /29L1T4UUxFI2HPs5Z+bRX+anP7PdvSh0CuA0JtrTXTeEAgm46ZADh0R6PfR/JGSpok6
         ERVIeanzdWGa3fztBxvVh/9hdGNCP/pRAANWYDu8J1m2So4BV+WbhTWdfOE+Zs3ImqIr
         oNJA==
X-Gm-Message-State: AFuF++km6I+Vhsc14FWzqco+GPJ7b+Sh7Yf9iBMzHu0ZFrcxGxu74oQM
	xsBQDMfeSINVCCAS7PC7Vbk9y9edojEe0+4hVbblMRPIzQzqdKh/Q1Mp2JhZrzlUIZpl75P+MGc
	DaErsIBPB3ZDsUO75x9Yz9phNRrc2aiM=
X-Gm-Gg: AYBFou2AfzjbNQULrePuymu0eUkysvswpxX+rDijLXvNHrzleW5y0O6DUjzAIIQz1re
	MjfqkbgLMWuXiPHSsIQ/1Btj1uErpoNmxul8u00x/wahMPo7SEJDqjOpsXCzJPI3nvDaN7c8w1f
	bqa2nrJ1517YOGeH33eqbK008lOybpcFoiZgrIIPwgSph2hAnTtkc5PgZHl95btmBZQI358D5g5
	L2/GFwXzgCz0q/N0KCcIo7oPPnSvWMtnUqYZyM7IDANBapAPtusKdYNnUG6x+1QqcK9Fa2O6U79
	KBENoeN7+Pl0DVSxJS7QVVx8cZ+NUrauQecUNcwR7btD
X-Received: by 2002:a05:6870:6c0d:b0:440:67b1:b59b with SMTP id
 586e51a60fabf-46f858b9423mr11048484fac.0.1788443239324; Thu, 03 Sep 2026
 06:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Sep 2026 09:47:07 -0400
X-Gm-Features: AcwNN1W7U2MsPf93zXVEsPCi1kh1m-KNw6H-O8XrHwfyMMcJhM9EiIvydIc-B3E
Message-ID: <CAEjxPJ5Yy+GQCjpddDQTjCcCLB=9DCJ-Bf2Wv9n26=vgwP84qA@mail.gmail.com>
Subject: Re: [PATCH 2/5] selinux: bounds-check filename transition source
 types at load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:36=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> filename_trans_read_helper() validates the target type, target class and
> each datum's otype, but the per-datum stypes ebitmap is read without any
> bound on its set bits.
> Reject a stypes bitmap whose highest set bit is not a defined type.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Technically this will reject a policy with an empty stypes bitmap and
no types (p->p_types.nprim =3D=3D 0) but that's fine since no real policy
should do that.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
