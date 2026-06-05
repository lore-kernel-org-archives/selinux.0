Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA133395AC3
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681930; cv=pass; b=WXYN2g+fxyqUlnOww3Bjil/GSJy8wjGp/5oIt6fGVLQwc+uPLXOj2V9Nt8oNdygqIiHQWHFX4idY1hrcjnHxRl8zg1CKLPUS3RwB7hiyUKSI+aAl5t0sx7YqRyoluQA9GqvDT1l9fu7j+kU0B0Rwk4z3aGcWyx6rHAlvoCnzuRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681930; c=relaxed/simple;
	bh=BEqoGNhQIoGoJuDrRICeLiWMl+0T96wpVPO63JaDyl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBslC51WQYYnb4G3wbHMWHgWyjD1Vp7cHZveXjG27dEIiYlBsIrbkxoHDAF3t0xB81qEkPSrTRnZuyTFOY+9U4LQDPd84G06DSnqwIuzfFQNL/HyFV7oeOp90sxB3ykT3uw2uMG7P2OeSG5HxhWZz+CgatBj2W16zqF/6ZkcL2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df/DN5eh; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df/DN5eh"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-842358aaf36so953742b3a.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 10:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780681916; cv=none;
        d=google.com; s=arc-20240605;
        b=MSNXkT1c2Ea2hS1eZgvaKmj8xkHYJUAOnBmYqyvgMhOeWJhEy639xjFXx3pihUC6uW
         6K8kOQ1+uAUU5Ig4OzJi9WjyiET5nVhghK88WjCWZGBefMuL229H0W2a/Z5GmZBTzbO3
         RhUn0v6tMh421ufzfYXbSTiMrizFEY+atLAJvKDqwPGJBaNBv/3AIeTpvrBGb+bSsb/u
         KHvd6F6zMQf/25sFsjS491GEj4seuL4Gyh+QVmBrmtPwB0AL2ESc8J6Kst7wEKsScO8j
         Qa24bOKVrINIEML87pnPOYmGr7i2k2na/sjeN4TW3WeXH39GZAZWx+VT0C6hi3jMXy+Y
         AHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V6TGqpbMXyHGNZXRWvVye1JjvF3LQ4Y0uTku5L1U64Y=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=GpqBgHQ9uUQrQCzdMMeukAZMMIYgKrZQMZTVYASV507xDDYtL7XxHyqVe1BHXNhTZg
         +8LwFnWMq5z8KxxAmz4KYlxnc1zQ5F31NQMqXIlh4hLewxfnSh8L5MsKyLKiTkb/P4nI
         kGA2US2nTQckGYvvp3ZseiEFkP7O2B3sULM/i2C8TZeIrQduBe5dIXidWqrfdMwLkyBm
         4wnFnXc0FN4JNMt3BtfKak/So4q4qC99E5915MMOSJ5usrr30RSrDJVQMhO+cHD9Yffu
         KCgy/8Rf90lf80/jrH9xWElzjWrAHroAzNNYZzdjZamP50bAnEuDBlQ5b30xBYSC4N0G
         bENA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681916; x=1781286716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6TGqpbMXyHGNZXRWvVye1JjvF3LQ4Y0uTku5L1U64Y=;
        b=df/DN5ehDJi3YsA2bvrKqOqk929grj+iOuYolX/dwJK5BRkOl9Il4G51wAfdsydaM2
         m9wvXWlUmXDGG7LTu7aiO3vCEoquVOnYilbndx5giHeeuyhAZMppaXNUeJCxFKZF3UcE
         O25/mYixROjV48IkpKHigEhU8uuljqXlEuwRQEblR3aKPluGRQVUupNE8f4AK80EHAT4
         JIO/721mXM+bRi+OYPy3mn0oX2hDHL7V3W8XrjT/nykf+RS+BgadouhoOgwA2ScYXy+Z
         wmds7T7SWIHC2gR4984TDsbfWJC6Vh6EqpET0eRLPJzGztyx8lpSPe8fYEuTcoLa2eBD
         eDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681916; x=1781286716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V6TGqpbMXyHGNZXRWvVye1JjvF3LQ4Y0uTku5L1U64Y=;
        b=MzAQOAWkBVRpoNmBKQJ7w8iVFXpAFe+TaUfBagRcmwMM2gIhWnO2CniexO0MRH7Jpv
         yYfd6B6v98EqkL9LwhlAXKzNM0XqzqInaBJnYhr85Nj4sJmYhHhHtTWGhr9HQjTBWm29
         fP3a3HF17vWkZC4jSrZVMmZgGQoTwq5bZEPcIjTXH0lGs23nKmDBu7J9iJaT6dp5FM0W
         U9bxZyk7lnrwJqCXJpvA8kjMr0aq1axxY1Dm6vpkEq3lwPXapuaNFI8wy2tWc/HWkYV5
         YlyBWXJ565pVasDaZySIj4zBYdUHqdq/+XYpr9pWu52uf/MOEGP8McuJhT3OVcdT53XL
         ms6A==
X-Gm-Message-State: AOJu0YwvdSwKWGSKJnuqDQOFArQy0xyT4jNs6gEpy5x875QwEEVkvnUQ
	ADKqNmFUaaKsIBP0W3TidVOoGMFwi89JKWIlWOysLX5NLBdCdWNr0FzWEuzmlEodmV6gPm5jiST
	iKim2F9CfkNK3giCbIPWvHvGHDZpXI2U4oUmF
X-Gm-Gg: Acq92OGhFeHUhQP7280Jlaix2kzsfTpZx+eO2FiLvKSONhKFjhzpF9AH52G54NrNfuh
	9Rd728t6ukWTQnBnP2IFZiKUhfkLhKr4dgbwIVE7TUFSyTFflykz/VhxYpDle/wYrX0uvq44pJm
	GvhGka4USop9C5E+UZQ7a86F+qjVaEBP8xHl5bBy8Knhcq6r20HjH2ILYd8SLCvQZS3A7hdlJ4D
	5BQIC0pY5AyPjzmvZ52qCVYT4pe3rRbjA2yMFZxFV/r60Ei013sLK5tilEH76gOAanuOyZk/3WR
	7MjNpVwDwEJTW2bM/A==
X-Received: by 2002:a05:6a00:8d8e:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-842b0e118b1mr4382369b3a.7.1780681916009; Fri, 05 Jun 2026
 10:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de> <20260605172207.222382-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 13:51:44 -0400
X-Gm-Features: AVHnY4KhiENvSLX4D4S_ZO8T1a8TpEiuaW2gluAfZPUNvJ62o7zM1CMpPhSDzV4
Message-ID: <CAEjxPJ4wzfNcMKe+KOZvA_6cLQiUUzov6k90vEdbv52dGH5QKw@mail.gmail.com>
Subject: Re: [PATCH 04/11] policycoreutils: declare local variables static
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:29=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Variables that are only used inside a translation unit can be declared
> static.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/hll/pp/pp.c           | 2 +-
>  policycoreutils/secon/secon.c         | 2 +-
>  policycoreutils/semodule/semodule.c   | 2 +-
>  policycoreutils/setfiles/restore.c    | 2 +-
>  policycoreutils/setsebool/setsebool.c | 6 +++---
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
> index 823e339d..7280a70b 100644
> --- a/policycoreutils/hll/pp/pp.c
> +++ b/policycoreutils/hll/pp/pp.c
> @@ -30,7 +30,7 @@
>  #include <sepol/module_to_cil.h>
>  #include <sepol/policydb/module.h>
>
> -char *progname;
> +static const char *progname;
>
>  __attribute__((format(printf, 1, 2))) static void log_err(const char *fm=
t, ...)
>  {
> diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.=
c
> index 4f38f6b8..df32c830 100644
> --- a/policycoreutils/secon/secon.c
> +++ b/policycoreutils/secon/secon.c
> @@ -48,7 +48,7 @@ struct context_color_t {
>         char *range_bg;
>  };
>
> -struct {
> +static struct {
>         unsigned int disp_user : 1;
>         unsigned int disp_role : 1;
>         unsigned int disp_type : 1;
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodu=
le/semodule.c
> index 87a95c86..14e2f201 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -65,7 +65,7 @@ static int priority_set =3D 0;
>  static semanage_handle_t *sh =3D NULL;
>  static char *store;
>  static char *store_root;
> -int extract_cil =3D 0;
> +static int extract_cil =3D 0;
>  static int checksum =3D 0;
>
>  extern char *optarg;
> diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfile=
s/restore.c
> index 38f24326..1e3644f5 100644
> --- a/policycoreutils/setfiles/restore.c
> +++ b/policycoreutils/setfiles/restore.c
> @@ -15,7 +15,7 @@
>  #endif
>
>  char **exclude_list;
> -int exclude_count;
> +static int exclude_count;
>
>  void restore_init(struct restore_opts *opts)
>  {
> diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/sets=
ebool/setsebool.c
> index 0a7227c5..e019e43b 100644
> --- a/policycoreutils/setsebool/setsebool.c
> +++ b/policycoreutils/setsebool/setsebool.c
> @@ -17,9 +17,9 @@
>  #include <semanage/boolean_record.h>
>  #include <errno.h>
>
> -int permanent =3D 0;
> -int no_reload =3D 0;
> -int verbose =3D 0;
> +static int permanent =3D 0;
> +static int no_reload =3D 0;
> +static int verbose =3D 0;
>
>  int setbool(char **list, size_t start, size_t end);
>
> --
> 2.53.0
>
>
