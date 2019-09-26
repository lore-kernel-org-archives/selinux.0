Return-Path: <SRS0=fLGi=XV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF855C4360C
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEDB222C0
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZxfubkiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfIZMyg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:54:36 -0400
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:51628 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfIZMyg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Sep 2019 08:54:36 -0400
X-EEMSG-check-017: 27743903|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,551,1559520000"; 
   d="scan'208";a="27743903"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2019 12:54:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569502475; x=1601038475;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9rASrrfrfsrpPyUpA94sJimAWn/d52e6bS/LscfGoSg=;
  b=ZxfubkiN0zyoUzfBTl/VpvFfUz3aN90UTIDLDKrvfs88ZYpLFZDPWlN7
   bththXmJAkwJ0zSwhNWRlKntdfq751hhxQM83g0SN4PSSYBU8S/UoK3VW
   3c9/OdqDZqg/oPtsyND1jNA83mH1OCnub0jas0FRzX7o7hVD8Kj5yJBWs
   rIUoby2DAJMCPvr9mqFYO2jMySKYw1rANyMLVcV6iqGAcotyzyTnriCKM
   YxprB7o/6Wj/82W4C9r2pz4m5veMViLfpD04pcjv1lnBu7WBoMySJPuH9
   pWtjeCX5/CudFF/gcq3j6uve8uE1qnj24REp11S9pSh/Fbc/Ap7W5i+Dz
   w==;
X-IronPort-AV: E=Sophos;i="5.64,551,1559520000"; 
   d="scan'208";a="33383515"
IronPort-PHdr: =?us-ascii?q?9a23=3AL/0beB2/VnT6WnB3smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIeL/ad9pjvdHbS+e9qxAeQG9mCsLQf16GL6OjJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe71/IRq5oQjRuMQdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9WooT5olcDqwa1CwuxC+P10jJGm2H43aM63e?=
 =?us-ascii?q?oiHw/J0gMvENASv3rbt9j1KKUfXPqpwKXUwzjObfVb0ir95ojSdRAhpOmBU6?=
 =?us-ascii?q?9sccXP0UkvFx3KjlONooL4OjOazOANs2yF4OtgSOmijHUnpBxqojW02sctip?=
 =?us-ascii?q?XGhoISylze8yV525w6Kce3SE58f96pCZ1dvDyZOYtuWs4uXm5ltSkgxrAGpJ?=
 =?us-ascii?q?K3ZjYGxZs5yxLFdvCKdZWD7Aj5W+aLOzh4gWpoeLe4hxmv70et0vb8Vsyo0F?=
 =?us-ascii?q?ZSqSpFj8XMumgN1xPN7siHTeNw/lu71jaV1gDT9/pELVoolavbN5Ehwrkwmo?=
 =?us-ascii?q?AVsUvfBS/5hF/6jKqXdkUg4uSo6uLnbav6ppKEKoN5hQ7zPr4ul8CiG+g0LA?=
 =?us-ascii?q?cDU3aB9eihzLHj+Ff2QLROjv04iKnZt5XaKNwApqGkGA9YyZoj6hajADem19?=
 =?us-ascii?q?QUh38HLElfdx6dgIjpPE/OLOjiDfijm1SsjCtrx/feM735BpXCNGXDkKv7fb?=
 =?us-ascii?q?lm8UFR0xAzws5C6JJUEL4BPOj/VVP2tNzdFhU5KRC7w/77CNVh0YMTQXmPDb?=
 =?us-ascii?q?GdMKPTt1+I++0uLvKSZI8apjn9MeIp5/3wgn8jn18SY62p0YEQaHCiEfQ1a3?=
 =?us-ascii?q?meNELhns1JNW4XohA0RefqwAmaVTdOe2y4Voom6z07AZ7gBoDGEMTlm7GF3S?=
 =?us-ascii?q?GmDrVIaW1cTFOBC3Hlc8ODQfhfRjiVJ5pajjEcVbWnA7Qk3BWquR6yn6FrNc?=
 =?us-ascii?q?LI6yYYstTlz9Ez6OrNw0JhvQdoBtiQhjneB1p/mXkFEnpvh/Fy?=
X-IPAS-Result: =?us-ascii?q?A2B+AQCDtIxd/wHyM5BmHAEBAQQBAQwEAQGBVgQBAQsBg?=
 =?us-ascii?q?XMqgUAyKoQijw1NAQEBAQEBBoE2iXWRKAkBAQEBAQEBAQE0AQIBAYQ/AoMxI?=
 =?us-ascii?q?zcGDgIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCZgEBAQECASMVUQsOCgICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+BdwUPrhpzgTKFTIM7gUiBDCgBjAsYeIEHgTiCaz6HT4I2I?=
 =?us-ascii?q?gSWBJcMgiyCLpJWBhuZK44bmyUigVgrCAIYCCEPgydQEBSCBo4pJAMwgQYBA?=
 =?us-ascii?q?Y10AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Sep 2019 12:54:35 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8QCsYoF003897;
        Thu, 26 Sep 2019 08:54:34 -0400
Subject: Re: [PATCH 2/2] policycoreutils/fixfiles: Force full relabel when
 SELinux is disabled
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20190924190854.245105-1-plautrba@redhat.com>
 <20190924190854.245105-2-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ccd7643c-75e7-266a-ff9c-825d76b8d688@tycho.nsa.gov>
Date:   Thu, 26 Sep 2019 08:54:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924190854.245105-2-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/24/19 3:08 PM, Petr Lautrbach wrote:
> The previous check used getfilecon to check whether / slash contains a label,
> but getfilecon fails only when SELinux is disabled. Therefore it's better to
> check this using selinuxenabled.

Thanks, applied both patches.

> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>   policycoreutils/scripts/fixfiles | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 678fca40..ab0848ff 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -313,8 +313,8 @@ case "$1" in
>   	> /.autorelabel || exit $?
>   	[ -z "$FORCEFLAG" ] || echo -n "$FORCEFLAG " >> /.autorelabel
>   	[ -z "$BOOTTIME" ] || echo -N $BOOTTIME >> /.autorelabel
> -	# Force full relabel if / does not have a label on it
> -	getfilecon / > /dev/null 2>&1  || echo -F >/.autorelabel
> +	# Force full relabel if SELinux is not enabled
> +	selinuxenabled || echo -F > /.autorelabel
>   	echo "System will relabel on next boot"
>   	;;
>       *)
> 

