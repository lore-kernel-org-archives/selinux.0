Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3936196B
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528271; cv=pass; b=kxRAEwBeoM+ZL7i0B9l9GTzVbCYyaj25dcd6eelsO5d+FUWYTqTfvOvOfWwZphPitjFvgWpzVkcWxr9lFCcLT0VndK6GJJl7Y+gijO9BgZNg9vBcMNgpNHf0jjiQpcHh+ShjEHWkDsix3WIMHOE4IMar/Kb5OjoZbEvv1T6QWgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528271; c=relaxed/simple;
	bh=+aVLsT2HkAwuPg7OTAQLD5Pan8Hheg4IHyMHc0PIpCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zy8dV8s9HzZkaamVpANr9Z0gVe7zAda3YPQk/ReV+bS5zKkumDlyNLPUKXAR3eLSL4KoDC9fzPpPrbiJeVtR05qm33R7dCgRndmFhtw53GuIIobXEFv4sAP1KkOO2QbL8cnLZy4pLkMs8B9bqt9+ABwvdYzsTT5QfFiimAg2/5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/SykD+i; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/SykD+i"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6aca105971eso814171eaf.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 13:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785528269; cv=none;
        d=google.com; s=arc-20260327;
        b=LnZG9bfVyR9fPPfvD68GwZjWOUD3+Ku+KfOEdtqxoY/y+0y+abwA8NIWvGUFJ7ctxf
         weAbJ8wvBMz+A1q3vUrBram88vrmT4iFP7oGmWMG5viGAI/CoFozwoMsdhrEr7/9rSD6
         wz7+9eqpBZ0EbsYCcXpveElJwiS8FtPPNeeOVhOAEtiOf33wruv9FpaThBmqGTHqePs2
         IXy6C6zqlFvVAbxDIs3d/rOP/x0BJMfyDIayKQPdsBtCVBZ556vZPYqLs0dOHHF0rpJP
         pt4+3hgVrdfpAHlZ15T63pph7+MdfmPMWN9uG0pV67UjXOjoqh01MNd+9G2nYEXeXVH0
         IBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+aVLsT2HkAwuPg7OTAQLD5Pan8Hheg4IHyMHc0PIpCw=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=WfX5ovuBfgnwafTwTI1ji8M03Mzle1wN1KBJwXl8ptHpaD4xTGvhDTAd8MH0i6mRUs
         6CiZNjSQTFYPB3ftyRqG8GkyCJUx0jrkFAi720bXPt+Wo6SLv6LsLGixJX3qv/cMIeoE
         q9DnJdmQJtXsn67U1N7hFE6BgfyrTJgxVMe58MLVvt3PajGrr0ENOEIxG7gamPazPaXt
         4C1Ss7+egBKpZ6bOzdI5SK4IT7ITJoV5E4MUvdCi6sAp+hSZogBQwSmfJ5+ULWK0Paxz
         YnqFFa3Ei6c0KcNKc2VrvWMay2ZZ5BRbXj+3x60E8GY8PwtgWzf9Oh4VLekNzhJghlPx
         FEjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785528269; x=1786133069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+aVLsT2HkAwuPg7OTAQLD5Pan8Hheg4IHyMHc0PIpCw=;
        b=q/SykD+iApmgz18lVAcHyJrqenvVdWMaQaMm3xYiR15IXeuxmpYUtoOu9ns9/I39Ec
         qPUnkoxfmxtvZtCMuDUkIvdsUHLJmwgeyEg1FuAMfW3JvcDILRz5inHdV5i9vXqkmxT+
         6q4my2LiowhbtR42k31h9o97kqKJCZaEwDGQ2OWk0GURDdl5Y9mm5aL9txYlqARnM+Fs
         yHFn1Qe1OLWYQmzbeoiNlwGPbgOorXAMKgD8FzXA7GXCjlG4ENEoGS4cpgjgokOBPo1c
         Z1wvLk1qIemMQcIbDiF+tee21MTT0wXcVjTPSZhr4rkIXP2I3MtmipO3R17LUQK3/uUe
         5Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528269; x=1786133069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+aVLsT2HkAwuPg7OTAQLD5Pan8Hheg4IHyMHc0PIpCw=;
        b=m+aAcu0WZ+GJpyiHv2i2yh/Cye8PtQd1uqIO7lYpBVejSNLS+9SQsiXRSepjzGaUhX
         skjDr+0WzmfNjHi9swOPXJaqzrA7PVSFclUqtWEAppWiZalOmfaCPUzx4zcNriMRG9cR
         Kwi+zfZraU7Lj/PhHVchOV8jT0/bgMLUL8kiqGKFyUA3Mhtz2c9olHGiGqe/RDXal5+/
         kdjaTg5lXoksE7nzl0cMumQWA3ZTRii4lc6NTQ9r1HmR5eQ317rLH7uprF18y55UXi8u
         TXYGj+kZgj012rTWgZoQpPHmEMtWML5brAR59nyKv+O056fnaPdh9xUlx6C7FCS5bi8d
         mlMw==
X-Gm-Message-State: AOJu0Yw/XTo3VGjAHTGTmeIrX2PrhkFe94oTUEjmZMz4ffrA9Xo3kNJw
	xMaQv5uuH8hK39PKsyQQdFK9aoD+mZXNjVx+1USAv2d5bgnK0P0IRJ/OTBbefRhEAd9xLZCc4Rm
	QzmS0lBzAD+niNRpL2mBajP8hFh6gqLc=
X-Gm-Gg: AR+sD13JeiHl8mgJxrJPvM258qQG03GHvO57bA7yUqrOxj2nqkLAH/gwoUEXsmDypr4
	dF9hojW5/GojzH7NWru49JT8LSltcmrWw3fZMuI16lQMFjmvdqicT23iI2W9U8V4cae9AU9K5Ch
	O+zPihppG3+1pJ7OcYCy31fUIjHY1fKDzeJ/8YdyzZlNifsNLbOO7bY5WwDnGDOMZUq8TEVZiDa
	M+2o8WGp4TjtwbM2gQ1R1jzLbbwRcfb5o2vfH/Z9YSDLJQeQYOkDwuhYigRs71tRX6kpThWECQG
	KmXMxfQd3IDPewqqQPpjOiqaYw7p2Bxq9FG3oXFd/QLv
X-Received: by 2002:a05:6820:161e:b0:6aa:edca:e171 with SMTP id
 006d021491bc7-6ae43311530mr2538621eaf.19.1785528269597; Fri, 31 Jul 2026
 13:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731152609.47168-1-jwcart2@gmail.com> <CAEjxPJ4kRvrt77OLNRh9fcR=U3MQx1tpUr5sT695C3_heqpo+g@mail.gmail.com>
In-Reply-To: <CAEjxPJ4kRvrt77OLNRh9fcR=U3MQx1tpUr5sT695C3_heqpo+g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 16:04:17 -0400
X-Gm-Features: AUfX_mz0sXPY4PlrK1m169MJqxyOAD2eJgvH24er7f3zgN9HY4YM0WZCk2e3oQQ
Message-ID: <CAEjxPJ7OJmp1zKZ+VnFtXQ2_KE2d43v749q6Btbnaoaev3WM=Q@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/fuzz: Exercise module to CIL code when fuzzing
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:54=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 31, 2026 at 11:26=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > When fuzzing a kernel policy both sepol_kernel_policydb_to_conf()
> > and sepol_kernel_policydb_to_cil() are called to test those parts
> > of the code base. Call sepol_module_policydb_to_cil() for base and
> > module policies to test that part of the code base.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
