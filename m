Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C297C433DB
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 02:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3F264EE0
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 02:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhBTC4f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 21:56:35 -0500
Received: from namei.org ([65.99.196.166]:53830 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhBTC4f (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 19 Feb 2021 21:56:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 9011F67;
        Sat, 20 Feb 2021 02:54:04 +0000 (UTC)
Date:   Sat, 20 Feb 2021 13:54:04 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Subject: Re: security_task_getsecid() and subjective vs objective task
 creds
In-Reply-To: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com>
Message-ID: <67cacc61-4d6a-39d5-f2c0-5530e8d1e39@namei.org>
References: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 18 Feb 2021, Paul Moore wrote:

> Hi all,
> 
> When looking into a problem I noticed that audit was recording the
> wrong subject label for a process.

Is this a public bug? It would be good to know what the extent of this 
issue may be and whether it warrants a CVE.

-- 
James Morris
<jmorris@namei.org>

