Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5121BC2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 13:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246032070E
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 13:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="bJTbqqEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA2Nel (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:34:41 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:46121 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgA2Nel (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 08:34:41 -0500
X-EEMSG-check-017: 50177745|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="50177745"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Jan 2020 13:34:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580304862; x=1611840862;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0O6ZOAcLpPq1udbQKn8JZ13ZgAjdhJm80FsEX3BB2qU=;
  b=bJTbqqEgbBG3Pb3lk/HNiFjRuFe1HW4+1015fMrXUcdMO00wssAkTNmR
   O6e+ObczBjTrmZQMccK3LYgtQoddNx75G4Rs+1wBdlRaCRQCYIrc+HPCZ
   rJJHx9wdnGgAsoXSrzlZsnTbm9sVPd0q9DWvObyFr6W6sLNyoimLcwZaN
   tBApnBtc1/W4z87D6ursAv58mbmWZqylXpTa2kj5sbZ4wQTNqd2GXi/5q
   jgihH7YUnx5fhb7+i5fczU7CXEgIJO/UwoeO4RLGfbejvXn2Mfrh/3SMg
   x89WRYWYXE+1r3kVVRWJ13qS+a66oMTJ0RFATZ7jvNv7+eui5cmZa6kfU
   A==;
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="32446998"
IronPort-PHdr: =?us-ascii?q?9a23=3AgXZcWB/Ef+95g/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+MXIJqq85mqBkHD//Il1AaPAdyHrakawLeP++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMj4ZvK6k9xx?=
 =?us-ascii?q?vUrnBVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBtwDvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFA7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2Mpth1xrSa3xscslI?=
 =?us-ascii?q?bJgJ8exE3B9SpjxIY1IcO3SU5matOjC5tfqjqaOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreLTmppmSN49zkQHxLLghltajAeU4Lg?=
 =?us-ascii?q?cOX2+b9f661LL/5k32XK9Gjvg3kqndqJzaJMIbqbClAwJNz4ou5BmyAy2m3d?=
 =?us-ascii?q?gFh3ULMl1IdAydg4T0I13OJer3Dfa7g1SiijdrwPXGM6X6AprQNXjOi6vhfL?=
 =?us-ascii?q?Zh5E5czwo/19Zf54lOBb0bL/LzXVHxuMTCDhAlKwy03/rnCNJl24wCVmKOA6?=
 =?us-ascii?q?iZMKXMvl+T/e8vLO6MZIgauDb5Nfcl4uThjX49mVMHYaap2p4XYmiiHvt6O0?=
 =?us-ascii?q?WZfWbsgtAZHGcSpAU+UejqhUaaUTFJenayW7sw5jQ8CIKhF4fMWJqhj6CG3C?=
 =?us-ascii?q?e+BpdWfHxJCkiQEXf0cIWJQ+kDaDqILc97kzwETqOsS5c72hG0tQ/60KJnLu?=
 =?us-ascii?q?7O9SIEq53vzt915/fclRsq7zx7E9yd032RT2Fzhm4IQDo23KdkoUx70FiMzb?=
 =?us-ascii?q?Z3judCFdNN+vxJUh01NYLGw+NmDNDyXxrLfs2VR1a+XtWmHTYxQ8oqw9AQZ0?=
 =?us-ascii?q?Z9GtOijg3M3iexHb8VmKKEBIYu/qLfwXfxPcB9xGjC1KU7iFkmWMRPZiWagf?=
 =?us-ascii?q?tU9xLSHJLImkOuuDi2ab8X3COFoGyM322IsVpwXwl3XqHIWHkeYg3dqtGvtW?=
 =?us-ascii?q?3YSLr7MqgqKgtMz4a5L6JObtD4xQFdSOzLJMXVY2X3nXy5QxmP2OXfP8LRZ2?=
 =?us-ascii?q?wB0XCFWwA/mAcJ8CPDbFNvCw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BoAgDPiDFe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVAEgEiqEFIkDhlkGgRIliW+RSQkBAQEBAQEBAQEnEAEBhEACgk44EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIw8BBUEQCxgCAiYCAlcGDQYCAQGCY?=
 =?us-ascii?q?z8BgkoDCSWse4EyhUqCNg1igT6BDiqMOnmBB4ERJwwDgl0+ghuFPoJeBI04i?=
 =?us-ascii?q?kKXXoJDgkyEdo5vBhuCSIxRi2arfiKBWCsIAhgIIQ87gmwJRxgNjikXFY4sI?=
 =?us-ascii?q?wMwjkcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 29 Jan 2020 13:34:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00TDXVIt040604;
        Wed, 29 Jan 2020 08:33:31 -0500
Subject: Re: [PATCH v2] selinux: allow kernfs symlinks to inherit parent
 directory context
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200124184221.322248-1-cgzones@googlemail.com>
 <20200128191656.111902-1-cgzones@googlemail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fea9b8ba-c95b-3629-fcc8-6f6d7a345b71@tycho.nsa.gov>
Date:   Wed, 29 Jan 2020 08:35:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128191656.111902-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/28/20 2:16 PM, Christian Göttsche wrote:
> Currently symlinks on kernel filesystems, like sysfs, are labeled on
> creation with the parent filesystem root sid.
> 
> Allow symlinks to inherit the parent directory context, so fine-grained
> kernfs labeling can be applied to symlinks too and checking contexts
> doesn't complain about them.
> 
> For backward-compatibility this behavior is contained in a new policy
> capability: genfs_seclabel_symlinks
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

(pruned cc list to omit non-selinux kernel maintainers since this change 
is entirely self-contained to selinux; I'm guessing you blindly took the 
results of scripts/get_maintainer.pl which tends to over-approximate - I 
only use it as a guide/hint and rarely use the full list it provides.)

This looks fine to me code-wise.  Have you tried enabling this new 
policy capability in policy and seeing the effects of it?  I remember a 
problem in the way-back time that motivated adding the S_ISLNK() 
exception for proc.  IIRC, the issue was that policies specified 
"genfscon proc /net system_u:object_r:proc_net_t:s0" to label everything 
under /proc/net with proc_net_t by default, and when /proc/net was 
changed to be a symlink to /proc/self/net as part of the network 
namespaces work, this caused the symlink to be labeled proc_net_t, but 
since previously there were no symlinks labeled proc_net_t, no processes 
were allowed to read/follow the symlink and existing systems broke. 
Exempting symlinks caused the /proc/net symlink to be labeled proc_t 
instead, which was already widely allowed.  To avoid this problem when 
enabling this capability, you will either need to allow 
proc_net_t:lnk_file read widely or you will need to change the genfscon 
statement to avoid labeling the symlink (there is an optional file mode 
field in genfscon statements similar to that of file_contexts, e.g.
  genfscon proc /net -d system_u:object_r:proc_net_t:s0
  genfscon proc /net -- system_u:object_r:proc_net_t:s0
would only label directories and regular files with proc_net_t.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

[...]
