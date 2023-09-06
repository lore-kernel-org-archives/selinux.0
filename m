Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E9DEE14BB
	for <selinux@archiver.kernel.org>; Wed,  6 Sep 2023 17:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243017AbjIFRRR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Sep 2023 13:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjIFRRQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Sep 2023 13:17:16 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32492199F
        for <selinux@vger.kernel.org>; Wed,  6 Sep 2023 10:17:13 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c0822f46a1so102230a34.0
        for <selinux@vger.kernel.org>; Wed, 06 Sep 2023 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694020632; x=1694625432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ4/U5uiSXIkyLxh5D56qYxOziG9M6zHYC/vFiF2QG0=;
        b=dNDkRHla/nHOUrIJ1b2YRfSNhRvlbb/dGwjqKK+RuZfDt8S/Ao9Zuxm9+18h+5L3+2
         tNbvTtphzCzC9ZFMTeaAWtataU4zrS4LGoztnOKut4Iv2hsXLg7aoqgWwZPb4vdWsS8s
         f0xlGdx3aVqnCCYu74h8E03tb1flRSXMRp2Q64DzVzeZNi8AmAc/qyNixyKgtJDL3wkE
         Jaxiyp+6KgjZILdSCClEaZfhcNEc7ciTk1Raj6FW3SxvsOaUyRVnQdbZXtjPBHFnyieB
         r5m1qSbjDOWPKgkKg74LvVy2Y2TZrGMskfkMYz/+QCdLRP979R3Slu5Us5N6GwSKuuIl
         zFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694020632; x=1694625432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ4/U5uiSXIkyLxh5D56qYxOziG9M6zHYC/vFiF2QG0=;
        b=kaIP/fyfharQga2hKvlPGd8eALM5q33D4ugIO+oCqnBu92VH9i3ZqhOHPdFolZAyt+
         zx6GfhboSnmNKQsd2zlRDVp7jd73mD8iLGjlS0+WB+f1DzuF1TumGYaHD3r2+G7xNwpN
         KAtE4OM/nr18qdWnSOTFtPEh8pDAIrSWHb7FFmjd9gGyGynZ9cX+lybhOCAYVNYY1B5X
         iD8PhTHtGPkGNWIX9omQNKkVqauaoDNhQYXKVBGRidpetdsFHWiMP5XMahWdPDg8ahrT
         6kq8heU80h8oEKsfe+DijD/+3IAwxM8NnCrP6hqQahiKfs9BnUThWBJtqTigvQ4pfLL7
         QJ9A==
X-Gm-Message-State: AOJu0YyGcA/rcYk4w7eahclJFhF4ONebYf01difzlTxugM+Z8ScXbAck
        J4fdeROJVjD/Q7bZuN+8HHFjvQU8DGmrPdOuo8w=
X-Google-Smtp-Source: AGHT+IFiKSn7VbVlN7+FOAGLqGxaxGmo8pircfzj26bUXTezcGWtO7Mwd54VxC/czwoZcS77iE0ahapMsxJLZpAhUI4=
X-Received: by 2002:a05:6830:32ab:b0:6bd:d14:147a with SMTP id
 m43-20020a05683032ab00b006bd0d14147amr18240428ott.21.1694020632541; Wed, 06
 Sep 2023 10:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230906154611.31762-1-jsatterfield.linux@gmail.com> <20230906154611.31762-3-jsatterfield.linux@gmail.com>
In-Reply-To: <20230906154611.31762-3-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 6 Sep 2023 13:17:01 -0400
Message-ID: <CAEjxPJ61V=OZcAibfbbbV-_PD-0R08JASCED0xB42_Y99rh5wQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] selinux: shrink conditional avtab node array
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 6, 2023 at 11:46=E2=80=AFAM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> Due to how conditional rules are written in the binary policy, the
> code responsible for loading does not know how many conditional rules
> there are before creating the avtab structure. Instead, it uses the
> number of elements in the non-conditional avtab as a hint and allocates
> the hash table based on it. Therefore, pre-allocating an array of nodes
> based on this hint over-allocates at best and under-allocates at worst.
>
> This patch includes two functions, avtab_grow_nodes and
> avtab_shrink_nodes, which help manage the size of the nodes array in the
> unlikely case when there are more conditional rules than non-conditional
> and in the likely case when there are more non-conditional rules than
> conditional rules respectively.
>
> This patch required struct cond_av_list to become an array of indices
> instead of pointers so that the nodes array can be copied and moved.
> This coveniently results in a reduction of memory usage on 64-bit archs
> as pointers become u32 integers.
>
> Future improvements to the binary policy to provide the correct hint to
> the loader code will make these functions obsolete. But as this would be
> a breaking change to the format, it is not a part of this patch series.
>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/ss/avtab.c       | 61 +++++++++++++++++++++++++------
>  security/selinux/ss/avtab.h       |  8 ++--
>  security/selinux/ss/conditional.c | 46 ++++++++++++++---------
>  security/selinux/ss/conditional.h |  2 +-
>  4 files changed, 84 insertions(+), 33 deletions(-)
