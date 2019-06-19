Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FF2C31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386B62166E
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 14:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="N5G1JCwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfFSO0i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:26:38 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:19193 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfFSO0h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 10:26:37 -0400
X-EEMSG-check-017: 26160598|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Jun 2019 14:26:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560954394; x=1592490394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JMqv287cMHml6bRm7arT0Q0276NIXme7Tj6Rkbe9OR8=;
  b=N5G1JCwe7zgXk7xLNIh9mjgCTv5w3oroWhyVA50aGyrVJwOjbdE/EtSr
   VSPWrD7bkWtRlAZjro2SOFpeuzb7Ilpo3pW679lhyaUxxTH5gg1F1oEQw
   lSC2kNcA4aCgr0fYfjPm7wFeWuxuT/FtNZfuIAXeUzDmCfy8txqOlvxWq
   Z2JZT8ZXkLn85fzXTzZIrqIbWhM4kYTpcWfc0YDrjFtGSThwvRN6ol0u/
   iSBLMYTQtrs5dtqsawaQc0F6Ko6291hNWJz6UYd60jjvg7u5SQDnoikQn
   IbP/w1uENgOEbPaKqGCpYYwaqBgrQFv1afbgIlurE8XdyeWHNLiVRzewX
   A==;
X-IronPort-AV: E=Sophos;i="5.63,392,1557187200"; 
   d="scan'208";a="24901775"
IronPort-PHdr: =?us-ascii?q?9a23=3A65P/Yh86nF8XXv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B32+IcTK2v8tzYMVDF4r011RmVBN+ds6gP17ue8/i5HzBZuNDZ6DFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sBvdutMKjYd8Jao8xR?=
 =?us-ascii?q?/EqWZMd+hK2G9kP12ekwvh6suq4JJv7yFcsO89+sBdVqn3Y742RqFCAjQ8NG?=
 =?us-ascii?q?A16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWT?=
 =?us-ascii?q?Sj9KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjcKzdZ9caTn?=
 =?us-ascii?q?dfUMhXWSJKH4ewY5IBAucFOOpVqZT2qVkTohukHQSiBP3hxCJGiHH12qM13O?=
 =?us-ascii?q?svHBra0AEjBd8CrG7ZoMnpOKoUTOu7zLPIzTLGb/5OxDn99JbHcgghof6SW7?=
 =?us-ascii?q?J7bNffyUw1GAPBilWft4zkNC6S2+QWrmeb9PFtVf6vimE7qwFxpSKjxsE3io?=
 =?us-ascii?q?bTnI4VxVfE9TtgzYszONa2Rkl7Ydu+H5tRsSGXL4V2Td0/TGFvoiY10KUGuY?=
 =?us-ascii?q?S8fCgI1pso2wLfZ+aAc4iS7RLuUvuaLzRghH99Zb6yiBm//VKgx+HhTMW4zl?=
 =?us-ascii?q?lHojRfntXRsH0Gygbd5dKdSvRn+0eswTOP1wfO5e5aOU00jq/bK4I5wr43i5?=
 =?us-ascii?q?oTrVzPHi/ol0Xyi6+bblkk9fKy6+Tmf7XmvYWQN5N0iw7iMqQundazAeIkPQ?=
 =?us-ascii?q?gVQ2eX4+G81Lzn/UHhQbVKiOM5krXBvZzHKskWqbS1Dg9I3oo59RqyACmq3M?=
 =?us-ascii?q?4FkXUfKVJKYhOHj4znO1HUJ/D4CO+yg0+xnzdw3P3GIr3gDYnNLnjEirvhe6?=
 =?us-ascii?q?195FRGxAo8ytBf+YpYCqsdL/LrRk/xqNvYAwchMwOu3ubnDM5w1psEVmKSBq?=
 =?us-ascii?q?+VKabSsViP5uI1PeaAfpMauDH4K/I9/f7hkWc5mUMBfamuxZYXc263HvBnI0?=
 =?us-ascii?q?WffHrtjcwMEXkFvgUgVuzmkl6CXiBJZ3a0Qa084is3CIW8DYfMFciRh+ma0S?=
 =?us-ascii?q?O6GIBGTn5JB0rKEnrycYiAHfAWZ3G8OMhkxwcYWKChRolp7hSnsAv32vIzNe?=
 =?us-ascii?q?bP0jEJvpLkkt5u7qvckg9kpm88NNiUz2zYFzI8pWgPXTJjmfsurA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BBAQCURQpd/wHyM5BmHgEGBwaBVgYLAYFsKmpRATIol?=
 =?us-ascii?q?1UBAQEBAQEGiwiRDAkBAQEBAQEBAQEbEAkBAgEBhECCWiM3Bg4BAwEBAQQBA?=
 =?us-ascii?q?QEBBAEBbIo3DII6KYMgAUaBUYJjPwGBdhQPrEOERkFAgyaBQAaBNIcHhFcXe?=
 =?us-ascii?q?IEHhGGEDYEEhRUEqWUJghOCG4QtjH8MG5czAZRBkVEigVgrCAIYCCEPgnMBM?=
 =?us-ascii?q?4tFhVsjAzCBBgEBjBiCUgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Jun 2019 14:26:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5JEQWtb016043;
        Wed, 19 Jun 2019 10:26:32 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: fix old python shebang in tests/overlay/access
Date:   Wed, 19 Jun 2019 10:26:30 -0400
Message-Id: <20190619142630.26648-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

/usr/bin/python is no longer installed by default, so this test
script fails on default installs.
Best practice guidance appears to be to switch to using
/usr/bin/python3 instead, per
https://docs.fedoraproject.org/en-US/packaging-guidelines/Python/

Fixes: #46
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/overlay/access | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/overlay/access b/tests/overlay/access
index 5a47eb145904..e50d5b402ebd 100755
--- a/tests/overlay/access
+++ b/tests/overlay/access
@@ -1,4 +1,4 @@
-#!/bin/python
+#!/usr/bin/python3
 import os, sys
 try:
         acc=eval("os.%s" % sys.argv[2])
-- 
2.20.1

