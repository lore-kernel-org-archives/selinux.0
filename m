Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67403C64E90
	for <selinux@archiver.kernel.org>; Mon, 30 Nov 2020 10:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D014B20825
	for <selinux@archiver.kernel.org>; Mon, 30 Nov 2020 10:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDtcDQVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgK3Kkr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Nov 2020 05:40:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbgK3Kkr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Nov 2020 05:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606732761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1JGRx2ehRVzW/MEuZo+PSvIdirMjzvztCuJ+Pj5pD/0=;
        b=VDtcDQVreozAUpyqrgX4jgTJjmnFpZdNK8k9sTK+7ur/g56XJmwfMyxXGCoMwkxHslpcJk
        /d6rYqFpv4gCPvK4Tgh2AOwmeCExgAWdWxk3I+lS2F9bO66wXj+dNNhnScDFiK9w18iMN6
        LdPVkrGromivoVNwFDgMAe7XiGJNEjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-T9rK_1q1MfiKm5mpmDvoMA-1; Mon, 30 Nov 2020 05:39:17 -0500
X-MC-Unique: T9rK_1q1MfiKm5mpmDvoMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCC27100E423
        for <selinux@vger.kernel.org>; Mon, 30 Nov 2020 10:39:16 +0000 (UTC)
Received: from localhost (unknown [10.40.194.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F4EC5C1A1;
        Mon, 30 Nov 2020 10:39:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     kdudka@redhat.com
Subject: review needed - coreutils ported to a newer version of libselinux
Date:   Mon, 30 Nov 2020 11:39:14 +0100
Message-ID: <87k0u3p1rh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Hello,

a week ago I was asked to review coreutils changes which migrated
coreutils from matchpathcon() to selabel_lookup(), see bellow. Sadly I
wasn't able to do it yet so I would really appreciate if somebody can
help with this. I've CCed Kamil who should be answer coreutils related
questions.

Thanks!

quote:

Upstream has ported GNU coreutils to a newer version of libselinux.  Namely,
it uses selabel_lookup() instead of matchpathcon().  They are now asking for
a review by an SELinux expert from Red Hat:

    https://lists.gnu.org/archive/html/coreutils/2020-11/msg00049.html

Could you (or someone from your team) please review the following upstream
commits?

    https://git.savannah.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=v8.32-76-g3aaa42deaa
    https://git.savannah.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=v8.32-79-g7b341f084b
    https://git.savannah.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=v8.32-81-gd12f5da6d4

And there's another follow-up at
    https://lists.gnu.org/archive/html/coreutils/2020-11/msg00054.html


