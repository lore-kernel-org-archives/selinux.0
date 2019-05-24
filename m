Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A32C072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 17:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C4C2175B
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 17:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="SDuy0veh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfEXRHp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 13:07:45 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:59022 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfEXRHp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 May 2019 13:07:45 -0400
X-EEMSG-check-017: 713896830|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,507,1549929600"; 
   d="scan'208";a="713896830"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 May 2019 17:07:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558717656; x=1590253656;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=RvFHnHDQ7GfWMU3PKpjeOHXlJMKLN8ZJgBOq1Um03f8=;
  b=SDuy0vehY7kpMz51Xhu7/g8zSTgrZJaUDxfhuVekRNqsq+nnxQf8n8cJ
   QqLTGHBcH1+I/5d7ihAz/lWiXOZ+Y8NiupgBdHnPGPEi9eYPxQzN/YG4+
   8RwBzQ+YV9sgqMA5SS62LJkEkdDVT8LacNZUAcoyLNkL343po6JTkBHT5
   C3h6fByhQ7hiIkpKgISiK18l09/KE4C/CQBwEFVB2iXctjYYRYIDbM/dw
   LXzhiWOxx7VCtsqGyvDPWrANslZEUooZ7WMZZmY0ELX7/Vrsd9dgZBanY
   LA4PWCkaP4x8JN9+dYczG7DtVAEdTRSlynSj76+DjCjBEnZ4p/NrccHTh
   w==;
X-IronPort-AV: E=Sophos;i="5.60,507,1549929600"; 
   d="scan'208";a="28157461"
IronPort-PHdr: =?us-ascii?q?9a23=3AEryezhd+Y/SgvYeArhLC8EWDlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW4Zx7h7PlgxGXEQZ/co6odzbaP6ua5ADJLuM7Q+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiroQnLq8UanIpvJqksxh?=
 =?us-ascii?q?fVpnZDZvhby35vKV+PhRj3+92+/IRk8yReuvIh89BPXKDndKkmTrJWESorPX?=
 =?us-ascii?q?kt6MLkqRfMQw2P5mABUmoNiRpHHxLF7BDhUZjvtCbxq/dw1zObPc3ySrA0RC?=
 =?us-ascii?q?ii4qJ2QxLmlCsLKzg0+3zMh8dukKxUvg6upx1nw47Vfo6VMuZ+frjAdt8eXG?=
 =?us-ascii?q?ZNQ9pdWzBEDo66YYQPFe4BNvtGoYf7qVUFsB+yCRCsCe7rzzNFgGL9068n3O?=
 =?us-ascii?q?Q7CQzIwRIuH9wOvnrXotv6OqgdXuKpw6fH1jjDc/Bb1C3h5ITUfB0so/eBVq?=
 =?us-ascii?q?9wf8rLzkkvEhvIgEiMqYP7JzOV1voCs26G5OR9UOKgkWonqwVvrTmv28whjZ?=
 =?us-ascii?q?LJiZ8Oyl3f6SV4wJo6Jd2/SEJhZ96kC4FfuzuVN4txXMMvWmdlszs5xL0eoZ?=
 =?us-ascii?q?O3YScHxZs9yxPfdvCLaZaE7x39WOqLPDt1gm9udqiliBao60egz/XxVsyz0F?=
 =?us-ascii?q?lXsCVIisLMtnUR1xzL7ciHV+d98l+h2TmR0wDT7flJIVwumqrBKp4h36Uwmo?=
 =?us-ascii?q?APsUXDAiD2mEL2gLWQdko44ein9/7rYrDnpp+YL4N0iwf+PboymsGnHOg1PQ?=
 =?us-ascii?q?cDU3Kb9OihzrHv40L0TKtQgvEriqXZtYrVJcUfpq63GQ9V1YMj5g6kDzi7y9?=
 =?us-ascii?q?QVhmUHLVJZdxKHiIjlIVfOIOviAvuljFSslylry+jcPrL9GpXNMmTDkLD5cL?=
 =?us-ascii?q?Z/7E5cywkzws5F65JUEL4BJej8Wkvru9zZCB82LQq0zv3kCNV60oMeRX6PAq?=
 =?us-ascii?q?ifMKzMt1+E/OwvI+iUbo8PpDn9M+Ql5+LpjXIhgl8SY62p3ZoRaHClEfVrOF?=
 =?us-ascii?q?uZYXXyjdcbC2sKvRQxTPbsiFKcVT5ffXGyX7gz5mJzNIXzL4DARY3loDCEUC?=
 =?us-ascii?q?M3H5tbYCgSCFePEnqud4yBUvMFaSSfJOdilTgYSb+nRoln2xD48Efhxr5mKP?=
 =?us-ascii?q?fE0jMXuIil19Vv4eDX0xYo+m9aFcOYhlqRQnl0k2VAfDo/2KRysAQp0VuY+b?=
 =?us-ascii?q?RpiPxfU9pI7rVGVRlsZs2U9PBzF92nAlGJRdyOUlvzB4z7UDw=3D?=
X-IPAS-Result: =?us-ascii?q?A2BJCQCeJOhc/wHyM5BlHQEBBQEHBQGBZYFnKoE6ATKDe?=
 =?us-ascii?q?0CTDEwBAQEDBoEQJYlOjx6BZwkBAQEBAQEBAQE0AQIBAYRAAoI/IzgTAQMBA?=
 =?us-ascii?q?QEEAQEBAQMBAWwogjopAYJnAQUMFwQLAQVRCQIYAgImAgJXBgEMCAEBgl8/g?=
 =?us-ascii?q?XcUiiqbanwzhUeDK4FGgQwoi1MXeIEHgREnDIJfPoQsgyKCWASTBZVCCYIPg?=
 =?us-ascii?q?hKQegYblkGMaJd7IYFXKwgCGAghD4MokG0jA4E2AQGOBQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 May 2019 17:07:35 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4OH7YwA029308;
        Fri, 24 May 2019 13:07:34 -0400
Subject: Re: [PATCH] conf-parse.y checks (with style fixes removed)
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>, selinux@vger.kernel.org
References: <alpine.LFD.2.21.1905181955170.29988@34-41-5D-CA-59-C7>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2f749de1-4965-2be5-6415-6389a10fd38f@tycho.nsa.gov>
Date:   Fri, 24 May 2019 13:07:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1905181955170.29988@34-41-5D-CA-59-C7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/18/19 12:57 PM, Jokke Hämäläinen wrote:
> 
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index b527e893..64b53c2d 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -221,6 +221,9 @@ usepasswd: USEPASSWD '=' ARG {
>   
>   ignoredirs: IGNOREDIRS '=' ARG {
>   	current_conf->ignoredirs = strdup($3);
> +	if (current_conf->ignoredirs == NULL) {
> +		yyerror("could not allocate memory for current_conf->ignoredirs");

I wouldn't put the variable name/field name into the error message. 
"could not allocate memory for ignoredirs" would suffice.

> +	}
>   	free($3);
>    }
>   
> @@ -240,8 +243,8 @@ handle_unknown: HANDLE_UNKNOWN '=' ARG {
>   bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
>   	int blocksize = atoi($3);
>   	free($3);
> -	if (blocksize > 9)
> -		yyerror("bzip-blocksize can only be in the range 0-9");
> +	if (blocksize < 1 || blocksize > 9)
> +		yyerror("bzip-blocksize can only be in the range 1-9");
>   	else
>   		current_conf->bzip_blocksize = blocksize;
>   }
> @@ -339,9 +342,18 @@ static int semanage_conf_init(semanage_conf_t * conf)
>   {
>   	conf->store_type = SEMANAGE_CON_DIRECT;
>   	conf->store_path = strdup(basename(selinux_policy_root()));
> +	if (conf->store_path == NULL) {
> +		return -1;
> +	}
>   	conf->ignoredirs = NULL;
>   	conf->store_root_path = strdup("/var/lib/selinux");
> +	if (conf->store_root_path == NULL) {
> +		return -1;
> +	}
>   	conf->compiler_directory_path = strdup("/usr/libexec/selinux/hll");
> +	if (conf->compiler_directory_path == NULL) {
> +		return -1;
> +	}
>   	conf->policyvers = sepol_policy_kern_vers_max();
>   	conf->target_platform = SEPOL_TARGET_SELINUX;
>   	conf->expand_check = 1;
> @@ -515,7 +527,10 @@ static int parse_module_store(char *arg)
>   			}
>   		}
>   	}
> -	return 0;
> +
> +	if (current_conf->store_path)
> +		return 0;
> +	return -3;
>   }
>   
>   static int parse_store_root_path(char *arg)
> @@ -526,6 +541,10 @@ static int parse_store_root_path(char *arg)
>   
>   	free(current_conf->store_root_path);
>   	current_conf->store_root_path = strdup(arg);
> +	if (current_conf->store_root_path == NULL) {
> +		return -2;

Not sure why we are using multiple error return codes here or what they 
mean.

> +	}
> +
>   	return 0;
>   }
>   
> @@ -536,6 +555,9 @@ static int parse_compiler_path(char *arg)
>   	}
>   	free(current_conf->compiler_directory_path);
>   	current_conf->compiler_directory_path = strdup(arg);
> +	if (current_conf->compiler_directory_path = NULL) {
> +		return -2;
> +	}
>   	return 0;
>   }
>   
> 

