Return-Path: <SRS0=wb4z=OV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFDDC65BAF
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 23:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E6220851
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 23:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E6220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLLXir (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:38:47 -0500
Received: from namei.org ([65.99.196.166]:51430 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeLLXir (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 12 Dec 2018 18:38:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBCNZdEC007574;
        Wed, 12 Dec 2018 23:35:39 GMT
Date:   Thu, 13 Dec 2018 10:35:39 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, mszeredi@redhat.com,
        bfields@fieldses.org
Subject: Re: SELinux testsuite failure in overlayfs with v4.20-rc kernels
In-Reply-To: <CAHC9VhTGF3SxRh0iTMhqFYExh3HrKVn7Wnko-_hb+y+6BmCRaQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1812131034330.7515@namei.org>
References: <alpine.LRH.2.21.1812130915190.5053@namei.org> <CAHC9VhTGF3SxRh0iTMhqFYExh3HrKVn7Wnko-_hb+y+6BmCRaQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 12 Dec 2018, Paul Moore wrote:

> This is a known problem, see the archive link below, with Miklos
> promising to send a revert to Linus for v4.20.  I just pinged him
> earlier this week to remind him, but I haven't heard back yet and I
> don't see anything in Linus' tree.

Ahh, looks like the mailing list change meant my mail filters weren't 
separating the SELinux postings out for me and I missed these.

-- 
James Morris
<jmorris@namei.org>

