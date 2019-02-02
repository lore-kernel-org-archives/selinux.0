Return-Path: <SRS0=QHdN=QJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9430AC282D7
	for <selinux@archiver.kernel.org>; Sat,  2 Feb 2019 09:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A9021479
	for <selinux@archiver.kernel.org>; Sat,  2 Feb 2019 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549098608;
	bh=oiCWpDW3ZKk7IHqWhCwqDJX9jay5C7U4xCKx3CnbYZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bmo8WdkqWFRiu8UxWY99fouPtdJjh54aEwtHwlZ2ZAFfyAI1+7VoBe4Zqal6wusyD
	 YpsN6Kvmoo3aWNlbd5n1wVJIUsscGIfS5HIudN1cQaaUUaKGhNZY3Pkm+r/HxQ5IOC
	 6ioy6nhOdpuNaZ/m7041qGLGUunm5w5vPFmHTh1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfBBJKI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBBJKH (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 2 Feb 2019 04:10:07 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 311B52146E;
        Sat,  2 Feb 2019 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549098607;
        bh=oiCWpDW3ZKk7IHqWhCwqDJX9jay5C7U4xCKx3CnbYZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gP0dmd1EkUdNZA2/kCeHkbge9hBBkgGjucvSotEbYOoT8eOf1VoxjmWrOdbZ2xpHu
         ee2ZEduixm/n++OoPNpdnJOatO9z5fCLmVIdcwaTPNLGPOvqqO9sFn+PPJPCMM8P6B
         7cQ5rubbxByCrNiidgIw/44EXQgHxbuKa5xUckjU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, selinux@vger.kernel.org,
        paul@paul-moore.com, ddutile@redhat.com
Subject: [PATCH rdma-rc v1 3/4] IB/core: Eliminate a hole in MAD agent struct
Date:   Sat,  2 Feb 2019 11:09:44 +0200
Message-Id: <20190202090945.4106-4-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202090945.4106-1-leon@kernel.org>
References: <20190202090945.4106-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Daniel Jurgens <danielj@mellanox.com>

Move the security related fields above the u8s to eliminate a hole in
the struct.

pahole before:
struct ib_mad_agent {
...
u32                        hi_tid;               /*    48     4 */
u32                        flags;                /*    52     4 */
u8                         port_num;             /*    56     1 */
u8                         rmpp_version;         /*    57     1 */

/* XXX 6 bytes hole, try to pack */

/* --- cacheline 1 boundary (64 bytes) --- */
void *                     security;             /*    64     8 */
bool                       smp_allowed;          /*    72     1 */
bool                       lsm_nb_reg;           /*    73     1 */

/* XXX 6 bytes hole, try to pack */

struct notifier_block      lsm_nb;               /*    80    24 */

/* XXX last struct has 4 bytes of padding */

/* size: 104, cachelines: 2, members: 14 */
...
};

pahole after:
struct ib_mad_agent {
...
u32                        hi_tid;               /*    48     4 */
u32                        flags;                /*    52     4 */
void *                     security;             /*    56     8 */
/* --- cacheline 1 boundary (64 bytes) --- */
struct notifier_block      lsm_nb;               /*    64    24 */

/* XXX last struct has 4 bytes of padding */

u8                         port_num;             /*    88     1 */
u8                         rmpp_version;         /*    89     1 */
bool                       smp_allowed;          /*    90     1 */
bool                       lsm_nb_reg;           /*    91     1 */

/* size: 96, cachelines: 2, members: 14 */
...
};

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/rdma/ib_mad.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index fdef558e3a2d..1c0b914f199d 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -616,12 +616,12 @@ struct ib_mad_agent {
 	void			*context;
 	u32			hi_tid;
 	u32			flags;
+	void			*security;
+	struct notifier_block   lsm_nb;
 	u8			port_num;
 	u8			rmpp_version;
-	void			*security;
 	bool			smp_allowed;
 	bool			lsm_nb_reg;
-	struct notifier_block   lsm_nb;
 };

 /**
--
2.19.1

