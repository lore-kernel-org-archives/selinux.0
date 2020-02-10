Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C52C352A3
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 11:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76C82080C
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 11:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJL4Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:56:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49732 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgBJL4Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 06:56:16 -0500
Received: from localhost (unknown [IPv6:2001:4d48:ad58:9a00::6dd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3C6C629289F;
        Mon, 10 Feb 2020 11:56:14 +0000 (GMT)
Date:   Mon, 10 Feb 2020 11:56:11 +0000
From:   Simon McVittie <smcv@collabora.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
Message-ID: <20200210115611.GA13930@horizon>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 03 Feb 2020 at 13:54:45 -0500, Stephen Smalley wrote:
> The printable ASCII bit is based on what the dbus maintainer requested in
> previous discussions.

I thought in previous discussions, we had come to the conclusion that
I can't assume it's 7-bit ASCII. (If I *can* assume that for this new
API, that's even better.)

To be clear, when I say ASCII I mean a sequence of bytes != '\0' with
their high bit unset (x & 0x7f == x) and the obvious mapping to/from
Unicode (bytes '\1' to '\x7f' represent codepoints U+0001 to U+007F). Is
that the same thing you mean?

I thought the conclusion we had come to in previous conversations was
that the LSM context is what GLib calls a "bytestring", the same as
filenames and environment variables - an opaque sequence of bytes != '\0',
with no further guarantees, and no specified encoding or mapping to/from
Unicode (most likely some superset of ASCII like UTF-8 or Latin-1,
but nobody knows which one, and they could equally well be some binary
encoding with no Unicode meaning, as long as it avoids '\0').

If I can safely assume that a new kernel <-> user-space API is constrained
to UTF-8 or a UTF-8 subset like ASCII, then I can provide more friendly
APIs for user-space features built over it. If that isn't possible, the
next best thing is a "bytestring" like filenames, environment variables,
and most kernel <-> user-space strings in general.

    smcv
