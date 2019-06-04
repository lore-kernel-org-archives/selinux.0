Return-Path: <SRS0=onaf=UD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C920BC282CE
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 20:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A692D207E0
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFDUm3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:42:29 -0400
Received: from namei.org ([65.99.196.166]:36780 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfFDUm2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 4 Jun 2019 16:42:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x54KgCIO031551;
        Tue, 4 Jun 2019 20:42:12 GMT
Date:   Wed, 5 Jun 2019 06:42:12 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
In-Reply-To: <a493956a-8a2f-6239-e5fe-09030640c397@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1906050638550.31292@namei.org>
References: <20190602165101.25079-1-casey@schaufler-ca.com> <f71388e9-a4c5-8935-137b-8eb50be7f833@tycho.nsa.gov> <66a87b0b-b6f4-74ff-2e51-afc8e2d30de1@schaufler-ca.com> <2a9049a7-6259-5ae0-2790-0aaf337c51a4@tycho.nsa.gov>
 <a493956a-8a2f-6239-e5fe-09030640c397@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 4 Jun 2019, Casey Schaufler wrote:

> > It isn't free so there should be a cost/benefit analysis.
> 
> Some benchmarking is definitely in order, but most
> of what's you're calling out as downside is hypothetical
> or based on assumption. 

When you're proposing changes such as these, which make fundamental and 
far-reaching changes, the burden is on you to present the cost/benefit 
analysis.

You can't just say "Here are some changes and here are the benefits, and 
any possible costs are merely hypothetical".


-- 
James Morris
<jmorris@namei.org>

