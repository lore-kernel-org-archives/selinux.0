Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF43C31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 14:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F23214AF
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 14:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="C962pS3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfFSOpK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:45:10 -0400
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:60916 "EHLO
        UCOL19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOpF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 10:45:05 -0400
X-EEMSG-check-017: 30362409|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,392,1557187200"; 
   d="scan'208";a="30362409"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Jun 2019 14:44:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560955487; x=1592491487;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=aTwHpeNJgqZQXDtbSUN8GUucDvywbrQVXc0Rsn1i6CE=;
  b=C962pS3l8wTN3XpSprMcWbHNk29tsmZtk72M4Un3ULGfQCNc0CqBHJgD
   Fr2ryPh/LfePz4WLiRNM/lnhK2fQKnbeVH2K4Yft9lVxRyW+JnVHkX0oq
   3NdrRgRpVgwnw2YNy50ySmFgetfJM/6eJIb9j0KPF350G/QtV3U293j+c
   KR6NoqOaWAz4ZrIjsLfS8Zl1FsrzkrVJznQYNVKxUf0pXKpHBfuaNUTQe
   oOjH7tA04RoNnaOKB8WfAVtYFNlr/o56ihR6T3ODLwSac/fiCHLa5pk65
   sXpQirTQs689kJ1P9n6tLXC/AUL8p/ct3rz5nJNfOFARJbp3r8VhyOE17
   w==;
X-IronPort-AV: E=Sophos;i="5.63,392,1557187200"; 
   d="scan'208";a="24903237"
IronPort-PHdr: =?us-ascii?q?9a23=3AOk4OjRcMbLPiq6ESmnvBV41slGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26YBeN2/xhgRfzUJnB7Loc0qyK6vqmATZLvM3J8ChbNsAVDl?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN7g9xg?=
 =?us-ascii?q?HVrndWdOhbxW1lLk+Xkxrg+8u85pFu/zlNt/4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsOqofVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NulgH/Mrghmsy4AegiNA?=
 =?us-ascii?q?gBQ3Ob9vim2L3m/E35RK1GjvwwkqbHrJDXPdkXq6G2DgNP0osv9gyzAymp3d?=
 =?us-ascii?q?gGh3ULMUpJeBedgIjoP1HOLur4DfC6g1m0izdk2uvGM6b9ApTNMnfDkLDhca?=
 =?us-ascii?q?x7605H0gU/199f55VKCr0ZOvL8RlfxtMDEDh8+KwG1zPvnCNNh2YMeQ22PBK?=
 =?us-ascii?q?CZPbjdsV+P4eIvLO2Ma5EPtDnhLPgl4ubkjWUlll8FYampwZwXZWijHvt4J0?=
 =?us-ascii?q?WZYHzsgsoOEGoRoAo+Q/LliEeYXT5QeXmyRaQ86S8/CI68CofDXI+tiqSb3C?=
 =?us-ascii?q?inBp1WenxGCleUHHfydoWLR/cMZziIIsB8ijMLSaCuS4872hGvsg/11aFnI/?=
 =?us-ascii?q?HP9S0EtJLj0sR16PPJlRE06zN0E96R3H2KT2FxzSs0QGomwaZ0oUV7xR/Xwb?=
 =?us-ascii?q?V+iPxRE9N76PROXQM3c5Xbyro+Q8v/XgPHY8ehVlmrWJOlDCs3Q9Z3xMUBJw?=
 =?us-ascii?q?5HGt6ihwrPlwqjArkYjPTfHp0/8qvG00/6EMZ0ynDLz4Erk1ggXsZVM2C6wK?=
 =?us-ascii?q?V48l6AKZTOlhCii6uydakalBXI/WOHwHvG6FpUSyZsQK7FWjYZfUKQotPnsB?=
 =?us-ascii?q?CRB4SyAKgqZ1MSgfWJLbFHP5iw1gRL?=
X-IPAS-Result: =?us-ascii?q?A2CCBADdSApd/wHyM5BmHgEGBwaBZ4FtKoE7ATIohBaSc?=
 =?us-ascii?q?0wBAQEBAQEGgTV+iFWQNQNUCQEBAQEBAQEBATQBAgEBhEACglgjOBMBAwEBA?=
 =?us-ascii?q?QQBAQEBBAEBbIpDgjopAYJmAQEBAQIBIwQRUQsYAgImAgJXBgEMBgIBAYJfP?=
 =?us-ascii?q?4F3BQ+rDH4zhUeDJoFGgQwoi14XeIEHgREngjY1PodOglgEi2YGiEGBKZQPC?=
 =?us-ascii?q?YITghuRMgYbgieVDY0dgSyXSiE3gSErCAIYCCEPgyeCSgIBF448IwMwgQYBA?=
 =?us-ascii?q?Y5qAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Jun 2019 14:44:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5JEij8h024242;
        Wed, 19 Jun 2019 10:44:46 -0400
Subject: Re: [PATCH] Restorecon: factor out a lookup helper for context
 matches
To:     xunchang <xunchang@google.com>, selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
References: <20190311222442.49824-1-xunchang@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3a5038d7-cb5b-de62-23ee-e22324a8a989@tycho.nsa.gov>
Date:   Wed, 19 Jun 2019 10:44:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
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

There were some changes to this patch before it landed in AOSP, so they 
aren't quite consistent.  Do you want to submit the final patch?

> 
> Signed-off-by: Tianjie Xu <xunchang@google.com>
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

