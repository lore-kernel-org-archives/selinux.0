Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B355DC3F2D1
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 20:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AA720848
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 20:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuWiRYK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgCDU4R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:56:17 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43435 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDU4R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 15:56:17 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so3553505oif.10
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 12:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iarKbDoJOaqWPAJE7IPr+Tg9FjpwlF4vriidOc8LgI=;
        b=ZuWiRYK8ExWNp530+6QjW9Se22suWy39Y/DKvzjG8yDRwp6uG7izfEd3PHZVp77OEM
         VNFpblhryzJWpsukOT0HbUuWHChli6tJNEMGm2XsFLOKjS6d5T887ExmY4xoxSwtfZ/U
         1y8CyOQwkzMbTbq4ktH5kxzpR24m3rnSdl+aQxAiFcRkl3tId3a61vvFt30uZWQtOf2R
         W0G+NPfLuYeFkd+DBTrb0K5nr2xfbcHgkbWC4GkVGBbBX611t4jduBzjKGVmznMu1hzY
         /vshhQXfpnmo0LbxmLdeWp+jChLa8Anv9pUPC4iRfDkNkV58WVwsbleXT3oMik9nvckY
         EKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iarKbDoJOaqWPAJE7IPr+Tg9FjpwlF4vriidOc8LgI=;
        b=Drb2fRJTKe3OosVjHotz/A8WkcXUM4IcH/v2xkMPFoQ57GVi7XlNBt5UT4sfgDqdA/
         EEHaufB3R+0k5F1x3LNXKmYFYBDOJr/MtWTt0o3B4kXC8wRz09D0NLTsONqvCUXeE0Vw
         pyu9pMgwfelrlnuxmWCa7tIBg34BPQGiGaGxzpzJ8leRp3l1t/TaxYpK37nsYMcJm5c1
         DNJSdUqCqR1LzDyD72h2JhFjoOA4xmlGChxhHtp1F5kGjBpLpf3Ke8fQ5+P7kPGUUT0w
         qlZiEF4VPliYVz/k2mzb7xFhL2uyNWm4OVstvA28YKxn7Na/hCX6ZcRDre1NFfp1oUbB
         qW/A==
X-Gm-Message-State: ANhLgQ3mqc10Unr3N9jGmTCgSxTwFUWpvi0czPUKQRGfjFnH2m1w+UA/
        qw5NdsBD6LmiCNVpBMVskThuR43IM3qhrQl5CgxQlg==
X-Google-Smtp-Source: ADFU+vsD/H8L5jhdWbIjs/WqZNfXtIRBR4q+q+c7lGdMlEgU+9iJ2TjaVfEZEv4kN9x+KC9LwAk5XiyksPNv19jv6w4=
X-Received: by 2002:aca:fd4f:: with SMTP id b76mr3213756oii.140.1583355375033;
 Wed, 04 Mar 2020 12:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20200303085233.137371-1-omosnace@redhat.com> <CAEjxPJ5XHa2JLMf_BmhHV=LNBUe7qgM8Le6_PMX=jYjGb2OXvA@mail.gmail.com>
 <CAGB+Vh4RVwSraAGn1caEXOvHySkmgzgAfV7aZ-pwWKeUVyV_ag@mail.gmail.com> <CAGB+Vh69hcAjRG7aoDbCO6RyATWFoOBzEBcAYyGRWWHkE9RSFQ@mail.gmail.com>
In-Reply-To: <CAGB+Vh69hcAjRG7aoDbCO6RyATWFoOBzEBcAYyGRWWHkE9RSFQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 4 Mar 2020 15:57:22 -0500
Message-ID: <CAEjxPJ6w+n=1XvA72FKPOnQSDjA+tKsUZRfY5HUd+_RxgBkosA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: add test for default_range glblub support
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 12:18 PM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
> It's been a while so I'm just rereading mine, I also attempted to
> differentiate between MLS and MCS policies on the system running the
> tests so that they could run on the MLS policies directly (which is
> where glblub support is utilized), and I also verify the default (non
> glblub) behavior to ensure we didn't impact normal computations.
>
> Unless there is a compelling reason I think mine should be merged
> rather than this one.

Comparing the two:
- As you said, yours in theory supports a system running mls or
neither-mls-nor-mcs policy.
However, I'm unclear that one can run the testsuite under anything
other than targeted policy w/ mcs currently.
Is that something you have actually done?
- As you said, yours tests non-glblub behavior too.  However this
makes an assumption about the base policy default_range rules
that might not be true?
- Ondrej's uses the more compact (range c0 c1023) notation in the cil policy.
- Ondrej's checks that checkpolicy supports policy version 32 in
addition to the kernel, necessary to build the policy.
