Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F904C47247
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 11:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33922206D7
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 11:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="atw6kE1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgEELen (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728233AbgEELen (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 07:34:43 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB65C061A0F
        for <selinux@vger.kernel.org>; Tue,  5 May 2020 04:34:42 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id r7so1456417edo.11
        for <selinux@vger.kernel.org>; Tue, 05 May 2020 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tazNIJx3hgg3/k7MSkhCvxxTQxUDlmyO+2LQQ846deA=;
        b=atw6kE1+PKYKgoCPZecvAzOVzt8hyV+ZTuodz0LiandlvtKYjls2Ga05NLT1pRBFT+
         7nyNXANE86Qh8l103cdMI0k3YPFc0OOaDaaFT0xhYyESouyVMxInAxEV6zbXaUYTp6uE
         +yJRgrXqQ1LTk62ssYTANZr4YI6l94iTKRUFWqyFc3DzbGXxlUpzSOWgmql1nX9eAqHf
         x1rXzJQOSNwHeqDbOHf2RBKfWqU6/dX3UCwyzGIuM3wRtQKTTMT6SBOjPj7Z26AIflc9
         nMvrL3l/8IECNyDHe2wdawfZIgt/ZjUVwciqznRWfOOPCQaA+mchzz2MSTrZV3vp/Npw
         94WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tazNIJx3hgg3/k7MSkhCvxxTQxUDlmyO+2LQQ846deA=;
        b=K2XQLZwkYQXCK5cCLnoYvstSTbgURv+zmFHbcC7U4P7da1W1w+jnVHe1jaaoyeHMZf
         4iqHUIbjGkjbkctqojIeY5dD/8JJXfY5OcN2usRgy8YWqRGuvx0OFzIw1F141yeJr7l+
         zNMxA00pf6QUrSGA02m7Peqg8jtHy8OL+P7mNWkGGKCyZ11BeNQi96ro0ip3A+KnAPRK
         WC4fQuoSG9fUHJmuLtGauHT9JyoNvGnS3V2S7bty5KgWOeTX1epmKFYNw08fEjXHEmM5
         kgdFSozwMy/jRqeyOi5KmUpGT47njJUjZp8r7qNKIlw4BgKF938UskbQihjfFlI8Y62J
         mq/Q==
X-Gm-Message-State: AGi0PuYauGtRVk/+YjMMgjz9tsbNjChAxvfISK+odLIRzxR7hADlc0oV
        wuJgc/mv4lZucFS2Jj5/viRcsU4QKEFePgeAvbOo
X-Google-Smtp-Source: APiQypL6/mlyUycz63HJ+HYyrpnkLHjyOdmnZ4TRLGMkoZAfP+nX7kW0xV1kUi4SFDMSvbvTunTVOhS+z9dx/lPEzmY=
X-Received: by 2002:a05:6402:1adc:: with SMTP id ba28mr2174677edb.12.1588678481397;
 Tue, 05 May 2020 04:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200504115923.88828-1-omosnace@redhat.com> <20200504115923.88828-3-omosnace@redhat.com>
In-Reply-To: <20200504115923.88828-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 May 2020 07:34:30 -0400
Message-ID: <CAHC9VhTbTTT4otsEWRPrPewz2j5FEJHODr8N0efG+cX7vph0Hg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selinux: prepare for inlining of hashtab functions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 4, 2020 at 7:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Refactor searching and inserting into hashtabs to pave way for
> converting hashtab_search() and hashtab_insert() to inline functions in
> the next patch. This will avoid indirect calls and allow the compiler to
> better optimize individual callers, leading to a drastic performance
> improvement.
>
> In order to avoid the indirect calls, the key hashing and comparison
> callbacks need to be extracted from the hashtab struct and passed
> directly to hashtab_search()/_insert() by the callers so that it is
> always known which callbacks we want to call at compile time. Note that
> the kernel's rhashtable library (<linux/rhashtable*.h>) also does the
> same.
>
> This of course makes the hashtab functions more easy to misuse by
> passing a wrong calback set, but unfortunately there is no better way to
> implement a hash table that is both generic and efficient in C. This
> patch tries to somewhat mitigate this by only calling the hashtab
> functions in the same file where the corresponding callbacks are
> defined (wrapping them into more specialized functions as needed).
>
> Note that this patch doesn't bring any benefit without also defining
> hashtab_search() and -_insert() inline, which is done in a follow-up
> patch to make it easier to review the hashtab.c changes here.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/hashtab.c  | 44 ++++++++++----------
>  security/selinux/ss/hashtab.h  | 22 +++++-----
>  security/selinux/ss/mls.c      |  2 +-
>  security/selinux/ss/policydb.c | 76 ++++++++++++++++++++++++----------
>  security/selinux/ss/policydb.h |  9 ++++
>  security/selinux/ss/services.c |  4 +-
>  security/selinux/ss/symtab.c   | 16 ++++---
>  7 files changed, 110 insertions(+), 63 deletions(-)

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
>  };

I remain concerned that in the process of chasing performance this
patchset makes the code worse and more fragile.

What if we took a slightly different approach such that instead of
breaking apart hashtab_node we moved the variable portions (htable,
size, nel) into a separate struct which we could reference in
hashtab_node?  For example:

  struct hashtab_var {
    struct hashtab_node **htable;
    u32 size;
    u32 nel;
  }

  struct hashtab {
    struct hashtab_var *table; // adds an extra ptr deref
    u32 (*hash_value)(...);
    int (*keycmp)(...);
  }

I might be mistaken, but I believe this should still allow you to
implement the inlining/pass-by-value tricks for search and insert
while maintaining a binding between the hashtable data and
hash/compare functions.  Yes?  Or does the entire struct need to be
declared as a static const for the compiler optimizations to work?  It
is not clear to me from the commit descriptions or comments in the
code.

As far as testing is concerned, whenever possible it is better to show
performance improvements in the context of some sort of user workload
and not an artificial stress test or micro benchmark.  I understand
that such focused tests can be attractive both in terms of their
results and ease of use, but they can also be very misleading.
Performance improvements for things like policy loads, kernel
compiles, etc. are much more interesting to me than results from
running something like stress-ng.

-- 
paul moore
www.paul-moore.com
