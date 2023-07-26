Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D72C001B0
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 15:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjGZPzm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 11:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjGZPzl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 11:55:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F02A82109
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 08:55:39 -0700 (PDT)
Received: from [192.168.1.10] (pool-96-241-71-43.washdc.fios.verizon.net [96.241.71.43])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3A6552380B28;
        Wed, 26 Jul 2023 08:55:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A6552380B28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690386939;
        bh=MSLH9r5OVmh7NATFcCdzFGpnLjuhFplECYzplAKu2CY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=fObU/GTv0Ppk68z0/hQHEt6A2li+wMcHb/tkEase8f2QwWbSKf4K6WGM0PFvx0meT
         Qxii7wbxg6lNVRo7l4EodYJ0n0SyZppP5UOp/jsQUbea9SbirzFrgsRmoGoRtRtq6V
         3BQwY+Ov8MzyNaPVj3xE48c8cOzheIqFFQlSXEy8=
Message-ID: <6c74b08b-4319-b21a-6570-330f570c3660@linux.microsoft.com>
Date:   Wed, 26 Jul 2023 11:55:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 9/9 v3] secilc/docs: Add deny rule to CIL documentation
Content-Language: en-US
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
References: <20230413193445.588395-1-jwcart2@gmail.com>
 <20230413193445.588395-10-jwcart2@gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20230413193445.588395-10-jwcart2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/13/2023 3:34 PM, James Carter wrote:
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v3: Remove the "*Where" section, since the notself patch series moves all of
>      that to beginning of the access vector section before talking about specific
>      rules.

It doesn't look to me like the patch matches this description.  I still 
see a "where" section added.

(Presumably the updated patch should also add deny to the "av_flavor" 
portion of the new common "Where" section)

-Daniel

> 
>   secilc/docs/cil_access_vector_rules.md | 67 ++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
> index 034185da..385c4f4a 100644
> --- a/secilc/docs/cil_access_vector_rules.md
> +++ b/secilc/docs/cil_access_vector_rules.md
> @@ -175,6 +175,73 @@ This example will not compile as `type_3` is not allowed to be a source type for
>           (allow type_3 self (property_service (set)))
>       )
>   ```
> +deny
> +----------
> +
> +Remove the access rights defined from any matching allow rules. These rules are processed before [`neverallow`](cil_access_vector_rules.md#neverallow) checking.
> +
> +**Rule definition:**
> +
> +```secil
> +    (deny source_id target_id|self classpermissionset_id ...)
> +```
> +
> +**Where:**
> +
> +<table>
> +<colgroup>
> +<col width="27%" />
> +<col width="72%" />
> +</colgroup>
> +<tbody>
> +<tr class="odd">
> +<td align="left"><p><code>deny</code></p></td>
> +<td align="left"><p>The <code>deny</code> keyword.</p></td>
> +</tr>
> +<tr class="even">
> +<td align="left"><p><code>source_id</code></p></td>
> +<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
> +</tr>
> +<tr class="odd">
> +<td align="left"><p><code>target_id</code></p></td>
> +<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
> +<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
> +</tr>
> +<tr class="even">
> +<td align="left"><p><code>classpermissionset_id</code></p></td>
> +<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
> +</tr>
> +</tbody>
> +</table>
> +
> +**Example:**
> +
> +```secil
> +    (class class1 (perm1 perm2))
> +
> +    (type type1)
> +    (type type2)
> +    (allow type1 type2 (class1 (perm1))) ; Allow-1
> +    (deny type1 type2 (class1 (perm1)))  ; Deny-1
> +    ; Allow-1 will be complete removed by Deny-1.
> +
> +    (type type3)
> +    (type type4)
> +    (allow type3 type4 (class1 (perm1 perm2))) ; Allow-2
> +    (deny type3 type4 (class1 (perm1)))        ; Deny-2
> +    ; Allow-2 will be removed and replaced with the following when Deny-2 is evaluated
> +    ; (allow type3 type4 (class1 (perm2)))
> +
> +    (type type5)
> +    (type type6)
> +    (typeattribute attr1)
> +    (typeattributeset attr1 (type5 type6))
> +    (allow attr1 attr1 (class1 (perm1))) ; Allow-3
> +    (deny type5 type6 (class1 (perm1)))  ; Deny-3
> +    ; Allow-3 will be removed and replaced with the following when Deny-3 is evaluated
> +    ; (allow type6 attr1 (class1 (perm1)))
> +    ; (allow type5 type5 (class1 (perm1)))
> +```
>   
>   allowx
>   ------

