Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890D379C39
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699686; cv=pass; b=Ji/RoHGNIAG4V4NIcZNw+DT8gFkY3sK9Ti+TTZJ7N/7y+ZCqfI+H138xVoUh8o9plr/2RAa71Hlcdd4dRxy7UB8koUmpskqtL/Rsa9aspPq567qkZpjx0nwvwkcN3Mx825fhTalgsUuxuFt+NhTmvJVIVb1N7Omd2hlq0IGOHOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699686; c=relaxed/simple;
	bh=ZS1TyC40nAR4t/M1xUTkzYR6fRFiD80PhEn64vnM9Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cONL7zrxriopwLlL5nicGWB5u4WtF8sAjTmEjMbzuCEuJueJeZCYygqZYh/vKQefN4VSOomxDhfDXge3hHZEWoY5wWo6bG1oMYa7Q0TFl6SPgJ9plgY6BGLSIwNaTzB1q/shJoS9UgKCllGGaMUyviGOFeOVPIon+YWbqFJR1Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooaSCwCe; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooaSCwCe"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab4620ecf9so6649017b3.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699683; cv=none;
        d=google.com; s=arc-20260327;
        b=RXQjgLePqWgEtzi6rgzgSYUVscTOd5r5h/Z7+3T0PXkjb5+Evmt32RrrYUT/HbK43d
         kj64KCsd3GdB1JloaN643V2xZAPLdWxTPIUPB2llRw3hECUyqtdUiHdBfwBN0Z+SJu00
         PFhO+4WKC7K8duq+7B5q4fAPVqgJHVjMTTws1AlZg81eTwzgwNkhnCu1ltKqgo9cbFix
         h/XYBPSiZrzaTTgvorYfAh5r8d1jqeBVaEqVcS3V6j16dKJnNqIc6cHj7VfRFLW5EJEo
         F9CxaWstDFNoJceTiCKuLBWBxGeIKsDZiSEmDPEEr5GOsG4KrX6aW6McBo4u8AZcogQb
         iJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vL6919hhk0fKil7KjsB5a/L4hlZiGRK9iVwf73Z8R/s=;
        fh=OwAMYJB7jfWJkONZCoaW1jFPjG00CJVq/UYDauTm7j4=;
        b=auXCXxBNBjRVYesZ1B92JC5v4swP1ngjZ7wKCuR8GkKQweyGYzSu9mX7Bza59UyfTe
         bDt+4cD22sITNMfgD1s+59HUarNPv3Xr7OHVEAkDoK7bOaewZKDp5grotKbfa1tHKzXY
         jw5HevLsiXuosHuItKNTLXYds50RTX66Z3fdpUhk2jDU5NL0u/J0hyifQ4mta/vFGd/d
         VLa4gsey4LUzYoXh0twefebLsRKb+/55ck3kcZAhci+b8iGPzmQKNhzXPAlMZw0xI0sX
         WoteW6cTvXCxLnRxM0vH/F255PrI/OobHyMgILTkBOWrv7P1sJEYiHvdc4gKeh/MyoW6
         AFhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699683; x=1791304483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vL6919hhk0fKil7KjsB5a/L4hlZiGRK9iVwf73Z8R/s=;
        b=ooaSCwCeIJ8VKyLsj6K9jUtT+lmqhm9Qfc0FyDC0EP4ISSpp6GJzDHqe7ER9+77HVq
         tkYdNvGvaUSnDcYw1fd6NclU44gYoCTM7NlcJ/+4nuAHd6fCAVWzFLsmTVGgxqEmpPUl
         Jbbs/btSpuBcZdH/vLjAS2ipiHzJtkFkOobmIKKjMU3G5n/Q+/ORt8q8kx6qUMz2aJeV
         hzbEfv1zA6NuuNSab47Ny8322nxpHloTHb+hVr4MwAywKP2TA7xLPRCWulHvItjI/OWa
         UmSfjZFMkdGzfzN6uo9OTf0tyjebcj6WszSHjTCx1T4iV2WPWGfEmA5X5ck1nJ356TBa
         Ps6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699683; x=1791304483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vL6919hhk0fKil7KjsB5a/L4hlZiGRK9iVwf73Z8R/s=;
        b=OoKlpt6tqY5/PXwMVt+x3AWmQK104dDsp4TFHvzju6V5uEDQat7F0bqv8KpG9SXCyu
         T7yScXAjzmff9coD+WixOmEPUizcsfBV2MSKDAvhR0ap2abS3oH/bNg3O0QPj6xT4NI4
         s+dznemqHOIUXicvl+wfVsoj01zd9HdHnEu7XdbwiLPPh+XaljqrTca82O6X1d3oFq1E
         Bmc8CcmWi4Wvxgi/IyVt+IvnC8ywapkVRNKptysjOAtlagA35daR7laHAXKcZa94tMO9
         uoGHW59VQkmA2fzTo/swLiimanAjyYo4cqTU+o8rGMUmw6Rk7sqBNv+YrCojoPkguJBC
         Fl5Q==
X-Gm-Message-State: AFq9FYLw33ljcp6/B4XlP8alNdv9xWlbL6/vPjaUH1omrE3bhJUnYjDo
	4XuThu8GLHeIvgHjGUgOLm7Gy2SNDQvkxGjO6cJKNKeoHelZW2Gvm2t3D8taFj1p21JU83Bcy5C
	JahSntVnZC+j21esYn+xTSonROzW9LpH9jawv
X-Gm-Gg: AYBFou3BhlHz9Ji2AoPfFRyZCUl2cAO6shkoWZRzM9dZw6Qpi21dN1gekszwtIuTZXj
	T2T4NCkxYyz/MX8WMvuZy8NfQ9oXVvh9k99hEq2BkbUHEVX7Epaydp6xNkYf/h5lqb6bzKFTuB9
	QEAjE5CRusU9NAQtap9Nlu+hmLqmY5LX/o6DdbmZ5xKouiFRrj/xj0pe+PgXzf4kjImynVquRGm
	cNoL6xUqYyhWSS8nDAZJogopIDX8QzbMNAFs4bosw4P0boC1s5Eq3K5JvP2rtspb5ilmyz+QluT
	8vBYFuKtxGDnIyPoQ21y70pOtVrGXpbzPF6wxualSj7rlrAWjqoA26g=
X-Received: by 2002:a05:690c:c008:b0:8a8:8d90:a6a1 with SMTP id
 00721157ae682-8a88d90ac09mr35456567b3.39.1790699683235; Tue, 29 Sep 2026
 09:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929125836.90030-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260929125836.90030-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:34:32 -0400
X-Gm-Features: AclHuK89xTlxb-DABN5m5Jx-0XPiIz57fmhapAEff16UfgSZbfpciWThOtIMo_Y
Message-ID: <CAEjxPJ6wj=eMvOcgLWKL6QbM=hvuXwzMk81zKaT3k1BZ2eCbpg@mail.gmail.com>
Subject: Re: [PATCH] sestatus: avoid self-referential symlink
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, Joe-Ju-Alpha <joe_ju@alphanetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 8:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Joe-Ju-Alpha <joe_ju@alphanetworks.com>

See below. In addition, it would be good if the patch description /
commit message had a non-empty body that says which install breaks -
GNU coreutils works fine here without your patch, so presumably your
use case is busybox or toybox install. Lastly, this still doesn't
cover the case where SBINDIR=3D/usr/sbin but the on-disk /usr/sbin is a
symlink to bin (usrmerge, no DESTDIR); textually unequal so ln still
runs, still relies on install-overwrites ala GNU coreutils install.
Not a regression so up to you but it remains uncovered.

>
> Signed-off-by: Joe-Ju-Alpha <joe_ju@alphanetworks.com>
> ---
>  policycoreutils/sestatus/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus=
/Makefile
> index 6f8db774..54082adc 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -28,10 +28,11 @@ install: all
>         [ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p $(DESTDIR)$(MANDIR)/m=
an5
>         -mkdir -p $(DESTDIR)$(BINDIR)
>         -mkdir -p $(DESTDIR)$(SBINDIR)
> +ifneq ($(BINDIR),$(SBINDIR))
>         # Some tools hard code /usr/sbin/sestatus ; add a compatibility s=
ymlink
> -       # install will overwrite a symlink, so create the symlink before =
calling
> -       # install to allow distributions with BINDIR =3D=3D SBINDIR
> +       # install will overwrite a symlink, so create it before installin=
g.

This comment is no longer relevant, right, because you are now
preventing creation of the symlink if BINDIR=3D=3DSBINDIR.

>         ln -sf --relative $(DESTDIR)$(BINDIR)/sestatus $(DESTDIR)$(SBINDI=
R)
> +endif
>         install -m 755 sestatus $(DESTDIR)$(BINDIR)
>         install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
>         install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
> --
> 2.55.0
>
