Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB042C433F5
	for <selinux@archiver.kernel.org>; Tue, 29 Mar 2022 16:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbiC2Q62 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiC2Q62 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Mar 2022 12:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16295CD33A
        for <selinux@vger.kernel.org>; Tue, 29 Mar 2022 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648573003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=3lESSn4RozbNkZ53W4f2leybBzQzKKO0ipjzXrsLC8Y=;
        b=hZRdTa8e+O464DF2slGB/nqePHGUzjuy9+Lohhrycb7+04EJ3OP5nhQEQhQMGEyjTmtn6R
        t/RAFsxunWdCANjo2PXrnWRAbsvtPd3VJl06nOhc211ubyWyvSJqzr51LVFobnJD3yVhBt
        FCKnYNNw8jbxjJPzKztsOALmsonwvDs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-lHqoFb3VPsCbI25YTDV-vQ-1; Tue, 29 Mar 2022 12:56:42 -0400
X-MC-Unique: lHqoFb3VPsCbI25YTDV-vQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E197418E5341
        for <selinux@vger.kernel.org>; Tue, 29 Mar 2022 16:56:41 +0000 (UTC)
Received: from localhost (unknown [10.40.193.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7943400E11D
        for <selinux@vger.kernel.org>; Tue, 29 Mar 2022 16:56:40 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Subject: Lets start with 3.4 userspace release
Date:   Tue, 29 Mar 2022 18:56:39 +0200
Message-ID: <87pmm43dfc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

after 142 commits and 5 months since last SELinux userspace release,
it's time to think about another release.

The current backlog of patches is bellow. Please take a look.

This time, I'd like to release rcX every 14 days -
rc1 - 04-06-2022
rc2 - 04-20-2022
...

I'll try send patches with the release number change on Mondays before every
release.


Also when rc1 is out, please consider postponing non-bugfix patches
after the release or provide a comment that the change is not necessary
for this release.



* https://patchwork.kernel.org/patch/12617693/ New [v2] Support static-only builds

- v2 of https://lore.kernel.org/selinux/87lf1scgd6.fsf@alyssa.is/
- waits for another review

* https://patchwork.kernel.org/patch/12639767/ New libsepol: free ebitmap on end of function

* https://patchwork.kernel.org/project/selinux/list/?series=590259 add not-self neverallow support

* https://patchwork.kernel.org/patch/12672523/ New [v2] secilc: kernel policy language is infix

* https://patchwork.kernel.org/project/selinux/list/?series=604679  libsepol: Adding support for not-self rules

* https://patchwork.kernel.org/patch/12718352/ New [libselinux] libselinux: make threadsafe for discover_class_cache

* https://patchwork.kernel.org/patch/12726783/ New libselinux: Prevent cached context giving wrong results

* https://patchwork.kernel.org/project/selinux/list/?series=616731 libsepol: add sepol_av_perm_to_string |

"""
Since most of these functions are used in either checkpolicy or
audit2why (or both), it is probably fine to export these, but I would
appreciate any thoughts that Chris and others might have.
"""

* https://patchwork.kernel.org/patch/12775701/ New libsepol/cil: Write a message when a log message is truncated

* https://patchwork.kernel.org/patch/12780657/ New libsepol: Use calloc when initializing bool_val_to_struct array

* https://patchwork.kernel.org/patch/12783189/ New libsepol: Validate conditional expressions

* https://patchwork.kernel.org/patch/12790631/ New [v3] libsemanage: Fall back to semanage_copy_dir when rename() fails



Petr

