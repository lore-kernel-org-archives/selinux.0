Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8FAC433EF
	for <selinux@archiver.kernel.org>; Wed,  2 Mar 2022 16:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbiCBQlI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243455AbiCBQkx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Mar 2022 11:40:53 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB24BCF385
        for <selinux@vger.kernel.org>; Wed,  2 Mar 2022 08:40:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id p4so3083219edi.1
        for <selinux@vger.kernel.org>; Wed, 02 Mar 2022 08:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dNbJGASQ5Pj2olNDJ4E1SAdB9M2qC/RceXbqjCgevtY=;
        b=53WQyjvtsJ967nxw064K6rlqD8DBASReSiaFU3UtkrQoEA9KmD2N+rZyt4nAh+OGR7
         OvpHFgrvRoedLzNzHmnSy6Xq4zhaqdnpjeVsnPwobfIdkD8WwSKyTyHQ5m6w6IDXLHQ6
         UpBoYjXOdVEKRstIfV+jekLCjABp4OOIK3dt74b7lMbWLkXT9jjXEp/utyqyDx1C7I0S
         2gFuIhj/r5nnbgK0oAWINj5lTWDWtekBFVNk66Y6cIKPxL7t1CrQLr7T4Lm96zygWoSP
         T/XfNj7Y9k2m0iU0tJjekoWVrowrILvJa4UzsU8SYy+eGgX9072x3xCEk697DJ29eveq
         dLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dNbJGASQ5Pj2olNDJ4E1SAdB9M2qC/RceXbqjCgevtY=;
        b=7q9H2gIDFtYKY+mY4KgjHTLKFOTtrPusoVcQeJlRvSjDAX5lRtSPHIVWP5RmQusyWz
         MVhd2prMBabeJn7OfY3SJ5nwWFrq54jK4vOq9f9JhMsu/Gv5cctDs+fUPuxft1hxEFJK
         IxIdkFXgbfpVHFF+u/FCBER08knrYjg6H66j8UbytR/h1DNdnBz51aNX5S2CaiFenGUv
         uxHRjuAHeATnkgWVTsSfn04rXVnU5a7/ODQRsuJJQWk8FIRtzDlyKKMjxp9QwiAa4eUJ
         JFhTqohF3jB2sK0hP8maDs5r+cPEPcvKIVpT6R2Ytqbw5PkdfcGBSH5+GxGzoRrTJXGS
         QKpQ==
X-Gm-Message-State: AOAM531AV+wCtD9imcoE6HeSK6ihkTImBg0ckJaIxxA+y2LZ7EBKw9Fe
        QL+0ibr/wH+e4UoEYjgtL2pk/mw0g2Q1XbLcZgljmVjxYQ==
X-Google-Smtp-Source: ABdhPJwB8arf/8kgwdaPXwraj+ftl1MBRqX6y5fTQKgk/6mXG2LDpd3fUDY3Bapu3m0NR1PsXFr931gYtS0EX4r+Uho=
X-Received: by 2002:aa7:c896:0:b0:413:c96d:6bfd with SMTP id
 p22-20020aa7c896000000b00413c96d6bfdmr13254017eds.331.1646239206839; Wed, 02
 Mar 2022 08:40:06 -0800 (PST)
MIME-Version: 1.0
References: <164615727605.32677.11271643808590060552.stgit@olly>
In-Reply-To: <164615727605.32677.11271643808590060552.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 2 Mar 2022 11:39:55 -0500
Message-ID: <CAHC9VhTuyv73X4icRv+VUt470yUHbxu55Z0eb3GjAViZGYjiPg@mail.gmail.com>
Subject: Re: [PATCH] selinux: shorten the policy capability enum names
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 1, 2022 at 12:54 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The SELinux policy capability enum names are rather long and follow
> the "POLICYDB_CAPABILITY_XXX format".  While the "POLICYDB_" prefix
> is helpful in tying the enums to other SELinux policy constants,
> macros, etc. there is no reason why we need to spell out
> "CAPABILITY" completely.  Shorten "CAPABILITY" to "CAP" in order to
> make things a bit shorter and cleaner.
>
> Moving forward, the SELinux policy capability enum names should
> follow the "POLICYDB_CAP_XXX" format.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ima.c                     |    4 ++--
>  security/selinux/include/policycap.h       |   22 +++++++++++-----------
>  security/selinux/include/policycap_names.h |    2 +-
>  security/selinux/include/security.h        |   18 +++++++++---------
>  security/selinux/selinuxfs.c               |    2 +-
>  5 files changed, 24 insertions(+), 24 deletions(-)

Merged into selinux/next.

-- 
paul-moore.com
