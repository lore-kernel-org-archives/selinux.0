Return-Path: <SRS0=LfCf=UQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504F1C31E5B
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 17:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C2320861
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 17:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPOj6RWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFQRxr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:53:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46410 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQRxr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jun 2019 13:53:47 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so23038865iol.13
        for <selinux@vger.kernel.org>; Mon, 17 Jun 2019 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e2e3XQsEmYefBfaZDJFBAlJHSTEU6Rp4CpALsf6yY1E=;
        b=SPOj6RWqW5eJCwo7gCGiJzyz2sWzDxvUi+Oz+3pJdAWThe2cR4+OPb2cZMqsZCLzB4
         FgvMkpETdbsJFUun4Ggqo1jM9BBgyl28BL+tW9bXa6NgwEbiIpbSw3l8K5Qh0/ztLo+e
         4Uz+MyCJum/n0FZ5287Lp77ydXt1aOto1yJvhqPFwcTd05Kb+pv6va8nLtlqbRS5Cs+T
         EK5JgJLDvsHmuASBtVHs3RqtVExWg630fNhCn38uCmwty2FIMXPfiZWUGYQlrESmjZgl
         jNwEnSi5kmlA5w2A2Gy3cJ/+IJZPhM4ez19oPDy2OrwD+tXQMxWBlAdnFm6zFRMiNhmc
         fRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e2e3XQsEmYefBfaZDJFBAlJHSTEU6Rp4CpALsf6yY1E=;
        b=GJjZwkuuZOBq5nLOttoK1yKxjS3P3gchVYWw01uyH3U2msxknZ9IiLo3UJxy0Lolfx
         bwItdL9L1axPgngxIwAG+/2PerxHKFOxwyTs+Wz8pbA6sjPn4lq4UUemQeWj3tptlP3k
         rCTAfkQcigWs4nn+Eqvv2ALgRAiQ7uBNqPbhOUJ/Y7lEEweNGrgSWb/pYW9AFDXG6le7
         eRhxlEMJ3b8swa4tFNULu2ESL6nVf25bCc8eRplh3FBrM/Rfeo9HzDjInfjNFpcl7dtm
         XnFOxyKIPUp8fDjeacmqavQInbDO0QJVlmvyYzMSsrE0K/59Gt4As6pA2am5UM6usr/T
         n9tw==
X-Gm-Message-State: APjAAAV1REbZ3IKkEaCX13nxOvGiDHaib6/Bqdff7mP0VfgheBTJ89qj
        L2xfg2yEqcb0oKYmsca3juXfQzT6+JdgiavI9oxcnqFZcH4=
X-Google-Smtp-Source: APXvYqyMgmbQLLF7wG704hzEYGowDRV5fL1Y0fjZcNR4Zlgkw6ctJu7TAJWL68W1s/vI8RRVBvWllX+y0WjcI6LKoqI=
X-Received: by 2002:a5d:8f9a:: with SMTP id l26mr97444iol.22.1560794026202;
 Mon, 17 Jun 2019 10:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1906171502130.6467@34-41-5D-CA-59-C7>
In-Reply-To: <alpine.LFD.2.21.1906171502130.6467@34-41-5D-CA-59-C7>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 17 Jun 2019 10:53:33 -0700
Message-ID: <CAFftDdpbvUngYWtdySVyag80y5ZnaioP7RoqWhzJa73cYjq+xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Replace constant with sizeof()
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

ack on the series, staged: https://github.com/SELinuxProject/selinux/pull/1=
63

On Mon, Jun 17, 2019 at 5:02 AM Jokke H=C3=A4m=C3=A4l=C3=A4inen
<jokke.hamalainen@kolttonen.fi> wrote:
>
>
> Replace constant 18 with safer use of sizeof()
>
> Signed-off-by: Unto Sten <sten.unto@gmail.com>
> ---
>  libsepol/src/kernel_to_conf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 5fb4e838..930bafab 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -448,7 +448,7 @@ static int write_sids_to_conf(FILE *out, const char *=
const *sid_to_str,
>                 if (i < num_sids) {
>                         sid =3D (char *)sid_to_str[i];
>                 } else {
> -                       snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> +                       snprintf(unknown, sizeof(unknown), "%s%u", "UNKNO=
WN", i);
>                         sid =3D strdup(unknown);
>                         if (!sid) {
>                                 rc =3D -1;
> @@ -2376,7 +2376,7 @@ static int write_sid_context_rules_to_conf(FILE *ou=
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
