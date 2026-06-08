Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C238238D
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946554; cv=pass; b=X4krxsiuCBWqVM2CvZjK3cdSPbBjHzNO+iBHecdG4pmFTK/c2JElj49TuW7hbddlwpzYSd2A4ZcNj+kRr8JQl+Kdd6DbzA3FzI8zKRmJ2o7iEFxjw+OJCqjmfR1HNkOZpqF+PK2dZrmXxjD0NHoy96XE8gapgmYpE6ehTDb99oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946554; c=relaxed/simple;
	bh=Xl8DQYS+PoYtsc7QTNmQScbBVRKcZkQdU31ig321prk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JClNwQLueAxEEwMUhoAGhxIz7IUT/AoGIpIBfJQ83LJOVJRlo4p1uWKoYCNjRmizxZsBvrdZXUTMg2HpWZCLP1JqyKhzLNUwCkohwlxH+cYP8Z+/hlBkzfYU9YzcHNV8OfpOwX7GM8lvsOcvyJQqsIUw4Js5Tn/mEWWnAas73cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPDQfeJt; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPDQfeJt"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39676d82b7fso46887261fa.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 12:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780946551; cv=none;
        d=google.com; s=arc-20240605;
        b=Gpw0DfgeYAU7P0FutSLMZj5lAtIgT/+JI1612xOOskJDu5fWoDdyTFdDFQl1qerW8L
         qBKy+cl4+RKp/ZlS4wXdmeoM2gW/Mb3Y4Q9XMglNaNgp8VqQbxx8r+x0BB1qmPThTkzb
         n363/2eE5cEym2gcgkul/gUpnuJUlRdjZjNV+cC9XGkVqGE+C5YDEaBmhBFAOGxl5Oie
         qlVIUFAiKrj5dlQdEnt5OJvL8xRVkrG/OwHCTiXx+37e7zbFnvtq7yiIHoKB5j+6OysP
         UlY+8AO25iInXXCNnvul3/QsPapy9AVGxxeDJu0meqeJWc9sHS1ou/J/Fw4fYWh+BgUf
         vZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HfFyFV6ETGEpnodGj1s7d1TR6dCorRzI6YkH8cZsEJA=;
        fh=sUqzqvPqLid9m5DJEHzU4XEAbh8jKuYePz/M4VIf3v0=;
        b=COL+7VzXkTxegKxzwPjFLypNB0FEj3243ixUSwwka4OHShkMrn6mMH/bRTmYQ2YiSP
         OOBOG1ZjzrXZylIea/X34J0yPRGSWhqNYG0qmx+90fVTCK5tbAvZa0LUdXm+3yEjNeBP
         LgFhLW96lNL5hjXfzlCOY3f28IRYyNF99T1ihmdtbS1+gB9jJUvGU4gRlFUs/Be/0fkN
         sjKWoZv1L72T4kzz9Xq+qp2XWqobxl4+QWedUpF9L5FZa+Ym1XsjGffIcGMp5IyOCKlb
         xDCeaYVs0/QApozk/baauPW1XBg2pD6ApHyP/+qrb3LwiKJKriTfbhMkzQ97owB1XfjX
         NtlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780946551; x=1781551351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfFyFV6ETGEpnodGj1s7d1TR6dCorRzI6YkH8cZsEJA=;
        b=gPDQfeJtiFL2EcNF05yGBdHidwhq1P4CH8pyYnc2hjHIbEqYRLHj02Ap4g5Sye9Ltt
         kqefLKSh/hX+wtPqBZzIFMLHnmyTs3zMvT6BDCAbnlya9aLB+SMKsZynA+0XBsmvVtdC
         85qhEPOz/9FKMrIGc/13R5Ryy02/CZJd6PbkfMBudnq49J9fIf23ajyy+kqlTP7tPrBz
         3I65LTx3v79CY4sOdqqX73mFX6/Him2z1MqJ3M7uRFNTCPgvj2lz67tSh00lYvpfAwtM
         sDqoH2kuMfQJ6Mp0Q3VpXyPwokhV/oEUgfXXpmkIsHfduyuW52ZZEpam4D01/IVfcNfq
         Qvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780946551; x=1781551351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HfFyFV6ETGEpnodGj1s7d1TR6dCorRzI6YkH8cZsEJA=;
        b=mJhfDcMBoT1pYp7iX9FcnVeI7O/LceHd0BOPqzbuKSF98OFOnE7eDq4rTrnSGMSBzI
         n66bnEZcFs+MeTc0d0DHToN4nFWGcKlKXcQKG3AiSM/EZHjYwtVbWA7ttuCOmi90Vpbs
         +tDZveEhqUcZ/bzaixsEDw/HrP2QvNw4c67PtFYbM9XzR5jePaQvCMWlJAiPVGUibZ+R
         gzaTGnShHpicDcrEp99Ui+6QwbH40e/DiBLSPAtTP6JEYfNfV7gaFvXmvNlreiBTZHyl
         NqQzvR1EnV/SFIVWE2lmWpe1/bRr4hEL7NPXNT8mO+/8B+2yGDl19aakbUscaYnhf28F
         YTGQ==
X-Gm-Message-State: AOJu0YxuxKdbDErJszm5hvX7PJ2zIrbW4tRa+LeI2Np+miOtkY1hb5Gw
	z5RdSPoDVNcDHoXRPRjqfKp8yNwFV1QGYa7UZaYb/f0Gri3gIbKVDKsnvvZjMKmToo6E9nLejp/
	RTPH8jZ2NVNzI/l/tAwWtfo1BM1hiW+0=
X-Gm-Gg: Acq92OF90KnVU2oQggRSrEqUYp61+BY8RMqw6D7iQmo6VyAsfgCkFfw2uDsKXDuUdRB
	NsZthgWofJrY9/7KuqAif4tnWbfuNyZH53JPaWY91OdyvPPLsgsTf4V0bLKgSnMwZhTOLGuCSBN
	0hJ43Vwkc1GXVhFByEuWb7eVNGz8mSQwfmCfMDQTIC+ebPqOiRjCMvKq6DfEP+q5kpBmtMqotV3
	N+qEjEuvi/r6jPKFkG4nocU6lUc4G2LX3QX41dXbTlJu0k7DVxdBLwgSybK43cLFbCegylMdDxf
	VmdLdJJUshxOPZhgkot3uV7jBQ==
X-Received: by 2002:a05:651c:30ee:b0:395:2467:9e74 with SMTP id
 38308e7fff4ca-396d0840298mr33676731fa.14.1780946550947; Mon, 08 Jun 2026
 12:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605184558.280873-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260605184558.280873-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 8 Jun 2026 15:22:19 -0400
X-Gm-Features: AVVi8CcmZN0FkNqy1fj-B5U4UbCA2XNPP751Ib8z2A_O0IW1WD5dCb7jDl344kw
Message-ID: <CAP+JOzQ6ywdzxBzc=P+JLoY+sXjM-r5LucQ1WjRZDKvAYbXwDQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Do not clobber errno of the world
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, 
	=?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cristian@rodriguez.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 2:46=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Cristian Rodr=C3=ADguez <cristian@rodriguez.im>
>
> libselinux clobbers errno of all consumers (systemd, sshd you name it)
> because its constructors do not properly save and restore errno.
> The following program demonstrates it.
>
> int main(void)
> {
>         assert(errno =3D=3D 0);
>         /* Just a test, it doesn't matter already clobbered */
>         if(is_selinux_enabled() < 0) {
>                 perror("not enabled");
>                 return 1;
>         }
> }
>

I don't see that this demonstrates errno being clobbered. errno starts
as 0 and finishes as 0.

> if any function sets errno, it is not switched back to the original
> value and standards DO NOT require errno to the set to zero before
> entering main
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/445
> Signed-off-by: Cristian Rodr=C3=ADguez <cristian@rodriguez.im>
> ---
>  libselinux/src/init.c             | 1 +
>  libselinux/src/selinux_internal.h | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/libselinux/src/init.c b/libselinux/src/init.c
> index 499e4e44..abed3088 100644
> --- a/libselinux/src/init.c
> +++ b/libselinux/src/init.c
> @@ -145,6 +145,7 @@ void set_selinuxmnt(const char *mnt)
>  static void init_lib(void) __attribute__((constructor));
>  static void init_lib(void)
>  {
> +       SELINUX_PROTECT_ERRNO;
>         selinux_page_size =3D sysconf(_SC_PAGE_SIZE);
>         init_selinuxmnt();
>  #ifndef ANDROID
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index 6089463d..ff191c76 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -147,4 +147,13 @@ static inline void fclose_errno_safe(FILE *stream)
>
>  #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
>
> +static inline void selinux_reset_errno(int *saved_errno) {
> +        if (*saved_errno < 0)
> +                return;
> +

I don't understand this check. errno should never be < 0, the
saved_errno should never be < 0 either.
Jim

> +        errno =3D *saved_errno;
> +}
> +
> +#define SELINUX_PROTECT_ERRNO __attribute__((__cleanup__(selinux_reset_e=
rrno))) \
> +                         __attribute__((__unused__)) int __selinux_saved=
_errno =3D errno
>  #endif /* SELINUX_INTERNAL_H_ */
> --
> 2.54.0
>
