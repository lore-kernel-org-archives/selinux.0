Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3312C433ED
	for <selinux@archiver.kernel.org>; Tue, 18 May 2021 18:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58B3610CD
	for <selinux@archiver.kernel.org>; Tue, 18 May 2021 18:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbhERSir (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 May 2021 14:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242953AbhERSip (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 May 2021 14:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621363047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GwdBDbQwi6LTntAg6PWTWuoqx5wlPjjT1m9tiZZSdM=;
        b=Llg5vj6muDvHfAeQoNf0BDbK5jHTiK1Aunie98MhBIocNuIA+x0qd6rWS/wYlF4RuUUWZp
        ZdgOJ2zScyAD/mY8CH9gJdWRJDoewvduYPzN1b9U2+U59G1YoKHBFF54eDnDyzsBX7PmeQ
        OACUNlWTDSPMbncdAeuSiNq9CmeKqqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-uWxIdggTM5iVfjBqwFUAnw-1; Tue, 18 May 2021 14:37:24 -0400
X-MC-Unique: uWxIdggTM5iVfjBqwFUAnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B12DF501ED;
        Tue, 18 May 2021 18:37:23 +0000 (UTC)
Received: from localhost (unknown [10.40.192.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 419D55D6AB;
        Tue, 18 May 2021 18:37:23 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 00/25] libselinux: misc compiler and static analyzer
 findings
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
Date:   Tue, 18 May 2021 20:37:22 +0200
Message-ID: <87a6orlwgt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Several changes found by compilers and static analyzer regarding const
> qualifiers, dead code, code smells and resource cleanup.
>
> Contains no changes with regard to libselinux callers.

Acked-by: Petr Lautrbach <plautrba@redhat.com>

All merged.

Thanks!


>
> Christian G=C3=B6ttsche (25):
>   libselinux: sidtab_hash(): do not discard const qualifier
>   libselinux: selinux_file_context_cmp(): do not discard const qualifier
>   libselinux: label_common(): do not discard const qualifier
>   libselinux: Sha1Finalise(): do not discard const qualifier
>   libselinux: sefcontext_compile: mark local variable static
>   libselinux: avcstat: use standard length modifier for unsigned long
>     long
>   libselinux: selinux_restorecon: mark local variable static
>   libselinux: selabel_get_digests_all_partial_matches: free memory after
>     FTS_D block
>   libselinux: getconlist: free memory on multiple level arguments
>   libselinux: exclude_non_seclabel_mounts(): drop unused variable
>   libselinux: context_new(): drop dead assignment
>   libselinux: label_x::init(): drop dead assignment
>   libselinux: label_media::init(): drop dead assignment
>   libselinux: setexecfilecon(): drop dead assignment
>   libselinux: getdefaultcon: free memory on multiple same arguments
>   libselinux: store_stem(): do not free possible non-heap object
>   libselinux: matchmediacon(): close file on error
>   libselinux: init_selinux_config(): free resources on error
>   libselinux: label_file::init(): do not pass NULL to strdup
>   libselinux: matchpathcon: free memory on realloc failure
>   libselinux: label_db::db_init(): open file with CLOEXEC mode
>   libselinux: drop redundant casts to the same type
>   libselinux: sidtab_sid_stats(): unify parameter name
>   libselinux: regex: unify parameter names
>   libselinux: label_file.c: fix indent
>
>  libselinux/src/audit2why.c                    |  2 +-
>  libselinux/src/avc_sidtab.c                   | 15 ++++-----
>  libselinux/src/context.c                      |  2 +-
>  libselinux/src/is_customizable_type.c         |  2 +-
>  libselinux/src/label_db.c                     |  2 +-
>  libselinux/src/label_file.c                   | 16 ++++++----
>  libselinux/src/label_file.h                   |  8 +++--
>  libselinux/src/label_media.c                  |  1 -
>  libselinux/src/label_x.c                      |  1 -
>  libselinux/src/matchmediacon.c                |  1 +
>  libselinux/src/matchpathcon.c                 | 32 +++++++++++--------
>  libselinux/src/regex.c                        |  4 +--
>  libselinux/src/selinux_config.c               |  7 +++-
>  libselinux/src/selinux_restorecon.c           |  7 ++--
>  libselinux/src/setexecfilecon.c               |  1 -
>  libselinux/src/sha1.c                         | 10 +++---
>  libselinux/src/sha1.h                         |  2 +-
>  libselinux/utils/avcstat.c                    |  4 +--
>  libselinux/utils/getconlist.c                 |  1 +
>  libselinux/utils/getdefaultcon.c              |  3 ++
>  libselinux/utils/sefcontext_compile.c         |  2 +-
>  .../selabel_get_digests_all_partial_matches.c | 10 +++---
>  22 files changed, 76 insertions(+), 57 deletions(-)
>
> --=20
> 2.31.1

