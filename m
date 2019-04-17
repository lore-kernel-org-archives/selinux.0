Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB0CC282DA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CD520663
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfDQQ12 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:27:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfDQQ12 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 17 Apr 2019 12:27:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FA8A2D7F8;
        Wed, 17 Apr 2019 16:27:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id C8504608C1;
        Wed, 17 Apr 2019 16:27:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 17 Apr 2019 18:27:27 +0200 (CEST)
Date:   Wed, 17 Apr 2019 18:27:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: kernel BUG at kernel/cred.c:434!
Message-ID: <20190417162723.GK32622@redhat.com>
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com>
 <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com>
 <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com>
 <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 17 Apr 2019 16:27:28 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 04/17, Paul Moore wrote:
>
> On Wed, Apr 17, 2019 at 10:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > On 04/17, Paul Moore wrote:
> > >
> > > I'm tempted to simply return an error in selinux_setprocattr() if
> > > the task's credentials are not the same as its real_cred;
> >
> > What about other modules? I have no idea what smack_setprocattr() is,
> > but it too does prepare_creds/commit creds.
> >
> > it seems that the simplest workaround should simply add the additional
> > cred == real_cred into proc_pid_attr_write().
>
> Yes, that is simple, but I worry about what other LSMs might want to
> do.  While I believe failing if the effective creds are not the same
> as the real_creds is okay for SELinux (possibly Smack too), I worry
> about what other LSMs may want to do.  After all,
> proc_pid_attr_write() doesn't change the the creds itself, that is
> something the specific LSMs do.

Yes, but if proc_pid_attr_write() is called with cred != real_cred then
something is already wrong?

In fact, I think that something is already wrong if it is not called by
user-space directly. Too late to ask, but why is this /proc/self/attr/
magic not implemented via syscall(s) ?

But, Paul, this is up to you. I don't understand this all even remotely.

Oleg.

