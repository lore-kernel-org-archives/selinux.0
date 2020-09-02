Return-Path: <SRS0=YX5s=CL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE92C433E7
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 18:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE2120758
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 18:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="cfKgPSO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBStd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIBStb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Sep 2020 14:49:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF9FC061244
        for <selinux@vger.kernel.org>; Wed,  2 Sep 2020 11:49:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b79so413514wmb.4
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2020 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=yrT562NicWPhLNxxCAYol7fge47KQs7XcNLScf+g5yI=;
        b=cfKgPSO/nUJpLE+oXlBfFYHfM6DW/HzDKlL7vOjJlBpfGJ1YINugO8Y12ohPi0F/as
         1yZ6gGnRaK98jB94geZ9eYaANueQPW18wAcfdBu99cOfJP2GvWEaD4z2aBby8G7IEzNW
         45gGwfT90b6Ju6b+mErcN7/jX8fiMmTDas/Tp47V5m+WogOQUbK15ggF95g6Z/KpJT3S
         rVAfl8ptoEEm813nOMhy3de0qi1RV9dFSomxLUCdM65To/J9T/iwXIzTiyb8WzUg0NB+
         iiuSyi0xi4E/SmgE3QNj7ptffjtmFPRWdOPe365SX3Ts/5sH5te9oJwW9rHTSHImjj2h
         1HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yrT562NicWPhLNxxCAYol7fge47KQs7XcNLScf+g5yI=;
        b=jqLtXvtB8l83wU/nrUvAF8rn0zihNP51YlTaIBsKxBbvtZ5sS1VRG6O6/lVPzuaFwt
         nwtScSrwwIV0XIQClBTWjoCANb9Swv0T62Kh4vVzUIJF6dNkQPeR4JJ4ttLExwhOoiBu
         4TyzamHrpM9+OLm6JNzkQxBamJpeh37nasQnIISkMgefiqJftgO/4ofWKx96w+niZdRZ
         RzFD9yQilUfWYV6O9YGhgoZaUJEaAwQOdlAcLLu9tnotEIv7wC5IqZdDVNCXN2dH3E8u
         A8yiDAYFCpRcuyb/kVCrQ948s3CgTJeAWeoHUu0xEGmGbO6CV38uXN/15xCzGP2JueA5
         Kx4g==
X-Gm-Message-State: AOAM530NILN1Pbe2xkP7YKmheUCQczakwX6jPUonKfqOZNRpA6yx+e8q
        4L+lCN7xDjBdMVCf+xWECnuP8wD29WRGSTk2qfnwuVAJMZ3qQDZA
X-Google-Smtp-Source: ABdhPJx7nGRdGwHzvESuTNGkzvXVNnR9sZnJVgMdCINpYqfynWUevvids+SM0ZGoN2i2PqnpA7BSxsTBdzes1bfFAlo=
X-Received: by 2002:a1c:f402:: with SMTP id z2mr1887968wma.87.1599072569261;
 Wed, 02 Sep 2020 11:49:29 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Wed, 2 Sep 2020 14:49:03 -0400
Message-ID: <CAGeouKFjz1GRa4X7CNfc7WNqzrUu=dCLPOr47j3nEs6XaHj1mA@mail.gmail.com>
Subject: Options to audit2allow and manpage phrasing
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Folks, I've been studying audit2allow in order to understand how to
use the sepolgen library, and I've a couple of questions about how the
code is structured and how the manpage is phrased. One concerns
dontaudit (-D), the other concerns refpolicy (-R/-N). I'd appreciate
your reviewing this and setting me straight.

For dontaudit, audit2allow reads

       parser.add_option("-D", "--dontaudit", action="store_true",
                          dest="dontaudit", default=False,
                          help="generate policy with dontaudit rules")

while  audit2allow.1 reads

    .B "\-D" | "\-\-dontaudit"
    Generate dontaudit rules (Default: allow)

Since '-D' defaults to false and only sets dontaudit true if present,
shouldn't the man page read

    .B "\-D" | "\-\-dontaudit"
    Generate dontaudit rules (Default: False, do not generate dontaudit rules)

???

They may mean the same thing, but the second reading seems clearer to me.

It's a bit muddier for refpolicy-style-output, for which audit2allow reads

        parser.add_option("-R", "--reference", action="store_true",
dest="refpolicy",
                          default=True, help="generate refpolicy style output")
        parser.add_option("-N", "--noreference", action="store_false",
dest="refpolicy",
                          default=False, help="do not generate
refpolicy style output")

The corresponding lines in audit2allow.1 are:

    .B "\-N" | "\-\-noreference"
    Do not generate reference policy, traditional style allow rules.
    This is the default behavior.

    .B "\-R" | "\-\-reference"
    Generate reference policy using installed macros.
    This attempts to match denials against interfaces and may be inaccurate.

Since both -R and -N set refpolicy, the only way I can make sense of
this is if defining the '-N' option *after* the definition of '-R'
overrides refpolicy as set by -R. That seems reasonable to me, but I
wanted to confirm. It might make it clearer if the -R option had a
default of false, as in

        parser.add_option("-R", "--reference", action="store_true",
dest="refpolicy",
                          default=False, help="generate refpolicy style output")

In other words, leave -R out, and default to the -N behaviour.

Since -R and -N are opposites, would it make sense to make them
mutually exclusive?

        refPolOpt = parser.add_mutually_exclusive_group()
        refPolOpt.add_option("-R", "--reference", action="store_true",
dest="refpolicy",
                          default=False, help="generate refpolicy style output")
        refPolOpt.add_option("-N", "--noreference",
action="store_false", dest="refpolicy",
                          default=False, help="do not generate
refpolicy style output")

This would make it clearer that only one of these options should be
provided and that only -R changes default behaviour.

Thoughts?

Thanks,

P

Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP
