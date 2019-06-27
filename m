Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7076C48BD6
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 03:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9228E20989
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 03:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfF0Dpy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:45:54 -0400
Received: from namei.org ([65.99.196.166]:48874 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbfF0Dpy (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 26 Jun 2019 23:45:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5R3jeWo016724;
        Thu, 27 Jun 2019 03:45:40 GMT
Date:   Thu, 27 Jun 2019 13:45:40 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
In-Reply-To: <alpine.LRH.2.21.1906271245210.13254@namei.org>
Message-ID: <alpine.LRH.2.21.1906271344480.16512@namei.org>
References: <20190626192234.11725-1-casey@schaufler-ca.com> <alpine.LRH.2.21.1906271230490.12379@namei.org> <alpine.LRH.2.21.1906271245210.13254@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 27 Jun 2019, James Morris wrote:

> On Thu, 27 Jun 2019, James Morris wrote:
> 
> > On Wed, 26 Jun 2019, Casey Schaufler wrote:
> > 
> > > This patchset provides the changes required for
> > > the AppArmor security module to stack safely with any other.
> > 
> > I get a kernel oops with this patchset when running the SELinux testsuite 
> > (binder test) with:
> > 
> > $ cat /sys/kernel/security/lsm 
> > capability,yama,loadpin,safesetid,selinux,tomoyo

Confirming there's no oops when Tomoyo is un-selected in the kernel 
config.

-- 
James Morris
<jmorris@namei.org>

