Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B5C433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 16:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B563120721
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 16:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC5vUN/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgE0Qoc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbgE0Qob (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 12:44:31 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22BC05BD1E
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 09:44:31 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d26so57211otc.7
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9yb2MMMdF48g+cEn3LETSBOfmGZE5HfINHuFVArPqU=;
        b=NC5vUN/bKikW1J2MwQwiJug8gaNaLaMzRhkO6hDaSu6ftgwVGY1amZoWw3jQojKXfD
         w9ZdYAPH921HZ7gC0G96xfxFHfRmB9ZWe8HJzXnraI7IkuFac7necDTSkLCnFWi/gU7W
         zK5XEvOmojZVtEDwWTC+Esr59DyvMurDnUVcAq0tPc01QWHv4uU3VkE5IxDZc/B+LiHc
         vqHvu2LLWlRnfcOhPs+Fcoef4I/goSEa9CLj49RP8OlEHNwUZfmP6hRJwubqKGY05Oq/
         8VVJyOZbVg9OOHDAXiOW3MtlesiLATYm548qaybt972RVM555TV3i+B+HCRYb3JaBlrs
         QeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9yb2MMMdF48g+cEn3LETSBOfmGZE5HfINHuFVArPqU=;
        b=h3sIYq4ADC2CwFfU6rszBZz35Dhtoq7w5nzHxzDBI275c5lAyCvQo3Ae9xtCuisR/v
         lLrgQzQVcYlKHC1vxTZG1BorRbKnp5dViI7hjLaHqDzwTlv5ru+pEcZsmXUHju5LUaRw
         /UUCzT9ydA0MTlNEeBB0JJD8FZgEt7kyHnqYciwfx0076/DAgXZPihxMwU+WWjMVhuHH
         oB76aCajpiKZGWvtmURsuQrvvu/eTloXFKDmL2bqkDNtYukLZDbNoFz04IUbrLqwaGzX
         b4yU49RV31VmwnJtIZxEOgEx96ZUeSD8GsMaWesH8M89xK1m/OZzNFiwQ1oFtpaMeyEr
         t5Ew==
X-Gm-Message-State: AOAM5320Tl/CL4R8/kKVq0ifKpphuJkGXbfb+zobSeueC7yS8vib49dI
        nQv5VOjdQi11/ceK/3xcR2AnXnFir2Orf6YUSoY=
X-Google-Smtp-Source: ABdhPJwbBwu3iCF4pvWvidhM4B761ITY2gYgg63eUtrn61HhmVQYk2+4XLJGyeDsGKItD+ZP+p1hRkotzL/KPg2mB7o=
X-Received: by 2002:a05:6830:1c3:: with SMTP id r3mr4949883ota.89.1590597870604;
 Wed, 27 May 2020 09:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145513.194440-1-jwcart2@gmail.com> <20200522145513.194440-3-jwcart2@gmail.com>
In-Reply-To: <20200522145513.194440-3-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 27 May 2020 12:44:19 -0400
Message-ID: <CAEjxPJ6UxEaNkZt4sdCfeVd2amr1fxE97d4jWRD=nkDif=oz+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libsepol: Improve writing CIL category rules
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 10:58 AM James Carter <jwcart2@gmail.com> wrote:
>
> Improves writing of CIL category rules when converting MLS kernel
> policy to CIL. No changes to functionality, but eliminate useless
> checks for category aliases when using the p_cat_val_to_name array,
> find the actual number of aliases before allocating memory, and
> skip the category alias rules if there are no aliases.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This series looks fine to me but do you have a test case that exercises it?
