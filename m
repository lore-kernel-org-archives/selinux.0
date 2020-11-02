Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5A6C2D0A3
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 19:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68622225E
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 19:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crm9Q9Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKBTUf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTUf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 14:20:35 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CC7C0617A6
        for <selinux@vger.kernel.org>; Mon,  2 Nov 2020 11:20:35 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so6219902otc.7
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 11:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lw61WPuzxhxYkiGny4OU/U5BHCU/jUMJIyjgM+lIX1w=;
        b=crm9Q9Fb1Ewjx0ynWFhoBdY1rqvDUVPTmSaDeACNYoyGpFdz+2aGcMdLWYC+BerN6Q
         lKzK750JC4LOF8xFuvJrv+eHVlNeVHbcOousE+n1fpesAb6MEUUZW2yvriWKTd35rpgt
         QVX4pWEGtqlL+HTpXbuOYCL8/lNKbIx8lRYF35TGRCpT02XU2xTyYc/HwXPsgd805nwC
         qta9NPQeT9bi2STtSIoMqMX5w9SRSH4+dQVP47btEkR/Rn3esXSeT0t3o0B6NhdM/zPW
         7BSidx9etwhITWF+GcUmhdHdfQkwoZuqetsHqBc0sVF+xOm+PcOTgnuwS6gFjJWL0Rum
         JgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lw61WPuzxhxYkiGny4OU/U5BHCU/jUMJIyjgM+lIX1w=;
        b=GDErn+rfLiPI+tJNNe33cGUFZXnQP6y7g87JELt6QCSxUAo9i0ZW1IXbq4AGgQD1GY
         QBzVRBbSngiciKUVMu1/ACjHn6FyGzoqNZ67vvcZuhDWRdfAmeYk/WRt220k2W/OU+GU
         Qv0q79nyec5jrlPYHXFBS7dC42hZmCjL179Cbaur40Y7R5lmmZnSmcGrWyV8Ryi1KlTK
         0aSJk40tUt30zl1o0/Y0c2x8HWI9VKBkEGJwNHz0+D7oKrPOSKbmK83mlKQ4nudK4+/9
         +U7zMNJHQ3E3C+EsDoFZfab6DigK1Iwu4ig4VY6XXgD3689mobQnHfldWCOk2GgYOI+U
         1JPA==
X-Gm-Message-State: AOAM530HulEUjLuz2oEHp9yiUZPIdOOQEOf1s64B+R9/kJnrDw/PyJs/
        6GJHbuo7DeJ0kLT6pJH16GhCzz3HXPIL9MGSKp+SrgKegbo=
X-Google-Smtp-Source: ABdhPJwI3lmWIW4PBIYuVHTkdcpdenx2hGhLiYCfvFlTKnPgZzbPptMQBKIvze2bQk5CNJgrLALbvRdC7MlE4kWZ6do=
X-Received: by 2002:a05:6830:1347:: with SMTP id r7mr13929030otq.203.1604344834969;
 Mon, 02 Nov 2020 11:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20201013145456.77253-1-richard_c_haines@btinternet.com> <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com>
In-Reply-To: <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Nov 2020 14:20:24 -0500
Message-ID: <CAEjxPJ6U=sAHRaeND==ioJp=SOaWQ9ok4Va+ne=Eiii5Fo1-QA@mail.gmail.com>
Subject: Re: [PATCH 0/1] selinux-testsuite: Add btrfs support for filesystem tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 30, 2020 at 5:56 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Oct 13, 2020 at 4:55 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > These fs_filesystem failures are caused by a bug when using the fsmount(2)
> > type calls that was reported in [1].
>
> I'll try to dig into this a little bit. It seems that FS maintainers
> are not interested :(

For further context and the corresponding fix for nfs, see
https://github.com/SELinuxProject/selinux-kernel/issues/49.
