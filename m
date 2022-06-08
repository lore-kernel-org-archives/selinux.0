Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE2C43334
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiFHTXT convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Wed, 8 Jun 2022 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiFHTXS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jun 2022 15:23:18 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 12:23:16 PDT
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3894D1DC86D
        for <selinux@vger.kernel.org>; Wed,  8 Jun 2022 12:23:16 -0700 (PDT)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D0A5D56128B
        for <selinux@vger.kernel.org>; Wed,  8 Jun 2022 21:16:32 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id e24so19511032pjt.0
        for <selinux@vger.kernel.org>; Wed, 08 Jun 2022 12:16:32 -0700 (PDT)
X-Gm-Message-State: AOAM532PQusBrpql9a3Ayll/ocwIMHEpAneE1qycPKOVw+o04arSgB0Z
        kH4pYLcI2M7m6YjHFP0x+wJjU49f7SZKQ+XaxUM=
X-Google-Smtp-Source: ABdhPJwAZHorXfzeZkSVST0GAiendHvVRbUgmmZojWxUl5aF0ZmPPNWw3PnXczixJUdq3ymcQAPn19z2FhaQSjP/vG4=
X-Received: by 2002:a17:90b:3e85:b0:1e8:8f2f:bd2f with SMTP id
 rj5-20020a17090b3e8500b001e88f2fbd2fmr719021pjb.120.1654715791620; Wed, 08
 Jun 2022 12:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220607150145.29757-1-cgzones@googlemail.com>
In-Reply-To: <20220607150145.29757-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 8 Jun 2022 21:16:20 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==wRe=5QXr=g4VGwudXGiiWLdJeiyP9kM97TZS=D=nySg@mail.gmail.com>
Message-ID: <CAJfZ7==wRe=5QXr=g4VGwudXGiiWLdJeiyP9kM97TZS=D=nySg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix validation of user declarations in modules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>, bauen1 <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jun  8 21:16:33 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 7, 2022 at 5:02 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Users are allowed to be declared in modules. Modules do not get expanded
> leaving the `struct user_datum` members `exp_range` and `exp_dfltlevel`
> empty.
> Do no validate the expanded range and level for modular polices.
>
> Reported-by: bauen1 <j2468h@gmail.com>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
> index da18282b..99d4eb7f 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -18,7 +18,7 @@ typedef struct validate {
>  typedef struct map_arg {
>         validate_t *flavors;
>         sepol_handle_t *handle;
> -       int mls;
> +       policydb_t *policy;
>  } map_arg_t;

Hello,
As the policy is not modified, could this pointer be "const policydb_t
*policy;"? (And the last parameter of validate_user_datum be "const
policydb_t *p"). On the other hand, as policydb_validate.c does not
use any const pointer, feel free to disregard my comment.

This patch nevertheless looks good to me too.
Thanks!
Nicolas

