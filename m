Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F82C48BD6
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 02:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A9C217D9
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 02:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfF0CW3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:22:29 -0400
Received: from namei.org ([65.99.196.166]:48796 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfF0CW3 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 26 Jun 2019 22:22:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5R2MDbj012804;
        Thu, 27 Jun 2019 02:22:13 GMT
Date:   Thu, 27 Jun 2019 12:22:13 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 23/23] AppArmor: Remove the exclusive flag
In-Reply-To: <20190626192234.11725-24-casey@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1906271219450.12379@namei.org>
References: <20190626192234.11725-1-casey@schaufler-ca.com> <20190626192234.11725-24-casey@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 26 Jun 2019, Casey Schaufler wrote:

> With the inclusion of the "display" process attribute
> mechanism AppArmor no longer needs to be treated as an
> "exclusive" security module. Remove the flag that indicates
> it is exclusive. Remove the stub getpeersec_dgram AppArmor
> hook as it has no effect in the single LSM case and
> interferes in the multiple LSM case.

So now if I build a kernel with SELinux and AppArmor selected, with 
SELinux registered first, I now need to use apparmor=0 at the kernel 
command line to preserve existing behavior (just SELinux running).

This should at least be documented.

I wonder if this will break existing users, though.  Who has both 
currently selected and depends on only one of them being active?

-- 
James Morris
<jmorris@namei.org>

