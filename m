Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE9344D88
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637522; cv=pass; b=m2FVi8dAnDtXm5drw/isKQO6+XLjYJjatLQMthtIIM0VHzBB91LOfX6jma9ZAu9dGJTCkpLPgflZSioLi7vfUWCnh+V11mwKXMgnxBulImJ+jE6B3CwAsHZq63OErn2JkZ3Dp0X3Ndnsk0n6uaWwJsG6yBsSvWQF3naOS2qcEJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637522; c=relaxed/simple;
	bh=QcBhM23wC/WrPMdMPXs/omYUrIMapWBR//P9ttFGIn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoKlGsF0XrWl2pn2axTda9DVlsQ1/SNYacTk8tDkJzVn/kES2oWYV/GbAC+ff8LqW5W38+qogrVXrzqOaeMEacYd5+tpnWSL62k2vUMd+gihXi1T10ghvx4XOxveggiEdUDY/XQQyxrwhKn3A5nJXFITK/6wuMu5TwzKQE91ClQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRvtRCiJ; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRvtRCiJ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36da8439078so4268716a91.2
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 12:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781637521; cv=none;
        d=google.com; s=arc-20240605;
        b=ECiLhV16T2W59G2iRA4m8PcNu+KnlShoYmnRizVGFb6qwc8RJib1bOmIecajq6pgpH
         iAvvy1KGzuaCrvek9TWmlngVHieEC+mMjyJomNHWICCxPe1kg73NFc7aasOoLvHcnVF8
         qXUhSiJDW6IJxo48sV7ccGTaaGe8hBIcXlbJMUNFPXsWUTfKSPq7pCvT5UzA19ZeUYpJ
         CAXw1yKGz+AsbtsakP6Rje8uJVySOcjVSSWikNb8/KfMI2EFeJBL960Wxh+rGkFHF1o9
         KDLmRf1joXeRPZjSDDGP/qT3gaUAuQd0XN4BuxfidQRMEWI3Gc9TsfNSlOFOPGWe1Tp4
         9G1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcBhM23wC/WrPMdMPXs/omYUrIMapWBR//P9ttFGIn8=;
        fh=TJA2JcGthyTjMSbB2L3EgP4zVSAL/KkZ9ocaUBov9sQ=;
        b=QZv3KPw3vzvR8dG9Pl8Q4bM1sDEQqpXG5dqyanzz6x62i6MMNNM8qMIQmbwiiNtuAr
         KFaIliHGVA+vPF7wg5C61JTTThb/kxB7pojNvERMyd/EYxr6II+r56h227woW5bhYvUO
         it2vIf4mzE8ImFJzi6TH+yKxmtbssa+O5mQLMJcQONhvUAXBMVQnDBlZJcv0dCzmUaBH
         EmTnc3Bo/BiYLZgNeONFgOvcKe4mLM3XZcuXRFIwUKERJjXFZqGqdXKTltWSojjyssYT
         vxgEVZgl5an+VUo/XUauaOLUVFM870D9soEVCwpFHhbFgObPx2gMZthVMG9SE7OOvrFZ
         lgHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781637521; x=1782242321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcBhM23wC/WrPMdMPXs/omYUrIMapWBR//P9ttFGIn8=;
        b=JRvtRCiJr+CnFq50zltFmfkYAPyEzJtJ9rbjXyomj3FfGURUXQb1baX6gcjANVcZ57
         Y/4vhcrfyDY5n7pIRnA3z2MDD0Tmg2f9oE23FYr2Pv1et/2WUJmLvRyDShCL7BCcWI7k
         tfBk6YWxFrlleoJKLipHV9VeKAgfpJiyq62/3mh97gRtzF0N/1B1XjV7159JPoEWiiUb
         B7c0cfQq7wAWYBX6XssjWySi23udNs3GEuzWANz3EKuvjG8OCjMRCzf9Uc02RHOPudVr
         Fp6bpqOcI4jsap+AyWg46BGyGxDJhMgbHjuW9ReODUVfvCr9oGgj9Zb6tX9NFUouEYKx
         Oqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637521; x=1782242321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QcBhM23wC/WrPMdMPXs/omYUrIMapWBR//P9ttFGIn8=;
        b=KGTwjpayyXnh3ux9xRJ8PccD4LiNkv44F2WctysRZWxb/PgWC9a4vWH7pVdnzLgBvB
         DRhEjk5STHvLYGU+oeF/mQOzk6/IEyrHmIUXi9YCboUAezrpkiPIc4RdG4JS8aqcjc82
         9bhMTuoF9OMgyvfNiHFi1ThXSDnvIX6gIBs8smOtjTeekLSafxM6Mc0wxzgbYdrfrXDJ
         hCXlJ2C+X+xnjqna9Vop+XWCpET9UwSyzFQt5BEEHXut8ujcg6O79AebDGxTGdsJL4xk
         gr8qaFMGrImhwGSeRsL3yhvMdwZ9d0kUv1jSCFtFWcJiZTJx6p6dTVWFYN9O7oyZgTag
         UQDg==
X-Forwarded-Encrypted: i=1; AFNElJ/3Io5JIeZzORJcV3g7UE2so7cplhOUgoP7W0ol3eLI5ZvhiJDVs5xGe3FVkQKKoxpfwiqLRE3A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/nGRs/1Lj7C2J1KXyUAZLY4yS1NKZrUoLKkz/tWjaWnXPchTa
	+ApDqgOOvNrRm9d7xRwyk2jJZvVpiwQIuA5jmtLXuwdV2ZfzxD/IM9Y18m3MnCIzpl8bHBcKP+p
	smePZOhFgli2Kr913dJp4OEZyl0MaxP0=
X-Gm-Gg: Acq92OGwc+hrubZ1QMsdqf7rMcRBbPpvJDoWn1jbLajTZ4YAHX6Fu2KdWBSeMK6Rlda
	kH2/Fpf1a1P2roCkBsOlyRd6IgguNUbdJlAwmKk2CajAdZhnIEH1IA/55ZhXVMKxYaeNTSnQJRo
	4SioY5hTzo8961BG/CEgA+kXzJp+YemAR5vFHE2XNt4nrxe4ro2PRNT3I58/wsc/eESVLvsWHk5
	J8ybX5Tgpg+M+x64mEtK5iuVW8jQik/hpvEhObYPxnx1QC/f2wbSpDED+Q3BrvQwMD5kX9c1euj
	ZzM8f9M=
X-Received: by 2002:a17:90a:d00e:b0:36d:b680:3041 with SMTP id
 98e67ed59e1d1-37c9369f04dmr684507a91.4.1781637520926; Tue, 16 Jun 2026
 12:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616144345.478744-1-cgoettsche@seltendoof.de>
 <20260616144345.478744-2-cgoettsche@seltendoof.de> <CAP+JOzQkV2HcYF1UxArFwQjiSqsY+F0W_5WGOVhrHssm3HsGgQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQkV2HcYF1UxArFwQjiSqsY+F0W_5WGOVhrHssm3HsGgQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 15:18:29 -0400
X-Gm-Features: AVVi8Ccw-Fb43-nFxg6CzJ7CzTIiJsh2v86kGg4XD5qgDB6G8g4LBT_clVmOQVc
Message-ID: <CAEjxPJ4e=9-dfqzjW1QJh0eU_eTanwU=JGWFuAKTspyRu9bTsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] secilc/docs: fix wrong CIL statements
To: James Carter <jwcart2@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 1:12=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Jun 16, 2026 at 10:53=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > - fix missing closing parenthesis
> > - fix enclosing of `sensitivityorder` datums
> > - fix typo `low_high` to `low-high`
> > - avoid double enclosed `((all))`, valid but particular
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
