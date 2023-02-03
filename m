Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD5C61DA4
	for <selinux@archiver.kernel.org>; Fri,  3 Feb 2023 22:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjBCWzI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Feb 2023 17:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjBCWzH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Feb 2023 17:55:07 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ACA47D2A8
        for <selinux@vger.kernel.org>; Fri,  3 Feb 2023 14:55:06 -0800 (PST)
Received: from [192.168.1.10] (pool-96-241-71-43.washdc.fios.verizon.net [96.241.71.43])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8D45520C7DD1;
        Fri,  3 Feb 2023 14:55:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D45520C7DD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675464905;
        bh=YFGH+CazbSBJN19u9ZpHb2v/wTazVYspnE+yNE7+YQI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=eE5QLihyo38cBNYGdEJ/UFGdo05NhzjPTkULDn88VDULy9Cw6upJKG+CpIsWXlsZh
         dJ5NTqzEqWuU5A0D+qDSSndCwBOmAhPoYoMT86dhiSSAtpXN2M4EwQXXMqGUFPjasW
         keX8CsUvRuA9T+VjI4dAIjo7vjgm28P6kzEwJTTc=
Message-ID: <98d7a37e-dcfb-ca7d-24d1-57f2a3abbadd@linux.microsoft.com>
Date:   Fri, 3 Feb 2023 17:55:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 9/9] secilc/docs: Add deny rule to CIL documentation
Content-Language: en-US
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
References: <20221215213429.998948-1-jwcart2@gmail.com>
 <20221215213429.998948-10-jwcart2@gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20221215213429.998948-10-jwcart2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/15/2022 4:34 PM, James Carter wrote:
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>   secilc/docs/cil_access_vector_rules.md | 68 ++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
> index f0ba4a90..35825283 100644
> --- a/secilc/docs/cil_access_vector_rules.md
> +++ b/secilc/docs/cil_access_vector_rules.md
> @@ -247,6 +247,74 @@ This example will not compile as `type_3` is not allowed to be a source type for
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
> +	(type type_1)
> +    (type type_2)
> +	(allow type_1 type_2 (class1 (perm1))) ; Allow_1
> +	(deny type_1 type_2 (class1 (perm1)))  ; Deny_1
> +  	; Allow_1 will be complete removed by Deny_1.
> +
> +    (type type_3)
> +	(type type_4)
> +	(allow type_3 type_4 (class1 (perm1 perm2))) ; Allow_2
> +	(deny type_3 type_4 (class1 (perm1)))        ; Deny_2
> +	; Allow_2 will be removed and replaced with the following when Deny_2 is evaluated
> +    ; (allow type_3 type_4 (class1 (perm2)))
> +
> +	(type type_5)
> +	(type type_6)
> +	(typeattribute attr_1)
> +	(typeattributeset attr_1 (type_5 type_6))
> +	(allow attr_1 attr_1 (class1 (perm1))) ; Allow_3
> +	(deny type_5 type_6 (class1 (perm1)))  ; Deny_3
> +	; Allow_3 will be removed and replaced with the following when Deny_3 is evaluated
> +	; (allow type_6 attr_1 (class1 (perm1)))
> +	; (allow attr_1 type_5 (class1 (perm1)))
> +    )
> +```

Looks like theres some intermixing of spaces and tabs messing up 
formatting on the example.

-Daniel
>   
>   allowx
>   ------

