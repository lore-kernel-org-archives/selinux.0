Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73470C433DB
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 17:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427FF60240
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 17:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhC2RNY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Mar 2021 13:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC2RNR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Mar 2021 13:13:17 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC99C061574
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 10:13:17 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id a8so13710047oic.11
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erFFVMyehFOZdotbXrqFRz+2khendshAJ7Jp57bnPck=;
        b=t7UmRM1oQA8056zZuy3wqGfWKxy+ovDueG+ucZlUNP3nnwdtS4FrNjbnC4X0AhLkMZ
         28QaIJf2R4/5dQ3nx50d5TWH4DBFpcqH5khbvqbe7bBhkM6wkaKNGUO7EakheEQiczzZ
         KQfG134Cvx1/qPX0b0MuHvAbDR/t7cxHFPnm+HrwdmxMIi45j7npUwf206MFl01Z/96o
         KheWns4FYoH4vI1P98FolEeC6HiP3L12WRPtXXbZ2JPgsAwZZMiZrlFQOHuTLPAKKzWQ
         iCOX2ogQTZajycLbfM1sOEanakAcPtILKtn0Xn9OFy7IVw2wownZ0y1+ecETjLH3DWFR
         SzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erFFVMyehFOZdotbXrqFRz+2khendshAJ7Jp57bnPck=;
        b=MwgFyXYL2nZvPUy1iYK7CV88EVbCtdR4qwcka7yDXEJaXYOr+7IZMAT+3d4uYAVxT7
         Lc6N05n645WZMA4x5PCDRVwdyElPr60M1yRLF4efL/RBslcroimDYhMqRjt1V5ebqs0o
         vpm7dYbWnCcCBEobjhr8DqESlpoGKno5LjgS0/JMxkh+LukFwsrE4fWFqqR9ArPdfvfH
         jfOmF7eFzgAPHVhYMN666WJjwMp7UOv+OKuywjYKm25UXS1m6zZUnf+OQcXEvCUq/h/D
         uVxmINvOqNmd4//BhvI7KkhJRjBKw1+ABJEwjQULS3pafCDo687jcBt3F0aLgx/XUzpE
         XCGg==
X-Gm-Message-State: AOAM533VRXvuyWDD3BS/pkf8qVBQZudkatR4plbpVJWq803VPJCtFHXS
        nTzeQZUcxlnQxhV8WEDe5vtJDpXjZuIcs9gmYAU=
X-Google-Smtp-Source: ABdhPJwKMUegqLIUShNO0cePWzK/tT46P8IRszX/D+lPGqs8ieo+aNMTIBIfkrPTGQ1hsEB126XrO9Uel6HVm+26bMo=
X-Received: by 2002:a05:6808:1482:: with SMTP id e2mr114312oiw.138.1617037995222;
 Mon, 29 Mar 2021 10:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <ypjl8s65aprj.fsf@defensec.nl>
In-Reply-To: <ypjl8s65aprj.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 29 Mar 2021 13:13:04 -0400
Message-ID: <CAP+JOzR=ryK1sp+YNBKqBO3QaQTmRcyXt+Z4cn0-tmOEJetXcQ@mail.gmail.com>
Subject: Re: typechange silently dropped in some cases
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 29, 2021 at 12:29 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
> typechange rules expect three types: sourcetype loginterminaltype
> targettype
>
> 1. you can use typeattributes for loginterminaltype fine
> 2. if you try to use typeattributes for targettype then cil wil refuse
> to build it with a helpful message along the lines of: targettype cannot
> be typeattribute
> 3. if you try to use typeattributes for sourcetype then cil wil not
> refuse to build it but it will result in the rule not being added
>
> scenario 3 is obviously less than optimal. although it would have been
> nice if you could use typeattributes for not just loginterminaltype, it
> should probably atleast fail to build with a helpful message such as in
> scenario 2 when you try to use a type attribute for source type.

I am not seeing that behavior.

I took a minimal CIL policy and added the following lines:
  (type t1a)
  (type t1b)
  (type t2a)
  (type t2b)
  (type t3)
  (typeattribute a1)
  (typeattributeset a1 (t1a t1b))
  (typeattribute a2)
  (typeattributeset a2 (t2a t2b))
  (typealias ta3)
  (typealiasactual ta3 t3)
  (typechange a1 a2 CLASS ta3)

After running:
  secilc -o test.bin typeclass.cil
  checkpolicy -C -b -o test.bin.cil test.bin

I get the following typechange rules:
  (typechange t1a t2a CLASS t3)
  (typechange t1a t2b CLASS t3)
  (typechange t1b t2a CLASS t3)
  (typechange t1b t2b CLASS t3)


Maybe there is something else going on?

Thanks,
Jim

>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
