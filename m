Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6031C433F5
	for <selinux@archiver.kernel.org>; Mon, 10 Oct 2022 22:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiJJWAy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJJWAy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Oct 2022 18:00:54 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486CF59265
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 15:00:50 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id y72so7340889oia.3
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zK36e9Vx/hFePI+T7ZJUnNnknw4X+mt+F8ztkRT+ZSQ=;
        b=BpWWbdBqr3T1stkL5mdXuTWAdPul5xXoI3gUIpp/gP94eQYocgVU8+m7JCPYapLC5x
         YorYa723Ed44HsdvxcxgH2SfdWEQb4RJBEcUwuwxDl6VXvId/pdW498xi43S9/ZqM46l
         K6VNNh5y/6eW/qhTNm3BdgMUJyXKvj5gtSIIc1OUTgDX5RiccoHWqkMC/9+HqZN27mJ5
         m3WRgi+OXZ8KRz0TeMSOqASMCThbBeaMQsX78IlUa88mlXOn6VDARxZAZ1V1fJqXPJdk
         5dxzC2QwiESHPWPXkHuXVG6t5VHUYafRKiupUTQ13rd82mDZjPW4edTkgCLCdV1pnmS0
         VxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zK36e9Vx/hFePI+T7ZJUnNnknw4X+mt+F8ztkRT+ZSQ=;
        b=Gk+3721tSQPSxXPlXqhLPC3FvDknwkv96b6qL6M0iPbZsccS8juK5N+MdxXFTigCKC
         qTXuY6bkpdGz7hYlDIGWMBCMquWVSIzx4t2iNdA+rGtAAILQiRBZAPUlCZvoOkq08vZr
         PktIvg2zZeOTHRW8J6BI12RBL9BzNCUvCFibCpHcr/s0Tuvx/vA57+0rf+++zrJBHrz6
         ruEl2k1PDmjs4gL8MnT54PZSRO5MJa1jKruQ306zwXOMWpgbjapsosdiJe56k9Yc4Ld7
         pgOrOVGWY8XLQjoTRPwFBw4SvDJDIsy3p9grQecNesVnSZCFGEd9py2981k0PdHlkqK0
         45gQ==
X-Gm-Message-State: ACrzQf2BDPY5vRomKO8pJapf91hE6QbHLXyGptGAXA5VCU7/UlQE3GKI
        dZ89M23mgDywYV+V5duLwo+xZoIODBHmgNoUvTTv
X-Google-Smtp-Source: AMsMyM5vsz00GWERn3z9uwzRpEUSLoQNJTdOHkNcqfDmT+j6pYJtv6zmtMFRI8GvWJQvtlMO7K6V4dGO3WySidPDhA0=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr15544993oiv.51.1665439249073; Mon, 10
 Oct 2022 15:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <166543910984.474337.2779830480340611497.stgit@olly>
In-Reply-To: <166543910984.474337.2779830480340611497.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Oct 2022 18:00:38 -0400
Message-ID: <CAHC9VhRfEiJunPo7bVzmPPg8UHDoFc0wvOhBaFrsLjfeDCg50g@mail.gmail.com>
Subject: Re: [PATCH] lsm: make security_socket_getpeersec_stream() sockptr_t safe
To:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 10, 2022 at 5:58 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
> sockptr_t argument") made it possible to call sk_getsockopt()
> with both user and kernel address space buffers through the use of
> the sockptr_t type.  Unfortunately at the time of conversion the
> security_socket_getpeersec_stream() LSM hook was written to only
> accept userspace buffers, and in a desire to avoid having to change
> the LSM hook the commit author simply passed the sockptr_t's
> userspace buffer pointer.  Since the only sk_getsockopt() callers
> at the time of conversion which used kernel sockptr_t buffers did
> not allow SO_PEERSEC, and hence the
> security_socket_getpeersec_stream() hook, this was acceptable but
> also very fragile as future changes presented the possibility of
> silently passing kernel space pointers to the LSM hook.
>
> There are several ways to protect against this, including careful
> code review of future commits, but since relying on code review to
> catch bugs is a recipe for disaster and the upstream eBPF maintainer
> is "strongly against defensive programming", this patch updates the
> LSM hook, and all of the implementations to support sockptr_t and
> safely handle both user and kernel space buffers.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h |    2 +-
>  include/linux/lsm_hooks.h     |    4 ++--
>  include/linux/security.h      |   11 +++++++----
>  net/core/sock.c               |    3 ++-
>  security/apparmor/lsm.c       |   29 +++++++++++++----------------
>  security/security.c           |    6 +++---
>  security/selinux/hooks.c      |   13 ++++++-------
>  security/smack/smack_lsm.c    |   19 ++++++++++---------
>  8 files changed, 44 insertions(+), 43 deletions(-)

Casey and John, could you please look over the Smack and AppArmor bits
of this patch when you get a chance?  I did my best on the conversion,
but I would appreciate a review by the experts :)

-- 
paul-moore.com
