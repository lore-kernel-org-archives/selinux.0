Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFF7EE0210
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 22:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjIMWNK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Sep 2023 18:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjIMWNK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Sep 2023 18:13:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD921996
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 15:13:05 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76f08e302a1so23521185a.1
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694643185; x=1695247985; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p17mow8jOToGHzl/reGSy5sg/JPF1WcbOesSQaNA64=;
        b=Fbb5HPISxCDtWGpl9r3GRmDhaUeVYIxqa/1sg3oUyaCODR7H7YtjdVKfm5TgrSdI2W
         CYQjkRmu1bdtMzeHAnIfXefzKarvguH2nD5PWKaIcVDe5VxHuJM7OHMNhVIblIJSe0Hs
         XFTGtdCC10260Pg255cABzIPiQUxPG2E2WbCB8Gn8i1Nu8uI6XKWipqGAOmlO8jZ+GM4
         t/dGefIWmD4X1OUL6UkoNcrM6QjIykoAmgnUXdYEfn2JxFFoBM5Gu1twISGfZKpyNfkQ
         Hdqt4L4TG0QqHzm+iuKmAI53+ytfdMUWr3lN3RoI0zhS+W8GzswF10JomlybLIs10mP2
         seeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643185; x=1695247985;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2p17mow8jOToGHzl/reGSy5sg/JPF1WcbOesSQaNA64=;
        b=Q2Se+GsPwTznmNoyvlOi73BgOiUxQYLiR6NSRve4VxxvBc+eEETyJEd+7vAtymRP7S
         Nf593iaaPa343f18ecumDF/4eWznUJRedJrQdw/ApuNKHBDpS32o6flmEjt6O70CNG+e
         Ty5+vaOmcCr/mXBFlVFfrMV39Lui8bjlT3KvSxd+awpwraQYyEbAeWbxj9MTQhhyJXoY
         UtjRc2NWpdtFD0YCNxkoE8AzLCJiSxBnQSGWLP/t0pAllIQrImgIvmuwkuU+PWJ0Ztv4
         uYpFStgL2WyTd6ZxAAU9fzFtKot8YE0Q4I7vdLC9J1trfS+s2jBiAXYkPm7+TDON75OQ
         BtyA==
X-Gm-Message-State: AOJu0YwxgK5Y5D937nczyay+HphwZlCc2Vj0TXGn3/14VXIOMmEMqgR5
        fCSczSG+6wdv4RX8rQzUwV/v
X-Google-Smtp-Source: AGHT+IF2ufzmX0mgSW8tYUOIhjgdVWAPVJoSNbm23WjMTFdbfD9qge9HiUsqmQYmCws2E0YhK7FVzg==
X-Received: by 2002:ac8:5e49:0:b0:415:15bd:94d2 with SMTP id i9-20020ac85e49000000b0041515bd94d2mr4259821qtx.43.1694643184892;
        Wed, 13 Sep 2023 15:13:04 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id m4-20020ac807c4000000b00410ab3c78efsm73610qth.11.2023.09.13.15.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 15:13:04 -0700 (PDT)
Date:   Wed, 13 Sep 2023 18:13:03 -0400
Message-ID: <82e3a9c95fdc838943802d9a22d83aa8.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: Re: [PATCH] lsm: constify 'bprm' parameter in  security_bprm_committing_creds()
References: <ZOW5rC1MngXvPQLz@gmail.com>
In-Reply-To: <ZOW5rC1MngXvPQLz@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug 23, 2023 Khadija Kamran <kamrankhadijadj@gmail.com> wrote:
> 
> The 'bprm_committing_creds' hook has implementations registered in
> SELinux and Apparmor. Looking at the function implementations we observe
> that the 'bprm' parameter is not changing.
> 
> Mark the 'bprm' parameter of LSM hook security_bprm_committing_creds()
> as 'const' since it will not be changing in the LSM hook.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/apparmor/lsm.c       | 2 +-
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

Merged into lsm/next, thanks!

--
paul-moore.com
