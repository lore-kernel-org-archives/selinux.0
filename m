Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89773C04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480722175B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 14:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MV5QBCZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfEJORq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 10:17:46 -0400
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:26711 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfEJORp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 10:17:45 -0400
X-EEMSG-check-017: 223723043|UPBD19PA10_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 May 2019 14:17:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1557497859; x=1589033859;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=zUVnUeGOa5ynaUtNvBAE90GQ3Un5hsuwEjYvPpDuRnk=;
  b=MV5QBCZDrnPjiF71qhOWrBjfiWQT0wRTHINqNQLeSbwD4fVO3fWw7458
   1DMmBXP8bL2pbdC0quhgTsfrouJbFq0FWYFr6/7KHoZvfZdMp4fDlbj8e
   A+N6jvbthkJnI4eUjNj98XKbnHj/g4ajULjv7rnnSdyHTXi6OAOVSbIJm
   OG2bBquXLGuwDVqHLxejVVQvWyEmDsoIs0tDS7pPzk5TOg362PhHNMaIv
   j1cl5slW+mJeJCqZZAC077fU+pMESFA8pBc8tCgZIpdGXrEnT2sGbpcCk
   +ACD+xyqTnRU15F6+S1VqPVUmYc2K8rTp2nm2rJ+t6k6yvoVIOjF+1tvS
   g==;
X-IronPort-AV: E=Sophos;i="5.60,453,1549929600"; 
   d="scan'208";a="27384991"
IronPort-PHdr: =?us-ascii?q?9a23=3AwbmN0xLDDvwoyPFcRtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXK/n5rarrMEGX3/hxlliBBdydt6sdzbqG+P+9EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCegbb9oLxi7rgrdu8sWjIB/Nqs/1x?=
 =?us-ascii?q?zFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0QrNEAjsoNW?=
 =?us-ascii?q?A1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVT?=
 =?us-ascii?q?i+6apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSG?=
 =?us-ascii?q?xPUcZLUyxKH52yYY0BAeEcOepUtofwql8LoRa4GAKiBv7gyiVQi3Hrw6M63e?=
 =?us-ascii?q?QvHwLI0gMuEN0BsmjbotruOacOU+241rXEwSnNYv5U3zr29YjGcgomofGJRb?=
 =?us-ascii?q?9+bNbRxlc3FwPFkFqQr5HuMS6Q1usXt2ib6/RvVOKygGMgsAF+vyOvy9wwio?=
 =?us-ascii?q?jJmo0VylfE+T9/wIYuP9K0UkF7Ydm6EJZJsSyRKoV4QsQnQ25yuSY6zKULto?=
 =?us-ascii?q?W8fCgN1JQnwx/fa/qdf4eU5RLjUf6dITh5hHJ5eLK/mg29/VK8xe37U8m51k?=
 =?us-ascii?q?tBoCldktTUq3wA2BPe5tKHR/dg5EutxzmC2x7J5u1ZJ00/iLDVJIQ7wrEqk5?=
 =?us-ascii?q?oeqUHDHijrl0rolKKWbUAk+vSw6+Tgf7XmuoeQN49qhQH6NaQjgtC/Dv4iMg?=
 =?us-ascii?q?gPQmib4v6w1KHj/ELlQLVKiec6kq/Fv5DBOcsXvKu5Aw5R0oo76ha/CSmp0M?=
 =?us-ascii?q?gAkHUaI19IdwiLgoj0N13UPvz1Aumzj06xnDtzwvDJJLzhApHDLnjZl7fheK?=
 =?us-ascii?q?5w61VBxwoo1t1f+5JVBa0BIPL0QEPxssfYAQUjPwy7xObnFs1x1pkCVmKXHq?=
 =?us-ascii?q?+ZLKTSvEeQ5uIrOeaMeZMVuCzmJPc//PPul2E2lkIdfaazwZsbcmy3HvNjI0?=
 =?us-ascii?q?+Be3rjns8BEXsWvgo5VOHqk0ONUTpSZ3a0QqI96So2CJypDYjdXIChmr+B0z?=
 =?us-ascii?q?mhHp1QeG9GDkqAEXDyd4WLQ/0Mcj6dItd9kjwYUrisU5Qu1RCqtA/+0bZoMv?=
 =?us-ascii?q?DY+jcftZ34ytd1/fHTlQop+Dx7CsSSyWCNT2VukmwUQD822bh1oVZhxVebza?=
 =?us-ascii?q?h4n/tYGMRL5/xXSQg1K5jcz+1mC9D1QQ/Bf8mGR0i4Tdm8BjExVN0xkJcyZB?=
 =?us-ascii?q?NFFsm4xjTKwjawCbYel/TfHJg9777G1XHZPctxy3/akqImig9iCtBCMWygm7?=
 =?us-ascii?q?5X6QfeHcjKnl+fmqLscr4TmGby9WOHzGOL9HtfWgNqTb6NCXoeYk+QppLj4U?=
 =?us-ascii?q?nPVaO1IbsiOwpFj8WFL/0OIpfCjU9HX+vkINTTeSqT3S+ICDyFwLKQa8CiL3?=
 =?us-ascii?q?0Q1ijbCVQDuwEe8HvAMhIxUHSPuWXbWQdyGErvbkWkyux3rHe2Xwdg1A2RR1?=
 =?us-ascii?q?Fw3LqyvBgOjLqTTO1FjeFMgzsotzghRAX15NnREdfV4lM6Lag=3D?=
X-IPAS-Result: =?us-ascii?q?A2BRAAAwh9Vc/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?WYqaVIyKIQRiByKdUwBAQEBAQEGgQgIJYlNiW6FGIF7CQEBAQEBAQEBAS0HA?=
 =?us-ascii?q?QIBAYN6RgKCCyM0CQ4BAwEBAQQBAQEBAwEBbBwMgjopAYJnAQUjBBFRCw4KA?=
 =?us-ascii?q?gImAgJXBgEMBgIBAYJfPwGBdhQPrSF8M4VHgyGBQAaBCycBi04XeIEHgREnD?=
 =?us-ascii?q?IJfPoJhAgKEaYJYBIseL4dOlDUJgguCB4QYhDiHfAYblWktjASGVJAmOIFXK?=
 =?us-ascii?q?wgCGAghDzuCbIIbF4NMim8jAzABC3oBAY9YAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 May 2019 14:17:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4AEHSO7001132;
        Fri, 10 May 2019 10:17:29 -0400
Subject: Re: [PATCH] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org,
        William Roberts <bill.c.roberts@gmail.com>,
        "Christopher J. PeBenito" <pebenito@ieee.org>
References: <20190509084204.26198-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <43a3624a-2217-f504-0195-13e4423c7b63@tycho.nsa.gov>
Date:   Fri, 10 May 2019 10:11:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509084204.26198-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/9/19 4:42 AM, Petr Lautrbach wrote:
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
>   libselinux/src/get_context_list.c | 185 ++++++++++--------------------
>   1 file changed, 60 insertions(+), 125 deletions(-)
> 
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
> index 689e4658..a36c6253 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -114,61 +114,24 @@ int get_default_context(const char *user,
>   	return 0;
>   }
>   
> -static int find_partialcon(char ** list,
> -			   unsigned int nreach, char *part)
> -{
> -	const char *conrole, *contype;
> -	char *partrole, *parttype, *ptr;
> -	context_t con;
> -	unsigned int i;
> -
> -	partrole = part;
> -	ptr = part;
> -	while (*ptr && !isspace(*ptr) && *ptr != ':')
> -		ptr++;
> -	if (*ptr != ':')
> -		return -1;
> -	*ptr++ = 0;
> -	parttype = ptr;
> -	while (*ptr && !isspace(*ptr) && *ptr != ':')
> -		ptr++;
> -	*ptr = 0;
> -
> -	for (i = 0; i < nreach; i++) {
> -		con = context_new(list[i]);
> -		if (!con)
> -			return -1;
> -		conrole = context_role_get(con);
> -		contype = context_type_get(con);
> -		if (!conrole || !contype) {
> -			context_free(con);
> -			return -1;
> -		}
> -		if (!strcmp(conrole, partrole) && !strcmp(contype, parttype)) {
> -			context_free(con);
> -			return i;
> -		}
> -		context_free(con);
> -	}
> -
> -	return -1;
> -}
> -
> -static int get_context_order(FILE * fp,
> +static int get_context_user(FILE * fp,
>   			     char * fromcon,
> -			     char ** reachable,
> -			     unsigned int nreach,
> -			     unsigned int *ordering, unsigned int *nordered)
> +			     const char * user,
> +			     char ***reachable,
> +			     unsigned int *nreachable)
>   {
>   	char *start, *end = NULL;
>   	char *line = NULL;
>   	size_t line_len = 0;
> -	ssize_t len;
> +	ssize_t len, ulen;
>   	int found = 0;
> -	const char *fromrole, *fromtype;
> +	const char *fromrole, *fromtype, *fromlevel;
>   	char *linerole, *linetype;
> -	unsigned int i;
> +	char **new_reachable = NULL;
> +	char *usercon_str;
>   	context_t con;
> +	context_t usercon;
> +
>   	int rc;
>   
>   	errno = -EINVAL;
> @@ -180,7 +143,8 @@ static int get_context_order(FILE * fp,
>   		return -1;
>   	fromrole = context_role_get(con);
>   	fromtype = context_type_get(con);
> -	if (!fromrole || !fromtype) {
> +	fromlevel = context_range_get(con);
> +	if (!fromrole || !fromtype || !fromlevel) {
>   		context_free(con);
>   		return -1;
>   	}
> @@ -243,23 +207,52 @@ static int get_context_order(FILE * fp,
>   		if (*end)
>   			*end++ = 0;
>   
> -		/* Check for a match in the reachable list. */
> -		rc = find_partialcon(reachable, nreach, start);
> -		if (rc < 0) {
> -			/* No match, skip it. */
> -			start = end;
> -			continue;
> +		/* Check whether a new context is valid */
> +	        ulen = strlen(user) + strlen(start) + 1;
> +		usercon_str = malloc(ulen);
> +		if (!usercon_str) {
> +			rc = -1;
> +			goto out;
>   		}
>   
> -		/* If a match is found and the entry is not already ordered
> -		   (e.g. due to prior match in prior config file), then set
> -		   the ordering for it. */
> -		i = rc;
> -		if (ordering[i] == nreach)
> -			ordering[i] = (*nordered)++;
> +		/* set range from fromcon in the new usercon */
> +		snprintf(usercon_str, ulen - 1, "%s:%s", user, start);
> +		if (!(usercon = context_new(usercon_str))) {
> +			fprintf(stderr,
> +				"%s: can't create a context from %s\n",
> +				__FUNCTION__, usercon_str);
> +			free(usercon_str);
> +
> +			continue;
> +		}
> +		free(usercon_str);
> +		context_range_set(usercon, fromlevel);

I think the main potential stumbling block here is the MLS range 
component. The kernel policy defines the default level and allowed range 
for the (SELinux) user, and uses this information in the kernel function 
mls_setup_user_range(), 
https://elixir.bootlin.com/linux/latest/source/security/selinux/ss/mls.c#L402, 
to determine the most suitable MLS range for the user session, based on 
both the from-context and the user default and range from the kernel 
policy.  Just using the level from the from-context could fail if the 
user isn't authorized to operate at that level, and even if the user is 
authorized to operate at that level, it could introduce a change in the 
default behavior if the user's default level differs. I think when we 
have discussed this in the past on the list, we were going to either 
export the user's default level and range information from the kernel 
via selinuxfs and replicate the mls_setup_user_ranges() logic in 
userspace, or have it automatically extracted from the kernel policy 
during policy build into a userspace configuration file that could be 
used directly by userspace.  Or something like that.  This gets a bit 
tricky though in that the logic involves comparing MLS levels, which is 
intrinsically policy-specific logic, and thus if we wanted to truly 
replicate it in userspace, we'd probably need to use libsepol.  Ugh. 
Maybe the kernel could just provide a simple selinuxfs interface for 
computing the result of mls_setup_user_range() and return that piece.

That said, I don't know to what extent anyone is relying on this logic 
and to what extent it is obsoleted by the use of the level/range from 
seusers.  It looks like today we are replacing the level/range in the 
original from-context with the one from seusers before calling this 
code, in which case the fromlevel is in fact the one we ultimately want 
to use.  So perhaps this doesn't matter and we can just go with your 
approach.

> +		usercon_str = context_str(usercon);
> +
> +		if (security_check_context(usercon_str) == 0) {
> +			if (*nreachable == 0) {
> +				new_reachable = malloc(2 * sizeof(char *));
> +				if (!new_reachable) {
> +					context_free(usercon);
> +					rc = -1;
> +					goto out;
> +				}
> +			} else {
> +				new_reachable = realloc(*reachable, (*nreachable + 2) * sizeof(char *));
> +				if (!new_reachable) {
> +					context_free(usercon);
> +					rc = -1;
> +					goto out;
> +				}
> +			}
> +			new_reachable[*nreachable] = strdup(usercon_str);
> +			new_reachable[*nreachable + 1] = 0;
> +			*reachable = new_reachable;
> +			*nreachable += 1;
> +		}
> +		context_free(usercon);
>   		start = end;
>   	}
> -
>   	rc = 0;
>   
>         out:
> @@ -313,21 +306,6 @@ static int get_failsafe_context(const char *user, char ** newcon)
>   	return 0;
>   }
>   
> -struct context_order {
> -	char * con;
> -	unsigned int order;
> -};
> -
> -static int order_compare(const void *A, const void *B)
> -{
> -	const struct context_order *c1 = A, *c2 = B;
> -	if (c1->order < c2->order)
> -		return -1;
> -	else if (c1->order > c2->order)
> -		return 1;
> -	return strcmp(c1->con, c2->con);
> -}
> -
>   int get_ordered_context_list_with_level(const char *user,
>   					const char *level,
>   					char * fromcon,
> @@ -395,11 +373,8 @@ int get_ordered_context_list(const char *user,
>   			     char *** list)
>   {
>   	char **reachable = NULL;
> -	unsigned int *ordering = NULL;
> -	struct context_order *co = NULL;
> -	char **ptr;
>   	int rc = 0;
> -	unsigned int nreach = 0, nordered = 0, freefrom = 0, i;
> +	unsigned nreachable = 0, freefrom = 0;
>   	FILE *fp;
>   	char *fname = NULL;
>   	size_t fname_len;
> @@ -413,23 +388,6 @@ int get_ordered_context_list(const char *user,
>   		freefrom = 1;
>   	}
>   
> -	/* Determine the set of reachable contexts for the user. */
> -	rc = security_compute_user(fromcon, user, &reachable);
> -	if (rc < 0)
> -		goto failsafe;
> -	nreach = 0;
> -	for (ptr = reachable; *ptr; ptr++)
> -		nreach++;
> -	if (!nreach)
> -		goto failsafe;
> -
> -	/* Initialize ordering array. */
> -	ordering = malloc(nreach * sizeof(unsigned int));
> -	if (!ordering)
> -		goto failsafe;
> -	for (i = 0; i < nreach; i++)
> -		ordering[i] = nreach;
> -
>   	/* Determine the ordering to apply from the optional per-user config
>   	   and from the global config. */
>   	fname_len = strlen(user_contexts_path) + strlen(user) + 2;
> @@ -440,8 +398,8 @@ int get_ordered_context_list(const char *user,
>   	fp = fopen(fname, "re");
>   	if (fp) {
>   		__fsetlocking(fp, FSETLOCKING_BYCALLER);
> -		rc = get_context_order(fp, fromcon, reachable, nreach, ordering,
> -				       &nordered);
> +		rc = get_context_user(fp, fromcon, user, &reachable, &nreachable);
> +
>   		fclose(fp);
>   		if (rc < 0 && errno != ENOENT) {
>   			fprintf(stderr,
> @@ -454,8 +412,7 @@ int get_ordered_context_list(const char *user,
>   	fp = fopen(selinux_default_context_path(), "re");
>   	if (fp) {
>   		__fsetlocking(fp, FSETLOCKING_BYCALLER);
> -		rc = get_context_order(fp, fromcon, reachable, nreach, ordering,
> -				       &nordered);
> +		rc = get_context_user(fp, fromcon, user, &reachable, &nreachable);
>   		fclose(fp);
>   		if (rc < 0 && errno != ENOENT) {
>   			fprintf(stderr,
> @@ -463,40 +420,18 @@ int get_ordered_context_list(const char *user,
>   				__FUNCTION__, selinux_default_context_path());
>   			/* Fall through */
>   		}
> -		rc = 0;
> +		rc = nreachable;
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

