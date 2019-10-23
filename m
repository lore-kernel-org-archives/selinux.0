Return-Path: <SRS0=o958=YQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD57CA9EB6
	for <selinux@archiver.kernel.org>; Wed, 23 Oct 2019 14:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E19521906
	for <selinux@archiver.kernel.org>; Wed, 23 Oct 2019 14:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZtXN9FUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391097AbfJWOXN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:23:13 -0400
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:54393 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJWOXM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Oct 2019 10:23:12 -0400
X-EEMSG-check-017: 20156883|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,221,1569283200"; 
   d="scan'208";a="20156883"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Oct 2019 14:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571840589; x=1603376589;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=aDiUQo1Z78/vjsIxuiJ4OYJ+2B+S7IrAis/p5ec51Hs=;
  b=ZtXN9FUUC+k7R1zf7rQpSyYuRoBlRRqkV2nIZpePZ76gPB67fWKFUFPf
   71A79PVuF36DuCGxm+9jCtDTX8tuSB374CTo7N6jvZtqaWEBdZtGHWtU8
   oF0IAoxolicLOQTfSG2/IFuROo0qAk2lZr9JKu3mauxdQ6l8mK08esMxR
   aCa3DSUxJDd6fc5GlejZaPYaw6DKyVJc2EvsnWMzPnnSXA3pVyemicdPc
   MwgztZhsWUp+7R2+vr0Vp9RAHj79X5bimAFVMFXdQKJsJp8EWaxIsnoDM
   dNdce3eX77llAv1oLiOh2rtvHnU4SsJnZx9LkaxWBfwBesYNapwCegELj
   w==;
X-IronPort-AV: E=Sophos;i="5.68,221,1569283200"; 
   d="scan'208";a="29302999"
IronPort-PHdr: =?us-ascii?q?9a23=3AJo+NwhATQX8rMRODC5Y5UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX+r8bcNUDSrc9gkEXOFd2Cra4d0KyG4uu/BSQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Nha7oAHeusQUjoZpN7o8xA?=
 =?us-ascii?q?bOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPW?=
 =?us-ascii?q?Y15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RT?=
 =?us-ascii?q?iu86FmQwLzhSwZKzA27n3Yis1ojKJavh2hoQB/w5XJa42RLfZyY7/Rcc8fSW?=
 =?us-ascii?q?dHUMlRTShBCZ6iYYUJAeQKIOJUo5DzqlYKqBezAxSnCuHyxT9SnnL4wLM00+?=
 =?us-ascii?q?ohHw/F0gIvEd0Bv3bIo9v6L6oSTeK4wbPUwTnfYf5b2zHw45XIfBA7pvGMWK?=
 =?us-ascii?q?p9f9fNyUYxDwPFjkufqYr4ND2I0+QCqWyb7+5+WuOvlmUqrBpxrSW0xso3lo?=
 =?us-ascii?q?nIhp4aylDD9SljxoY1Pse3RFR0Yd6jDptdrieXPJZ4TMMlRmFnoic6yrsetJ?=
 =?us-ascii?q?60fSgK1JQnxwPEZPCdb4eI5RfjWeCMKjl7nHJoYK+zihm9/ES6yuDwS9O43E?=
 =?us-ascii?q?hFoyZbiNXAq3YA3AHJ5MedUPty5EKh1C6K1wDU9+5LP1g5lbHeK5492r4wkY?=
 =?us-ascii?q?cTsVjbEi/2hkr2iKiWe104+uey8eTnY6jmpoSGO49oigDxLqQumsulDeQ+Lg?=
 =?us-ascii?q?cORHSU9f651L3i+U31WLRKjvsonanFqJ3WOMsWq6GjDwJVz4ov8QizAji43N?=
 =?us-ascii?q?gCgHULNFdFdwiGj4jtNVHOOvf4DfKnjlS3jThr3OvLPqHhA5rRLnjDl63tfb?=
 =?us-ascii?q?Bm60FG0gYzwtdf54xMBrEbPP3zQlPxtMDfDhIhMQy72f3nCNJ71o4FQWKAHL?=
 =?us-ascii?q?WZMK3TsV+O5+IvJO+MaJUJtzb6Lvgv/+TugmMhmV8BYamp2oMaaGumEfRiIk?=
 =?us-ascii?q?WZZ2fsg9gaHGcUsQoxUvbqhEeBUTFNfXayWbwz5jUhBIKhF4fDSdPlvLvU/i?=
 =?us-ascii?q?6gGZseVGlDA1bERXXhbIKCc+8BciyTJM5mlHoPUr33D8c62BWvshLq46RoI/?=
 =?us-ascii?q?CS+SACs5/nkt9v6Kmbtxg3+Cc8JM2Hz2yXBzV2gWgBXSNs9Lxuqkx6jFGY2O?=
 =?us-ascii?q?53hOIORvJJ4PYcaRs3LZ7RyaRBDtn2Xg/QNoOSRE2OXsStATZ3SMk4hdAJfR?=
 =?us-ascii?q?AuSJ2Zkhnf0n/yUPcunLuRCclxq/mN0g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CCAAAAYbBd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWgGA?=
 =?us-ascii?q?QELAYFzLGxUMiqEJ45vVAaBNol9jzSBewkBAQEBAQEBAQErCQECAQGDe0UCg?=
 =?us-ascii?q?zQkNQgOAgwBAQEEAQEBAQEFAwEBbIU3DII6KQGCbQEFIxVRCxgCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/AYJSJQ+yHoEyhDkBgRSDMYFCBoEOKAGMDhh4gQeBESeCaz6CY?=
 =?us-ascii?q?gKBKoNHgl4EjQSITmGBNJV3gi6CMoRcjhIGG5lOjjaIJ5McATaBWCsIAhgII?=
 =?us-ascii?q?Q+DJ1AQFIMSF4NQim8lAzCBBgEBjGMqgjEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 23 Oct 2019 14:23:08 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9NEN7P1011572;
        Wed, 23 Oct 2019 10:23:07 -0400
Subject: Re: [PATCH] policycoreutils: semodule: Enable CIL logging
To:     Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org,
        James Carter <jwcart2@tycho.nsa.gov>
References: <20191021055505.25372-1-jason@perfinion.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e3c0bd92-7fc8-78f2-eabb-867142a5e660@tycho.nsa.gov>
Date:   Wed, 23 Oct 2019 10:23:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021055505.25372-1-jason@perfinion.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/21/19 1:55 AM, Jason Zaman wrote:
> semodule -v will turn on semodule's own verbose logging but not logging
> from CIL. This change makes the verbose flag also set cil's log level.
> 
> By default (ie no -v flag), this will enable CIL_ERR, and each -v will
> increase the level from there.
> 
> Tested with a duplicated fcontext in the policy.
> Before this change:
>      # semodule -v -B
>      Committing changes:
>      Problems processing filecon rules
>      Failed post db handling
>      semodule:  Failed!
> 
> After this change:
>      # semodule -v -B
>      [ ... snip ... ]
>      Found conflicting filecon rules
>        at /var/lib/selinux/mcs/tmp/modules/400/mycustom/cil:159
>        at /var/lib/selinux/mcs/tmp/modules/400/mycustom/cil:158
>      Problems processing filecon rules
>      Failed post db handling
>      semodule:  Failed!
> 
> Closes: https://github.com/SELinuxProject/selinux/issues/176
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> ---
> 
> I also opened a PR here to run travis tests: https://github.com/SELinuxProject/selinux/pull/182
> 
> This only affects semodule -v, I tested out setsebool and it doesnt die
> on a duplicated fcontext so I skipped it there. Should all the tools set
> it or only as-needed? Do we want to make some general guidelines for
> what kind of tools should set the CIL logging?

Thanks, applied. Not sure about whether other tools should set the cil 
log level.  I think current cil logging leaves a lot to be desired, 
especially since the pathnames identified in the output when invoked 
from semodule/libsemanage are temporary.  It would be preferable IMHO to 
display the actual conflicting rules themselves and not just the file 
name and line number.

> 
> -- Jason
> 
> 
>   policycoreutils/semodule/semodule.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index a76797f5..a1f75e16 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -22,6 +22,7 @@
>   #include <libgen.h>
>   #include <limits.h>
>   
> +#include <sepol/cil/cil.h>
>   #include <semanage/modules.h>
>   
>   enum client_modes {
> @@ -238,7 +239,7 @@ static void parse_command_line(int argc, char **argv)
>   			set_mode(LIST_M, optarg);
>   			break;
>   		case 'v':
> -			verbose = 1;
> +			verbose++;
>   			break;
>   		case 'r':
>   			set_mode(REMOVE_M, optarg);
> @@ -350,6 +351,8 @@ int main(int argc, char *argv[])
>   	}
>   	parse_command_line(argc, argv);
>   
> +	cil_set_log_level(CIL_ERR + verbose);
> +
>   	if (build)
>   		commit = 1;
>   
> 

