Return-Path: <SRS0=VTMH=CN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B532FC433E2
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 12:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6E22158C
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 12:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcwppctU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgIDMtv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgIDMto (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Sep 2020 08:49:44 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DABC061244
        for <selinux@vger.kernel.org>; Fri,  4 Sep 2020 05:49:42 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 109so5755671otv.3
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2020 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7F5J/QFpZ8B6bzr6m9HtDlvNw8zpabu5LAuZygB3Oo=;
        b=dcwppctUe9PG5BdDH7JOW80fvnztPnnu3su9M549Wdeq1bxb2f+zdjmiDolo8fkYw3
         ozhTEwlhR/ZHWUsWB049gvy3pm/auY1hVUn1L049U75T0uEtOjYzIVk2NhhCgDj8W3Bh
         Z/KdIA+3Tsl/BcIUYHNT9+CVMV1O+lDhQLsmiD5rBSQdV4NJ/Ug1Bko4fU2w4NLsO+Ar
         B2AK2N+nD6XoHkIjkPQg8MxqAesMcY9nzc5fqyifcpr8RCWrFSEQM7HXjmaQSLKWOc1q
         2zkRZcgsKD3K6mmMM6jyaaX2Vaz9KUSZobFRKfxipcQFSer2sSXph3IFwJPAfgkXCoF9
         /sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7F5J/QFpZ8B6bzr6m9HtDlvNw8zpabu5LAuZygB3Oo=;
        b=BMnuKmtBLY4rcq1eB2Ns9x6Xwq2j3XhJ06XApYLvDiqb4jbQssKmir4UmC16dfRv+J
         orVSmv/GH4DgrM3kdCrNC71cYfnc2hsb2DRkUmIYWA0RRv/IoAhlKXWUV70sku2R/3m/
         HNj+tiZPepjPghGBPH3dQUk8WDIfbBlJCugDSIu+p0SiZb4CI9273g1sOPh622cWwjTC
         0FWbF7wmo/Fs5jjxxWdTZEn76YvglRnCGcIZXEBv6fj9wrQu9WYU8clPOOm6bJsIkX5C
         RNN6zSgu2qIdNd4TqnN/IHt8LDgaYceVPeCEp22sorJNjz73S1kOMs5TgHPqPwo1tI3B
         wt8w==
X-Gm-Message-State: AOAM532iljgtyVdNUFFYZhGK/n8CcXOZrutcKx7W7Z7K5Nv9NI935RQr
        ll3iM+AH43iuCxdIgd9xn8kWROxGA7cdpId3RpqtXuvV
X-Google-Smtp-Source: ABdhPJyzsVmwB+m7Ta4G6V7iBXcbMAnPlseuborbhUVVuUicUdUyrfNfYfuzPAwXs96eI5bM7hFLXKkh7YRFfczvhyo=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr5293991otb.162.1599223781367;
 Fri, 04 Sep 2020 05:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200903181900.81179-1-jwcart2@gmail.com>
In-Reply-To: <20200903181900.81179-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 4 Sep 2020 08:49:30 -0400
Message-ID: <CAEjxPJ53Z6z2VAw75QOHZdK-kFz1fnkEFth7acyUGh_2nzpGkQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Give an error when constraint expressions
 exceed max depth
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 3, 2020 at 2:19 PM James Carter <jwcart2@gmail.com> wrote:
>
> CIL was not correctly determining the depth of constraint expressions
> which prevented it from giving an error when the max depth was exceeded.
> This allowed invalid policy binaries with constraint expressions exceeding
> the max depth to be created.
>
> Correctly calculate the depth of constraint expressions when building
> the AST and give an error when the max depth is exceeded.
>
> Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

The fix for conditional boolean expression depth checking can be a
separate patch.  For this one,

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
