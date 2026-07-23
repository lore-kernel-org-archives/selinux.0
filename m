Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD538E8DC
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818568; cv=pass; b=e7ua1+BHAsPpV8ZBI5rJdvYIkGDfTXQ9ml73KEoaK8prujkaLFsaezFBbAXhxicYtJ1P0fpsqzfEHFTFvai0xSC7//XHzOYfjhiYDRGx6KQC2OBMXAw83nfSS773PVAClXp4lK7oVOX3Ym9PCsHaVfHckNYS9C4nVOJJOch9KPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818568; c=relaxed/simple;
	bh=l3oJQ1ckYmWV1sHx76L9fTlTy5QWW1q2T+2AtvcY9G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHYnCO9JQTsalrs3roS60czGaHTYvFrYNhXkZcTYx5IwV8NyQKj82EGEzKT04BO1iFLUIvwLccVOvI+IPUcoeCRdQOzuKaY1YlcKDnVvvxg3udKq/HbD75+14hT9epP0flsCxZ8I4rcgD15LVwjEpfDa8PUuSuzP35x8Xj4uon8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2gELkba; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2gELkba"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e0688b859so263708b3a.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 07:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784818560; cv=none;
        d=google.com; s=arc-20260327;
        b=GvINmWLTFzEXIaihFFdntN+2dSuCGVJWngK9Xs205bAgy9noVoAEAkuqjsLcCwpnwJ
         hEdy8eKUvG6k6CxNzwWx0f8cskujrKkk5eTqNGUEFme9ra9L7aOpiKgCM3CK1CU6jqxr
         KM07CzrTjazY6DnlbEi/vAS3EC6kfEvE10v7zwR1juR8Sck+ZymmdL+0DhAwIkZGbF4v
         YXOAUlAT4xwgACYroXgiD77yoFQCb2FK7IxNDMKKgFv9PiFvZW/JdIEJ9KKE9AI3h/w5
         M85Hv1SlqwZUHO9W5+jlcDmqWP5FvkB0eNfs4yeBRuus3MjcajazE2+kh97K7pgv6Aaw
         KKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZQE0ZdFw2lGpyuWCOLe0eCHVu7JoVqiPidQoXIEx10=;
        fh=E51Jjr8Bz9WzQ+Ik80n9UcoRPIh3NakEhV8l9xr/qbM=;
        b=k6SAPq/KdGFfiirTmHjDaTPZBpqqr9lmJTUuvhoPI57aY2qhPeUbEh+j37+qSoLJ0i
         tnbxt7kMzhAyHSVheKKVO1E7tFAMLud1xtOTF8QojQsEWGfNNd/1Gmwtg2FQmTnqA0qz
         Ttxa01/4uMSOtILTqFP5gDQ+CP8o810oRXkKS4OdtZva1LV/0B9E2p+y9heU4OYGfTAW
         4aX8Sd1a64wCHr47NkwbFqLfSh0PdeJxfpwkDr9SB68gaWaZmjKS8trjghxgYXs8cfz6
         ckh3ApDmb0z7Jviix+HqTXDl7vhHecgh9ccbzXh4KXTn5BLTs69uCdr7pchJB2iW0o1L
         fkkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784818560; x=1785423360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OZQE0ZdFw2lGpyuWCOLe0eCHVu7JoVqiPidQoXIEx10=;
        b=g2gELkbaj87ikFELpElcLattJOLOKFqMF4b6Y6LkL0rwLxGNVXV8E5+HJ56OM1Bsjd
         zumGWO/cVFyCe6Suvmb2HkLzMGunHseJEAY9ZD9//tex31qKRzum54C6qeShn5j5kEp4
         +gyt5SeJhACAYe8OA8ztbZwhmZSepJUUDgLa+bJQYPyU+lowGN4ERGzOB2udMYlJC59o
         dYDPbYJVlay2o98iDGaqNgMgCfyKAraGCDxARGi3zepa5Lo3Rr4OHRqMq0oIk9UTTImu
         VmSBAVQseA6Gqe8FZ760/YslENiEclgiQKVQh35/hURKMb8hbPhla3apPGRCymBZAa2j
         N9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784818560; x=1785423360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZQE0ZdFw2lGpyuWCOLe0eCHVu7JoVqiPidQoXIEx10=;
        b=NIvIeR2g9FksU3QudN2Igat9szfrFhHwPRnu45t0zZMt/njb3jgqDsHarP1BVcn+49
         ePzy1PPln2L5ASfW7M6iFlQXhvGm2RygxErmtb3P9l2sgAMisiWUfAIFRah/Eo5QiYUP
         sSmepVfHNOpte+Nttsy36qAAVaEjhZ1n++1MnwRyTaGOp5swaOmQLWkLSNp4znKHepe2
         bFr/xVi53+igACPP1hN9jTdiba0K0dbuMenDpqSmnJb440VLBrOOCac4mk6hZvFwRxsC
         5MajQ+dfL4IQ1GVX1PP5OWJJlXQUAAACUmuZaQkhw6/W11Du8KMDWROULPwB9YnvJ8tT
         jlYA==
X-Gm-Message-State: AOJu0YwVXzNCQpuw9U74w5n42XWfrPRJQrOCAvM3aOCUNh66bRUuSC4W
	/I9EnTT/qyVBlgVya6ENRPUDUFhL0f8mvrD68U5KZvZPuUnOeXral2OTzsZ7y3mGPZ4X6FIbtnC
	zLbu6IzpcvpvKhvFIO0UXvpjhFebQhpqbZA==
X-Gm-Gg: AR+sD10FjcRM/60BY6/E2bEzMGGpgTHQXGp+xfyfqyXeIv0FeYllIQ/WsvYMWPLr7xe
	+xSCjdSzKR0BIbxnEbmNYzB910oq1IIF4+t9IJ99FsLxxetZ+HvXqqvqJtdEJhztjAuzYXrh8ul
	oUzkUAluRlKjH/Df/QHwZ++ywgjY1twx7j8FsoL1Kw8eOXV0lbkHi3kHrivYJX4Tj3h3R031tF5
	4IROm1XsM/oN77CHjV4K227Bdw77Nbo4YJtec+r9Df+wAU4qld+M7aFekocEQSzxsJ6MWxV
X-Received: by 2002:aa7:8d0a:0:b0:84e:2f2e:8dec with SMTP id
 d2e1a72fcca58-84e2f2e9492mr2436275b3a.63.1784818560565; Thu, 23 Jul 2026
 07:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amHW-fFHM3pw-g3y@suse.com>
In-Reply-To: <amHW-fFHM3pw-g3y@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 10:55:48 -0400
X-Gm-Features: AUfX_mwA6_9efA6c8R3feLbEKhT3BWH8YHctqRGXh7qrIZs3-DHwgHLJ9zimsNY
Message-ID: <CAEjxPJ5KfidbsqrUe07F8sdssdqEtEUsBUDgGqn4dm4RZUcyOw@mail.gmail.com>
Subject: Re: [PATCH] selinux_restorecon: Do not exit on directory cycles
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:56=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> w=
rote:
>
> All other failures are handled gracefully. Directory cycles can e.g.
> happen on BTRFS filesystems with subvolumes. Skip them and continue
> instead of exiting

This is a user-visible behavior change so we should note it; restorecon -R
on a tree with a bind mount of an ancestor will now complete with rc 0 and
only a WARNING rather than aborting with ELOOP.

Missing Signed-off-by line and the patch still doesn't apply for me
(did you send it using git send-email and against current selinux/main?)
but also see comment below on the code.

> ---
>  libselinux/src/selinux_restorecon.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 30f1b836..fdefc92c 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1393,15 +1393,14 @@ static void *selinux_restorecon_thread(void *arg)
>                 if (is_dir) {
>                         if (descend && walk_is_cycle(state, ent_sb.st_dev=
,
>                                                      ent_sb.st_ino)) {
> -                               selinux_log(SELINUX_ERROR,
> +                               selinux_log(SELINUX_WARNING,
>                                             "Directory cycle on %s.\n",
>                                             ent_path);
>                                 close(ent_fd);
> -                               close(rd_fd);
> -                               errno =3D ELOOP;
> -                               state->error =3D -1;
> -                               state->abort =3D true;
> -                               goto finish;
> +                               if (rd_fd >=3D 0)
> +                                       close(rd_fd);

You don't need the if (rd_fd >=3D 0) guard here because this branch is only
executed if descend =3D=3D true so that's always true.

> +                               prune_pathbuf(state);
> +                               continue;
>                         }
>
>                         if (state->sfsb.f_type =3D=3D SYSFS_MAGIC &&
> --
> 2.55.0
