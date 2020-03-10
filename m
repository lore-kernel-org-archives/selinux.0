Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC8FC18E5B
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 20:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878F121655
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 20:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vF3Gt6nN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgCJUJj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:09:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32979 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgCJUJg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Mar 2020 16:09:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id r7so2097547oij.0
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2020 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+i0JFOtvcgGOgLGuL6vtHup6HgmtWApkGJipqc3TJk=;
        b=vF3Gt6nN8xuirrq5eDlJ+AxnHQCobONT9TYYQMYjs6oSfX/JPoFdcjCYttsbf85dbM
         /FATfYl4kPIjzxR0JGK4cKvmaXFWHs5hQIiLlzQckuv9kUaW4LbTRxREzrPmIb9UWjKw
         nME34xWV+XN48yzSC19sKiDFoh7gwuCyO/UZplK9JAYVKPhzmSZD0Fsadjs5NqsAY8kK
         DgPnqN4xbQMrRND3G+7iMU7Kux+JdqYhU/D6IClIGPdJNPr9BAALExOEQM83pCRXwLGv
         XfPlURHpV74VaDw+qNPZ7rhNvFkIZPYk/mrg6RjOQ0oU7FGJzHd8NxhMPxlb/b38m4V5
         n9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+i0JFOtvcgGOgLGuL6vtHup6HgmtWApkGJipqc3TJk=;
        b=bQTUgJeGAiPDQdlaBMZDAgSDAkTDGk0SYTNU4eWn+qFZmUwfVnyFkx0Qv0UdDBfafv
         bVwRSwcc1WJYkEwPFy1Yn5+ikEOV46exNMKxH7gBPq4EoK7j/L9QtjMG0CScMejMqntn
         OO7BHPB8NkLAomGvZQTfkAKnZM9hH4tM0XAIM++ihuqNfD0cEJWQBA36skOheXJE0W25
         sdnpuaR0IUat6QXD74In77PrOnPTbegjwdwJb6TUNu9szUjMM1Kb9UoXkHQctcqAxadK
         QAD5/CFmf9A5teGcJMJEdCFz2ywMwPBtifwyNI6xvIr8ft6/ucNnJ9Z4YFftN48cvYD0
         LnYw==
X-Gm-Message-State: ANhLgQ3A2PnvGzLtF6i2jPYrRacnSeh9m6GwHowj3QcN0mPU3ZA3TlzO
        Hybp6y97hnxiGzzuqar424zUiWgAQdmrq8SBG+w=
X-Google-Smtp-Source: ADFU+vuBS9YFHuVT/EgpwBpLTZIsjSDhD8hKxbmQWvUGcsACpwq7hMAO6Hviw/rmjx1t+Y6QXzNRfLsxgGiOvVp9E3I=
X-Received: by 2002:aca:3544:: with SMTP id c65mr2372993oia.160.1583870975412;
 Tue, 10 Mar 2020 13:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com> <20200309152539.8581-2-william.c.roberts@intel.com>
In-Reply-To: <20200309152539.8581-2-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 10 Mar 2020 16:10:17 -0400
Message-ID: <CAEjxPJ6fUuZbe_Pz7xzfzEGc_ABPjsarTX4GmevEVpf4CS_D0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/dso: drop hidden_proto and hidden_def
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 9, 2020 at 11:25 AM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> libsepol already has a linker script controlling it's exports, so this
> patch has a net 0 affect, with the exception that internal callers of
> external routines, which there could be 0 of, could potentially call a
> non-libsepol routine depending on library load order.
>
> Additionally, verify that nothing changed in external symbols as well:
>
> This was checked by generating an old export map (from master):
> nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
>
> Then creating a new one for this library after this patch is applied:
> nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map
>
> And diffing them:
> diff old.map new.map
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

I get the following differences when I do the same:

$ diff oldmap newmap
62a63
> sepol_context_to_sid
93a95
> sepol_ibendport_sid
117a120
> sepol_ibpkey_sid
163a167
> sepol_msg_default_handler
194a199
> sepol_node_sid
240a246
> sepol_port_sid

Looks like these were marked hidden previously but get pulled into the
map through wildcards if that isn't retained.
Maybe we should drop wildcards from the version script.
