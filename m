Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1610EC3F68F
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 05:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB73B206E0
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 05:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLJFjp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:39:45 -0500
Received: from namei.org ([65.99.196.166]:36806 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfLJFjp (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 10 Dec 2019 00:39:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xBA5dVTh028798;
        Tue, 10 Dec 2019 05:39:31 GMT
Date:   Tue, 10 Dec 2019 16:39:31 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-next@vger.kernel.org, sds@tycho.nsa.gov,
        jamorris@linux.microsoft.com
Subject: Re: [RFC PATCH] security: add an interface to lookup the lockdown
 reason
In-Reply-To: <157594493094.748324.9234611948545428995.stgit@chester>
Message-ID: <alpine.LRH.2.21.1912101639140.28773@namei.org>
References: <157594493094.748324.9234611948545428995.stgit@chester>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 9 Dec 2019, Paul Moore wrote:

> With CONFIG_AUDIT enabled but CONFIG_SECURITY disabled we run into
> a problem where the lockdown reason table is missing.  This patch
> attempts to fix this by hiding the table behind a lookup function.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>

-- 
James Morris
<jmorris@namei.org>

