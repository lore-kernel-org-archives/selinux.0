Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7431C04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 20:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBD120881
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 20:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3VWfBgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfEJUvw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 16:51:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33574 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfEJUvw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 16:51:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id m204so5529835oib.0
        for <selinux@vger.kernel.org>; Fri, 10 May 2019 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d5/XKfmcNWhzPfTilEmMNOHVf+iWpT6mQjFcg9TgJCA=;
        b=k3VWfBgbeGyY+Sl82Ql/CNBuHRsELjm2rr2234+DxI8e2ojOu6/QT9iQdvkOnf4IQD
         rWo1uEpHnakvM8DOPDTUhiuEFncsbFQoMr8kzZY01sIVRrBrJuY9i4lSzPUnQmNhdxhO
         andzryhmcyZVSYZc1mKW0yWu+flQK2COJS9sq1qGtp0NhPEidWMi45zO5ssEFe0WT42r
         AHDbrDWhNoy3EOqhbzGEzScb0CkHiqghh0+olGLPya6eHI9BwuCLMmHSaBW+imqcIR/S
         YGVEuxSPVGUWyHhHZ5n0PZ3ACSut43n40pbrC7e1F0ZWM2pykAqIlA2Qnh9XcnAdaBLI
         posA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d5/XKfmcNWhzPfTilEmMNOHVf+iWpT6mQjFcg9TgJCA=;
        b=uCdbs9MC8OaLtU46XbQHdfnMV7Xb0e7FUgY+ZSu9IRkhUaCbyvxOchZK/VKl1EgwQK
         vqYDGxkdGCmB0PkxKOeZ604K0IlcYxvWbHxCRIIS7JokScOvcpDxspkF3J5NgpDqJHqK
         D3rNQ5UfX9j2Jfn9KPaJwDJAcXXYfsILLxnpwQXrq/spt855qyog756eZ9a8y9XUsGRq
         eaduwkEI+cwkpVXo0RbWXaXZGq/gw/k8KopSAKWU/MH6pphLnKczA72Q0oFYkrFR+8KA
         52p7UDPPSoDH+66/G1xNNLa2dQ0PLkAjwBMPRDQMe1KXpCHx8r7qpYYkE3oaxq7iGBb3
         B5YQ==
X-Gm-Message-State: APjAAAXdt/XwG9kCcMg5TqhgDB+Gx0VWa26fMr4ySffOH0PXp19id5uR
        fD7uS2kWK4N8jKZCLlWVwbqtEUmotJajYOHSMOb4ebfw
X-Google-Smtp-Source: APXvYqzQf+BHapBtT/YttiD68lTo6zDD/0Vh5wuKsqLcW1Hv195h02n6FtEcss2kXwFgLTnI2QftR/wkXBs+5m5J4so=
X-Received: by 2002:aca:c154:: with SMTP id r81mr6023975oif.160.1557521511133;
 Fri, 10 May 2019 13:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1905102116350.16225@34-41-5D-CA-59-C7>
In-Reply-To: <alpine.LFD.2.21.1905102116350.16225@34-41-5D-CA-59-C7>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 10 May 2019 13:51:39 -0700
Message-ID: <CAFftDdpJe1Yd_MdiNO=D+=pK6bbg3-G+a0aM_Ck=cz7dzJdsgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] another style fix
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 10, 2019 at 12:03 PM Jokke H=C3=A4m=C3=A4l=C3=A4inen
<jokke.hamalainen@kolttonen.fi> wrote:
>
>
>
> ---
>  libselinux/utils/matchpathcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpath=
con.c
> index 9756d7d9..eb39a188 100644
> --- a/libselinux/utils/matchpathcon.c
> +++ b/libselinux/utils/matchpathcon.c
> @@ -25,7 +25,7 @@ static int printmatchpathcon(const char *path, int head=
er, int mode)
>         int rc =3D matchpathcon(path, mode, &buf);
>         if (rc < 0) {
>                 if (errno =3D=3D ENOENT) {
> -                       buf=3Dstrdup("<<none>>");
> +                       buf =3D strdup("<<none>>");
>                 } else {
>                         fprintf(stderr, "matchpathcon(%s) failed: %s\n", =
path,
>                                 strerror(errno));
> --
> 2.21.0
>

ack
