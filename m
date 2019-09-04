Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B508C3A5AB
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3462077B
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 19:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfIDTgI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:36:08 -0400
Received: from namei.org ([65.99.196.166]:42524 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730584AbfIDTgI (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 4 Sep 2019 15:36:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x84JZntZ011134;
        Wed, 4 Sep 2019 19:35:49 GMT
Date:   Thu, 5 Sep 2019 05:35:49 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
cc:     paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [PATCH] selinux: fix residual uses of current_security() for
 the SELinux blob
In-Reply-To: <20190904143248.7003-1-sds@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1909050535360.10775@namei.org>
References: <20190904143248.7003-1-sds@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 4 Sep 2019, Stephen Smalley wrote:

> We need to use selinux_cred() to fetch the SELinux cred blob instead
> of directly using current->security or current_security().  There
> were a couple of lingering uses of current_security() in the SELinux code
> that were apparently missed during the earlier conversions. IIUC, this
> would only manifest as a bug if multiple security modules including
> SELinux are enabled and SELinux is not first in the lsm order. After
> this change, there appear to be no other users of current_security()
> in-tree; perhaps we should remove it altogether.
> 
> Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

