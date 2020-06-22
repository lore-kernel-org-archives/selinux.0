Return-Path: <SRS0=wZqU=AD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CCDC433DF
	for <selinux@archiver.kernel.org>; Mon, 22 Jun 2020 19:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDB520767
	for <selinux@archiver.kernel.org>; Mon, 22 Jun 2020 19:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw+bcctt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgFVTBY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgFVTBX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Jun 2020 15:01:23 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D10EC061573
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2020 12:01:21 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u23so13998363otq.10
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2020 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pnl4aeEq6ewYQTfyuT365N1YRFbSCe6OdeY40aVWzaQ=;
        b=Fw+bccttAT0f4HvpFKWLAWPaarsiTmLw+g8DBaO6RBnZ4gC1gpQKuCNl72WFzXn3uU
         L87fQoKA4xBlguTicSk3qFo/ZLB53NC/M8r9qrFxYZinVS6c9OXc67L2aOfSNIx36rnm
         mCdCIhHYGY/aTJKrYM1Zx6aI+hnlj5FWwOh7AG5ohedA+bl6aWQt7htxPrBZFArjEapy
         u3XeLMi8WhtJlYw6QXx2l0CzTVN2vHgrypA5nJHR4lk5PsZgW0Tt5qgrywUPlskMC+8o
         Q89otvTFyd7eyKTi2diZGKg4mNDdQ1tlFURvbCVOUnSnrN95qJoFWt0jxk/WS7p9Uqka
         2ELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pnl4aeEq6ewYQTfyuT365N1YRFbSCe6OdeY40aVWzaQ=;
        b=LRvmsjNXSi87oyYNvEfD04kYR7acNP/0OUC0K/8l9z3tE71QvV09yIquG7Wpi4zvLa
         cVZ6MGqf9FNP7qTEf4Bv2RKVSugVTaukp+LMqTbvapMIT3JwS5gnpChSqEbvc5rcdA6I
         sl3B7oNRdu8RbH3PSk9dl6xXf3s5XS1utBQqwcrrN/sKsR+joZugVIY+eX/bDRIROMvR
         RVqhsX6qiYAWeIMMN09bu4RvCJTtEL1fdIprpPShpgVqbSmgOwW8YT7AK7wQEyragr5O
         MUsdD2NcCU5QIN+qW4iD6POfPNE0j06hdvwFVAEkWVppFJplNy3uPyYNUK3qvyWb//3E
         4NcA==
X-Gm-Message-State: AOAM533gUq5dtToI/WAnhv8xMhJ4+1HUQF4117u30I87Rh/21UNTL/nO
        qC58178LVu+jSVRKswYIyPN3vmla/3v3SclTgKo=
X-Google-Smtp-Source: ABdhPJznMHbzHnw1bjCr0Ywovpuv7RXCa2F8yFbGRAhW+HKB19Vj335H7R98mlJ/lYh0HCV5Q4utb4rNziiBjUd+LGg=
X-Received: by 2002:a05:6830:1315:: with SMTP id p21mr16042368otq.295.1592852480980;
 Mon, 22 Jun 2020 12:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <0412674c-6099-bcce-c568-4ce4dd3a165f@gmail.com>
In-Reply-To: <0412674c-6099-bcce-c568-4ce4dd3a165f@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 22 Jun 2020 15:01:10 -0400
Message-ID: <CAP+JOzTv04QtP6UXmNuJorUCqg58SPLkAYW30vXSFLZrx9LmyA@mail.gmail.com>
Subject: Re: CIL classmap with set named all resulting in segfault
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 20, 2020 at 4:37 PM bauen1 <j2468h@googlemail.com> wrote:
>
> Hello,
>
> The below code can crash secilc reliably by using `all` as a classmap
> set identifier.
> This was tested against secilc / libsepol 3.0 from debian and a quick
> build from git.
> For some reason I haven't been able to build secilc and libsepol with
> debug symbols to track down the cause of the issue myself.
>
> - bauen1
>
>
> (sensitivity s0)
> (sensitivityorder (s0))
>
> (level low (s0))
> (level high (s0))
> (levelrange lowhigh (low high))
>
> (class file (getattr read))
> (classorder (file))
>
> (user test_u)
> (userrange test_u lowhigh)
> (userlevel test_u high)
>
> (role test_r)
> (userrole test_u test_r)
>
> (type kernel_t)
> (roletype test_r kernel_t)
>
> (sid kernel)
> (sidorder (kernel))
>
> (context kernel_context (test_u test_r kernel_t lowhigh))
> (sidcontext kernel kernel_context)
>
> (allow kernel_t kernel_t (file (read)))
>
> ; Test case that works
> (classmap testmap1 (test))
> (classmapping testmap1 test (file (read)))
> (allow kernel_t kernel_t (testmap1 (test)))
>
> ; Test that breaks secilc / libsepol
> (classmap testmap2 (all))
> (classmapping testmap2 all (file (read)))
> (allow kernel_t kernel_t (testmap2 (all)))
>

CIL needs to not allow set expression operators to be defined as a map
class permission.

Using
(class C1 (P1a P1b P1c))
and adding C1 to the classorder
This also generates a segfault:
(classmap CM1 (and pm1 pm2))
(classmapping CM1 and (C1 (P1a)))
(classmapping CM1 pm1 (C1 (P1b)))
(classmapping CM1 pm2 (C1 (P1c)))
(allow t1 self (CM1 (and pm1 pm2)))

Thanks for the report,
Jim
