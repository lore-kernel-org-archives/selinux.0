Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0233BC676A8
	for <selinux@archiver.kernel.org>; Thu,  2 Sep 2021 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA886109E
	for <selinux@archiver.kernel.org>; Thu,  2 Sep 2021 16:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbhIBQ3a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346309AbhIBQ3V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Sep 2021 12:29:21 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D92C061575
        for <selinux@vger.kernel.org>; Thu,  2 Sep 2021 09:28:23 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 107-20020a9d0bf4000000b0051b8be1192fso3223750oth.7
        for <selinux@vger.kernel.org>; Thu, 02 Sep 2021 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIzQgJQhvAU62WUAsNXk6cijWKML93OBfc3mKhUe/nE=;
        b=UAftFSWW7DdMcoYGJdx6V80j95dA4pC6MapEp7EHYicj8P3qaMhFTIevbvk4/kQ2Gj
         NXURiGsn6EGCRxpnNMYbsmQpuQERu0LBcbrcgwdUm5L4esuQPOPLYEuvpYZvIQYCPCEb
         Jb3Ma1Y4cRr5HZOXDp1lFxm/OlR4Q5CXtPEVNrHV8X5TZKzl0sfSnWbLJ/Kf0quLSMt+
         E3hIZk23Izs0oTU68yHhI3ElNXnGLGQUI92+nclGff9fYuO81Ae3GunUCPCfcrgjZmYR
         8eH5QHw0DMJF04nrPLDk5M5X0RbX71EFttY7b8/gH2AqbQLEnDn/HxKLtJzFAFPEHcOA
         tsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIzQgJQhvAU62WUAsNXk6cijWKML93OBfc3mKhUe/nE=;
        b=jAIE34KmQZsHTkWBXzUfp+Mct/qZDx7+bGar+FXGS9myv3/RH9NKZQqFU2tsbAPfmh
         620u2tPcNjNji1EgF9pddOKfV4VvUXt3OX5k09IetrRkD8Qq4QYIlD1xhqMd+uxyujpX
         pMvF8UHLUcjrwtzdX9mvrWYeYxQ5huqAXfz+ihR92FGM+1iqoeDvDuZSNgexMHEkZ+8L
         7kH5XfinAjaXR6uwz5db41rHlKE5kaNpE5Sfc5akr17HTzZT6LN0G8vBo4KrEF2VN5rO
         DafG6JBkh3egutVy2B3t9aZrqoRxo4viRQe5ePDWAzr3PNEF2EUZM+IkaeOq3iUw9S4Z
         bGZw==
X-Gm-Message-State: AOAM532ithegzFn6nqhrXulkOW8wla5KCcV7jMlt/uDDM4FH2maNThCR
        r27O24iB3YXZoHxcmm8/LecRTBZmEleds66on8yjvna2
X-Google-Smtp-Source: ABdhPJyRwp2nMfzOLq6l19zNCw/Vc73vuPzCZJc9NYBGzKrjQlmeo1GLf7eKler2HnBCXbJlBPKxqkagjsQbsXqi3a8=
X-Received: by 2002:a9d:608b:: with SMTP id m11mr3415374otj.196.1630600102601;
 Thu, 02 Sep 2021 09:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210827141955.370777-1-jwcart2@gmail.com> <CAJfZ7=m_PJj2SaSqGs7phPhTYnfRD_fSxhVPZJwZXet2yMjrmw@mail.gmail.com>
In-Reply-To: <CAJfZ7=m_PJj2SaSqGs7phPhTYnfRD_fSxhVPZJwZXet2yMjrmw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Sep 2021 12:28:11 -0400
Message-ID: <CAP+JOzSkzMApjTdK8D66YnkQwSQZWw_76egfN=ne-nLaP=CUdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol/cil: Properly check parse tree when printing
 error messages
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 1, 2021 at 3:22 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Aug 27, 2021 at 4:20 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > The function cil_tree_get_next_path() does not check whether the
> > parse tree node that stores the high-level language file path of a
> > src_info rule actually exists before trying to read the path. This
> > can result in a NULL dereference.
> >
> > Check that all of the parse tree nodes of a src_info rule exist
> > before reading the data from them.
> >
> > This bug was found by the secilc-fuzzer.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> For the 3 patches:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

This series has been merged.
Thanks,
Jim

> Thanks,
> Nicolas
>
> > ---
> >  libsepol/cil/src/cil_tree.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> > index 75293005..e70722ec 100644
> > --- a/libsepol/cil/src/cil_tree.c
> > +++ b/libsepol/cil/src/cil_tree.c
> > @@ -62,7 +62,10 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
> >
> >         while (node) {
> >                 if (node->flavor == CIL_NODE && node->data == NULL) {
> > -                       if (node->cl_head->data == CIL_KEY_SRC_INFO && node->cl_head->next != NULL && node->cl_head->next->next != NULL) {
> > +                       if (node->cl_head && node->cl_head->data == CIL_KEY_SRC_INFO) {
> > +                               if (!node->cl_head->next || !node->cl_head->next->next || !node->cl_head->next->next->next) {
> > +                                       goto exit;
> > +                               }
> >                                 /* Parse Tree */
> >                                 *info_kind = node->cl_head->next->data;
> >                                 rc = cil_string_to_uint32(node->cl_head->next->next->data, hll_line, 10);
> > --
> > 2.31.1
> >
>
