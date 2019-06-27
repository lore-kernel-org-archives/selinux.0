Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C02C48BE4
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 18:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0412064A
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 18:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF0SKj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:10:39 -0400
Received: from namei.org ([65.99.196.166]:49178 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfF0SKj (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 27 Jun 2019 14:10:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5RIAPrO018848;
        Thu, 27 Jun 2019 18:10:25 GMT
Date:   Fri, 28 Jun 2019 04:10:25 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
In-Reply-To: <201906271006.57DE3C2@keescook>
Message-ID: <alpine.LRH.2.21.1906280409410.17363@namei.org>
References: <20190626192234.11725-1-casey@schaufler-ca.com> <alpine.LRH.2.21.1906271230490.12379@namei.org> <alpine.LRH.2.21.1906271245210.13254@namei.org> <alpine.LRH.2.21.1906271344480.16512@namei.org> <alpine.LRH.2.21.1906271409460.16512@namei.org>
 <201906271006.57DE3C2@keescook>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 27 Jun 2019, Kees Cook wrote:

> On Thu, Jun 27, 2019 at 02:10:18PM +1000, James Morris wrote:
> > On Thu, 27 Jun 2019, James Morris wrote:
> > 
> > > Confirming there's no oops when Tomoyo is un-selected in the kernel 
> > > config.
> > 
> > n/m, the problem is still there.
> 
> Were you able to test my fix for this? I wonder if what I found was just
> a coincidence.

Seems to have fixed the oops I was seeing.


diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 4adf4d4a954b..e76dbeee979b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2875,7 +2875,7 @@ static void binder_transaction(struct binder_proc *proc,
        binder_size_t last_fixup_min_off = 0;
        struct binder_context *context = proc->context;
        int t_debug_id = atomic_inc_return(&binder_last_id);
-       struct lsmcontext lsmctx;
+       struct lsmcontext lsmctx = {};
 
        e = binder_transaction_log_add(&binder_transaction_log);
        e->debug_id = t_debug_id;


-- 
James Morris
<jmorris@namei.org>

