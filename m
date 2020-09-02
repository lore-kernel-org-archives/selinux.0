Return-Path: <SRS0=YX5s=CL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2335C433E7
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 19:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852C42083B
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 19:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="icj1fw4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgIBTe7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgIBTe6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Sep 2020 15:34:58 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F9FFC061244
        for <selinux@vger.kernel.org>; Wed,  2 Sep 2020 12:34:57 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 934552A0CF5;
        Wed,  2 Sep 2020 21:34:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 934552A0CF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1599075291;
        bh=fJAhtlCShjFBFcg8Bv7FqauFVOSt1ymBuhUA5zPRS2Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=icj1fw4h79oekTQJ6JkqE/OEZWp+mIzlReQ2Ok7SvD/5wFshOqN/lTFimF7tTyvvh
         PrjNAggE+1GPUqqygUFE5Zj9NVFC4whyKfA0YlJ/DAqng1D6TEngsu+dHwq0zPGFZ5
         HQzAoseXP2DnT6hkkby7MOF1Mk4RH6UKLnDjMG9o=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Peter Whittaker <pww@edgekeep.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: Options to audit2allow and manpage phrasing
References: <CAGeouKFjz1GRa4X7CNfc7WNqzrUu=dCLPOr47j3nEs6XaHj1mA@mail.gmail.com>
Date:   Wed, 02 Sep 2020 21:34:46 +0200
In-Reply-To: <CAGeouKFjz1GRa4X7CNfc7WNqzrUu=dCLPOr47j3nEs6XaHj1mA@mail.gmail.com>
        (Peter Whittaker's message of "Wed, 2 Sep 2020 14:49:03 -0400")
Message-ID: <ypjly2lsvup5.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Peter Whittaker <pww@edgekeep.com> writes:

> Folks, I've been studying audit2allow in order to understand how to
> use the sepolgen library, and I've a couple of questions about how the
> code is structured and how the manpage is phrased. One concerns
> dontaudit (-D), the other concerns refpolicy (-R/-N). I'd appreciate
> your reviewing this and setting me straight.
>
> For dontaudit, audit2allow reads
>
>        parser.add_option("-D", "--dontaudit", action="store_true",
>                           dest="dontaudit", default=False,
>                           help="generate policy with dontaudit rules")
>
> while  audit2allow.1 reads
>
>     .B "\-D" | "\-\-dontaudit"
>     Generate dontaudit rules (Default: allow)
>
> Since '-D' defaults to false and only sets dontaudit true if present,
> shouldn't the man page read
>
>     .B "\-D" | "\-\-dontaudit"
>     Generate dontaudit rules (Default: False, do not generate dontaudit rules)
>
> ???
>
> They may mean the same thing, but the second reading seems clearer to me.
>
> It's a bit muddier for refpolicy-style-output, for which audit2allow reads
>
>         parser.add_option("-R", "--reference", action="store_true",
> dest="refpolicy",
>                           default=True, help="generate refpolicy style output")
>         parser.add_option("-N", "--noreference", action="store_false",
> dest="refpolicy",
>                           default=False, help="do not generate
> refpolicy style output")
>
> The corresponding lines in audit2allow.1 are:
>
>     .B "\-N" | "\-\-noreference"
>     Do not generate reference policy, traditional style allow rules.
>     This is the default behavior.
>
>     .B "\-R" | "\-\-reference"
>     Generate reference policy using installed macros.
>     This attempts to match denials against interfaces and may be inaccurate.
>
> Since both -R and -N set refpolicy, the only way I can make sense of
> this is if defining the '-N' option *after* the definition of '-R'
> overrides refpolicy as set by -R. That seems reasonable to me, but I
> wanted to confirm. It might make it clearer if the -R option had a
> default of false, as in
>
>         parser.add_option("-R", "--reference", action="store_true",
> dest="refpolicy",
>                           default=False, help="generate refpolicy style output")
>
> In other words, leave -R out, and default to the -N behaviour.
>
> Since -R and -N are opposites, would it make sense to make them
> mutually exclusive?
>
>         refPolOpt = parser.add_mutually_exclusive_group()
>         refPolOpt.add_option("-R", "--reference", action="store_true",
> dest="refpolicy",
>                           default=False, help="generate refpolicy style output")
>         refPolOpt.add_option("-N", "--noreference",
> action="store_false", dest="refpolicy",
>                           default=False, help="do not generate
> refpolicy style output")
>
> This would make it clearer that only one of these options should be
> provided and that only -R changes default behaviour.
>
> Thoughts?

I think that would probably be an improvement. The reference policy
specific option (-M) should probably be removed in my view.

>
> Thanks,
>
> P
>
> Peter Whittaker
> EdgeKeep Inc.
> www.edgekeep.com
> +1 613 864 5337
> +1 613 864 KEEP

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
