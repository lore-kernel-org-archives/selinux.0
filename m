Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24C7C432C3
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 20:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D1F2068D
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 20:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUUhM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:37:12 -0500
Received: from namei.org ([65.99.196.166]:41724 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfKUUhM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Nov 2019 15:37:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xALKatnY001847;
        Thu, 21 Nov 2019 20:36:55 GMT
Date:   Fri, 22 Nov 2019 07:36:55 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     John Johansen <john.johansen@canonical.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v11 18/25] LSM: security_secid_to_secctx in netlink
 netfilter
In-Reply-To: <d2b3065d-c8b7-4d77-c447-5ae81ba9b27c@canonical.com>
Message-ID: <alpine.LRH.2.21.1911220734260.30841@namei.org>
References: <20191113182506.2580-1-casey@schaufler-ca.com> <20191113182506.2580-2-casey@schaufler-ca.com> <d2b3065d-c8b7-4d77-c447-5ae81ba9b27c@canonical.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 21 Nov 2019, John Johansen wrote:

> On 11/13/19 10:24 AM, Casey Schaufler wrote:
> > Change netlink netfilter interfaces to use lsmcontext
> > pointers, and remove scaffolding.
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > cc: netdev@vger.kernel.org
> 
> Acked-by: John Johansen <john.johansen@canonical.com>

Just to clarify, you don't need to ack if you've already added a 
reviewed-by, I just want to make sure all of the patches have some kind of 
signoff.

-- 
James Morris
<jmorris@namei.org>

