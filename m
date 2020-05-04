Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D885C3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 10:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A7F20721
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 10:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BToYWIRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgEDKi6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 06:38:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57646 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDKi5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 06:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588588737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6uUHqCXbhR34VRcdpEaxDFsRtv3nbEV/dajj+1ODZ+A=;
        b=BToYWIRBjJMZIhCcLWg+zySSa+abjt24BI/eaCWBzcE9toJW+zsvqZIpphFvuy+N/plo8r
        s5U5rNOpsodfLnmG9qWEFbpwaJm7eLpvymGNNylneLykNmGNq2I3lPNDIvrBoxRVRuvstO
        GN0GA75w8tZif3Q4YPxXLbEMLm6v3b0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-22DBY48jOlCOdOWvsyYJLA-1; Mon, 04 May 2020 06:38:49 -0400
X-MC-Unique: 22DBY48jOlCOdOWvsyYJLA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 278D5461
        for <selinux@vger.kernel.org>; Mon,  4 May 2020 10:38:48 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.195.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49CFF1002388;
        Mon,  4 May 2020 10:38:47 +0000 (UTC)
From:   Richard Filo <rfilo@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Filo <rfilo@redhat.com>
Subject: [PATCH v3] libselinux: Add missing errno setup
Date:   Mon,  4 May 2020 12:38:42 +0200
Message-Id: <20200504103842.96472-1-rfilo@redhat.com>
In-Reply-To: <CAFqZXNs88P_VeYgO=9nOX1Z2vpPUVgHxTTqyk6Rj-peqhyN-bA@mail.gmail.com>
References: <CAFqZXNs88P_VeYgO=9nOX1Z2vpPUVgHxTTqyk6Rj-peqhyN-bA@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Errno is not set to ENOENT when lookup_all() doesn't find any match.

fixes: https://src.fedoraproject.org/tests/selinux/issue/51

Signed-off-by: Richard Filo <rfilo@redhat.com>
---
	-removed check: result !=3D NULL

 libselinux/src/label_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 300625c2..74d2027e 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -948,6 +948,8 @@ static const struct spec **lookup_all(struct selabel_=
handle *rec,
 			goto finish;
 		}
 	}
+	if (!result[0])=20
+		errno =3D ENOENT;
=20
 finish:
 	free(clean_key);
--=20
2.25.2

