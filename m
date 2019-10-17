Return-Path: <SRS0=qWI8=YK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B168ECE58E
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E290A21925
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 17:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="iR+hU/Ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440642AbfJQRPL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:15:11 -0400
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:59862 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQRPL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Oct 2019 13:15:11 -0400
X-EEMSG-check-017: 18487184|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,308,1566864000"; 
   d="scan'208";a="18487184"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Oct 2019 17:15:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571332510; x=1602868510;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=1vxJyoB1V7W9Ku2+ijvwmGfZ7CsrftZP/TmVgGwKnoo=;
  b=iR+hU/UeZIQyETvXqereiyyU2Mn/EHo3Viw/IlfmGt8vFNUWO6DVSUa8
   6aO5r7a+xl6t+KcCCsXhAYEgSJRAHy9TJoXS/V7sgsxismUvfnfN40oxG
   jjTKoBpNH+uk3nbOwTnpVLcp/6bY+1L82J5xtGt3ahF+8Stn1vi6662xK
   RMtNIrgt40+/dABtzABdYuUz3eFas9uty7oAIXZciOIifCowqnGL5mG7A
   ws5jE97bt5Oa4vgimth/3hDR0j9xboJgqRnSxJZ5z8vMZuoTWaEsAZ9Gg
   kI2K5T37Xv3bJLXbdWq9EvMcG35W0lKVkEIRJf0WL6Ib++VAqPdcKIDT9
   g==;
X-IronPort-AV: E=Sophos;i="5.67,308,1566864000"; 
   d="scan'208";a="34309865"
IronPort-PHdr: =?us-ascii?q?9a23=3AmGpCvRUbJPoxZ1iP5sutc9NC7fLV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbByOt8tkgFKBZ4jH8fUM07OQ7/m7HzNfqs/Y6DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrMsbjIltJqos1x?=
 =?us-ascii?q?fFvmZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oPsUXMAi/2mELsgK+Qakok4fSn5/7iYrXnop+QL450igfgPaQygsGzHOs1Pw?=
 =?us-ascii?q?cUU2Wb5OiwzqPv8ELnTLlQk/E6iqzZv4rbJcQfqK65GQhV0oM75hakEjimy8?=
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5er?=
 =?us-ascii?q?Z97klcyBE1zd9F+51bFKoMIOjtVUDstNzXFAM5PxaozObgDdV3zpkeVn6XAq?=
 =?us-ascii?q?+FLKPStkeF5vkxLOmIZY8Vviv9Kvc+6v7wgn82h0UdcbOq3ZQJcnC4GOppI0?=
 =?us-ascii?q?GDbXrrmNcBHjRCgg1ra+rmklCAGRtUfHC7VK8/rmU8DYW9C47IS6i3jbCB1T?=
 =?us-ascii?q?v9FZpTMCQOEV2IEHH1Z62aVPoWLiGfOMlslnoDT7fyZZUm0ESVqALiy7dhZt?=
 =?us-ascii?q?HR8ykcuIOrgMN5/MXPhBoy8npyFM3b3GaTGTIn1lgUTiM7ifgs6Xd2zU2OhO?=
 =?us-ascii?q?0h2K1V?=
X-IPAS-Result: =?us-ascii?q?A2CRAQBHoahd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYFzLGxUMiqEJY5mUwaBNol5kS8JAQEBAQEBAQEBIxEBAgEBhEACgwYkN?=
 =?us-ascii?q?wYOAgwBAQEEAQEBAQEFAwEBbIUtDII6KQGCaAEFIxVRCw4KAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYJfPwGCUiWwCYEyhU2DKIFIgQwoAYwNGHiBB4E4gms+h1KCXgSWL5cig?=
 =?us-ascii?q?iyCMoRajg8GG4MslhuOMJtPI4FYKwgCGAghD4MnCUcQFIsohQolAzCBBgEBj?=
 =?us-ascii?q?3wBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Oct 2019 17:14:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9HHEYfq021512;
        Thu, 17 Oct 2019 13:14:34 -0400
Subject: Re: [PATCH userspace] sepolicy: generate man pages in parallel
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191014080647.19602-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d6755428-b0bd-1d88-69f7-0dd953eb7300@tycho.nsa.gov>
Date:   Thu, 17 Oct 2019 13:14:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191014080647.19602-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/14/19 4:06 AM, Ondrej Mosnacek wrote:
> Generating man pages takes a lot of time. Do it in parallel to speed up
> the process.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   python/sepolicy/sepolicy.py | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> index 1934cd86..02094013 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
> @@ -25,6 +25,7 @@ import os
>   import sys
>   import selinux
>   import sepolicy
> +from concurrent.futures import ProcessPoolExecutor
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
> @@ -340,9 +346,9 @@ def manpage(args):
>       else:
>           test_domains = args.domain
>   
> -    for domain in test_domains:
> -        m = ManPage(domain, path, args.root, args.source_files, args.web)
> -        print(m.get_man_page_path())
> +    with ProcessPoolExecutor() as e:
> +        for domain in test_domains:
> +            e.submit(manpage_work, domain, path, args.root, args.source_files, args.web)
>   
>       if args.web:
>           HTMLManPages(manpage_roles, manpage_domains, path, args.os)
> 

