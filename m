Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94526C43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639AA21783
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="S1a/rjW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKLPgF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:36:05 -0500
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:40579 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfKLPgE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 10:36:04 -0500
X-EEMSG-check-017: 47551621|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="47551621"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2019 15:36:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573572963; x=1605108963;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DRDbszOB8W1Tc2Uem9MZEN3f72Q1g99VbRlhEqt8Bj8=;
  b=S1a/rjW9EEjXSYxEmsQdyv1b5PaRjNjt2jd1YFLHiJNwoyD+S5H+KBeJ
   dDmHQboCZ4smoIPtf8VrfYRF7Wy2l6DAfGWwi3O0K/KnttNeJ36fzlbFG
   eEVce5tvzUfV7oHiqPc4eDO7pQFmE+3Th1IDssTRt9sapFSgufCQpmuTa
   4LgmDpgvqvugtdHv908qqx72SVfpXkQ6zjE67gRPWpLQt75Du1JKKW7zy
   5S3P+i7wEvf/Q7fwbmtfCpHfSvD+69hWfQoWVwrsRXLl8uTYyL9o9x1RG
   eYOrEiOL1SjfdhoVg2YafTL25Gu9AsoxQLgiGBs76xqLgJtSvTakJ2yz6
   Q==;
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="29994538"
IronPort-PHdr: =?us-ascii?q?9a23=3AdfZkwhVWxi5x5sT/DmQWnzz4LMbV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRCEt8tkgFKBZ4jH8fUM07OQ7/m7HzVasN3e7zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajZVmJ6o+yB?=
 =?us-ascii?q?bEoGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oPsUXMAi/2mELsgK+Qakok4fSn5/7iYrXnop+QL450igfgPaQygsGzHOs1Pw?=
 =?us-ascii?q?cUU2Wb5OiwzqPv8ELnTLlQk/E6iqzZv4rbJcQfqK65GQhV0oM75hakEjimy8?=
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5e7?=
 =?us-ascii?q?Z96lJTyA03zd9F/JJYELABIPX0Wk/qr9zVFRo5PgO7wur9D9V9zIweU3qVAq?=
 =?us-ascii?q?CFKKPSrUOI5uU3LumXeoAVvDf9K/445//hlnI5h1Adcrez3ZcNa3C3AO5mI0?=
 =?us-ascii?q?OHbnromNsBFn0KvgUmRuzwlFKCSSJTZ2q1X68k4zE7CYGmApnYS4+3hLyBwC?=
 =?us-ascii?q?O7HpxQZmBbBVGAC3Dod5+LW6REVCXHBM5qlTgNTvCATIg6zln6sg7xzL5uNa?=
 =?us-ascii?q?zV/SoDrrrmiMgz4Pfcw1V67jFwDsKAw0mTQGxu2GAFXTk72OZ4u0Mu5E2E1P?=
 =?us-ascii?q?1Dn/FAFdFVr8hMWwM+OI+Um/d2EPjuSwnBeZGPU1/gTdK4V2JiBuktysMDNh?=
 =?us-ascii?q?4uU+6piQrOim/zWO4Y?=
X-IPAS-Result: =?us-ascii?q?A2DWAADQz8pd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0LGxVMiqEKY9YBoERJYlmkUMJAQEBAQEBAQEBIxEBAgEBhEACgh0kO?=
 =?us-ascii?q?BMCDgEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjFUEQCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/AYJSJa8tgTKFToM0gUiBDiiMFBh4gQeBOAyCXz6BF4Y+gl4EllBFl?=
 =?us-ascii?q?nuCL4I2hGGOJwYCGYMvlkqOR5wHIoFYKwgCGAghD4MnCUcRFJp6hCAjAzCBB?=
 =?us-ascii?q?QEBkFcBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Nov 2019 15:36:02 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xACFZwb0007449;
        Tue, 12 Nov 2019 10:35:59 -0500
Subject: Re: [PATCH 1/3] libselinux, libsemanage: never create -.o in
 exception.sh
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Cc:     Michael Shigorin <mike@altlinux.org>
References: <20191111115315.1173097-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <51587266-6682-0b37-5645-c3435fbc2648@tycho.nsa.gov>
Date:   Tue, 12 Nov 2019 10:35:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191111115315.1173097-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/11/19 6:53 AM, Nicolas Iooss wrote:
> Files starting with "-" causes issues in commands such as "rm *.o". For
> libselinux and libsemanage, when exception.sh fails to remove "-.o",
> "make clean" fails with:
> 
>      rm: invalid option -- '.'
>      Try 'rm ./-.o' to remove the file '-.o'.
>      Try 'rm --help' for more information.
> 
> Fix this by making exception.sh create "temp.o" instead of "-.o".
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/src/exception.sh  | 6 +++---
>   libsemanage/src/exception.sh | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
> index d6c8c71713ad..1a21e651c42f 100755
> --- a/libselinux/src/exception.sh
> +++ b/libselinux/src/exception.sh
> @@ -15,10 +15,10 @@ echo "
>   ;;
>   esac
>   }
> -if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
> +if ! ${CC:-gcc} -x c -c -I../include -o temp.o - -aux-info temp.aux < ../include/selinux/selinux.h
>   then
>       # clang does not support -aux-info so fall back to gcc
> -    gcc -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
> +    gcc -x c -c -I../include -o temp.o - -aux-info temp.aux < ../include/selinux/selinux.h
>   fi
>   for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except $i ; done
> -rm -f -- temp.aux -.o
> +rm -f -- temp.aux temp.o
> diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
> index 97bc2ae879f2..fc1d4035a9cd 100644
> --- a/libsemanage/src/exception.sh
> +++ b/libsemanage/src/exception.sh
> @@ -9,10 +9,10 @@ echo "
>   }
>   "
>   }
> -if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
> +if ! ${CC:-gcc} -x c -c -I../include -o temp.o - -aux-info temp.aux < ../include/semanage/semanage.h
>   then
>       # clang does not support -aux-info so fall back to gcc
> -    gcc -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
> +    gcc -x c -c -I../include -o temp.o - -aux-info temp.aux < ../include/semanage/semanage.h
>   fi
>   for i in `awk '/extern int/ { print $6 }' temp.aux`; do except $i ; done
> -rm -f -- temp.aux -.o
> +rm -f -- temp.aux temp.o
> 

