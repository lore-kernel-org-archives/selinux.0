Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B484AC33CAC
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 13:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870612086A
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 13:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FLY9KCV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgBCNdp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:33:45 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:52707 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgBCNdp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 08:33:45 -0500
X-EEMSG-check-017: 52496594|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="52496594"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Feb 2020 13:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580736823; x=1612272823;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=3z3P+OIcLA3CVLDxZSaHvU9/h82w4PqnBg2RBAMTTT4=;
  b=FLY9KCV9tnmV5WYVEYrrUdZBlXNJRB2zkOlH3GnhBC0Dzl8ppQWcAvCW
   kVQYMYlyjCzZg5krl9U2C2PtTVcug8vDF1twc/fjyZkRuz9d9lOauxahN
   6tCFer+2l0NKrZYMJ7+83X0/Lk3jSu+dwEbtXcb696+msQ2fIn+1teS0a
   xxTLyUELXZGDHK4pWkHKiFeh1Bk3fiK+Rswch0gaEGCUTdQORzHWJUSlS
   +ZYhQYPnwHrfgNk3QAgJxwiBLAxytIEJzZWxs6hHfxUe9BtkqrJ2Dxg3/
   vKDcquRF2Irz6dx1hXzjABBiIeDuzG2QD/DmRtBKgQm7H6Hs2nWUpMaUR
   g==;
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="38576507"
IronPort-PHdr: =?us-ascii?q?9a23=3A81dwxhZ9Qj0sXYIHcjDDdsT/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsyzbnLW6fgltlLVR4KTs6sC17OK9fy/EjFYqdbZ6TZeKccKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZtJ6orxR?=
 =?us-ascii?q?bEoHREduRKyWh1IV6fgwvw6t2/8ZJ+/Slcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWG?=
 =?us-ascii?q?ROXtxVVydcHI2yaYUBBPcFMepBoYTwo14CoB2jDgeuGezv0CdFiGLo06000+?=
 =?us-ascii?q?ovEg/I0wIvEN0MrHvao874NLsRXO2v0KXE0TvOYvFQ1Dzg6IbIaBchofSUUL?=
 =?us-ascii?q?xtbcre11EvFwPbgVWWtIfrIjaV2f4Js2if8eVhVf+khmk8qw5suTii3dssi4?=
 =?us-ascii?q?nViYIVzVDI7yN5wJ0vKtGiR057ZsCkHYJWuiqHNIV2WtsvT3xntSs10LELuY?=
 =?us-ascii?q?O3cDIUxJko2RLTceGLfo6V6Rz5TumROy13hHd9dbK6gBa97Favx/XnVsmxzF?=
 =?us-ascii?q?ZKti1FksTQtnwV1xzc9MyHSvxl80e9wzmPzQHT6vxfIUwulKrbLZAhwrkrlp?=
 =?us-ascii?q?UNrUvPBDP2mUXqg6+WcUUo4O6o5Pj8Yrr6vJOcMo50igXmPqQvnMywH/g4Px?=
 =?us-ascii?q?ATU2WU9umwzr3u8VDjTLlUgfA6jLPVvI3CKcQevKG5AgtV0og56xa4CjeryM?=
 =?us-ascii?q?8YkmQcLF9eZBKGj5TmO1HJIPziC/e/mE6jnC1kx/DBIL3tGo/NIWTbkLf9Yb?=
 =?us-ascii?q?Z97FZRxxY8zdFe4JJUDK8OIOnoV0/+s9zYCRA5MwiqzObiEtp914ceVXiTDa?=
 =?us-ascii?q?+eNaPYqUWI6f43I+mQeI8Vvy7wK+M76P7qjH85n0IdfKay0JsJZ3C3AO5mL1?=
 =?us-ascii?q?+aYXXymNcBF3kFvg4kQOztkl2CXm0bW3HndKIm5yonCYugOqhdWpy2i7yMlH?=
 =?us-ascii?q?OwEY9RYG1dIl+LFnjseoCNWvNKYyWXdIspiTEAVL68W6c/2hy08gz30bxqKq?=
 =?us-ascii?q?zT4CJLm4jk0Y1O++DLlRw0vQdxBsCZ3nDFG3p4hUsUVjQ22+Z5ukU7xVCdh/?=
 =?us-ascii?q?sry8dEHMBesqsaGjwxMoTRmqkhWt0=3D?=
X-IPAS-Result: =?us-ascii?q?A2DUAACrIDhe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gW0gEiqEFIkDhlwBAQaBEiWJb4olhyQJAQEBAQEBAQEBNwEBhEACg?=
 =?us-ascii?q?lg3Bg4CEAEBAQQBAQEBAQUDAQFshUOCOymDAwEFIw8BBVELGAICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCYz+CSwMJJatcgTKFSoJODWKBPoEOKgGMOXmBB4ERJwwDgl0+ghuFQ?=
 =?us-ascii?q?IJeBJd+l2SCRYJOk2wGG5sILY40nSojgVgrCAIYCCEPgydQGA2OKReOQSMDM?=
 =?us-ascii?q?I8JAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 03 Feb 2020 13:33:23 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 013DWY6k154436;
        Mon, 3 Feb 2020 08:32:35 -0500
Subject: Re: [PATCH] libsepol: add support for new polcap
 genfs_seclabel_symlinks
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20200131183900.3507-1-cgzones@googlemail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <35cc375a-1c8e-5394-3ab5-55741374fa15@tycho.nsa.gov>
Date:   Mon, 3 Feb 2020 08:34:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131183900.3507-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/31/20 1:39 PM, Christian Göttsche wrote:
> Add support for new SELinux policy capability genfs_seclabel_symlinks.
> With this capability enabled symlinks on kernel filesystems will receive
> contexts based on genfscon statements, like directories and files,
> and not be restricted to the respective filesystem root sid.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libsepol/include/sepol/policydb/polcaps.h | 1 +
>   libsepol/src/polcaps.c                    | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
> index dc9356a6..40669fb5 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -13,6 +13,7 @@ enum {
>   	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>   	POLICYDB_CAPABILITY_CGROUPSECLABEL,
>   	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> +	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
>   	__POLICYDB_CAPABILITY_MAX
>   };
>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index b9dc3526..67ed5786 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -12,6 +12,7 @@ static const char *polcap_names[] = {
>   	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
>   	"cgroup_seclabel",		/* POLICYDB_CAPABILITY_SECLABEL */
>   	"nnp_nosuid_transition",	/* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
> +	"genfs_seclabel_symlinks",	/* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
>   	NULL
>   };
>   
> 

