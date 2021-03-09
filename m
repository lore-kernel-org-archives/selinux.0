Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76822C433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 19:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3412D65243
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 19:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhCITq5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 14:46:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:27368 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhCITqr (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 9 Mar 2021 14:46:47 -0500
IronPort-SDR: My+JZ5CeGu8Om2lbp7pbUom4/BJncPt6OBMIhS8wo+S07HZwePKL7nzGi6aldOvuLYde2T6ZcA
 22Ht76FDk4Dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="185929818"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="185929818"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 11:46:42 -0800
IronPort-SDR: AxQyp0CSpeKmjgegg1rRi7DDWn6V4RWA8fjoj0nsPvsFR5cfR1AJbzJTiTqRDuVHhAVOvBQYfZ
 3uKC2BXCQ8qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="588558665"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2021 11:46:39 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJiJT-0001n3-4t; Tue, 09 Mar 2021 19:46:39 +0000
Date:   Wed, 10 Mar 2021 03:46:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
Subject: [RFC PATCH] LSM: audit_sig_lsm can be static
Message-ID: <20210309194632.GA104254@1cfea093ef28>
References: <20210309144243.12519-13-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309144243.12519-13-casey@schaufler-ca.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 audit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index c061331046956..c32df242a3726 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
-struct lsmblob		audit_sig_lsm;
+static struct lsmblob		audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
