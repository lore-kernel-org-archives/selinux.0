Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AC2C43613
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 20:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F072084A
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 20:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFSUI1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:08:27 -0400
Received: from namei.org ([65.99.196.166]:46464 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFSUI0 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 19 Jun 2019 16:08:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5JK83bM026517;
        Wed, 19 Jun 2019 20:08:03 GMT
Date:   Thu, 20 Jun 2019 06:08:03 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v2 00/25] LSM: Module stacking for AppArmor
In-Reply-To: <201906182133.EBF2C78D@keescook>
Message-ID: <alpine.LRH.2.21.1906200555400.25930@namei.org>
References: <20190618230551.7475-1-casey@schaufler-ca.com> <201906182133.EBF2C78D@keescook>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 18 Jun 2019, Kees Cook wrote:

> On Tue, Jun 18, 2019 at 04:05:26PM -0700, Casey Schaufler wrote:
> > Patches 0001-0003 complete the process of moving managment
> > of security blobs that might be shared from the individual
> > modules to the infrastructure.
> 
> I think these are happy stand-alone patches and should just go into the
> common LSM tree for v5.3.

We extended stacking support in March to allow Landlock and SARA to be 
merged and have not seen anything from them since.

Is there any point in adding more of the same for v5.3 before the current 
AppArmor stacking changes are fully ready? This seems to carry risk but no 
concrete benefit for the release.

-- 
James Morris
<jmorris@namei.org>

