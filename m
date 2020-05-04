Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12E1C3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 08:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C9F24960
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 08:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fINZ0Jo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEDIp2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 04:45:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28053 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727837AbgEDIp1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 04:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588581927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFCB1bnN3Gx6lvzhoyGO2h4ZHniy7YkcoT9A8LT9lUQ=;
        b=fINZ0Jo8gNrdpOOubLWZ6Y/BtIbZFLaLCE0JQ7WESYdoIB4uLKh4Azg5qdcLC32po9WAXn
        +tehQ8ytW4UDv3DqNATUz9GqGWMYcMwTN0AOWkwY4JrjWO2wcBj+6FXvfuVFpJlMWXSR+F
        Be3qXKyjG+lS9ZkpfqdTzMZ86F6QWsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-khkILHTyNP2AuVXMUvXGLQ-1; Mon, 04 May 2020 04:45:20 -0400
X-MC-Unique: khkILHTyNP2AuVXMUvXGLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D97980B714
        for <selinux@vger.kernel.org>; Mon,  4 May 2020 08:45:19 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.195.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94E0B6247F;
        Mon,  4 May 2020 08:45:18 +0000 (UTC)
From:   Richard Filo <rfilo@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Filo <rfilo@redhat.com>
Subject: [PATCH v2] libselinux: Add missing errno setup
Date:   Mon,  4 May 2020 10:45:07 +0200
Message-Id: <20200504084507.92526-1-rfilo@redhat.com>
In-Reply-To: <CAFqZXNvk=UoVRdpk4m4byh-kKU5LUp08C52Nx-MkfcywZ+4rig@mail.gmail.com>
References: <CAFqZXNvk=UoVRdpk4m4byh-kKU5LUp08C52Nx-MkfcywZ+4rig@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Errno is not set to ENOENT when lookup_all() doesn't find any match.

fixes: https://src.fedoraproject.org/tests/selinux/issue/51

Signed-off-by: Richard Filo <rfilo@redhat.com>
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

