Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EAAC001B0
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 16:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjGZQcT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjGZQcT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 12:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A480626AE
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690389091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M9gjEokf0ulKdOd//VSvm0jGiN3rIlkzfEqOMkGT9VI=;
        b=WQT95dF9xrb4I4Ud+jbH3Bb3eheFev+OflNOCGH+oC6qyYZHxpwV7Bq+8LdDTqMaiDjjNA
        9oEpkn1MX+rfWcnF8a1tPF0s//PxtQ+DO+0D/MCHNWbxomq5EEkSVgd46fS7HBgyzg3WRV
        5SwOC4T8D9eHfKLvD5jWZSo8Kq75WN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-XQclruTrNaGxC9pLQ3k4iw-1; Wed, 26 Jul 2023 12:31:29 -0400
X-MC-Unique: XQclruTrNaGxC9pLQ3k4iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B10AC80C4FF;
        Wed, 26 Jul 2023 16:31:28 +0000 (UTC)
Received: from localhost (unknown [10.45.225.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C7B1200B41D;
        Wed, 26 Jul 2023 16:31:28 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc:     juraj@jurajmarcin.com, James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH 0/8] Revert the prefix/suffix filename transition patches
In-Reply-To: <20230726142549.94685-1-jwcart2@gmail.com>
References: <20230726142549.94685-1-jwcart2@gmail.com>
Date:   Wed, 26 Jul 2023 18:31:27 +0200
Message-ID: <87o7jyy6qo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> Since the kernel patches have not been accepted yet, it seems better to
> revert these patches while they can still be cleanly reverted just in
> case the kernel patches are not accepted.
>
> If the kernel patches get accepted, then I will re-apply these patches.
>
> I should have waited for the kernel patches to be accepted before committing
> these in the first place.

Acked-by: Petr Lautrbach <lautrbach@redhat.com>


> James Carter (8):
>   Revert "libsepol/cil: add support for prefix/suffix filename
>     transtions to CIL"
>   Revert "checkpolicy,libsepol: add prefix/suffix support to module
>     policy"
>   Revert "checkpolicy,libsepol: add prefix/suffix support to kernel
>     policy"
>   Revert "libsepol: implement new module binary format of avrule"
>   Revert "libsepol: implement new kernel binary format for avtab"
>   Revert "checkpolicy,libsepol: move filename transition rules to
>     avrule"
>   Revert "checkpolicy,libsepol: move filename transitions to avtab"
>   Revert "checkpolicy,libsepol: move transition to separate structure in
>     avtab"
>
>  checkpolicy/checkmodule.c                  |   9 -
>  checkpolicy/module_compiler.c              |  12 +
>  checkpolicy/module_compiler.h              |   1 +
>  checkpolicy/policy_define.c                | 211 +++++-
>  checkpolicy/policy_define.h                |   3 +-
>  checkpolicy/policy_parse.y                 |  13 +-
>  checkpolicy/policy_scan.l                  |   4 -
>  checkpolicy/test/dismod.c                  |  39 +-
>  checkpolicy/test/dispol.c                  | 106 ++-
>  libsepol/cil/src/cil.c                     |   6 -
>  libsepol/cil/src/cil_binary.c              |  63 +-
>  libsepol/cil/src/cil_build_ast.c           |  26 +-
>  libsepol/cil/src/cil_copy_ast.c            |   1 -
>  libsepol/cil/src/cil_internal.h            |   4 -
>  libsepol/cil/src/cil_policy.c              |  17 +-
>  libsepol/cil/src/cil_resolve_ast.c         |  10 -
>  libsepol/cil/src/cil_write_ast.c           |   2 -
>  libsepol/include/sepol/policydb/avtab.h    |  19 +-
>  libsepol/include/sepol/policydb/hashtab.h  |   8 -
>  libsepol/include/sepol/policydb/policydb.h |  50 +-
>  libsepol/src/avrule_block.c                |   1 +
>  libsepol/src/avtab.c                       | 338 +---------
>  libsepol/src/conditional.c                 |   6 +-
>  libsepol/src/expand.c                      | 153 +++--
>  libsepol/src/kernel_to_cil.c               | 182 +++--
>  libsepol/src/kernel_to_common.h            |  10 -
>  libsepol/src/kernel_to_conf.c              | 178 +++--
>  libsepol/src/link.c                        |  57 +-
>  libsepol/src/module_to_cil.c               |  86 ++-
>  libsepol/src/optimize.c                    |   8 -
>  libsepol/src/policydb.c                    | 479 +++++++++++---
>  libsepol/src/policydb_validate.c           | 101 ++-
>  libsepol/src/services.c                    |   5 +-
>  libsepol/src/write.c                       | 735 +++++----------------
>  34 files changed, 1390 insertions(+), 1553 deletions(-)
>
> -- 
> 2.41.0

