Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79F27452
	for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083309; cv=none; b=W5/yxBZjN3Lyyit7suhvnXZYfOtHIbhyWG46w1OT7oCTS0tJDnSpw0yoRaDD0NuzoGCpoOM1nBe0LP1RnZgGL2sPf74SPoITyac7ST3Mfe2jPoLK+k5Zqws/6ty640fwE86/ba0v1wzgEe4IJhr2NSQ/kaFVWDxA34tC9f/8jr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083309; c=relaxed/simple;
	bh=WljSzM8rOU3ggTGDfUKs5i4ksmR0f629Z7Xt/1pKCSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrYLHuVh5Sudu9lnfCOknXqGRbw5y0HFa+Pq9c/Fp6rwRwh9tEueF4CTQe15x7Yspw0fZgAXoU2f5A6uvjprSHQ/kTGTvGx2gSxlHmuZ7Qa15IlBdHmg/PhjSr5scIbLCWSZBBB6kAs0aQiGGb/RNbZVthkTOVkGSgFxgY1i0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YplcAkyU; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YplcAkyU"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4b60c221587so3330387137.3
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738083307; x=1738688107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01WBDB08O17Uc78F7jlYNIhW1MEMZthkNiFwxqp6LLQ=;
        b=YplcAkyUebKpSN3VhSzeEA+YQIY7nEaAvDPOGaCzSDFVqPisbriWLyQTM9j1C850D8
         0SRKL1W9AIcqM1Ye1TgP+7U8qzcyhv/IZFkhIXmrjfT4c+zXJP5Rmvvp+xIyzJOnhp+R
         X6gVcaejuy8sChpEs5KEj3t/tePDZAn1hBHFxxJKGQtliwkQMjMXj4ckm8tQ2XZJ1Q6B
         5Qtvuwy1I4dNLtSfUtgHnb3eCc0GSxKkTp2RNwYL1OJp5kQez0UlHfP727QOC8TjLiu/
         4B0dLoFGuTpH8ymHX5D/Qa2l8MMVpLCKxAga9h46jWIhr0YHSj6gjI03uvc3aXI2NGwT
         1RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738083307; x=1738688107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01WBDB08O17Uc78F7jlYNIhW1MEMZthkNiFwxqp6LLQ=;
        b=dpjjFLNuM02x5FjNgftSb/5bN3xp2dn4EwaNBhVOZC9XR3Q+MficvI5KTilp2aM8HF
         WZ65W1NB5e3Wy39myfw8UozCY4P8f2eUHoXBNEIgpv27fyQ8+DbxZYbz+XK4i+L+vEtL
         JWz5fI44f0QA3AYWyfUlVrNMirUF2DuHJF5+dXowG2kX4owapoXBMvzBxsqJ4vcItoVS
         xcEjUy19oRfKtM/sLvk+twnqWWgemg7aFR37FNuaUUh2sFN3v1OoJbZDsBeVhf+oxOLV
         zI3i5BINDyCX3+cOopcZ9kZWRjIqCTgnN+sl4faB0+ASytzgzdaQH2bwkgXvQ5b3evrl
         X/BQ==
X-Gm-Message-State: AOJu0Yyjamt6rPHtAGj4/xaLW6N9fDYdjh5F6+38NslsHQA2PIqOSwcv
	p550l9i7BbM5ArI3VEeDaSOJLGm1wZsCyFJC9j0Q2msQdrYrZ0kZXs2YIDSwzycWv9hWhUcG1q4
	BiiSvaUw1UD17Fd1A0cublkpfbM+lXg==
X-Gm-Gg: ASbGncvsNvLZGtQ+Wa4hYVjqWg/UL2ZkYrKLdSOgpGZY4HgExchVXuUB7/Uh2GzGd+U
	socMK1EOMtCMHJD5GvwTni5d9PDx21IQvrKGcLsyjOza1gHx+NlemKA5fp8wqXFXdv+ZLhCyC
X-Google-Smtp-Source: AGHT+IHj3WmwZppc5CyB/urJY61Gz66q6lrwh43dU2p7Afo70u7UwOaZccDCC+qilEIcB2Xw80QnpN2KP1FbuGtinkM=
X-Received: by 2002:a05:6102:390e:b0:4b0:c214:fbd6 with SMTP id
 ada2fe7eead31-4b690cf688fmr41100962137.23.1738083306862; Tue, 28 Jan 2025
 08:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877c6f83bz.fsf@redhat.com>
In-Reply-To: <877c6f83bz.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 28 Jan 2025 11:54:56 -0500
X-Gm-Features: AWEUYZmoXIhYSC9AdvDaCM8Dy49VwmkIE26NITQeowK3mEPC-pFI_mhxQNovAEI
Message-ID: <CAP+JOzRcyZZFA8BL2tWy4QEe9OLODcWDM_jdr50=2nM4244pgw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Possible solution to possible regression
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 8:39=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > As reported by Petr Lautrbach (lautrbach@redhat.com), commit d96f27bf7c=
b9
> > ("libsemanage: Preserve file context and ownership in policy store") ca=
n cause
> > restorecon to use old data.
> >
> > Here is a possible fix. It seems to work.
>
>
> Works for me. Thanks!
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

I merged these two patches adding details above about the commit that
caused the problem.

Thanks,
Jim

> >
> > James Carter (2):
> >   libselinux: Close old selabel handle when setting a new one
> >   libsemanage: Set new restorecon handle before doing restorecon
> >
> >  libselinux/src/selinux_restorecon.c | 4 ++++
> >  libsemanage/src/semanage_store.c    | 5 +++++
> >  2 files changed, 9 insertions(+)
> >
> > --
> > 2.48.1
>
