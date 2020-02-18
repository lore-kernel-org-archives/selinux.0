Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA36C34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996512173E
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 13:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XXVVNlyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBRNrj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:47:39 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:44461 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgBRNrj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 08:47:39 -0500
X-EEMSG-check-017: 59606880|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="59606880"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 13:47:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582033655; x=1613569655;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=I7rcuS4kE84HZyT/BZ8bRhUPE9Jh0n0gf7X+jgE4Xgs=;
  b=XXVVNlyN1k9RHeMuzzl/ab0kseic9jwlJblrkXwcG+Y/MY3XqSfl/QrW
   HjXhC/tfxn1E6lLj2oTNZj4sdURXqGBHI6LFK/NxtoVQdsa97x4DHi+BN
   UPHhsxPl17dyIjf8RJKNPIAT0KgZvtKQPobbXXlz14O/V46cbFyv2yhwX
   9bdCwcm0mO2MdbA6wRs6mNHbqtCldR800Ra5DA8z1zfvyvMtD99Whlub0
   WGMF0yJk3Q49LbJmhSrsk0f0Xo2qhILph03ADUw981sAyLQiwH2zcqcpe
   krDMZPHNycMVoFsuCqfkEmfz0oYwAa2dl9mj4c+6V4KYBqwgc91UA+9+Z
   w==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="33146453"
IronPort-PHdr: =?us-ascii?q?9a23=3AcCFvAxUVdb4ZDanxWhf1fB3+yT3V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSOv6dThVPEFb/W9+hDw7KP9fy5BSpfsd3c7jgrS99laV?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4lvJ6U+xh?=
 =?us-ascii?q?bJo3ZDZvhby35vKV+PkBnw4du98oR++CpKofIh8MBAUaT+f6smSLFTESorPW?=
 =?us-ascii?q?Mo6sD1rBfPVQSA6GcSXWUQiRpIHhPK7ArmUZfrsyv1rfRy1S+HNsDrV780WD?=
 =?us-ascii?q?Ci76B2SB/0jSoMKjA0/H3LhsF2kalWuwyqqQBhzIHIYYGVLPt+cb3bfdMGXm?=
 =?us-ascii?q?pKQ8JdWzVcDo+gc4cDCuwMMuhCr4n5ulAAsx2wCwexD+/r0zNFhnv70ag83u?=
 =?us-ascii?q?88Ew/JwRYgEsoTvnrKotX7NKQcX+67w6bHzzrMc/xY1Czh6IXKaB0tve2AUL?=
 =?us-ascii?q?xyfMfX1EIhFxnFjlKVqYH9Ij2VyvoCs3Cb7+V+U+KklnMpqwRrrTirwscjlI?=
 =?us-ascii?q?nIjZ8Sx1Df6Cp52504JcG4SUFnYd6kF4FctyeBN4RsWM8iTGZouDgjx7AApJ?=
 =?us-ascii?q?W1fzAKxYw6yxPQZPGLaYiF7g/5WOqPLjp0mmhpdK+5ih2v60av0Pf8WdOx0F?=
 =?us-ascii?q?tSqypFlcTDuW4V2hzI78iHVuN9/kC82TaTzwzT6v9LIUQzlafDN54u2KQwlp?=
 =?us-ascii?q?sOsUTYBCP2mUP2jKGRdkU/5Oen9/7rYqnmp5CAN490jRvyMqIylcykHes0KA?=
 =?us-ascii?q?0OX2mf+eik1b3j+1P2QKlSg/ErnaTUv4rWKMQGqqKjHQNY3Zgv5wyiAzu+1d?=
 =?us-ascii?q?QXh3gHLFZLeBKdiIjpPknDIOvlAvekmFmsjDdqyOzGPr3mGJnNKGPDn637cb?=
 =?us-ascii?q?Zy7E5c1hI/zcpD6JJMFrEBPPXzV1f2tNzdCR85KAq0zPz7B9pjzY4eQ3yADb?=
 =?us-ascii?q?KZMKzIrV+E/P4gI+6JZIUNojbyN+Al5+LyjX8+gVIdZrem3Z8WaHC+A/RnLF?=
 =?us-ascii?q?6UYWTjgtgfC2cGpAk+Q/LwiF2ETzFTY2y+X6Um5jE0EIimF5vMRpixgLyd2y?=
 =?us-ascii?q?e2BptWZmFaBVCLFXfnbZ6EV+0NaCKVJc9hiScEWKOkS4Iu2hCirgj6y6BoLu?=
 =?us-ascii?q?DM4C0XqYrj1MRp5+3UjRwy9yZ7D9+a02GLVGx0hn0HRyU43KB+p0x9y1CD0a?=
 =?us-ascii?q?5ij/NEEtxT4utDUh0mOp7E0+x6F9fyVxrZfteNUlmmX8mmASsqQd0r2NIOeV?=
 =?us-ascii?q?hyFMiijh/ZwyqmGaMal7uOBM98zqWJ+H79Pct/g1PBz68ohFQlCp9IMGq9gK?=
 =?us-ascii?q?d0+iDJCoLJmlnfnKGvI+BU5wPJ9WGe3SKKvVpEGFprXKHEW20PTlXZoM6/5U?=
 =?us-ascii?q?7YSbKqT7M9PV0S59SFL/5xdtDxjVhADMzmMdDabnP5z3y8Hj6U17iMa8zsYG?=
 =?us-ascii?q?xb0yLDXhtX2zsP9GqLYFBtThyqpHjTWXk3SAPi?=
X-IPAS-Result: =?us-ascii?q?A2DzAAD76Ute/wHyM5BmGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7AoF7gW0gEoQ+iQOGYgaBN4lwj1CBegkBAQEBAQEBAQE3BAEBh?=
 =?us-ascii?q?EACgic6BA0CEAEBAQUBAQEBAQUDAQFshUOCOykBgwEBAQEBAgEjFUEFCwsOC?=
 =?us-ascii?q?gICJgICVwYBDAgBAYJjP4JXBSCrTHWBMoVKg22BPoEOKgGFH4ceeYEHgTgPg?=
 =?us-ascii?q?igHLj6HW4JeBI1kiW5Gl3KCRYJQlAMGHIJJmF2ObYFMnAYHGIFYKwgCGAghD?=
 =?us-ascii?q?4MoTxgNjikXjkEjA5E9AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Feb 2020 13:47:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IDkR8R248878;
        Tue, 18 Feb 2020 08:46:28 -0500
Subject: Re: Duplicate hashtab code in libsepol vs. policycoreutils/newrole?
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@tycho.nsa.gov>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Jason Zaman <jason@perfinion.com>,
        Petr Lautrbach <plautrba@redhat.com>
References: <CAFqZXNte8PTA5E77kYtmX-1s0juzZ=MrdV0JOf9txbW9q1L46w@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3378893d-95d3-245e-ae52-65b9482bdf07@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 08:49:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNte8PTA5E77kYtmX-1s0juzZ=MrdV0JOf9txbW9q1L46w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/15/20 12:32 PM, Ondrej Mosnacek wrote:
> Hello everyone,
> 
> I noticed that there is a duplicate hashtab.[hc] code from libsepol in
> policycoreutils/newrole. Can this be deduplicated somehow? I can think
> of three options:
> 1. link to libsepol (a bit unsafe, since hashtab symbols are not
> versioned, but other programs already use non-versioned symbols form
> libsepol anyway...),
> 2. statically link with libsepol's hashtab.o (libsepol code would be
> needed in ../../libsepol to build newrole)
> 3. turn the newrole files into symlinks that link to libsepol ones
> (similar issue as above, the symlinks would have to be substituted for
> actual files when creating release archive).

I'd say none of the above. Nothing should be using a non-versioned 
symbol from libsepol unless it is statically linking libsepol, and we 
don't want to grow the set of users of the static libsepol (if anything 
we want to shrink that set).  We also don't want to create extraneous 
dependencies.

> If we really can't get rid of the duplicity, what should be the policy
> for updating the hashtab code? Should the same changes be done
> simultaneously to both copies? Or should we change only libsepol and
> treat the newrole copy as mostly frozen legacy code?

I'd say the latter - ignore the newrole hashtab.[ch] copy unless/until 
you have a real reason that it requires an update for newrole's sake. 
Treat it as a fork (which it is).

> The thing is, I'd like to make some small changes in them, but I'm not
> sure how to handle the duplicity.
