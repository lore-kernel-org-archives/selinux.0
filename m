Return-Path: <SRS0=GP6F=AH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC60DC433E0
	for <selinux@archiver.kernel.org>; Fri, 26 Jun 2020 12:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C462C207E8
	for <selinux@archiver.kernel.org>; Fri, 26 Jun 2020 12:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A834nagi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgFZMtk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZMtj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jun 2020 08:49:39 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DE8C08C5DB
        for <selinux@vger.kernel.org>; Fri, 26 Jun 2020 05:49:40 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id w17so614054otl.4
        for <selinux@vger.kernel.org>; Fri, 26 Jun 2020 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCxRC4QmeI91UNEjdK6LxLgnAW2O/qFXnsFYxcvTKQY=;
        b=A834nagiEA6wd0VZc6GnwvgwziFQNGxVA4zvyjUEO0uVFqb9MjsSUFofNV1LNVYcvY
         JIvYHBU+DCJ+ifpbbFgWWOnj5Urj7tOYjzyp8M0zpOwzc4ugKpzupvkqoUKkvc7KEQwu
         heIM94uRULK/uNG+iWw51Kbso1doCWMxVelrJpd3yOba8ZXRPp/G8hJK40R7j8krOn+Q
         Z+B2JVSC+l017z3YSPciLYzK1GH96ZHMST+SysyST63kmZnhcH1H/ACyuQTnebwuZb64
         d5Haq3Jkz2XgLcRDSOuQ732KiaGM/C27FlB4301U+YbtqR5DQwl29zl88nnW+TWg486b
         Inuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCxRC4QmeI91UNEjdK6LxLgnAW2O/qFXnsFYxcvTKQY=;
        b=I/8rJ9wmc5FdfhOJ1K6IhLXLHpkctTNP9AsxhKXGBnSr9dWs5gb5Ao3NW/iQkIiNk1
         zFeUoR5h8gZrXLGDwLDMmpRYRtMuxusPaDYS5yP1R8U/ngDEUU1Ncbi0X5IZ7eZB/dbu
         ztIFhes7p1W1VFYCGyKmH92FS6QQPKp3KDFX1w/4jiYgrWXaPzWfv++qNYzp9h1HU6Fc
         J0V8zlDcg2Udvh/RRyBDxBiitC9cN6rWM/jCPcfV14TgH1P/G7B0fyn9l1U+bWZhxFaJ
         vDeS+E3LeN3aimZ154MGj09UCyxHC0XoLACRgdwLlorVkdAyDszmPbVNn6zrf7NGUb7s
         9hpg==
X-Gm-Message-State: AOAM5308TPlKx0N0gJoQ/iNzdrzO67vZMrIr0Zn+Ae6qnY3visu2/N0d
        EC08WYiDAsKXzyOS2iTUr/UlT1+i4l20ItybLMY=
X-Google-Smtp-Source: ABdhPJzj7kH7BQOPYzneGk02duBCxYng2lZG63WAqkwIxMf/Se77xCnDHzwdvD4Tv6ZxEjVa0EejVu5j9H9/Saq/8EM=
X-Received: by 2002:a4a:49cd:: with SMTP id z196mr224225ooa.58.1593175779391;
 Fri, 26 Jun 2020 05:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200626114359.80134-1-omosnace@redhat.com>
In-Reply-To: <20200626114359.80134-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 26 Jun 2020 08:49:28 -0400
Message-ID: <CAEjxPJ5+FhHLp01JWaALV6TCwkFP4PO=Y9KrjhKJCS-potV1TQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: fix `make conf` invocation
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 26, 2020 at 7:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In refpolicy when a module is added/removed, the policy build config
> may need to be rebuilt. Currently we run `make conf` just once and then
> reuse it via cache. Instead, we need to run it unconditionally, since
> the other targets won't trigger that implictly.
>
> In Fedora policy the default module config is included and maintained in
> git, so we don't need to (and must not) call make conf at all.
>
> Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Feel free to apply whenever; I will not be around next week to do so.
