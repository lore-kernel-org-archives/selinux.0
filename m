Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230991FF7C8
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188147; cv=pass; b=TpR94iedMpER78p4G0njCiuJUjdMquHWMaiM276pzdSrpKT1qfGO/zTlqtDBAbJgH/zS4vbfmW3D5KGaRabfpZOFunh9Bh9IRPfcqhp/Vv2bmWhJq7S7BcnHj5zKHKlITpyA0llNZKKmHkaD9U/8xWrQL6XnD4sfowxxjTFIIIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188147; c=relaxed/simple;
	bh=LlZSu35SdEkFTchoJeKClehaFsncgBpKk6kiwf2T3jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSGpHHB/DYnGLFyE0Z2MwIZPiyt25oy9lDlWU6pxPv2YKyfUt6JoQnK6CaCx82UGQvAPawo+ocyBvZC0+4x0atyOIEuo9DaL1XqrU8P4LZ2cArEarHnXgfDde4j+qdSTw2qNQFDAXJ+WJd15XvMeDbqsAEobO8IcRBC9X4pt0dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PezknRGD; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PezknRGD"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3870778358aso49291331fa.1
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 10:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776188144; cv=none;
        d=google.com; s=arc-20240605;
        b=h0spfKIiqFPVvCeq3PGglc3UkJUL8usuxjcw9kilekzlQgeES8ICLKSoQ4Ee1r1NJm
         ra28+oOesiz4GnsB0AkP+ZdHbFESjZzPs8m4WOlgMGKoe/JPnR6Z+Vo1LyBxSiqYYgdt
         qHBYU+bwiQJwdH36gHJ3fzjAK4WBg6nC78rrUjFylbMQ/Vu4xM8EfspE5d6UQwgaAjgG
         WkL/pejOicMo7ShbqY9d3znpdf5kBFzZ0cGgIClgLmAbzdSN38Pn9r9rYpRNClU3QrGe
         z39mdyqK9aTstBss/KmYcbVIcOFb/Qld41Rb5xSMgfv6OT3TQgX8JV3vfPlPw37klVks
         PI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aB/EAVQKarIzpcrYQq2dFwiCwXmkFzsYSdr1UxATpfQ=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Tc9bp+BBvQINC2L51/RaGVcl6XxbxRN0dZkHTHu8S9BX3Ef7/vGHfAyTqLqbGUniij
         l+KI1XPrFqa6RJ7RgV+HH6eiaBGz3GqbqSf4I2uYmwKVu9I5ZLTmlKVgk1CUYwyzdEGU
         4VOY5toyx98WLbV7o+BUv3EhV3X6N+z0Vvm5ALGx3Ex0P4GJVL0eQHKK65Y7P6JyE6M0
         S3QW0S7m59Hcc92rQTxyYdT439XceFDZezQNjECH0HsEInDiVmnGGgMV+LqfcianO5n/
         eONsWoVYJwggUYA219SXAJBORgw+qMAVgLFnik0csyW42YfgUpiwnZUN+EnCJ+hIPnVA
         DquA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776188144; x=1776792944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB/EAVQKarIzpcrYQq2dFwiCwXmkFzsYSdr1UxATpfQ=;
        b=PezknRGDvQ4RpFIMa/zMEChjfXkae6HQMPPmK15uycrYbKa1GJ7aJvl5xstBRjmPZs
         cHlKRp7o7QPxrv8JgZZVqDkjXwSh89VbOT3ZL/BOl8i8eWw6fckc8Xp+s08ZIVtbrhBq
         Fwi9VOPK33yXclTXDqR6f1L7PMPCiLatCLFePupR7WLiavDRvQjmAhLpUlvGnd6o4VGE
         dFCqqja51WLAfbIGNz97X2N72f+bZJQ8hKt11Ke5WZ76lHvtfEqmUH5uOkYR2Yd39Hvw
         Sz/aUsCsE1HjNQ7tXv/7uy3dwqaF5BvENEo+J0mWfKsgEE8duPBSDzTqb42nbemjWesi
         7eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188144; x=1776792944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aB/EAVQKarIzpcrYQq2dFwiCwXmkFzsYSdr1UxATpfQ=;
        b=RzZ0H3U6cyyi2BdQ5xQTPbEgzgvmbhfMSrYRw9OSCS6RgevtfH50mChxi6docTF2XQ
         alHYw8MNPqh8wKRcWAkO2fkp3O62HYiaff5Sn8ZTKjm9hoZOIS2jR0nTyj42CPfc/TUI
         1pyGZG5nPCsO2cmHHvY/83khnpZGEF+gf7DggJKHKwOXdQaHtrpvBzGI7Re7o6/r7o0g
         fIfoEm+hT5j8lovAJf7hsFHs+T9J5QvDh7PV+ukOzoVZyH9swDPHIEkU5fpkGjuevkP9
         XO2rzwXdOKzG4jT7QAW6T/MYgcBT5Bc2NcRAaIadBGLFTf43fHvGuqmQ8oTdPDNGyBJJ
         Qs5w==
X-Gm-Message-State: AOJu0YygCqN0CIappyCAnvREGkBF32lF65ZBZzf5mp6BcirMspcAu1DE
	FKaU245WkC8Iux3QtwgmLxzeQicrus49CFu5YzP6vaY25ymCPAIuyASz2b3ljvcB5sip7KX5rmI
	UGmBCRMi7ggIzr120/mVQtn+hoWnggnd2og==
X-Gm-Gg: AeBDieuLwyStMj8J1lSglMg1WNH/2DbPoGwSg3aaXaiBmUacOWL2KUuW/m0Km0OwKtz
	ibAocB5Qe4gPz7LfUlZrnLProveD9lgzWs1J9xsmWuiX+MLI3wr2sGL8fiTTqZiUFbxrqzfRio4
	k8NS6vy0RIewTc4WutDDwAsKRBOYFVou5/jWTnQcVm3uGiCtgkA0dUjKNqQVrGxSn28SY58t5vG
	/dsq3cnKzYq6bQCrV8/o9/5TTwpmMsJwTAcyQhdB3HfXI97jle3M2Pl8JEr1FXnYk9Wf/3M5eYd
	v0Zd
X-Received: by 2002:a05:651c:410c:b0:38e:7b10:fdc6 with SMTP id
 38308e7fff4ca-38e7b110147mr20843321fa.21.1776188143990; Tue, 14 Apr 2026
 10:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202143554.97209-1-cgoettsche@seltendoof.de> <CAP+JOzT4pYTE4AZf3mRrrNJnX0y6r_Nd7-+day7yM=O_B5+HBQ@mail.gmail.com>
In-Reply-To: <CAP+JOzT4pYTE4AZf3mRrrNJnX0y6r_Nd7-+day7yM=O_B5+HBQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 14 Apr 2026 13:35:32 -0400
X-Gm-Features: AQROBzALrzKxXzBp2-lAQQ9QIRy1Djf3wiRkWdIKYKRuUyPMSnJID5XRmWMCL3Y
Message-ID: <CAP+JOzT0goR9yNyKj0PcjVRTMp34vxgJ18_K9tmRLFgwPMMOdg@mail.gmail.com>
Subject: Re: [PATCH 2/4] libselinux: support non-pthread build
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 10:19=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Feb 2, 2026 at 3:21=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Consistently use libselinux-internal __pthread wrappers to re-
> > instantiate support for non-pthread builds.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/selinux_restorecon.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 34927126..b1f6f672 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -905,7 +905,7 @@ static void *selinux_restorecon_thread(void *arg)
> >         bool first =3D false;
> >
> >         if (state->parallel)
> > -               pthread_mutex_lock(&state->mutex);
> > +               __pthread_mutex_lock(&state->mutex);
> >
> >         if (state->ftsent_first) {
> >                 ftsent =3D state->ftsent_first;
> > @@ -1011,14 +1011,14 @@ loop_body:
> >
> >                         ent_st =3D *ftsent->fts_statp;
> >                         if (state->parallel)
> > -                               pthread_mutex_unlock(&state->mutex);
> > +                               __pthread_mutex_unlock(&state->mutex);
> >
> >                         bool updated =3D false;
> >                         error =3D restorecon_sb(ent_path, &ent_st, &sta=
te->flags,
> >                                               first, &updated);
> >
> >                         if (state->parallel) {
> > -                               pthread_mutex_lock(&state->mutex);
> > +                               __pthread_mutex_lock(&state->mutex);
> >                                 if (state->abort)
> >                                         goto unlock;
> >                         }
> > @@ -1046,7 +1046,7 @@ finish:
> >                 state->saved_errno =3D errno;
> >  unlock:
> >         if (state->parallel)
> > -               pthread_mutex_unlock(&state->mutex);
> > +               __pthread_mutex_unlock(&state->mutex);
> >         return NULL;
> >  }
> >
> > @@ -1279,7 +1279,7 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
> >                 pthread_t self =3D pthread_self();
> >                 pthread_t *threads =3D NULL;
> >
> > -               pthread_mutex_init(&state.mutex, NULL);
> > +               __pthread_mutex_init(&state.mutex, NULL);
> >
> >                 threads =3D calloc(nthreads - 1, sizeof(*threads));
> >                 if (!threads)
> > @@ -1316,7 +1316,7 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
> >                 }
> >                 free(threads);
> >
> > -               pthread_mutex_destroy(&state.mutex);
> > +               __pthread_mutex_destroy(&state.mutex);
> >         }
> >
> >         error =3D state.error;
> > --
> > 2.51.0
> >
> >
