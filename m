Return-Path: <SRS0=nnTv=Y4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964EDCA9ECF
	for <selinux@archiver.kernel.org>; Mon,  4 Nov 2019 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6161220869
	for <selinux@archiver.kernel.org>; Mon,  4 Nov 2019 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Hq//UBoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfKDPSu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:18:50 -0500
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:57435 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfKDPSr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Nov 2019 10:18:47 -0500
X-EEMSG-check-017: 45212434|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,267,1569283200"; 
   d="scan'208";a="45212434"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Nov 2019 15:18:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572880726; x=1604416726;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=62bQcfNRnlh3fO1oOye/k08mw45m6jGv1V/m9pu0k4A=;
  b=Hq//UBocv/+Mwh3axFkNasJrrPZSS+9Cj6b5JHJQxhC/2YgKl1r7e011
   jTHFKXH3y7pCA99/a1aRrSE/YNpfnzJgMrY44OoAKjXguelqOxG/cDs/p
   5y+TClsXrYTcaqJ+jtA7nTqkw6qDzdYyJpPMUy7a7YkehTWT2Pwd4ue4o
   po9CPEzqQwXxuE5OOnrxIBtGHtr2aiRfUF1xL9y7DYBGMIuTsXe2ga06/
   Q4cskKDKO4BZbuNcAXfaLGiZTb0qA2DHbJ2QPJcwgDb/S20+EHUqbEhik
   337fdkGOR0ge7fJxUSyeQLcLk/5T7ploPqMPyydkRJZefCL1Q1nuOOmAc
   w==;
X-IronPort-AV: E=Sophos;i="5.68,267,1569283200"; 
   d="scan'208";a="29716568"
IronPort-PHdr: =?us-ascii?q?9a23=3A7pavrBfRSU1gGM9J4z29i8E3lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcWyZR7h7PlgxGXEQZ/co6odzbaP6Oa5ADdLvsrJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusULj4ZuJaQ8xx?=
 =?us-ascii?q?TUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmtiE6yrgctp?=
 =?us-ascii?q?66eigH0JcnyADFa/yBbYeI5gjvVOGLITd3gn9uZbGxhw6q/ES9xeDxWdO43V?=
 =?us-ascii?q?ZXoiZfjNXBuW4B2wbO5sWBV/Bz5F2u2SyV2ADW8uxEJEc0mrfFJJM52b4wk4?=
 =?us-ascii?q?YTsVzEHi/rhEX6lK+WeVsg+uiv8+nnfq/ppoWdN49pkQHyKLgum8yjDuQ4NQ?=
 =?us-ascii?q?gCRW6b9vin1LL/50H5RbRKjvkunqnYtpDVO9gbq7akDwJa3Ysv8RayAyq83N?=
 =?us-ascii?q?gGknQLMkhJdA+fg4jsIV7OIfT4Dfmlg1SrlTdm3+vGMaD6ApjWMnjCkKvufb?=
 =?us-ascii?q?Z660JGzgoz1spQ64hbCrEGPvL/QlXxu8DADh8lLwy0xP7qCNN81owCXmKPBr?=
 =?us-ascii?q?WWMLjIvV+J4eIvJPKMZJQOtTb4JPUk6OTijXgjmV8SZaOpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeWHsjckFEWcLuAo+UePrhUacUT5ceXmyRbgw5jIlB4K8C4fMWIStjKaG3C?=
 =?us-ascii?q?ehEZ1cfnpGBUyUEXf0a4WEXO8BaCeTIs9ijDMJTqKuS4s91RGqtQ/6zadnL+?=
 =?us-ascii?q?XO9i0fr5Lj24s92+qGsxA58jh9FIy81GaWVCkgmGIDQDs/x+Z+pktm0X+Gjb?=
 =?us-ascii?q?g+hOZXQ5gb/P5NUwEnJbbCwOFgTdP/QATMepGOUln1bM+hBGQKUt8pw9IIK3?=
 =?us-ascii?q?14EtGmgwGLizGmGJcJhreLA9oy6aua0H/vcZUug03a3bUs2gF1CvBEMner0+?=
 =?us-ascii?q?smrFne?=
X-IPAS-Result: =?us-ascii?q?A2BpAQCqOMBd/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfYF0LGxVMiqEKY9aAQEBAQEBBoE2f4hlkUIJAQEBAQEBAQEBLwUBAgEBh?=
 =?us-ascii?q?EAChA4kOBMCDgEBAQQBAQEBAQUDAQFshTcMgjspAYJsAQEBAQIBIxVBEAsYA?=
 =?us-ascii?q?gImAgJXBgEMBgIBAYJfPwGCUgUgD7BqdYEyhDkBgRSDMoFIgQ4ojBMYeIEHg?=
 =?us-ascii?q?REngjY1PoJiBIRvgl4EjQoHiSlEcpYCgi6CM4RehR6JAQYbgy6WN45CiC6TO?=
 =?us-ascii?q?iKBWCsIAhgIIQ87gmwJCj0RFIwNgT2EICMDMAEBAYECAQGNZgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Nov 2019 15:18:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA4FIjj5017249;
        Mon, 4 Nov 2019 10:18:45 -0500
Subject: Re: [PATCH 2/3] libselinux: generate Python glue code using "sed"
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Cc:     Michael Shigorin <mike@altlinux.org>
References: <20191101092724.7650-1-nicolas.iooss@m4x.org>
 <20191101092724.7650-2-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1787feff-156f-b6e0-db22-0bdc128b817e@tycho.nsa.gov>
Date:   Mon, 4 Nov 2019 10:18:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101092724.7650-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/1/19 5:27 AM, Nicolas Iooss wrote:
> libselinux currently uses "gcc -aux-info" in order to generate glue code
> for its Python bindings that throws an exception when a function returns
> a negative integer value. This causes issues when another compiler than
> gcc is used (such as clang or icc), as option -aux-info is specific to
> gcc.
> 
> Replace "gcc -aux-info" with a command that parses the content of header
> files using "sed". As this is more fragile (because the declaration of
> functions is not normalized), add a new target to the Makefile in order
> to test that the new method does not produce different results with
> "make CC=gcc test".
> 
> When reverting commit cfe487409307 ("libselinux: mark all exported
> function "extern""), "make test" now fails as expected:
> 
>      bash -e exception.sh test
>      Error ensuring that all exported functions that return an int are handled by exception.sh.
>      Here are functions that were not found in "gcc -aux-info" but that were collected by "sed":
>      Here are functions in "gcc -aux-info" that may be missing "extern" in header file:
>      selinuxfs_exists
>      make: *** [Makefile:202: test] Error 1
> 
> Original thread: https://lore.kernel.org/selinux/20191012172357.GB19655@imap.altlinux.org/T/#ma78bd7fe71fb5784387a8c0cebd867d6c02ee6e4

I'm not excited about moving to a more fragile method of generating this 
glue code. Would it perhaps suffice for us to pre-generate the files and 
keep them in-tree (or package them as part of the tar file 
distributions) so that downstream users without gcc can just use the 
generated files?

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> Cc: Michael Shigorin <mike@altlinux.org>
> ---
>   libselinux/Makefile         |  1 +
>   libselinux/src/Makefile     |  5 ++++-
>   libselinux/src/exception.sh | 38 +++++++++++++++++++++++++++++++------
>   3 files changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index 16531fe95bf5..c0ae884f8ede 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -67,3 +67,4 @@ clean-rubywrap:
>   	$(MAKE) -C src clean-rubywrap $@
>   
>   test:
> +	$(MAKE) -C src test
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 63d6b0eda270..c12230a17b1d 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -198,7 +198,10 @@ clean: clean-pywrap clean-rubywrap
>   distclean: clean
>   	rm -f $(GENERATED) $(SWIGFILES)
>   
> +test:
> +	bash -e exception.sh test
> +
>   indent:
>   	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
>   
> -.PHONY: all clean clean-pywrap clean-rubywrap pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
> +.PHONY: all clean clean-pywrap clean-rubywrap pywrap rubywrap swigify install install-pywrap install-rubywrap distclean test indent
> diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
> index d6c8c71713ad..adbb632c2f04 100755
> --- a/libselinux/src/exception.sh
> +++ b/libselinux/src/exception.sh
> @@ -1,11 +1,12 @@
> +#!/bin/bash -e
>   function except() {
> -case $1 in
> +case "$1" in
>       selinux_file_context_cmp) # ignore
>       ;;
>       *)
>   echo "
>   %exception $1 {
> -  \$action
> +  \$action
>     if (result < 0) {
>        PyErr_SetFromErrno(PyExc_OSError);
>        SWIG_fail;
> @@ -15,10 +16,35 @@ echo "
>   ;;
>   esac
>   }
> -if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
> +
> +if [ $# -eq 1 ] && [ "$1" = "test" ]
>   then
> -    # clang does not support -aux-info so fall back to gcc
> -    gcc -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
> +    # Ensure that "gcc -aux-info" produces the same list of functions as the sed command.
> +    # The main difference between these way of producing the list of exported
> +    # functions is that "gcc -aux-info" automatically inserts "extern" to all
> +    # declarations and writes each one on a single line.
> +    # clang does not support -aux-info, so skip the test if generating the aux file failed.
> +    if ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
> +    then
> +        FCT_FROM_AUX="$(awk '/<stdin>.*extern int/ { print $6 }' temp.aux | sort -u)"
> +        FCT_FROM_SED="$(sed -n 's/^extern \+int \+\([0-9A-Za-z_]\+\) *(.*$/\1/p' < ../include/selinux/selinux.h | sort -u)"
> +        if [ "$FCT_FROM_AUX" != "$FCT_FROM_SED" ]
> +        then
> +            echo >&2 'Error ensuring that all exported functions that return an int are handled by exception.sh.'
> +            echo >&2 'Here are functions that were not found in "gcc -aux-info" but that were collected by "sed":'
> +            comm -13 <(echo "$FCT_FROM_AUX") <(echo "$FCT_FROM_SED")
> +            echo >&2 'Here are functions in "gcc -aux-info" that may be missing "extern" in header file:'
> +            comm -23 <(echo "$FCT_FROM_AUX") <(echo "$FCT_FROM_SED")
> +            exit 1
> +        fi
> +    fi
> +    rm -f -- temp.aux -.o
> +    exit
>   fi
> -for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except $i ; done
> +
> +# shellcheck disable=SC2013
> +for i in $(sed -n 's/^extern \+int \+\([0-9A-Za-z_]\+\) *(.*$/\1/p' < ../include/selinux/selinux.h)
> +do
> +    except "$i"
> +done
>   rm -f -- temp.aux -.o
> 

