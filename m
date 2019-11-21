Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41813C432C3
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 05:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1337420872
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 05:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfKUFgZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:36:25 -0500
Received: from namei.org ([65.99.196.166]:41466 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUFgZ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Nov 2019 00:36:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xAL5a2gx004361;
        Thu, 21 Nov 2019 05:36:02 GMT
Date:   Thu, 21 Nov 2019 16:36:02 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v11 02/25] LSM: Create and manage the lsmblob data
 structure.
In-Reply-To: <20191113175721.2317-3-casey@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1911211632130.3625@namei.org>
References: <20191113175721.2317-1-casey@schaufler-ca.com> <20191113175721.2317-3-casey@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 13 Nov 2019, Casey Schaufler wrote:

> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Hi Casey,

Note that LSM infrastructure changes will need signoffs from the 
maintainers of all major LSMs.

See 
https://lore.kernel.org/linux-security-module/alpine.LRH.2.21.1909060644570.1710@namei.org/

I've set aside some time at the end of this week to take a close look.


-- 
James Morris
<jmorris@namei.org>

