Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC82C433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CAA2177B
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Fns7Qv2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgH0OVv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgH0OVf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 10:21:35 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A9C06123B
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 06:55:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q4so5015876eds.3
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JE/FlvnCbFhw4S4rsB8hpI2t9izCkIupsVpNkBNhba0=;
        b=Fns7Qv2fUSULPzMYchhGojZlqdvJtstNFjs8lzpQvboxhGJb6L7kF2J34uJHExaXo7
         A5WenHCc0Kowwvd58kq+/CiU39B5DlFBjdhz0zCFSvDJTbs3B37bOo3zUlEhO+0fLNgQ
         DkCTsVGIeQfokAGQ6RqyiAWtRmVnKPunEcea696OYVHHVBfi/CiVhrAkWttAR7jbL2Ol
         vUP3rELtvvDGJF55ITqEW0Wsl9ZDBn4QXv3+BKxPZrihAqobW8d3R83zcgNF5Amivo5T
         NZbTCdeOkHSBKDSG5D/DKiDlus9l/CWD47BTL/y9WCeKM/mSp/4jLdj1KweaW6WkLLXB
         RaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JE/FlvnCbFhw4S4rsB8hpI2t9izCkIupsVpNkBNhba0=;
        b=ZYM7H2DYCE225RXFsgpDWl4zXawHtclPeMlcLu2YOA8i+vAz1SzSvUjGDMBR4N0y55
         HzhVbvPwsKRBQrdEsbOANEjTVxLGizSL1wtzmcobIiZF9YfLb076Tzt+WY8RhPYsNkMu
         VnzDoTyTIpB7zJp+d3MWyAyhhbk1ggQL+aJolTC2wkhE7F/W2kDceJviPKR7D/bMlODN
         Fd8xH3byG1QN1ImSbyu3R98wXcyUsEX1YSBHQIgog6o1gLO9bRtdbaaUL+G7ABIJyo5N
         woqbzjs+GLgx7UTM+M798mjqxoBws7yAmGXIrBu/fcenrRDmCCS7U7DGMEL0I12LOnQ/
         pPJg==
X-Gm-Message-State: AOAM531Xtkivg9IUwGuAam9JcWn9BOr2UVaTPK9y0aJY0aY3A40ASR4f
        C6sYe3yuNwWZxalrceNYh8bQKZAkWFiUM+cyelZC
X-Google-Smtp-Source: ABdhPJzwjUwvvlLP6RqOjzA9C3YdTJI8eX1nKYkLAUdyC+kdJv6xzMEwwnTswbeuKlFHqzEqylIoWELUzJk5OMZdwAk=
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr19433331edv.135.1598536538415;
 Thu, 27 Aug 2020 06:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200826172853.49426-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200826172853.49426-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Aug 2020 09:55:26 -0400
Message-ID: <CAHC9VhSougbm39_KA1KvN=KsAoeBkpsqn+hS99ZRwS3iWGAL0A@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: move policy mutex to selinux_state, use in
 lockdep checks
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        peter.enderborg@sony.com, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 1:29 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Move the mutex used to synchronize policy changes (reloads and setting
> of booleans) from selinux_fs_info to selinux_state and use it in
> lockdep checks for rcu_dereference_protected() calls in the security
> server functions.  This makes the dependency on the mutex explicit
> in the code rather than relying on comments.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 switches selinuxfs from using &selinux_state.policy_mutex to using
> fsi->state->policy_mutex.  selinuxfs operates on fsi->state->policy
> for all policy reading or modifying operations.  It only acts on
> &selinux_state for checking permissions in the current context.
> At present, fsi->state is always &selinux_state; this will change
> when selinux namespaces are introduced.
>
>  security/selinux/hooks.c            |  1 +
>  security/selinux/include/security.h |  1 +
>  security/selinux/selinuxfs.c        | 26 ++++++++++----------
>  security/selinux/ss/services.c      | 37 +++++++----------------------
>  4 files changed, 22 insertions(+), 43 deletions(-)

Thanks Stephen, merged into selinux/next.

-- 
paul moore
www.paul-moore.com
