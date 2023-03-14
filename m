Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D98C05027
	for <selinux@archiver.kernel.org>; Tue, 14 Mar 2023 19:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjCNT2u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjCNT2j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Mar 2023 15:28:39 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981C5900B
        for <selinux@vger.kernel.org>; Tue, 14 Mar 2023 12:28:37 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e71so8456494ybc.0
        for <selinux@vger.kernel.org>; Tue, 14 Mar 2023 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678822117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgxLqjNHLHFmwvWWamBkPfHPyQN320qeTND2oWOpQO4=;
        b=RBNgx29ajp7WtfpWqUE5zmG8V6YOqHamPj8Wt1DLJJga9I71viFduOmwCL7XRGxjyh
         ci9OxpIDS/+HEWgfMabC7TfLylZSAyVjksSve/5P44FZ0GX6KHCj0uqDoLFmKS79VPcb
         RVQVyb9np1+tre+XjgXQ8TNS3AxORaTP+MxfKfWpHtsFmuenRaIaLga83hQQZAHkKejv
         /0d5ScKj4rjLwU7F8yW+0whZK15FKbrTvsSBcWsv7DWKumxXN0RgMz3xYRt2tPnb9F/2
         zrFDh7EStG7Pq7h4ien/Xd481LIrwmRA4pojEkGqVTzAmWQ6CrUGTycE2oglGvKX1PhL
         eltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678822117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgxLqjNHLHFmwvWWamBkPfHPyQN320qeTND2oWOpQO4=;
        b=trL7wdzNRPrKNHqgHItCiyoeH1lTmm0QkwqOMH8etwUW9jTlHqLA30B19uG/rgM1Uk
         Ao49C8VJCPQ1KQJKPf3Vuv8VmtLzwkzvf0jcvLfIdBag/zGSqtgjOvmG0ovoM8iETDB1
         wDcXiohHsxnzw5lNRrkGgjYaSkPJfK6v1+fgf7L5sewdOorpdK5KG53DUUxqB6QMOHSk
         vPvCZG3XbQgzjOyWNliTRH/b5/3MYLtL4BPM2RfkhATdP+1hAMYymeybNsMxLTkHpUpx
         LRXBIVwePZgBhvFy+nFfNASrhdma2vF8pNnMQhLvCsXERroUyVuL4bGkrio9VXFNkE/N
         M4Cg==
X-Gm-Message-State: AO0yUKXRzAwSTGp5uJTJmmOPpovT4QTvBQbApvX/jS90T0RyYEADjEVw
        Y6erSDxgxQ3Ds7YvySdAeGgBCJzDQANMtCpOVWmF
X-Google-Smtp-Source: AK7set+SNxgz6ktdYngECpuRgBPT8fMqr++FjGETQySmRvfXb754K4LKWUc8QzGiNJWwvvRXs7kgzvDuwJykhhH/h+4=
X-Received: by 2002:a05:6902:4f0:b0:ab8:1ed9:cfc1 with SMTP id
 w16-20020a05690204f000b00ab81ed9cfc1mr22147305ybs.3.1678822116752; Tue, 14
 Mar 2023 12:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230310130113.2029-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20230310130113.2029-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Mar 2023 15:28:25 -0400
Message-ID: <CAHC9VhRA1q6NHK4WcH+oJny35-+Qb4BKApFueOu9zu-saOwXQQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: stop passing selinux_state pointers and their offspring
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, torvalds@linux-foundation.org,
        omosnace@redhat.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 10, 2023 at 8:03=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Linus observed that the pervasive passing of selinux_state pointers
> introduced by me in commit aa8e712cee93 ("selinux: wrap global selinux
> state") adds overhead and complexity without providing any
> benefit. The original idea was to pave the way for SELinux namespaces
> but those have not yet been implemented and there isn't currently
> a concrete plan to do so. Remove the passing of the selinux_state
> pointers, reverting to direct use of the single global selinux_state,
> and likewise remove passing of child pointers like the selinux_avc.
> The selinux_policy pointer remains as it is needed for atomic switching
> of policies.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303101057.mZ3Gv5fK-lkp@int=
el.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes the lockdep_assert_held() in security/selinux/ima.c reported by =
kernel test robot.
>
>  security/selinux/avc.c                 | 197 ++++-----
>  security/selinux/hooks.c               | 549 ++++++++++---------------
>  security/selinux/ibpkey.c              |   2 +-
>  security/selinux/ima.c                 |  37 +-
>  security/selinux/include/avc.h         |  29 +-
>  security/selinux/include/avc_ss.h      |   3 +-
>  security/selinux/include/conditional.h |   4 +-
>  security/selinux/include/ima.h         |  10 +-
>  security/selinux/include/security.h    | 171 +++-----
>  security/selinux/netif.c               |   2 +-
>  security/selinux/netlabel.c            |  17 +-
>  security/selinux/netnode.c             |   4 +-
>  security/selinux/netport.c             |   2 +-
>  security/selinux/selinuxfs.c           | 208 ++++------
>  security/selinux/ss/services.c         | 346 +++++++---------
>  security/selinux/ss/services.h         |   1 -
>  security/selinux/status.c              |  44 +-
>  security/selinux/xfrm.c                |  20 +-
>  18 files changed, 651 insertions(+), 995 deletions(-)

Merged into selinux/next, thanks Stephen.

--=20
paul-moore.com
