Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E130DC77B73
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 22:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjEaWY0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 18:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEaWYZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 18:24:25 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72079F
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 15:24:23 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-568900c331aso1265287b3.3
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685571863; x=1688163863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oi+kxpsjM0R3ZKtaCQmHdOemwN8jrXhop8kskOBysM=;
        b=WYcxVp55abw4Qg93LbwDbWUqbUea1epr+9Rq0b8frDOOt3dKSrSkmSrS6hswRqLRun
         8JMlAgvWlFzrJdf5xdjz1FmaA32xg05al3XgnO5r8k/upgjf0QfXNi9bkC21b7wzCmc0
         cqDQ85Mcj5otBESJtffLUUVZ81MVABUjtlnad65dzf5tpnOq0k/fPc8qKjpDIji4wl3c
         7KZ0NMSedcU5rh0mYP+5FZ5GFXJNby++yUUnrI4N1qZyIUg0NYMfZR3RFfZ+pPCL1ZsV
         hImW30UthqLIqjaIG16oomPtdXrtSYdJqRvBvInmuYpr8+EtPlrzs14Sc0KtqfyEce4j
         vu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685571863; x=1688163863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oi+kxpsjM0R3ZKtaCQmHdOemwN8jrXhop8kskOBysM=;
        b=T/ZmFF5BxeRdgATBTPPGYMVwZ0LyBCFGwWPCa438AHBRZAbqx1oRmuTbBjby6tANsI
         PS7jSrS3aaRfPgQ2fV1V8ulpdDFa2hplJb9mcBAN3oxwuiWraj3/BzIO5K34627CpcRt
         tttTVFrK3FGzM5+6jKiP6Kr6vlIURfxRTxPkAjJY1bPBwweNX0fewipu2ATS+wc7MUe0
         32DjcCBMxpyejpixK5Sj857oWowosv0EwE4OD8AWxL6ZidPJlulKMUoTjImFtgI2lklp
         AszkntzB+Sdm9KKvjQQ+h6FxVD78GemFx2kljLwzj4K2g7gWZnVtkCFsk8OgVgDrLqUH
         cTZw==
X-Gm-Message-State: AC+VfDxDQI35i1X1gOHRGnlinDoCYjyIkPP2uEU3oLFNyxGH+Onxkazi
        dzlKZCR9F24ZV6+8wUZYmnZfArSwf66KWxMNriojLkJ5WpEt/j0=
X-Google-Smtp-Source: ACHHUZ4TaW9vTmLgrYMJUYwT+PdecTpgsqkFS6hFCROzlDXXyD2tB6JK+eqklFeRv1WMXBGaMNoLJBiWXEuuu0O3Cag=
X-Received: by 2002:a81:a115:0:b0:569:19e4:bd51 with SMTP id
 y21-20020a81a115000000b0056919e4bd51mr745141ywg.43.1685571863118; Wed, 31 May
 2023 15:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
In-Reply-To: <20230531112927.1957093-1-juraj@jurajmarcin.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 31 May 2023 18:24:12 -0400
Message-ID: <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com>
Subject: Re: [PATCH 0/5] selinux: add prefix/suffix matching to filename type transitions
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 31, 2023 at 7:32=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> Currently, filename transitions are stored separately from other type
> enforcement rules and only support exact name matching. However, in
> practice, the names contain variable parts. This leads to many
> duplicated rules in the policy that differ only in the part of the name,
> or it is even impossible to cover all possible combinations.
>
> First, this series of patches moves the filename transitions to be part
> of the avtab structures. This not only makes the implementation of
> prefix/suffix matching and future enhancements easier, but also reduces
> the technical debt regarding the filename transitions. Next, the last
> patch implements the support for prefix/suffix name matching itself by
> extending the structures added in previous patches in this series.
>
> Even though, moving everything to avtab increases the memory usage and
> the size of the binary policy itself and thus the loading time, the
> ability to match the prefix or suffix of the name will reduce the
> overall number of rules in the policy which should mitigate this issue.
>
> This implementation has been successfully tested using the existing and
> also new tests in the SELinux Testsuite.
>
> Juraj Marcin (5):
>   selinux: move transition to separate structure in avtab_datum
>   selinux: move filename transitions to avtab
>   selinux: implement new binary format for filename transitions in avtab
>   selinux: filename transitions move tests
>   selinux: add prefix/suffix matching support to filename type
>     transitions

Just a quick comment as I haven't had a chance to properly review this
series yet; you show some memory usage and performance measurements in
some of the intermediate patches, that's good, but I don't see the
same measurements taken when the full patchset is applied.  Please
provide the same memory usage and performance comparisons with the
full patchset applied.

--=20
paul-moore.com
