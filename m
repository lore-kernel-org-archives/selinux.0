Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39CFC4320A
	for <selinux@archiver.kernel.org>; Fri, 23 Jul 2021 17:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2E860EB5
	for <selinux@archiver.kernel.org>; Fri, 23 Jul 2021 17:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhGWQwf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232760AbhGWQwa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Jul 2021 12:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627061581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uPLGJXau2+5qQnMOPpffQVoOvlJLUuEgQVlLdBlzRzA=;
        b=SuOzq5g9HJEoexOyTXVM5NwAD6otymf8JupY0SOc0ZYiWmv8ApkzqyAkr+ogAmedbZjT2l
        6f7nABg9GTTcbqYwX5K8UJ9/Uz4Ha/2vhnVcJht/RRPDjtTQYVb1aKMaE08uRm7ZqtOq3R
        NCwjSOLAmdReQ3qYuan+Y4TBUpWM89c=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-N8AHYfniNtmoh_eiSyZh2Q-1; Fri, 23 Jul 2021 13:32:59 -0400
X-MC-Unique: N8AHYfniNtmoh_eiSyZh2Q-1
Received: by mail-yb1-f197.google.com with SMTP id s123-20020a2577810000b02904f84a5c5297so2873293ybc.16
        for <selinux@vger.kernel.org>; Fri, 23 Jul 2021 10:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPLGJXau2+5qQnMOPpffQVoOvlJLUuEgQVlLdBlzRzA=;
        b=qr9or50749Oy7IQhSpXFbbuHw9iB8VWEvqfZPiXgcKjwsUSNTynUTu1z8rezFOTGu7
         o/l6igrUK1+ob0XZciyQpXGONATpBfv/D/HGEYY2xeZI1egl+jFaluoDSgLM70c998UZ
         7q4Q3lXwpelDZSKGcRioCgWs3kL8clr7WDzKVaKyRWzlhHcon0KtBQ/8obRM9HaCbhoA
         WRd4lFjjRr3wbkBMjTQcZa2Q6Rx1xB7DoLBU1KAF9QXYG49WrWELAKWKXl6fKW5SX0+x
         OoT4MrqrRZnkXR3936hz4uWB84fdkOH+VM6Fx6bnLjzjkww8tg0QgIfyu2MyQ9V+2cs3
         Nf+Q==
X-Gm-Message-State: AOAM530BizqcYNli/VkOAo3q+LEy8Yrwh9n9Suq19Yh2fa2vETaOSNCI
        YeIVcIrhn0BaG+m8hKSWfaUsRZs1lC3MMQ4L1W6qv63dhQiAPIv3s0lefJUl2z81mkMGZ6KU0Oa
        SEC8sQoWSlqsWvug4eZMEg0Yv67bWiBO2Ag==
X-Received: by 2002:a05:6902:690:: with SMTP id i16mr5044981ybt.327.1627061579250;
        Fri, 23 Jul 2021 10:32:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHaVSUnpZfdr0unz968g0KoK9kylJ3DgabVwIdgxlB9OLbpTO0l/6bMpCr16eiRFEnzHElMrkK3z+yhJOUHvc=
X-Received: by 2002:a05:6902:690:: with SMTP id i16mr5044967ybt.327.1627061579114;
 Fri, 23 Jul 2021 10:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEN2sdo3wVKXnEUASFTbhR81kOYNgU1CbR0XMUNCTt8keOHC6A@mail.gmail.com>
 <CAP+JOzT0++Kp1zNVDY77i92RcosdvC5hyFRQJ8vwmkCin1Ebig@mail.gmail.com>
In-Reply-To: <CAP+JOzT0++Kp1zNVDY77i92RcosdvC5hyFRQJ8vwmkCin1Ebig@mail.gmail.com>
From:   Garrett Tucker <gtucker@redhat.com>
Date:   Fri, 23 Jul 2021 13:32:48 -0400
Message-ID: <CAEN2sdqJKHvDzPnxS-J8grU8fSf32DDtx=kyh84OsCq_Vm+yaQ@mail.gmail.com>
Subject: Re: libsepol CVE patch issue
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks for the detailed explanation Jim, that definitely helps clear
things up on our end.

All the best,

Garrett

On Fri, Jul 23, 2021 at 1:18 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Jul 23, 2021 at 11:43 AM Garrett Tucker <gtucker@redhat.com> wrote:
> >
> > Hi everyone, I'm a product security engineer at Red Hat and we noticed
> > that libsepol CVE-2021-36087 was assigned, and marked as resolved
> > within the OSS-Fuzz project. The patch info provided for the CVE
> > appears to be wrong, and after looking into the provided commits and
> > commit ranges, these seem to be the wrong commits and commit ranges
> > for this CVE.
> >
> > Would anyone be able to confirm if there is a fix for this CVE, and if
> > so, point us towards the correct patch for this.
> >
>
> It is very hard to figure out what is going on in the policy provided
> by the fuzzer. The best I can figure out is that the problem was
> caused by something in an optional block that had been disabled and
> deleted being referred to outside of the optional block. Removing all
> of the optional blocks that are going to be disabled anyway eliminates
> the problem, so that seems to confirm that idea.
>
> This commit prevents that whole class of bugs from occurring.
> 340f0eb7f3673e8aacaf0a96cbfcd4d12a405521
> libsepol/cil: Check for statements not allowed in optional blocks
>
> The problem is definitely there before this patch. After this patch an
> error is produced because a block is declared in an optional.
>
> I hope that helps,
> Jim
>
>
> > All the best,
> >
> > Garrett
> >
>

