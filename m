Return-Path: <SRS0=o61S=RE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292B6C43381
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C272084D
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 14:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfCAOPM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:15:12 -0500
Received: from mail.emypeople.net ([216.220.167.73]:38441 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfCAOPM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Mar 2019 09:15:12 -0500
X-Greylist: delayed 729 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Mar 2019 09:15:11 EST
Received: from Shop7 ([166.182.241.52])
        by mail.emypeople.net (12.1.1 build 4 DEB9 x64) with ASMTP id 201903010903002836;
        Fri, 01 Mar 2019 09:03:00 -0500
From:   "Edwin Zimmerman" <edwin@211mainstreet.net>
To:     "'Casey Schaufler'" <casey@schaufler-ca.com>, <jmorris@namei.org>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>
Cc:     <keescook@chromium.org>, <john.johansen@canonical.com>,
        <penguin-kernel@i-love.sakura.ne.jp>, <paul@paul-moore.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com> <20190228221933.2551-2-casey@schaufler-ca.com>
In-Reply-To: <20190228221933.2551-2-casey@schaufler-ca.com>
Subject: RE: [PATCH 01/97] LSM: Infrastructure management of the superblock
Date:   Fri, 1 Mar 2019 09:02:38 -0500
Message-ID: <000701d4d037$6e9d7aa0$4bd86fe0$@211mainstreet.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQHLxLo4sMohEqs1TC+P/+0SYu7cuwGh7BtmpfvR3OA=
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thursday2/28/2019 Casey Schaufler <casey@schaufler-ca.com> wrote:
> From: Casey Schaufler <cschaufler@localhost.localdomain>
> 
> Move management of the superblock->sb_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> 

...
> @@ -296,12 +297,13 @@ static void __init ordered_lsm_init(void)
>  	for (lsm = ordered_lsms; *lsm; lsm++)
>  		prepare_lsm(*lsm);
> 
> -	init_debug("cred blob size     = %d\n", blob_sizes.lbs_cred);
> -	init_debug("file blob size     = %d\n", blob_sizes.lbs_file);
> -	init_debug("inode blob size    = %d\n", blob_sizes.lbs_inode);
> -	init_debug("ipc blob size      = %d\n", blob_sizes.lbs_ipc);
> -	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
> -	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
> +	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
> +	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
> +	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
> +	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
> +	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
> +	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> +	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
> 
Any reason this couldn't be a single line, or am I missing something?  
It took a second look to realize that the only line actually being added was 
+	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);


