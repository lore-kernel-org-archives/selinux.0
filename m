Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE4C4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 12:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjKAMjJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 08:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjKAMjJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 08:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3810C
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 05:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698842304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=Vjw8+/diqzeHkHaOIwjy578z/XjhicgesfCHGBANJgU=;
        b=UZ3EE92jHvpcASKDCbV+PLcmeLDppVIZkj7kufmZhVxKBBBQ1j7mU5iTupUVflrIFQX2KQ
        tCFrsMdguiQFRdOD3XxaxSbaSZ0OQNvJwrJdvFKe8vQ4nu4lOyy/pMzzmSrLXrIj3XGZPb
        mhVVaae6o1pNr6UN7slBwfDMoVOBOC8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-cRFa6DDfMO-ZbG-r0EmHBQ-1; Wed,
 01 Nov 2023 08:38:22 -0400
X-MC-Unique: cRFa6DDfMO-ZbG-r0EmHBQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 525943C11CC1
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 12:38:22 +0000 (UTC)
Received: from localhost (unknown [10.45.224.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3129B474FB6
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 12:38:22 +0000 (UTC)
Date:   Wed, 01 Nov 2023 13:38:21 +0100
Message-ID: <f56796460aeb726520d0d954b94683c4.plautrba@redhat.com>
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Subject: SELinux userspace 3.6 release - the current status and plan
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

it's been some time [1] since we released 3.5 so it's time to start with
3.6

[1] https://lore.kernel.org/selinux/87v8auhbr6.fsf@redhat.com/T/#t

Currently we have about 153 merged changes and about 39 changes waiting
for review or to be merged.

You can see waiting queue at

https://patchwork.kernel.org/project/selinux/list/?series=&submitter=&state=&q=&archive=&delegate=82149

# Series: 

## [RFC,1/9] libselinux: annotate interfaces with compiler attributes 

https://patchwork.kernel.org/project/selinux/list/?series=747047&submitter=&state=*&q=&archive=&delegate=

Given that some patches were already rejected, I guess that the whole set could be considered as rejected as well.

## [1/5] libsepol: free memory on str_read() failures

https://patchwork.kernel.org/project/selinux/list/?series=765423&submitter=&state=*&q=&archive=&delegate=

Based on https://lore.kernel.org/all/CAP+JOzQ-AuM9M3c4ehKYca-eUAOy0wbVGkygkpPkhhSTNaVC-Q@mail.gmail.com/ I've marked them as "not applicable"

## libselinux: rework selabel_file(5) database

https://patchwork.kernel.org/project/selinux/list/?series=775966&submitter=&state=*&q=&archive=&delegate=

Given that the majority was already accepted/merged, the rest could be considered as rejected.
If there's no objection I'll mark them before the release.

## [1/5] libsepol: include length squared in hashtab_hash_eval()

https://patchwork.kernel.org/project/selinux/list/?series=776635

no response yet

## CIL Cleanups and Improved Argument handling

https://patchwork.kernel.org/project/selinux/list/?series=788225

There's Reviewed-by and Acked-by attached to the first patch but I guess that it applies to the whole serie.
If it's not merged before the release and there's no other objection, I'll merge it.



The rest are individual patches which are already acked or waiting for review.


# Plan

During this week, I'll prepare update of translations from fedora weblate and I'll prepare pre-release list of highlights for this release.

I'd like to start with rc1 during next week and then do rc releases every other week (14 days)


Please let me know if there's any objection or if you think that we should wait for somethig or if you want to have seomthing in release notes.


Thanks,

Petr






