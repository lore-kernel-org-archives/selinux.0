Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699A9C433EF
	for <selinux@archiver.kernel.org>; Wed,  4 May 2022 12:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349539AbiEDMk1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 May 2022 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349797AbiEDMk0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 May 2022 08:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3AA8329B8
        for <selinux@vger.kernel.org>; Wed,  4 May 2022 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651667807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zwHxMWfONaKxtdNItHlaXryIApp8H7D+ByTpU8g6h1g=;
        b=PQBiE5JsJ4+qLLMt+Z7H0IybPYY5TuV4vp5phL7XX+PNmywxRqRoNa3KmYB/PxX2gNEPAA
        Jj8OaZcy/FCUyg+DN3OsgxYKO58MsREIqlNNPDCMn+tZmee3SMxun6kG0CVMC5ZzDOXtv+
        XqNjeLK1UrsQs0dZSCPxmdboCdXIrDY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-cvsenLf8Mx2kH11J6Rn8rw-1; Wed, 04 May 2022 08:36:46 -0400
X-MC-Unique: cvsenLf8Mx2kH11J6Rn8rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70C8B811E90
        for <selinux@vger.kernel.org>; Wed,  4 May 2022 12:36:46 +0000 (UTC)
Received: from localhost (unknown [10.40.195.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0819AC28101;
        Wed,  4 May 2022 12:36:45 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SELinux List <selinux@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [PATCH v2 0/5] selinux_restorecon(3), setfiles(8): skip
 relabeling errors
In-Reply-To: <20220503082326.11621-1-lersek@redhat.com>
References: <20220503082326.11621-1-lersek@redhat.com>
Date:   Wed, 04 May 2022 14:36:45 +0200
Message-ID: <87pmkt8of6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Laszlo Ersek <lersek@redhat.com> writes:

> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1794518
> v1:       https://lore.kernel.org/selinux/20220428065354.27605-1-lersek@redhat.com/
>
> In version 2, I've picked up Daniel Burgener's R-b for patch#3, and
> moved the new symbol "selinux_restorecon_get_skipped_errors" to section
> LIBSELINUX_3.4 of "libselinux.map" in patch#4, according to Petr's
> feedback.
>
> Please CC me on all replies to the series; I'm not subscribed to the
> SELinux mailing list. ("CONTRIBUTING.md" does not say that subscribing
> is a requirement.)
>
> Cc: "Richard W.M. Jones" <rjones@redhat.com>
> Cc: Petr Lautrbach <plautrba@redhat.com>
>


For all 5

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> Thanks,
> Laszlo
>
> Laszlo Ersek (5):
>   setfiles: fix up inconsistent indentation
>   setfiles: remove useless assignment and comment (after RHBZ#1926386)
>   setfiles: remove useless "iamrestorecon" checks in option parsing
>   selinux_restorecon: introduce SELINUX_RESTORECON_COUNT_ERRORS
>   setfiles: introduce the -C option for distinguishing file tree walk
>     errors
>
>  libselinux/include/selinux/restorecon.h                     | 15 ++++++++
>  libselinux/man/man3/selinux_restorecon.3                    | 22 +++++++++++-
>  libselinux/man/man3/selinux_restorecon_get_skipped_errors.3 | 28 +++++++++++++++
>  libselinux/src/libselinux.map                               |  1 +
>  libselinux/src/selinux_restorecon.c                         | 34 +++++++++++++++---
>  policycoreutils/setfiles/restore.c                          |  8 +++--
>  policycoreutils/setfiles/restore.h                          |  4 ++-
>  policycoreutils/setfiles/setfiles.8                         | 22 ++++++++++++
>  policycoreutils/setfiles/setfiles.c                         | 36 +++++++++-----------
>  9 files changed, 141 insertions(+), 29 deletions(-)
>  create mode 100644 libselinux/man/man3/selinux_restorecon_get_skipped_errors.3
>
>
> base-commit: 2a167d1156578fc29541f6fb60af65452f431aae
> -- 
> 2.19.1.3.g30247aa5d201

