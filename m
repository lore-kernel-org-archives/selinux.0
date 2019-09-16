Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19B0C49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 14:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E68F20830
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 14:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="GFmlUqHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfIPOnv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:43:51 -0400
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:13898 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbfIPOnu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 10:43:50 -0400
X-EEMSG-check-017: 25600179|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="25600179"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 14:43:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568645029; x=1600181029;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=x2Q2EyF8kkVpOGWc4SZpqkPBTKj3qUoKWM1md1gBlsY=;
  b=GFmlUqHhjhgzx/mziAjg3mDxnx0Eca761/5h2AKnAmq+ejd2c1zHw0Bh
   DSttqz7+7SFc9jg3tiU9u7ZPY6/Mao4fFAfFYyEPpgP/5Xb5LLszBk651
   9CZk2mvzRjePqtyc8VhdQ/URQHGmrqpGeQ3HcASpMJNn9GwewhoLiGudr
   q5RYIfScjkp/toGnkmHkLSfbtVpNLi1gVOAMMdKBcWeJFXEvjyEH7maQc
   WjNdxUdwFRksE7+jO8lr4gJn5HtBI1dXDdWxlSuCDJeHB+a2NzY0qijI6
   iCCgkw5V/C3LTNPA3iU3A9Q+WbcFfd3jWVzhueKROsbSs879a2OqGp+/9
   w==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="32893979"
IronPort-PHdr: =?us-ascii?q?9a23=3AQm86zxAMLrYa5TfA0YsiUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP36p86wAkXT6L1XgUPTWs2DsrQY0rGQ6vurBjNIoc7Y9ixbKtoUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIVvJrwsxh?=
 =?us-ascii?q?bHrXdFeeZbzn5sKV6Pghrw/Mi98IN9/yhKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHXm?=
 =?us-ascii?q?dKQNpfWDJdDYO9d4sPDvQOPeBEr4nmulACqQKyCRSwCO/zzzNFgHH53bc+0+?=
 =?us-ascii?q?88Dw/I2gIuFM8KvHjNotj4MKIeXOaox6fK0DrDdetb1yrj5ojGch4vov+CUr?=
 =?us-ascii?q?x/fsXT1UYhGBjIjkmSpIH/Iz+ZyuoAvmqd4uF9VeyvkWknqwRprzay2scjlJ?=
 =?us-ascii?q?HJhoILxVDC6C533YM1Kse8SE5/f9GlEIZbuiaBN4RrWcMvWH1ouSYmxb0Gvp?=
 =?us-ascii?q?63Zi4KyI89yBLFZPyHdJaI7wvlWe2MLzl4g3dld6i+hxa06UWg0PPzWdS00F?=
 =?us-ascii?q?lQsipJiMXDtncI1xHV98OJSeN981+81TuA2A3f8OFJLV0umabFJJMt3KQ8mo?=
 =?us-ascii?q?cVvE/eBCH5gl/2g7WTdkg8/+io7Pnobav+q5+HMo90lhn+MqMzmsyjGeg4Mh?=
 =?us-ascii?q?YBX2yc+emkyL3s51f5QLRXjv0tiKXZrJDbKtgbpq6+GQNV1Jos6w2jADu81d?=
 =?us-ascii?q?QYnH0HIEpEeBKBkYfpJ0nDLO33APqwmVihkCpny+rYMrDuHJnBNGXPnK/kfb?=
 =?us-ascii?q?ln6k5czAQzzcpY55JRErwBO+/8WlTqudzEDh42Lwy0w+H9BNV7zYMRQ3iDAq?=
 =?us-ascii?q?CeMKPMqVOI/P4gI/GQZI8JvzbwM/8l5/vpjX8in18SZ7Wm0oUMZXCiAPtpPk?=
 =?us-ascii?q?WZbmDwgtsbDWgKuQ8+RvTwiFKeST5Te2qyX6Uk6zEgFo2mCYbDRoawgL2Oxy?=
 =?us-ascii?q?q7AJJWaX5cClyWEnfnaZ+EW/ESZyKWOMNhlSYEVbe5QY87yR6urBP6y6ZgLu?=
 =?us-ascii?q?fM4i0Xr4/j1Nxu6u3Ljx4y6Dh0A92Y02GKSGF0hH0HSyUq06B4pEx30k2D3r?=
 =?us-ascii?q?Rgg/xECdxT4OtEUgIhNZHCzOx6D879Wh7bcdqSUlapXMipATErQdIt2dMBf0?=
 =?us-ascii?q?F9G9DxxizEig2sD6UYlfSuA4cy+6nR3DClIMN60HDP36QJlVQqQsJTc2ahg/?=
 =?us-ascii?q?g7vxPeA4/PjlWxiamnb+If0TTL+WPFynCB+AlgWRN0GYDCWmoSLh/OpMn9zl?=
 =?us-ascii?q?vLUrvrDLMgKAYHwsmHfPhkcNrs2G5aSe/jNdKWWGe4n2O9FF7c3b+XRJb7cG?=
 =?us-ascii?q?UamiPGAQ4LlB5FriXODhQ3Gir0+zGWNzdpD1+6Jhq3oOQ=3D?=
X-IPAS-Result: =?us-ascii?q?A2DQAABSn39d/wHyM5BmHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?W0qbVMyKoQhj1gBAQaBESWJc49AgWcJAQEBAQEBAQEBKwkBAgEBhD8Cgm8jN?=
 =?us-ascii?q?wYOAgwBAQEEAQEBAQEFAwEBbIUuDII6KQGCZwEFIwQRQRALDgoCAhEVAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfPwGBdhQPrDV/M4VMgzeBQwaBDCgBi3cYeIEHgTgMgl8+gmEEG?=
 =?us-ascii?q?IECgQSCTIJYBIxniQqWeYIsgi6EV411BhuZGY4JiAyTBiKBWCsIAhgIIQ+DJ?=
 =?us-ascii?q?4JOF4NPim8kAzABgQUBAY9uAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Sep 2019 14:43:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GEhmwf011002;
        Mon, 16 Sep 2019 10:43:48 -0400
Subject: Re: [PATCH] selinux: optimize MLS context to string conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Michal Sekletar <msekleta@redhat.com>
References: <20190730124852.7670-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2412f6e1-8f70-1ede-2776-79470083b912@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 10:43:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730124852.7670-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/30/19 8:48 AM, Ondrej Mosnacek wrote:
> When mls_compute_context_len() or mls_sid_to_context() encounters a
> context with large category ranges, it behaves suboptimally - it
> traverses each positive bit of the category bitmap, each time calling
> find_next_bit() again.
> 
> This has a large performance impact on UNIX datagram sockets with
> SO_PASSSEC set, since here the peer context needs to be converted to
> string for each recieved datagram. See [1] for more information.
> 
> This patch introduces a new helper for ebitmap traversal, which allows
> to efficiently iterate over positive ranges instead of bits -
> ebitmap_for_each_positive_range() - and converts the two mls_*()
> functions to leverage it.
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1733259
> 
> Reported-by: Michal Sekletar <msekleta@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/ss/ebitmap.h | 46 +++++++++++++++++++++
>   security/selinux/ss/mls.c     | 76 +++++++++++++----------------------
>   2 files changed, 73 insertions(+), 49 deletions(-)
> 
> diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
> index 6aa7cf6a2197..a415741cb206 100644
> --- a/security/selinux/ss/ebitmap.h
> +++ b/security/selinux/ss/ebitmap.h
> @@ -42,6 +42,10 @@ struct ebitmap {
>   	u32 highbit;	/* highest position in the total bitmap */
>   };
>   
> +struct ebitmap_range {
> +	unsigned int start, end;
> +};
> +
>   #define ebitmap_length(e) ((e)->highbit)
>   
>   static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
> @@ -80,6 +84,43 @@ static inline unsigned int ebitmap_next_positive(struct ebitmap *e,
>   	return ebitmap_length(e);
>   }
>   
> +static inline unsigned int ebitmap_next_negative(struct ebitmap *e,
> +						 struct ebitmap_node **n,
> +						 unsigned int bit)
> +{
> +	unsigned int ofs;
> +
> +	ofs = find_next_zero_bit((*n)->maps, EBITMAP_SIZE,
> +				 bit - (*n)->startbit + 1);
> +	if (ofs < EBITMAP_SIZE)
> +		return ofs + (*n)->startbit;
> +
> +	for (*n = (*n)->next; *n; *n = (*n)->next) {
> +		ofs = find_first_zero_bit((*n)->maps, EBITMAP_SIZE);
> +		if (ofs < EBITMAP_SIZE)
> +			return ofs + (*n)->startbit;
> +	}
> +	return ebitmap_length(e);
> +}

This is likely moot given that the patch was deferred on exploring the 
cache option, but if/when this patch is revisited, you don't seem to 
account for the possibility that there could be a hole between the 
bitmaps represented by (*n) and (*n)->next, and that might be where the 
next negative/zero bit is.

> +
> +static inline void ebitmap_start_positive_range(struct ebitmap *e,
> +						struct ebitmap_node **n,
> +						struct ebitmap_range *range)
> +{
> +	range->end = range->start = ebitmap_start_positive(e, n);
> +	if (range->start < ebitmap_length(e))
> +		range->end = ebitmap_next_negative(e, n, range->start);
> +}
> +
> +static inline void ebitmap_next_positive_range(struct ebitmap *e,
> +					       struct ebitmap_node **n,
> +					       struct ebitmap_range *range)
> +{
> +	range->end = range->start = ebitmap_next_positive(e, n, range->end);
> +	if (range->start < ebitmap_length(e))
> +		range->end = ebitmap_next_negative(e, n, range->start);
> +}
> +
>   #define EBITMAP_NODE_INDEX(node, bit)	\
>   	(((bit) - (node)->startbit) / EBITMAP_UNIT_SIZE)
>   #define EBITMAP_NODE_OFFSET(node, bit)	\
> @@ -122,6 +163,11 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
>   	     bit < ebitmap_length(e);			\
>   	     bit = ebitmap_next_positive(e, &n, bit))	\
>   
> +#define ebitmap_for_each_positive_range(e, n, range)		\
> +	for (ebitmap_start_positive_range(e, &n, &range);	\
> +	     range.start < ebitmap_length(e);			\
> +	     ebitmap_next_positive_range(e, &n, &range))	\
> +
>   int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
>   int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
>   int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32 last_e2bit);
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 5e05f5b902d7..3abd6b950c66 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -35,10 +35,12 @@
>    */
>   int mls_compute_context_len(struct policydb *p, struct context *context)
>   {
> -	int i, l, len, head, prev;
> +	int l, len;
>   	char *nm;
>   	struct ebitmap *e;
>   	struct ebitmap_node *node;
> +	struct ebitmap_range range;
> +	unsigned int rlen;
>   
>   	if (!p->mls_enabled)
>   		return 0;
> @@ -49,24 +51,14 @@ int mls_compute_context_len(struct policydb *p, struct context *context)
>   		len += strlen(sym_name(p, SYM_LEVELS, index_sens - 1));
>   
>   		/* categories */
> -		head = -2;
> -		prev = -2;
>   		e = &context->range.level[l].cat;
> -		ebitmap_for_each_positive_bit(e, node, i) {
> -			if (i - prev > 1) {
> -				/* one or more negative bits are skipped */
> -				if (head != prev) {
> -					nm = sym_name(p, SYM_CATS, prev);
> -					len += strlen(nm) + 1;
> -				}
> -				nm = sym_name(p, SYM_CATS, i);
> +		ebitmap_for_each_positive_range(e, node, range) {
> +			rlen = range.end - range.start;
> +			if (rlen > 1) {
> +				nm = sym_name(p, SYM_CATS, range.start);
>   				len += strlen(nm) + 1;
> -				head = i;
>   			}
> -			prev = i;
> -		}
> -		if (prev != head) {
> -			nm = sym_name(p, SYM_CATS, prev);
> +			nm = sym_name(p, SYM_CATS, range.end - 1);
>   			len += strlen(nm) + 1;
>   		}
>   		if (l == 0) {
> @@ -91,9 +83,11 @@ void mls_sid_to_context(struct policydb *p,
>   			char **scontext)
>   {
>   	char *scontextp, *nm;
> -	int i, l, head, prev;
> +	int l, first;
>   	struct ebitmap *e;
>   	struct ebitmap_node *node;
> +	struct ebitmap_range range;
> +	unsigned int rlen;
>   
>   	if (!p->mls_enabled)
>   		return;
> @@ -109,43 +103,27 @@ void mls_sid_to_context(struct policydb *p,
>   		scontextp += strlen(scontextp);
>   
>   		/* categories */
> -		head = -2;
> -		prev = -2;
> +		first = 1;
>   		e = &context->range.level[l].cat;
> -		ebitmap_for_each_positive_bit(e, node, i) {
> -			if (i - prev > 1) {
> -				/* one or more negative bits are skipped */
> -				if (prev != head) {
> -					if (prev - head > 1)
> -						*scontextp++ = '.';
> -					else
> -						*scontextp++ = ',';
> -					nm = sym_name(p, SYM_CATS, prev);
> -					strcpy(scontextp, nm);
> -					scontextp += strlen(nm);
> -				}
> -				if (prev < 0)
> -					*scontextp++ = ':';
> -				else
> -					*scontextp++ = ',';
> -				nm = sym_name(p, SYM_CATS, i);
> -				strcpy(scontextp, nm);
> -				scontextp += strlen(nm);
> -				head = i;
> -			}
> -			prev = i;
> -		}
> -
> -		if (prev != head) {
> -			if (prev - head > 1)
> -				*scontextp++ = '.';
> -			else
> +		ebitmap_for_each_positive_range(e, node, range) {
> +			if (first) {
> +				first = 0;
> +				*scontextp++ = ':';
> +			} else {
>   				*scontextp++ = ',';
> -			nm = sym_name(p, SYM_CATS, prev);
> +			}
> +			nm = sym_name(p, SYM_CATS, range.start);
>   			strcpy(scontextp, nm);
>   			scontextp += strlen(nm);
> -		}
> +			rlen = range.end - range.start;
> +			if (rlen > 1) {
> +				*scontextp++ = rlen > 2 ? '.' : ',';
>   
> +				nm = sym_name(p, SYM_CATS, range.end - 1);
> +				strcpy(scontextp, nm);
> +				scontextp += strlen(nm);
> +			}
> +		}
>   		if (l == 0) {
>   			if (mls_level_eq(&context->range.level[0],
>   					 &context->range.level[1]))
> 

