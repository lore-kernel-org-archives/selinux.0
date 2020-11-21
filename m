Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEDAC56201
	for <selinux@archiver.kernel.org>; Sat, 21 Nov 2020 02:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CC824124
	for <selinux@archiver.kernel.org>; Sat, 21 Nov 2020 02:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgKUCFf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Nov 2020 21:05:35 -0500
Received: from namei.org ([65.99.196.166]:54684 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgKUCFf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 20 Nov 2020 21:05:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AL25Nup018866;
        Sat, 21 Nov 2020 02:05:23 GMT
Date:   Sat, 21 Nov 2020 13:05:23 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com,
        tyhicks@linux.microsoft.com, sashal@kernel.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v6 8/8] selinux: measure state and hash of the policy
 using IMA
In-Reply-To: <20201119232611.30114-9-tusharsu@linux.microsoft.com>
Message-ID: <alpine.LRH.2.21.2011211301340.18334@namei.org>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com> <20201119232611.30114-9-tusharsu@linux.microsoft.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 19 Nov 2020, Tushar Sugandhi wrote:

> an impact on the security guarantees provided by SELinux. Measuring
> such in-memory data structures through IMA subsystem provides a secure
> way for a remote attestation service to know the state of the system
> and also the runtime changes in the state of the system.

I think we need better clarity on the security model here than just "a 
secure way...".  Secure how and against what threats?

This looks to me like configuration assurance, i.e. you just want to know 
that systems have been configured correctly, not to detect a competent 
attack. Is that correct?



-- 
James Morris
<jmorris@namei.org>

