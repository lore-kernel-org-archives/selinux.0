Return-Path: <SRS0=labB=U7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6282C5B578
	for <selinux@archiver.kernel.org>; Tue,  2 Jul 2019 00:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B374821473
	for <selinux@archiver.kernel.org>; Tue,  2 Jul 2019 00:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGBAtq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:49:46 -0400
Received: from namei.org ([65.99.196.166]:50236 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbfGBAtq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 1 Jul 2019 20:49:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x620nTat025613;
        Tue, 2 Jul 2019 00:49:29 GMT
Date:   Mon, 1 Jul 2019 17:49:29 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Stephen Smalley <stephen.smalley@gmail.com>
cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, keescook@chromium.org,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Fwd: [PATCH v4 15/23] LSM: Specify which LSM to display
In-Reply-To: <CAB9W1A29fCn=cH_Mx-g-P6M-5t+832ayhMmjy3PFZ-BOL3BuDQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1907011745480.13468@namei.org>
References: <20190626192234.11725-1-casey@schaufler-ca.com> <20190626192234.11725-16-casey@schaufler-ca.com> <89561452-86f9-fd9a-1390-0cd4bde1fd62@tycho.nsa.gov> <7944672e-a590-44a3-743a-48c1785a5464@schaufler-ca.com> <CAB9W1A1nwE7WBZqTe-GV8xNb83_B2ybV7cco++nfMjtDz9NJrg@mail.gmail.com>
 <CAB9W1A29fCn=cH_Mx-g-P6M-5t+832ayhMmjy3PFZ-BOL3BuDQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 28 Jun 2019, Stephen Smalley wrote:

> > Balancing backward compatibility with new behavior is hard!
> > What would you suggest for audit logs? Should we put all LSM
> > data in every record? Is NFS a concern for anyone not using
> > SELinux?
> 
> Yes to all on audit if stacking is going to be real.  And yes, I think
> other security modules will care about NFS if they are serious.

Agreed.

There must better way to approach this, somehow...

-- 
James Morris
<jmorris@namei.org>

