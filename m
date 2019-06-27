Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC4C48BD7
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 03:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B69A20656
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 03:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfF0DuE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:50:04 -0400
Received: from namei.org ([65.99.196.166]:48894 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbfF0DuE (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 26 Jun 2019 23:50:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5R3ntFE016809;
        Thu, 27 Jun 2019 03:49:55 GMT
Date:   Thu, 27 Jun 2019 13:49:55 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     John Johansen <john.johansen@canonical.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v4 23/23] AppArmor: Remove the exclusive flag
In-Reply-To: <d89fbbe9-49cb-646e-6cba-7951cf835bf9@canonical.com>
Message-ID: <alpine.LRH.2.21.1906271347010.16512@namei.org>
References: <20190626192234.11725-1-casey@schaufler-ca.com> <20190626192234.11725-24-casey@schaufler-ca.com> <alpine.LRH.2.21.1906271219450.12379@namei.org> <d89fbbe9-49cb-646e-6cba-7951cf835bf9@canonical.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 26 Jun 2019, John Johansen wrote:

> AppArmor can be built-in (compiled) without being on the Enabled list.
> If you had apparmor in your enabled list along with selinux before,
> it would attempt to enabled and fail with the message
> 
>   exclusive disabled: apparmor
> 
> now it will be enabled but it does match what is documented in
> the lsm enabled description
> 
>     A comma-separated list of LSMs, in initialization order.
>     Any LSMs left off this list will be ignored. This can be
>     controlled at boot with the "lsm=" parameter.

Ok -- I suspect the only people who have SELinux and AppArmor selected are 
doing testing / development.


-- 
James Morris
<jmorris@namei.org>

