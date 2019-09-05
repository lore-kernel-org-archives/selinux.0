Return-Path: <SRS0=j8XY=XA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84878C43331
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 20:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F58B206BB
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 20:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfIEUzl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:55:41 -0400
Received: from namei.org ([65.99.196.166]:42760 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfIEUzl (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 5 Sep 2019 16:55:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x85KtRe6002717;
        Thu, 5 Sep 2019 20:55:27 GMT
Date:   Fri, 6 Sep 2019 06:55:27 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
cc:     Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] selinux: fix residual uses of current_security() for
 the SELinux blob
In-Reply-To: <b5705661-089a-cb9c-53b5-21b855937638@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1909060644570.1710@namei.org>
References: <20190904143248.7003-1-sds@tycho.nsa.gov> <CAHC9VhTdv2C2MbNb7p-cPAW8ZeY+tmcz1c77qXmvowSxrWbw4g@mail.gmail.com> <b5705661-089a-cb9c-53b5-21b855937638@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 5 Sep 2019, Stephen Smalley wrote:

> For the next and any future rounds of stacking support, I'm hoping we can be a
> bit more rigorous in our code review and testing requirements.

After the 5th iteration of the patchset and with everything having at 
least one trusted reviewer, I did ask the list if there were any 
objections and stated I would otherwise merge to v4.21:

http://kernsec.org/pipermail/linux-security-module-archive/2018-December/010209.html

Regardless, from now I'll also require signoffs from all of the major LSMs 
on these kinds of changes.

I'd have to say I also have concerns about the direction of LSM stacking 
and what its final goal is.  It seems to makes sense to be able to stack 
Apparmor inside SELinux or Smack, so that folk can use AA system 
containers on an SELinux or Smack host.

We've not seen other proposed use-cases for full stacking materialize in a 
sustained and viable manner.

Are there really any beyond AA inside a labeling LSM?  Because if not I 
think this is a reasonable goal state for LSM stacking until we concretely 
know otherwise.


-- 
James Morris
<jmorris@namei.org>

