Return-Path: <SRS0=qWI8=YK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C04FA3735
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 12:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6D821835
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 12:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jC2j2tiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390108AbfJQMwS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:52:18 -0400
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:18304 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfJQMwS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Oct 2019 08:52:18 -0400
X-EEMSG-check-017: 40226612|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,307,1566864000"; 
   d="scan'208";a="40226612"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Oct 2019 12:52:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571316736; x=1602852736;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ivaWYgcquI8rt6CEkilch4I0bgVVAOQtw9VC+wpVZGw=;
  b=jC2j2tiSHCjOSo5WXzgkGdxD8h9n8rIyp9H99umsgfM0oI9gXSytVm1a
   eDomZ/tYbyxHg69FfMFhQCw3JY483m4gJwpz5VqG/f+sycC9jMFgrVGKw
   F7aFk/0eL9Ro3kYhPel7LmRa5WDNVY8Vej1V3UGF+Rp6wDmEIo1CVQDWU
   5QSLb00GbwXJWFl/oRZArjGR8+9ADRGNJtEIJp1q8eBNeaHpvugHrx2tG
   BP22fEDH5jHuRF9+pVs/oEtdXr5nhKwkZxzFhsZAR2EPh8L5WSAlzccw2
   pVwX49fDFtRQHPHYWdorikJoXKeWlhf9p2m0tDFpeG3o5hXxI2LZ/Sw1S
   Q==;
X-IronPort-AV: E=Sophos;i="5.67,307,1566864000"; 
   d="scan'208";a="29081315"
IronPort-PHdr: =?us-ascii?q?9a23=3AFJS6MxSFLJqisFKBS1GVXGPhd9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYReN2/xhgRfzUJnB7Loc0qyK6vumBjNLvMvJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/Tu8QUjodvKqY8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUStODJ6hb4sUF+oOI/pXr5XzqVsJqBuxHwisBOXywTNMiXL72ag23u?=
 =?us-ascii?q?IvHgHc2AwrAswAvnLaot7oMKseSO64wa3NwTjFcvhY2yry6JLQfx48v/+MU7?=
 =?us-ascii?q?J+f8nfx0YhGAzKjEmfp4P+MjOJ1OkAqXSX4/ZuWO+tjWMstgF/oiKoxscpko?=
 =?us-ascii?q?THm54VxU7c9SV53ok1I8CzRlN+YdG+FJtQsz+VNotrSc4lWGFnpT06x6YauZ?=
 =?us-ascii?q?+7YCcKyJMnywTZa/ycaYeE+B3jVOGPITphgn9uZbyxhxG38Ue6y+38UNG50F?=
 =?us-ascii?q?hLripBjNbArG0C2ALN6sWBV/Bz/V+h1C6S2w3c5exIO0A5mbfBJ5I/zbM8iI?=
 =?us-ascii?q?AfvVnFEyTrgkv5lrWWeV8h+uWw7uTnZajpqYGEOo9vjwH+LrwumsuiAeQkKg?=
 =?us-ascii?q?QOX3aU+eC71LD74U32Wq9KjvwrkqnCqpzaOcQaqbK5Aw9SyIoj7QqwDyy639?=
 =?us-ascii?q?gCmHkHLVZFdAqGj4jvJV7OPOj1Aeqwjlmjijtmx+3KMqf/DpjCMHTPiqrtca?=
 =?us-ascii?q?5460FGyQozyd5f54hTCrEEOP/zQVL+tMfDAx8lMw273+bnCNJn2oMYQmKAGL?=
 =?us-ascii?q?WVMKzVsV+W/u4vOfWDZJcJuDbhLPgo//7vgmU8mVAHYamp2oAaaGqmEft7I0?=
 =?us-ascii?q?WWe2bsjs0dHmcNuwo0VPbqh0GaUT5Pe3ayWLox5iolB4KiDIfDQJ2tgbOa0S?=
 =?us-ascii?q?elEZ1ZeHpGBkqPEXj2bYWEXekDaCaILs9miDwEWuvpd4h08Bi1vRPzyLcvH8?=
 =?us-ascii?q?Px0xE//cby3d18++r7jxw+9TVoSc+a1jfJB3p5mmIOWi8ewq9yuwp+x02F3K?=
 =?us-ascii?q?w+hOZXRvJJ4PYcaRs3LZ7RyaRBDtn2Xg/QNoOSRE2OXsStATZ3SMk4hdAJfR?=
 =?us-ascii?q?AuSJ2Zkhnf0n/yUPcunLuRCclxo/rR?=
X-IPAS-Result: =?us-ascii?q?A2DdAgACYqhd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYFzLIFAMiqEJY5nUwaBNol5kS8JAQEBAQEBAQEBNAECAQGEQAKDAyQ3B?=
 =?us-ascii?q?g4CDAEBAQQBAQEBAQUDAQFshTmCOimCaQEFIxVRCxgCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?l8/glMlr1iBMoVNgy6BSIEMKAGMDRh4gQeBESeCaz6HUoJeBJYvlyKCLIIyk?=
 =?us-ascii?q?mkGG4I6i32LD44wm04jgVgrCAIYCCEPgydQEBSBXBeOPyUDMIEGAQGNYiqCK?=
 =?us-ascii?q?gEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Oct 2019 12:52:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9HCqEYX015614;
        Thu, 17 Oct 2019 08:52:14 -0400
Subject: Re: [PATCH 3/3] checkpolicy: allow to write policy to stdout
To:     Masatake YAMATO <yamato@redhat.com>, selinux@vger.kernel.org
References: <20191017070513.13445-1-yamato@redhat.com>
 <20191017070513.13445-3-yamato@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0770f4d7-77bf-8ad8-582b-bf8c06f730fb@tycho.nsa.gov>
Date:   Thu, 17 Oct 2019 08:52:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017070513.13445-3-yamato@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/17/19 3:05 AM, Masatake YAMATO wrote:
> If - is given as filename for -o option, checkpolicy
> writes the policy to standard output. This helps users
> to read policy.conf and/or CIL policy file with pager
> like less command:
> 
>   $ checkpolicy -M -F -b /sys/fs/selinux/policy  -o - | less
> 
> The users don't have to make a temporary file.
> /dev/stdout can be used instead. However, - reduces the number of
> typing for the purpose. Using - for standard output (and/or standard
> input) is popular convention.
> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>   checkpolicy/checkpolicy.8 |  5 +++--
>   checkpolicy/checkpolicy.c | 24 +++++++++++++++++++-----
>   2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
> index db57751c..bdfd6acd 100644
> --- a/checkpolicy/checkpolicy.8
> +++ b/checkpolicy/checkpolicy.8
> @@ -3,7 +3,7 @@
>   checkpolicy \- SELinux policy compiler
>   .SH SYNOPSIS
>   .B checkpolicy
> -.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-c policyvers] [\-o output_file] [\-S] [\-t target_platform (selinux,xen)] [\-V] [input_file]"
> +.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (selinux,xen)] [\-V] [input_file]"
>   .br
>   .SH "DESCRIPTION"
>   This manual page describes the
> @@ -41,7 +41,8 @@ Specify the policy version, defaults to the latest.
>   .TP
>   .B \-o,\-\-output filename
>   Write a policy file (binary, policy.conf, or CIL policy)
> -to the specified filename.
> +to the specified filename. If - is given as filename,
> +write it to standard output.
>   .TP
>   .B \-S,\-\-sort
>   Sort ocontexts before writing out the binary policy. This option makes output of checkpolicy consistent with binary policies created by semanage and secilc.
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index e18de171..81bd2a9d 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -112,7 +112,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
>   {
>   	printf
>   	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
> -	     "[-c policyvers (%d-%d)] [-o output_file] [-S] "
> +	     "[-c policyvers (%d-%d)] [-o output_file|-] [-S] "
>   	     "[-t target_platform (selinux,xen)] [-V] [input_file]\n",
>   	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
>   	exit(1);
> @@ -390,7 +390,8 @@ int main(int argc, char **argv)
>   	struct sepol_av_decision avd;
>   	class_datum_t *cladatum;
>   	const char *file = txtfile;
> -	char ans[80 + 1], *outfile = NULL, *path, *fstype;
> +	char ans[80 + 1], *path, *fstype;
> +	const char *outfile = NULL;
>   	size_t scontext_len, pathlen;
>   	unsigned int i;
>   	unsigned int protocol, port;
> @@ -638,9 +639,20 @@ int main(int argc, char **argv)
>   	}
>   
>   	if (outfile) {
> -		outfp = fopen(outfile, "w");
> +		int use_stdout = !strcmp(outfile, "-");
> +		if (use_stdout) {
> +			outfp = stdout;
> +			outfile = "<STDOUT>";
> +		} else {
> +			outfp = fopen(outfile, "w");
> +		}
> +
>   		if (!outfp) {
> -			perror(outfile);
> +			if (use_stdout)
> +				fprintf(stderr, "%s: error to use %s\n",
> +					argv[0], outfile);

This error message doesn't seem especially useful, and it isn't clear to 
me under what conditions this could ever occur.  Do we really need 
special handling of the stdout case here?

Otherwise, this looks good to me.

> +			else
> +				perror(outfile);
>   			exit(1);
>   		}
>   
> @@ -682,7 +694,9 @@ int main(int argc, char **argv)
>   			}
>   		}
>   
> -		fclose(outfp);
> +		if (outfp != stdout) {
> +			fclose(outfp);
> +		}
>   	} else if (cil) {
>   		fprintf(stderr, "%s:  No file to write CIL was specified\n", argv[0]);
>   		exit(1);
> 

