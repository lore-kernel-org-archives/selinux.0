Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9166C43334
	for <selinux@archiver.kernel.org>; Tue, 28 Jun 2022 21:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiF1VFS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiF1VFR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jun 2022 17:05:17 -0400
X-Greylist: delayed 222 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 14:05:15 PDT
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED02F387A1
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 14:05:15 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D174A564864
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 23:05:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
        t=1656450314; bh=azAwtiEpjHQ+1at8SDXrM4EFoRA/0lAJ6u55GRdnPhc=;
        h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc;
        b=wKIGPrFsIqJUQXfywqHdq0zhvngDhKr9WJCDjmYelris5Kf7R2YAjxoRoSdhQI34o
         VpJo1CZBrsGNPyJkLewmRvPBNr727YkFhM4+n9LL+qJjXFxlUo1jPQSRaRmb+3Lym/
         OMScRdclx9NRPupTw+va/7v/4AVV7f7ysu1pLlgg=
Received: by mail-pj1-f54.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so8490310pji.4
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 14:05:13 -0700 (PDT)
X-Gm-Message-State: AJIora8Kg6AnAoBiPUgoNlZi85zZgis33YEmIfV3A8AdBYHRwRMJWTRj
        Vf1c/TjthGem56BAylTHGLOHk0nMNpTFqdW9ygQ=
X-Google-Smtp-Source: AGRyM1v8S58CKE7TLMeyvbjltojEpmyiYC3LA9UHGKRh6PQzD0v6eR+hw3dw3xKtSh0Bei4vwMjnef2qiTahTkSQ3Og=
X-Received: by 2002:a17:902:e543:b0:16a:7d9e:6517 with SMTP id
 n3-20020a170902e54300b0016a7d9e6517mr5615091plf.151.1656450312706; Tue, 28
 Jun 2022 14:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220517140748.24238-2-cgzones@googlemail.com> <20220607170035.40090-1-cgzones@googlemail.com>
In-Reply-To: <20220607170035.40090-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 28 Jun 2022 23:05:01 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==gTydDpHQN2YC_n1iVRsSqZGmHxhfu1CFGgniZ8a-Z3w@mail.gmail.com>
Message-ID: <CAJfZ7==gTydDpHQN2YC_n1iVRsSqZGmHxhfu1CFGgniZ8a-Z3w@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: restorecon: avoid printing NULL pointer
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jun 28 23:05:14 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 7, 2022 at 7:00 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The variable `curcon` is NULL in case the file has no current security
> context.  Most C standard libraries handle it fine, avoid it nonetheless
> for standard conformance.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Hello,
What is the status of this patch? As it looks good to me, I can merge
it if nobody has any more comments.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> ---
> v2:
>    print "<no context>" instead of "(null)"
> ---
>  libselinux/src/selinux_restorecon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 9f5b326c..3c441119 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -744,7 +744,9 @@ static int restorecon_sb(const char *pathname, const =
struct stat *sb,
>                         selinux_log(SELINUX_INFO,
>                                     "%s %s from %s to %s\n",
>                                     updated ? "Relabeled" : "Would relabe=
l",
> -                                   pathname, curcon, newcon);
> +                                   pathname,
> +                                   curcon ? curcon : "<no context>",
> +                                   newcon);
>
>                 if (flags->syslog_changes && !flags->nochange) {
>                         if (curcon)
> --
> 2.36.1
>

