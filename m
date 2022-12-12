Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F6C00145
	for <selinux@archiver.kernel.org>; Mon, 12 Dec 2022 23:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiLLX22 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Dec 2022 18:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiLLX21 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Dec 2022 18:28:27 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05558F01C
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 15:28:26 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id n3so1014166pfq.10
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 15:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lDMpBs92GDwHHSGPWXE6ZbOfetatETM5r1yUsqZWmYU=;
        b=Kvh5zgo3uISQqMXTbxWjd9MNjk/vmARRZbcPyDRDL8hBhYNcHhlu/Wr8If4AkfsZn/
         ST2t+vgBR0VI2aRmpHcrJgkR2GjPXw9jQvJhsOM3bwvoj+Mf0AqE5esf+lc9C05eXbtQ
         F2c6OzCdLLnuy23a9X1IyYPulLgFSnABWGO/H8CDmU0t4T/6WhPpcvJR6ftQ3Ahc85OD
         osL/9UjGT71f6wO3/8VKBTLBIS4T0Rk0YUfVkksKAZ10G3G4zfMegjDuHcKMSbQIfIVP
         gefmOzT+y2l2rrfBiBncwpkVRnKXbgstDp5dbQvWSoD4HqVpVTW7PYdQmBu1qCaHtMgu
         g1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDMpBs92GDwHHSGPWXE6ZbOfetatETM5r1yUsqZWmYU=;
        b=SNhpa6DFVpNXKtXyMVbJy/hC9bVywMnwBE9x8O1wZbs1VcXdQXmqWYbVgsxKAKsYzD
         td+WTH0mVJq5gH496CUo9xn0QB7WSDGQ5JfMsp9ymE4W9KCVHQaYsZLAUn1DptOkZYbI
         pFEO/qcGnxS31P3cEWEQInBCA0gScm5hR70+fduQaghj2yMhoo1Xn9raInkUUZxbRojT
         L4W4adb4PQcit6mPt/lC2vLCVxePOJwisFziPgk5i1KLIJQj6eTWpX/lqhlN1LE5Myql
         kST4YU5WJ19PTF7bDpoMf+cmfyCU78hsqgIs0+YpmiveBP1kxpMKNffbIuulWUkTRAyz
         J9UQ==
X-Gm-Message-State: ANoB5pm5olSnO6VmfY3HvMwPgJI006pfYZE3y9os+qUJa58SlFStlOX6
        i0OQCO3ZMX7gy1LUMM1DktlZoUToUkJWEOU0Rd5v
X-Google-Smtp-Source: AA0mqf5nuk73f8SqlgS3qMu08yIFcWROfsVVv20WHkeTOTsnQKfKNmb9vRIE1UvLlCwc2nUXH5de7YLfmnytra2JeBI=
X-Received: by 2002:a62:e402:0:b0:577:62a8:f7a1 with SMTP id
 r2-20020a62e402000000b0057762a8f7a1mr8981577pfh.2.1670887705431; Mon, 12 Dec
 2022 15:28:25 -0800 (PST)
MIME-Version: 1.0
References: <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
 <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com> <CAHC9VhQzJAhNtpMnU7STEfq6QpaJo-xiie8HoHH2w3io3aXBHw@mail.gmail.com>
 <75d48710be78d59e990cbb3930133a4f42c95a30.camel@redhat.com>
In-Reply-To: <75d48710be78d59e990cbb3930133a4f42c95a30.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Dec 2022 18:28:14 -0500
Message-ID: <CAHC9VhTNh-YwiyTds=P1e3rixEDqbRTFj22bpya=+qJqfcaMfg@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix LSM labeling for passive msk
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        mptcp@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 12, 2022 at 10:36 AM Paolo Abeni <pabeni@redhat.com> wrote:
> If the preferrede solution is via a new LSM hook I have no objections
> at all. I'm sorry to put another hook mainteinance on you.

Don't worry about it, sure there is a bit more code, but I think it's
a better approach than all of the alternatives we've attempted.  I'd
rather have "better" than a hack ;)

> How do you propose to preceed? After quickly digging into the relevant
> LSM code, the only module I think I could handle in a reasonable
> timeframe is selinux. Hopefully the new hook implementation should be
> quite straight-forward for the relevant SME.

That's sounds reasonable to me.  Our policy in LSM land is that you
should provide at least one LSM implementation when adding a new hook
(the BPF LSM doesn't count due to it's rather unique approach), so if
you can provide a SELinux implementation that should meet that
requirement.  I'm also not sure that any of the other LSMs currently
claim support for MPTCP.

> I guess the patch[es] should target the LSM tree, as the change in the
> mptcp code should be a one-liner. On the flip side, that would likely
> lead to some merge conflict, as the mptcp protocol impl. is quite a
> moving target.

The LSM has also seen a lot of renewed activity lately.  However, I
think the deciding factor is where the bulk of the code will live, and
with the vast majority of the code expected under security/, I think
it makes sense to merge this via the LSM tree.  My general policy for
the LSM tree is to either base your patches of Linus' tree or the
lsm/next branch and I'll handle whatever merge conflicts arise at the
time of merging.

For reference, the current LSM tree can be found here:

* https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git

-- 
paul-moore.com
