Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33219C282E3
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0548C205C9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 20:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfDSU1M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:27:12 -0400
Received: from namei.org ([65.99.196.166]:34682 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfDSU1M (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 19 Apr 2019 16:27:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3JKQwu9021817;
        Fri, 19 Apr 2019 20:26:58 GMT
Date:   Sat, 20 Apr 2019 06:26:58 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        cj.chengjian@huawei.com, john.johansen@canonical.com,
        casey@schaufler-ca.com
Subject: Re: [PATCH] proc: prevent changes to overridden credentials
In-Reply-To: <CAHC9VhQKE3Rnbz8qxm0UKNB=GT6xPu-Le=ZZM0_XisOS+v3jKg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1904200626400.21756@namei.org>
References: <155570011247.27135.12509150054846153288.stgit@chester> <CAHC9VhQKE3Rnbz8qxm0UKNB=GT6xPu-Le=ZZM0_XisOS+v3jKg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 19 Apr 2019, Paul Moore wrote:

> On Fri, Apr 19, 2019 at 2:55 PM Paul Moore <paul@paul-moore.com> wrote:
> > Prevent userspace from changing the the /proc/PID/attr values if the
> > task's credentials are currently overriden.  This not only makes sense
> > conceptually, it also prevents some really bizarre error cases caused
> > when trying to commit credentials to a task with overridden
> > credentials.
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: "chengjian (D)" <cj.chengjian@huawei.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  fs/proc/base.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> 
> I sent this to the LSM list as I figure it should probably go via
> James' linux-security tree since it is cross-LSM and doesn't really
> contain any LSM specific code.  That said, if you don't want this
> James let me know and I'll send it via the SELinux tree assuming I can
> get ACKs from John and Casey (this should only affect SELinux,
> AppArmor, and Smack).

This is fine to go via your tree.


Acked-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>

