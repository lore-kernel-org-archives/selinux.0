Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ECEC43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 14:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8637820679
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 14:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFVOVX convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 10:21:23 -0400
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:39414 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVOVW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 10:21:22 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jun 2019 10:21:20 EDT
Received: from smtp7.infomaniak.ch (smtp7.infomaniak.ch [83.166.132.30])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x5MEFA5o020020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jun 2019 16:15:10 +0200
Received: from localhost (19.131.134.77.rev.sfr.net [77.134.131.19])
        (authenticated bits=0)
        by smtp7.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x5MEF6KB123947
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 22 Jun 2019 16:15:07 +0200
Date:   Sat, 22 Jun 2019 16:15:05 +0200
In-Reply-To: <201906201029.0476F14A@keescook>
References: <201906201029.0476F14A@keescook>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Stacked LSMs (was Re: [PATCH v2 00/25] LSM: Module stacking for AppArmor)
To:     Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        James Morris <jmorris@namei.org>
CC:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
From:   =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Message-ID: <008DBF7D-C015-49F5-A9FC-032E6A8EC9DB@digikod.net>
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On June 20, 2019 7:33:25 PM GMT+02:00, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Jun 20, 2019 at 06:08:03AM +1000, James Morris wrote:
> > We extended stacking support in March to allow Landlock and SARA to
> be 
> > merged and have not seen anything from them since.
> 
> Salvatore and Mickaël, have you had a chance to look at the stacking
> changes? I'd love to see work progress on your LSMs now that the
> stacking prerequisites have landed.
> 
> Thanks!

Yes, I successfully updated Landlock as a stackable LSM. I also worked on removing some code (and related features, for now) to get smaller patches for the next round, and I tried to get rid of the VFS modifications. I still need to update the tests, rebase a last time and review everything before sending a new patch set, hopefully next week.

 Mickaël
