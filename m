Return-Path: <SRS0=kuKh=SY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE7C10F11
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 13:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F5220693
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 13:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfDVNYS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:24:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53371 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDVNYR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Apr 2019 09:24:17 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3MDDxu7078424;
        Mon, 22 Apr 2019 22:13:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Mon, 22 Apr 2019 22:13:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157095162.bbtec.net [60.157.95.162])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3MDDxSf078362
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 22 Apr 2019 22:13:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 69/90] LSM: Use full security context in
 security_inode_setsecctx
To:     Casey Schaufler <casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
 <20190419004617.64627-70-casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <04b749f6-097e-4faf-dc87-7892db728e3b@I-love.SAKURA.ne.jp>
Date:   Mon, 22 Apr 2019 22:13:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419004617.64627-70-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2019/04/19 9:45, Casey Schaufler wrote:
> +	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecctx, list) {
> +		if (strncmp(ctx, hp->lsm, strlen(hp->lsm))) {
> +			WARN_ONCE(1, "security_inode_setsecctx form1 error\n");
> +			rc = -EINVAL;
> +			break;
> +		}

Will you avoid using WARN*() ?
Since syzbot tests using panic_on_warn == 1, this WARN_ONCE() will act as panic().
