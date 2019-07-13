Return-Path: <SRS0=bYD3=VK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B7C742A7
	for <selinux@archiver.kernel.org>; Sat, 13 Jul 2019 04:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EB320830
	for <selinux@archiver.kernel.org>; Sat, 13 Jul 2019 04:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfGMEaQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Jul 2019 00:30:16 -0400
Received: from namei.org ([65.99.196.166]:35038 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfGMEaQ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 13 Jul 2019 00:30:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6D4Tx3e004642;
        Sat, 13 Jul 2019 04:29:59 GMT
Date:   Sat, 13 Jul 2019 14:29:59 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, keescook@chromium.org, serge@hallyn.com,
        john.johansen@canonical.com, mortonm@chromium.org
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
In-Reply-To: <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1907131410310.3804@namei.org>
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov> <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com> <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov> <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 12 Jul 2019, Casey Schaufler wrote:

> I'm not disagreeing with that. What I'm saying is that the capability
> check interface is not the right place to pass that information. The
> capability check has no use for the object information. I would much
> rather see a security_pass_object_data() hook that gets called after
> (or before) the security_capable() hook in the places where you want
> the extra information.

Extending existing security models is a core feature of the LSM framework. 

The Linux capability code has no use for object metadata by design, but 
extending that model to MAC (and other models) via LSM hooks is well 
within scope and of course already happening e.g. mediating Linux 
capabilities wrt SELinux subject types. Adding object metadata extends the 
function of the capability hook along these lines, so that more effective 
MAC policies may be implemented by LSMs.


-- 
James Morris
<jmorris@namei.org>

