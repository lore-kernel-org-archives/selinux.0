Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68CEC35280
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DCA521835
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 20:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cztTOp5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgEAUcu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 16:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgEAUct (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 16:32:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE3CC061A0C
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 13:32:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id re23so8467880ejb.4
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 13:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzxGzOOcT5SFWrqcyLSPsyVKv3RZx+xLXfqF7sCHHFQ=;
        b=cztTOp5ms+6syTR/dN3T0NTnUqMlZoAnBV0RfBtYABl9l5CQZ9ynOEmTQ2WhSt1kD+
         Kin01ebd5kMprFETC0MvN6+l9VFjItiuIxn5bR3UB5GqbCcsOgPny256575JP5qxL4Pn
         lZ3EJrjRbqcbU9y/yd4TNBWDboSTdCuQe4RZhEFbd2QQK0rLX24Be9Ppi98fzwI9jOxM
         hgz+6lzvO/6gvT5oPWJWPaIFpYlszjSF8GSxtAD9jOgMGaLoamxOYZa7ETytF6cWXJSn
         SPRIAdp4gubrJ6wm3+rqDWRtmH9fyw3J4sf4LdqD/UdPBIYyOKQt7+/CaAuomt+3npQG
         /d2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzxGzOOcT5SFWrqcyLSPsyVKv3RZx+xLXfqF7sCHHFQ=;
        b=dd9h1otzExHoTTPqTIpRcVNyDHlja3tWLS+W+WVeoF+7wnJ9+wYjpXX5EHZEMRgpz/
         OoSTo1i/pQaoQKEGaK0mmoQ8p9gtpuYBtz50hx3Lujb+YQ+m6u9sbwsc1XBicT53MdKa
         qTnRtcRzjQRPfOF+L8PEM9/6CUyYmQdR/QkdEnY1jOblHg+nZkkt5M33V332F65sMHvh
         xWh4LbskPZQ0tCKtAiFQv00cKyDUPhS6TYCV3cUBcifgx6oL5z1MlPznyzZzm9rij9Ax
         WN2DDLyIiyiPgBmgcWfKNykRwTxM5MzPq/V33/EvLTu/Av5sm4pxdAxBsE1xkb3UROub
         RFSA==
X-Gm-Message-State: AGi0PubNiKbNOnOqxd8iHAbr9TTnCUThSmvN25txQT7gR8Q144IqO4Vq
        PI8FIfI72IBRXspu9f7hOUKgcbIgrOy0xv9JRdaK
X-Google-Smtp-Source: APiQypLgm2I3v16okVFHdAJvZZqnSD3vXjzpHhAqkuuUUKrEeocCChxfJamVhkbwyxVxVHCMU3omd8xwoEq5kxdAldo=
X-Received: by 2002:a17:906:35d0:: with SMTP id p16mr4837606ejb.77.1588365168014;
 Fri, 01 May 2020 13:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200428125514.2780171-1-omosnace@redhat.com> <20200428125514.2780171-4-omosnace@redhat.com>
In-Reply-To: <20200428125514.2780171-4-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 16:32:36 -0400
Message-ID: <CAHC9VhSP70QB4A4zjLScK1uGxBUhzHXi9UUVKk0kDoKbJF+PrQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] selinux: prepare for inlining of hashtab functions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 28, 2020 at 8:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Refactor searching and inserting into hashtabs to pave way for
> converting hashtab_search() and hashtab_insert() to inline functions in
> the next patch. This will avoid indirect calls and allow the compiler to
> better optimize individual callers, leading to a drastic performance
> improvement.

This commit description describes the next patch in the series, and
some of your motivation, but doesn't really tell me much about this
patch other than it is a "refactoring".  I need more info here,
especially considering my comment below.

> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/conditional.c |   4 +-
>  security/selinux/ss/conditional.h |   2 +-
>  security/selinux/ss/hashtab.c     |  44 +++++-----
>  security/selinux/ss/hashtab.h     |  22 ++---
>  security/selinux/ss/mls.c         |  23 +++---
>  security/selinux/ss/policydb.c    | 128 +++++++++++++++++++-----------
>  security/selinux/ss/policydb.h    |   9 +++
>  security/selinux/ss/services.c    |  38 ++++-----
>  security/selinux/ss/symtab.c      |  22 ++++-
>  security/selinux/ss/symtab.h      |   3 +
>  10 files changed, 178 insertions(+), 117 deletions(-)

...

> diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
> index 31c11511fe10..4885234257d4 100644
> --- a/security/selinux/ss/hashtab.h
> +++ b/security/selinux/ss/hashtab.h
> @@ -13,6 +13,12 @@
>
>  #define HASHTAB_MAX_NODES      0xffffffff
>
> +struct hashtab_key_params {
> +       u32 (*hash)(const void *key);   /* hash function */
> +       int (*cmp)(const void *key1, const void *key2);
> +                                       /* key comparison function */
> +};
> +
>  struct hashtab_node {
>         void *key;
>         void *datum;
> @@ -23,10 +29,6 @@ struct hashtab {
>         struct hashtab_node **htable;   /* hash table */
>         u32 size;                       /* number of slots in hash table */
>         u32 nel;                        /* number of elements in hash table */
> -       u32 (*hash_value)(struct hashtab *h, const void *key);
> -                                       /* hash function */
> -       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2);
> -                                       /* key comparison function */

I don't like how you've split the hashing and comparison functions out
of the hashtab struct and into their own data structure with no
explicit linkage between the two.  This is a bad design decision in my
opinion, and something we should try to avoid.

>  };
>
>  struct hashtab_info {



-- 
paul moore
www.paul-moore.com
