Return-Path: <SRS0=KzNU=YP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F7CCA9EA0
	for <selinux@archiver.kernel.org>; Tue, 22 Oct 2019 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D262184C
	for <selinux@archiver.kernel.org>; Tue, 22 Oct 2019 12:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="CoLWuzcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbfJVMZm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:25:42 -0400
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:52849 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbfJVMZl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Oct 2019 08:25:41 -0400
X-EEMSG-check-017: 24282116|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,327,1566864000"; 
   d="scan'208";a="24282116"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Oct 2019 12:25:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571747138; x=1603283138;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=cXN6VtUOBJs+r6nQwT3VEWOecLda70kIhpBy3gEsBOQ=;
  b=CoLWuzcqFiN7G5BuokrV4YsEGGiMtNPBKAAS0H75B67TEfHWlYX0dcao
   dMFge+UhOsGSKx9JkRiqjIotEj5WkRbr8H/GXlj8tfMfwGZ118gOpebo1
   AfQDJbGIgaZmbety5bHicNDakeOJX3saGrdfD5YdcM55x73nSTLNeELOC
   fsfTKk1E6tqnKJ6AlF4nmcguqxsW4+jATYw6YCYRjx7SDGjoWLt6oCQJ9
   CZJe/qX1/MSD0WaJnXP0VUq1MqW6GoCDM5foodzGOKSijQMC9X8vcQJGl
   u19Ls7fHWFt4sLcStvFD2EsbdZlluF9te3h50qE8o1DUsKXn8XZjRfQ2i
   A==;
X-IronPort-AV: E=Sophos;i="5.67,327,1566864000"; 
   d="scan'208";a="34475519"
IronPort-PHdr: =?us-ascii?q?9a23=3ATLY/vBGYaukLUEw+1kbX+J1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zr8qwAkXT6L1XgUPTWs2DsrQY0rGQ4/+rBDRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+1oAjTucUbgZduIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWMheVzZFAoihcYUBCeQPNvtco4XkqVYDqR6yCA+xD+3t1zBInGf707Ak3e?=
 =?us-ascii?q?QvEQ/I3wIuENwBv3vWsNr7O7wfUfy3waTS0TnPc/1b1DX75YPVch4hu/aMXb?=
 =?us-ascii?q?dofMTM1UkgCRvFjlWOpozjIjiby+ENvHKf7+pkS+2ui3MspgZqojey3cchkZ?=
 =?us-ascii?q?XJh4IJxVDE8iV12oA1JcaiR0Jhbt6kF4VQujicOoBrQc0iW3lltDs1x7AJo5?=
 =?us-ascii?q?K2fDUGxI45yxPQdfCLaZWE7xT+X+iLOzh4nmhqeLeniha39kiv1/PzW9Gv0F?=
 =?us-ascii?q?ZPsipFit7Mtm0R1xDL6siIVP99/kC51DaTzQ/T8OBEIV0vlabBN54gwqI/lp?=
 =?us-ascii?q?oUsUjZGC/5hF72g7OMekUh++io7/zrYrTgppCCK495khzyP6shl8ClAek0Lx?=
 =?us-ascii?q?ICU3aU9OiizrHv4FX1QLBQgf03lqnZvoraJcMepqOhGA9az50j5g2jDzamzN?=
 =?us-ascii?q?sYnX4HIEhDeBKclYflIV7OIPfmDfunmVSjjC9rx+zaPr3mGpjNKX3DkLD6fb?=
 =?us-ascii?q?Z78UFT1BQ8wMtF551KF74BIOj8WlPruNPECR85NhS+w/z7B9VlyoMeRWWPD7?=
 =?us-ascii?q?eCMKzMtV+I5+QvI/SDZYIOpjb9JOYq5+T0gX86h1AdZ6+p0oUTaHyiGfRmOU?=
 =?us-ascii?q?qZMjLQhYImF2sQswh2aevxjlSJXD0bM3G3WLk67zo2IJirAYfKWsamh7nXmG?=
 =?us-ascii?q?+gE5lXYH1WIk6DHG2udIieXfoILiWILZxPiDsBAIO9Rpch2Bfmjwrzz75qP6?=
 =?us-ascii?q?KA4SEDnY7y39hyoevInFc98iIiXJfV6H2EU2whxjBAfDQxxq0q5BUmm1o=3D?=
X-IPAS-Result: =?us-ascii?q?A2A3CQBR9K5d/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBd?=
 =?us-ascii?q?CxsUwEyKoQmjm9TBoE2iX2RLwkBAQEBAQEBAQEjEQECAQGEQAKDKiQ4EwIMA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFNwyCOikBgmgBBSMVUQsOCgICJgICVwYBDAYCAQGCX?=
 =?us-ascii?q?z8BglIlsXWBMoVOgzCBSIEOKIwPGHiBB4E4gms+h1WCXgSWM5crgi6CMoRcj?=
 =?us-ascii?q?hIGG4MtliGONptYIoFYKwgCGAghD4MnCUcQFIxehQolAzCBBgEBjwwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 Oct 2019 12:25:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9MCPa7H025627;
        Tue, 22 Oct 2019 08:25:36 -0400
Subject: Re: [PATCH userspace v2] sepolicy: generate man pages in parallel
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191018092005.3198-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <13ed021e-b7f7-c826-e9ee-cc59a2bac41f@tycho.nsa.gov>
Date:   Tue, 22 Oct 2019 08:25:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018092005.3198-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/18/19 5:20 AM, Ondrej Mosnacek wrote:
> Generating man pages takes a lot of time. Do it in parallel to speed up
> the process.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks, applied.

> ---
>   python/sepolicy/sepolicy.py | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> Changes in v2:
> - use multiprocessing.Pool, which reacts better to interruption
> 
> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> index 1934cd86..7b223065 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
> @@ -25,6 +25,7 @@ import os
>   import sys
>   import selinux
>   import sepolicy
> +from multiprocessing import Pool
>   from sepolicy import get_os_version, get_conditionals, get_conditionals_format_text
>   import argparse
>   PROGNAME = "policycoreutils"
> @@ -326,8 +327,13 @@ def gen_gui_args(parser):
>       gui.set_defaults(func=gui_run)
>   
>   
> +def manpage_work(domain, path, root, source_files, web):
> +    from sepolicy.manpage import ManPage
> +    m = ManPage(domain, path, root, source_files, web)
> +    print(m.get_man_page_path())
> +
>   def manpage(args):
> -    from sepolicy.manpage import ManPage, HTMLManPages, manpage_domains, manpage_roles, gen_domains
> +    from sepolicy.manpage import HTMLManPages, manpage_domains, manpage_roles, gen_domains
>   
>       path = args.path
>       if not args.policy and args.root != "/":
> @@ -340,9 +346,11 @@ def manpage(args):
>       else:
>           test_domains = args.domain
>   
> +    p = Pool()
>       for domain in test_domains:
> -        m = ManPage(domain, path, args.root, args.source_files, args.web)
> -        print(m.get_man_page_path())
> +        p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web])
> +    p.close()
> +    p.join()
>   
>       if args.web:
>           HTMLManPages(manpage_roles, manpage_domains, path, args.os)
> 

