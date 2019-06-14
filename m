Return-Path: <SRS0=ZMzQ=UN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A615EC31E4D
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 15:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDFA2177E
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 15:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ay20Y/hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfFNPea (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:34:30 -0400
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:32319 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfFNPe3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jun 2019 11:34:29 -0400
X-EEMSG-check-017: 419891207|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jun 2019 15:34:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560526463; x=1592062463;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=C2NAjB9ce77PqYTLGXbEguB6fJ3TWv12ebp3Rf6ZwBI=;
  b=ay20Y/hqzU839/NT9nYzlGUQzoeReHmvmIzL4vqZx++SuAK+JKU2ufFU
   7F5ppnDLe+7hS4bVJGHA+jD2t4B/cMzOuqBN0FAwPwQsKRkl9vHp4XaAJ
   HY2wVOsSSzGWkkGUpeBH0MiGAiuKtZwql02A8OrPfNStAfd9OWer5O9MZ
   Hoyy8ek2L5vuNAFrPqPxu1C99RJgm3kjaXcSFVeuByUUKYt7yuYfrnoAQ
   XCt6jikGu9FKXA4/3hfnsDx7mqLP3qRz3LXeT5dG5F9Zg/+op9jDE/e7+
   TWcGxBn0946hqoSpErTIphcNqYwTh6WvbOnsVpnBVb2JVMH8X0BaD/Tr5
   A==;
X-IronPort-AV: E=Sophos;i="5.63,373,1557187200"; 
   d="scan'208";a="28986923"
IronPort-PHdr: =?us-ascii?q?9a23=3AQbHZ9RU4ZAJDljxLgNs1+NOof3rV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbReEt8tkgFKBZ4jH8fUM07OQ7/m5HzVeuN3R4DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrsAndrNQajIp/Jqo+yR?=
 =?us-ascii?q?bEoWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvHjlSetYPqJSmV1vgTv2OG6OdgV+yuhHI9pAFrvjij2Nwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbN54gzaIwlp?=
 =?us-ascii?q?oUq0jDGDP5mF7qg6OMc0Uk++yo5/zmYrXguJCcK5d5hhzxP6khgMCyAfk0Ph?=
 =?us-ascii?q?IQU2WU5+iwzqDv8VX8QLpQj/02lqfZsIrdJcQevqO5AQFU3Zo55BalEzeqzs?=
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5fb?=
 =?us-ascii?q?d99kpcyAspwdBc55JUDawOIPXpWk/ys9zYEAQ5Mw+1w+fnE9hyypkeWX+JAq?=
 =?us-ascii?q?CFMKPTsUKH6fgzI+aWfoMapDH9K/097f70kXA5gUMdfbWu3ZYPc3C3APBmI0?=
 =?us-ascii?q?SfYXrxjdYMCnkKvgUgQ+zwklGCUiBcZ2y0X60i4jE3EoWmDZ3MRtPlvLvU7T?=
 =?us-ascii?q?q/H9V1ZmdKDUqPFmnzdISVE6MddSaTZMxhlTADT7umVZQi1ACGvxXnzbFnP+?=
 =?us-ascii?q?bd5iRevpXmgpw9/ODXlBcv5RRqAMmHlWKAVWd5miUPXTBl8rp4pBl/1VyKy7?=
 =?us-ascii?q?Qiy6haCtda/e8TehsrPp7biephApb9XRyXLYTBc0qvXtjzWWJ5ddk22dJbJh?=
 =?us-ascii?q?8mStg=3D?=
X-IPAS-Result: =?us-ascii?q?A2D2CgAKvgNd/wHyM5BmHgEGBwaBZYFnKoFuKIQWlQOYd?=
 =?us-ascii?q?4FnCQEBAQEBAQEBATQBAgEBghKCLgKCTCM4EwEDAQEBBAEBAQEDAQFsKII6K?=
 =?us-ascii?q?QGCZwEFIwQRUQsJDwICJgICVwYBDAYCAQGCXz+CC6lpfjOFR4MegUaBDCiLX?=
 =?us-ascii?q?YFWQIE4gms+hA0EARIBgymCWASBLQGKMjqICIEplAkGA4ISk0sGG5cyiXeDJ?=
 =?us-ascii?q?ZNrhH8hZ3ErCkFKgR6BToIbFxRuAQyNLSMDMIEGAQGNAQ8XgiwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Jun 2019 15:34:19 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5EFYF4S002484;
        Fri, 14 Jun 2019 11:34:15 -0400
Subject: Re: [Non-DoD Source] [PATCH] libsepol: error in CIL if a permission
 cannot be resolved
To:     Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>,
        selinux@vger.kernel.org
References: <20190613201827.8616-1-yuli@crunchydata.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <ac39d408-134f-8e8a-26a7-c61a5e75d42c@tycho.nsa.gov>
Date:   Fri, 14 Jun 2019 11:35:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613201827.8616-1-yuli@crunchydata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/13/19 4:18 PM, Yuli Khodorkovskiy wrote:
> In the following example, "relabeltoo" is not a valid permission
> in the loaded policy nor in the new module. Before, CIL would not
> complain about the invalid permission and proceed to install the module:
> 
> 	$ cat test.cil
> 
> 	(mlsconstrain (db_procedure (create relabeltoo)) (eq l2 h2))
> 
> With this patch, an error is now prompted to a user:
> 
> 	$ sudo semodule -i foo.cil
> 
> 	Failed to resolve permission relabeltoo
> 	Failed to resolve mlsconstrain statement at /etc/selinux/mls/tmp/modules/400/test/cil:1
> 	semodule:  Failed!
> 
> Signed-off-by: Yuli Khodorkovskiy <yuli@crunchydata.com>
> ---
>   libsepol/cil/src/cil_resolve_ast.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index ea08087d..22d37f05 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -135,8 +135,11 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
>   				if (class_flavor == CIL_MAP_CLASS) {
>   					cil_log(CIL_ERR, "Failed to resolve permission %s for map class\n", (char*)curr->data);
>   					goto exit;
> +				} else if (class_flavor == CIL_CLASS) {
> +					cil_log(CIL_ERR, "Failed to resolve permission %s\n", (char*)curr->data);
> +					goto exit;
>   				}
> -				cil_log(CIL_WARN, "Failed to resolve permission %s\n", (char*)curr->data);
> +
>   				/* Use an empty list to represent unknown perm */
>   				cil_list_init(&empty_list, perm_strs->flavor);
>   				cil_list_append(*perm_datums, CIL_LIST, empty_list);
> 

You essentially want to revert commits 46e157b47, da51020d6, and 2eefb20d8 from 
back in July to November 2016.

I did not do a good job of specifying the motivation in the initial patch in 
that series, but here is Steve's reply to Steve Lawrence's understandable objection.

 From Steve Smalley's email "Re: [PATCH] libsepol/cil: Warn instead of fail if 
permission is not resolve" on 7/28/16
> The specific motivation for the change is that Fedora is trying to
> expunge permissions from its policy that were never upstream (e.g.
> ptrace_child in class process, compromise_kernel in class capability2,
> etc).  This presently breaks policy updates when there is a third party
> or local policy module already installed that was built against the
> older selinux-policy-devel that had those permissions.  What is worse is
> that rpm thinks that the policy was updated, since only semodule fails
> during %post, so you could easily brick a system this way on an upgrade
> because you'll end up running the old policy but rpm will think it has
> succeeded and proceed to install any other updated packages, which may
> depend on the new policy.


I would be fine with reverting the error handling back to what it was initially. 
It seems unlikely that we are still worried about local policy modules built on 
three year old policy.

Is this still a concern to anyone?
Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
