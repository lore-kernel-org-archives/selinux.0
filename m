Return-Path: <SRS0=LfCf=UQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFF1C31E44
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 04:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D832187F
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 04:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g75HXlRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfFQEhk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jun 2019 00:37:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43629 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFQEhk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jun 2019 00:37:40 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so18236615ios.10
        for <selinux@vger.kernel.org>; Sun, 16 Jun 2019 21:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VdeoZJDwAeJsV5zLDDO6IuLUbxMBLRTZHDlzMTGcUdg=;
        b=g75HXlRFzTL10avZtzuHbOSft9xdJiIkjTGqBiTgbOA2yu6JYcTH4uATySBQvHAC7o
         NEeYtH5rACSokW5GM2SNKLGncl+jDSu8TcoNjBFLenHIrCG8OVibgBQqY6r1v5ve8gNV
         rnvQ1cxPAxogkV86YKAo+blFlt8QUSUY8hOqooSYHoJC8y75dYvYz8cwbb7uaS/7znmL
         FYK5NLLCv1A4q5zWBOpitge30hTMBaedVwIbxIfIixkJgegS4oS5d8h8TPeU6hgc/5UO
         F6hC+wmN55tP0tlP1DlpBiS7RXu3CQy8rjQT/bNEyWs2uuOHZ6l/OjLxx6/OgNqEZ2Tl
         RT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VdeoZJDwAeJsV5zLDDO6IuLUbxMBLRTZHDlzMTGcUdg=;
        b=jJm0wXQHJRTWzCgx4hrz5AarWS1c7z2sWytNZjP/AQd2cu7ioM6T+FboLwBKVRWIPi
         NC+GWTnJtcNCvZ8dv9yPJc7bhQbnuU+xgL+QZl3iO87dxbfVMsDn7516Tyzp1JNsjyyU
         48HqVYfYwriwaVMBJIzY3bZcFS1M0Ayf7z0CsLBoMOuIpkTRe1dB/1s9HGdEqLWOz8DL
         wLs7wCu0Id8LNfeRMidCgFr9pcDOW3E87MXk0IBFlK9O6Jetg1ANUclCatDa1WAzvC/r
         rgb3M8bNu2ZIcjT/9tl+xTJAWRNnMCz5y1P6mmgaOC90Y1eS8Nnk14TFS2lp+qKMvGLO
         rXUQ==
X-Gm-Message-State: APjAAAVeUF5QtvejxCOYjzZhvBKBVzbKdt2BskbcAvxpwa8kV0o32IHu
        eUTT7TpZIhyffme5+sOcPILeOWY3dBeUM93nXtUWnKm/
X-Google-Smtp-Source: APXvYqxnNyIwHXXlgrNravtDyjffzFlXIQ7WPlMY5CMd3ndgHX7AWhHcJ5GXphb7lC7lRCyQDwC6PkxwInx7RITE5p0=
X-Received: by 2002:a5d:8f9a:: with SMTP id l26mr45409558iol.22.1560746259509;
 Sun, 16 Jun 2019 21:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1906150215140.18365@34-41-5D-CA-59-C7>
In-Reply-To: <alpine.LFD.2.21.1906150215140.18365@34-41-5D-CA-59-C7>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 16 Jun 2019 21:37:28 -0700
Message-ID: <CAFftDdrxyX2MPzexBOdaATmt6YTA4qM3+xJ5uzkHWAJUZxVPXQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: check strdup() failures and replace constant
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 14, 2019 at 4:17 PM Jokke H=C3=A4m=C3=A4l=C3=A4inen
<jokke.hamalainen@kolttonen.fi> wrote:
>
>
> Check for strdup() failures. Also replace constant 18
> with a safer sizeof() use.

When ever you do "also" and "and" in a patch description, that's usually
an indication it should be 2 separate patches. The only case where this
is generally not followed is when both patches modify the same hunk.
Please split this, one for strdup() checks and 1 for the sizeof() usage.

>
> Signed-off-by: Unto Sten <sten.unto@gmail.com>
> ---
>  libsepol/src/kernel_to_conf.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 4f84ee8b..930bafab 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -448,8 +448,12 @@ static int write_sids_to_conf(FILE *out, const char =
*const *sid_to_str,
>                 if (i < num_sids) {
>                         sid =3D (char *)sid_to_str[i];
>                 } else {
> -                       snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> +                       snprintf(unknown, sizeof(unknown), "%s%u", "UNKNO=
WN", i);
>                         sid =3D strdup(unknown);
> +                       if (!sid) {
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
>                 }
>                 rc =3D strs_add_at_index(strs, sid, i);
>                 if (rc !=3D 0) {
> @@ -792,6 +796,10 @@ static int write_sensitivity_rules_to_conf(FILE *out=
, struct policydb *pdb)
>                         j =3D level->level->sens - 1;
>                         if (!sens_alias_map[j]) {
>                                 sens_alias_map[j] =3D strdup(name);
> +                               if (!sens_alias_map[j]) {
> +                                       rc =3D -1;
> +                                       goto exit;
> +                               }
>                         } else {
>                                 alias =3D sens_alias_map[j];
>                                 sens_alias_map[j] =3D create_str("%s %s",=
 2, alias, name);
> @@ -919,6 +927,10 @@ static int write_category_rules_to_conf(FILE *out, s=
truct policydb *pdb)
>                         j =3D cat->s.value - 1;
>                         if (!cat_alias_map[j]) {
>                                 cat_alias_map[j] =3D strdup(name);
> +                               if (!cat_alias_map[j]) {
> +                                       rc =3D -1;
> +                                       goto exit;
> +                               }
>                         } else {
>                                 alias =3D cat_alias_map[j];
>                                 cat_alias_map[j] =3D create_str("%s %s", =
2, alias, name);
> @@ -2364,7 +2376,7 @@ static int write_sid_context_rules_to_conf(FILE *ou=
t, struct policydb *pdb, cons
>                 if (i < num_sids) {
>                         sid =3D (char *)sid_to_str[i];
>                 } else {
> -                       snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> +                       snprintf(unknown, sizeof(unknown), "%s%u", "UNKNO=
WN", i);
>                         sid =3D unknown;
>                 }
>
> --
> 2.21.0
>
