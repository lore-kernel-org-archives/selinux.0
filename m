Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D967C33CAC
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF97024689
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="PauQLmzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfLMUsr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:48:47 -0500
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:1205 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMUsr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 15:48:47 -0500
X-EEMSG-check-017: 61455187|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,311,1571702400"; 
   d="scan'208";a="61455187"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Dec 2019 20:48:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576270126; x=1607806126;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=bwBedYsrVvjgtxGTGy+E6bc+20Ok4RUEWV74MaG8D+8=;
  b=PauQLmzXFAsBGpjaOrfvavJWzjxeu5rIrWx4LJdKZLm70rEAjp1Tglhq
   7e17mo+ftKRIsPvxgLDTw4QIlX8Ii0csOhAM3Ev6nKHhlqnlCTtI+5d47
   o1/LVrgLfuv2a2XW8GHLF6GTVglp9JJZ2ZDMgh1EpssoplMFwwD/8x5ka
   YBRRbvkc1u0b99qnIs7yx9MqpUZz059M9fNMQBY80HuyIwbu+LxqebQuH
   DgU5kCws54IKFDEAfya6tWzYNQiyPlcOd/oKd2FSnFCKlruhHZbNqr6zi
   kL+CN6An/c/QzGsQvGxv3o67FEr29FJLs7tbMFYj0niUPuwHSIra+NNuP
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,311,1571702400"; 
   d="scan'208";a="36741532"
IronPort-PHdr: =?us-ascii?q?9a23=3ADYCE3h/WWp1QVf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20+IcTK2v8tzYMVDF4r011RmVBN6dsqMVwLOK6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe65+IRGyoAneq8UbjpduIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWMheVzZFAoihcYUBCeQPNvtco4XkqVYDqR6yCA+xD+3t1zBInGf707Ak3e?=
 =?us-ascii?q?QvEQ/I3wIuENwBv3vWsNr7O7wfUfy3waTS0TnPc/1b1DX75YPVch4hu/aMXb?=
 =?us-ascii?q?dofMTM1UkgCRvFjlWOpozjIjiby+ENvHKf7+pkS+2ui3MspgZqojey3cchkZ?=
 =?us-ascii?q?XJh4IJxVDE8iV12oA1JcaiR0Jhbt6kF4VQujicOoBrQc0iW3lltDs1x7AJo5?=
 =?us-ascii?q?K2fDUGxI45yxPQdfCLaZWE7xT+X+iLOzh4nmhqeLeniha39kiv1/PzW9Gv0F?=
 =?us-ascii?q?ZPsipFit7Mtm0R1xDL6siIVP99/kC51DaTzQ/T8OBEIV0vlabBKp4hxLAwlp?=
 =?us-ascii?q?0IsUvdAiD6gln2ja+KeUUk/eik8eLnban9ppCALYN0jwD+MqA2lsy+B+Q3LB?=
 =?us-ascii?q?QOUnCG9emz27Dv5030TKhQgvEonaTVrorWKdkDqq68GQBV04Ij6xilDzeh1d?=
 =?us-ascii?q?QVhWIHI09eeB+ck4joO03BIPD/DfulhVSsiy1ky+rJPr3mHJXBNmLDn6v5fb?=
 =?us-ascii?q?Zh905czxI+zdda55JTEbEBJuj8VVPvu9HDFB82LRG7w+b9B9VhzI8RRWWPAq?=
 =?us-ascii?q?qBOqPIrVCI/v4vI/WLZIINozbyNfwl5//ojX8kll4QZrep3ZQJZ3CiBPhmIF?=
 =?us-ascii?q?uWYWDqgtgfFWcGpA0+TPbliA7KbTkGQHC+Ra8+rhQ8E4SvBorADtSqhbua2i?=
 =?us-ascii?q?6wE7VMa2xGA0zKGnDtIcHMQPoIaSSPMud/nTEeE7usUYks0VeprgCp5aBgK7?=
 =?us-ascii?q?/v5iAAtZ/lnONw7unXmAB6oSd4FOyBwmqNSCdyhWpOSDgoivMs6Xdhw0uOhP?=
 =?us-ascii?q?Ary8dTEsZesrYQCVY3?=
X-IPAS-Result: =?us-ascii?q?A2DNAACN+PNd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gWwBIBIqhAOJA4Z2BoESJYlpkUUJAQEBAQEBAQEBNwEBhEACgjM4E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIxVRCw4KAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJfP4JTJa04gTKFT4M3gUiBDiiMMnmBB4E4DAOCXT6HWYJeBJcJRpcpgjqCP?=
 =?us-ascii?q?5M/BhuaRy2OH5xWIoFYKwgCGAghD4MnUBEUm3YjAzCPTwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Dec 2019 20:48:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBDKmUg8137225;
        Fri, 13 Dec 2019 15:48:31 -0500
Subject: Re: [PATCH testsuite] selinux-testsuite: fix tun_tap checks
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191213091733.1058949-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <dd9ad82c-9970-fd7b-732e-e7447efadcd8@tycho.nsa.gov>
Date:   Fri, 13 Dec 2019 15:49:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213091733.1058949-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/13/19 4:17 AM, Ondrej Mosnacek wrote:
> The attach_queue permission was introduced later than the tun_socket
> class itself. So check for that instead of the class, since the policy
> fails to build without it.
> 
> Fixes: 4e0f6d5a52d2 ("selinux-testsuite: Add TUN/TAP driver tests")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   policy/Makefile | 2 +-
>   tests/Makefile  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index f0de669..909594a 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -101,7 +101,7 @@ ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && ech
>   TARGETS+=test_module_load.te
>   endif
>   
> -ifeq ($(shell grep -q tun_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +ifeq ($(shell grep -q attach_queue $(POLDEV)/include/support/all_perms.spt && echo true),true)
>   TARGETS += test_tun_tap.te
>   endif
>   
> diff --git a/tests/Makefile b/tests/Makefile
> index 9a890be..45c9885 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -79,7 +79,7 @@ SUBDIRS+=module_load
>   endif
>   endif
>   
> -ifeq ($(shell grep -q tun_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +ifeq ($(shell grep -q attach_queue $(POLDEV)/include/support/all_perms.spt && echo true),true)
>   SUBDIRS += tun_tap
>   endif
>   
> 

