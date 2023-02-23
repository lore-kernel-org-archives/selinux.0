Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE09C636D7
	for <selinux@archiver.kernel.org>; Thu, 23 Feb 2023 07:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjBWHnL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Feb 2023 02:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWHnL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Feb 2023 02:43:11 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B93C8A7E
        for <selinux@vger.kernel.org>; Wed, 22 Feb 2023 23:43:09 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PMlHd0C9RzKmNj;
        Thu, 23 Feb 2023 15:38:05 +0800 (CST)
Received: from [10.67.110.167] (10.67.110.167) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 23 Feb 2023 15:42:56 +0800
Message-ID: <49f8735b-5d09-8f5e-d18d-1bb9f0f4c2a7@huawei.com>
Date:   Thu, 23 Feb 2023 15:42:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] libselinux: performance optimization for duplicate
 detection
To:     <selinux@vger.kernel.org>
CC:     <lautrbach@redhat.com>, <jwcart2@gmail.com>, <jason@perfinion.com>,
        <cgzones@googlemail.com>, <weiyuchen3@huawei.com>
References: <20230209114253.120485-1-wanghuizhao1@huawei.com>
 <20230217084458.40597-1-wanghuizhao1@huawei.com>
 <20230217084458.40597-4-wanghuizhao1@huawei.com>
From:   wanghuizhao <wanghuizhao1@huawei.com>
In-Reply-To: <20230217084458.40597-4-wanghuizhao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.167]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 2023/2/17 16:44, wanghuizhao wrote:
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 74ae9b9f..eebf9665 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> +
> +/*
>    * Warn about duplicate specifications.
>    */
>   static int nodups_specs(struct saved_data *data, const char *path)
>   {
> -	int rc = 0;
> -	unsigned int ii, jj;
> +	int rc = 0, ret = 0;
> +	unsigned int ii;
>   	struct spec *curr_spec, *spec_arr = data->spec_arr;
> +	struct chkdups_key *new = NULL;
> +	unsigned int hashtab_len = (data->nspec / 10) ? data->nspec / 10 : 1;
>   
> +	hashtab_t hash_table = hashtab_create(symhash, symcmp, hashtab_len);
> +	if (!hash_table) {
> +		rc = -1;
> +		COMPAT_LOG(SELINUX_ERROR, "%s: hashtab create failed.\n", path);
> +		return rc;
> +	}
>   	for (ii = 0; ii < data->nspec; ii++) {
> -		curr_spec = &spec_arr[ii];
> -		for (jj = ii + 1; jj < data->nspec; jj++) {
> -			if ((!strcmp(spec_arr[jj].regex_str,
> -				curr_spec->regex_str))
> -			    && (!spec_arr[jj].mode || !curr_spec->mode
> -				|| spec_arr[jj].mode == curr_spec->mode)) {
> -				rc = -1;
> -				errno = EINVAL;
> -				if (strcmp(spec_arr[jj].lr.ctx_raw,
> -					    curr_spec->lr.ctx_raw)) {
> -					COMPAT_LOG
> -						(SELINUX_ERROR,
> -						 "%s: Multiple different specifications for %s  (%s and %s).\n",
> -						 path, curr_spec->regex_str,
> -						 spec_arr[jj].lr.ctx_raw,
> -						 curr_spec->lr.ctx_raw);
> -				} else {
> -					COMPAT_LOG
> -						(SELINUX_ERROR,
> -						 "%s: Multiple same specifications for %s.\n",
> -						 path, curr_spec->regex_str);
> -				}
> +		new = (struct chkdups_key *)malloc(sizeof(struct chkdups_key));
> +		if (!new) {
> +			rc = -1;
> +			COMPAT_LOG(SELINUX_ERROR, "%s: hashtab key create failed.\n", path);
> +			return rc;
> +		}


I found a hashtab leak here. I'll fix it in the next patch version.

