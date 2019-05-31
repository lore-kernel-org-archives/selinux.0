Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA1C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 19:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734B526E66
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 19:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="QREaI/pO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfEaTfK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 15:35:10 -0400
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:63451 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfEaTfK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 15:35:10 -0400
X-EEMSG-check-017: 681959807|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,535,1549929600"; 
   d="scan'208";a="681959807"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 May 2019 19:35:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559331303; x=1590867303;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=fpArMWp8SeuueOrMUNEiq+MNgYriDzYLP1b33Ps2kDo=;
  b=QREaI/pOkhs8uBcD7eU1u0Xso2tzdLffk52uIFIBkFFQQFcRW1gAzBfa
   pJHpWEwXzdFYkk+IpcW9r5+vwQIwW/9LK+PlbzROiaKnHc63YgXo1Iqcn
   hRFvXjR2NMPIbAh015YuT/h3uzBActsBg5EKGr9FBSF1FZMbAF5wCvifs
   Rn2UHN4EIHJdh4iEMPoe4W0l1ciNstXol60rgK5buGVwm0PVJssxxYCWE
   cd5ZAE6ztGkhsCJG6VQEUtBpRl/AMlk7tjrGVkZSZmbXhBOEoYAaPGrqe
   2FSmR+TojtdYY0hJdfF5evEya5iJGnWUVBHggVf0MSsOscob/bgVgtZv8
   A==;
X-IronPort-AV: E=Sophos;i="5.60,535,1549929600"; 
   d="scan'208";a="28419876"
IronPort-PHdr: =?us-ascii?q?9a23=3AaZ+zixI4VRT3Zu9ULtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKv/+rarrMEGX3/hxlliBBdydt6sdzbON6uu5BTVIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK5+IA+roQjfq8UajpZuJ6ksxh?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtBWzCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzjjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXmJmuD4ix7Ebtp?=
 =?us-ascii?q?O2czIGxZQ6yxLFdfCKfJaE7gj+WOuXPDx2nmhqeKiliBa36UWgz+r8WdSq31?=
 =?us-ascii?q?tStSpFl8XMtmgK1xzO9siLUvt98Vml2TaIzw3T9vtLIVo1larGMJ4t2KIwl5?=
 =?us-ascii?q?oPvkTDGS/6gkP2g7ONdko44OSo7uXnYrH+qp+dMY97lB3+P7wzlsGwDuk0KA?=
 =?us-ascii?q?gDU3WB9eii27Dv41f1TKhSgv0ziKbZsZTaJcoBpq6+Bg9Yyp0j5AukDzq9zN?=
 =?us-ascii?q?QZnWUILFJCeB6diYjpIEvBLOr3Dfe4nVSgiC1ryOzePr39HpXNKWDOkK3gfb?=
 =?us-ascii?q?lh605T0hAzws1H6J1IEr4BIOj8Wk73tNPGFR80KBe7w/rmCNV7yoMRR3iPAq?=
 =?us-ascii?q?mHP6POq1OH+uUvI+yUbo8PpDn9M+Ql5+LpjXIhgl8SY62p3ZoRaHClEfVrOF?=
 =?us-ascii?q?uZYXXyjdcbC2sKvRQxTPbsiFKcVT5ffXGyX7gz5jsjEoKpEZ/DRpyxgLyGxC?=
 =?us-ascii?q?q0BZxWZmRCClyWDXjkbZ+EW/AXZy2MOM9hjicEWKOuS48kzx6utQv6x6B7Ie?=
 =?us-ascii?q?rT/y1L/a7kgeJ07O3ajx161TV1CcmGmzWXTmp0l3kEcDQB3Kl+p0Fm4l2f0K?=
 =?us-ascii?q?5kjuZeGMAV7PRMBENyLpPYzupnG/jsVQ/bONSEUlCrRpOhGz51Bu0wx9sPak?=
 =?us-ascii?q?M1IdKogwrfxGL+Cb4Rk/qAQoYz+K/Gw2PZKMN0ynKA364k2QoIWMxKYFa6i7?=
 =?us-ascii?q?Z/+g6bPIvAl0GUhu7+bqgH9DLc/2eEi2yVtQdXVxAmAvaNZmwWekaD9Yex3U?=
 =?us-ascii?q?jFVbL7TO18YwY=3D?=
X-IPAS-Result: =?us-ascii?q?A2AFBQAlgfFc/wHyM5BlHAEBAQQBAQcEAQGBZYFnKoFtK?=
 =?us-ascii?q?IQUkwdMAQEBAQEBBoEQJYlQkQgJAQEBAQEBAQEBNAECAQGEQAKDBCM4EwEDA?=
 =?us-ascii?q?QEBBAEBAQEDAQFsKII6KQGCZgEBAQECASMPAQVGCwsYAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJfP4FrAwkFD6tBgS+FR4MmgUaBDCiLWBd4gQeBEScMgjEuPoIahTSCWASTG?=
 =?us-ascii?q?YgPjUoJgg+CF5ERBhuCIYpziVOMepglIYFYKwgCGAghD4MnghgajjwjAzCBB?=
 =?us-ascii?q?gEBjXYBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 31 May 2019 19:35:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4VJZ00d023734;
        Fri, 31 May 2019 15:35:00 -0400
Subject: Re: [PATCH] selinux: Fix strncpy in libselinux and libsepol
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, William Roberts <bill.c.roberts@gmail.com>
References: <20190531151609.16873-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d122ef80-dc99-511e-6132-44a4072e4b37@tycho.nsa.gov>
Date:   Fri, 31 May 2019 15:35:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531151609.16873-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/31/19 11:16 AM, Richard Haines wrote:
> When building with gcc9, get build errors such as:
> 
> genbools.c:24:2: error: ‘strncpy’ output may be truncated copying 8191
> bytes from a string of length 8191 [-Werror=stringop-truncation]
>     24 |  strncpy(dest, ptr, size);
>        |  ^~~~~~~~~~~~~~~~~~~~~~~~

It would be nice if we could just remove all of this code, modulo 
ABI/API concerns (maybe we could reduce the public interfaces to 
no-ops?).  It is all legacy code I think, predating kernel 2.6.22 
(kernel automatically preserves boolean values across policy reload) and 
the use of libsemanage (managed policy, persistent boolean changes 
directly applied to the kernel policy file).  Probably not used by 
anything later than RHEL 4, which should be dead and gone by now I hope.

> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>   libselinux/src/booleans.c |  4 ++--
>   libsepol/src/genbools.c   | 20 +++++++++++---------
>   2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index ab1e0754..cdc03517 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -539,7 +539,7 @@ int security_load_booleans(char *path)
>   
>   	__fsetlocking(boolf, FSETLOCKING_BYCALLER);
>   	while (getline(&inbuf, &len, boolf) > 0) {
> -		int ret = process_boolean(inbuf, name, sizeof(name), &val);
> +		int ret = process_boolean(inbuf, name, len, &val);

This might fix the warning but is it correct? len is the size of the 
buffer allocated by getline, which could be larger or smaller than 
sizeof name and also could be larger than the number of bytes read. 
process_boolean() seems to want the size of the name buffer as a bound 
for strncpy() in the strtrim() call. strtrim() also seems to be using it 
wrongly as a bound for the source aka name1, presuming they are the same 
size.

>   		if (ret == -1)
>   			errors++;
>   		if (ret == 1)
> @@ -557,7 +557,7 @@ int security_load_booleans(char *path)
>   		int ret;
>   		__fsetlocking(boolf, FSETLOCKING_BYCALLER);
>   		while (getline(&inbuf, &len, boolf) > 0) {
> -			ret = process_boolean(inbuf, name, sizeof(name), &val);
> +			ret = process_boolean(inbuf, name, len, &val);

Ditto.

>   			if (ret == -1)
>   				errors++;
>   			if (ret == 1)
> diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
> index d4a2df62..ad194ca6 100644
> --- a/libsepol/src/genbools.c
> +++ b/libsepol/src/genbools.c
> @@ -10,6 +10,8 @@
>   #include "private.h"
>   #include "dso.h"
>   
> +#define FGET_BUFSIZ 255
> +
>   /* -- Deprecated -- */
>   
>   static char *strtrim(char *dest, char *source, int size)
> @@ -32,7 +34,7 @@ static char *strtrim(char *dest, char *source, int size)
>   
>   static int process_boolean(char *buffer, char *name, int namesize, int *val)
>   {
> -	char name1[BUFSIZ];
> +	char name1[FGET_BUFSIZ];
>   	char *ptr = NULL;
>   	char *tok;
>   
> @@ -48,7 +50,7 @@ static int process_boolean(char *buffer, char *name, int namesize, int *val)
>   		ERR(NULL, "illegal boolean definition %s", buffer);
>   		return -1;
>   	}
> -	strncpy(name1, tok, BUFSIZ - 1);
> +	strncpy(name1, tok, FGET_BUFSIZ - 1);
>   	strtrim(name, name1, namesize - 1);
>   
>   	tok = strtok_r(NULL, "\0", &ptr);
> @@ -79,8 +81,8 @@ static int load_booleans(struct policydb *policydb, const char *path,
>   {
>   	FILE *boolf;
>   	char *buffer = NULL;
> -	char localbools[BUFSIZ];
> -	char name[BUFSIZ];
> +	char localbools[FGET_BUFSIZ];
> +	char name[FGET_BUFSIZ + 1];

Similarly seems to be making faulty assumptions about using the same 
buffer sizes throughout.

>   	int val;
>   	int errors = 0, changes = 0;
>   	struct cond_bool_datum *datum;
> @@ -90,12 +92,12 @@ static int load_booleans(struct policydb *policydb, const char *path,
>   		goto localbool;
>   
>   #ifdef __APPLE__
> -        if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL) {
> -          ERR(NULL, "out of memory");
> -	  return -1;
> +	if ((buffer = (char *)malloc(FGET_BUFSIZ * sizeof(char))) == NULL) {
> +		ERR(NULL, "out of memory");
> +		return -1;
>   	}
>   
> -        while(fgets(buffer, 255, boolf) != NULL) {
> +	while (fgets(buffer, FGET_BUFSIZ, boolf) != NULL) {

I think this was just a hack to make it build on macOS for Android.  But 
there is no reason for this code to be used there.  I wouldn't change 
the other buffer sizes to match.

>   #else
>   	size_t size = 0;
>   	while (getline(&buffer, &size, boolf) > 0) {
> @@ -124,7 +126,7 @@ static int load_booleans(struct policydb *policydb, const char *path,
>   
>   #ifdef __APPLE__
>   
> -	  while(fgets(buffer, 255, boolf) != NULL) {
> +	while (fgets(buffer, FGET_BUFSIZ, boolf) != NULL) {
>   #else
>   
>   	    while (getline(&buffer, &size, boolf) > 0) {
> 

