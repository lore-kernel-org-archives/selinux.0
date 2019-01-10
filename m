Return-Path: <SRS0=duOh=PS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0944FC43387
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 18:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D4C206B7
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 18:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Nk1IAbmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfAJSL4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:11:56 -0500
Received: from uphb19pa09.eemsg.mail.mil ([214.24.26.83]:65031 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730735AbfAJSL4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 13:11:56 -0500
X-EEMSG-check-017: 244187928|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2019 18:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547143909; x=1578679909;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=kI4ANcG3KnaD+wANKyXdXdFlNiqZ2tGeRVZlsVCN+1A=;
  b=Nk1IAbmPwxHrx+kzZOrul/u4GiSBttodKcSm6R6rVGLIj/3oPTRmWvJl
   5JoAsSfUEevC6q7wniebNCnLnh/WkKCSQL0JW1Vrjfk4hyRAXVhJEe6I9
   Es2K1q8whAuQomXnfjFiQ6zuk6Gg5KSdR/ueODdpeZ0dfEtJUwDBUhI6G
   NbRsfGx17psI7b1ZwysHY/hAAjKlSsm3No2cgVXH2SDluWM7XLBmePFAE
   7yp/Ug24B8Jpx3L9341G5c+Dg/1ZHdGMzvWIiyNdKkCGyXkSQ1RiAehP7
   kH6BTrlrJ5B5MmCjbTtuQjmHddoBAgKNEImLdk9knx+o4KPjzf/eeFROd
   A==;
X-IronPort-AV: E=Sophos;i="5.56,462,1539648000"; 
   d="scan'208";a="22544893"
IronPort-PHdr: =?us-ascii?q?9a23=3AX9yqcRYYDqX+VptuKUN+CX//LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsW5bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Ses4URX?=
 =?us-ascii?q?daXsZJSSNOHp+8YYUID+oEJ+lYro/9rEYKoRaxAQSgAeXixTFShn/ywKY0ze?=
 =?us-ascii?q?IvHw/b1wAkBt4DsXHYodPoP6kQTO+11rHFwyjdYfNY2Tnz64bGfR4urv6OQb?=
 =?us-ascii?q?1+ftHcyVUsGg7fklmctYLoMjGT2+8Qs2ab9e1gVee3hmA6twF+vCCvxscyhY?=
 =?us-ascii?q?nPm4kb11XE+j99wIYxO9K5SFNwbNm/EJRNrCGXLJd2Q8M+TGFovyY20LsGuY?=
 =?us-ascii?q?WhcyQQx5QnwADfZuWBfoOV7BzjU+ORLi15hHJjYL+/iBey8VSgyu3hTca4yl?=
 =?us-ascii?q?dKri1dntnCqH8CyhvT6tKdRftl4Eih3i6P1wTN5e1eJkA0j6XbJpg8ybAzjp?=
 =?us-ascii?q?oeqVnPEyD5lUnsjKKaa18o9van5uj5eLnqu5mRPJJuhA7kKKQhgMm/DPw9Mg?=
 =?us-ascii?q?gJQmeU5/yx1Kbm/U3lWLVKieA2krXBvJDaO8sboqm5DhdJ0ok58Ra/Diqm0M?=
 =?us-ascii?q?8CkXkbLFNKZBKHj4/zN1HIPP/4Fuuwj06pkDdqw/DKJrzhApPTIXjfiLrtYL?=
 =?us-ascii?q?lw5kFGxAcz0NxT/YxYB74fLP7pR0P9rNnYAQU4MwywzebnEtJ91oYGVGKUH6?=
 =?us-ascii?q?CZK7jfsUOI5+0zI+mMY5UZuDDmK/c//fLugng5mUEFcamzwZQXcGy4HuhhI0?=
 =?us-ascii?q?iBeXrshs0OEXoWvgokV+PlkkaPUSRNaHmvX6Iz/C07BJi6AofEQ4CnmKaB0z?=
 =?us-ascii?q?ujHp1KemBGDUiBEWz2eIWAWvcMbj+SI8B6nzwaWriuVZUh2QuttADk0bpnKP?=
 =?us-ascii?q?Tb+ikCuZLkzth16L6bqRZnzTFoFYy52nyRVWt9lWNAEycy1b1ju0Z04k2O3a?=
 =?us-ascii?q?hxn7pTEtkFo7tyfyM7M4PMh7hhBtTzXB/RVsmGRUzgQdi8Bzw1CNUrzIldTV?=
 =?us-ascii?q?x6HoCZkh3b3yesS4QQnriPCY18prnQxFDtNs19zDDAz6BngF44FJgcfVa6j7?=
 =?us-ascii?q?JyolCAT7XClF+UwuP3Kqk=3D?=
X-IPAS-Result: =?us-ascii?q?A2CxBABfijdc/wHyM5BkHAEBAQQBAQcEAQGBZYFbKWZPM?=
 =?us-ascii?q?yeEAJQITAEBAQEBAQaBCC2JLJBGMgYBhEACgiUiOBIBAwEBAQEBAQIBbBwMg?=
 =?us-ascii?q?jopgmcBAQEBAgEjDwEFOhcJAg4KAgImAgJXBgEMCAEBgl8/AYF0BQgPkhSbY?=
 =?us-ascii?q?IEvhUKEcIELizQXeIEHgTiCNjWDHgIBhGmCVwKQdYQbjGUJhxmDTIcUBhiCM?=
 =?us-ascii?q?Y9LiW6EN1eNQiGBVisIAhgIIQ+DJwmIZIIwgV2EACEDMAEBAYECAQGJRwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jan 2019 18:11:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0AIBlLw030202;
        Thu, 10 Jan 2019 13:11:47 -0500
Subject: Re: RFC: introduce new library versions for added symbols
To:     Petr Lautrbach <plautrba@redhat.com>,
        SELinux <selinux@vger.kernel.org>
References: <pjdmuo8fl9s.fsf@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <391a8f7b-b8b0-32a4-29ff-f85eccec0712@tycho.nsa.gov>
Date:   Thu, 10 Jan 2019 13:13:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <pjdmuo8fl9s.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/19 12:57 PM, Petr Lautrbach wrote:
> I used abi-compliance-checker [1] and compared the latest sources with 
> 2.8 release [2].
> It looks like there's one symbol added to audit2why.so.

audit2why.so needs a .map file or equivalent; it shouldn't be exporting 
all of the libsepol.a symbols.  We don't guarantee ABI or API 
compatibility for anything not in libsepol.map.

> 
> Then I tried the same thing with 2.7 [3] and 2.6 [4] and noticed that
> there were added new symbols even to LIBSEMANAGE_1.0 while since 2.3
> there's already LIBSEMANAGE_1.1.
> It's a bug which breaks automatic dependency checking. So I propose
> to fix symbol version mappings in order to be in relation with the
> release where they was introduced, e.g. for libsemanage:
> 
> diff --git a/libsemanage/src/libsemanage.map 
> b/libsemanage/src/libsemanage.map
> index 02036696..45e90215 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -18,8 +18,6 @@ LIBSEMANAGE_1.0 {
>           semanage_root;
>           semanage_user_*; semanage_bool_*; semanage_seuser_*;
>           semanage_iface_*; semanage_port_*; semanage_context_*;
> -         semanage_ibpkey_*;
> -         semanage_ibendport_*;
>           semanage_node_*;
>           semanage_fcontext_*; semanage_access_check;          
> semanage_set_create_store;
>           semanage_is_connected; semanage_get_disable_dontaudit; 
>           semanage_set_disable_dontaudit;
> @@ -63,3 +61,19 @@ LIBSEMANAGE_1.1 {
>           semanage_module_remove_key;
>           semanage_set_store_root;
> } LIBSEMANAGE_1.0;
> +
> +LIBSEMANAGE_2.5 {
> +  global:
> +    semanage_module_extract;
> +} LIBSEMANAGE_1.1;
> +
> +LIBSEMANAGE_2.7 {
> +  global:
> +         semanage_ibpkey_*;
> +         semanage_ibendport_*;
> +} LIBSEMANAGE_2.5;
> +
> +LIBSEMANAGE_2.8 {
> +  global:
> +    semanage_fcontext_list_homedirs;
> +} LIBSEMANAGE_2.7;
> 
> 
> If this is acceptable, I would prepare a patch with symbol versions
> starting with 2.5 as LIBSEMANAGE_1.1 was introduced in 2.4.

Will this break compatibility for binaries built against earlier versions?

> 
> [1] http://lvc.github.io/abi-compliance-checker/
> [2] 
> https://plautrba.fedorapeople.org/selinux/compat_reports/2.8_to_2.9-rc0/compat_report.html 
> 
> [3] 
> https://plautrba.fedorapeople.org/selinux/compat_reports/2.7_to_2.9-rc0/compat_report.html 
> 
> [4] 
> https://plautrba.fedorapeople.org/selinux/compat_reports/2.6_to_2.9-rc0/compat_report.html 
> 
> 
> Petr

