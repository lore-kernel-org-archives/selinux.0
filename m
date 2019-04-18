Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C415BC10F0E
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87929217FA
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 13:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="CfxXliNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbfDRNxC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:53:02 -0400
Received: from uhil19pa14.eemsg.mail.mil ([214.24.21.87]:26667 "EHLO
        UHIL19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRNxB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 09:53:01 -0400
X-EEMSG-check-017: 45305608|UHIL19PA14_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Apr 2019 13:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1555595578; x=1587131578;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5D9w/x9zOwCzKoJ4WowNkZ32v4HQmuvs9omXH7hHWpA=;
  b=CfxXliNPKuXLSIaOCRi6BQo9FQSoIAMBDoX+SsD8QHjZJytQgTtCLz9x
   vWN3Zh7vbGihl92vMAuUzAgRC3m4BeYYlysFnoje/qf51fcqUUht1ZeqZ
   uv38BwfsPOZV9+QNc8FPf5/AuDjh70Ut0W9AXdFC7THO9dUiLR06s5DpE
   e3SAGpMN0jaEdG12XwJWXAgzp1Hs4xqjO8MkgLoc0gCDXQowr2Gcy34pN
   XkqmsoSUzyAwZuXd98kIYbidXZ8yCAXLrw6+jXyMfXcqufQV55nOx8rAr
   dP6v1s8J19f/L0C+vsNyCUYJX3DA7doS8nezmy+ru94i/0vehMUIGGs6+
   A==;
X-IronPort-AV: E=Sophos;i="5.60,366,1549929600"; 
   d="scan'208";a="22661798"
IronPort-PHdr: =?us-ascii?q?9a23=3AKe6JmBRUYpKipFE17sQDoKINU9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBCOt8tkgFKBZ4jH8fUM07OQ7/m5Hzddqs3f+DBaKdoQDk?=
 =?us-ascii?q?dD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrssxh?=
 =?us-ascii?q?fTrHZFe+tayG1pKFmOmxrw+tq88IRs/ihNp/4t7dJMXbn/c68lUbFWETMqPn?=
 =?us-ascii?q?wv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qi?=
 =?us-ascii?q?mi4LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2?=
 =?us-ascii?q?dKQ91cXDJdDIyic4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ks03O?=
 =?us-ascii?q?Q7FQHNwRIuEdQAvn/JqNn5LakfXOSwwKTO0D7Nbe5Z2S3l5YbVbB4hr/GCU7?=
 =?us-ascii?q?F+f8XfxkYgFR/KgFqLpIz5PT6YzPgBv3SV4udiU++klm4pqxt2ojiq3soil5?=
 =?us-ascii?q?XJiZwNylDE6yp5xps+K8C9SEFhZd6kFIVftiGHPIZxWcMtXnpotT0myrwGpZ?=
 =?us-ascii?q?G7fC8KxI4hxx7EcfOLaYeI4hX9VOuIJzpzmXxreLW6hxmo8EigzPXxVsqq31?=
 =?us-ascii?q?ZQqCpKjN3MumoK1xzJ5ciKTOZ28ES52TuXygze5e5JLVo0mKbGMZIt3LE9mo?=
 =?us-ascii?q?QJvUjeGCL9hV/4g7WMdko+/+il8+HnYrL7qZCCL4J0kQT+Mrg2msy4HOQ4Lh?=
 =?us-ascii?q?ACX2iF9uS4073u5VH5T69Qjv03j6nZq4rWJdgbp6GlAw9V1Zwv6xCjADe9zN?=
 =?us-ascii?q?sUh3wHLFNBeB6fjojpPU/BIOzgAPuijFmhny1nyvDbMrH7HJnAIWbPnK38cb?=
 =?us-ascii?q?pl7k5T0gszzdRR55JODbEBJer+WlTsu9zDFRI5Lwy1zPrnCNV6zI8eX3mPDb?=
 =?us-ascii?q?WDPKPdtl+I+PojI/OQa48NpDb9N/8l6ub0jX84hVAdfbOm3YEKZ3+gAvtpO0?=
 =?us-ascii?q?WZbmDtgtcHD2gKpREzQ/f2iF2DVz5Te2i9X7g65j4lFIKqF5vMRoeogLaZxi?=
 =?us-ascii?q?e0AoVWZnxaClCLCXrobJuLW/MNaCKUP89gnScJVaauS4A/zxGirgz6xKR9Lu?=
 =?us-ascii?q?rS5CIYsYjv1N9v5+3cjRsy7yB7D9yB02GRSGF5hmwJRyIw3K9joUxy0FGD0a?=
 =?us-ascii?q?djjvxXEtxT4PxJUgMkOpLG0+N6DNXyCUr9eYKzSV2mS8+qSRE4T9Q82JdaeU?=
 =?us-ascii?q?d2G9y4gifI6CqjArkYjJSBGJ0y7q/G2XXtYc16ziCCnLIsi1ggX9tnK2KrnO?=
 =?us-ascii?q?h8+hLVCoqPlF+WxIiwcqFJ5zLA7GeOyyK1uUhcVANhGfHeUWs3elrdrdO/4F?=
 =?us-ascii?q?jLCbCpF+J0YUN61ceeJ/4SOZXShlJcSaKmYY+Pbg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AUAAAzgLhc/wHyM5BlGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFmKmgDTgEyKIQOiByLWAEBAQEBAQaBNYlIjwKBezUHAYRAAoYZIzQJD?=
 =?us-ascii?q?gEDAQEBBAEBAQECAWwcDII6KQGCZgEBAQECASMVQRALGAICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCXz8BgXQFDw+ofYEvhDIBgRSEYAaBCycBi0kXeIEHgREngj0uPodOglcEi?=
 =?us-ascii?q?lCIBJN0CYIIhgyMEgYbi22JGot4hjOPcDg1gSErCAIYCCEPO4JtEoIyiEyFW?=
 =?us-ascii?q?yMDMQGBBAEBj2oBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Apr 2019 13:52:57 +0000
Received: from [192.168.25.131] (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x3IDqvaq003941;
        Thu, 18 Apr 2019 09:52:57 -0400
Subject: Re: [RFC PATCH 0/1] libselinux: Save digest of all partial matches
 for directory
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     xunchang@google.com
References: <20190417105020.23803-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <000cbd06-9d20-505d-18ce-f91814c09954@tycho.nsa.gov>
Date:   Thu, 18 Apr 2019 09:52:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417105020.23803-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/17/19 6:50 AM, Richard Haines wrote:
> This patch requires that patch [1] be installed first. [1] has been
> implemented on Android and was sent to the selinux list, however its
> merge has been defered. It will install the core hashing of file_context
> entries.
> 
> This patch updates selinux_restorecon() replacing the per-mountpoint
> security.restorecon_last attribute with a per-directory security.sehash
> attribute computed from only those file contexts entries that partially
> match the directory. This is to avoid the need to walk the entire tree
> when any part of file_contexts changes, limiting relabels to only those
> parts of the tree that could have changed.
> 
> One change is to add a new selabel_get_digests_all_partial_matches(3)
> function that is explained in the man page. This could replace the Android
> version of selabel_hash_all_partial_matches(3), that could then be
> converted into a local function.
> 
> I've not updated restorecon(8) or restorecon_xattr(8) programs as they
> work okay (although I could rework the "selabel_opt_digest" stuff). However
> the man pages at least will need updating.
> 
> The patch still needs more testing (I've not tried all restorecon options),
> however I will send a patch for the selinux-testsuite that will perform
> some simple tests on the new code.
>   
> [1] https://lore.kernel.org/selinux/20190311222442.49824-1-xunchang@google.com/

I've seen some activity on AOSP suggesting that Android has had some 
problems with this support, e.g. mismatches due to stem logic and 
triggering CAP_SYS_ADMIN denials upon attempting to set security.sehash 
attributes.  There have been some follow-up commits to AOSP's libselinux 
fork in that area and I'm not sure if the dust has entirely settled there.

> 
> Richard Haines (1):
>    libselinux: Save digest of all partial matches for directory
> 
>   libselinux/include/selinux/label.h            |   5 +
>   .../selabel_get_digests_all_partial_matches.3 |  69 ++++++
>   libselinux/src/label.c                        |  15 ++
>   libselinux/src/label_file.c                   |  51 +++++
>   libselinux/src/label_file.h                   |   4 +
>   libselinux/src/label_internal.h               |   5 +
>   libselinux/src/selinux_restorecon.c           | 204 +++++++++++++-----
>   libselinux/utils/.gitignore                   |   2 +
>   .../selabel_get_digests_all_partial_matches.c | 171 +++++++++++++++
>   .../utils/selabel_hash_all_partial_matches.c  | 126 +++++++++++
>   10 files changed, 595 insertions(+), 57 deletions(-)
>   create mode 100644 libselinux/man/man3/selabel_get_digests_all_partial_matches.3
>   create mode 100644 libselinux/utils/selabel_get_digests_all_partial_matches.c
>   create mode 100644 libselinux/utils/selabel_hash_all_partial_matches.c
> 

