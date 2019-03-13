Return-Path: <SRS0=LIAv=RQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8ECC43381
	for <selinux@archiver.kernel.org>; Wed, 13 Mar 2019 18:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2B021019
	for <selinux@archiver.kernel.org>; Wed, 13 Mar 2019 18:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mZvJ5Rbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfCMSGj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:06:39 -0400
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:53699 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCMSGj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Mar 2019 14:06:39 -0400
X-EEMSG-check-017: 207012797|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Mar 2019 18:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1552500391; x=1584036391;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=WJbn8CB61VGTqQNF+GY4uC4cfzqMYv+VE3q5w7NUKY4=;
  b=mZvJ5Rbxs1Y6NKuPgdp54/HLLXjrTZSGyJu0U5abW3mdDHjabVa91si3
   uu0IVPk1VdVee1Q+n+nezuX7hvEkNL/tlP2h/+x3GWFgCVGnny+4q58Ho
   8nIxhimqZdy2dZSzlFQcBL1YS50hTrAWXT2l/dnjei45i/FFmnLl5HpvZ
   75Io3TbY/f68AH0znu+MJEOoG7o46fnOn7clWL5Az/PBPlB7b2Bm9o9nF
   /yYdWdctgN+9OkJkSXjodiYvTQjWEjf/xPYTL60Nyfm87RFEpDHg3UGNK
   7JXdhNMnyAIUHp+HPDxiuNrprlUTx4Lla3JCwF+eRp1ARimxA3mjxScdJ
   A==;
X-IronPort-AV: E=Sophos;i="5.58,475,1544486400"; 
   d="scan'208";a="21445784"
IronPort-PHdr: =?us-ascii?q?9a23=3AQSuSvRHdnfQfRG2OxFIz1J1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zpcWwAkXT6L1XgUPTWs2DsrQY0rKQ6/mocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmSaxbaluIBmrsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/Vj?=
 =?us-ascii?q?q476dvVRTmliEJOTAk+23Tk8B9gqZWrBenqhdiwYDbfZuVOeJjcK3Dc9MURW?=
 =?us-ascii?q?lPUMhfWCNOAIyzc4QBAvEdPetatYTxu0cCoBW8CASqGejhyiVIhnjz3aAizu?=
 =?us-ascii?q?ohDR/J3BQgH90QtnTfscj7NKIIXuCxyKnH0zXCZO5R1Dfm9YfIaQssoe2MXL?=
 =?us-ascii?q?1sccrRzlMjFwXejlqKs4DlMDSV1voUvmWd8uFuVvqvhnY6pwx+rTWj3Mchhp?=
 =?us-ascii?q?TTio4LxV3I6z91zJszKNalUkB0e8SkH4FVtyyCMot2Rd4tTH9wtSYhz70GpY?=
 =?us-ascii?q?a7fC8XyJQ73xLfa+KIc4yP4h/7SOaeOy14hHN4eLKknRqy7UihxfH8Vsmzyl?=
 =?us-ascii?q?pKqDZKksLQuXwX0hzT68yHRuN8/kenxzmPyxje5vxLLE07j6bWK4MtzqQump?=
 =?us-ascii?q?ccr0jPBDL6lF3zjKCMd0Uk/uao6/7gYrXjvpKcLJJ7ihrlP6Qyms2wHeQ4Mg?=
 =?us-ascii?q?8UU2id4uSzzqfv/UL+QLVUlvE2iLXWsIjGJcQHoa60GwBU0psl6xmjDzepyt?=
 =?us-ascii?q?IYnXYcIVJKfxKHiIfpO1XQL/ziEfi/hFGsmi9xx//aJr3hHonNLn/bnbf6Y7?=
 =?us-ascii?q?l9709cyAwuzdFQ/J9UFL4BL+zpWkPrt9zXEAU5MwqqzObjEtl90ZkeWW3cSp?=
 =?us-ascii?q?OeZbPPt1SI7+Qga72ceYkeuD/7JNAq4PnhiXJ/klgYK+3hxpYTaXalDtx4LE?=
 =?us-ascii?q?iDJ3nhmNEMFSENpAVtYvbtjQi5TTNLZ3u0F5k57zU/BZPuWZzPXaixkbeB22?=
 =?us-ascii?q?G9BZQQaWdYXAPfWUz0fpmJDq9fIBmZJdVsx3lfBLU=3D?=
X-IPAS-Result: =?us-ascii?q?A2CHAQCQRYlc/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?WUqgTgzJ4QKkzpMAQEBAQEBBoEICCV8iEOQEwNUOAGEQAKERiI3Bg0BAQMBA?=
 =?us-ascii?q?QEIAQMCAWwogjopgmgBBSMEEVELGAICJgICVwYBDAYCAQGCXz+BaQ2ueHwzh?=
 =?us-ascii?q?UWEbIELJAGLLBd4gQeBEScMgio1iAuCVwOKFgaHKIEYkV4JkxcGGYF7kUyKf?=
 =?us-ascii?q?YETk1IiNYEhKwgCGAghD4MnghMCAReOOiMDMIEFAQGPOgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Mar 2019 18:06:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2DI6RI5021267;
        Wed, 13 Mar 2019 14:06:27 -0400
Subject: Re: [PATCH] Restorecon: factor out a lookup helper for context
 matches
To:     xunchang <xunchang@google.com>, selinux@vger.kernel.org
References: <20190311222442.49824-1-xunchang@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8d257c8b-4a90-6664-49ee-4108ff9efc7a@tycho.nsa.gov>
Date:   Wed, 13 Mar 2019 14:06:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311222442.49824-1-xunchang@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/11/19 6:24 PM, xunchang wrote:
> We used to hash the file_context and skip the restorecon on the top
> level directory if the hash doesn't change. But the file_context might
> change after an update; and some users experienced long restorecon
> time as they have lots of files under directories like /data/media.
> Therefore, we try to skip unnecessary restores if the file context
> relates to the given directory doesn't change.
> 
> This CL is the first step that factors out a lookup helper function
> and returns an array of matched pointers instead of a single one.
> The old loopup_common function is then modified to take the first
> element in the array.
> 
> This change has already been submitted in android selinux branch. And
> porting it upstream will make these two branches more consistent and
> save some work for the future merges.
> 
> Signed-off-by: Tianjie Xu <xunchang@google.com>

This looks good to me but we might defer merging it until after the 
selinux userspace 2.9 release.

> ---
>   libselinux/include/selinux/label.h |   4 ++
>   libselinux/src/label.c             |   9 +++
>   libselinux/src/label_file.c        | 111 +++++++++++++++++++++++------
>   libselinux/src/label_internal.h    |   2 +
>   4 files changed, 106 insertions(+), 20 deletions(-)
> 
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
> index 277287ed..e537aa11 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -7,6 +7,7 @@
>   #define _SELABEL_H_
>   
>   #include <stdbool.h>
> +#include <stdint.h>
>   #include <sys/types.h>
>   #include <selinux/selinux.h>
>   
> @@ -105,6 +106,9 @@ int selabel_lookup_raw(struct selabel_handle *handle, char **con,
>   
>   bool selabel_partial_match(struct selabel_handle *handle, const char *key);
>   
> +bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
> +                                      const char *key, uint8_t* digest);
> +
>   int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
>   			      const char *key, const char **aliases, int type);
>   int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 8d586bda..1d16f685 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -274,6 +274,15 @@ bool selabel_partial_match(struct selabel_handle *rec, const char *key)
>   	return rec->func_partial_match(rec, key);
>   }
>   
> +bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
> +                                      const char *key, uint8_t *digest) {
> +	if (!rec->func_hash_all_partial_matches) {
> +		return false;
> +	}
> +
> +	return rec->func_hash_all_partial_matches(rec, key, digest);
> +}
> +
>   int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
>   			      const char *key, const char **aliases, int type)
>   {
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index b81fd552..90cbd666 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -843,22 +843,38 @@ static void closef(struct selabel_handle *rec)
>   	free(data);
>   }
>   
> -static struct spec *lookup_common(struct selabel_handle *rec,
> -					     const char *key,
> -					     int type,
> -					     bool partial)
> +// Finds all the matches of |key| in the given context. Returns the result in
> +// the allocated array and updates the match count. If match_count is NULL,
> +// stops early once the 1st match is found.
> +static const struct spec **lookup_all(struct selabel_handle *rec,
> +                                      const char *key,
> +                                      int type,
> +                                      bool partial,
> +                                      size_t *match_count)
>   {
>   	struct saved_data *data = (struct saved_data *)rec->data;
>   	struct spec *spec_arr = data->spec_arr;
>   	int i, rc, file_stem;
>   	mode_t mode = (mode_t)type;
>   	const char *buf;
> -	struct spec *ret = NULL;
>   	char *clean_key = NULL;
>   	const char *prev_slash, *next_slash;
>   	unsigned int sofar = 0;
>   	char *sub = NULL;
>   
> +	const struct spec **result = NULL;
> +	if (match_count) {
> +		*match_count = 0;
> +		result = calloc(data->nspec, sizeof(struct spec*));
> +	} else {
> +		result = calloc(1, sizeof(struct spec*));
> +	}
> +	if (!result) {
> +		selinux_log(SELINUX_ERROR, "Failed to allocate %zu bytes of data\n",
> +			    data->nspec * sizeof(struct spec*));
> +		goto finish;
> +	}
> +
>   	if (!data->nspec) {
>   		errno = ENOENT;
>   		goto finish;
> @@ -899,18 +915,33 @@ static struct spec *lookup_common(struct selabel_handle *rec,
>   		 * specified or if the mode matches the file mode then we do
>   		 * a regex check        */
>   		if ((spec->stem_id == -1 || spec->stem_id == file_stem) &&
> -		    (!mode || !spec->mode || mode == spec->mode)) {
> +				(!mode || !spec->mode || mode == spec->mode)) {
>   			if (compile_regex(data, spec, NULL) < 0)
>   				goto finish;
>   			if (spec->stem_id == -1)
>   				rc = regex_match(spec->regex, key, partial);
>   			else
>   				rc = regex_match(spec->regex, buf, partial);
> -			if (rc == REGEX_MATCH) {
> -				spec->matches++;
> -				break;
> -			} else if (partial && rc == REGEX_MATCH_PARTIAL)
> +
> +			if (rc == REGEX_MATCH || (partial && rc == REGEX_MATCH_PARTIAL)) {
> +				if (rc == REGEX_MATCH) {
> +					spec->matches++;
> +				}
> +
> +				if (strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
> +					errno = ENOENT;
> +					goto finish;
> +				}
> +
> +				if (match_count) {
> +					result[*match_count] = spec;
> +					*match_count += 1;
> +					// Continue to find all the matches.
> +					continue;
> +				}
> +				result[0] = spec;
>   				break;
> +			}
>   
>   			if (rc == REGEX_NO_MATCH)
>   				continue;
> @@ -921,19 +952,58 @@ static struct spec *lookup_common(struct selabel_handle *rec,
>   		}
>   	}
>   
> -	if (i < 0 || strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
> -		/* No matching specification. */
> -		errno = ENOENT;
> -		goto finish;
> -	}
> -
> -	errno = 0;
> -	ret = &spec_arr[i];
> -
>   finish:
>   	free(clean_key);
>   	free(sub);
> -	return ret;
> +	if (result && !result[0]) {
> +		free(result);
> +		result = NULL;
> +	}
> +	return result;
> +}
> +
> +static struct spec *lookup_common(struct selabel_handle *rec,
> +                                  const char *key,
> +                                  int type,
> +                                  bool partial) {
> +	const struct spec **matches = lookup_all(rec, key, type, partial, NULL);
> +	if (!matches) {
> +		return NULL;
> +	}
> +	struct spec *result = (struct spec*)matches[0];
> +	free(matches);
> +	return result;
> +}
> +
> +static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key, uint8_t *digest)
> +{
> +	assert(digest);
> +
> +	size_t total_matches;
> +	const struct spec **matches = lookup_all(rec, key, 0, true, &total_matches);
> +	if (!matches) {
> +		return false;
> +	}
> +
> +	Sha1Context context;
> +	Sha1Initialise(&context);
> +	size_t i;
> +	for (i = 0; i < total_matches; i++) {
> +		char* regex_str = matches[i]->regex_str;
> +		mode_t mode = matches[i]->mode;
> +		char* ctx_raw = matches[i]->lr.ctx_raw;
> +
> +		Sha1Update(&context, regex_str, strlen(regex_str) + 1);
> +		Sha1Update(&context, &mode, sizeof(mode_t));
> +		Sha1Update(&context, ctx_raw, strlen(ctx_raw) + 1);
> +	}
> +
> +	SHA1_HASH sha1_hash;
> +	Sha1Finalise(&context, &sha1_hash);
> +	memcpy(digest, sha1_hash.bytes, SHA1_HASH_SIZE);
> +
> +	free(matches);
> +	return true;
>   }
>   
>   static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> @@ -1133,6 +1203,7 @@ int selabel_file_init(struct selabel_handle *rec,
>   	rec->func_stats = &stats;
>   	rec->func_lookup = &lookup;
>   	rec->func_partial_match = &partial_match;
> +	rec->func_hash_all_partial_matches = &hash_all_partial_matches;
>   	rec->func_lookup_best_match = &lookup_best_match;
>   	rec->func_cmp = &cmp;
>   
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> index 0e020557..1fa5ade6 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -87,6 +87,8 @@ struct selabel_handle {
>   	void (*func_close) (struct selabel_handle *h);
>   	void (*func_stats) (struct selabel_handle *h);
>   	bool (*func_partial_match) (struct selabel_handle *h, const char *key);
> +	bool (*func_hash_all_partial_matches) (struct selabel_handle *h,
> +	                                       const char *key, uint8_t *digest);
>   	struct selabel_lookup_rec *(*func_lookup_best_match)
>   						    (struct selabel_handle *h,
>   						    const char *key,
> 

