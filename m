Return-Path: <SRS0=KzNU=YP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D6BCA9EA0
	for <selinux@archiver.kernel.org>; Tue, 22 Oct 2019 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F662184C
	for <selinux@archiver.kernel.org>; Tue, 22 Oct 2019 12:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="f6ycxpxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfJVM1e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:27:34 -0400
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:5253 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbfJVM1d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Oct 2019 08:27:33 -0400
X-EEMSG-check-017: 38905672|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,327,1566864000"; 
   d="scan'208";a="38905672"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Oct 2019 12:27:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571747251; x=1603283251;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=/KJGlCqwsPvoqz3iGfQ9pqNhdEBKEIYhdgZDl8fjvXw=;
  b=f6ycxpxwQIF+A6FeeK9wpnf/OG4WOMai6hdk9/7pWzB9SGpToZ5I1ILH
   s8zCzg8A7PFD/RA2cYVT/VhwPI4EetaRywSWzYVJLCdh/jnqvHt6wOgA5
   naASn8sk4WeCb9o60eLm1SSM8dGg6g89Mt0Lvn/9L97HVQSIoJAGJM5Ri
   7cS7eugsa6AafuPFNGqzYq8F0eX0Z5QjK2aPl4cCccZsN3Z/c2ZEygFT9
   abqjnXFeBQ6YdcSqqaM2vBw5/IGpwj3ePAdLj1PINRH1nNnrJ0XA/Ph0T
   49onMd5aRuwA5frEeSb4xIwXZYATjX5sZMVlc9Yb535GWo4N9j3Mv5duv
   w==;
X-IronPort-AV: E=Sophos;i="5.67,327,1566864000"; 
   d="scan'208";a="29241503"
IronPort-PHdr: =?us-ascii?q?9a23=3Ab2RxUxyQddD6PhfXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2u8VIJqq85mqBkHD//Il1AaPAdyAraIbwLeO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanYr5/Lhq6oAXNusILnYZsN6E9xw?=
 =?us-ascii?q?fTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ7NWCjQmKH?=
 =?us-ascii?q?0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXz?=
 =?us-ascii?q?mp8rxmQwH0higZKzE58XnXis1ug6JdvBKhvAF0z4rNbI2IKPZyYqbRcNUdSm?=
 =?us-ascii?q?RcQ8ZRTDRBDZ2gYIsTAeQBOuNYoJP8p1sIsBCyAQahCefqxjJOiHD2x6k62P?=
 =?us-ascii?q?k/Hw/A0gIrAtYCvG3aodjxMasfV/2+wqvVwjXZd/5YxCnz6IbIfB4ir/+DU7?=
 =?us-ascii?q?1/fsjNxkcgDA7FkledpJb5Mz+J2OkAsW6W5PdgW+K1jG4nrhl8rCWzxsgyko?=
 =?us-ascii?q?nJhpwaylbZ/itkxYY6P9m4SEplbt+kDZBdsDqaOJZtQs45X2FpuDo1yr0BuZ?=
 =?us-ascii?q?KheigK044oywTQa/yAbYiF+xTuX/ufLzd/gXJqYrO/hxCq/Eiuy+38Ute73E?=
 =?us-ascii?q?xXoSVbjNnBsG0G2R/L6sWfV/dw8Uis1SyP2gzO8O1IP085mbTBJ5I8xLM7i4?=
 =?us-ascii?q?Advl7ZHiDsnUX7lKqWdkI59ee28+nnebDmpoOEN49zlwH+LrwimsyhDuQ8NQ?=
 =?us-ascii?q?gDR3Sb9v6m1L3i4E35W69GjuE2k6bFsJDaIt4XpqilDA9Ozokv8RO/Dzai0N?=
 =?us-ascii?q?gAnHkHKkxKeA6fgoT0NFzDL+r0APeij1i2jjtmyO7KMqf8DpnVK3jMirbhfb?=
 =?us-ascii?q?Jz605GzwozyMhS54lJBbEaO//zRk/wu8DYDh8+KQC0xf3nB89n2oMRXmKPHL?=
 =?us-ascii?q?eVMLnOvl+Q+uIvP+6MaZcVuTnnLvgq/eLujXgilF8HY6amwJsXZ2qkHvh8P0?=
 =?us-ascii?q?qZZn/siM8bEWgWpgo+UPDqiFqaXD5IeXmyW6M85jcmCIOpForDWI+tj6Kb3C?=
 =?us-ascii?q?uhHZ1ZeHpGClaSHnfsbYmEXO0MaC3BavNmxxkNTrG9QowsnSCHkSbG7PIzP+?=
 =?us-ascii?q?PR8zEfnYju2Nh8+6vYkhRksXRvAsCc1XydZ397k3lORDIs2q1750tnxQSty6?=
 =?us-ascii?q?991sdEGMRT6vUBaQIzMZrR3qQuENzpch7QddeODlC9S5OpBi9nHYF5+MMHf0?=
 =?us-ascii?q?soQ4bqtRvExSf/Ru5Nmg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DOCgCO9K5d/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBd?=
 =?us-ascii?q?CyBPwEyKoQmjm5TBoERJYl9kS8JAQEBAQEBAQEBNAECAQGEQAKDKiQ4EwIMA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I6KYJpAQUjFVELGAICJgICVwYBDAYCAQGCXz+CU?=
 =?us-ascii?q?yWxd4EyhU6DMIFIgQ4ojA8YeIEHgREnDIJfPodVgl4EljOXK4IugjKSbgYbg?=
 =?us-ascii?q?juMAIsTjjabWCKBWCsIAhgIIQ+DJ1AQFIMSF44/JQMwgQYBAYw3KoIrAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Oct 2019 12:27:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9MCRUfx028844;
        Tue, 22 Oct 2019 08:27:30 -0400
Subject: Re: [PATCH v2 3/3] checkpolicy: allow to write policy to stdout
To:     Masatake YAMATO <yamato@redhat.com>, selinux@vger.kernel.org
References: <20191019102656.22972-1-yamato@redhat.com>
 <20191019102656.22972-3-yamato@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8186f7b8-4fdc-c897-2755-58ae491b2c8c@tycho.nsa.gov>
Date:   Tue, 22 Oct 2019 08:27:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191019102656.22972-3-yamato@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/19/19 6:26 AM, Masatake YAMATO wrote:
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
> Change(s) in v2:
> * Check the availability of output stream only when opening
>    a regualar file. Suggested by Stephen Smalley <sds@tycho.nsa.gov>.
> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

Thanks, applied.

> ---
>   checkpolicy/checkpolicy.8 |  5 +++--
>   checkpolicy/checkpolicy.c | 22 +++++++++++++++-------
>   2 files changed, 18 insertions(+), 9 deletions(-)
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
> index e18de171..7c5b63f8 100644
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
> @@ -638,10 +639,15 @@ int main(int argc, char **argv)
>   	}
>   
>   	if (outfile) {
> -		outfp = fopen(outfile, "w");
> -		if (!outfp) {
> -			perror(outfile);
> -			exit(1);
> +		if (!strcmp(outfile, "-")) {
> +			outfp = stdout;
> +			outfile = "<STDOUT>";
> +		} else {
> +			outfp = fopen(outfile, "w");
> +			if (!outfp) {
> +				perror(outfile);
> +				exit(1);
> +			}
>   		}
>   
>   		policydb.policyvers = policyvers;
> @@ -682,7 +688,9 @@ int main(int argc, char **argv)
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

