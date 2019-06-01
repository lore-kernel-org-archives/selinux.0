Return-Path: <SRS0=ThDI=UA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E426AC04AB6
	for <selinux@archiver.kernel.org>; Sat,  1 Jun 2019 02:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0909270AD
	for <selinux@archiver.kernel.org>; Sat,  1 Jun 2019 02:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfFACZl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 22:25:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37646 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfFACZk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 22:25:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hWti3-0004WW-Up; Sat, 01 Jun 2019 02:25:28 +0000
Date:   Sat, 1 Jun 2019 03:25:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v3] selinux: lsm: fix a missing-check bug in
 selinux_sb_eat_lsm_opts()
Message-ID: <20190601022527.GR17978@ZenIV.linux.org.uk>
References: <20190601021526.GA8264@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601021526.GA8264@zhanggen-UX430UQ>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 01, 2019 at 10:15:26AM +0800, Gen Zhang wrote:
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked. And 'mnt_opts' 
> should be freed when error.

What's the latter one for?  On failure we'll get to put_fs_context()
pretty soon, so
        security_free_mnt_opts(&fc->security);
will be called just fine.  Leaving it allocated on failure is fine...
