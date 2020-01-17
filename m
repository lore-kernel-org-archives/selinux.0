Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748B5C33C9E
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 17:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535942467D
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 17:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgAQRoY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:44:24 -0500
Received: from dgrift.xs4all.space ([80.100.19.56]:59598 "EHLO
        agnus.defensec.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQRoY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 12:44:24 -0500
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jan 2020 12:44:24 EST
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id CFC0F1320022
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 18:34:49 +0100 (CET)
Date:   Fri, 17 Jan 2020 18:34:48 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: any reason why a class mapping is not able to solve permissionx?
Message-ID: <20200117173448.GA166208@brutus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For example this:

(permissionx alg_socket_ioctl_except_SIOCGIFHWADDR (ioctl alg_socket (and (all) (not (0x8927)))))
(classmap all_sockets (ioctl_except_SIOCGIFHWADDR))
(classmapping all_sockets ioctl_except_SIOCGIFHWADDR alg_socket_ioctl_except_SIOCGIFHWADDR)

(allowx a self (all_sockets (ioctl_except_SIOCGIFHWADDR))) 

Say's:

<snip>
Building AST from Parse Tree
Destroying Parse Tree
Resolving AST
Failed to resolve classmapping statement at policy/base/class_maps.cil:994
Problem at policy/base/class_maps.cil:994
Pass 14 of resolution failed
Failed to resolve ast
Failed to compile cildb: -2
make: *** [Makefile:30: policy.32] Error 254

Am i doing something wrong or is this unsupported?

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
