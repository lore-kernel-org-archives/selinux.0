Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C85BC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C1120881
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 15:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfEJPv7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 11:51:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfEJPv7 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 10 May 2019 11:51:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46895307EA81;
        Fri, 10 May 2019 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B78AB1FC;
        Fri, 10 May 2019 15:51:56 +0000 (UTC)
Message-ID: <8edfb95424cdf4bac06adbeb6b4204e5cc86f643.camel@redhat.com>
Subject: Re: [PATCH v2] selinux: do not report error on connect(AF_UNSPEC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Tom Deseyn <tdeseyn@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Date:   Fri, 10 May 2019 17:51:55 +0200
In-Reply-To: <CAHC9VhRCdSPB8LuFTtBjLqrZAc3h8UsDJPJnYnMZmU3x_zWkTQ@mail.gmail.com>
References: <34870696b95f9cf48b5436df46e27dddd054858c.1557492319.git.pabeni@redhat.com>
         <CAHC9VhRCdSPB8LuFTtBjLqrZAc3h8UsDJPJnYnMZmU3x_zWkTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 10 May 2019 15:51:59 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2019-05-10 at 11:32 -0400, Paul Moore wrote:
> On Fri, May 10, 2019 at 9:49 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > calling connect(AF_UNSPEC) on an already connected TCP socket is an
> > established way to disconnect() such socket. After commit 68741a8adab9
> > ("selinux: Fix ltp test connect-syscall failure") it no longer works
> > and, in the above scenario connect() fails with EAFNOSUPPORT.
> > 
> > Fix the above skipping the checks when the address family is not
> > AF_INET{4,6} - we don't have any port to validate, but leave the
> > SCTP code path untouched, as it has specific constraints.
> > 
> > Fixes: 68741a8adab9 ("selinux: Fix ltp test connect-syscall failure")
> > Reported-by: Tom Deseyn <tdeseyn@redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> >  - avoid validation for AF_UNSPEC
> > ---
> >  security/selinux/hooks.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> What was wrong with explicitly checking for AF_UNSPEC as I mentioned
> in my last email?

Whoops sorry, I missed a relevant part of that email.

Reading it now.

To me, the 2 options look quite similar, and I have a slighter
preference for this one, being a smaller change possibly more suited to
a stable fix.

But if you have strong different opinions I can post the code you
suggested. I don't see any performance related issue with that.

Cheers,

Paolo


