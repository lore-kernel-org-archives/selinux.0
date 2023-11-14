Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC15C46CCA
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 20:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjKNUk1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 15:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjKNUk0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 15:40:26 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7D4F7
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 12:40:22 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a3b8b113so8511817e87.0
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 12:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699994421; x=1700599221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVg1zW4n6vJw00oWGHugKVX5Zq5OUITQ26chprWdTW8=;
        b=GDftvnxLGJGAvx14UCBZOXf6rKvuuq8JfRgrF20GEwhez9MMeS/eriQh/2eaUEGyPV
         kZm7gVV7OTX2xsNx4WlYM2MnWzX8bPYoNwA8guVu7TQ9oO1d6i/y9Io4xrm6vpjBQL/c
         xy4QzWIJsyX222DWkYhw+f4FxQItoTJm3ZuzchEeki0KzZ3FkD1hKgqjzfAAucdTGt5m
         KkNXe9nWO/fVzjh9axT6zNUIQ+nNzUHMsyyVON8leLaaNOapwxvRcR6uy7G+BCRE4nfV
         /aT9eTtWoqm9cbbbj8P3s88wAW8NY0C/U8foqmf0O/ePdQeHIPMHpZkVqQt4M1otyqv8
         8c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699994421; x=1700599221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVg1zW4n6vJw00oWGHugKVX5Zq5OUITQ26chprWdTW8=;
        b=eyR3w614VEouBBBuxrgb3kcW6Vj+eTz3+Aj3sOJcLiClAIALFf9pFZC+jzA5zM9QWq
         4YSh5yy0C2mLyVikGNmqWCXQOVBOdTCjEq0Pf+XyUqFRdr4iPfP11Ke4RpAMFAHm23hb
         nzs3K1pGY24hTRsHyHa54YfUbpw2/+Npjwfz5tnj6xosy+Wqa6Lh94hMZ0rX2e33z2bV
         hZ0mQuOYU71bzS5WiDYs0WpnOjj358wnN7xYiOuoQiYRbW/fTP+ATBvw1hxfCRj2hlPc
         qbzpLfZg39C60UoEaVPZCicn+n4YhalDd3Gmi/mgOb/iDTi9fT5db3oSSZ0zTpWIDSrX
         b2UQ==
X-Gm-Message-State: AOJu0YwxDLlw5GCCgVcGMVIJIg2sGjikR5BwMI9lIBMOlw6TvA27Onwi
        1roARAjV1Uy78zZn7Ha63ijywtzIefCzN3wcHA/0Yzh1FIc=
X-Google-Smtp-Source: AGHT+IGr/YzUJwvlzO6xDC1/I0+z60ACCS7JjYUr6V5sVm4YAcqURrdKlvaP7DM0POkuD48S+3ZkpFbVUTCBfTi0Q5c=
X-Received: by 2002:a05:6512:360f:b0:509:5d4b:742f with SMTP id
 f15-20020a056512360f00b005095d4b742fmr6394458lfs.20.1699994421020; Tue, 14
 Nov 2023 12:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20231109135400.44658-1-cgzones@googlemail.com>
In-Reply-To: <20231109135400.44658-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 14 Nov 2023 15:41:09 -0500
Message-ID: <CAP+JOzQOz0cw7qe45K5kFB1UXCwpKRwDUwPQYyU=ceYQK1K9Jg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: update policy capabilities array
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 9, 2023 at 8:54=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use their enum values as indices to clarify their relationships.
> Specify array size to verify it at compile time.
> Remove unnecessary trailing entry, since all access is controlled by a
> check against POLICYDB_CAP_MAX.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/polcaps.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index be12580a..8289443a 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -5,17 +5,16 @@
>  #include <string.h>
>  #include <sepol/policydb/polcaps.h>
>
> -static const char * const polcap_names[] =3D {
> -       "network_peer_controls",        /* POLICYDB_CAP_NETPEER */
> -       "open_perms",                   /* POLICYDB_CAP_OPENPERM */
> -       "extended_socket_class",        /* POLICYDB_CAP_EXTSOCKCLASS */
> -       "always_check_network",         /* POLICYDB_CAP_ALWAYSNETWORK */
> -       "cgroup_seclabel",              /* POLICYDB_CAP_SECLABEL */
> -       "nnp_nosuid_transition",        /* POLICYDB_CAP_NNP_NOSUID_TRANSI=
TION */
> -       "genfs_seclabel_symlinks",      /* POLICYDB_CAP_GENFS_SECLABEL_SY=
MLINKS */
> -       "ioctl_skip_cloexec",           /* POLICYDB_CAP_IOCTL_SKIP_CLOEXE=
C */
> -       "userspace_initial_context",    /* POLICYDB_CAP_USERSPACE_INITIAL=
_CONTEXT */
> -       NULL
> +static const char * const polcap_names[POLICYDB_CAP_MAX + 1] =3D {
> +       [POLICYDB_CAP_NETPEER]                          =3D "network_peer=
_controls",
> +       [POLICYDB_CAP_OPENPERM]                         =3D "open_perms",
> +       [POLICYDB_CAP_EXTSOCKCLASS]                     =3D "extended_soc=
ket_class",
> +       [POLICYDB_CAP_ALWAYSNETWORK]                    =3D "always_check=
_network",
> +       [POLICYDB_CAP_CGROUPSECLABEL]                   =3D "cgroup_secla=
bel",
> +       [POLICYDB_CAP_NNP_NOSUID_TRANSITION]            =3D "nnp_nosuid_t=
ransition",
> +       [POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]          =3D "genfs_seclab=
el_symlinks",
> +       [POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]               =3D "ioctl_skip_c=
loexec",
> +       [POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]        =3D "userspace_in=
itial_context",
>  };
>
>  int sepol_polcap_getnum(const char *name)
> --
> 2.42.0
>
