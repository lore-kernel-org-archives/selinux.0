Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D6CDB475
	for <selinux@archiver.kernel.org>; Wed, 11 Oct 2023 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjJKSum (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbjJKSuR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Oct 2023 14:50:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0221112
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 11:50:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-503065c4b25so294133e87.1
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050200; x=1697655000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBi02hgJmIKNB7KVVHq31Meg6rSiTVLCRGyYCMaDEy0=;
        b=PFbgmzRqwPBG+dvcWMW8nl8ZxbN8p9qO8QsLguJJtmhYGOapNA3JSWpqNVCVSH9KXt
         +FTHpJFZMsP40+zt/W12PhXmIBB8ghbOXdUkeD575k8H/LgjoW0BVKRnaauTsND+XzFV
         vVTKDizySF5w9oO+zXkQhpGgQ3I7m4do2isBFV5nfh90tNZA7eNJ5pugx0MER8Fm5jYE
         L70YFoPhpoYKW8DZfHRDM5mQ6ws2ogelBpdjBLiZnlGN61ZA9ogR+dFDI+rg33sclaq1
         f/1ZwdW0koMf7Fy8IK/CiEpo86M8KdHXgap67KN4w5vOfYye1oebJWMNpo5A5NH1k+Wk
         pREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050200; x=1697655000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBi02hgJmIKNB7KVVHq31Meg6rSiTVLCRGyYCMaDEy0=;
        b=BBFD4exCBEA9Rmh56cOMzwdfK7sa1KbIlDr4d/OF9A2PflqtZ0DPrEVGDkrOISaR3p
         2rVLgRROqWNpjpv91GzC7Idg0uvVXF/KRSdUViD2zwXtH+1kD2mEOhiMLUpFsQPzLNk8
         9xRVBMMm3Sq8sAJFLcGAFWsxr+38ysrSLhVOd0FH+QZytETwTmYvzhtXlHspowbqGq9W
         CpGU8U/0yauCJ4zAivkThg0KXBZ+tOUtqNg94rTJF2X0VCASPqlz9xyZbvD79dpMYuIq
         9AZBAzGhg0AKbGK8ka8tx0NgvnXDt1IdAJ/SSsdS5EeZgYxiB/dX1YFkNmeXmSDz6sYQ
         zh8w==
X-Gm-Message-State: AOJu0Yz6n6fePddsMi1/gFJhGJe7gw3i+4WkhcdKSE3yslJve1F0CrtM
        85TpKMBgIK1dQSJZEUhJusVveFQlDkk0h9u+EyyV8traEJ4=
X-Google-Smtp-Source: AGHT+IEy9ZmT/nJbhwI/m0+axkiBWksf2m6Cpyg2fzgre9gEnKpvFWY2wlGggZwJgL0MCrrQd9GO/n1Yz9qfxTSh7yY=
X-Received: by 2002:a05:6512:1326:b0:503:388f:30a3 with SMTP id
 x38-20020a056512132600b00503388f30a3mr20602693lfu.26.1697050199551; Wed, 11
 Oct 2023 11:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-23-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-23-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Oct 2023 14:49:48 -0400
Message-ID: <CAP+JOzRTxy+feD3cX6e-r+k4XM1X+4UOhB71Q8jrYywWOhOBtw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/27] libselinux/utils: drop include of internal
 header file
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> selabel_get_digest_all_partial_matches is dynamically linked against
> libselinux, so it should not depend on any internals and thus do not
> make use of an internal header file
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/selabel_get_digests_all_partial_matches.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c b=
/libselinux/utils/selabel_get_digests_all_partial_matches.c
> index c4e0f836..e2733b41 100644
> --- a/libselinux/utils/selabel_get_digests_all_partial_matches.c
> +++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
> @@ -8,8 +8,6 @@
>  #include <selinux/selinux.h>
>  #include <selinux/label.h>
>
> -#include "../src/label_file.h"
> -
>  static __attribute__ ((__noreturn__)) void usage(const char *progname)
>  {
>         fprintf(stderr,
> --
> 2.40.1
>
