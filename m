Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533753570BA
	for <selinux@vger.kernel.org>; Wed, 11 Feb 2026 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802839; cv=pass; b=MGyyOV32TacMbzQrizPmo50ku2pBHJpX+sOv8jCGE/G8VZ2t71wURyyZ/Ea1YGwg+t++ijzZQleA2MxCrO/r26Iw0GtCNikWPiWda4OwNMEqgB7W7lHJIINT4ZTT9S0Foixc0HW0xGVxMopDTla7i3rPJnZIFwY2RO1j1J1W/Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802839; c=relaxed/simple;
	bh=pbVPPGED0aNtILMDfwpVZIRFZ7UPYVQrurrGmCKJz5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3ST00qKk9p/b1l9FgOgzMxV29/hJ7JPvg8akUOaNuuQrCp5u2lewQ0JCDhZ5g8D6pPGQ2szAucUlJlMQcbFXdFfPb2lTY+mE05aa19oIIHRoqmkpxuKoL7mVL0a5pMfLOjKmskBlV+yiY3txNE0eJfAVONyL1Qy3YLlz9uPyag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FGosEWPV; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FGosEWPV"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so301988a91.0
        for <selinux@vger.kernel.org>; Wed, 11 Feb 2026 01:40:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770802837; cv=none;
        d=google.com; s=arc-20240605;
        b=lDpHGzM3pIrx70OStCoABDWTNmiXxo7i7AXqppxsbQJY9tDNIK/ANowSKM8WnlpYaD
         JqIgUaumd/Q3KcmjkAEQG2/i5CG/RWt/KxzzPsTmSnWK96wjDFcMm9qjeBtpWYVt38LV
         h9Ys6a4c1fumRo5pFoWzYW0i4IEBqa/QGYSUeFf/JvMDxj35Wqy9m+xunBVPYzeXpIla
         pcJ1iL7+CUzusip2ThHUrvax/vfXL9CQnK22yL3Gow+3yGuhDNfGDoC46qqVZhZ73Psi
         vnYu4gvvj77vhChs/QstnokC0E6PrJIWhtAQP9soUh+HgfvU55ZlWg58V7KdSpq3vwxH
         lHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BjXKhFTfJiM005W8+dX7G5EuIxJHf1ws6Z7GJMib1BM=;
        fh=gxN+tW+bB78pFrIXdVRVMhq8TwLlRkuWCG8hXm2ZwDE=;
        b=OuEqiGU7W8At+aA1+GqQ5K5cl6Mz1VkoIvgw3iezIW9JB4J8I+4v11F49v1dXXgLdr
         O8/qwTapW8ebzH4rT4ALIlRV3DWoHa/HlOiy2EvKXC/zQNmes+i9ArWYJEDRdV0kdYQU
         ZFmGbm/nhQnbKoHzzyxY/fYAbJX/j/xOEjET3INPFNG4+wtG5EkgRbyPPkSD2pRodaZT
         HYZQ8LS6v4MNuEZOGiPetiuaGZrIJMjVKy4uSStHQ9atdJS5NFT5/EeibfR9aSyHtch0
         wGWLtfCXKfhWwmVPj0lhJ3zZXY57JPu5WvB9PK1zH5n3auf9chPf2ME0PuoJONuf+y/q
         eccg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770802837; x=1771407637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjXKhFTfJiM005W8+dX7G5EuIxJHf1ws6Z7GJMib1BM=;
        b=FGosEWPVhZ/U0wGEPzNfTKCRUOJQAN6IwnK8TWZX2lkpvVU0QXuplmLnPyfQbYor+W
         vL7e2abptR4jXqM1F1kHA0crHysWelORM/zkOWhVUYTKoT603qQpNH6wAOaxdn6t1vZ5
         73AFaEJQARUTZBVrZO+ghstIKhoUVcI2cIufKaOnkD0whAvFsZj9dBaMQvu/euccf4dy
         zZIXJKTsElxQzO8i89g6LLEzkNBdgsHshuPH6f3e0y4O28kNsZTThjeUtkeuRB1alYM/
         LW4IlsaScVBYw3GWWuy/FjtX5FfIICvcNjbyIgWk+ifx+qnEmOcjAxUp/bNC95kyNPqy
         lK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770802837; x=1771407637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjXKhFTfJiM005W8+dX7G5EuIxJHf1ws6Z7GJMib1BM=;
        b=f2siPILA2Hi9e+GxDxK8la2FlWsvl1eOBCwu6kwV8elB35M9wnhpJ9oAqY2QTcBcaI
         0LQnKk7fKzOiojXS2DMy3q8RvvRMv94FpC3fuSOBKCTDhsGae9Ge3K+V9/1Kov4ei6Rt
         u85p3ujpnzCZqB6zr3mIviJGM+lIL1os7mM1oDAxrWn38WKAbXg4Z3xgrmWyQivlvnnq
         71fGmMWVbt3ZUXwNNQtpCpGZk7lI4mCI32gwTnFp6bKMfqt2BC6ryHCmUa57GR6fXGv3
         jNOJZdT3R7HrWzCvxMeqiQhgtSlmfK4so/2xxiHNzpq+j/DD3NJfs3akTVX6UgoFe29H
         mNuw==
X-Forwarded-Encrypted: i=1; AJvYcCVl9NWOyy8kUv3wiuH6o8CUXrxNSL0no+woETIC+BbPlUZNCbYWv0KGiC12WyxBDJIY4JzrB02S@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGhepxSeP/YqmqofKDCgXrID3VEJzkhmBc4CpU60jHmE3Pep8
	FZAAvsEpdZvm89QEZrHqZCXP34QcDV7iWM6DP1hjzz9yHRiOJX8aDaabqSvJfzeuqm3MhFlHM/w
	jB6hRTVBzoM1SYEtO1mecjDjjPqmHF7rsa/kBze+B
X-Gm-Gg: AZuq6aLgEmvKVqrfKM1OscUSHTZYwjvAaitvOcdoNohQaxna++Ri6qmiSiDxCqC/HpU
	/Ta8DSDj5n1HWuOVGHFnFpn8Q5ojvxUP/OI9sUV4l2HoxNZ3A428hMdSRVEAqOG3GbmH60INZf8
	amjA0+DBrrtU4c5F67bmhzn5q6zxKYDfGDL31uI3dYAzalK4C9Y9DZ1jp9NVttT6lI1zOhXpaqW
	KsXE1l/HhggdxN2OEYUaXR0aLa4nsuatJ9TbsSHoBmreF8hUqEKRv79UJY+LPkNaw8WPtU9pvTM
	ApguEg==
X-Received: by 2002:a17:90b:240e:b0:356:1edc:b68 with SMTP id
 98e67ed59e1d1-3561edc10a7mr9435155a91.12.1770802837659; Wed, 11 Feb 2026
 01:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205033328.1644-1-ericsu@linux.microsoft.com>
 <CAKrb_fEFhHRuSW7M2W+CF_B0ocSg4=3+PiG8iqb3HYbZAZ9a-Q@mail.gmail.com> <CAEjxPJ5DRgdLriX2A7CZAD7cHkmmf9PtvgkWbF2yoScpOZG1BA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5DRgdLriX2A7CZAD7cHkmmf9PtvgkWbF2yoScpOZG1BA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Feb 2026 04:40:25 -0500
X-Gm-Features: AZwV_QgEC2cskBs-30v0WddD2B0D4yKp1KQbGtpw8KTiBwKldzYSGBcBeB_-qOw
Message-ID: <CAHC9VhQ6NLJR3d7qrpVs20h59uU+os1344YS+WAHQAV-g6H0ww@mail.gmail.com>
Subject: Re: [PATCH testsuite v7] tests/bpf: Add tests for SELinux BPF token
 access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: Daniel Durning <danieldurning.work@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 3:43=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Feb 9, 2026 at 1:02=E2=80=AFPM Daniel Durning
> <danieldurning.work@gmail.com> wrote:
> > On Thu, Dec 4, 2025 at 10:33=E2=80=AFPM Eric Suen <ericsu@linux.microso=
ft.com> wrote:
>
> ... This won't get exercised by the automated testing
> until/unless someone updates the tmt configuration to apply the
> necessary policy changes above or until these get defined in Fedora
> policy.

I'm thinking out loud here ... it would be nice if we had a set of
Fedora Rawhide packages (COPR anyone?) for the SELinux userspace and
policy that tracked the upstream development tree (somewhat similar to
linux-next for the kernel) so that people could easily test these new
features.  I don't think this would be too difficult to automate, but
it's been a bit since I've looked at it.

What do others think?

Or has this already been done and I simply missed it?

--=20
paul-moore.com
