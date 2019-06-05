Return-Path: <SRS0=z8TV=UE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A632C28CC5
	for <selinux@archiver.kernel.org>; Wed,  5 Jun 2019 22:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB5A2067C
	for <selinux@archiver.kernel.org>; Wed,  5 Jun 2019 22:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFEW2u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:28:50 -0400
Received: from namei.org ([65.99.196.166]:37126 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfFEW2t (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 5 Jun 2019 18:28:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x55MSUi9029461;
        Wed, 5 Jun 2019 22:28:30 GMT
Date:   Thu, 6 Jun 2019 08:28:30 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     John Johansen <john.johansen@canonical.com>
cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
In-Reply-To: <c27ef338-e8fc-cf60-41ed-3d74352add3d@canonical.com>
Message-ID: <alpine.LRH.2.21.1906060827410.20895@namei.org>
References: <20190602165101.25079-1-casey@schaufler-ca.com> <f71388e9-a4c5-8935-137b-8eb50be7f833@tycho.nsa.gov> <42fcfaf2-43a9-642e-2e19-282087c3cdb2@canonical.com> <alpine.LRH.2.21.1906051305370.17052@namei.org> <d86c6f89-39c5-bcf6-6491-96963d1113d3@canonical.com>
 <alpine.LRH.2.21.1906060653060.20895@namei.org> <c27ef338-e8fc-cf60-41ed-3d74352add3d@canonical.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 5 Jun 2019, John Johansen wrote:

> This does rely on apparmor doing its own namespacing and bounding. LSM
> stacking just allows us to start doing this with apparmor containers
> on smack and selinux based systems.

Ahh, ok, I thought you were using an LSM stack for each container.


-- 
James Morris
<jmorris@namei.org>

