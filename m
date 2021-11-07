Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5191C433F5
	for <selinux@archiver.kernel.org>; Sun,  7 Nov 2021 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E8461159
	for <selinux@archiver.kernel.org>; Sun,  7 Nov 2021 14:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhKGOPx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 Nov 2021 09:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhKGOPw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Nov 2021 09:15:52 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A0C061570
        for <selinux@vger.kernel.org>; Sun,  7 Nov 2021 06:13:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r12so51820695edt.6
        for <selinux@vger.kernel.org>; Sun, 07 Nov 2021 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/8bLRVi7dxv/9MASDzNQG0suFX7w4MEKyGAhcaOmtQ=;
        b=yi3zBMtPTUhA4YOSggoL1+XRKolOBDBTagP31xlRyE4I804LZUtIx7V2Vj9B4+Md4L
         pRySWKh2i3CnoSO31LrzU9xpG5Vdd9QCpNUYKbxofcKTXf/KCCZzpPxRZJYfPvmrX1G3
         8sMifZJM0aZ53HfYhuYZvcMsmO1iIIRfxbusTFPCt6GGQw+VprCEnllCVNwuoe9lZgto
         jDVVp2ySWIS1wkymDhLxNzmtwFUmdDeXMVZvzHUZW6Xm2D2tpOl+VokFAguQIAr8Qaot
         f4F/HGoeBmHxU74v8DUovBi/OKDIs65LvbiQo8PNCUFeoA/A1QQQZAQ4iAkW21sLRsXa
         GJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/8bLRVi7dxv/9MASDzNQG0suFX7w4MEKyGAhcaOmtQ=;
        b=5co9Ouw0bn6uO1xsgFeW7cMqw7E9gzG0zbn5pcdFjcspvtxveI1biSFdnBrSSsXD08
         5gxvOkiC+lYauwUHGG65kz9qe1qTIjc8IC4eFkry/IHhJ8HBmhC0r/07McQ5Wk13FABw
         wPwFPMMocrqhJGu8L5X6IvJaf6yXsnJ6IlNJ/MnfSsoUQWqtuLHjsDuDsKtfBjxe1vjC
         IXlBJc001inZx6+fvcGCTUZEeqkd5fb6n+4aniAACOtKoRUnEA1SNMZ3E6SIiUhQ0S/2
         A+PDHJbDD2B28T+GW1ZgNyb3txptOOjhzWbbOX+QNflDCc/1tcGHlkZYGhteuscG/tRd
         WbWg==
X-Gm-Message-State: AOAM531/3dOfhIzIh+k7S5pLhOtoV0tcwyx6l8RGvhlH7mmT2Ygrefww
        9+Spk09aAtV2Nuc3EXuvQchxZlm98RpyQi1mnVeC
X-Google-Smtp-Source: ABdhPJxcjyzrhjw45p8G8n8WvvcwB4V30YZiOXbmjJus85QXuwma8cKK6NpWxAc70tFMV+J67qu2uzk/ur2A5n1w4Gs=
X-Received: by 2002:a50:8dcb:: with SMTP id s11mr67368043edh.318.1636294387862;
 Sun, 07 Nov 2021 06:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20211104195949.135374-1-omosnace@redhat.com>
In-Reply-To: <20211104195949.135374-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 7 Nov 2021 09:12:57 -0500
Message-ID: <CAHC9VhQwpKWBF2S=vTutBVXeY9xSfTRuhK9nM9TariLVUSweMA@mail.gmail.com>
Subject: Re: [PATCH net] selinux: fix SCTP client peeloff socket labeling
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 4, 2021 at 3:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The commit referenced in the "Fixes" tag mistakenly attempted to
> preserve the label of the peeloff socket that had been set in
> selinux_socket_post_create() in the case of a client socket. However,
> the peeloff socket should in fact just inherit the label from the parent
> socket. In practice these labels are usually the same, but they may
> differ when setsockcreatecon(3) or socket type transition rules are
> involved.
>
> The fact that selinux_socket_[post_]create() are called on the peeloff
> socket is actually not what should be happening (it is a side effect of
> sctp_do_peeloff() using socket_create() to create the socket, which
> calls the aforementioned LSM hooks). A patch to fix this is being worked
> on.
>
> In the meanwhile, at least fix sctp_assoc_established() to set
> asoc->secid to the socket's sid and selinux_sctp_sk_clone() to
> unconditionally get the peeloff socket's sid from asoc->secid, which
> will ensure that the peeloff socket gets the right label in case of both
> client and server SCTP socket. The label set by
> selinux_socket_post_create() will be simply overwritten in both cases,
> as was the case before the commit this patch is fixing.
>
> Passed both the selinux-testsuite (with client peeloff tests added) and
> the SCTP functional test suite from lksctp-tools.
>
> Fixes: e7310c94024c ("security: implement sctp_assoc_established hook in selinux")
> Based-on-patch-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> As agreed with Xin Long, I'm posting this fix up instead of him. I am
> now fairly convinced that this is the right way to deal with the
> immediate problem of client peeloff socket labeling. I'll work on
> addressing the side problem regarding selinux_socket_post_create()
> being called on the peeloff sockets separately.
>
> Please don't merge this patch without an ack from Paul, as it seems
> we haven't reached an overall consensus yet.
>
>  security/selinux/hooks.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

When we change things as significantly as we are doing here, i.e.
shifting some of the labeling away from the endpoint to the
association, I much rather we do it as a chunk/patchset so that we can
review it in a consistent manner.  Some of that has gone out the door
here because of what I view as recklessness on the part of the netdev
folks, but that doesn't mean we need to abandon all order.  Let's get
all the fixes and repairs queued up in a single patchset so that we
can fully see what the end result of these changes are going to look
like.  Further, I think it would be good if at least one of the
patches has a very clear explanation in the commit description (not
the cover letter, I want to see this in the git log) of what happens
with respect to labeling on the server side, the client side, during
socket peeloffs on both ends, and how multiple associations are
handled.  My hope is that this should give us all a more consistent
view, which will be very important moving forward if netdev is going
to act independent of the other subsystems.

-- 
paul moore
www.paul-moore.com
