Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32083C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 20:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062092467B
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 20:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgA0UGC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:06:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35714 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA0UGC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 15:06:02 -0500
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:3aba:f8ff:fe58:9ca1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DAA4528A938;
        Mon, 27 Jan 2020 20:06:00 +0000 (GMT)
Date:   Mon, 27 Jan 2020 20:05:58 +0000
From:   Simon McVittie <smcv@collabora.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
Message-ID: <20200127200558.GA1657845@horizon>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 24 Jan 2020 at 15:16:36 -0500, Stephen Smalley wrote:
> Aside from the trailing newline and \0 issues, AppArmor also has a
> whitespace-separated (mode) field that may or may not be present in the
> contexts it presently returns, ala "/usr/sbin/cupsd (enforce)".

My understanding from last time I worked with AppArmor is that this
is genuinely part of the context, and whether it is present or absent
does not vary according to the kernel API used to access contexts.
AppArmor-specific higher-level APIs parse it into a label and an optional
mode, but LSM-agnostic user-space APIs (like the one in dbus) pass the
whole string through as-is.

(In practice it seems to be present if and only if the context is
something other than "unconfined", although I don't know offhand whether
that's an API guarantee.)

    smcv
