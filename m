Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F273FC33CA1
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C765C2067D
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="poLgJO3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbgAIRNi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:13:38 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:57121 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbgAIRNi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jan 2020 12:13:38 -0500
X-EEMSG-check-017: 42907311|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="42907311"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2020 17:13:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578590011; x=1610126011;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=f7V/QP8r4oSoPgFk6/Q8ix3AbREIZgrKL4oqrgmT6DY=;
  b=poLgJO3i4gsZuFKmhIr5IOmQXB3VuEXaUt6Rb01IoId+IGHbwcxR2rvS
   79aNlQnBm8p0tzLzx2DNpFtpAx+yCTqWCXW4lxH+RzITL3H+20vs07Ijo
   A8xWdNAKmuIZbtUqWfIn2O1dMCpwIeRrX9vjbt3ssZ5yIwrW+urypds+D
   03v6GXTDiPoS7466zWMi8BjslnnUJ0oII599JOEM/JsGA9dv3D7Jjb/sm
   8JiFphm0HoIOEji+67kSq/mgXHNgX6ZiUik8ufcxIE0XcGX1TF869XgSQ
   kPlm0UTxF6UqA0AII8VejICBUrMgDbNTIx7K+i0Cuz3W5hYoIQXA0Soac
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="37560954"
IronPort-PHdr: =?us-ascii?q?9a23=3A5nKNexfy5zOMuo1GAGq5qQGSlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcWzYB7h7PlgxGXEQZ/co6odzbaP6Oa6BzVLv87JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQXnIduJac8xg?=
 =?us-ascii?q?fUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwl5?=
 =?us-ascii?q?wTsUrEHi/thkr5kLWadlkk++e06+TnZa/qppmAOI9vlg7yKKEums27AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH+8kD0T69Gg/0rnqXDrpzXKtoXqrSkDwNN14Ys8Re/DzOo0N?=
 =?us-ascii?q?QCmnkHKUpIeAmagIjyIFzOPPD5Auu/g1SrijtrwevGMaf7DpXCKXjDjq/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opOCrEAPP3zWlX+tMbFARAhLwO72+bnB8981oMYR22PGb?=
 =?us-ascii?q?SUP7jOsV+J4OIvP/eDZJUTuDnjN/gp/eLhjXg8mVUFZ6mmwYMXaGykHvRhO0?=
 =?us-ascii?q?iZemTjgtMAEWcMowo/Q/fniEONUTFNfXa+RaE86S8hCIKgE4jDQpqhgLub3C?=
 =?us-ascii?q?e0BpdWfHxJCkiQEXf0cIWJQ/AMaCeVIs96lDwLT6SuRJE62BG0qgD11rpnIf?=
 =?us-ascii?q?DI+iECqZ3j0911tKXvkkQI9Dd0Bt6Rm0GETmd5hStcXT493KllrXt2/VeK0K?=
 =?us-ascii?q?51mNRSCd1V+/5TVAomc5Xbyro+Q8v/XgPHY8ehVlmrWJOlDCs3Q9Z3xMUBMG?=
 =?us-ascii?q?hnHND3tQzOxyqnBfcukrWPAJEluvbH02PZO9d2y3GA0rIoyVYhXJ0cZiWdmq?=
 =?us-ascii?q?dj+l2LVMbymEKDmvPvLP9N0Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AYAACDXRde/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFrAgEBAQELAYF8gWwBIBIqhAmJA4ZgAQEBAQEBBoE3iW6RSAkBA?=
 =?us-ascii?q?QEBAQEBAQE3AQGEQAKCEzcGDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCeQEBA?=
 =?us-ascii?q?QECASMVQQULCxgCAiYCAlcGAQwGAgEBgmM/gksDCQUgqwF1gTKFT4NCgT2BD?=
 =?us-ascii?q?igBjDJ5gQeBEScPgl0+ghuFPoI8IgSNSIlXRniWT4JAgkWTXAYbmmSOWJx8I?=
 =?us-ascii?q?4FYKwgCGAghD4MnUBgNjR4XjkEjAzCRFQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 Jan 2020 17:13:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 009HCq10211732;
        Thu, 9 Jan 2020 12:12:52 -0500
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
 <20200109150709.360345-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <26995a97-6d5d-5ae1-914b-25de620c4b5c@tycho.nsa.gov>
Date:   Thu, 9 Jan 2020 12:14:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109150709.360345-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/20 10:07 AM, Richard Haines wrote:
> Test filesystem permissions and setfscreatecon(3).
> 
>  From kernels 5.5 filesystem { watch } is also tested.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---

> diff --git a/tests/filesystem/fs_relabel.c b/tests/filesystem/fs_relabel.c
> new file mode 100644
> index 0000000..25b1781
> --- /dev/null
> +++ b/tests/filesystem/fs_relabel.c
> @@ -0,0 +1,72 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <linux/unistd.h>
> +#include <selinux/selinux.h>
> +
> +static void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v] -n\n"
> +		"Where:\n\t"
> +		"-n  New fs context\n\t"
> +		"-v  Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt, result, save_err;
> +	char *context, *fscreate_con, *newcon = NULL;
> +	bool verbose = false;
> +
> +	while ((opt = getopt(argc, argv, "n:v")) != -1) {
> +		switch (opt) {
> +		case 'n':
> +			newcon = optarg;
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (!newcon)
> +		print_usage(argv[0]);
> +
> +	if (verbose) {
> +		result = getcon(&context);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed to obtain process context\n");
> +			exit(-1);
> +		}
> +		printf("Process context:\n\t%s\n", context);
> +		free(context);
> +	}
> +
> +	result = setfscreatecon(newcon);
> +	save_err = errno;
> +	if (result < 0) {
> +		fprintf(stderr, "Failed setfscreatecon(3): %s\n",
> +			strerror(errno));
> +		return save_err;
> +	}
> +
> +	result = getfscreatecon(&fscreate_con);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed getfscreatecon(3): %s\n",
> +			strerror(errno));
> +		exit(-1);
> +	}
> +	if (verbose)
> +		printf("New fscreate context: %s\n", fscreate_con);
> +
> +	free(fscreate_con);
> +	return 0;
> +}

I'm a little confused by this test.  setfscreatecon() is normally 
performed prior to performing some file creation using creat() or 
open(O_CREAT), mkdir(), symlink(), etc and the expected behavior is that 
the newly created file/directory/link/... will have the specified 
security context.  I didn't see an explicit test that setfscreatecon() 
followed by one or more file creations yields the expected context on 
the new files, and I don't think we have an explicit test of this 
functionality in the testsuite currently.



