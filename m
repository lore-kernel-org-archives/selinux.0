Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1446AA94
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934438; cv=pass; b=lfguer3dxvo0lU3GrL7w2IpfQm3FNYllx3v2N9YvUBT87YkyJIfIfQHCXU6M8vhxYqn2NutOgjOXOsdvBXyGKrAm/UQEMGdc1tOvFVG6iy2ygSlbsg5VYkHgKSJoS4leR5Is/99KTPuNweFybiTmIG7UvZU1sWdLw9y0fHapCZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934438; c=relaxed/simple;
	bh=H4jEaPAHGR6jMdQkH8WBCqNmz9NJyG5Ph8ygdPgshnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oK3X7nkX8oL13t/vZLflHldvNmG4QGMpUTdvhtbhO+szo75RjBCywgtsYAONmkQc+TA4qS+32kPrXaYTkfDHpIAEkQE4QfCRtxJt1tYQgLmX5zzePu1mWzsNGU6ohyrgsheF7NJTdrjWSZlmFc/Bq0KzmDRMbWbhphpLpHnci6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpJ8PcjZ; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpJ8PcjZ"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43bf9548df4so570427fac.0
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 05:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785934436; cv=none;
        d=google.com; s=arc-20260327;
        b=efWs+zVGdDqdFXFvDd6ggnYz6Uz0XBHC4X2c4+fH6UwRKNdn2zCtuUoIjAvP4lqB/D
         f2S60gJV9ZnsNj8119WkgCirLpb2VWStUZxe5/CygJ0h2+V+k14CibjvQaTcpPxKCNHj
         CFczMI542aD+cdmN/znh28pUob+v/4iw1j83x86tWuNa//kp4S8uEUU4WJLOi3jCB+/8
         cum2oC6Fi5KL4qRQFlRPyxzbgWZlgOwXwgqN+TGKPtPdyVpdsfFOEIbfcvkrFpPf8XsF
         pA19OeLI++C8oRrk0R5o5feBXeV2n7M7eZcT5KMQJtv0/IK8rd3FrQB52wrEPwpMdepC
         eyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0f7q7KqG10ky3ulmwOFrTtoXKMRlloXHHZM0/JZvM9s=;
        fh=ioEzxjIYy2lWKkptRdF8KF1tkY5XGT4L4QJl8Ctk1RQ=;
        b=D7fciU+7eoNwLeIGOsnkSgzfF5PRz7Vd8D2NSAjgHoWLsNIuA03jalKJpQviehb6nm
         5b3M27lA1quz7JqSQPMQwABdtdKzP0H8voxTiApHrL1nQScy9DfGJ4HO/tYxDXM5/Rxn
         raFiYFLvva0wFeP5CJbYkxcppKB1IEBifRQwmgYrGQNNHHE983n0ZlNCw9JcWEdUpFxb
         JZ1ZeR8yFaxNfasS6WJT5GKUzvJEbUGBgdEJH41eglN3lKqbbckD7dYL4DfHbc8N3kzb
         OvLC58YlALJ6sgPOEEB8V0aEg6AAfzltJVsjp2Ij9QznWu/MUzKQWU/FB5Xvb/OrMb+D
         XPDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785934436; x=1786539236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0f7q7KqG10ky3ulmwOFrTtoXKMRlloXHHZM0/JZvM9s=;
        b=MpJ8PcjZ0oDE8sH2uty4E1yFdf0hCY5fssz3+WWPtZFMZzjJCO2/2kKl7Fs8AQjxzl
         4ERkFYVrL4OmufQfKsLW5P59jPEw63ekyWFXrsi2xhYJnMZ3vu2E/MwzV4xuIfcWUkF4
         QyKs1BEXLDTAMbNqVHIWBJyeUe+0cYiBHd45/2TJlQ7dFZec/rQwGXZ8JfAhX+PsTfhb
         ZXNiImfUm3QJ65eLp/O2D6R+SkVuVsCeSYOL6IDdQoyiXiPX0sM8oY2uVlw5ca8tAohk
         ellAiAj2pMF9/835stabBuhNP7TRNM4WIGa1us0hh30Oed3YQPaJd7P8WMP85uh0vz4H
         AMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934436; x=1786539236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0f7q7KqG10ky3ulmwOFrTtoXKMRlloXHHZM0/JZvM9s=;
        b=X1agowv99MqGCUZbhelH/om6+ypNKpSqIupMM71mh9G58j00z2mrMubb8sjNeC2bVK
         lyiQDwX/w97z0b8YhyHae0n5hul0LRY5z6TGX+qJP/VPYU3sQLy1/BJwWC6QpIPdoqUu
         jC0bUwmadMlJbFKUqdbb2cebCc8jwpywrsOlwM4nlw8cTEy9julQY7GSYy9DkUYvvHhH
         uFQsKRMrW+tiUCWu1SAos6WF9/IuxbLuIFOtDR2/e2+xpv5yYYR8pjpNLaQD3fkkTht6
         6h1PaZna+sDQRctwPpS9DuRcg2YvHrouAyw139hDkJFidqKNPG93lg16yQCkrFkwxXto
         lgtQ==
X-Gm-Message-State: AOJu0YxGq3sPuz9jSJ+a75bv3AJMSx6fxSwvtNIzPup/Py1NiJWCmx4H
	Kl7Po0WXFp7mhpiM1yAnh4Re0DMA8IXVHiMxO2/YiW5MI07Ujwvxq+xc/Ok8RwkRtfV0SH0CNM5
	kL0OfJm5+svN8KMxYEEDFnmsSMJz2f/kcyA==
X-Gm-Gg: AR+sD12xa4gTArN8STMa7TN45hDQcqVVRtjcHT7/JasAEMphEFuQzn9dkw0Hjsc8t5u
	OUfrdiIRWx6wsgUEiMCcS7sKQxfcSkxaV+ZdHjIhFrwebszVRov1V1hyVa2izQgQJ6+I76IPee+
	KSgqn0rwvmX31W6RIbDJC6QA5kGVmpIl3NzFJ1gLWlOBU4jxGQm1gefjfqaBZBLLk6KD+dKyPh0
	plt/T6a4dOgEfjk2qaD4IO7/iNIDTGDWW7kodAHdv3rHTevDQ8+sRzzq7FwI7z+PTThmGRBPk+r
	+oAsjsplG+RP9MDMP1yjFfNV5Cp+xITBVMjUE3ECqkxB
X-Received: by 2002:a05:6871:6d13:b0:451:25f2:da63 with SMTP id
 586e51a60fabf-4599eb72100mr3522726fac.6.1785934435583; Wed, 05 Aug 2026
 05:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804183911.23819-1-stephen.smalley.work@gmail.com> <CAFqZXNvGzqF2JYdYqkcC=8XRuS8iZ=XdPMYg0BAW295txtrNXg@mail.gmail.com>
In-Reply-To: <CAFqZXNvGzqF2JYdYqkcC=8XRuS8iZ=XdPMYg0BAW295txtrNXg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 5 Aug 2026 08:53:44 -0400
X-Gm-Features: AUfX_mw_lHihS8IJZoDOvvgyqDIWeM-8x8GTi02a_d9jMg7tD1Bg8o_JjhnRgSw
Message-ID: <CAEjxPJ7bdnbLFH5bcWaBgaONhum2DwyaMu-8Be_7Ktm3-hz1Zg@mail.gmail.com>
Subject: Re: [PATCH] .github/workflows/tf_testsuite.yml: only run on SELinuxProject/selinux
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:53=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On Tue, Aug 4, 2026 at 8:39=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Only try to run the testfarm tests on SELinuxProject/selinux; anything
> > else will fail due to lacking access to the API key.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  .github/workflows/tf_testsuite.yml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/.github/workflows/tf_testsuite.yml b/.github/workflows/tf_=
testsuite.yml
> > index 7e3993d3..48484496 100644
> > --- a/.github/workflows/tf_testsuite.yml
> > +++ b/.github/workflows/tf_testsuite.yml
> > @@ -5,6 +5,7 @@ on: [push, pull_request]
> >  jobs:
> >    tf_testsuite:
> >      runs-on: ubuntu-latest
> > +    if: github.repository =3D=3D 'SELinuxProject/selinux'
> >      strategy:
> >        fail-fast: false
> >        matrix:
> > --
> > 2.55.0
> >
>
> IMHO this is overly restrictive - a contributor may have a TF token
> set up in their fork and this would prevent the test from running when
> they push a branch there (they would have to commit a revert of this
> patch and leave it out when submitting upstream). I think it's better
> to let it always try to run and suffer the failure when there's no
> token. We could disable it at least for pull requests, though, where
> sadly having a token set up in either repo doesn't help.

Ok, I'll drop this patch then. I just find it annoying that every time
I push a branch to my fork it tries to run these and fails and
therefore doesn't get the nice green check mark overall even when
everything else passes. I noticed that the CIFuzz workflow had this
conditional and thought I'd replicate it for the testfarm one, but
that's fine - I'll just live with it as is.
