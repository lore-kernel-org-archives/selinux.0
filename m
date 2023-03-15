Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0DAC6FD1D
	for <selinux@archiver.kernel.org>; Wed, 15 Mar 2023 17:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjCORhw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCORhv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Mar 2023 13:37:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13AC28D3C
        for <selinux@vger.kernel.org>; Wed, 15 Mar 2023 10:37:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg48so19348751edb.13
        for <selinux@vger.kernel.org>; Wed, 15 Mar 2023 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678901868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADN5nWp2h2FqD3qi9ZyJVeLEf9YZBCYBENdJRJDpsvE=;
        b=cQqagqJuuvtgz6mOsPTLJFXt2rq1EUWtFkrUHwQLvJ9NvMULh+N9tAfZFAr+lx34v8
         7o34q+n5oOmmDfb/GU/FRDS120pVRvfapqorHnxDylroMRkeMm5uwXkBEXfVN0AC9If+
         YYVlTDsX+h5VsTOpSgXpQPD57GNr9k1k0aV3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678901868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADN5nWp2h2FqD3qi9ZyJVeLEf9YZBCYBENdJRJDpsvE=;
        b=yEiXAJn+teG/2zNhVOEuweNbz2Q2qgn/X1bzDGhu/pa9FRx+VDOC890aiUaq8eyTxS
         1e7NTCGEYsou3ExNPxCCS52ZZH+bPjRp8xuTsVVECAzH8KPfsvbP17LvorkayGJzqYib
         AvdzZV26sVZvKYtXyS1HrxLddiUWceVLOPWQC5fYqU9abYUH+4IwrHMnCXSvbg9HGwY+
         bHXZLF8BxKToj2p56mjtFha0qZdmfiT4Gc6NJmUC7/7wf20DLf51V0eEIC/eRq0cieB8
         UQrq+a+W0Quvs64oa/JdB1avfyHWu/8Y6iKXROlmtZy0FjpOLnzym5B7xaoQ5fvAngRO
         LSKA==
X-Gm-Message-State: AO0yUKXvmyjqdvPRK2d8oSw6e6h05SGRFqv5qsLCmJCBZbzw+9Iz3sqG
        AeavYm0Wmff1dWUtnQsq+vQkWvh6Vxgd2EgNL+YDdA==
X-Google-Smtp-Source: AK7set+aLN2zLOkYBa0YJSVWT0+eWynueB1UJ2Npl97lrDBRHq/RnpgUlj/UmRhSX7RuBQcX/smwoQ==
X-Received: by 2002:a17:906:27d3:b0:92b:ea1a:dfe3 with SMTP id k19-20020a17090627d300b0092bea1adfe3mr7577885ejc.29.1678901868215;
        Wed, 15 Mar 2023 10:37:48 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090638c600b00925d50190a3sm2777204ejd.80.2023.03.15.10.37.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 10:37:47 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id w9so7783840edc.3
        for <selinux@vger.kernel.org>; Wed, 15 Mar 2023 10:37:47 -0700 (PDT)
X-Received: by 2002:a17:907:2069:b0:8af:4963:fb08 with SMTP id
 qp9-20020a170907206900b008af4963fb08mr3777182ejb.15.1678901867065; Wed, 15
 Mar 2023 10:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230314125734.19896-1-stephen.smalley.work@gmail.com>
 <CAHC9VhQ77njhXPvEZ6-3WKVQtLtNXJw69NOGSoNktf7STgKjTQ@mail.gmail.com> <CAEjxPJ7ZVnGzWFfj051POA+gO2cVY_6vPgyNzPBFo=wr909xYQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7ZVnGzWFfj051POA+gO2cVY_6vPgyNzPBFo=wr909xYQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Mar 2023 10:37:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuMkkCFrZQ_U8W8Z=3iDKV=jv9PUJg6D0fqMtQ=gTqRQ@mail.gmail.com>
Message-ID: <CAHk-=whuMkkCFrZQ_U8W8Z=3iDKV=jv9PUJg6D0fqMtQ=gTqRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: cache access vector decisions in the
 inode security blob
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 15, 2023 at 5:33=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> We are already taking the isec->lock (or otherwise have exclusive
> access to a newly initialized isec) in all the places where we are
> updating the isec->avd and isec->avdsid. The issue is not the updates
> but rather the reads in inode_has_perm() and
> selinux_inode_permission().

Right.

And that is always going to be unordered, in the sense that you will
get "one or the other" value whether you have strict locking or not.

So even with a spinlock around the actual low-level selinux data reads
and writes, there is only "data consistency", not any actual
*ordering*. The pathname lookup itself is simply not ordered (and
cannot in any sane model be ordered) wrt somebody else coming in and
changing any selinux rules.

So I don't think this is even worth worrying about. There is no
ordering, because no ordering can possibly exist.

The only thing that can matter is consistency: any *individual*
security decision should either get the old rules or the new rules
(never a mix of the two), but either of those is fine - and as you
traverse a whole pathname and do multiple different security decisions
for each path component (and for the final open), you *will* get a
mixture of old and new if the rules are updated concurrently.

I don't think this is a problem, and I don't even think it's fixable
(sure, in theory, we could do some big sequence number lock or
similar, but no way do we actually want to do that for path lookup in
reality).

                 Linus
