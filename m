Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362AAC432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 22:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43361206E5
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 22:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfKMWD3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:03:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39257 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKMWD3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 17:03:29 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iV0jA-0007G8-2J; Wed, 13 Nov 2019 23:03:04 +0100
Date:   Wed, 13 Nov 2019 23:03:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     y2038@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 20/23] y2038: move itimer reset into itimer.c
In-Reply-To: <20191108211323.1806194-11-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1911132301110.2507@nanos.tec.linutronix.de>
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-11-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 8 Nov 2019, Arnd Bergmann wrote:

> Preparing for a change to the itimer internals, stop using the
> do_setitimer() symbol and instead use a new higher-level interface.
> 
> The do_getitimer()/do_setitimer functions can now be made static,
> allowing the compiler to potentially produce better object code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


