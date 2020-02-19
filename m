Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA96C34047
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8018F24670
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XSSHzyBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSPNn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:13:43 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:10592 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSPNm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 10:13:42 -0500
X-EEMSG-check-017: 59864341|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="59864341"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Feb 2020 15:13:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582125219; x=1613661219;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=uUZwOVUoVn85SQ6+Jga0jP/Vjk5IyBylsEwjhQmH638=;
  b=XSSHzyBFzfLOKMKRdu+aC1SLC+CCa4fMJL/Nlt+MyV4dVavIGbpvIiG8
   Eiy7p2sY9cRYYW5bucJSBW1Eeh0+tr0LO2PmwQuoNf56J7uPAh4e4+0PJ
   pFn86h9pLMPaHzU0ZhhHWOxMzAv1pDgiUZDrcPkw8DBB/E8eMNovtqF0D
   4a+277Kz75ZR6xd/Pd7cJbAzHPvi5ecM+Uiszf/kSYAuvvzwAewA8PI4K
   0ZvMRALLrbNmFlAc6p1XQWTzz0M18YVeB9zWlnxreWD3zUVLcXG8uNl5k
   TPhPqQb0awcLyNfcQ9nXR0DdBPdv5IgDXb/dKWtqOELLwTqRbA4PAGnjd
   w==;
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="33207998"
IronPort-PHdr: =?us-ascii?q?9a23=3AiVcv7hLQnCBE7qYyR9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfK/3xwZ3uMQTl6Ol3ixeRBMOHsq4C27Kd7PqocFdDyKjCmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfLx/IA+1oAnNucUbg5VuIbstxx?=
 =?us-ascii?q?XUpXdFZ+tZyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAeoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lp?=
 =?us-ascii?q?sVsUTNGS/2g1v5g7OMekU4+umn9+TnYrL8qp+aK4B0kR3xPr4rmsy+BeQ0Kg?=
 =?us-ascii?q?kOX26F9uSgzLDv4EL0TbpQgvA2j6XVqo7WKMsFqqKjHgNZyoMj5Ay+Dzei3t?=
 =?us-ascii?q?QYh34HLFdddRKckofpIErDIOz4DPijg1Ssly1nx/bdPrL7GJnNIX/DkKn5cb?=
 =?us-ascii?q?Zn90Fc0BYzzcxY559MDbEBJfXzWlT3tNPCEhA2LRe5w/z5B9pg1oMRQ36PDr?=
 =?us-ascii?q?WFP6PVtF+C/vgvLPWUZI8JpDb9LOAo5+Xwgn89mF8de7Sp3JQMZXCmEfRpPV?=
 =?us-ascii?q?+ZbWDvgtgfC2cKuBQxTOjwhF2FSz5TaCX6Y6VpwTc3Eo+kRaLEXYaki7GClH?=
 =?us-ascii?q?O8G5pNYGlNB3iWHHvofpnCUPAJPmbaOcJlkzoZRZC/RII7kxKjrgn3z/xgNO?=
 =?us-ascii?q?WH1DcfsMfYyNVt5+DV3So3/DhwAtXVh3qBVEloj2gIQHkwx6k5rktjnATQmZ?=
 =?us-ascii?q?NkiuBVQIQAr8hCVR03YNuFlL13?=
X-IPAS-Result: =?us-ascii?q?A2BhAgBqT01e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsATIqhBSJA4ZTAQEBAQEBBoESJYEBiG+PY4FnCQEBAQEBAQEBATcEAQGEQ?=
 =?us-ascii?q?AKCKDgTAhABAQEFAQEBAQEFAwEBbIVDgjspAYMCAQUjBBFRCw4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJjP4JXJa1xfzOFSoNlgT6BDiqMPnmBB4ERJwwDgig1PoQxgyqCX?=
 =?us-ascii?q?gSNaoltRogOj2aCRYJQlAoGHJFjiUiOb51WIoFYKwgCGAghD4MnUBgNjigBF?=
 =?us-ascii?q?45BIwMwjxMBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Feb 2020 15:13:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01JFCaUI184547;
        Wed, 19 Feb 2020 10:12:36 -0500
Subject: Re: [PATCH 1/2] libsepol, newrole: remove unused hashtab functions
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200219134522.230822-1-omosnace@redhat.com>
 <20200219134522.230822-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2381cfbd-eaba-3025-60bf-fb8fc0822887@tycho.nsa.gov>
Date:   Wed, 19 Feb 2020 10:14:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219134522.230822-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/20 8:45 AM, Ondrej Mosnacek wrote:
> hashtab_replace() and hashtab_map_remove_on_error() aren't used
> anywhere, no need to keep them around...
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libsepol/include/sepol/policydb/hashtab.h | 28 --------
>   libsepol/src/hashtab.c                    | 85 -----------------------
>   policycoreutils/newrole/hashtab.c         | 85 -----------------------
>   policycoreutils/newrole/hashtab.h         | 28 --------
>   4 files changed, 226 deletions(-)
> 
> diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include/sepol/policydb/hashtab.h
> index ca5ba862..dca8c983 100644
> --- a/libsepol/include/sepol/policydb/hashtab.h
> +++ b/libsepol/include/sepol/policydb/hashtab.h
> @@ -79,20 +79,6 @@ extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
>   					   hashtab_datum_t d,
>   					   void *args), void *args);
>   
> -/*
> -   Insert or replace the specified (key, datum) pair in the specified
> -   hash table.  If an entry for the specified key already exists,
> -   then the specified destroy function is applied to (key,datum,args)
> -   for the entry prior to replacing the entry's contents.
> -
> -   Returns SEPOL_ENOMEM if insufficient space is available or
> -   SEPOL_OK otherwise.
> - */
> -extern int hashtab_replace(hashtab_t h, hashtab_key_t k, hashtab_datum_t d,
> -			   void (*destroy) (hashtab_key_t k,
> -					    hashtab_datum_t d,
> -					    void *args), void *args);
> -
>   /*
>      Searches for the entry with the specified key in the hash table.
>   
> @@ -122,20 +108,6 @@ extern int hashtab_map(hashtab_t h,
>   				     hashtab_datum_t d,
>   				     void *args), void *args);
>   
> -/*
> -   Same as hashtab_map, except that if apply returns a non-zero status,
> -   then the (key,datum) pair will be removed from the hashtab and the
> -   destroy function will be applied to (key,datum,args).
> - */
> -extern void hashtab_map_remove_on_error(hashtab_t h,
> -					int (*apply) (hashtab_key_t k,
> -						      hashtab_datum_t d,
> -						      void *args),
> -					void (*destroy) (hashtab_key_t k,
> -							 hashtab_datum_t d,
> -							 void *args),
> -					void *args);
> -
>   extern void hashtab_hash_eval(hashtab_t h, char *tag);
>   
>   #ifdef __cplusplus
> diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> index f5407ab6..9590b359 100644
> --- a/libsepol/src/hashtab.c
> +++ b/libsepol/src/hashtab.c
> @@ -133,48 +133,6 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
>   	return SEPOL_OK;
>   }
>   
> -int hashtab_replace(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
> -		    void (*destroy) (hashtab_key_t k,
> -				     hashtab_datum_t d, void *args), void *args)
> -{
> -	int hvalue;
> -	hashtab_ptr_t prev, cur, newnode;
> -
> -	if (!h)
> -		return SEPOL_ENOMEM;
> -
> -	hvalue = h->hash_value(h, key);
> -	prev = NULL;
> -	cur = h->htable[hvalue];
> -	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
> -		prev = cur;
> -		cur = cur->next;
> -	}
> -
> -	if (cur && (h->keycmp(h, key, cur->key) == 0)) {
> -		if (destroy)
> -			destroy(cur->key, cur->datum, args);
> -		cur->key = key;
> -		cur->datum = datum;
> -	} else {
> -		newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
> -		if (newnode == NULL)
> -			return SEPOL_ENOMEM;
> -		memset(newnode, 0, sizeof(struct hashtab_node));
> -		newnode->key = key;
> -		newnode->datum = datum;
> -		if (prev) {
> -			newnode->next = prev->next;
> -			prev->next = newnode;
> -		} else {
> -			newnode->next = h->htable[hvalue];
> -			h->htable[hvalue] = newnode;
> -		}
> -	}
> -
> -	return SEPOL_OK;
> -}
> -
>   hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
>   {
>   
> @@ -241,49 +199,6 @@ int hashtab_map(hashtab_t h,
>   	return SEPOL_OK;
>   }
>   
> -void hashtab_map_remove_on_error(hashtab_t h,
> -				 int (*apply) (hashtab_key_t k,
> -					       hashtab_datum_t d,
> -					       void *args),
> -				 void (*destroy) (hashtab_key_t k,
> -						  hashtab_datum_t d,
> -						  void *args), void *args)
> -{
> -	unsigned int i;
> -	int ret;
> -	hashtab_ptr_t last, cur, temp;
> -
> -	if (!h)
> -		return;
> -
> -	for (i = 0; i < h->size; i++) {
> -		last = NULL;
> -		cur = h->htable[i];
> -		while (cur != NULL) {
> -			ret = apply(cur->key, cur->datum, args);
> -			if (ret) {
> -				if (last) {
> -					last->next = cur->next;
> -				} else {
> -					h->htable[i] = cur->next;
> -				}
> -
> -				temp = cur;
> -				cur = cur->next;
> -				if (destroy)
> -					destroy(temp->key, temp->datum, args);
> -				free(temp);
> -				h->nel--;
> -			} else {
> -				last = cur;
> -				cur = cur->next;
> -			}
> -		}
> -	}
> -
> -	return;
> -}
> -
>   void hashtab_hash_eval(hashtab_t h, char *tag)
>   {
>   	unsigned int i;
> diff --git a/policycoreutils/newrole/hashtab.c b/policycoreutils/newrole/hashtab.c
> index 24c65c49..bc502836 100644
> --- a/policycoreutils/newrole/hashtab.c
> +++ b/policycoreutils/newrole/hashtab.c
> @@ -112,48 +112,6 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
>   	return HASHTAB_SUCCESS;
>   }
>   
> -int hashtab_replace(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
> -		    void (*destroy) (hashtab_key_t k,
> -				     hashtab_datum_t d, void *args), void *args)
> -{
> -	int hvalue;
> -	hashtab_ptr_t prev, cur, newnode;
> -
> -	if (!h)
> -		return HASHTAB_OVERFLOW;
> -
> -	hvalue = h->hash_value(h, key);
> -	prev = NULL;
> -	cur = h->htable[hvalue];
> -	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
> -		prev = cur;
> -		cur = cur->next;
> -	}
> -
> -	if (cur && (h->keycmp(h, key, cur->key) == 0)) {
> -		if (destroy)
> -			destroy(cur->key, cur->datum, args);
> -		cur->key = key;
> -		cur->datum = datum;
> -	} else {
> -		newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
> -		if (newnode == NULL)
> -			return HASHTAB_OVERFLOW;
> -		memset(newnode, 0, sizeof(struct hashtab_node));
> -		newnode->key = key;
> -		newnode->datum = datum;
> -		if (prev) {
> -			newnode->next = prev->next;
> -			prev->next = newnode;
> -		} else {
> -			newnode->next = h->htable[hvalue];
> -			h->htable[hvalue] = newnode;
> -		}
> -	}
> -
> -	return HASHTAB_SUCCESS;
> -}
> -
>   hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
>   {
>   
> @@ -220,49 +178,6 @@ int hashtab_map(hashtab_t h,
>   	return HASHTAB_SUCCESS;
>   }
>   
> -void hashtab_map_remove_on_error(hashtab_t h,
> -				 int (*apply) (hashtab_key_t k,
> -					       hashtab_datum_t d,
> -					       void *args),
> -				 void (*destroy) (hashtab_key_t k,
> -						  hashtab_datum_t d,
> -						  void *args), void *args)
> -{
> -	unsigned int i;
> -	int ret;
> -	hashtab_ptr_t last, cur, temp;
> -
> -	if (!h)
> -		return;
> -
> -	for (i = 0; i < h->size; i++) {
> -		last = NULL;
> -		cur = h->htable[i];
> -		while (cur != NULL) {
> -			ret = apply(cur->key, cur->datum, args);
> -			if (ret) {
> -				if (last) {
> -					last->next = cur->next;
> -				} else {
> -					h->htable[i] = cur->next;
> -				}
> -
> -				temp = cur;
> -				cur = cur->next;
> -				if (destroy)
> -					destroy(temp->key, temp->datum, args);
> -				free(temp);
> -				h->nel--;
> -			} else {
> -				last = cur;
> -				cur = cur->next;
> -			}
> -		}
> -	}
> -
> -	return;
> -}
> -
>   void hashtab_hash_eval(hashtab_t h, char *tag)
>   {
>   	unsigned int i;
> diff --git a/policycoreutils/newrole/hashtab.h b/policycoreutils/newrole/hashtab.h
> index ad5559ba..092b96a9 100644
> --- a/policycoreutils/newrole/hashtab.h
> +++ b/policycoreutils/newrole/hashtab.h
> @@ -81,20 +81,6 @@ extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
>   					   hashtab_datum_t d,
>   					   void *args), void *args);
>   
> -/*
> -   Insert or replace the specified (key, datum) pair in the specified
> -   hash table.  If an entry for the specified key already exists,
> -   then the specified destroy function is applied to (key,datum,args)
> -   for the entry prior to replacing the entry's contents.
> -
> -   Returns HASHTAB_OVERFLOW if insufficient space is available or
> -   HASHTAB_SUCCESS otherwise.
> - */
> -extern int hashtab_replace(hashtab_t h, hashtab_key_t k, hashtab_datum_t d,
> -			   void (*destroy) (hashtab_key_t k,
> -					    hashtab_datum_t d,
> -					    void *args), void *args);
> -
>   /*
>      Searches for the entry with the specified key in the hash table.
>   
> @@ -124,20 +110,6 @@ extern int hashtab_map(hashtab_t h,
>   				     hashtab_datum_t d,
>   				     void *args), void *args);
>   
> -/*
> -   Same as hashtab_map, except that if apply returns a non-zero status,
> -   then the (key,datum) pair will be removed from the hashtab and the
> -   destroy function will be applied to (key,datum,args).
> - */
> -extern void hashtab_map_remove_on_error(hashtab_t h,
> -					int (*apply) (hashtab_key_t k,
> -						      hashtab_datum_t d,
> -						      void *args),
> -					void (*destroy) (hashtab_key_t k,
> -							 hashtab_datum_t d,
> -							 void *args),
> -					void *args);
> -
>   extern void hashtab_hash_eval(hashtab_t h, char *tag);
>   
>   #endif
> 

