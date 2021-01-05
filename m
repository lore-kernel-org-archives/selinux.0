Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE795C433DB
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 10:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8E222515
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 10:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbhAEKmJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 05:42:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728006AbhAEKmI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 05:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609843242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=ro2MPIGkKUMRorivTO3ECRjQ5933i9nVdCBgsrV9pOY=;
        b=UiDWZtLdWFY1NDzT95gXl62b6nk3YP1Xp8eRfCzVgBj26srek2Ma8q0ayvA91ipuBNY5QX
        YtQpQ8dBnInHZfrtIdGicClXca8PiiiHKZNbRKy9HWDX/ZgkFdMWumFGpZ9cb5kH47EBqF
        KQsBQsjBBWB1KTHH0ADbU9KX80/A1Y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-sYkbIQxqPiqem9njMbkIMw-1; Tue, 05 Jan 2021 05:40:39 -0500
X-MC-Unique: sYkbIQxqPiqem9njMbkIMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1859107ACE3
        for <selinux@vger.kernel.org>; Tue,  5 Jan 2021 10:40:38 +0000 (UTC)
Received: from localhost (unknown [10.36.110.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3755B5D9C6
        for <selinux@vger.kernel.org>; Tue,  5 Jan 2021 10:40:38 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Intent to release 3.2-rc1
Date:   Tue, 05 Jan 2021 11:40:37 +0100
Message-ID: <87ft3fhdju.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

It's more than half a year since 3.1-rc1 and more than a year since
3.0-rc1 so I'd like to start with 3.2 release process. If there's no
objection  and no unexpected issues I'd announce 3.2-rc1 release on the
next Wednesday, January 13.

According to patchwork there are several patches not accepted:

https://patchwork.kernel.org/patch/11436955/ New [RFC] libsepol,secilc,policycoreutils: add unprivileged sandboxing capability

without any reaction for a long time


https://patchwork.kernel.org/patch/11668455/ New selinux: make use of variables when defining libdir and includedir

Nicolas raised some concerns and asked for a reproducer, without any
other response.


https://patchwork.kernel.org/patch/11993081/ New [1/6] libsepol: do not decode out-of-bound rolebounds
https://patchwork.kernel.org/patch/11993085/ New [2/6] libsepol: ensure that hashtab_search is not called with a NULL key

I read it as there are some changes requested and therefore need to be updated.


https://patchwork.kernel.org/patch/11993087/ New [3/6] libsepol/cil: constify some strings
https://patchwork.kernel.org/patch/11993089/ New [4/6] libsepol/cil: fix NULL pointer dereference when parsing an improper integer
https://patchwork.kernel.org/patch/11993083/ New [5/6] libsepol/cil: fix out-of-bound read in cil_print_recursive_blockinherit
https://patchwork.kernel.org/patch/11993091/ New [6/6] libsepol/cil: destroy perm_datums when __cil_resolve_perms fails

Ack-ed, probably could be merged.


https://patchwork.kernel.org/patch/11940309
https://github.com/SELinuxProject/selinux/pull/273

The patch on the mailing list is not up to date with the PR and needs to
be resent.


Petr


