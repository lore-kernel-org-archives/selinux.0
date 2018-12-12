Return-Path: <SRS0=wb4z=OV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7F1C6786C
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E3C2084E
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E3C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeLLWTO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:19:14 -0500
Received: from namei.org ([65.99.196.166]:51376 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbeLLWTO (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Dec 2018 17:19:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBCMIwNl005593;
        Wed, 12 Dec 2018 22:18:58 GMT
Date:   Thu, 13 Dec 2018 09:18:58 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     selinux@vger.kernel.org
cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, mszeredi@redhat.com,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: SELinux testsuite failure in overlayfs with v4.20-rc kernels
Message-ID: <alpine.LRH.2.21.1812130915190.5053@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The SELinux testsuite is failing in the overlayfs tests in current -rc 
kernels. I bisected the issue to

commit 007ea44892e6fa963a0876a979e34890325c64eb
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri Oct 26 23:34:39 2018 +0200

    ovl: relax permission checking on underlying layers
    
    Make permission checking more consistent:
    
     - special files don't need any access check on underling fs
    
     - exec permission check doesn't need to be performed on underlying fs
    
    Reported-by: "J. Bruce Fields" <bfields@fieldses.org>
    Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reverting this commit fixes the testsuite failure.

Is there any more information on the rationale for the change?


-- 
James Morris
<jmorris@namei.org>

