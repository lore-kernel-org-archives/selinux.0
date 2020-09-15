Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163D4C433E2
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 20:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB33C206C9
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 20:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWNQvdRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgIOU66 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 16:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgIOUpg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 16:45:36 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEAEC06178A
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 13:45:23 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id y5so4593824otg.5
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hNpDFFsfV4rs/3NveU5TfxJXV5pbq8s8vKFlrLDXdo=;
        b=VWNQvdROYWJGe1huk9eERDO80oLRItGkhfpniDqJupeguyHosuYYATZEE2RQg+BrLj
         LYlStowzlhWnThRnAIwEUIN/xA5g5pq61vw04h/hq0fSMJxhPT8WH6MgKN4XjBMx79oP
         5nMEKQVvbkG45MD5qPVAkICVcW6eDuKUeXjSJP0Zs7L1I6oXYRKK7GR6ffVsdMPINr0e
         GoBdxLfBSeVqxvNOcWZIxIIdc4JBT0p8LvJ/EW5j3YuqOxML7fGBhkT3AYa1qP7GvViM
         YYGfVpVv06Ak3i4pV8qdjoMb6pjEar2iW+0zdaPrTgBHlM7bL8rzeqjt0dz3fCyMiEF1
         RkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hNpDFFsfV4rs/3NveU5TfxJXV5pbq8s8vKFlrLDXdo=;
        b=BRM/6livh5g82f6bk9GPJ1HmK2k4OjdShzK9nc1G1wOzD73U6tQJQuf7iPchGBps/z
         h79Wv4omnomVCWlHshZJGLJTt52/eGRFSxL9AJ1ZJeG4nLc2Prc0+jJNEz3EW7deEPw3
         qxEDWjepxVZnV5hdnDomgMfsFsFMg7C25s4Vzw2OxWpMom1iF/t0vIkmGxO0vTAGKA6n
         VMQUVxzu7swmaYWg2hESX3hMo6DWiZHl2e7dSOzWzTJNJJmJ/XPd9ssPXTk1CtvWMLs3
         UXUGNcrBJgVwJJLFgfoZXy5gCrS7pIic5lRUu70YTrl8LpVEjkuqx5Zf5rhGq4c78UN1
         Ai/w==
X-Gm-Message-State: AOAM531XxyVnEXgMVGD92OFB2cmrESRLVFx7nkgwXp5OqLaZF2EfLfo7
        ckRi3hNN7QE1qDHKD33Hf1qoeyehS1VG2HmsBDzLLZo3
X-Google-Smtp-Source: ABdhPJz2RPJWGhO5MPgR6LbLTCHi/CpCz7AtZUdUoNVHrKx0uBvwCaTdNjXb6B31CyuWMxBW0oMt0Ygr1IXRjNbxsvk=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr14318935otb.162.1600202722545;
 Tue, 15 Sep 2020 13:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200915184806.396309-1-jwcart2@gmail.com>
In-Reply-To: <20200915184806.396309-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 15 Sep 2020 16:45:11 -0400
Message-ID: <CAEjxPJ667-sqywnL+nib6ndhbpSD7FWDq-ghnbttmVZx+-hi=w@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix neverallow checking involving classmaps
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 15, 2020 at 2:49 PM James Carter <jwcart2@gmail.com> wrote:
>
> When classmaps used in a neverallow were being expanded during CIL
> neverallow checking, an empty classmapping in the list of
> classmappings for a classmap would cause the classmap expansion to
> stop and the rest of the classmapping of the classmap to be ignored.
> This would mean that not all of the classes and permissions associated
> with the classmap would be used to check for a neverallow violation.
>
> Do not end the expansion of a classmap when one classmapping is empty.
>
> Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
