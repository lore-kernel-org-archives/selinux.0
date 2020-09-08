Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDF7C433E2
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 17:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A841C2074D
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 17:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFdcQHLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbgIHRx5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731574AbgIHQMs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 12:12:48 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813CFC0619C4
        for <selinux@vger.kernel.org>; Tue,  8 Sep 2020 06:46:54 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id u25so14875130otq.6
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2020 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlDOIhj7wnpfVJ+cfScXsi9ZQ19wAPf+yZo3cARjanw=;
        b=WFdcQHLOBrA7SYN0gbfyCZMbIROvJrYk3r1xgGenWeBvHoWXrwkhbDDz+akbVyGWsS
         Ef+wR5hAnCtubRCQE75EGtejbF9TZRNQg2mXVp/Vl50Cr5feyt+cWsUnBZryPlYqus8t
         x237l5iaCwwtBOA4loyLFQotMB+TqG4+sunSXSyau4Bm/ztbgvxe6VxGbs51s1c6saFo
         WZ93KjEJDt0PB80dMUVlccUZxNNv+sPkuSsKp17jxJbmD4LwJOL3ssxgqNKl84tOEwpf
         RN6ZNdHh6IsAVbfkAAWFO+UaE0reMd1Z3+H0Jk14tkUNSoK3Jpe7z5kEM84obFwyzHjV
         7EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlDOIhj7wnpfVJ+cfScXsi9ZQ19wAPf+yZo3cARjanw=;
        b=L/SsHzCf5dyoCiJXrMwjqkKiE3SDJWoYEODFM/Zed2MXPEcHDGGsXrP98h5lNn8EYg
         IZMJfBddEAjRVBp9ViU0KqDvdx5cPGX5ZwPlLY6d9UhxJxKl4wxe6R1rUZFAiBYtlDip
         Uyhob6EOFVwtehgLuBsEARqWqGa8tfCxVESMtqc8QL2zyMFR9yHDZWxm3nEARribBeEZ
         tJe307nv1OOdpWuUVzoZOVyNEk/xsHOykGb4IOZVyym5nakKshWsVRzAamy5ZnZhcpyq
         6wYw5fxh1jnP8N0t1fB/pHAzTvQ8rgqYGuFaTxb2It+vbnZiLinYe9qB8T6R/G+Dwxnp
         5Pqg==
X-Gm-Message-State: AOAM530/gi8lua+soCZXU8fzMkw7oU1VRAecUB6sxE0WQVdiH+3WT60z
        efIpZbbiZmkXIgizF1JZwgGFwVJ1ifdxDJKr6N4=
X-Google-Smtp-Source: ABdhPJyUsK+P13BgE+ojxqGAHHXH9sLfQxVg8ev8qOsE5e2NUKSxDeFBxqT2WeJ0UPsZM5Mt2d7jyzMKp+CAKXh9umM=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr17108174otn.89.1599572813713;
 Tue, 08 Sep 2020 06:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200903181900.81179-1-jwcart2@gmail.com> <CAEjxPJ53Z6z2VAw75QOHZdK-kFz1fnkEFth7acyUGh_2nzpGkQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ53Z6z2VAw75QOHZdK-kFz1fnkEFth7acyUGh_2nzpGkQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Sep 2020 09:46:42 -0400
Message-ID: <CAEjxPJ6EXg5B8pjCxs2SdqBGe91u7PZnBPEphWgvvQ_u1mZtYA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Give an error when constraint expressions
 exceed max depth
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 4, 2020 at 8:49 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 3, 2020 at 2:19 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > CIL was not correctly determining the depth of constraint expressions
> > which prevented it from giving an error when the max depth was exceeded.
> > This allowed invalid policy binaries with constraint expressions exceeding
> > the max depth to be created.
> >
> > Correctly calculate the depth of constraint expressions when building
> > the AST and give an error when the max depth is exceeded.
> >
> > Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> The fix for conditional boolean expression depth checking can be a
> separate patch.  For this one,
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Actually, this breaks selinux-testsuite. Will have to look into why.
/usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.cil
test_overlay_defaultrange.cil test_add_levels.cil test_glblub.cil
Max depth of 4 exceeded for constraint expression
Bad expression tree for constraint
Bad constrain declaration at
/var/lib/selinux/targeted/tmp/modules/100/base/cil:919
