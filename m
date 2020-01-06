Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0CCC33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 17:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53FB207FD
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 17:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgAFR3x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:29:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35322 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFR3x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 12:29:53 -0500
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:3aba:f8ff:fe58:9ca1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 97F632911A8;
        Mon,  6 Jan 2020 17:29:51 +0000 (GMT)
Date:   Mon, 6 Jan 2020 17:29:49 +0000
From:   Simon McVittie <smcv@collabora.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH v13 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
Message-ID: <20200106172949.GA80652@horizon>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-24-casey@schaufler-ca.com>
 <cce57d59-8c68-8ef0-b887-0597492e1833@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce57d59-8c68-8ef0-b887-0597492e1833@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 06 Jan 2020 at 12:15:57 -0500, Stephen Smalley wrote:
> On 12/24/19 6:59 PM, Casey Schaufler wrote:
> > The getsockopt SO_PEERSEC provides the LSM based security
> > information for a single module, but for reasons of backward
> > compatibility cannot include the information for multiple
> > modules. A new option SO_PEERCONTEXT is added to report the
> > security "context" of multiple modules using a "compound" format
> > 
> >          lsm1\0value\0lsm2\0value\0
> > 
> > This is expected to be used by system services, including dbus-daemon.
> > The exact format of a compound context has been the subject of
> > considerable debate. This format was suggested by Simon McVittie,
> > a dbus maintainer with a significant stake in the format being
> > usable.
> 
> Since upstream AA does not currently ever set the peer label info, there is
> no need for this support for stacking upstream AA today, and there is no way
> to test this functionality with more than one module present currently in an
> upstream kernel.  Either fix AA to actually implement the functionality so
> it can be tested properly, or drop it from this series please.  I don't
> understand why AA continues to keep this kind of basic and longstanding
> downstream functionality out of tree.

Alternatively, a pair of tiny in-tree or out-of-tree stackable LSMs
that don't make any security decisions, and label every labellable
process/socket/thing with something predictable, would make it really
easy for both kernel and user-space developers to test this and the
user-space code that uses it (D-Bus and others).

For example, they could label process 1234 and all sockets created by
process 1234 with "contexttest1\0pid1234\0contexttest2\0process1234" or
something like that.

I'd love to see AppArmor in upstream kernels support SO_PEERSEC and
SO_PEERCONTEXT, but setting up a development machine to stack AppArmor
and SELinux (and still be able to boot, without one or the other LSM
forbidding something important) seems likely to be harder than setting
it up to load some toy LSMs.

    smcv
