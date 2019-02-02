Return-Path: <SRS0=QHdN=QJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD83AC282D7
	for <selinux@archiver.kernel.org>; Sat,  2 Feb 2019 09:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97D021479
	for <selinux@archiver.kernel.org>; Sat,  2 Feb 2019 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549098593;
	bh=onIHCCtQ6WUCVtkRjoAn0u5J2IXcpkiVbkKkAUIYko8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0JhIZ2Gnt2UhkXL8YlKacki8a14ZtpdbmRuPWFRIdhqYY6Dp0ZeLT68OML/viqHGr
	 SxoqE8lCAI31VsZzmxv1kkvub5QqcQvpJ34d4QrH4hA8bOos32XmSRlQH+Hjb4z+pX
	 WoDK9AHY+Q9JA/rY9JIwxDD3ZVGlDb+nyEtUzSWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfBBJJx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:09:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBBJJw (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 2 Feb 2019 04:09:52 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE722146E;
        Sat,  2 Feb 2019 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549098592;
        bh=onIHCCtQ6WUCVtkRjoAn0u5J2IXcpkiVbkKkAUIYko8=;
        h=From:To:Cc:Subject:Date:From;
        b=eraYbQFv5fUFGRNaJCxUTYNvxz2dhiwfmxK5Z2yG+C3Y3uyAAFhf/MDGkg3dOC84a
         PICfjPLynmhYQLUGHBhuIle4MPr1dliliMYZIRaCQ2oRxnrWYNQb2NFVzJST3HdqMa
         wzQ1mR2pc/grxpP+JnjGl1KxeLPhkFWPcnz8J3ho=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, selinux@vger.kernel.org,
        paul@paul-moore.com, ddutile@redhat.com
Subject: [PATCH rdma-rc v1 0/4] IB selinux related fixes
Date:   Sat,  2 Feb 2019 11:09:41 +0200
Message-Id: <20190202090945.4106-1-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This is second version of previously sent patch "IB/core: Don't register
MAD agents for LSM notifications", due to the fact that we found extra
things to fix during the review, I grouped that patch together with
other fixes in that area.

Thanks

Daniel Jurgens (4):
  IB/core: Unregister notifier before freeing MAD security
  IB/core: Fix potential memory leak while creating MAD agents
  IB/core: Eliminate a hole in MAD agent struct
  IB/core: Don't register each MAD agent for LSM notifier

 drivers/infiniband/core/core_priv.h |  5 +++
 drivers/infiniband/core/device.c    |  1 +
 drivers/infiniband/core/security.c  | 57 +++++++++++++++++------------
 include/rdma/ib_mad.h               |  5 +--
 4 files changed, 42 insertions(+), 26 deletions(-)

--
2.19.1

