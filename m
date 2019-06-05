Return-Path: <SRS0=z8TV=UE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32880C28CC5
	for <selinux@archiver.kernel.org>; Wed,  5 Jun 2019 20:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1258A2070B
	for <selinux@archiver.kernel.org>; Wed,  5 Jun 2019 20:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFEUyJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:54:09 -0400
Received: from namei.org ([65.99.196.166]:37090 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfFEUyJ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 5 Jun 2019 16:54:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x55KroJ4021347;
        Wed, 5 Jun 2019 20:53:50 GMT
Date:   Thu, 6 Jun 2019 06:53:50 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     John Johansen <john.johansen@canonical.com>
cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
In-Reply-To: <d86c6f89-39c5-bcf6-6491-96963d1113d3@canonical.com>
Message-ID: <alpine.LRH.2.21.1906060653060.20895@namei.org>
References: <20190602165101.25079-1-casey@schaufler-ca.com> <f71388e9-a4c5-8935-137b-8eb50be7f833@tycho.nsa.gov> <42fcfaf2-43a9-642e-2e19-282087c3cdb2@canonical.com> <alpine.LRH.2.21.1906051305370.17052@namei.org>
 <d86c6f89-39c5-bcf6-6491-96963d1113d3@canonical.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 4 Jun 2019, John Johansen wrote:

> Yes, on Ubuntu & suse you can lauch lxd system containers with the
> container having a system policy bounding the container, and the container
> having its own apparmor policy namespace. So it loads and has its own
> policy that is enforced.
> 
> This allows for us to run older versions of ubuntu (say 16.04) on an
> 18.04 host, and have the 16.04 policy behave just as if it was the host.

How well does the LSM stacking scale to 100s or more containers?

> This approach won't be an option for the 19.10 release and we will be
> needing the full patchset. I should be able to provide some benchmark
> and testing data soon.

Great.

-- 
James Morris <jmorris@namei.org>

