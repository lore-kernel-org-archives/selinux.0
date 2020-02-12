Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CB2C2BA83
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878CF2082F
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 16:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OWQanJwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBLQAj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:00:39 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:51771 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBLQAj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 11:00:39 -0500
X-EEMSG-check-017: 55716200|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="55716200"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 16:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581523237; x=1613059237;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ruM7MjHNS1QTQwJQ5bNdJkrBeEAtlMnsNhVWNNeIF08=;
  b=OWQanJwxr0BFdy9Czb1T5wJxDhjxVe2z98JXksIaeWx1U2eUdOg3IM7N
   FhMK2UG20XxLVv9/4diFaZ29Gt4b6LYswdc6RCaAOj/ek5hIgCMSouoTN
   QsmmgP1MVzoRGbeKlcU35WjOnVb6ArsoKuNFRDpEamTLE3mH7PfFnAeza
   dL8/hrq0GhMQNYtlOF3o6EobbHqtmx6cpK71aTP9IEx4hV4SHQAJM0Wvy
   TqLfAAd0CK8ceAn4lqcGcqbWBZH8KyujBkyczj+NCVFl2/IRtsrngA8ur
   YOV/Ml3b2xfft2JnbaKZCTpo/KRHNs8oL7sj+wdmxI6JtUw4iRHXpLQC8
   A==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="32977697"
IronPort-PHdr: =?us-ascii?q?9a23=3AxbYxRBN3+4J5aBkkYvkl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/jzrarrMEGX3/hxlliBBdydt6sYzbSL+PC7EUU7or+/81k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba59IRmsrAjctsYajIhsJ60s1h?=
 =?us-ascii?q?bHv3xEdvhZym9vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg0zb0GvI?=
 =?us-ascii?q?S0fCkMyJk/yB7fauCHc4iV4h34TuqePTB4hHdjdbmihBiy6VCtxvDzW8S7yl?=
 =?us-ascii?q?pHrjdJnsPSun0CyRDf8NWLR/1g9Um7wzmPzRrc6uRcLEAxkqrUNoAuz6Yrlp?=
 =?us-ascii?q?oWrUTDBij2mFjqjKOOdkUr5Oyo6+P/b7X6vJCcLY50ihzlMqg0m8y/B+o4Mg?=
 =?us-ascii?q?8VX2eF5euwzqHj/E3lT7VKif06iK/Zv4zBJcsHvKK5Bg5V0oI75xa+CTepzs?=
 =?us-ascii?q?gYkGEaIF9Kdx+LlYjkN0zULPzmAvqznU6gnCpzy/DDJLLhA5HNLnbZkLfmeL?=
 =?us-ascii?q?Zw81Vcxxcozd1E+5JVCq0OIPL0WkPrstzYFQU2Pxa7w+bgFtVxzpkeVn6XAq?=
 =?us-ascii?q?+FLKPStkeF5vorI+aWeY8VpCz9JOM/6PP1l382h0ISfamz0psLcny3AvNmI0?=
 =?us-ascii?q?CBa3r2ntgBCXsKvhY5TOHyk12NTzpTZ3e0X6Ih6TA2E5ymDYjdSYC3mrCB3z?=
 =?us-ascii?q?m0HodQZm9YDlCAC3Dod5+LW6REVCXHGsJ9iHQgXKW9UYUo3hHm4Bf+wqd7NO?=
 =?us-ascii?q?Dd0jcVuZLqyJ5+4OiF0Vkp+Dh1CdmN+3+CQnsynW4SQTIymqdlrh9T0FCGhJ?=
 =?us-ascii?q?NkjuRYGNob3PZAVgM3JNaI1OBhI8zjUQLGONGSQRCpRcvwUmJ5dc4439JbOx?=
 =?us-ascii?q?U1IN6llB2WmnPxUrI=3D?=
X-IPAS-Result: =?us-ascii?q?A2B7AgDhH0Re/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVAEgEiqEFIkDhmUBAQEBAQEGgTeJcIomhyMJAQEBAQEBAQEBKwwBAYN7R?=
 =?us-ascii?q?QKCbTgTAhABAQEEAQEBAQEFAwEBbIU3DII7KQGDAQEBAQECASMVRgsLDgoCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgmM/AYJWBSAPqm11gTKFSoNKgTgGgQ4qjD55gQeBEScPg?=
 =?us-ascii?q?l0+gmQChHWCXgSXRUaXa4JEgk6EfoVIiTUGHJsVLY45iG6UTSKBWCsIAhgII?=
 =?us-ascii?q?Q87gmxQGA2SEIpxIwMwkWEBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Feb 2020 16:00:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CFxdXV089925;
        Wed, 12 Feb 2020 10:59:39 -0500
Subject: Re: [PATCH v5] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20200211101438.403297-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <214082e2-690c-0e69-2f58-f7926ef29673@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 11:01:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211101438.403297-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/11/20 5:14 AM, Petr Lautrbach wrote:
> get_ordered_context_list() code used to ask the kernel to compute the complete
> set of reachable contexts using /sys/fs/selinux/user aka
> security_compute_user(). This set can be so huge so that it doesn't fit into a
> kernel page and security_compute_user() fails. Even if it doesn't fail,
> get_ordered_context_list() throws away the vast majority of the returned
> contexts because they don't match anything in
> /etc/selinux/targeted/contexts/default_contexts or
> /etc/selinux/targeted/contexts/users/
> 
> get_ordered_context_list() is rewritten to compute set of contexts based on
> /etc/selinux/targeted/contexts/users/ and
> /etc/selinux/targeted/contexts/default_contexts files and to return only valid
> contexts, using security_check_context(), from this set.
> 
> Fixes: https://github.com/SELinuxProject/selinux/issues/28
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---

> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
> index 689e46589f30..6078d980cde1 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -463,40 +467,18 @@ int get_ordered_context_list(const char *user,
>   				__FUNCTION__, selinux_default_context_path());
>   			/* Fall through */
>   		}
> -		rc = 0;
> +		rc = nreachable;

Shouldn't we do this outside the if (fp) statement?  Otherwise, if we 
got some reachable contexts from the per-user contexts file but the 
global default_contexts file was missing, we'll end up freeing the 
reachable contexts and returning 0 on the out path.

>   	}
>   
> -	if (!nordered)
> +	if (!nreachable)
>   		goto failsafe;
>   
> -	/* Apply the ordering. */
> -	co = malloc(nreach * sizeof(struct context_order));
> -	if (!co)
> -		goto failsafe;
> -	for (i = 0; i < nreach; i++) {
> -		co[i].con = reachable[i];
> -		co[i].order = ordering[i];
> -	}
> -	qsort(co, nreach, sizeof(struct context_order), order_compare);
> -	for (i = 0; i < nreach; i++)
> -		reachable[i] = co[i].con;
> -	free(co);
> -
> -	/* Only report the ordered entries to the caller. */
> -	if (nordered <= nreach) {
> -		for (i = nordered; i < nreach; i++)
> -			free(reachable[i]);
> -		reachable[nordered] = NULL;
> -		rc = nordered;
> -	}
> -
>         out:
>   	if (rc > 0)
>   		*list = reachable;
>   	else
>   		freeconary(reachable);
>   
> -	free(ordering);
>   	if (freefrom)
>   		freecon(fromcon);
>   
> 

