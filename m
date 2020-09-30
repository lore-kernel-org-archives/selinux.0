Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46249C47420
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 10:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E132075F
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 10:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgI3KX6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Sep 2020 06:23:58 -0400
Received: from correo.us.es ([193.147.175.20]:59646 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbgI3KX6 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 30 Sep 2020 06:23:58 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A588518D005
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2020 12:17:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 942BEDA8FB
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2020 12:17:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 889DBDA8EC; Wed, 30 Sep 2020 12:17:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 20932DA722;
        Wed, 30 Sep 2020 12:17:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 30 Sep 2020 12:17:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id DFFF742EF9E2;
        Wed, 30 Sep 2020 12:17:36 +0200 (CEST)
Date:   Wed, 30 Sep 2020 12:17:36 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        laforge@gnumonks.org, jmorris@namei.org
Subject: Re: [PATCH 0/3] Add LSM/SELinux support for GPRS Tunneling Protocol
 (GTP)
Message-ID: <20200930101736.GA18687@salvia>
References: <20200930094934.32144-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930094934.32144-1-richard_c_haines@btinternet.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 30, 2020 at 10:49:31AM +0100, Richard Haines wrote:
> These patches came about after looking at 5G open source in particular
> the updated 5G GTP driver at [1]. As this driver is still under
> development, added the LSM/SELinux hooks to the current stable GTP
> version in kernel selinux-next [2]. Similar hooks have also been
> implemented in [1] as it uses the same base code as the current 3G
> version (except that it handles different packet types).

Yes, [1] looks like it is based on the existing 3G driver in the Linux
tree.

> To test the 3G GTP driver there is an RFC patch for the selinux-testsuite
> at [3].
> 
> To enable the selinux-testsuite GTP tests, the libgtpnl [4] library and
> tools needed to be modified to:
> Return ERRNO on error to detect EACCES, Add gtp_match_tunnel function,
> Allow gtp-link to specify port numbers for multiple instances to
> run in the same namespace.
> 
> A patch for libgtpnl is supplied in the selinux-testsuite patch as well
> as setup/test instructions (libgtpnl is not packaged by Fedora)
> 
> These patches were tested on Fedora 32 with kernel [2] using the
> 'targeted' policy. Also ran the Linux Kernel GTP-U basic tests [5].

I don't remember to have seen anything similar in the existing tunnel
net_devices.

Why do you need this?

> [1] https://github.com/PrinzOwO/gtp5g
