Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA80559C86
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184038; cv=pass; b=EKVkyXzQUqU6yQm8Yhhy9PIreCbAOsP8SkdJ5J2Ceyppt1Tf56UOpY+2sktkkXE/UOiksppb2FWrhdotkgpM0CG64/fxif0WYprby07YFvOzcsCCgvltj/lZofur9RygmVJvIBnmyGE5OnUOwqsdJAPP5c8w11o43hADAafjyio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184038; c=relaxed/simple;
	bh=sJI2mOCc7tznZH1xeE6WUqxrzQLAatMXruEgFfzLUks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex2ZuZuPvIoc1qpL4m9UrgHX9IbV7R7xAGjEI16v6Sv7jRyaVLkGq5vboBnvPGCINJKQv1gUucGBgmybgXm9iW9WFwmhFRUOHaUwoIozJAljRpufPtyqLhAKFjrC7GXuXq1TMugSLQWYxq4jPUIXP4x57UR6/XawCugVjq/VCs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRp5bbzk; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRp5bbzk"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-46ac530ba95so711705fac.0
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 06:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788184034; cv=none;
        d=google.com; s=arc-20260327;
        b=nUQuHfpWRpQ8RW9QKgpNPe+4xs75Y2K9rO1NQRP5B0lJuB2Ir+DM7LJfurvOWsOLlE
         UFb9rgmSHN3n5xME6PRwJDb2ElTfFZnqGpX1qctk+Pv0wUqQyrAAqzP9ZYt7AxS91LN2
         wF9fZlefeEjnOeBxPl+KUbIvXg2oTcOjONUFGFbSPGL+mgc0imRFIyLkjuxhu0Eq7XvV
         Vb3dYSc3xdl1txoili+ZPhaogKX+lT7DssEZhaADSFA8joXCEuIW4Y94ALKsxctFJcx3
         uJOC8gHRo0eVtUCn0FFsCyCzFcLVZVPqVG75o7A29vOqyQtduQ65DVGtZrrPv1X+ExlF
         glxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXdZhCAXl/YPLluX+b217oaIUS3C82lBDYKPatd622s=;
        fh=/d4M6ijv21gr6cxMRV0NkeUq44hA+vKyTwiRbY3swvA=;
        b=S5kk5WuDJf2cMWGBAfZyMClAJpmz7iuAR6nBpUhFsUXfb7jTRZ2fDfJINTCgCAwsei
         tZmQczOBj3tHP22nRPh181G+1IzO3pd9GXBK5/BBBkqAN851mK/yJufX5+vRBdNSe+Sx
         /+SbY2DMItJd/gz5KUlcd6Ts8kRRuecdgTxUkeGtXBT0WqVrIB5pTgD8Lc1w02DQvNnA
         LSiAqseEIPRsYmPayDPjYphCIzT1jC6dKs0h4Z2VHY1XKpGIlzCLrQZuDPHIa2HIUhgh
         IPRRDoABsyUqrR6WAfF7Mi0LW68UoOyVAu+I+g1/P51Z35afcK7EqKY2M6z80gkmD0mT
         48lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788184034; x=1788788834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXdZhCAXl/YPLluX+b217oaIUS3C82lBDYKPatd622s=;
        b=lRp5bbzkRDRp1K+S8y1GX09DnnKFU7PE1Gbf6wVUdRHBAavcLK4s2XmKkW5zbMKSUK
         k6b2AzuuUC9a7Z1nvd3ZtIdvJdHipXL1J/VlYPmBCx1NiiALUOaF5dPz/a496trHg7fP
         chBjZyGRuV3NAxUkFIASlQW2GilvxdaVd+N9cTSaGr6H6Xp85ws7MyjeWL/sI3eB5VXc
         /7EcPZd2gmttVD7+Li51Rynu7ka0bZ/3j2Q+422slcn6kD7sSyGPEzjjpp25mnyuTqt8
         L2eMwDUbUrNAhy9+xgz5EAq0+G462Ra1/xGYwnCNWRb/7Ds9favOJtVkBQJYNin17pzh
         IH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788184034; x=1788788834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXdZhCAXl/YPLluX+b217oaIUS3C82lBDYKPatd622s=;
        b=sgt5BgRDLqdyYtm81MMgjK6Hh7tqTTw90jRM80csaPbHJvIY3fNLEHKMK+Cz5jcJpr
         bSXchfoVbSGhbuu8/4nss3uEfuCMHFoYArraiPeGjdgPrCvsA3JHF2NsA1eH5pR0lrQO
         MkR7U40T5auvgMx/DY031OuZhQqmH1SpSexsjLWjnvGqSE1rxOIGdOSnv0RFiGQlLCoV
         UFqClQ7vf4sL5qkl8GKUfereH3ehIPiHE+8dJpV1aQ/amQgrmRUCTcdB575lid+ZXUcP
         xhqQsyHUz4p5GbRGU4sXhZy8UKS9YxX9+0bItvgh/VT9HK1RjQGNVhMdcNtmAVpYRCTZ
         5vrA==
X-Gm-Message-State: AFuF++kMmZf/vhRrklebBn82fiizaAEAq6rISQLSD+MWA94J7n3LNJX3
	hwRJ7rH3B2L1SHw+qAmtTXX/cbHKZhuya54rGrh//5rz7Nc202/KENS76J5eGNnFN1J6gMcy/rk
	D5pdZSEi/Sf8prDsl8AEpp09zmMLu7DU=
X-Gm-Gg: AR+sD10m0MqK2z/hwXnME8PZHyxxTcYG1KKBYT0PvWS123g2lHh7vsWm+lWcp+rO+aH
	L9IwBA847B+E5a23EnO6BhAq8jDntGWKmEt4vAzUhbSnmWDt10OYR26enQCOcQuR6sHj+82my5d
	bTehXCBx347cGW7bI5seQ0i9AEo9Hpw0zXEkd857//WRBUTyDqEYNuTdCVodI2X1+7+R47NvWyO
	fwh8CxhcoNJsLNuDordbziLQsuefvdixWFPI1P2rBZ6x6snZrmjlERyBZcju3XvIbAm3cREq38w
	8X1FDY2nxVuIgnEhi2DUHBToQHs2Lr6Gz7ILkF893chwEA==
X-Received: by 2002:a05:6870:9d94:b0:46a:9a34:c571 with SMTP id
 586e51a60fabf-46af57f1aa7mr1054584fac.19.1788184033715; Mon, 31 Aug 2026
 06:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829213256.51527-1-kmehltretter@gmail.com> <20260829213256.51527-2-kmehltretter@gmail.com>
In-Reply-To: <20260829213256.51527-2-kmehltretter@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 09:47:02 -0400
X-Gm-Features: AcwNN1XH17mTpK2KblerbVrKlCve1RclfFZ2A5wUG-rwX01P42n-jv3618nmM4k
Message-ID: <CAEjxPJ656tz7PZuVfKU5W6tBU01-Y2+EoD3wLQBanDnj2CbXng@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: preserve user SID across nested backing files
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Baokun Li <libaokun@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 5:33=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
>
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } agains=
t
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
>
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
>
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
>
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy.  The original test was also repeated with Fedora Cloud
> Base 44 userspace and gave the same result.
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
