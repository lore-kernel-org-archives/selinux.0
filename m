Return-Path: <SRS0=bYD3=VK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9DAC742D7
	for <selinux@archiver.kernel.org>; Sat, 13 Jul 2019 04:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAC020830
	for <selinux@archiver.kernel.org>; Sat, 13 Jul 2019 04:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfGMEfx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Jul 2019 00:35:53 -0400
Received: from namei.org ([65.99.196.166]:35054 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfGMEfx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 13 Jul 2019 00:35:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6D4Zi8o004729;
        Sat, 13 Jul 2019 04:35:44 GMT
Date:   Sat, 13 Jul 2019 14:35:44 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, keescook@chromium.org, serge@hallyn.com,
        john.johansen@canonical.com, mortonm@chromium.org
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
In-Reply-To: <4fb3a599-b1d8-7cc2-759a-02195251e344@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1907131430030.3804@namei.org>
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov> <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com> <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov> <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
 <4fb3a599-b1d8-7cc2-759a-02195251e344@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 12 Jul 2019, Stephen Smalley wrote:

> > > If we want to apply least privilege, then this is a desirable facility.
> > 
> > The capability mechanism is object agnostic by design.
> 
> Some might argue that's a flawed design.

Narrator: it's a flawed design.

> > > I understand that doesn't mesh with Smack's mental modelbut it would
> > > probably be useful to both SELinux and AppArmor, among others.
> > 
> > I'm perfectly happy to have the information transmitted.
> > I think a separate interface for doing so is appropriate.
> 
> As above, I don't see any way to do that that isn't just adding overhead.
> 

Agreed, and even so, part of the point of LSM is to allow existing 
security models to be extended to meet a wider range of security 
requirements.

-- 
James Morris
<jmorris@namei.org>

