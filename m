Return-Path: <SRS0=VC3m=Y6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A5DC5DF62
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 10:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1265B20869
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 10:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfKFKkj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:40:39 -0500
Received: from namei.org ([65.99.196.166]:57374 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfKFKkj (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Nov 2019 05:40:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xA6AeOsr030674;
        Wed, 6 Nov 2019 10:40:24 GMT
Date:   Wed, 6 Nov 2019 02:40:24 -0800 (PST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH v10 00/25] LSM: Module stacking for AppArmor
In-Reply-To: <19e2696d-ab07-21e5-ba22-4ffdcae3c97c@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1911060238410.30342@namei.org>
References: <20191024205228.6922-1-casey@schaufler-ca.com> <ce6c4861-2767-89ab-bad5-f633a67b3fc9@tycho.nsa.gov> <19e2696d-ab07-21e5-ba22-4ffdcae3c97c@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-726966886-1573036767=:30342"
Content-ID: <alpine.LRH.2.21.1911060239530.30342@namei.org>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-726966886-1573036767=:30342
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.21.1911060239531.30342@namei.org>

On Tue, 29 Oct 2019, Casey Schaufler wrote:

> > Can you re-base on something more recent than v5.1-rc2 (that's the base for that branch currently)?
> > At present it won't even boot for me on modern Fedora.  Two key missing commits are:
> 
> Sigh. It's based on James' next-general. As it's going up through James,
> and he hasn't updated that branch, I'm sort of stuck. BTW, I have a re-based
> version, but don't see how to get it into my git tree without mucking up
> the eventual merge.

Don't use next-general for this. Use the most recent released kernel if 
that works.

-- 
James Morris
<jmorris@namei.org>

--1665246916-726966886-1573036767=:30342--
