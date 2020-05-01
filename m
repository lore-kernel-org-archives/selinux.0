Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF2C35280
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 20:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950382137B
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 20:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xHD80tDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgEAUUq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 16:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgEAUUp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 16:20:45 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF01C061A0C
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 13:20:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l3so8122283edq.13
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0OrSnJ5LqQVHAOIAlUBc6H9DOFJkFsF8DhxOn76V2E=;
        b=xHD80tDsZ0WjCP4rWupgByojkk5qcuRZ9jEM0gMYC0ZRq7H6xH54o9GwgaIk3NdSwv
         94jN+OSbFjqiE7y2cdtt3OFBKQ1wS7/9J+NKGaTJp+Td72u7/ezhAQn/TQDH2miGQAGW
         /PlL79kcwLORKyfKoOMbbUCYgW3d+jQZhaoYO1lemiOXEKSezzkBMiZHd39/RVxW063b
         Ux73z+Z28p2x2d1b5v9AvbVInG/oxNZ1gQ4dTjXV/Vt3Ib9FMWWs8uuXjgPnBDEG+NSc
         nOb83BV0Nupr1J3xxvzJfM/ilp8ztN8Hnr6jHymJzvucT9iE+CXJja8xHC6PNEQq/+Rq
         AKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0OrSnJ5LqQVHAOIAlUBc6H9DOFJkFsF8DhxOn76V2E=;
        b=PLGAHJt1679ELCCztBfhAr4UOOH6vfph0KcRhkirs9ED4YxsSKtIgSqPwe/kL2WZBp
         4+hw5BjwXwrifeYMwo56TZZfn7uYZPtSDrIQyxis2loUzHVCPfYe0601FyHZ6tN45esQ
         XNXljywEFKHB9FRw2GpzaV6nOBWDcOZoIWD2+hC0aJlP1HdNPSXVWNThYmLcWlwANpap
         IKZBjT3ZIucdT9KxPmLdeW4/Kv89CwN00pvys5sjr+YXWW/e4IFzk6vwmmLWwziSW5ND
         9GUraW0xnXZULk8KRHHzZv+HCYzdqjtk5ORYWF6LCQ0eB6Ms3R7sIYwiFLT6GgNCnfq1
         zCdA==
X-Gm-Message-State: AGi0PuagArvPnNLg/5KGayiTGZAtV4+jUyBK4a72PTKAZ+SV2pxHrOsa
        7+3qLF2ixNuJWF36Png+cq24/IPXzo+KgoFCNa5KhUk=
X-Google-Smtp-Source: APiQypJqaPnB+cK7WABPZqpyJoAdfDvAzGFnnfCltCNczi6AoGVt/0Fe5D4jY1S0l2AIfNGm4rjdmkCKkf6x7xVbqeU=
X-Received: by 2002:a05:6402:1b0b:: with SMTP id by11mr5013751edb.269.1588364442510;
 Fri, 01 May 2020 13:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200428125514.2780171-1-omosnace@redhat.com> <20200428125514.2780171-3-omosnace@redhat.com>
In-Reply-To: <20200428125514.2780171-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 16:20:31 -0400
Message-ID: <CAHC9VhTr3cvYwJZyS_GPXW+8_VNoiO=qoJx2WBfpPq+MGsVunA@mail.gmail.com>
Subject: Re: [PATCH 2/4] selinux: do not allocate hashtabs dynamically
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 28, 2020 at 8:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> It is simpler to allocate them statically in the corresponding
> structure, avoiding unnecessary kmalloc() calls and pointer
> dereferencing.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/hashtab.c  |  51 ++++---------
>  security/selinux/ss/hashtab.h  |  13 ++--
>  security/selinux/ss/mls.c      |  14 ++--
>  security/selinux/ss/policydb.c | 126 ++++++++++++++++-----------------
>  security/selinux/ss/policydb.h |   6 +-
>  security/selinux/ss/services.c |  44 ++++++------
>  security/selinux/ss/symtab.c   |   5 +-
>  security/selinux/ss/symtab.h   |   2 +-
>  8 files changed, 116 insertions(+), 145 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
