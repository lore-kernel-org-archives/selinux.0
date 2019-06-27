Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBA9C4321A
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 23:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD762086D
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 23:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfF0XRi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:17:38 -0400
Received: from namei.org ([65.99.196.166]:49360 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfF0XRi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 27 Jun 2019 19:17:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5RNGpVR001878;
        Thu, 27 Jun 2019 23:16:51 GMT
Date:   Thu, 27 Jun 2019 16:16:51 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     John Johansen <john.johansen@canonical.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
In-Reply-To: <f5552cb8-1d6c-eb07-be4d-c85e0722c1fa@canonical.com>
Message-ID: <alpine.LRH.2.21.1906271614490.1670@namei.org>
References: <20190626192234.11725-1-casey@schaufler-ca.com> <f5552cb8-1d6c-eb07-be4d-c85e0722c1fa@canonical.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 27 Jun 2019, John Johansen wrote:

> I have more test combinations churning but figure I could report what I have so far

Do you have any way to test the nested scenario of say an AppArmor host 
with SELinux running in containers?

-- 
James Morris
<jmorris@namei.org>

