Return-Path: <SRS0=LFc9=SR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9EDC10F0E
	for <selinux@archiver.kernel.org>; Mon, 15 Apr 2019 15:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7A920880
	for <selinux@archiver.kernel.org>; Mon, 15 Apr 2019 15:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfDOPFb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:05:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfDOPFb (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 15 Apr 2019 11:05:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DC1788AAE;
        Mon, 15 Apr 2019 15:05:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id D1F9D19C57;
        Mon, 15 Apr 2019 15:05:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 Apr 2019 17:05:26 +0200 (CEST)
Date:   Mon, 15 Apr 2019 17:05:21 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>, neilb@suse.com,
        Anna.Schumaker@netapp.com, keescook@chromium.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        viro@zeniv.linux.org.uk,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>, yanaijie@huawei.com,
        peterz@infradead.org, mingo@redhat.com,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org
Subject: Re: kernel BUG at kernel/cred.c:434!
Message-ID: <20190415150520.GA13257@redhat.com>
References: <6e4428ca-3da1-a033-08f7-a51e57503989@huawei.com>
 <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 15 Apr 2019 15:05:31 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 04/15, Paul Moore wrote:
>
> On Mon, Apr 15, 2019 at 9:43 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > Well, acct("/proc/self/attr/current") doesn't look like a good idea, but I do
> > not know where should we put the additional check... And probably
> > "echo /proc/self/attr/current > /proc/sys/kernel/core_pattern" can hit the
> > same problem, do_coredump() does override_creds() too.
> >
> > May be just add
> >
> >         if (current->cred != current->real_cred)
> >                 return -EACCES;
> >
> > into proc_pid_attr_write(), I dunno.
>
> Is the problem that do_acct_process() is calling override_creds() and
> the returned/old credentials are being freed before do_acct_process()
> can reinstall the creds via revert_creds()?  Presumably because the
> process accounting is causing the credentials to be replaced?

Afaics, the problem is that do_acct_process() does override_creds() and
then __kernel_write(). Which calls proc_pid_attr_write(), which in turn calls
selinux_setprocattr(), which does another prepare_creds() + commit_creds();
and commit_creds() hits

	BUG_ON(task->cred != old);

Oleg.

