Return-Path: <SRS0=SKFz=ZL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AF2C432C3
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 10:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343AB22309
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 10:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUomKdkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfKSKnh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:43:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24188 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726265AbfKSKnh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Nov 2019 05:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574160216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GfUXk1aCG25ageTWADA5BcDm+bu1bigBFMRVMufLSSc=;
        b=iUomKdkRlUra1yGRFOAYJwzgPAMgFeiT3STHHEoFrsym3SDgVrfzp1RP/e+PihJ07vQuZ5
        fOz765FyrvHp486jVwaSj8sJtcnZ65L+Ixbjj35QpiRYIkThEDLCE+z4JSNIkfKEAP45jK
        bWYFom9pIFiDpQAhz5FFtN1GTqGwOVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-hNtTLflwONmVrCS0YO-8MA-1; Tue, 19 Nov 2019 05:43:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BFD88018A3
        for <selinux@vger.kernel.org>; Tue, 19 Nov 2019 10:43:34 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C82501B425;
        Tue, 19 Nov 2019 10:43:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] Travis-CI: Drop Python 2 from matrix
Date:   Tue, 19 Nov 2019 11:43:26 +0100
Message-Id: <20191119104326.1572146-1-plautrba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: hNtTLflwONmVrCS0YO-8MA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As a result of Python 2 sunset - https://www.python.org/doc/sunset-python-2=
/ -
Python 2 code will not be supported in this project anymore and new Python =
code
should be written only for Python 3.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 .travis.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 7a9e73ce55db..e9f86baa4e6f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -17,10 +17,8 @@ env:
     - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 LINKER=3Dbfd
=20
     # Test several Python versions
-    - PYVER=3Dpython2.7 RUBYLIBVER=3D2.6
     - PYVER=3Dpython3.5 RUBYLIBVER=3D2.6
     - PYVER=3Dpython3.6 RUBYLIBVER=3D2.6
-    - PYVER=3Dpypy2.7-6.0 RUBYLIBVER=3D2.6
     - PYVER=3Dpypy3.5-6.0 RUBYLIBVER=3D2.6
=20
     # Test several Ruby versions (http://rubies.travis-ci.org/)
--=20
2.23.0

