Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16099C83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 20:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10992076B
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 20:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mECOKVh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2UEv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2UEv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 16:04:51 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EFAC03C1AE
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 13:04:51 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id r66so3008143oie.5
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YjHcrDVDkOcEXULUAAvCnG54uPf77Bfu7t+3Emi7J4=;
        b=mECOKVh/bY28vgHqtY+8LjUfjZqyLrhOggmWoB5qF/BjrIIyXIQDD7spidAFyUt3Xx
         fxgD4NiYcQw93ylYl0enKlV2+QkjI3z9vZOm4iYHROfa7X66qVCKybngGK54HaN7ynNh
         iA9++URT9acrR3ieDFczT6QWrXmmB9s3WFrNShl7PVld9rqnurp5XqxgmWOZVq+4Eek+
         LC6EKSBowjg44LvavEdu1LRwCy1DVsqUh/i8El+akEUnN5U+P1pJ/FLjbJ37NEj9tUCb
         7f2guQI0F09maVgKYy5TVDPMxrEsMhJY4gek8MFu9JSnyc63JdnGxEQnwpnwjeYlIile
         kusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YjHcrDVDkOcEXULUAAvCnG54uPf77Bfu7t+3Emi7J4=;
        b=ETI+//IAzl4wHQa+Qun8u5u9R8fjsrRGEc7qfPn5Izbwv422ZyJWD1LtDv0nkqKvPB
         V3S5H069Nr8U5CgwY+G+uCbkC9X1mDmYbKSrr7ed/XL6plBgOnUYwkBMgt1v0M9bkhKg
         fpMSlKAHWPk8rXJdCuJfaFlNNc2AKuK+F/+vuzdPmy/uPBWYfWejJ0sn20nSXHkZ3Bn7
         tku+htLdaJoVb5FMP+cYUOdw25WkMdGAbuZux2OHyBOw3PRnq/jPgwo8baxCR2IPJYTU
         tcwyEEjLLz3N8IEcOorvRLV+CadphAecTR5pxqL3WUfmiXSkGVvzUJ/op7MSHLlW64bC
         jWNQ==
X-Gm-Message-State: AGi0PuamBgJLEZhCz4dD41mWbRx0xlfGL5p9KQrXLqbcuxjzsp3KEDZL
        aFpDRzT3y/rrbFQSIME/QnUgMDhEb2RnVLILcWOur/YI
X-Google-Smtp-Source: APiQypKOxZJf3hOOtzdXG2gRgOMOtPnNbfdn2rxue9C/MMjrnVhsOGvrZL/qtO1YVra5p2uHk+Rj2Ro1w925B36jQ0Q=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr2996387oib.140.1588190690547;
 Wed, 29 Apr 2020 13:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <53c7aec9-e132-315e-be42-d7bdc9060eed@gmail.com>
 <CAEjxPJ5ZSuxxbKfBKfgadEHk=R0APaYtGgstTMcPMU2fYaSk4w@mail.gmail.com>
 <1ddd7c0a-5903-6c4c-595a-bee00ebe7779@gmail.com> <ab69bba0-0c15-6a43-b0d2-9179e4948239@gmail.com>
In-Reply-To: <ab69bba0-0c15-6a43-b0d2-9179e4948239@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 29 Apr 2020 16:04:38 -0400
Message-ID: <CAEjxPJ56Y1NM_4hsTLvVsxucWmmu9Ny22ao_gpR6Z1JBPxi5Hg@mail.gmail.com>
Subject: Re: Daemon cannot execute python
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 3:25 PM Ian Pilcher <arequipeno@gmail.com> wrote:
>
> On 4/29/20 1:02 PM, Ian Pilcher wrote:
> > That would undoubtedly be painful!  For now, I've modified my systemd
> > service file to make a copy of the Python executable with the required
> > context, i.e.:
> >
> >    [Service]
> >    Type=simple
> >    PrivateTmp=true
> >    ExecStartPre=/usr/bin/cp /usr/bin/python2 /tmp/python.denatc
> >    ExecStartPre=/usr/bin/chcon -t denatc_exec_t /tmp/python.denatc
> >    ExecStart=/tmp/python.denatc /usr/local/bin/denatc -d
> >    ExecStartPost=/usr/bin/rm /tmp/python.denatc
>
> Slight update for posterity.  It looks like it's possible to use a
> symbolic link, so ...
>
>   [Service]
>   Type=simple
>   PrivateTmp=true
>   ExecStartPre=/usr/bin/ln -s /usr/bin/python2 /tmp/python.denatc
>   ExecStartPre=/usr/bin/chcon --reference=/usr/local/bin/denatc
> --no-dereference /tmp/python.denatc
>   ExecStart=/tmp/python.denatc /usr/local/bin/denatc -d

I don't see how that could work.  Symbolic link should be resolved and its
context only ever used to determine whether you could follow/read it.  Not
for the execute check.
