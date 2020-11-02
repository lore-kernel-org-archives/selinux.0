Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536A5C00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 20:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DDC2071A
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 20:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbElYjCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKBUqQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:46:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgKBUp1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 15:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604349926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e8JL1kCZYxRmkY3Cem7dR7dvDx0e4w9xWkpDhlzSwXE=;
        b=gbElYjCnkJBGwy/MWVCnxdNUgz79Kk5w+LgxnHy9VQkH3TAIAHRsD+76P+gMTmhEYNO0AZ
        OPYTro9Sxb9v2mhM7LcrOaE33LAyzgbQifQlSFlZVLaUy8j9/fTuCogtTqGCBk6is4amEE
        58ssSWbWiVuYE5QdppRA0jDfrSh1vN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-zjlv-oLgNSCd1aZnAkzysw-1; Mon, 02 Nov 2020 15:45:24 -0500
X-MC-Unique: zjlv-oLgNSCd1aZnAkzysw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19FCF1006C9E
        for <selinux@vger.kernel.org>; Mon,  2 Nov 2020 20:45:23 +0000 (UTC)
Received: from [10.40.194.21] (unknown [10.40.194.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B03105B4AE
        for <selinux@vger.kernel.org>; Mon,  2 Nov 2020 20:45:22 +0000 (UTC)
To:     selinux@vger.kernel.org
From:   Vit Mojzis <vmojzis@redhat.com>
Subject: homedir file context definitions
Message-ID: <495ea932-98d8-d413-6be3-36b0d5c1e17d@redhat.com>
Date:   Mon, 2 Nov 2020 21:45:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello everyone,
when investigating a bug report [1], I found that homedir context 
definitions (specified in .fc file) are changed based on the 
corresponding user (selinux user, role and mls level from the context 
definition are replaced - [2]).
While replacing the selinux user and role makes sense, I'm wondering if 
the mls level from each homedir context definition should instead be 
compared to corresponding user's mls range (and either kept or replaced 
to ensure given user has access to it).

I have no problem with writing the patch, but I could use help 
understanding what the correct behaviour should be (and why).

Any pointers would be apprecited.

Thank you.


[1] - https://bugzilla.redhat.com/show_bug.cgi?id=1818472
[2] - 
https://github.com/SELinuxProject/selinux/blob/master/libsemanage/src/genhomedircon.c#L638

--

Vit Mojzis
Software Engineer, Platform Security - SELinux userspace
Red Hat, Inc.

