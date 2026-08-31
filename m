Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE12E5B2D
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205419; cv=pass; b=B0su9HJ/BbjVPSTfuJffbxX0D9vNQyJbZIadcGw/TbcXLg7DDvadoCpaYDRP7RWk7w+ilwKetU098/TduaZ/5RSpI1PWvuR46ebikSh2lnyT/4AZrXnXytdPFTOKzjir8pWS1dU7k0HZCz2kQ4USkaO7YfbQDXjxmH2uVaiBWmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205419; c=relaxed/simple;
	bh=MfZc/RC8whK5QAyOozfTUHmXgjKG6FtxR8s5gCfUkv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJyOdyeAPvPPay4lD29+XpTL+G84cqHr4N57ztqpNBWeGEwjFFgId+88byLCRHv8uOGgy9ge/38oOb/kcyas+DTamhIAhkCOyrAAtR4JWG/TRIHLtD8ZFHCL5XiIqhC585QcEWB9eeBurz7c0g1lxtOyxZ1R0epVfBaKis2kRoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dh94UXdf; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dh94UXdf"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc149372c14so135181a12.1
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 12:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788205418; cv=none;
        d=google.com; s=arc-20260327;
        b=JCQIM2p9T1cp96ijV/nC7ByxwdyVpq5HiYuRAEB9jdKcRAJ+LGwTr3tsp8eBC1osvH
         cHqPLPswP7wDunnQxNM3YPVOnzbAVcGj3x2VnpTs1kH6ypzRVFQmK9O7kQEpqq2kScRJ
         8dlRouVzwSq/Sp6FeM9rDkZHVI9sxjAOH3isNBtA2E5hvQtxxoL2DVwc/UHhSsOxPcnn
         NbZvp94DsXyfI/cozhzvR+UooTVU+/LO8UtR3d1G4uDhIA8wB4vKy/rAJO/nnJXWs5Z4
         yxgKj6RAjV00k8Cf62YmeHRpClTiuSfxvAVfsmD9ak8vI0RjGQV54KqQfRrhIQeZB892
         IlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=icJcpMQ0Zb+woDJPqUSvSRxhEckAm5xq+C/nVYSyZ5s=;
        fh=o44F32nRPQXH9d1Ct4CmtoKpe1gNh6qYcpMzAKc726I=;
        b=HQ6Si5cAi0gGjUTmN8Tlut7G20xpRPWTDRBPztxEf2dthnmz5Sd/fguNM0y2Ky3bb2
         KhU5iLuktUAIBbpj1CGXXPp2RXkEXEK3VsrcNKxXq4Vs/1AGEsHtTyhnl0cS+fUk3UeI
         2XYTqA2+xHdgJv2fg6dlLhHuu+CkVZoBVA6RN+FsyRDP9pfiwMAqEc7VYYh2OrsCZP7f
         13PF/XHYMKRON2aIre+cZky8SPtQ3Ip3B+F7EJRfD6LaDJFo6bi28XRhMsudjtDjPpW5
         aVf/q9Wpxe1ScCnJcwCWO4skKPSX9pRzymygdNNTFHKXFZL8iB1HkoxbulggDmvR3Wwj
         zAVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788205418; x=1788810218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=icJcpMQ0Zb+woDJPqUSvSRxhEckAm5xq+C/nVYSyZ5s=;
        b=Dh94UXdfL4cth4hXowS1Yxf8iJ3zRnPplX+P8u1R8Hw0QiIyxzqQf9RWfnGsx8EpOT
         aPzEnnekPLJ6oupxiNmwqMR2Fm+cre+G+DkTBm/Af8H75qpzLUdSprqFiqm1RTgWkMo+
         HmKbiwIzKZrNuHBXLBpo7mjVT9wNuMgSpxdYvu2ROrUJ1RHOw0aMTpvsosucz+DcDEw9
         FkPUFSFEtHldHavgRxW8OlvVR7rPZhKZ7nyj+e9cQFt4E4yzMWpDVEjrjNcwgMPJeinJ
         zcWB3XoqQCF5gMXdh3L6yON5RXU1f4cd3YegKzqHD/aBxfnzCC7CywjxMnGx0eJ4HEzN
         /vZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788205418; x=1788810218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icJcpMQ0Zb+woDJPqUSvSRxhEckAm5xq+C/nVYSyZ5s=;
        b=fVAqYHq7EPxniTyxZ6HljcIDNYyp1Zm+nNAvxQ3pdy8n2Kpp63l/csnSyPnmYCJ3or
         12plYv49gzH3tvtSxdD4SJzcHnRHraJFMZwO35s4W573BEKsXcDQXpbJFX1vqHvoNk/u
         Y+v7hfb+/Foo21zV1nTjR2v+myLsdE/rAhQ1Ck6+eYRaGc+8aX1mckGpT87P3Hkqumbr
         jqlVro8EO0p+7iDLOSvK7S5ZTwYWkx7XcrLJM3KH/pMmPu7XtRmdJrhCnSQnj4pAQFV1
         saWGDGYxBwZzQs2DSSx2CZd7162a1JpAi8KUiBnqkqMj7P6DJnvoMbBU/Uqs9lM+0u87
         opIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmWXQ1WbESehg2IC84m3XSeKGpGTjGhXCQup29YAz76Zgnd5tGXgD/wXYABQWUKQMwgEGYKacZ@vger.kernel.org
X-Gm-Message-State: AFuF++kqLFsRWOgEIfgjcmkTx82cf+PmxdlF+y2un2+qMhl15VC6vS5S
	81Mu6Wwyluj2idQBIJ/fSD0DsgFe6TpMqZIGOPtcQOO/iVpRuD2BGK6R7jmjt2bJ3Vgc4MkfJGf
	p+siZTecxVUumInJtYabYMa0jMxT7tnOGtu7GBe1e
X-Gm-Gg: AR+sD111WBXt/uDJuzVl4Or2oH8kNeblC9Fr1mkCgPLCjGS7xqNRozNobq8JP8yDcSW
	iBuqwl0qqUIqjrLiikp72BFuoZ0Ds9q+1REnmIGUjUfN8jqgsZEPP/and4taeFVV0yC7Si8sW6e
	XhmI+eCpGJU0B/p4nXlhphf8vGK7B47myZSrno9vm9LoMVSTTQTVy+FbEOCbczkizUfYpx96dJc
	aKQhIL+K9MwaO4tGs6k1OAdi+0Gf6zpTu3vDPnMwryiPuFw+HEnWqX6g1inRj/IzK5fVPcRM395
	0gHKgQRmGP3jwDvk8y2nXIfmrOqDr3yA2efCwyj7ZjxD
X-Received: by 2002:a05:6a20:4322:b0:3d3:af85:eb98 with SMTP id
 adf61e73a8af0-3d3af85fc5bmr25533812637.26.1788205417558; Mon, 31 Aug 2026
 12:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828202350.110547-1-stephen.smalley.work@gmail.com> <77960c774f1a659ca33efb7134e24162@paul-moore.com>
In-Reply-To: <77960c774f1a659ca33efb7134e24162@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 15:43:25 -0400
X-Gm-Features: AcwNN1Vjq11kQDWjA6dwHGrRStUth789GI0zIpIDBmnPfODXTFxsw8i76M0l1I8
Message-ID: <CAHC9VhR4qpHQnxNJH48st30rW6-4Qq3dDdGQihHs7zVaB-3j+A@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove unused mls_setup_user_range()
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 4:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug 28, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > mls_setup_user_range() was a helper for security_get_user_sids(),
> > which was removed by commit ad1ac3d740cc6b8 ("selinux: prune
> > /sys/fs/selinux/user"). Since mls_setup_user_range() has no remaining
> > users, remove it too and any other helpers that only it was using.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/ss/mls.c       | 38 ---------------------------------
> >  security/selinux/ss/mls.h       |  3 ---
> >  security/selinux/ss/mls_types.h |  3 ---
> >  3 files changed, 44 deletions(-)
>
> Nice catch.  Merged into selinux/dev-staging and will be moved to
> selinux/dev next week after the merge window closes.

Merged into selinux/dev, thanks!

--=20
paul-moore.com
