Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62418C433E1
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 12:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370D620724
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 12:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbDNvTes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHUM3g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgHUM3d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 08:29:33 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3306C061385;
        Fri, 21 Aug 2020 05:29:32 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h22so1397230otq.11;
        Fri, 21 Aug 2020 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyfadVWLMqawJRTIbPVn1xuWVw5c4WH7SQfS+lYvwdM=;
        b=BbDNvTesofn8kb5rMLokT9pvAZZXAgWUM1MHYxRmsPcqjXYpgLIf039WcB6UFAofOr
         CBCk0jf+xUOSP0TOjzqfMqi0Zo3gFgkJILaFwb7maHuUuigsvt7p4FSJUUxQ6PJ6RkAW
         QJUkXudVAUI6gnFu19PH+o77TdBIyxtkzmmMyhFkIxt4HayX78B0GPKmnUuBPiZS90dx
         P8455Hmh5kvv9c8t1GbClSJY4DW0LhYxNKxI8aCSXJGs4vpK+k/cqbpaWEmdO/tUGEaY
         z66UKPKQ4nA3zRfy9vtanh4M/vhu/dkN4iKsOjQdnP5XFDlvbVDjDRK14s2OzH3I1tWf
         zAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyfadVWLMqawJRTIbPVn1xuWVw5c4WH7SQfS+lYvwdM=;
        b=Zz9IhIFve1DRwq2jfHilY6ZVeIXQGKN6X3TEou+aK4GpGevIa0zveJqKN+3jKxU3Tx
         DeM4aPfHkyha2wSb6xJ0/id0HqanjoW9Z16+ONk2qq6vycZoBvPvl2c4wph/q7ruZyqT
         sT0jKAxWyd0Zy8+OAfvKELpYWcLlmAG5aBeGFIGJEYfdMpbI91zOUUGCDn+ldr1f7fpb
         O5iXCIxJwVt8aTDNzL63NIw4E/Lh0m00CNvKJWM8ggzcDxuuxLBfVWWKUb1Ut6yhV1ta
         Jj1SHaWEX7y3dYNcQW77JxZBqwAATtVAIFn+ezWg5Pl5gsiSjF+Z6v7t4vYvIkzurEJ5
         7iJA==
X-Gm-Message-State: AOAM533yvwcZhskMGaBdwGjVP5f45DmWBcmXGY3UoI3iZ/XZcrO1hojT
        Je4HLFOsk1t8fD4mNVJtyya2fQUVmto4QfoAvdw=
X-Google-Smtp-Source: ABdhPJxkT6uZ6pZSHaAmRPYE3ll8NIpCM/ZIYNd7D9MLFX6AMFJcb498bM0+FWc7H5BOrreJ6+RZZE3RDodlCuhSn5U=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr1770333otn.162.1598012972298;
 Fri, 21 Aug 2020 05:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170729.2605279-1-tweek@google.com> <20200817170729.2605279-4-tweek@google.com>
 <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com> <20200817162933.79f69c66@oasis.local.home>
 <20200818120948.1a428da9@oasis.local.home> <66e6d84e-20b5-1bd3-e107-322f42ce35d3@gmail.com>
 <20200820223136.162850ce@oasis.local.home>
In-Reply-To: <20200820223136.162850ce@oasis.local.home>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 21 Aug 2020 08:29:21 -0400
Message-ID: <CAEjxPJ7-6PaHjPzB7vN=nh+VMNV-T2bnKM-YrXdQwOzNtG+9zg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 10:31 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 19 Aug 2020 09:11:08 -0400
> Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
>
> > So we'll need to update this plugin whenever we modify
> > security/selinux/include/classmap.h to keep them in sync.  Is that a
> > concern?  I don't suppose the plugin could directly include classmap.h?
> > I guess we'd have to export it as a public header. It isn't considered
> > to be part of the kernel API/ABI and can change anytime (but in practice
> > changes are not that frequent, and usually just additive in nature).
>
> Yes, it would require some stability between userspace and the plugin.
> If the value indexes don't change then that would work fine. If you add
> new ones, that too should be OK, just have a way to state "unknown" in
> the plugin.

Since we introduced the dynamic class/perm mapping support, it has
been possible for the values of existing classes/permissions to
change, and that has happened at time, e.g. when we added watch
permissions to the common file perms, that shifted the values of the
class file perms like entrypoint, when we added the process2 class
right after the process class, it shifted the values of all the
subsequent classes in the classmap.h.  So you can't rely on those
values remaining stable across kernel versions.
