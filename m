Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31643C11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 19:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FA524699
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 19:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6aF9KvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgB0TrG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:47:06 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46570 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbgB0TrG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 14:47:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id a22so387721oid.13
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 11:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wr7GVc8DkQPyMrB/VhB8+9F6RTaZqxjHTTqx9tYR2sI=;
        b=H6aF9KvLo0h+v4J+2JN887Q6l4i2BlWm8dzApzMbp0sM606DlA9tnEbd8waEMuw77g
         O8E2LuC4iGSiD2YoXFm3L9vuJPQRtt9+5aNTr833o/hnLoy7QIgA7lobGjTR1Iu4ubrw
         7oFnjV5ZsKHweHZJjeFnvhbEKkKDzee/2252S44EYhv5230pDmfX89DzC4FKZR2X8YgR
         DVB8c/oZJgzkYC0ouApGMO8cJylLRJp0J1stslw5NWSTH++RuxjnsaKbNZ1Io+MDcZGT
         v40s9Hm9WDYSGtDCs4U9ZNc9cohuAMzFkZ3QSzZgnMg0Ept+FTLevHJWuC1l61aOOsIY
         OckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wr7GVc8DkQPyMrB/VhB8+9F6RTaZqxjHTTqx9tYR2sI=;
        b=fep69ekbnXJl3nDl9lkc7H1fkdrn7lLRwjCJ6IwQzWXtqYN/ekuGO5b1wTfc2C0A8r
         RM3iWidhXV3+3DNSu3G+6/9p7zuCTPbQ62wMY/NzFRf4XDeouG2NYEPbJ8bbQ2xOy8jJ
         3GTz96hJGjhQf7ms/rcBZnhZehVQ2T15F4JBpp+O5SvOib1jEVspkXZFX+kjbc96V9NS
         5vZDuYbMCLTg2nSEMRu1s7umQ+nroXt2NsUYeJ3h6Zh8gC4Us7MPvIS7pLFOQ+M6nnbL
         LPHJtyKBVqcYYsljQZ6XiHJ0TH13EloReYxCqkxQ1/Z+U4Bxr7UTNdzLd3kw0DXTcHig
         87Zw==
X-Gm-Message-State: APjAAAWo2LEp//XrnDQtthszMVFhAAHx/oQTFYGNsx5TfqSei1BlOChW
        lgYta3m1RIu+nuWvGtgEzHGnMuqFelLxtBTC32imxy+k
X-Google-Smtp-Source: APXvYqybQcvmSRpsjudOT053EquKdO2vu8kVR7nx7nbCSKQnfr+AdhaHyl/2iP9yU6vLBxtPiapRHYNQJXmHqgDOw0k=
X-Received: by 2002:aca:f05:: with SMTP id 5mr526270oip.140.1582832825528;
 Thu, 27 Feb 2020 11:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
 <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com> <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
In-Reply-To: <CAFftDdomj5C35JLZCx9ATaUcS7Lg3izWx8M5CAX6DPhNuZs62g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 27 Feb 2020 14:48:15 -0500
Message-ID: <CAEjxPJ4wZw=g1QW9gSPL_2tu9E12oJnX2OYPmTKCZqZQH6StKw@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 1:41 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> It doesn't get us around all the issues, anything marked deprecated in se=
linux.h
> and marked hidden_proto in selinux_internal.h, will still need a pragma.
>
> This would be much simpler if we drop the whole hidden_proto stuff, I gue=
ss
> kloczek is proposing patches? Who is that, I see the Github name as:
> Tomasz K=C5=82oczko
>
> But I can't find any matching author in the git logs to CC them.

I don't actually know him myself but he has opened a number of issues
on the selinux userspace and appears to be involved in Fedora in some
capacity.

> I'm looking at those macros:
> hidden_def
> hidden_proto
>
> They both seem to take a function and create an _internal symbol, and
> set the global symbol equal to the internal one. Essentially, both the
> normal and _internal functions are pointing to the same address.
>
> $ readelf -s ./src/libselinux.so | grep setexeccon_raw
>    176: 0000000000017c26    63 FUNC    GLOBAL DEFAULT   12 setexeccon_raw
>    279: 0000000000017c26    63 FUNC    LOCAL  DEFAULT   12
> setexeccon_raw_internal
>    606: 0000000000017c26    63 FUNC    GLOBAL DEFAULT   12 setexeccon_raw
>
> The hidden one, additionally
> sets the visibility to hidden, which if IIUC, just requires one to
> statically link. We can see above the
> visibility is local.
>
> What I don't understand, is why one would do this? What actual
> performance enhancement do we get?

The hidden_def/hidden_proto stuff originally came from Ulrich Drepper,
glibc maintainer at the time, to eliminate unnecessary runtime
relocations and PLT entries being used for local symbols.  Per the
comments in https://github.com/SELinuxProject/selinux/issues/204,
these might not be needed anymore and are breaking building with LTO.
Willing to get rid of them if it doesn't produce a significant
regression.
