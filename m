Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC2C4332F
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 17:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKNRjK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 12:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjKNRjJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 12:39:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C4100
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 09:39:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54366784377so9053737a12.3
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 09:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699983543; x=1700588343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VEPo41ONBCWtGueKrE1jM7ZvUgpdeJdyiXa3iH48gDE=;
        b=hymAWQB0ltzemCfvqmYF+Yvdm7hxmsCxKg0GVEdSRL1o5hgBoZEHATrE6Nn650OfJl
         w3wT96QYFZJkQKk4zid3VyAoCZJ76hdFh1PT8WQThYnCHk3B/bBFk/faEL6Hpdhocdcz
         4mTPtp9fqRoHDlpedvFRwWDK9IMbyxebgYCkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699983543; x=1700588343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEPo41ONBCWtGueKrE1jM7ZvUgpdeJdyiXa3iH48gDE=;
        b=m4l3QE+14gLxchVOSgSkQ9NvdR/GYLx087p786Pmdtx4dmTCmPHnI9dG7IywhXH9MC
         2at8vqY+Ar+L8+dvXKfFM+e9Uvth6CECGR9QgnuVZXo6J4L6HNhmSU8q0BH1J8f2EeVx
         imCwOSqH1eRkCd9pQM9HaO1xDqjLo2MoUxyeOhVdovlx5ib6BZh63WHyjOmZQkjglIyh
         e9iu3+d1BEnZ76GlyUWk3EhOzb+OTdM1nHznmUh9ynr/MQ0l/62M7QqQY0AKl1sKjze/
         rBqd86qqwJTk8XNns+SXVr4HCI7WbbYOS9s9qP2THK29JYWmswLEhnxDhKEHy2yyps6U
         1t6g==
X-Gm-Message-State: AOJu0Yz0rm0V1+Ahz3eO3fSqwpeP7g11g5pnP74G47Ax1tEAsmuQgF2j
        nnwo8GPsg35gD9Z8aHIMDAtD0Je+JKdpePdyOhhWGA==
X-Google-Smtp-Source: AGHT+IEpxFlsijuoAy8bS1lwgZM29RxkjKS46tUC1wyELxzW8NQ2HH4Z9BUugZgx2g+c5JBrej1/pQ==
X-Received: by 2002:aa7:ca57:0:b0:53f:a017:7526 with SMTP id j23-20020aa7ca57000000b0053fa0177526mr6941204edt.40.1699983542858;
        Tue, 14 Nov 2023 09:39:02 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id d2-20020a50f682000000b00546cf67c348sm5535328edn.59.2023.11.14.09.39.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 09:39:02 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54553e4888bso8851392a12.2
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 09:39:02 -0800 (PST)
X-Received: by 2002:a05:6402:353:b0:53d:d4a0:3154 with SMTP id
 r19-20020a056402035300b0053dd4a03154mr7700611edw.31.1699983541883; Tue, 14
 Nov 2023 09:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20231114061656.557513-2-paul@paul-moore.com>
In-Reply-To: <20231114061656.557513-2-paul@paul-moore.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Nov 2023 09:38:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3=78DOGPME9kJ9Hx9djTYP7sm8XyBCu3PcCKZq6XLYw@mail.gmail.com>
Message-ID: <CAHk-=wg3=78DOGPME9kJ9Hx9djTYP7sm8XyBCu3PcCKZq6XLYw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: assorted hash table improvements
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 13 Nov 2023 at 22:17, Paul Moore <paul@paul-moore.com> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> This is an inline patch version of a patch submitted by Linus in the
> thread below.  Do not merge this patch anywhere without additional
> testing or a proper commit message.
>
> * https://lore.kernel.org/selinux/20231111160954.45911-2-paul@paul-moore.com

A couple of notes on this.

The *point* of the patch basically boils down to this particular change:

> +static inline struct hashtab_node **hashtab_entry(struct hashtab *h,
> +       const void *key, const struct hashtab_key_params key_params)
> +{
> +       return h->htable + hash_32(key_params.hash(key), h->hbits);
> +}
...
> -        ... key_params.hash(key) & (h->size - 1);
> +       ... hashtab_entry(h, key, key_params);

which basically means that now instead of just using the low bits of
whatever hash value, it actually uses all bits of the 32-bit hash.

It doesn't much matter as things stand now, because

 (a) I'm not convinced of how performance-critical this is (there is
*very* performance-critical hashing in selinux, but it's mainly the
AVC lookup which doesn't use the hashtab model at all)

 (b) a lot of the hashing intentionally tries to put the bits in low
bits - exactly *because* this code used to just use the low bits. IOW,
we have things like this:

    static u32 rangetr_hash(const void *k)
    ...
        return key->source_type + (key->target_type << 3) +
                (key->target_class << 5);

which basically tries pretty hard to keep things in the low bits
rather than spread things out too much or too well

 (c) the code hasn't ever done a good job before

For example, with the old "filenametr_hash()" it used
partial_name_hash(), but then never did the final end_name_hash(), so
it was never even folded down to an u32, and the high bits of the hash
on a 64-bit machine were dropped entirely even before it then only
used the low bits thanks to that '& (h->size-1)' masking.

Anyway, for this patch to really matter, the hashing itself should
matter (questionable) and the existing hash functions like that
rangetr_hash() and filenametr_hash() should be better than they are.

Paul already sent out a patch to improve on filenametr_hash(),
although it is the case that full_name_hash() is really meant for
*counted* strings, and since filenametr_hash() has to do the
'strlen()' just to see how lonbg the string is, it's not exactly
efficient there either.

Oh well. We do have a "hash and count length a word at a time"
function, but that one is for pathnames, and stops at '/' characters
in addition to terminating NUL characters.

                Linus
