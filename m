Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C25C433FE
	for <selinux@archiver.kernel.org>; Mon, 10 Oct 2022 13:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJJNTn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Oct 2022 09:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJJNTk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Oct 2022 09:19:40 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCA9E73
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 06:19:39 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso12419707fac.6
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ElFZdwWFu/6S3XkLX3CTGFQ16KWpQJXO6RCVrOcV5c=;
        b=Lh3pTx2cU2pFUru1KHkuwGd6QDSu7dv1JxT+fUL1XyW4Pl/rZqXVIC+0W+TwuD0tnF
         /UzptMzh3N50czivsSJByp01PyE8j0NjIrandssAnrIk9v92ZhOoZVDKCAj6zuvy/U2P
         yVYG/Q24u07xmdKG6IfLe5Gzc1agfFyTz3PFWxYHcC9u5iea8W8eK4jcFFnxTJqbTL6K
         G4SOsDSr4HBGeid9OA6eUirjAw1IGOB6bBaW/tIqPogQsyzf46tNEPMIc3R9063KLs8e
         xrVjy1MZD6TISrOzdb+5up8M1/nQ6zHbg7efnmN2JS193W5HDyj81rk8d0L0Ase/ms2k
         c8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ElFZdwWFu/6S3XkLX3CTGFQ16KWpQJXO6RCVrOcV5c=;
        b=fGELXptCtD//B3ESA750WsleV4bNg3F2H9IhBAkuOcJDtCK3CFaWw2iqOGhz1nVzR8
         gqx1Vr7H56aIdtbvgSmFFF5f0wxg7GJMaj4fA/zcfugRdqnISnl/3kNkzKRnxwoM32tp
         8O5FHCj6KlubQct9Jhh0iJS/novrDYs8aUhzaJCOyRRQzONFqw33FwSZNg5deH/D2DrU
         /OwCDC+bmow0yIIxP4Pd0OPeNwl2sv4h6YK71CWJEVduPsT1PsvUnIAxjmMk4dNZKnw7
         r966QjsL4PMcl0hV0UG5DP9uyQg6VER0sjmwrC8lrhzc7OHglR7LZnaD10ODiGIGxI2b
         eZsQ==
X-Gm-Message-State: ACrzQf0EdFtoEzpdcxhDV7K28mSUDJpnqB0SHDCJVDPaumGcbi3h6zj+
        boea72rQXxM8Zt6CZebr9injFg+57evuSdyPC653
X-Google-Smtp-Source: AMsMyM4H/2qrz4TmHeWAOhhUYMI5/EmNCvUNzLMtMX8Vc9ozSYRF3abxt24AkFTZGzVPKrT3H89145uv/ujsH6K2/+U=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr15490250oac.51.1665407979148; Mon, 10
 Oct 2022 06:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTGE1cf_WtDn4aDUY=E-m--4iZXWiNTwPZrP9AVoq17cw@mail.gmail.com>
 <CAHC9VhT2LK_P+_LuBYDEHnkNkAX6fhNArN_N5bF1qwGed+Kyww@mail.gmail.com>
 <CAADnVQ+kRCfKn6MCvfYGhpHF0fUWBU-qJqvM=1YPfj02jM9zKw@mail.gmail.com>
 <CAHC9VhRcr03ZCURFi=EJyPvB3sgi44_aC5ixazC43Zs2bNJiDw@mail.gmail.com>
 <CAADnVQJ5VgTNiEhEhOtESRrK0q3-pUSbZfAWL=tXv-s2GXqq8Q@mail.gmail.com> <df4df4eb70594d65b40865ca00ecad09@AcuMS.aculab.com>
In-Reply-To: <df4df4eb70594d65b40865ca00ecad09@AcuMS.aculab.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Oct 2022 09:19:28 -0400
Message-ID: <CAHC9VhQRywim8vKGUM+=US0nq_fqZH7MShaV2tC14gw5xUrSDA@mail.gmail.com>
Subject: Re: SO_PEERSEC protections in sk_getsockopt()?
To:     David Laight <David.Laight@aculab.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 10, 2022 at 8:54 AM David Laight <David.Laight@aculab.com> wrote:
> From: Alexei Starovoitov
> > Sent: 07 October 2022 22:55
> ....
> > Not easy at all.
> > There is only way place in the whole kernel that does:
> >                 return sk_getsockopt(sk, SOL_SOCKET, optname,
> >                                      KERNEL_SOCKPTR(optval),
> >                                      KERNEL_SOCKPTR(optlen));
>
> Until I add change my out of tree driver to work with
> the new code.
> (Although it actually needs to do a getsockopt into SCTP.)
>
> I didn't spot the change to sk_getsockopt() going though.
> But KERNEL_SOCKPTR() is really the wrong function/type
> for the length.
> It would be much safer to have a struct with two members,
> one an __user pointer and one a kernel pointer both to
> socklen_t.

Yes, agreed.

> It isn't really ideal for the buffer pointer either.
> That started as a single field (assuming the caller
> has verified the user/kernel status), then the is_kernel
> field was added for architectures where user/kernel
> addresses use the same values.
> Then a horrid bug (forgotten where) forced the is_kernel
> field be used everywhere.
> Again a structure with two pointers would be much safer.

Any chance you have plans to work on this David?

-- 
paul-moore.com
