Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E76AC4332F
	for <selinux@archiver.kernel.org>; Tue, 15 Feb 2022 20:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbiBOUJG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Feb 2022 15:09:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242392AbiBOUJG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Feb 2022 15:09:06 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B5AB0C42
        for <selinux@vger.kernel.org>; Tue, 15 Feb 2022 12:08:54 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qk11so26288004ejb.2
        for <selinux@vger.kernel.org>; Tue, 15 Feb 2022 12:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhJlt5ZCYoidBqqNJ5EsFOz8HUlOmyfI7AV8Vc3JkYk=;
        b=ADoOeEn89ke3US6l0YM5nqedXSf+e9ChVnMnFsvfT7bO8qng9v6Ta1Rj8Ds/J4fnho
         JC3kI6BGKVlJgdUYnf82vkkoyXm/N71P0w6DJKZrzd5Cu2zgnNl0NhFzos5niPdtMbSU
         /MILDymIqGvkOWWPqa6cWe4U7kVCqXpjwmKgrV1zBUhAGK3e/8SCtoYhjzWpNOQT9g6n
         hCMwtfdf6Zb5rSnDACVc3b0BhSXs8+Jbakg1KlxkGOFZ/8pexlNdDMUNwSWZeFvOqi/o
         1rnk/qIn72rf6ybZ3U8mlqscNN1JRZYSq23BpzPUuDC9AQzkkxmqYrHEGoA5LH1Pr/2N
         c60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhJlt5ZCYoidBqqNJ5EsFOz8HUlOmyfI7AV8Vc3JkYk=;
        b=UqBrnDFSEMY6nsTirwgIO7K1bVnxsCdtUKZjrRYUuGAZGzk1cDQO3rSeo8TZ4zZb2S
         UcjkwsQEUcteTEIfrIe0U7gJltz7WiPqBD8+FRPPgNCexR+EkWb1LL1RkQtJP4zNyUjd
         3+/fcIBh4n1klNoWdDQtJY/xj9nus7ZdlNc0AM+JfX4lnSGu+dSYwX70EASuREWslu0e
         1ibg7iE2VECv6itmabMeE+NqoUVwLNjZ/hTlv/kl2ZYTbr/Q3h90XCppoLaXwEyD3Ffi
         dc5LXNdDLQoiHuUlca5YBSwpdVpHxQ0phYinLyaMs9L2hDK4zMGbojDzxs3OIdUguU5x
         sJCA==
X-Gm-Message-State: AOAM5333j3Wrvv+nBiCPJeThnLftC1POJv12bWo1kS9NLwVvZMgSgoyx
        CyYrmrSqw7N33gfpuOIoQBnkd9Yb6ksJ8QEa1uXf
X-Google-Smtp-Source: ABdhPJwZfMoC74QO9F+UqNNbECHuXUN/j7hFbn1Broo/RJdOcztLDt/AZzopuLRcYVoSxv2IibHJvuduoX2biLV87Os=
X-Received: by 2002:a17:906:6498:: with SMTP id e24mr639141ejm.12.1644955733109;
 Tue, 15 Feb 2022 12:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20220212175922.665442-1-omosnace@redhat.com>
In-Reply-To: <20220212175922.665442-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Feb 2022 15:08:42 -0500
Message-ID: <CAHC9VhR3qjmq461HyO7OwgicmEmzDjgshdocSqvYEZMk_BfceQ@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] security: fixups for the security hooks in sctp
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        selinux@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 12, 2022 at 12:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This is a third round of patches to fix the SCTP-SELinux interaction
> w.r.t. client-side peeloff. The patches are a modified version of Xin
> Long's patches posted previously, of which only a part was merged (the
> rest was merged for a while, but was later reverted):
> https://lore.kernel.org/selinux/cover.1635854268.git.lucien.xin@gmail.com/T/
>
> In gist, these patches replace the call to
> security_inet_conn_established() in SCTP with a new hook
> security_sctp_assoc_established() and implement the new hook in SELinux
> so that the client-side association labels are set correctly (which
> matters in case the association eventually gets peeled off into a
> separate socket).
>
> Note that other LSMs than SELinux don't implement the SCTP hooks nor
> inet_conn_established, so they shouldn't be affected by any of these
> changes.
>
> These patches were tested by selinux-testsuite [1] with an additional
> patch [2] and by lksctp-tools func_tests [3].
>
> Changes since v2:
> - patches 1 and 2 dropped as they are already in mainline (not reverted)
> - in patch 3, the return value of security_sctp_assoc_established() is
>   changed to int, the call is moved earlier in the function, and if the
>   hook returns an error value, the packet will now be discarded,
>   aborting the association
> - patch 4 has been changed a lot - please see the patch description for
>   details on how the hook is now implemented and why
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/
> [2] https://patchwork.kernel.org/project/selinux/patch/20211021144543.740762-1-omosnace@redhat.com/
> [3] https://github.com/sctp/lksctp-tools/tree/master/src/func_tests
>
> Ondrej Mosnacek (2):
>   security: add sctp_assoc_established hook
>   security: implement sctp_assoc_established hook in selinux
>
>  Documentation/security/SCTP.rst | 22 ++++----
>  include/linux/lsm_hook_defs.h   |  2 +
>  include/linux/lsm_hooks.h       |  5 ++
>  include/linux/security.h        |  8 +++
>  net/sctp/sm_statefuns.c         |  8 +--
>  security/security.c             |  7 +++
>  security/selinux/hooks.c        | 90 ++++++++++++++++++++++++---------
>  7 files changed, 103 insertions(+), 39 deletions(-)

This patchset has been merged into selinux/next, thanks everyone!

-- 
paul-moore.com
