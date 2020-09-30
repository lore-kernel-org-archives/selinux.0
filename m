Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1363FC4727E
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 11:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EA520708
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 11:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgI3LWn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Sep 2020 07:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3LWn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Sep 2020 07:22:43 -0400
X-Greylist: delayed 1139 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Sep 2020 04:22:42 PDT
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D65C061755;
        Wed, 30 Sep 2020 04:22:42 -0700 (PDT)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.89)
        (envelope-from <laforge@gnumonks.org>)
        id 1kNZtX-0008Kt-5k; Wed, 30 Sep 2020 13:03:35 +0200
Received: from laforge by localhost.localdomain with local (Exim 4.94)
        (envelope-from <laforge@gnumonks.org>)
        id 1kNZrt-000zE9-VK; Wed, 30 Sep 2020 13:01:53 +0200
Date:   Wed, 30 Sep 2020 13:01:53 +0200
From:   Harald Welte <laforge@gnumonks.org>
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        pablo@netfilter.org, jmorris@namei.org
Subject: Re: [PATCH 3/3] selinux: Add SELinux GTP support
Message-ID: <20200930110153.GT3871@nataraja>
References: <20200930094934.32144-1-richard_c_haines@btinternet.com>
 <20200930094934.32144-4-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930094934.32144-4-richard_c_haines@btinternet.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Richard,

I don't fully understand in which context you need / use those SELinux GTP hooks,
however one comment from the point of view of somebody who is working on GGSN/P-GW
software using the GTP kernel module:

On Wed, Sep 30, 2020 at 10:49:34AM +0100, Richard Haines wrote:
> +selinux_gtp_dev_cmd()
> +~~~~~~~~~~~~~~~~~~~~~
> +Validate if the caller (current SID) and the GTP device SID have the required
> +permission to perform the operation. The GTP/SELinux permission map is
> +as follow::
> +
> +    GTP_CMD_NEWPDP = gtp { add }
> +    GTP_CMD_DELPDP = gtp { del }
> +    GTP_CMD_GETPDP = gtp { get }

Wouldn't it make sense to differentiate between:

a) add/del/get on the GTP netdev
b) add/del/get on the indivudual PDP wihin the GTP netdev

'a' is typically only created once at startup of a GGSN/P-GW software, or is
done even at system stat-up time.

'b' is performed frequently during runtime as the GGSN/P-GW function runs, as
subscribers attach to / detach from the cellular network.

By differentiating between those two, one could further constrain the permissions
required at runtime.

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
