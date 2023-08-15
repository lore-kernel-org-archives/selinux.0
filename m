Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA51C0015E
	for <selinux@archiver.kernel.org>; Tue, 15 Aug 2023 15:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbjHOPK1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Aug 2023 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbjHOPKU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Aug 2023 11:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FA41733
        for <selinux@vger.kernel.org>; Tue, 15 Aug 2023 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692112171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycRQTp8KxzcHecAMFhdZQVaqV+raTcW9mCvyhuO+mgU=;
        b=YFH8INIEycai5/7SpiQR3xZUJAJPc5vOJEafZdbjg0ibp3ezSdpZ7fLbSbfJZ6u3OZiQjj
        T31kBLx7rsntb2mKH85/DlCZjnQgzjNe571b12x1e59Bu7MbLP1mXMiW3pN2aixm84tRdr
        Mgm1IgmkfcCoFretM2cj6doVmr08UOg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-1H5ZE346PK-3nJv7OTCCSg-1; Tue, 15 Aug 2023 11:09:29 -0400
X-MC-Unique: 1H5ZE346PK-3nJv7OTCCSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE859101AA63;
        Tue, 15 Aug 2023 15:09:28 +0000 (UTC)
Received: from localhost (unknown [10.45.226.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DE1440D2839;
        Tue, 15 Aug 2023 15:09:28 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH 0/9 v4] Add CIL Deny Rule
In-Reply-To: <20230809210157.112275-1-jwcart2@gmail.com>
References: <20230809210157.112275-1-jwcart2@gmail.com>
Date:   Tue, 15 Aug 2023 17:09:27 +0200
Message-ID: <87zg2se40o.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> This patch series depends on the "Add support for notself and other to
> CIL" patch series from August 9th
>
> These patches add a deny rule to CIL. Deny rules will be processed after
> everything except for neverallow rules. Unlike neverallow rules, they
> remove the permissions in the deny rule rather than reporting an error.
>
> See the individual patches for an explanation of what they do.
>
> Patches 1-8 are unchanged from v3, see:
> https://lore.kernel.org/selinux/20230413193445.588395-1-jwcart2@gmail.com/
>
> Previously, patch 9, as Daniel Burgener noted, did not do what it said it
> was going to do. Now it does.

I've pushed all 16 into
https://github.com/bachradsusi/SELinuxProject-selinux/commits/notself-other-deny
and I'm building it in my COPR repo -
https://copr.fedorainfracloud.org/coprs/plautrba/selinux-patchwork/builds/

I've already run some tests and it looks good.

For all 16 patches - together with notself and other serie:

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Thanks!



> James Carter (9):
>   libsepol/cil: Parse and add deny rule to AST, but do not process
>   libsepol/cil: Add cil_list_is_empty macro
>   libsepol/cil: Add cil_tree_node_remove function
>   libsepol/cil: Process deny rules
>   libsepol/cil: Add cil_write_post_ast function
>   libsepol: Export the cil_write_post_ast function
>   secilc/secil2tree: Add option to write CIL AST after post processing
>   secilc/test: Add deny rule tests
>   secilc/docs: Add deny rule to CIL documentation
>
>  libsepol/cil/include/cil/cil.h         |    1 +
>  libsepol/cil/src/cil.c                 |   68 ++
>  libsepol/cil/src/cil_build_ast.c       |   56 +
>  libsepol/cil/src/cil_build_ast.h       |    2 +
>  libsepol/cil/src/cil_copy_ast.c        |   19 +
>  libsepol/cil/src/cil_copy_ast.h        |    1 +
>  libsepol/cil/src/cil_deny.c            | 1413 ++++++++++++++++++++++++
>  libsepol/cil/src/cil_deny.h            |   36 +
>  libsepol/cil/src/cil_flavor.h          |    1 +
>  libsepol/cil/src/cil_internal.h        |   10 +
>  libsepol/cil/src/cil_list.h            |    3 +
>  libsepol/cil/src/cil_post.c            |    7 +
>  libsepol/cil/src/cil_reset_ast.c       |    8 +
>  libsepol/cil/src/cil_resolve_ast.c     |   48 +
>  libsepol/cil/src/cil_resolve_ast.h     |    1 +
>  libsepol/cil/src/cil_tree.c            |   35 +
>  libsepol/cil/src/cil_tree.h            |    1 +
>  libsepol/cil/src/cil_verify.c          |    9 +
>  libsepol/cil/src/cil_write_ast.c       |   10 +
>  libsepol/cil/src/cil_write_ast.h       |    1 +
>  libsepol/src/libsepol.map.in           |    5 +
>  secilc/docs/cil_access_vector_rules.md |   41 +-
>  secilc/secil2tree.c                    |    8 +-
>  secilc/test/deny_rule_test1.cil        |  580 ++++++++++
>  secilc/test/deny_rule_test2.cil        |  418 +++++++
>  25 files changed, 2780 insertions(+), 2 deletions(-)
>  create mode 100644 libsepol/cil/src/cil_deny.c
>  create mode 100644 libsepol/cil/src/cil_deny.h
>  create mode 100644 secilc/test/deny_rule_test1.cil
>  create mode 100644 secilc/test/deny_rule_test2.cil
>
> -- 
> 2.41.0

