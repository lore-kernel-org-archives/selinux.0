Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6485C7618B
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 13:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896AA206DD
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 13:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfG2NAh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:00:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55830 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbfG2NAg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 09:00:36 -0400
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:3aba:f8ff:fe58:9ca1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C735C28A6B9;
        Mon, 29 Jul 2019 14:00:35 +0100 (BST)
Date:   Mon, 29 Jul 2019 14:00:33 +0100
From:   Simon McVittie <smcv@collabora.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH 25/27] NET: Add SO_PEERCONTEXT for multiple LSMs
Message-ID: <20190729130033.GD2383@horizon>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
 <20190726233923.2570-26-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726233923.2570-26-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 26 Jul 2019 at 16:39:21 -0700, Casey Schaufler wrote:
> A new option SO_PEERCONTEXT is added to report the
> security "context" of multiple modules using a "compound" format
> 
> 	lsm1\0value\0lsm2\0value\0

> +		/*
> +		 * A compound context, in the form lsm='value'[,lsm='value']...
> +		 */

Presumably the commit message (and the implementation) means the comment
is out of date?

> +			/*
> +			 * Don't propogate trailing nul bytes.
> +			 */
> +			clen = strnlen(cp, clen) + 1;
> +			tlen = llen + clen;
...
> +			memcpy(tp + finallen + llen, cp, clen);

This assumes that cp points to a '\0'-terminated string, with the '\0'
either inside the span of memory cp[clen]..cp[clen-1], or at cp[clen]
(which is just outside the range that is obviously safe to access).
Is that assumption robust? If an LSM that worked with length-counted
("Pascal") strings internally would be allowed to fill the buffer with
nonzero bytes and not place a '\0' immediately after it, then it would
be necessary to insert the NUL explicitly:

    clen = strnlen(cp, clen);
    tlen = llen + clen + 1;
    ...
    memcpy(tp + finallen + llen, cp, clen);
    tp[finallen + llen + clen] = '\0';

Thanks,
    smcv
