Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8B1C282DA
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0727E21872
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfAaVdi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:33:38 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:47714 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfAaVdh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 16:33:37 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3FCBC5647E0
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 22:33:35 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id s5so4190785oth.7
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 13:33:35 -0800 (PST)
X-Gm-Message-State: AJcUukfr4v7yfh2VRFomd9Baopb5QvOW23IPI0SZFhGtvGPHGCAcCcgR
        vBm/nYFqAplRE1pkTtr9sXLPXdgLBROOIUH37Lk=
X-Google-Smtp-Source: ALg8bN4N//yT64ZtnZ9bPNW8ju1nIBiHR4/960BrwVE+J0t4lk7PA70eD6g4F+3sYALmXkmxypC9I4yQKO0Cmt6nXKQ=
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr28395721otg.74.1548970414256;
 Thu, 31 Jan 2019 13:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20190131132226.19030-1-plautrba@redhat.com>
In-Reply-To: <20190131132226.19030-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 31 Jan 2019 22:33:23 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=m4RUe3AONg-2f81H1i34tdiy5jEnQJ9x1DHb8n_U=1bw@mail.gmail.com>
Message-ID: <CAJfZ7=m4RUe3AONg-2f81H1i34tdiy5jEnQJ9x1DHb8n_U=1bw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: Fix RESOURCE_LEAK defects reported by
 coverity scan
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 22:33:35 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 2:22 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libsepol/cil/src/cil_binary.c      | 12 ++++++++++++
>  libsepol/cil/src/cil_resolve_ast.c | 10 ++++++++++
>  libsepol/cil/src/cil_symtab.c      |  1 +
>  libsepol/src/expand.c              |  3 +++
>  libsepol/src/kernel_to_cil.c       |  2 ++
>  libsepol/src/kernel_to_conf.c      |  2 ++
>  6 files changed, 30 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 0cc6eeb1..a645c95d 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
...
> @@ -4797,6 +4808,7 @@ static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t clas
>         return cp_list;
>
>  exit:
> +       free(cp);
>         cil_log(CIL_ERR,"Failed to create CIL class-permissions from sepol values\n");
>         return NULL;
>  }

Before free(cp), should cp->perms be destroyed with a call to
cil_list_destroy(&cp->perms, CIL_FALSE)?

> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index fb9d9174..91187ed7 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -1522,6 +1522,7 @@ int cil_resolve_sidorder(struct cil_tree_node *current, void *extra_args)
>                 rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_SIDS, extra_args, &datum);
>                 if (rc != SEPOL_OK) {
>                         cil_log(CIL_ERR, "Failed to resolve sid %s in sidorder\n", (char *)curr->data);
> +                       free(new);
>                         goto exit;
>                 }
>                 cil_list_append(new, CIL_SID, datum);

Here, free(new) will not free the items that were already appended.
Would cil_list_destroy(&new, CIL_FALSE) work? (I have not tested it)

> @@ -1591,6 +1592,8 @@ int cil_resolve_catorder(struct cil_tree_node *current, void *extra_args)
>         return SEPOL_OK;
>
>  exit:
> +       if (new)
> +               free(new);
>         return rc;
>  }

Same comment

> @@ -1624,6 +1627,7 @@ int cil_resolve_sensitivityorder(struct cil_tree_node *current, void *extra_args
>         return SEPOL_OK;
>
>  exit:
> +       free(new);
>         return rc;
>  }

Why is there a "if(new)" in the previous chunk and not here? As
cil_list_init() fails hard when the memory allocation failed, new can
never be NULL so the previous if(new) is not needed.

All the other changes in this patch looked good to me.

Nicolas

