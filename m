Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD840861A
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676453; cv=pass; b=MS3nKrEpIyQk6T3UH5e6NwIXKe5FzlGfJscZhHnSQzePR4ZdaT2gN2C2fIjc+fzqjC5rPU8PYgsl3z5IBLmFBIgfyznY6S/eiQbGB/n7laEb4h5yD3/U1h5qGAr9ZzfkNPFMBvj2QyaiVNFfuLIaMEebFB226ubACtQezGJyOzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676453; c=relaxed/simple;
	bh=ZbJGSHaCl9YdGNOal2yb5F+JNV+a/BQBQq7vevv5eiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7dPF+xwydXv0YL5zc/NU9aj2TT82s2MsKolABuSLfu+DzNn8vSqGLNw1G0z3tpA09uwtPcO2EB0GNnrJq/XYRGM9zPnGWvbM6czkIbF6MQMnHbIkiG/efC2CHmUFG6azebpf9uOfX2SBUEZPTaS1M80NFgO3UvCupp6viXE5pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nksNchvC; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nksNchvC"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f869421so1575074b3a.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676451; cv=none;
        d=google.com; s=arc-20240605;
        b=cXkTqqLG42qeInDDPcX2XRbQ0JzSgHManNBlmiTH6YN0/88t/K1/poN6bE8aue+SN3
         /c+mcLYgo+GQi2Vh1XLjWbaN5cCrMK7eRnxGBjv8fT+XfYfijA53PdvJpFnqkSiqdYzr
         61lfBNujmdR7dOK5rmk6TqF4RhGa21ULk6PfLosrp94f4Sqi8OEGPNa/RTcGimBQSwDf
         ZU2rF/HF5uNYKvsoA1CTeJaENqXxHmciF5Bt5HXscpCD+zIjEMgLKR0KMJS6HNWDydg8
         5/4dRA30J6YqY8JQD5qxZI3uUDmfmf6UaJgeTxrPmqjRIXDZaB37Utq7e3IbQtMYgxJ6
         xk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QkPIKArl5iCMR3iyfyeMxzpAFUzHzqNuwG+5cNrzVoI=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=RVCUftrHt/ulTccfdcpHbuNuAMGre79jx9b0QSoioNG7GiOg06BkIbroV3q3iEi5JK
         crKh1jYuOWS1SjnWuH4hDDY/odLyXVbDu8VaIVPFvIQ7opsUWTXLS5mvvIr3r49thIjb
         x91GyFy+4oybRj5gYlkYGMF7FFq7c7Dj7xKM7LCDEC3VAAF1pr0YBy2nJktwYaxZDQtM
         VImnmD6XHaAUg4SQzxWmOMNWEDCA4m39QjVebOlJY/9X9n1hcL44huT9QcCfv7HRPqow
         68GzH0ATn4RFo0pNSyPwXYkAdUpHoiFBaIesArqalKaxeaHebDbW8SSO7Sse/RrclQ0b
         3EOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676451; x=1781281251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkPIKArl5iCMR3iyfyeMxzpAFUzHzqNuwG+5cNrzVoI=;
        b=nksNchvCcBmMalxoWmBgWfOlm3s7n8YLsX6ldF1+EGJFe6SIOlI/SZPW/8eFsNJ2a8
         Fd1fRrWA/yUK8lqGafzNN49skLLP1OWDweSNaJffxmjDi/4AMxXhe2EA7mfpd1HqxGSM
         JCne5k3iEGKApy+WpSae/Z3iTgHBatVp7Jxz+ckmtT6nFvNa9ut4IOkZkF+oRb6lvS6Y
         MgA53uF6mUkveB06z74b/qWTdL5w9OId/t/LzW69Q4kpadeYsmT/Lp+2UPXUuzqvgpMQ
         9M+X+NE+BgBIWb7AebHRXKT3q3M+8c92AySMnkOmPO4eh296LDCWwqbMOkThTQWfx3AN
         wROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676451; x=1781281251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QkPIKArl5iCMR3iyfyeMxzpAFUzHzqNuwG+5cNrzVoI=;
        b=HeG43KZjKkrODzrt3RziSwv+f8zv55GgUGiTn+DjWZANovbO7pp/BqjkFv2P/Pzlxs
         Fp96Uvd95QcrXg7P2GdHp4CaNVjma6wflTP4Ay/mXCEfGD/L30WKgY4oVaB9xJXCbfxA
         yFmEGXXwV/wKtHpJPzN/PWGCCtHiUZwvugoJSzeDr3CLbglXKSuSL42uOoXtLT+kqM0S
         hWsdjmUNnNBa8jiK8LnWXogn6+FkcnLbozVc6xVfu8BJwm6ICTr/AVviTFQUK0sgWXNc
         CPoX+KyyiDYtX12TO7gmLNtxIswqbhI0L97GGLCp7dZe4Ce79BGyCEKrMGB+y2lwt2bV
         SBig==
X-Gm-Message-State: AOJu0YwxfZQNoyhw561dTLgYYI/5AOQAGMWZKJN6fPCJOSe1/rALkYMz
	O5Dx8FkhlJ9CDwPDO+bO32XSb4M00cSzBmBDq0c51b8RSwtBhX0Z+05Wz5xPf4txRYdDiUrOSKY
	588cGKDYYlidCSip1IBMm5xvGpQtCnQwrfA==
X-Gm-Gg: Acq92OF1fTjBcR75p7XkoI6AOExCT4BnnYzd89WTVGrOM1MoJfIipPh/au5bOb9AGAa
	qI4KwpRjLReRKmB780FVckyGX2Lyvx+j+1tqTt+JA0uyw3T6Ruqu71Gr9HLVZkyGVtv1RjemB9O
	ItZuFmLX7+OKIHWe7GoeT2qMQZ74xq+T5v0wtODrxt/NO2aRU18ol6tczHg9AjdS7rAugoIaNmO
	MUafgRZ56IUVrdBSLOsr4vRfCMr1qnE3b6bIOGSzbf8YRCpTcH9dGR9tbX5lJXKpuRrVFVkUTjf
	ls7K6orivi2tJLTreQ==
X-Received: by 2002:a05:6a00:4304:b0:842:2bcf:1d76 with SMTP id
 d2e1a72fcca58-842b0fef2a8mr4212012b3a.45.1780676451443; Fri, 05 Jun 2026
 09:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603093801.1070705-1-lautrbach@redhat.com>
 <20260603093801.1070705-2-lautrbach@redhat.com> <CAEjxPJ6GC5ugbBuegYpKTQXt-Hq0vrZ9DvyoRE3gOU=j96j1vg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6GC5ugbBuegYpKTQXt-Hq0vrZ9DvyoRE3gOU=j96j1vg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:20:40 -0400
X-Gm-Features: AVHnY4Jl4vYPgLcn4uxPzj2DgOAI2mMP_3fiBzLscqQFMUWWceZ2xmU4hPJovXA
Message-ID: <CAEjxPJ6QV7eNwoAm62hyYzG_FrdumvW3apqk8wfs+hDzC-EzXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add check_format Github CI job
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 9:22=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 3, 2026 at 5:45=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > Run `make check-format` on PRs and pushes
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
> > ---
> >
> > There's a test run available at https://github.com/SELinuxProject/selin=
ux/pull/520
> >
> > https://github.com/SELinuxProject/selinux/actions/runs/26875462663/job/=
79261408494?pr=3D520
> >
> >  .github/workflows/check_format.yml | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 .github/workflows/check_format.yml
> >
> > diff --git a/.github/workflows/check_format.yml b/.github/workflows/che=
ck_format.yml
> > new file mode 100644
> > index 000000000000..bb44e60a5507
> > --- /dev/null
> > +++ b/.github/workflows/check_format.yml
> > @@ -0,0 +1,21 @@
> > +name: Check format
> > +
> > +on:
> > +  push:
> > +    branches:
> > +      - main
> > +  pull_request:
> > +    branches:
> > +      - main
> > +
> > +jobs:
> > +  check-format:
> > +    runs-on: ubuntu-latest
> > +    container:
> > +      image: fedora:latest
> > +    steps:
> > +      - uses: actions/checkout@v4
> > +      - name: Install tools
> > +        run: dnf install -y make clang-tools-extra
> > +      - name: Check format
> > +        run: make check-format
> > --
> > 2.54.0
> >
> >
