Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F23EC4332F
	for <selinux@archiver.kernel.org>; Fri,  7 Oct 2022 08:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiJGIyY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Oct 2022 04:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJGIyM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Oct 2022 04:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB25E1162C8
        for <selinux@vger.kernel.org>; Fri,  7 Oct 2022 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665132850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=56AI6wzQuRL/bITHxI7XEdJFNlbdvBKgvwplo9YYYo8=;
        b=FY0aZBui2PA0FoAr7tpOj5Gp1coplUFZYGHRuSX/3uYC/Q/IBwrreh2lO7S3JtrPs6f0kn
        yAzgcsAZ0WhG6BRUeEANbO3taUusHHJsbnkQ+aKjoFnySAx5tK0LcPwqEmWvASfLA9u50u
        WVL9W4Z9E8wNWUKCIEt3dXLZqpNCY1g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-Xv6YU7cwNyOTjaDtmj_4qg-1; Fri, 07 Oct 2022 04:54:07 -0400
X-MC-Unique: Xv6YU7cwNyOTjaDtmj_4qg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 149A7185A7A3;
        Fri,  7 Oct 2022 08:54:07 +0000 (UTC)
Received: from localhost (unknown [10.40.194.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB18D40C947B;
        Fri,  7 Oct 2022 08:54:06 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: unnecessary log output in selinux_status_updated
Date:   Fri, 07 Oct 2022 10:54:05 +0200
Message-ID: <87ilkwxbde.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,


Commit 05bdc03130d74 ("libselinux: use kernel status page by default") changed
selinux_status_updated() so that it calls avc_process_policyload() and
avc_process_setenforce() and both functions call avc_log() and avc_log() logs to
stderr by default. So when a process like `rpm` checks whether there was a
change, it gets output on stderr which previously wasn't there.


Before this change:
>>> from selinux import *
>>> selinux_status_open(0);
0
>>> 
>>> selinux_status_updated();
0
>>> selinux_mkload_policy(0);
0
>>> selinux_status_updated();
1

Current version:
>>> from selinux import *
elinux_status_updated();
selinux_mkload_policy(0);
selinux_status_updated();
>>> selinux_status_open(0);
0
>>> selinux_status_updated();
0
>>> selinux_mkload_policy(0);
0
>>> selinux_status_updated();
uavc:  op=load_policy lsm=selinux seqno=2 res=11


The calling process could set its callback but it seems unnecessarily
complicated just for selinux_status_updated() which is supposed to check whether
something has changed or not. Also processing events in this function seems to
be unnecessary.

It looks like the reason for the new code added to selinux_status_updated() is
that there were several avc_netlink_check_nb() calls replaced by
selinux_status_updated(). Given the problem described above, I don't think it's
correct and I would like to change selinux_status_updated() back and use another
mechanism that would help with the replacement.


So what do you think about it?


Petr

