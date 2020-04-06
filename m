Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4950C2BA19
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 14:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A446523B44
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 14:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUVQjcY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgDFOQq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:16:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20389 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728591AbgDFOQp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 10:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586182604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5QHUdyA6EGZqOqtb0YatXKrsVwhMEXCKcgqnvY6+xTM=;
        b=jUVQjcY05oKQbBE2/uM0MW+IjSjrC+sLlSysuxv1b6BOgo3sA3hB0nVzX5pu7n8NH5D8NN
        ucCXDw186mJShWlXkOek1vIRas33QW0mbXLxbxkgI8G3hVjWmVw/n9EnnZJzmwdDbJZsVp
        nibR3Pqrg9AlOD1hV4FzkYFQrjbzThc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-xGOEcLQINxuupjUuuxJOzg-1; Mon, 06 Apr 2020 10:16:26 -0400
X-MC-Unique: xGOEcLQINxuupjUuuxJOzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D48AFB7480F
        for <selinux@vger.kernel.org>; Mon,  6 Apr 2020 14:16:16 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.196.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DC81119581
        for <selinux@vger.kernel.org>; Mon,  6 Apr 2020 14:16:16 +0000 (UTC)
From:   Richard Filo <rfilo@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: Add missing errno setup
Date:   Mon,  6 Apr 2020 16:16:04 +0200
Message-Id: <20200406141604.69308-1-rfilo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

fixes: https://src.fedoraproject.org/tests/selinux/issue/51

Errno is not set to ENOENT when lookup_all() doesn't find any match.
---
 libselinux/src/label_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 300625c2..113bb9b7 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -948,6 +948,8 @@ static const struct spec **lookup_all(struct selabel_=
handle *rec,
 			goto finish;
 		}
 	}
+	if (result && !result[0])=20
+		errno =3D ENOENT;
=20
 finish:
 	free(clean_key);
--=20
2.25.2

