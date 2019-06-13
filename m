Return-Path: <SRS0=L/M1=UM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA1FC31E45
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 19:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED73207E0
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 19:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="bIBbn7Q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfFMTu7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:50:59 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:38653 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfFMTu6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jun 2019 15:50:58 -0400
X-EEMSG-check-017: 720382170|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,370,1557187200"; 
   d="scan'208";a="720382170"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jun 2019 19:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560455456; x=1591991456;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=lpI7RixlBtuMU+lYp+W10ifohfraQESZzGeBPqPRPbk=;
  b=bIBbn7Q4W1+kOLXfiGO/YYlnezZQ1VcwbGYIPi/aKgDCCgkQUQxx8ZQm
   yj8t9wGJtOFa0JWWkp/lJL26QP5FvlOZefnutBN+XqguYLcKb5BNayKwv
   fneZQIBp2HxKDRfpHuPGkXDQh1Y5YIdvh6WsG9PT99Vfj+d4iT7FYj2NH
   7vye4R+cBToYPViBc4eBvnSKT0gh6jycCozDsKnmISPPEBtzVJcIupHmj
   o1FlcQwgOoLKv3hYAi/j2ZvTaE5oED5b5mBE5E80Cv+L+s1F0XtzkukIo
   l5NbflO0MPP1J9BJ6E+l6eeaG6n8UQaFfu9wv1fxC7jV3PaWmf5xVYWqK
   w==;
X-IronPort-AV: E=Sophos;i="5.63,370,1557187200"; 
   d="scan'208";a="28950284"
IronPort-PHdr: =?us-ascii?q?9a23=3AvYYBgx+74fc5v/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20OocTK2v8tzYMVDF4r011RmVBNydsq8VwLON4ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVmTaxe65+IRWyoAneq8Ubj49vIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWMheVzZFAoihcYUBCeQPNvtco4XkqVYDqR6yCA+xD+3t1zBInGf707Ak3e?=
 =?us-ascii?q?QvEQ/I3wIuENwBv3vWsNr7O7wfUfy3waTS0TnPc/1b1DX75YPVch4hu/aMXb?=
 =?us-ascii?q?dofMrTx0ggCxnKjk+MqYD7IjiY0eYNsmaH4OV6T+Kvl3Arphptojmv2sgsio?=
 =?us-ascii?q?7JipgTylDf7yp12ok1JdqmSENiZ9OvDZVetyafN4RsQ8MiRXlltzo9yr0At5?=
 =?us-ascii?q?63ZTMKx4g9yB7ZcfCHd5OH7xT+X+iSOTd1nG9pdb2wihqo8UWs1/fwWte73V?=
 =?us-ascii?q?pUtCZJj9/BvW0X2RPJ8MiIUP5981+k2TaIyg/c9PlJIVsxlarHM54hxaMwlo?=
 =?us-ascii?q?YLvUTDACD2nEL2gbeKdko+4Oio6vnnYq78qp+AN457lgH+MqM0lsy5Hes4KR?=
 =?us-ascii?q?QBU3Ke+eS90L3v5Uz5QLNUgf0qiqTVrZ/XKMsBqqO5HgNZyJgv5hmhAzu8zd?=
 =?us-ascii?q?gUhXwHI0hEeBKDgYjpIVbOIPXgAPe9jVWjjC1kx+raPrH/GZjNMnjCn6vhfb?=
 =?us-ascii?q?Z68UJczhEzwspF65JbDbEBPur/WlXtu9zAEh85Lwu0zv7gCNV40YMeQmSPDb?=
 =?us-ascii?q?WFP6zMqlKI/PwgLPSMZIAPpDbxMeQq5/nrjXUhg18SYbGp3YcLaHC/BvlmOF?=
 =?us-ascii?q?uWYX7tgtcHDGcLsREzTPLliFKcSz5ffXWyULwm5jE9Fo2mCZ3PRoe3gLyOj2?=
 =?us-ascii?q?+HGchxYGxcB1LENHDzcYyPVvREPCWXJdRnmzcJfaKsR48oyVelswqsj/J8I+?=
 =?us-ascii?q?7V/DAInYzs2cIz5ODJkxw2sztuAJezyWaIGmNrlWoSW2V+iKJgqkVn1g2rzb?=
 =?us-ascii?q?lzg/seE8daofxOTFFpZtbn0+VmBoWqCUr6ddCTRQPjG473DA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B4DwDxpwJd/wHyM5BlHQEBBQEHBQGBZYFnKoE7ATIoh?=
 =?us-ascii?q?BaSdoINmlwJAQEBAQEBAQEBNAECAQGCEoIuAoJJIzgTAQMBAQEEAQEBAQMBA?=
 =?us-ascii?q?WwogjopAYJmAQEBAQIBIwQRRgsLCQUKAgImAgJXBgEMBgIBAYJfP4F8D6taf?=
 =?us-ascii?q?jOFR4MigUaBDCiLXYFWQIERJ4JrPoEXgnaDQYJYBIEtAYo1iDuVLgYDghKLI?=
 =?us-ascii?q?INzhDMGG4ImL4ZTjgSNG5hgIYFYKwpBSoEegU6CRo4oIwMwgQYBAY1bglIBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Jun 2019 19:50:56 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5DJosu7031187;
        Thu, 13 Jun 2019 15:50:54 -0400
Subject: Re: [Non-DoD Source] [PATCH userspace v4 2/4] libsemanage: optionally
 optimize policy on rebuild
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190613114558.32621-1-omosnace@redhat.com>
 <20190613114558.32621-3-omosnace@redhat.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <0e7cdb7f-b4a1-8ac7-e837-9bbb7523f4ff@tycho.nsa.gov>
Date:   Thu, 13 Jun 2019 15:51:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613114558.32621-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/13/19 7:45 AM, Ondrej Mosnacek wrote:
> When building binary policy, optionally run it through
> sepol_policydb_optimize() just before writing it out.
> 
> Add an optimize-policy variable to semanage.conf(5) that controls

Sorry I didn't notice this in v3, but why not use "optimize" instead of 
"optimize-policy"?

Jim

> whether optimization will be applied during libsemanage operations.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   libsemanage/man/man5/semanage.conf.5 |  5 +++++
>   libsemanage/src/conf-parse.y         | 15 ++++++++++++++-
>   libsemanage/src/conf-scan.l          |  1 +
>   libsemanage/src/direct_api.c         |  7 +++++++
>   libsemanage/src/semanage_conf.h      |  1 +
>   5 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
> index 8f8de55a..8efc7dd5 100644
> --- a/libsemanage/man/man5/semanage.conf.5
> +++ b/libsemanage/man/man5/semanage.conf.5
> @@ -121,6 +121,11 @@ and by default it is set to "false".
>   Please note that since this option deletes all HLL files, an updated HLL compiler will not be able to recompile the original HLL file into CIL.
>   In order to compile the original HLL file into CIL, the same HLL file will need to be reinstalled.
>   
> +.TP
> +.B optimize-policy
> +When set to "true", the kernel policy will be optimized upon rebuilds.
> +It can be set to either "true" or "false" and by default it is set to "false".
> +
>   .SH "SEE ALSO"
>   .TP
>   semanage(8)
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index b527e893..9bf9364a 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -59,7 +59,7 @@ static int parse_errors;
>           char *s;
>   }
>   
> -%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT
> +%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY
>   %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
>   %token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
>   %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
> @@ -95,6 +95,7 @@ single_opt:     module_store
>   	|	bzip_blocksize
>   	|	bzip_small
>   	|	remove_hll
> +	|	optimize_policy
>           ;
>   
>   module_store:   MODULE_STORE '=' ARG {
> @@ -268,6 +269,17 @@ remove_hll:  REMOVE_HLL'=' ARG {
>   	free($3);
>   }
>   
> +optimize_policy:  OPTIMIZE_POLICY '=' ARG {
> +	if (strcasecmp($3, "false") == 0) {
> +		current_conf->optimize_policy = 0;
> +	} else if (strcasecmp($3, "true") == 0) {
> +		current_conf->optimize_policy = 1;
> +	} else {
> +		yyerror("optimize-policy can only be 'true' or 'false'");
> +	}
> +	free($3);
> +}
> +
>   command_block:
>                   command_start external_opts BLOCK_END  {
>                           if (new_external->path == NULL) {
> @@ -352,6 +364,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
>   	conf->bzip_small = 0;
>   	conf->ignore_module_cache = 0;
>   	conf->remove_hll = 0;
> +	conf->optimize_policy = 0;
>   
>   	conf->save_previous = 0;
>   	conf->save_linked = 0;
> diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
> index 607bbf0b..b06a896c 100644
> --- a/libsemanage/src/conf-scan.l
> +++ b/libsemanage/src/conf-scan.l
> @@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
>   bzip-blocksize	return BZIP_BLOCKSIZE;
>   bzip-small	return BZIP_SMALL;
>   remove-hll	return REMOVE_HLL;
> +optimize-policy return OPTIMIZE_POLICY;
>   "[load_policy]"   return LOAD_POLICY_START;
>   "[setfiles]"      return SETFILES_START;
>   "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index c58961be..0153091f 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1461,6 +1461,13 @@ rebuild:
>   
>   		cil_db_destroy(&cildb);
>   
> +		/* Remove redundancies in binary policy if requested. */
> +		if (sh->conf->optimize_policy) {
> +			retval = sepol_policydb_optimize(out);
> +			if (retval < 0)
> +				goto cleanup;
> +		}
> +
>   		/* Write the linked policy before merging local changes. */
>   		retval = semanage_write_policydb(sh, out,
>   						 SEMANAGE_LINKED);
> diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
> index c99ac8c7..23c4b8b4 100644
> --- a/libsemanage/src/semanage_conf.h
> +++ b/libsemanage/src/semanage_conf.h
> @@ -47,6 +47,7 @@ typedef struct semanage_conf {
>   	int bzip_small;
>   	int remove_hll;
>   	int ignore_module_cache;
> +	int optimize_policy;
>   	char *ignoredirs;	/* ";" separated of list for genhomedircon to ignore */
>   	struct external_prog *load_policy;
>   	struct external_prog *setfiles;
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
