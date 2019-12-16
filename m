Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43D5C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 18:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AF42067C
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLPS4T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:56:19 -0500
Received: from namei.org ([65.99.196.166]:37810 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfLPS4T (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 16 Dec 2019 13:56:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xBGItriN008699;
        Mon, 16 Dec 2019 18:55:53 GMT
Date:   Tue, 17 Dec 2019 05:55:53 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
In-Reply-To: <CAHC9VhRwPpBAD3vDwTf1q25Qhp-nE_wmPpqdyfsDwpUNS6smrw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1912170555360.7457@namei.org>
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov> <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com> <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov>
 <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com> <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov> <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com> <0f0778af-73c2-3c75-30c0-da5eae203032@tycho.nsa.gov>
 <CAHC9VhT24b6YYTcE-h9pS9HnJ35unW_14EYLcNBBd-xUa=1L9A@mail.gmail.com> <83d047ce-0ca0-4152-1da7-32798c500aab@tycho.nsa.gov> <CAHC9VhQG9zZEL53XRdLHdmFJDpg8qAd9p61Xkm5AdSgM=-5eAg@mail.gmail.com> <83af5f0f-d3ec-7827-92e5-2db0997b9d22@tycho.nsa.gov>
 <CAHC9VhSqNGxqGQU6QfB3SxHZZdtPh79-4vOrpDXLr9zxT_X4bg@mail.gmail.com> <CAFqZXNv7PUgrU9Qe28e3cHnRAwjKZLVmNrOZggvkE5AB7T9o1Q@mail.gmail.com> <CAHC9VhRwPpBAD3vDwTf1q25Qhp-nE_wmPpqdyfsDwpUNS6smrw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 13 Dec 2019, Paul Moore wrote:

> Next week I think I'm going to put together a RFC patch that marks
> CONFIG_SECURITY_SELINUX_DISABLE as deprecated, and displays a warning
> when it is used at runtime.  Later on when we have a better idea of
> the removal date, we can start adding delays when it is used to help
> get people to migrate to the cmdline approach.

+1

-- 
James Morris
<jmorris@namei.org>

