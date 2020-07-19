Return-Path: <SRS0=eLZI=A6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF491C433E1
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 09:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9202B208DB
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 09:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxd8IYHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgGSJd1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Jul 2020 05:33:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41786 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgGSJd0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Jul 2020 05:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595151204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=moheTi8kxyiojWZTDDmmqtPwWZqDhE7Ej06fRSEXJt4=;
        b=dxd8IYHtlwyUZ/EF2ziVeaRCH1HVzoVcmMnNyOn4AuWSaxTZq42jU3UyR1Sz9fYbpO1NgW
        x7GcXsOSraM9q/JZrlOU4iFCBBcwUgIDe9rPRBDp2o2biLqDXlsQtEEXh+iKIj7Z/sNMmi
        y9lfjiruHx9OQCLUgIBP4KoKVN4ilS8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-h6_DBesrN_S-QfWACWB92g-1; Sun, 19 Jul 2020 05:33:22 -0400
X-MC-Unique: h6_DBesrN_S-QfWACWB92g-1
Received: by mail-lj1-f199.google.com with SMTP id l20so4266236lje.2
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 02:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moheTi8kxyiojWZTDDmmqtPwWZqDhE7Ej06fRSEXJt4=;
        b=nyOAWOfnV9IvD9GDugHtulPka1Q3Wbdipiv56BGXOJeK4beKEj0c0iFj2EXLHSOWFz
         lcs4s01d2Jv96GtAJ7XKgq7Ji14vyfe/yGTJHg7p1QoI2e6DG1d33GAoxpofrMbPlIRU
         i5nr+zHbCWzwgC91pH9kyzWX0bGJhoroO+WYHaZXc/+cIdFwYKnVVGmfSiZzXMixtbXL
         mTPuBJlg+IcHPoCTL8xPh22AD06hZPCp7pqU1arIojCnFV1fLu3oD3iNrQibHubiJuvP
         4frY0yGdHLJBXRtEj2/Bq/cEgxm883R2C39LMya0GiNPnP8qrPky1WmqKJXMnIV1JU5j
         kM5w==
X-Gm-Message-State: AOAM530KitAF4ZQvV8Jq2vryFy/MDLcVqnx0ryMfIpL2t2a5KDfWI5v1
        ubppg5SqDQ9KkaXN8TV+j0eJMBEviCPblEkTVHX0Gzec/kOVBODeUmSU2KZjBXstdwJDGuHTQLf
        7aQXVXitzPmqxxAqOfTkXxI+XFFeEZF5Uqw==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr7385552ljo.217.1595151200984;
        Sun, 19 Jul 2020 02:33:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkMFrjAPlQ5zQ6LrwB1869Tjdl/zr/yLGnfoqXxVLp8jGjW+y/zy7pgbiBFFmueySCHQ/r3Ni9+n8XJhVt/5k=
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr7385545ljo.217.1595151200722;
 Sun, 19 Jul 2020 02:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200717114804.762125-1-omosnace@redhat.com>
In-Reply-To: <20200717114804.762125-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sun, 19 Jul 2020 11:33:09 +0200
Message-ID: <CAFqZXNtWyC0Ehr_SSSpHAbwfhAmGrLaOTtGQb8cPNBUr9CuJyQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] userspace: Implement new format of filename trans rules
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 17, 2020 at 1:48 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> These patches are the userspace side of the kernel change posted at [1].
>
> The first patch changes libsepol's internal representation of filename
> transition rules in a way similar to kernel commit c3a276111ea2
> ("selinux: optimize storage of filename transitions") [2].
>
> The second patch then builds upon that and implements reading and
> writing of a new binary policy format that uses this representation also
> in the data layout.
>
> See individual patches for more details.
>
> NOTE: This series unfortunately breaks the build of setools. Moreover,
> when an existing build of setools dynamically links against the new
> libsepol, it segfaults. Sadly, there doesn't seem to be a nice way of
> handling this, since setools relies on non-public libsepol policydb
> API/ABI. I have prepared a preliminary patch to adapt setools to these
> changes - I'll open a WIP pull request for it soon...

While testing the setools patch I found some bugs in this series, so
it'll need a respin... I also found bugs in the setools patch itself
so I haven't opened a PR yet. I think I have them all fixed now, so
stay tuned...

>
> See also this discussion about the setools impact:
> https://lore.kernel.org/selinux/daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov/
>
> Changes in v4:
>  - rebased on top of latest master branch
>
> Changes in v3:
>  - fixed the change in dispol.c to match the rest of the code
>  - renamed the helper functions to use the "_compat" suffix rather than
>    "_old" and "_new"
>
> Changes in v2:
>  - fixed counting rules when reading the new policy format
>
> [1] https://lore.kernel.org/selinux/20200327151941.95619-1-omosnace@redhat.com/T/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b
>
> Ondrej Mosnacek (2):
>   libsepol,checkpolicy: optimize storage of filename transitions
>   libsepol: implement POLICYDB_VERSION_COMP_FTRANS
>
>  checkpolicy/policy_define.c                |  52 ++--
>  checkpolicy/test/dispol.c                  |  20 +-
>  libsepol/cil/src/cil_binary.c              |  29 +-
>  libsepol/include/sepol/policydb/policydb.h |  18 +-
>  libsepol/src/expand.c                      |  60 +----
>  libsepol/src/kernel_to_cil.c               |  24 +-
>  libsepol/src/kernel_to_conf.c              |  24 +-
>  libsepol/src/policydb.c                    | 299 +++++++++++++++++----
>  libsepol/src/write.c                       | 101 +++++--
>  9 files changed, 428 insertions(+), 199 deletions(-)
>
> --
> 2.26.2
>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

