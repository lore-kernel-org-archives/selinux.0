Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B873FC072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FF020863
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 17:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="detZwKlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfEXRLX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 13:11:23 -0400
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:45742 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfEXRLW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 May 2019 13:11:22 -0400
X-EEMSG-check-017: 414694640|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 May 2019 17:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558717864; x=1590253864;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4knnyGKK7yG3VVTIPnciVvVpqm71HxK0SXV6W1HK+cg=;
  b=detZwKlDNoKg4y3Ab0zPWFWbNAAG2HQ5E1jwWTvhda8TWw0FWJbsXEUO
   uE+/lEmF/mD2WF9b0EE74kxVWHcKWw37tw2y2EQIjsNMgnS5i77xO5dZU
   FOUcd2x6owgUIia3vANvRdQsW5FocdZk94Juq0JXltL3SiXK7NO4Q6toO
   Vm+RfyNtMnuaRXMdlnmSCn5eII13efNE8uaHf7XeUhFkFs9GMUNMI5zve
   YY4bY/uEBx9BAurxf1cGzpryr21t5JZ9rMZBhdUVMhs6XqD186BI/HrA5
   tFvUzYYRlKAZgH91Pcc0CuDDBuTsO//FqcFRTZEZiCAE2BmluA3GKNHEn
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,507,1549929600"; 
   d="scan'208";a="24077575"
IronPort-PHdr: =?us-ascii?q?9a23=3AolYA1h0b9Z+iZRdesmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWK/XxwZ3uMQTl6Ol3ixeRBMOHsqsC0rOI+Pm4CCQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagfL9+Ngi6oRjQu8UZnIduNqI8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXoxazAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/TW9ovyM6xacHuZ?=
 =?us-ascii?q?69ZCUKy4ooxwTZa/OZd4iE+BXjVPyeITp+mXlre6q/ig6v/UWvxeDwTMm53E?=
 =?us-ascii?q?tQoiZbndTAqGoB2wHV58OaUPVy5F2h1iyK1w3L7+FEJl07mrTDJp46x74wio?=
 =?us-ascii?q?ITsUPeHi/qgEn2jLGZdkEj+uWw9+ToeK/mpp6BN49vkA3+LqQvldC/AeQ/KA?=
 =?us-ascii?q?QOWXSU+f+g27H5+E35QbFKguU3kqnfrp/aOdwWqrO2DgJayIou6wuzAy243N?=
 =?us-ascii?q?kXg3ULNk9JdAqCj4fzOlHOJP74De24g1SpiDpr3O3JPqb6D5XRLnnMjLfhfb?=
 =?us-ascii?q?Fn505a0wo818pT551TCrEfOP7zQFP+tMTEDh8lNAy52/znCNRh2YMeQ22PGL?=
 =?us-ascii?q?KWP7vOvlCQ5uIgOeiMZIkLtzbmMPUq/OLujX4/mV8BY6apx50XZ26kHvh8P0?=
 =?us-ascii?q?qZZn/siM8bEWgWpgo+UPDqiFqaXD5IeXmyW6M85jcmCIOpForDWI+tj6Kb3C?=
 =?us-ascii?q?uhHZ1ZeHpGClaSHnfsbYmEXO0MaC2KKM97jjMETaShS5Mm1Ry2uw761rxnIf?=
 =?us-ascii?q?bU+iICs5Lj28N45+LUlRE1+jx0C9qS33uRQGFzm2NbDwMxiZp+qkx00FvL8a?=
 =?us-ascii?q?F5hfFDXYhJ5vhJWx02ApXrz+V7Dd3pcgjdf9GVRUygT8ngCjY0GJZ52NIKYk?=
 =?us-ascii?q?BgC/28gR3ZmSmnGbkYk/qMHpNn3Ljb2i3KO8tly3vAnJIkhl0iT9oHYXaqnY?=
 =?us-ascii?q?Zj5gPTAMjPiEzfmKG0I/dPlBXR/XuOmDLd9HpTVxR9BOCcBiES?=
X-IPAS-Result: =?us-ascii?q?A2BzBgCeJOhc/wHyM5BlHAEBAQQBAQcEAQGBZYFnKmlRA?=
 =?us-ascii?q?TIohBOTWAEBAQMGgRAliU6RBQkBAQEBAQEBAQEtBwECAQGEQAKCPyM4EwEDA?=
 =?us-ascii?q?QEBBAEBAQEDAQFsHAyCOikBgmYBAQEBAgEjFUEQCxgCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?l8/AYF2BQ8PpgWBL4QyAYEUgyuBQAaBDCiLUxd4gQeBOAyCMS4+h06CWASLH?=
 =?us-ascii?q?SAxh2mUcAmCD4IShCGMWQYbgh+UIoxogSiFWJB7ITaBISsIAhgIIQ87gm0Si?=
 =?us-ascii?q?wCFWyMDMQGBBAEBjgUBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 May 2019 17:11:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4OHB04q029332;
        Fri, 24 May 2019 13:11:00 -0400
Subject: Re: [PATCH 0/3] Update restorecon to support new digest scheme
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     xunchang@google.com
References: <20190522164240.3062-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d508ca78-1166-be9b-7659-9def4728d991@tycho.nsa.gov>
Date:   Fri, 24 May 2019 13:11:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522164240.3062-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/22/19 12:42 PM, Richard Haines wrote:
> These patches require [1] and [2] be installed first. They have
> been implemented on Android and sent to the selinux list, however their
> merge has been deferred. They will install the core hashing of
> file_context entries and fix root stem processing.
> 
> Patch 1/3 updates selinux_restorecon() replacing the per-mountpoint
> security.restorecon_last attribute with a per-directory security.sehash
> attribute computed from only those file contexts entries that partially
> match the directory. This is to avoid the need to walk the entire tree
> when any part of file_contexts changes, limiting relabels to only those
> parts of the tree that could have changed.
> 
> One change is to add a new selabel_get_digests_all_partial_matches(3)
> function that is explained in the man page. This could replace the Android
> version of selabel_hash_all_partial_matches(3), that could then be
> converted into a local function (The Android team would need to approve).

Has Android sorted out all of the ramifications of this change?  What 
about the triggering of CAP_SYS_ADMIN denials for setting the 
security.sehash attribute?

> 
> Patches 2/3 and 3/3 update restorecon, setfiles and restorecond.
> 
> I will send a patch for the selinux-testsuite that will perform tests on
> the new code.
>   
> [1] https://lore.kernel.org/selinux/20190311222442.49824-1-xunchang@google.com/
> [2] https://lore.kernel.org/selinux/20190417180955.136942-1-xunchang@google.com/
> 
> Richard Haines (3):
>    libselinux: Save digest of all partial matches for directory
>    setfiles: Update utilities for the new digest scheme
>    restorecond: Update to handle new digest scheme
> 
>   libselinux/include/selinux/label.h            |   5 +
>   libselinux/include/selinux/restorecon.h       |  17 +-
>   .../selabel_get_digests_all_partial_matches.3 |  70 +++++
>   libselinux/man/man3/selinux_restorecon.3      |  91 +++---
>   .../man3/selinux_restorecon_default_handle.3  |   9 +-
>   .../man/man3/selinux_restorecon_xattr.3       |  11 +-
>   libselinux/src/label.c                        |  15 +
>   libselinux/src/label_file.c                   |  51 ++++
>   libselinux/src/label_file.h                   |   4 +
>   libselinux/src/label_internal.h               |   5 +
>   libselinux/src/selinux_restorecon.c           | 267 +++++++++++-------
>   libselinux/utils/.gitignore                   |   1 +
>   .../selabel_get_digests_all_partial_matches.c | 170 +++++++++++
>   policycoreutils/setfiles/restore.c            |   7 +-
>   policycoreutils/setfiles/restore.h            |   2 +-
>   policycoreutils/setfiles/restorecon.8         |  10 +-
>   policycoreutils/setfiles/restorecon_xattr.8   |  19 +-
>   policycoreutils/setfiles/restorecon_xattr.c   |  66 +----
>   policycoreutils/setfiles/setfiles.8           |  10 +-
>   policycoreutils/setfiles/setfiles.c           |  19 +-
>   restorecond/restore.c                         |   8 +-
>   restorecond/restore.h                         |   2 +-
>   restorecond/restorecond.c                     |   5 +-
>   23 files changed, 593 insertions(+), 271 deletions(-)
>   create mode 100644 libselinux/man/man3/selabel_get_digests_all_partial_matches.3
>   create mode 100644 libselinux/utils/selabel_get_digests_all_partial_matches.c
> 

