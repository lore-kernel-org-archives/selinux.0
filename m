Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671F8C48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 01:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E63C61374
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 01:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhFKBrD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 21:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFKBrC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 21:47:02 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8BBC061574
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 18:45:05 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrWEH-006l81-BT; Fri, 11 Jun 2021 01:45:01 +0000
Date:   Fri, 11 Jun 2021 01:45:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/2] selinux: slow_avc_audit has become non-blocking
Message-ID: <YMLAHTAtjdgcvOl4@zeniv-ca.linux.org.uk>
References: <YMI08apUwu1Y7Tc5@zeniv-ca.linux.org.uk>
 <CAHC9VhSo5wPdqyZ2i9rWgZJhRCw3jv7aNuUFZBwJysFpAW7Drg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSo5wPdqyZ2i9rWgZJhRCw3jv7aNuUFZBwJysFpAW7Drg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 10, 2021 at 07:12:15PM -0400, Paul Moore wrote:
> On Thu, Jun 10, 2021 at 11:51 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > [followup to dump_common_audit_data() changes from this winter; in vfs.git#work.audit]
> > Does anybody have objections to the below?
> >
> > From 663a40ab49308b5acaba8a335190fce66e17d969 Mon Sep 17 00:00:00 2001
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > Date: Sat, 16 Jan 2021 15:40:54 -0500
> > Subject: [PATCH 1/2] selinux: slow_avc_audit has become non-blocking
> >
> > dump_common_audit_data() is safe to use under rcu_read_lock() now;
> > no need for AVC_NONBLOCKING and games around it
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  security/selinux/avc.c         | 28 ++++++++--------------------
> >  security/selinux/hooks.c       | 13 ++-----------
> >  security/selinux/include/avc.h |  4 ----
> >  3 files changed, 10 insertions(+), 35 deletions(-)
> 
> This looks okay to me, thanks Al.  If you want to fix patch 2/2 I can
> pull both into selinux/next.

Done and force-pushed into the same branch...  Do you want a formal pull request?
