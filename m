Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09342C2D0B1
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F121775
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oE6URPrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBFNoo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:44:44 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:21951 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBFNoo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 08:44:44 -0500
X-EEMSG-check-017: 53578056|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,409,1574121600"; 
   d="scan'208";a="53578056"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 13:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580996651; x=1612532651;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=h+3p2X5o3UIB4N+U1hH/pMWRiygxFLJvIz5Yq5I2tzY=;
  b=oE6URPrPak1BbXP/ihjMTCBgpG0zbyEcuRpIizY8Llttp0pIODLJmXgO
   xqpcMujfRJ0fqL9F+ICN6af1ALIgwbukYUdiQ7kwjvBh14Zsv7S3IJIRJ
   nyUr1NxuY08hqZlb4zsobuxm65UzDBFFzelJYBlJaJVq0qsZCOMw3uDpl
   CXyRGJF3972lgiTFIq28ZK60PwuyEbmepu7A8vP1Cvlb53MQHoeluVEs/
   BucGoLNSA1UAk3E9dJ0FFMPF/lXlBgMbin2MUNDZETVJ0WQAinnXeC24b
   jQFzmCAPg6TbvcY74ie7F4XWYsDDYCyTx0iZ2chDddBC/1F4NJd8L7Qi0
   g==;
X-IronPort-AV: E=Sophos;i="5.70,409,1574121600"; 
   d="scan'208";a="38750148"
IronPort-PHdr: =?us-ascii?q?9a23=3A5k7w/BwubwWtmCXXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uMUIJqq85mqBkHD//Il1AaPAdyHra8fwLeN++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMgYZvJKk9xx?=
 =?us-ascii?q?vHr3BVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBtwDvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFQ7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2Mpth1xrSa3xscslI?=
 =?us-ascii?q?bJgJ8exE3B9SpjxIY1IcO3SU5matOjC5tfqjqaOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreLTmppmSN49zkQHxLLghltajAeU4Lg?=
 =?us-ascii?q?cOX2+b9f661LL/5k32XK9Gjvg3kqndqJzaJMIbqbClAwJNz4ou5BmyAy2m3d?=
 =?us-ascii?q?gFh3ULMl1IdAydg4T0I13OJer3Dfa7g1SiijdrwPXGM6X6AprQNXjOi6vhfL?=
 =?us-ascii?q?Zh5E5czwo/19Zf54lOBb0bL/LzXVHxuMTCDhAlKwy03/rnCNJl24MZXGKPBb?=
 =?us-ascii?q?SZMKXIvlCU+O0iOPOMa5EItzb9Mfcl++TigmM+mV8YZaOpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeWHsjckFEWcLuAo+UePrhUacUT5ceXmyRbgw5jIlB4K8C4fMWIStjKaG3C?=
 =?us-ascii?q?ehEZ1cfnpGBUyUEXf0a4WEXO8BaDqWIsB7jzwESaKhRJQ72hy1rg/11adoLu?=
 =?us-ascii?q?rO9S0Er57syN915+iA3S01oBtyA96Q0SmoSHpyl2gFRHdi26V4ukp0wVqry6?=
 =?us-ascii?q?V0g/VEU9dU4qUNGhw3MZ/a0vxSFd//QETCc82PRVLgRc+pUh8rSddk+MMDe0?=
 =?us-ascii?q?ZwHZ2ZixnH2ye7S+sOm6ejGI0/8qWa2WP4Ycl61SCVh+Eak1A6T54XZiWdja?=
 =?us-ascii?q?ll+l2WXtWYng=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DDAgACFzxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsIRIqhBWJA4ZkAQEBBoE3iXCRSwkBAQEBAQEBAQE3AQGEQAKCYTgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYMBAQEBAQIBIxVBEAsOCgICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCYz+CVwUgqmZ1gTKFSoNRgT6BDiqMPXmBB4ERJw+CXT6EEjmDEIJeBI4Si?=
 =?us-ascii?q?EthRpdngkSCTpNyBhubC45inTQigVgrCAIYCCEPgydQGA2OKReOQSMDMIwHg?=
 =?us-ascii?q?kMBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Feb 2020 13:44:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016DhJhC048556;
        Thu, 6 Feb 2020 08:43:19 -0500
Subject: Re: [RFC PATCH 2/2] semodule: support changing policyvers via command
 line
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
References: <20200206131253.535302-1-omosnace@redhat.com>
 <20200206131253.535302-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <dfd44a69-8ba1-9de7-c3a8-bca702fdf6a0@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 08:45:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206131253.535302-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/20 8:12 AM, Ondrej Mosnacek wrote:
> When using semodule for building a distribution policy package (as
> Fedora does), the environment might not have selinuxfs available and
> provide no way to modify semanage.conf. When we want to build a policy
> with version X (because our kernel doesn't support X+1 and above yet),
> but our libsepol already has support for X+1, then we currently have no
> way to do so.

Not fundamentally opposed, but unclear on the motivation.  The current 
approach is to generate the highest policy version supported by our 
libsepol at build time, then libselinux selinux_mkload_policy() uses 
libsepol functions (sepol_policydb_set_vers(), 
sepol_policydb_to_image()) to automatically downgrade the policy in 
memory to whatever version is supported by the kernel before writing it 
to the kernel.  This works as long as one uses the same or newer 
libsepol at load time as at build time and as long as policydb_write() 
supports writing older policy versions (generally discarding newer 
features).

> 
> To resolve this, add a new command-line argument to semodule, which
> allows to override the system-wide configured version to a different
> one.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   policycoreutils/semodule/semodule.8 |  3 +++
>   policycoreutils/semodule/semodule.c | 12 +++++++++++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
> index 18d4f708..88e027fd 100644
> --- a/policycoreutils/semodule/semodule.8
> +++ b/policycoreutils/semodule/semodule.8
> @@ -64,6 +64,9 @@ A module is extracted as HLL by default. The name of the module written is
>   <module-name>.<lang_ext>
>   .SH "OPTIONS"
>   .TP
> +.B  \-V,\-\-policyvers
> +force specific kernel policy version
> +.TP
>   .B  \-s,\-\-store
>   name of the store to operate on
>   .TP
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index a1f75e16..30c4495b 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -50,6 +50,8 @@ static int build;
>   static int disable_dontaudit;
>   static int preserve_tunables;
>   static int ignore_module_cache;
> +static unsigned policyvers;
> +static int policyvers_set = 0;
>   static uint16_t priority;
>   static int priority_set = 0;
>   
> @@ -137,6 +139,7 @@ static void usage(char *progname)
>   	printf("  -d,--disable=MODULE_NAME  disable module\n");
>   	printf("  -E,--extract=MODULE_NAME  extract module\n");
>   	printf("Options:\n");
> +	printf("  -V,--policyvers  force specific kernel policy version\n");
>   	printf("  -s,--store	   name of the store to operate on\n");
>   	printf("  -N,-n,--noreload do not reload policy after commit\n");
>   	printf("  -h,--help        print this message and quit\n");
> @@ -210,7 +213,7 @@ static void parse_command_line(int argc, char **argv)
>   	no_reload = 0;
>   	priority = 400;
>   	while ((i =
> -		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
> +		getopt_long(argc, argv, "V:s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
>   			    NULL)) != -1) {
>   		switch (i) {
>   		case 'b':
> @@ -248,6 +251,10 @@ static void parse_command_line(int argc, char **argv)
>   			fprintf(stderr, "The --upgrade option is deprecated. Use --install instead.\n");
>   			set_mode(INSTALL_M, optarg);
>   			break;
> +		case 'V':
> +			policyvers = (unsigned)strtoul(optarg, NULL, 10);
> +			policyvers_set = 1;
> +			break;
>   		case 's':
>   			set_store(optarg);
>   			break;
> @@ -363,6 +370,9 @@ int main(int argc, char *argv[])
>   		goto cleanup_nohandle;
>   	}
>   
> +	if (policyvers_set)
> +		semanage_set_policyvers(sh, policyvers);
> +
>   	if (store) {
>   		/* Set the store we want to connect to, before connecting.
>   		 * this will always set a direct connection now, an additional
> 

