Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975FBC43381
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 15:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DFA2070B
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 15:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfBVPxt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:53:49 -0500
Received: from ms.lwn.net ([45.79.88.28]:52604 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfBVPxt (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 22 Feb 2019 10:53:49 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 23E3D7DE;
        Fri, 22 Feb 2019 15:53:48 +0000 (UTC)
Date:   Fri, 22 Feb 2019 08:53:47 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>
Subject: Re: [PATCH] doc: sctp: Merge and clean up rst files
Message-ID: <20190222085347.7384a026@lwn.net>
In-Reply-To: <CAGXu5j+Cy_Ku=1zyLpXLnJXNKieu3L_SZq3Rn_D0jm=N5szt9Q@mail.gmail.com>
References: <20190217220836.GA41179@beast>
        <CAHC9VhSdW+eLx3RNwMZ-Wn7BUv9ayPubZLxSZzSj_ab-k84ZGQ@mail.gmail.com>
        <CAGXu5j+Cy_Ku=1zyLpXLnJXNKieu3L_SZq3Rn_D0jm=N5szt9Q@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, 17 Feb 2019 19:59:20 -0800
Kees Cook <keescook@chromium.org> wrote:

> > Are you planning this to go via the doc tree, or would you like me to
> > grab it for the SELinux tree?  Either way is fine with me.
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>  
> 
> Thanks! I figured it'd go via the docs tree since it's mainly moving
> files around in there. I figure it's up to Jon. :)

...and I've just applied it, thanks.

jon
