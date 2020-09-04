Return-Path: <SRS0=VTMH=CN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88A5C433E2
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 21:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7E52078E
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 21:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DhemKUhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgIDV7X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgIDV7W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Sep 2020 17:59:22 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032DEC061244
        for <selinux@vger.kernel.org>; Fri,  4 Sep 2020 14:59:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a15so10411103ejf.11
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2020 14:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5sj8Qs8D244b3DypbkVLK9SyzByIH1TSJxbsczlHJv0=;
        b=DhemKUhWJ1l++sfpfTPanfr2H5ctoJjFoQYr2T0m0NMZWUZuuixxnUF3vFHS6Vuc9M
         B2aFtIvz2x98v6Aei58a0BVXpOj4o5KpCmbs41waO1Uu7BTlHU0n39LzeKSYWuG07zUN
         rRTZvntMJbTDhWwI/fQOvTr5LruA9Ao8BvpWGsHETFYVauFbIc08/LUN6Pb9cJoN38FF
         3Rt9sYCffUlLNzUlf3+wA3QC3jz58jiMuQNuoa0x2AFJFmvwrrK2HTVSDGgK/lVTeDFW
         5EiBQn47TSoiw5/uhVuPpZzfpVQbiLRREYHDOBtjN+Px9GqUtBF9PdrY6SQ0ZrmRG9zs
         aoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5sj8Qs8D244b3DypbkVLK9SyzByIH1TSJxbsczlHJv0=;
        b=Phv3r35kQGTOwL7OGhck5aMo9PSazQATed9mb6KfxhSzhwFjvHkRpvyp0ahTmccZHo
         y30kJ0mn5jg0HDTAnhhMJ0Uf8Dmk0MllKEdm1bACAzTA296Ls1deR5tAi/eeqN/8AZuR
         jO+2wZ/Hd7vCOYstUAzPbppStYYysAg9Z+Zu7vhb1yfondB3m7qjphjin4OAynz055GW
         H38wPS41FbSnitAqr2h4rbHjQhKO0uyNa8GEFqBloI/wc8wlGz1KNpbI2g6Q50Aj0YZx
         BZwvfntoCXMzeyOdYcgzTQQthcJuiuP3WlAGRZYKyeRZQCRjM+TeD4v9NPcFHIG98zIc
         Avzg==
X-Gm-Message-State: AOAM532Mvfu4L4/tOHFUZE+KouyBwwjvUsBZAIzSC0B4AuqAq8nJzShQ
        2feHC+WKEXOVKgDzo665jqrFlMLxcwOuTGVA41vk
X-Google-Smtp-Source: ABdhPJyEo302Bpff3ClIcmQHpPcN7oCXqhq2TQCQ5B9CTFtk+KixYuWcSnC0gp7xea3RivSrzCT9299b9ttsc/6vX2s=
X-Received: by 2002:a17:906:8c8:: with SMTP id o8mr9529534eje.91.1599256760459;
 Fri, 04 Sep 2020 14:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-8-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-8-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Sep 2020 17:59:09 -0400
Message-ID: <CAHC9VhTqec_n-4y+Qd_i_YEOx6hrb5qKTDubWR1Y6mwCf3zgUA@mail.gmail.com>
Subject: Re: [PATCH v20 07/23] LSM: Use lsmblob in security_secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:09 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change security_secid_to_secctx() to take a lsmblob as input
> instead of a u32 secid. It will then call the LSM hooks
> using the lsmblob element allocated for that module. The
> callers have been updated as well. This allows for the
> possibility that more than one module may be called upon
> to translate a secid to a string, as can occur in the
> audit code.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  drivers/android/binder.c                | 12 +++++++++-
>  include/linux/security.h                |  5 +++--
>  include/net/scm.h                       |  8 ++-----
>  kernel/audit.c                          | 20 +++++++++++++++--
>  kernel/auditsc.c                        | 28 +++++++++++++++++++----
>  net/ipv4/ip_sockglue.c                  |  5 +----
>  net/netfilter/nf_conntrack_netlink.c    | 14 ++++++++++--
>  net/netfilter/nf_conntrack_standalone.c |  4 +++-
>  net/netfilter/nfnetlink_queue.c         | 11 +++++++--
>  net/netlabel/netlabel_unlabeled.c       | 30 +++++++++++++++++++++----
>  net/netlabel/netlabel_user.c            |  6 ++---
>  security/security.c                     | 11 +++++----
>  12 files changed, 117 insertions(+), 37 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
