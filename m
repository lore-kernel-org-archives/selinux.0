Return-Path: <SRS0=745E=5M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD41C43331
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE882206F2
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 17:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="RLU5Qula"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgC0RIH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:08:07 -0400
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:44014 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0RIH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Mar 2020 13:08:07 -0400
X-EEMSG-check-017: 68663446|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,313,1580774400"; 
   d="scan'208";a="68663446"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Mar 2020 17:07:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585328876; x=1616864876;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=x/UHmnLd7u9WOLpn8n9eg1G2CuOQRZKv1tPdR1NrTeI=;
  b=RLU5Qula4VJUcDbWuFQNuGLCDy6eyVJHpJwgsFxjbJN+DCxF+8t2Gj5p
   e6Scho1ytE2JkdCe+WnnAUlc6sOPNDYbviIEiLflw8xdoPafLZrMJzDm5
   t3nMfcvZFROsKSyRigxveAATDD5YeWHxUHuKgDClT74SYvVHjzm1VVQFc
   /7nFk8ECbd1BtYNlZBBx1KJuG5WLH6n5H/Q1QXojNZc+vzIlw7IgfiaYv
   G5BR5pFuyMhuuvgv8oD0VJ++2ceDyAh2FggyXRP9LYWkCpesBZ4B9o54G
   SFFFMHgvNfqM1IC2QiK62fPgr7Hs6VrqmMV7kxcy95WgcldTSzNSVvOrX
   A==;
X-IronPort-AV: E=Sophos;i="5.72,313,1580774400"; 
   d="scan'208";a="41146068"
IronPort-PHdr: =?us-ascii?q?9a23=3AImOeahVQJV+IJOcS4BxKmuc7LzHV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRCPt8tkgFKBZ4jH8fUM07OQ7/m8HzVdsN3Q6zgrS99laV?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam5ZuJ6Y1xx?=
 =?us-ascii?q?fGpnZFdfldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U7NVCSktPn?=
 =?us-ascii?q?426sP2qxTNVBOD6XQAXGoYlBpIGBXF4wrhXpjtqCv6t/Fy1zecMMbrUL07Qz?=
 =?us-ascii?q?Wi76NsSB/1lCcKMiMy/W/LhsBsiq9QvQmsrAJjzYHKfI6VNeJ+fqLDctMcWW?=
 =?us-ascii?q?pBRdtaWyhYDo+hc4cDE+8NMOBWoInno1sFsAWwCw+iCujyzjNEn3H70Kk/3+?=
 =?us-ascii?q?knDArI3hEvH8gWvXrJstv1OqccX+O7wqbGwjrMbe9Z1zjm5YjUcB0su+2AUa?=
 =?us-ascii?q?5+fMfTz0QkCgPLjk+XqYzgJz6by/gNvHaD7+pgS+2vjXMspRx0oje1wscsjp?=
 =?us-ascii?q?fGh4IIwV3D7iV23Z01KMakSE97fdGkEJxQuzucN4ttWMwuWW5ouCEkyrAfv5?=
 =?us-ascii?q?OwYSsEyIw/yhLCZPGKfJKE7xL+WOqLPzt1i2xpdKiiixu07EOu0PfzVtOu31?=
 =?us-ascii?q?ZPtidFl97MuW0T2BHL8ciHT+d9/l+m2TaSywDf8uFELl4wlarcM5Mh3qQ/lo?=
 =?us-ascii?q?ASsUTeBS/6gln2ja+KeUUk/eik8eLnban9ppCALYN0jwD+MqA2lsy+B+Q3LB?=
 =?us-ascii?q?QOUnCG9emz27Dv5030TKhQgvEonaTVrorWKdkDqq68GQBV04Ij6xilDzeh1d?=
 =?us-ascii?q?QVhWIHI09eeB+ck4joO03BIPD/DfulhVSsiy1ky+rJPr3mHJXBNmLDn6v5fb?=
 =?us-ascii?q?Zh905czxI+zdda55JTEbEBJuj8VVPvu9HDFB82LRG7w+b9B9VhzI8RRWWPAq?=
 =?us-ascii?q?qBOqPIrVCI/v4vI/WLZIINozbyNfwl5//ojX8kll4QZrep3ZQJZ3CiBPhmIF?=
 =?us-ascii?q?uWYWDqgtgfFWcGpA0+TPbliFeaSz5ce26yX74g5jE8EI+mFZnMSZuzj7yH3S?=
 =?us-ascii?q?e7AppWa3tHCl+SD3jnaZ+IW/AWaCKdcYddlWkjU7S7Ro1p8Ba1sgbxxrkveu?=
 =?us-ascii?q?3R/TYevJnu/MJ46+3aiVc58jkiS4yG3mWMSXxktn0HSiVw361lp0F5jFCZ3v?=
 =?us-ascii?q?tWmftdQOdP6utJXwFyDpvVy+h3GpimQQ7aVsuYQ1ahBNO9CHc+ScxnkIxGWF?=
 =?us-ascii?q?p0B9j31kOL5CGtGbJA0uXQVZE=3D?=
X-IPAS-Result: =?us-ascii?q?A2CjAABaMn5e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8LIFBMiqEGo9TBoEKLYl7iimHJAoBAQEBAQEBAQE0AQIEAQGERAKCM?=
 =?us-ascii?q?SQ3Bg4CEAEBAQUBAQEBAQUDAQFshWKCOykBgwwBBSMVQRALDgoCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgmM/glglrUGBMoVLg16BPoEOKgGMMBp5gQeBOA+CXj6HYIJeBJgCm?=
 =?us-ascii?q?FuCRoJWlDAGHZtpLY5nngojgVgrCAIYCCEPgydQGA2dASUDMIEGAQGOFQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Mar 2020 17:07:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02RH8FRv047149;
        Fri, 27 Mar 2020 13:08:15 -0400
Subject: Re: [PATCH 2/2] libsepol: implement POLICYDB_VERSION_COMP_FTRANS
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Chris PeBenito <pebenito@ieee.org>
References: <20200327152107.95915-1-omosnace@redhat.com>
 <20200327152107.95915-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cb990775-f602-8436-4460-f78b7ce3a96f@tycho.nsa.gov>
Date:   Fri, 27 Mar 2020 13:09:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327152107.95915-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/27/20 11:21 AM, Ondrej Mosnacek wrote:
> Implement a new, more space-efficient form of storing filename
> transitions in the binary policy. The internal structures have already
> been converted to this new representation; this patch just implements
> reading/writing an equivalent representation from/to the binary policy.
> 
> This new format reduces the size of Fedora policy from 7.6 MB to only
> 3.3 MB (with policy optimization enabled in both cases). With the
> unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

Haven't looked at the code yet, but something is wrong with the handling 
when it needs to dowgrade to an older policy version for a kernel that 
doesn't yet support this new version:

$ sudo semodule -B
libsepol.mls_read_range_helper: range overflow
libsepol.context_read_and_validate: error reading MLS range of context
libsepol.policydb_to_image: new policy image is invalid
libsepol.policydb_to_image: could not create policy image
SELinux:  Could not downgrade policy file 
/etc/selinux/targeted/policy/policy.33, searching for an older version.


