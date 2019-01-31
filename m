Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD6C169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF83020869
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfAaVRO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:17:14 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:59345 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAaVRO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 16:17:14 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6B6515646C8
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 22:17:12 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id u16so4143585otk.8
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 13:17:12 -0800 (PST)
X-Gm-Message-State: AJcUukfmsWroFBe3Km8ihWOa/NJol+LNZmvTx7H/hst89Vr7tuW8hiBg
        bL4CDm1RdHy3+vPQHZS1qaYGN1WHhnhzlgKIHns=
X-Google-Smtp-Source: ALg8bN42kskdRtsDMUHjotQ8R8FXZXOZ8whL/cEcxUjuSOg8792xDcUQv8e6jXy+2k3iILnbG+ypzXgLzMYyHJAvXAU=
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr28355379otg.74.1548969431307;
 Thu, 31 Jan 2019 13:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20190131132226.19030-1-plautrba@redhat.com>
In-Reply-To: <20190131132226.19030-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 31 Jan 2019 22:17:00 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mK=okzh1S8_1h6_TPRMTXEUQyHUccTf-Uai=Az8SDRQg@mail.gmail.com>
Message-ID: <CAJfZ7=mK=okzh1S8_1h6_TPRMTXEUQyHUccTf-Uai=Az8SDRQg@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: Fix RESOURCE_LEAK defects reported by
 coverity scan
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 22:17:12 2019 +0100 (CET))
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
> @@ -912,6 +912,8 @@ int cil_sensalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alias)
>         key = cil_strdup(cil_alias->datum.fqn);
>         rc = symtab_insert(pdb, SYM_LEVELS, key, sepol_alias, SCOPE_DECL, 0, NULL);
>         if (rc != SEPOL_OK) {
> +               if (rc == 1)
> +                       free(sepol_alias);
>                 goto exit;
>         }

There is something weird here. The exit label starts with
"level_datum_destroy(sepol_alias);". This is not a serious issue
because level_datum_destroy() does not do anything, but after this
patch, cil_sensalias_to_policydb()'s code seems to use sepol_alias
after freeing it.

Should the call to level_datum_destroy(sepol_alias) be removed, or
moved before free(sepol_alias)?

Thanks,
Nicolas

