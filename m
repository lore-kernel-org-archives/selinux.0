Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68220C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 14:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1981A2075A
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 14:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIpvZvfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgIJO6s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbgIJOyx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 10:54:53 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F06AC061573
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 07:54:50 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g96so5553929otb.12
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsEL2o9TqhN0BHPfTgRUuvqZeEYQLFgzSBetZGTJ/VE=;
        b=tIpvZvfrd0Ll6MUaH6kHSA+1sLTNkOyZQ7vRmxigqFBxLNH43SSilcpZHFvTD3B7uz
         B8P45WT4X3tzXkVEBxSOzP1d2PhDuTgccYGOTRSidv3Bc7yh+Tu0MJyiYDzwKmDE2NVD
         nlakxLIWvgHdHfHtL3p2uXUkrrHnpHTVjoDer4BGXgIt03Ci5G+sM6ShVvqkk5rJN4hr
         hLGzxIWFOeRaB7cel+7WOnuGASOhOgJPVZ5yV4vZJFPYZbuTgeQgxTIaMMT41q8uHHnr
         Yz+N4cMvLpyT75JLA2jiGt7O/XDwGDDeOVH9zH5qfiUpMtHAynKDs8I9jlJ5tJ22CTbh
         juIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsEL2o9TqhN0BHPfTgRUuvqZeEYQLFgzSBetZGTJ/VE=;
        b=H86ODZleTbyskJUm2y5eJrhMjhE1zd+komIo0E+jBn9/7Zr5blzTI3hVcmz9YIWnhz
         n/sxh6tlYvMQZHbiP8ieoRyRLuCynmRpHKj2qmxQl5SOWrKMo/9+j4treLFCzgznDNGY
         w0gUwpHncYm6hltnZ/g6FPx05iqPxFbeKY/6CZk5+EeH4QBeKafzcEpq1LmyujCLmzf8
         oTJEISIebRTUO3t2drsZI+sLMDitFvkSFO59vpuYTFtgLhxiwuBUslhgl7CmJOR46Vgq
         I/IYXviiJegaFDm0TYQ4sOnFGsBB80YQ18sb/yFOxjY/8+14+AbzeWP7aOInSuEcBYm/
         99KQ==
X-Gm-Message-State: AOAM5314STNlnQswfvBKWS/qhg+Pe2gwapPhCM5vwaAlm5wsVl34rekG
        oU92BIcIYlvhRewassQsWTq+VAjlMnjBt1eGQC2qjznh
X-Google-Smtp-Source: ABdhPJyRdqcofRvp0PAz1stnz44rEh+UbNnJ7Q6OzE3V9M/g+xueclagWOzavKTJgUIbfh6WZZZZBYaCEI77lKy07/g=
X-Received: by 2002:a9d:185:: with SMTP id e5mr4335137ote.135.1599749689499;
 Thu, 10 Sep 2020 07:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
 <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
 <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
 <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com>
 <20200819171459.GA57975@localhost.localdomain> <CAEjxPJ54j6PD6oBMWj7wOVskJuUY=BLpMCkdmmqwrP1DGJ0VqA@mail.gmail.com>
 <CAFqZXNuPCwvf2BNYrxxL-DqcwLQBCS9b78iQBfKDsWXOy8pvyg@mail.gmail.com>
 <CAEjxPJ4HMyabC+WwNwjO33SaFn9vKd1zZUR8n-wjrzN6bkHgMw@mail.gmail.com> <CAEjxPJ7n7irnx93xsNamWsuvoEaOQqDkgwPXJod8rrXUciOWng@mail.gmail.com>
In-Reply-To: <CAEjxPJ7n7irnx93xsNamWsuvoEaOQqDkgwPXJod8rrXUciOWng@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 10 Sep 2020 10:54:38 -0400
Message-ID: <CAEjxPJ6wViyeub1NMvTLjSaLRT2zu2sLap1+uVqVDtiSNnAVzA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 10, 2020 at 10:36 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 10, 2020 at 9:31 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > 2) For cases where an error is returned by SELinux that is not already
> > governed by a selinux_initialized() or enforcing_enabled() check, we
> > just need to ensure that all such cases are gated by such a check. We
> > fixed that recently for the removexattr security.selinux case and
> > there were some earlier cases fixed with respect to setting labels
> > before policy load.  The specific concern raised in the thread
> > appeared to be due to denials silenced via dontaudit rules, which
> > won't happen if there is no policy loaded so I don't think that's
> > relevant.  There are other cases where SELinux might return an error
> > if a new case is introduced in another kernel subsystem without
> > updating SELinux to handle it, e.g. a new type for
> > selinux_perf_event_open(), a new obj_type in selinux_path_notify().
> > It would be better if we could introduce build-time guards to catch
> > these as we have done for e.g. new capabilities, new socket address
> > families, new netlink message types, in order to ensure that they are
> > always in sync.
>
> On second look, selinux_perf_event_open() is ok because the type
> values are specifically (and only) for the security hook, so anyone
> adding new PERF_SECURITY_* types should see the need to update the
> hook implementation too.  selinux_path_notify() case is different.

For selinux_path_notify(), there are in fact other fsnotify object
types defined in fsnotify_backend.h but
fs/notify/fanotify_user.c:do_fanotify_mark() only ever sets obj_type
that is later passed to the hook to one of the three values it handles
(inode, vfsmount, sb).  Since that could potentially change in the
future, we should likely change the security framework to define its
own set of SECURITY_NOTIFY_OBJ_TYPE_* values and have the hook callers
explicitly translate to one of those.
