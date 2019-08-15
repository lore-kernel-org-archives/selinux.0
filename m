Return-Path: <SRS0=R+7g=WL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505AFC3A589
	for <selinux@archiver.kernel.org>; Thu, 15 Aug 2019 22:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2497E206C1
	for <selinux@archiver.kernel.org>; Thu, 15 Aug 2019 22:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbfHOWcU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:32:20 -0400
Received: from namei.org ([65.99.196.166]:40792 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731768AbfHOWcU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 15 Aug 2019 18:32:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x7FMWCnq026112;
        Thu, 15 Aug 2019 22:32:12 GMT
Date:   Fri, 16 Aug 2019 08:32:12 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
cc:     paul@paul-moore.com, rgb@redhat.com, mortonm@chromium.org,
        john.johansen@canonical.com, selinux@vger.kernel.org,
        luto@amacapital.net, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, nhfran2@tycho.nsa.gov, serge@hallyn.com,
        sds@tycho.nsa.gov
Subject: Re: [RFC PATCH v3] security,capability: pass object information to
 security_capable
In-Reply-To: <20190815202357.4238-1-acgoide@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1908160817300.22623@namei.org>
References: <20190815202357.4238-1-acgoide@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 15 Aug 2019, Aaron Goidel wrote:

> In SELinux this new information is leveraged here to perform an
> additional inode based check for capabilities relevant to inodes. Since
> the inode provided to capable_wrt_inode_uidgid() is a const argument,
> this also required propagating const down to dump_common_audit_data() and
> dropping the use of d_find_alias() to find an alias for the inode. This
> was sketchy to begin with and should be obsoleted by a separate change
> that will allow LSMs to trigger audit collection for all file-related
> information.

Will the audit logs look the same once the 2nd patch is applied? We need 
to be careful about breaking existing userland.


-- 
James Morris
<jmorris@namei.org>

