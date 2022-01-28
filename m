Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF64C433EF
	for <selinux@archiver.kernel.org>; Fri, 28 Jan 2022 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351111AbiA1U3P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jan 2022 15:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232469AbiA1U3O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jan 2022 15:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643401754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/R+jUAO4Zdq+RoAvmdtDhiLJNzkXYPpweQSqLQO/lto=;
        b=S252BAXtS0sbJJY8YKNIH2iT79s7mshMiIOYLq8TktflojWEI/Ya4sWBOgdlbqvETfWsd1
        8pCc51213Tv/YVgJsn58EktZTOD4OSoVLGSozzaBt1O2uiOPLMhnJRumEKcchX6dxQbDsD
        Sm2NZBBxyap6E+ENA28MgPFMjW8IBRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-4fDoml85Pk2hZ_OUQCpw6A-1; Fri, 28 Jan 2022 15:29:10 -0500
X-MC-Unique: 4fDoml85Pk2hZ_OUQCpw6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A7108143E5;
        Fri, 28 Jan 2022 20:29:09 +0000 (UTC)
Received: from vbendel-laptop-2020.redhat.com (unknown [10.40.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0D235E26B;
        Fri, 28 Jan 2022 20:29:06 +0000 (UTC)
From:   vbendel@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>
Subject: [PATCH 0/3] selinux: Fix and clean policydb->cond_list error paths 
Date:   Fri, 28 Jan 2022 21:28:55 +0100
Message-Id: <20220128202858.96935-1-vbendel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There are two users of policydb->cond_list: cond_read_list()
and duplicate_policydb_cond_list(). If any of them gets an error,
usually an -ENOMEM, the error-path-cleanup *_destroy() functions
get called twice: firstly from these two and secondly from
the caller functions' error paths.

In case such -ENOMEM happens while assigning cond_node data, i.e.
while ->cond_list_len is already non-zero, it leads to inappropriate
dereferencing of policydb->cond_list[] data in the second called
cond_list_destroy() from the caller functions' error paths, resulting
with:
- NULL pointer deref from cond_read_list();
- use-after-free + double-free from duplicate_policydb_cond_list().
(the cond_read_list() manages to set ->cond_list to NULL)

Patch 1/3 simply makes the error behavior consistent by always setting
->cond_list to NULL.

Patch 2/3 fixes the actual bug by resetting ->cond_list_len to 0,
so any subsequent cond_list_destroy() calls would become noop.

Patch 3/3 cleans up the duplicate *_destroy calls on these error paths,
albeit it's a bit questionable and I'm looking for feedback on it:
- on one hand the idea is that the caller functions call the *_destroy()
bits anyway, hence removing duplicate efforts (which also fixes the bug,
but I'd still prefer to apply patches 1 and 2 regardless);
- on the other hand it's appropriate and more bug-proof for a function
to clean everything it allocated on error.
Hence I'm looking forward to seeing what approach the upstream would find
more appropriate.

Signed-off-by: Vratislav Bendel <vbendel@redhat.com>


