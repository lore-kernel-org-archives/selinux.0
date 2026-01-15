Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2983B9604
	for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494155; cv=none; b=gfWWTkhGzVBxJfy3f1invZM4A3pAm2MC1tqxdlWLbo1nruTKw0zPhEE5I4HzPXLZrYlcwBraOW2UO84g1RmmMaeq22duxSxCtrelKGXG/dahFVRenFD+8aiCeqi12Vb7FWUGW+cxfLjyklZqt5OXgcRXZ1Pkcoa+08yulFs7KSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494155; c=relaxed/simple;
	bh=aDOi6SrPvdDQliDbGCWo+GD5E+5l6h5kQcgcIZ50ZRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFAlt+Zq3vLNDP3KydiYMBMuDjFADg6CoMTGpWXCOcW3HclzttVhCuHHOWKXwG+JuXZbLotNUWo7LAnst0YJL1ml0+8I4WKD4fiNAwa0QjcAX1QsVBfWtdmg6UIc4i9oSDSoOyDf17BwPns/2D0BE0luoF52lACqQ9zb6YBqjGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LC156Ggl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LC156Ggl"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c47ee987401so424139a12.1
        for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 08:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768494150; x=1769098950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKuMiSNRS5SQ9Kpe7kZEsMiutRB0NHoh6mRu9HPj7zw=;
        b=LC156GgltLvxADBfv/i24CKJQSm3IF2oLlbKpmUtcYng59tQMrq7/ObyglL6qmLSh0
         77AuBevrYvjV4hgcxHc+AvdA7EUSOqCNiD21E4/FsokZrEEVZjZ/RI21vjnur3Np/VU9
         JxUGXYBKgM0GKJreVTnMqAYERHaOImR6psStBj4uPXSRaEdBYBW0gg3+xuxgEtvqo1ln
         CFz7SELcCEEqLefJs6hqvprH68iOECKS0QCb0rikAtAczs7vafeU5ewaC//iX4dcydf6
         R+5D7cHnFNeMost5bFZj5IKXu/6fpNgUDDnm4vZLaeYf2rnR9WaiZT3TRYG2LCcbtR3N
         sSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768494150; x=1769098950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tKuMiSNRS5SQ9Kpe7kZEsMiutRB0NHoh6mRu9HPj7zw=;
        b=NM72EB7xBS1yrz83P2l68XArvGXjB5LD6SrpBBVxoIvj1lEIcJ4Evn+HzjmebCJVm1
         V6IoP1IXMOoPfCCOtQHs2hb4FBYfiWoekkE1GimdGSqlaVGGIqBskEY/PrILAdCCM3rG
         PcjvK8lpesboHWNzC9sxC7GVHwGbk+fjVao1qcvc2IjmOseEm3Xj40rDSTkHeKVzUtWM
         QO5B1rlFP82plL7N7x5DIBiw8Aci2PBrqc03jRH6ttNxzI4Aa3XNYl4G8ebZ4F5/lgmB
         JSb+lAYgpZdAxvZJAvsgHsYp4DVu77e30/zXWmLNIzJ3yPG/BFP8rmHewjlrPlR86UjK
         b65A==
X-Gm-Message-State: AOJu0YyzMK+NKPRIsxGkmMm27CkSretrTkaUqfwoj/TeX6q0XSHEKNeM
	5b8USCUCzd3ls45WHUzD7EcdRdVO/zsKfMIQ/sngxxNTNlH4jh/xfZdy3BpkTO8GTejsCnJEJUT
	8QHagnlxjrJj2qkXEgHUzxI3NWnUMAekWeQrvm3rh
X-Gm-Gg: AY/fxX42a95T0PtdqGZMkhDucLR1mYlM+vGgKR5BawJDj6512+GqgiOAG95P7ZdKwLA
	wtWiSf0CZtpHA3fpJT2kvn8b7XIYwl0wyx9idOCNHUp4/rr1sNjzMhfpZD11KMwkLFTHCf/4JJk
	n37Jrpb+Msq2aZnW3dObfVmN3vxR3WfvGSK9ktn7GqGnzP58uqfviL/org6aRTSaY0H0wfZHs3Z
	BTVZqZrCbJTRv2PtvtpRUwipodZpupa3eH3nMzO3RNpI0RyU7vMHp/OIhOBHAmM+2IKBqQ=
X-Received: by 2002:a17:90a:be07:b0:343:3898:e7c9 with SMTP id
 98e67ed59e1d1-352677ed610mr2333802a91.2.1768494150071; Thu, 15 Jan 2026
 08:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105174020.887724-1-lautrbach@redhat.com> <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
 <87h5sxvd52.fsf@redhat.com> <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
 <87cy3kv5w2.fsf@redhat.com> <CAHC9VhTcEFHNJcTSbvWFU4gKpAUBg-8cLAfushX8CrhnT41SbQ@mail.gmail.com>
 <873448ujz1.fsf@redhat.com> <CAHC9VhSBGr=6izQCmWwOcg85S3G02aDMgSrQ-bGEf-sR9RYtVg@mail.gmail.com>
 <87pl7b1f0n.fsf@redhat.com>
In-Reply-To: <87pl7b1f0n.fsf@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Jan 2026 11:22:17 -0500
X-Gm-Features: AZwV_QjDNf-dlx7FtG9cl67Dl7SRJkxJTgzpjbxouRDWgQh3JL_sp2ORHLbsI30
Message-ID: <CAHC9VhQHrnkMO0JMtDyEnsmgMJisSU5bs76bzLYXGirc8uDYmA@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:01=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> "68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E" is not a subkey.

Okay, in this case you need to get this new key signed by other
individuals trusted by the SELinux community before we can consider
including it in the SECURITY.md file.

--=20
paul-moore.com
