Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D186C43215
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F212075C
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ALWSZeNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK0PQf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:16:35 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:47902 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0PQf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 10:16:35 -0500
X-EEMSG-check-017: 55284242|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="55284242"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2019 15:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574867791; x=1606403791;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cPLnHgz+UEIEaVEvc0lotQY5BDVbebTFDDbjC1JxVZ4=;
  b=ALWSZeNva/aPUskG+aoQObz7r9ibE/ogLe7QWLUT0CEa4G7f5c1a5obD
   g9uPHHo0WHtcjaRJ3YwWRSTQvUI8fSdDD2EaBB+03U9CGeN9pn2Bkfpoo
   Q4ceSBD231zwhofI9yZJKTG5jDfPd3z9HfTgE1zcjfdmkvKLyaRv/c7DX
   U/PieJAtXdBF0q6QN7Kwe8wB4Lr+oWDADy4kN/Xyc/m86CI73+ng5COxd
   4oJp2gx8rC7PNJe8JLbPj7MvIu+W2lVAbtNOzrtyBX1zAPX6GiDRYDKHU
   +QlgYvUzT0PVbLfN75fGGTuktJnvI07tiIn76o+/VeA5bbaCEmOVHXb5q
   A==;
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="30559092"
IronPort-PHdr: =?us-ascii?q?9a23=3AZN/mqBSJ8wiwHODdo4pdi4NERtpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zbBeN2/xhgRfzUJnB7Loc0qyK6vumADJdqsnZ+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLq8UbgItvJqkzxx?=
 =?us-ascii?q?fVv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAeoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lp?=
 =?us-ascii?q?sVsUTNGS/2g1v5g7OMekU4+umn9+TnYrL8qp+aK4B0kR3xPr4rmsy+BeQ0Kg?=
 =?us-ascii?q?kOX26F9uSgzLDv4EL0TbpQgvA2j6XVqo7WKMsFqqKjHgNZyoMj5Ay+Dzei3t?=
 =?us-ascii?q?QYh34HLFdddRKckofpIErDIOz4DPijg1Ssly1nx/bdPrL7GJnNIX/DkKn5cb?=
 =?us-ascii?q?Zn90Fc0BYzzcxY559MDbEBJfXzWlT3tNPCEhA2LRe5w/z5B9pg1oMRQ36PDr?=
 =?us-ascii?q?WFP6PVtF+C/vgvLPWUZI8JpDb9LOAo5+Xwgn89mF8de7Sp3JQMZXCmEfRpPV?=
 =?us-ascii?q?+ZbWDvgtgfC2cKuBQxTOjwhF2FSz5TaG64X7gg6TEjFIKmEYDDS5i3gLyAwC?=
 =?us-ascii?q?i7HodZZnpbBV+UDXjnb4WEVO0NaCKUPMBhiScJWqO9S48g0xGuqBH1y6BhLu?=
 =?us-ascii?q?XK5i0Ur47s1N9w576bqRZn0jp4Fcmfm0SKVGd9lW4LD2sx2adkp0V2x3+Z3K?=
 =?us-ascii?q?R4iuAeHttWsbcBSQo+NJjB38RkBN3oHAHMZNGETBChWNr1Lys2S4cK39IWY0?=
 =?us-ascii?q?t7U+6nhxTH0jviV6QZjJSXFZc09eTaxHG3KMFjnSWVnJI9hkUrF5McfVatgb?=
 =?us-ascii?q?Ryok2KXN/E?=
X-IPAS-Result: =?us-ascii?q?A2BIAABHkt5d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQriQOGWgaBN4lpiiCHJAkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCJDgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJuAQUjFUEQCw4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfP4JHAwklslaBMoVPg0OBSIEOKIwweYEHgTgPgl0+ghuFPoJeB?=
 =?us-ascii?q?JZjRpcQgjeCOZMXBhuCQIwpizYtjhuBQppjIoFYKwgCGAghD4MnUBEUlSwjA?=
 =?us-ascii?q?zCOPQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Nov 2019 15:16:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xARFGRPt007630;
        Wed, 27 Nov 2019 10:16:27 -0500
Subject: Re: [PATCH testsuite v5] policy: use the kernel_request_load_module()
 interface
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
References: <20191127123319.814863-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3c4cc54b-bad1-e72f-85c2-7742cbd3c425@tycho.nsa.gov>
Date:   Wed, 27 Nov 2019 10:16:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127123319.814863-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/27/19 7:33 AM, Ondrej Mosnacek wrote:
> ...instead of open-coding the rules. Also define a fallback to allow the
> policy to build even if the interface is not defined.
> 
> Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
> Cc: Richard Haines <richard_c_haines@btinternet.com>
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
> 
> Change in v5: call the macro only once for the whole domain
> Change in v4: fix copy-paste mistakes spotted by Richard
> Change in v3: use different approach as suggested by Stephen
> Change in v2: update also tests/Makefile for consistency
> 
>   policy/test_key_socket.te | 8 +++-----
>   policy/test_policy.if     | 6 ++++++
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
> index cde426b..64d2cee 100644
> --- a/policy/test_key_socket.te
> +++ b/policy/test_key_socket.te
> @@ -12,8 +12,6 @@ typeattribute test_key_sock_t keysockdomain;
>   # key_socket rules:
>   allow test_key_sock_t self:capability { net_admin };
>   allow test_key_sock_t self:key_socket { create write read setopt };
> -# For CONFIG_NET_KEY=m
> -allow test_key_sock_t kernel_t:system { module_request };
>   
>   ################## Deny capability { net_admin } ##########################
>   #
> @@ -29,7 +27,6 @@ typeattribute test_key_sock_no_net_admin_t testdomain;
>   typeattribute test_key_sock_no_net_admin_t keysockdomain;
>   
>   allow test_key_sock_no_net_admin_t self:key_socket { create write read setopt };
> -allow test_key_sock_no_net_admin_t kernel_t:system { module_request };
>   
>   ####################### Deny key_socket { create } ##########################
>   type test_key_sock_no_create_t;
> @@ -50,7 +47,6 @@ typeattribute test_key_sock_no_write_t keysockdomain;
>   
>   allow test_key_sock_no_write_t self:capability { net_admin };
>   allow test_key_sock_no_write_t self:key_socket { create read setopt };
> -allow test_key_sock_no_write_t kernel_t:system { module_request };
>   
>   ####################### Deny key_socket { read } ##########################
>   type test_key_sock_no_read_t;
> @@ -61,10 +57,12 @@ typeattribute test_key_sock_no_read_t keysockdomain;
>   
>   allow test_key_sock_no_read_t self:capability { net_admin };
>   allow test_key_sock_no_read_t self:key_socket { create write setopt };
> -allow test_key_sock_no_read_t kernel_t:system { module_request };
>   
>   #
>   ########### Allow these domains to be entered from sysadm domain ############
>   #
>   miscfiles_domain_entry_test_files(keysockdomain)
>   userdom_sysadm_entry_spec_domtrans_to(keysockdomain)
> +
> +# For CONFIG_NET_KEY=m
> +kernel_request_load_module(keysockdomain)
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index e1175e8..3f163cb 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -82,3 +82,9 @@ interface(`userdom_search_admin_dir', `
>       userdom_search_user_home_content($1)
>   ')
>   ')
> +
> +# If the macro isn't defined, then most probably module_request permission

Sorry, I should have caught this earlier.  m4 does not do the right 
thing with embedded quotes in comments, so you can get weird effects 
after macro expansion.  I'd expand it to "is not" to be safe.

> +# is just not supported (and relevant operations should be just allowed).
> +ifdef(`kernel_request_load_module', `', ` dnl
> +interface(`kernel_request_load_module', `')
> +')
> 

