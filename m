Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9075C56201
	for <selinux@archiver.kernel.org>; Tue, 24 Nov 2020 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784D72076E
	for <selinux@archiver.kernel.org>; Tue, 24 Nov 2020 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1MQUUOxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbgKXOa0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbgKXOaZ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 24 Nov 2020 09:30:25 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836272076E;
        Tue, 24 Nov 2020 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606228225;
        bh=uq59WG7ZPGDif8JA0kcD8nAYX1wkpEsRc/NNVO2uRBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1MQUUOxF1aaSXZ6/3Td8TtXcM2d0XKYPZpTSPQR2Cfaq5d1ny3sSG0ZGdVPN8J6Ka
         cD4c3lghDP7BoAe69T4xnZGmawTzKKRlGcZenH1exqGYq3N/LHA7SO86q8faSq0vGs
         opcWUrsgI8btZ0WBzNKTBLZdDJWhkkACaJsOEH6s=
Date:   Tue, 24 Nov 2020 08:30:40 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 053/141] selinux: Fix fall-through warnings for Clang
Message-ID: <20201124143040.GB16084@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <c543804fee333ba315ddf4056ceed79f94e10d19.1605896059.git.gustavoars@kernel.org>
 <CAHC9VhTFUmRrabTytCyXPtFwb-uVLTgWmgxSkhpy5zjFkcacrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTFUmRrabTytCyXPtFwb-uVLTgWmgxSkhpy5zjFkcacrQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 23, 2020 at 06:31:52PM -0500, Paul Moore wrote:
> On Fri, Nov 20, 2020 at 1:32 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  security/selinux/hooks.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Merged into selinux/next, thanks.

Thanks, Paul.
--
Gustavo
