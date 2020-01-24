Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3AAC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 13:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB13920838
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 13:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iw9tDrf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbgAXNMV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:12:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41373 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387486AbgAXNMV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 08:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579871539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JNVhcQVujxWes3ag+7lMmuio1muuLInyCRTsEe5OF+k=;
        b=iw9tDrf/Y60Wz6pzW/vhT64j47mBbv+MlIR0PmHIRNqxgCD5Xu3E5ZtOox3otm9VfWRc+o
        ozZBO+PEHYbF/tfGQpt3eBy7u2/rR0OsVfDV7igoLJcppgaIoYtr4UAIHIVTpOQv2Du9Zy
        LHzftNELp0P7LKzPc3pMI55/6deuE1Q=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-U6i93UVEMmeVzE6OD1wJjg-1; Fri, 24 Jan 2020 08:12:17 -0500
X-MC-Unique: U6i93UVEMmeVzE6OD1wJjg-1
Received: by mail-ot1-f70.google.com with SMTP id z13so841561otp.7
        for <selinux@vger.kernel.org>; Fri, 24 Jan 2020 05:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNVhcQVujxWes3ag+7lMmuio1muuLInyCRTsEe5OF+k=;
        b=okxU0nsWKUx1TSbIyBPjU2BnSZDp+1B40kjU5HMId4h4cP2kioN8allX7V1Xe/PJ0j
         mXD12Xl6SYcb/724oLuAD4vXzaPh3lSvPd+RdqjETc7CGQBQday9Lq1Oo7TEx0o6xaqc
         soReMqNTPR5AwV5P3hHiqHeY2tgCfyVCcyMcs274pG3AMu4YtYrMTY8/I2X49untjFK/
         0CKt8iDSy87TbVdOeV46Rj8GmM22AaPRdnmgclIvfs2B0uCRiRiuAidLlHpB7pLBHAeH
         sDS+Baglcawb7YO7T83Ii+KA3U7d/wVdJ8lm+hfLjfqM72FDPQiUCcTOzvjQj07XMvyv
         I/fA==
X-Gm-Message-State: APjAAAUXyC8U6kgUGIyVWPjYziCDEqR0q2KUeG3ZGDxmxl4K7JvFrj+Y
        jiNMLnPYvaerPRxrY/2g242HMb3q0AxaZVD6kFWrqqWkxF+XD+CBJoJDsNWL9pKkYbhCygMV/55
        5pqGPjmCbs+SdNQ385dDQ5ekUqB6Q5MJqLw==
X-Received: by 2002:aca:c30d:: with SMTP id t13mr1952749oif.166.1579871536499;
        Fri, 24 Jan 2020 05:12:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVs7INEGMt9xKyB4gqBB4pb/1EXDx9sE4rxwL2uKzQUpOhKWZXjxlR6R6gvoVLQsGwhVrj84RS2zZLX1UGVtw=
X-Received: by 2002:aca:c30d:: with SMTP id t13mr1952731oif.166.1579871536227;
 Fri, 24 Jan 2020 05:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20200123204004.25600-1-jwcart2@tycho.nsa.gov>
In-Reply-To: <20200123204004.25600-1-jwcart2@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 24 Jan 2020 14:12:05 +0100
Message-ID: <CAFqZXNtkpV+E-Vpkeq2_2FitKQFFfu1bjDdaZFD5SA3gm9FfSg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix bug in cil_copy_avrule() in extended
 permission handling
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 23, 2020 at 9:39 PM James Carter <jwcart2@tycho.nsa.gov> wrote:
> When copying an avrule with extended permissions (permx) in
> cil_copy_avrule(), the check for a named permx checks the new permx
> instead of the old one, so the check will always fail. This leads to a
> segfault when trying to copy a named permx because there will be an
> attempt to copy the nonexistent permx struct instead of the name of
> the named permx.
>
> Check whether the original is a named permx instead of the new one.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

(OK, this looks simple enough to try out my new maintainer "powers" :)

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
>  libsepol/cil/src/cil_copy_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index 7af00aaf..67dd8528 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -827,7 +827,7 @@ int cil_copy_avrule(struct cil_db *db, void *data, void **copy, __attribute__((u
>         if (!new->is_extended) {
>                 cil_copy_classperms_list(orig->perms.classperms, &new->perms.classperms);
>         } else {
> -               if (new->perms.x.permx_str != NULL) {
> +               if (orig->perms.x.permx_str != NULL) {
>                         new->perms.x.permx_str = orig->perms.x.permx_str;
>                 } else {
>                         cil_permissionx_init(&new->perms.x.permx);
> --
> 2.21.1
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

