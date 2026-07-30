Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5C38DC46
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428573; cv=pass; b=KOPDXmwEQ42bTVjTNc22CGLYWSnE3H7dgUfuc0kCFhhfY/6osmDBe7IgnVlnZ/PhoXbkwhsMVqcdBjfBHiVEQLOI1KdLeqkeGHomW6zPgJfuo88mg/rXObow3AKer5wLWP2LNjBPxnVNR+xdOww8g8iL93dJjB5nBJFsQg3qFs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428573; c=relaxed/simple;
	bh=A/vNY4N4jm9QY0DtK4oFTSnA8UCDt4H8s6kf12A0sqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpMbpddn8fRDxk3f/nhcySOP7xea5YkAzIH5zc/MzmU4g0lJiIzfa27LUgu78I8q6hijTRrso3rSKmcrY+f+3cv9MrI+2L6UcBVx1+nBECFgFR3BttFrKniEfxue8SIoecsgvQUaFt7A+t3YOTI78byMwwM555Bk9Uus7l0rXGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/Tt3yaE; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/Tt3yaE"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a168dc590cso1488222eaf.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 09:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785428571; cv=none;
        d=google.com; s=arc-20260327;
        b=V+PO3OMBtTi2+hXGY3TS7taYzICYf9XTms/r5JDKPImwr2wtjjpFU8B6SsXHymbkQ5
         EKNF8INX5NmmEz6ANVPltsoDxeLil+RuHrXZHpKATbIcRUnvNHe4Rr4u2VFaoGQ5nWF2
         35083XDz7HXSitpDhZPw4q/8MD2H2SVjmpwZhgmWhtnf029paMfhdcz1CucOy2WPEu5k
         6ejh3y4ze99swiXyWsG5OizdenZsrI0RnEnr+h6ybc7voBMFy71wKUDkICDzXh3YHwmB
         yh1wHnG///zaR3gFG20WSh10Pstq/xC1calOq4U9330eFgy91cycTwjfHlmPHVCpxxpM
         lZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A/vNY4N4jm9QY0DtK4oFTSnA8UCDt4H8s6kf12A0sqw=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=V7Hn4R2rT3psMs0ZDtDkbUcB35fdBxgMpzaj2yZPKrciwILuppHTM+MQx1VbRi2OXc
         iNVY5/QMe8XYe8/OSaJpJKDiv/3BzeJTBqEvxBFROKTyl9sa0v68plTPBHg+krLkbh+X
         usGMjSKr/Pn4APaXkwtEzzQDMxh7IAvFfs0nJCMpjiv2RRLrFZF8SzxnkxXBRXLleSux
         pKbI6dhrBEAqzwlbceGj5BRMwFwjCDKR0iQq5tAxu6IPES5ysuBaN4spuJwTi9QfX3m5
         2SwY2c7A6jloHlL7856VvsbCOdHlj648TtB0Tue47/yEqmGx3GHPYZmjImUnxVaq7W8j
         I+VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785428571; x=1786033371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A/vNY4N4jm9QY0DtK4oFTSnA8UCDt4H8s6kf12A0sqw=;
        b=S/Tt3yaEavuhGB9noJWc33cY4I22o+GheTUJCrPqpiRPyIBoWkgVozRiTWjfy9yvUX
         GmmyUbFKY1CMLC20hOJCo9VdEbyIqoSHgO9k4VX9bmc3TJ09bTPOB4Ne8nopr18QIgs6
         EIuAaiAGasCdow/+V7jnvYu/Wv2rqvJzuizxzAcjooOxsD6XGdUHQpUNlDGXiRa7iFoB
         GrhFF5D2K7rox50SQ2TfPB1S+qI55UTaUe4oOo+vQIg9pKsI1Z+2kLyJoZLFLwU57xOU
         UoYv+2mSQ7tVa7/tWqHqEW+/Ac8+Xrp0f/djnC1TuhlwklpW7rDjTC4qW5oy+PWLVnXB
         nhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428571; x=1786033371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/vNY4N4jm9QY0DtK4oFTSnA8UCDt4H8s6kf12A0sqw=;
        b=XmxdU+p+VOXhYlUwNQlQFHjhwPHVwouBMbsbF41OtIkFiO3xFo4aS+ngDyxeJgmgco
         kPF58Z6m/esHXFrJuj/rVseb/0LXrY6XRS21RBfYfawX4nTGN1PdZ+Z5ceFc3YaXLazS
         C32yzkTF+jMBJGhsSCfy/8dM+vzF1p1LP7pLesiy85zgV6sMc9/R+L3ry1AB+nQkvtXg
         wMRNGi/IvpjknkwLS0hmAk+nnz0ZuXaTyKNBI4qo8Ya+G7C1XvzcHgU4QbQkuBG/MOHd
         eKuN/uu+hCELgEIBtaEddPI7ojQOyy6X8EfXyUxU5MjjnGB9kNcvWRamN6p9IWtgnpD+
         jIdA==
X-Gm-Message-State: AOJu0YzmSVd/hew2NX0y9yB5e+t+Govw5QS1kqkwl0p7uBk6Pnr1IxHc
	EENy+g+SWBEfGLG8IbklE36yPjvzDAnWigW4m16EyiUVfYtnIByN8AG+VdVaoeRtDxSXYZIbkYe
	o6FzORCY+WVT2Qcusr22GLTCx9bqPDiY=
X-Gm-Gg: AR+sD10Bx/72VF1qEKh0gIN22fiP3wxa9jLmsI1G6GXsq5DGJ5wD8wpIj86zYegGmdc
	YVP3lnsM3IVLEUEEbs8KwYfvD0y8wTiTChkHrGuiyHUUB351FJ0Up//lKbhv2f52oSDs4q3M+PV
	iZjtDY9RKhBcZD+iiibh/z8WoXzsX5aJ2qmrAef5Ot1CxJqb9omNQnhEi+rHJZ/l92r2l5gcCYM
	6cUrXu8Is1APVvnU7YLF8QjxtEFtr6ce1y2i3OGAnTI0dnSz4/ot1Q4P9zUKDTRHYlav+j2SQrh
	v/aISy4wsIB0NQztyEI9R+w2+eyJ1CtKuVS0oyUk8q7L8jLg2iyXf0c=
X-Received: by 2002:a05:6820:4a8f:b0:6a1:77ce:1b09 with SMTP id
 006d021491bc7-6acf828cc54mr515114eaf.6.1785428571462; Thu, 30 Jul 2026
 09:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729131413.1390890-1-pmatyas@redhat.com> <20260729131413.1390890-2-pmatyas@redhat.com>
 <CAEjxPJ5HrRc1k7U9dRBLb4mHbipxigrAsySxov=UncHndpmKpQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5HrRc1k7U9dRBLb4mHbipxigrAsySxov=UncHndpmKpQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 12:22:37 -0400
X-Gm-Features: AUfX_myeruIF3QESZg2Ur5u_XbxHoeBQcZ5iUcRzGUZtL2IL330yl5G2t86mZzI
Message-ID: <CAEjxPJ7J17x42hiG=58dm7cSEedxK_k0nJqst-_zuZFb8XGC0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: fix infinite loop and missing errno in
 partial <<none>> lookup
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 29, 2026 at 9:40=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com=
> wrote:
> >
> > lookup_check_node() has a do-while loop that iterates over matching
> > literal specs. When partial=3Dtrue and a matching spec has <<none>>
> > context the loop body used `continue` to skip to the next entry.
> > In a do-while, `continue` jumps to the condition rather than the
> > loop increment, so `literal_idx` was never advanced and the loop
> > spun forever.
> >
> > Fix by explicitly incrementing literal_idx before the continue so
> > the loop moves to the next literal spec as intended.
> >
> > Additionally, set errno =3D ENOENT before continuing so that callers
> > which test errno after a NULL return (such as the selabel_file_text
> > fuzzer) see a valid error code. Without this, lookup_all() returned
> > NULL with errno still 0, violating the expected contract that a NULL
> > result is always accompanied by a non-zero errno.
> >
> > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch is merged.
