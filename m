Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC71FC6FD1F
	for <selinux@archiver.kernel.org>; Wed, 22 Mar 2023 04:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCVEZZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Mar 2023 00:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjCVEZY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Mar 2023 00:25:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA4725965
        for <selinux@vger.kernel.org>; Tue, 21 Mar 2023 21:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1D55CE1C0A
        for <selinux@vger.kernel.org>; Wed, 22 Mar 2023 04:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FE1C433D2;
        Wed, 22 Mar 2023 04:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679459120;
        bh=R2rIi4BZVPPKaS2kqZhytBuDqxKBEYNx/TOXpheShA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CeI+8nH5y1iBSd3cHCKVNsS6QxrSgisgTaOk3CWOnII+r3Idi0jC6BHsjV6fsWQVn
         TzXejeL8IF9ZuCqgQtPnQ2XlHOL3zqIntUJM2JVQK7NkAUKlTVcIO7pAd68ehnXU5L
         /zfO68eAvpF+zs+ZHse0R9Fs6pgg+rZJW8ERU1hcli6+IqEqVGB7mj8FY+R57c1Ht6
         gsEO3JgueZve0QJ2RneSk6YlzYG2K/2qvS6O8vuMQ2CkFau3B+yuwlx+mlERSCdU/l
         SfRAlYc/90NMzlFuCxNsudt407LefHKQO0vswnt2LkjxqkJMfk1gJ77+1PyArgQdDb
         NpWG1yDPbe4Ug==
Date:   Tue, 21 Mar 2023 21:25:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 2/3] libselinux: improve performance with pcre matches
Message-ID: <20230322042518.GA34052@sol.localdomain>
References: <20230121180318.11853-1-carenas@gmail.com>
 <20230123014047.84911-1-carenas@gmail.com>
 <20230123014047.84911-3-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123014047.84911-3-carenas@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Carlo,

On Mon, Jan 23, 2023 at 01:40:46AM +0000, Carlo Marcelo Arenas Belón wrote:
> Since 30b3e9d2 (libselinux: Workaround for heap overhead of pcre,
> 2023-01-12), performance of PCRE2 matches has been affected due to
> excesive recreation of the match_data in an attempt to reduce memory
> utilization; instead of a workaround, it would be better to address
> the problem and maybe even improve performance in the process.
> 
> The issue is that currently the structure that holds PCRE state has
> both a pcre2_code (which is per pattern) and a pcre2_match_data (which
> is per match), forcing us to add a mutex to prevent multiple matches to
> step on each other.
> 
> Lets remove the match_data and the mutex and instead allocate one once
> in a thread independent way that could be used and reused, by extending
> our pthread interface to not only store TLS variables but also retrieve
> them, and then use one of those.
> 
> Since we are not interested on the capture groups (if any) lets only
> allocate 1 pair which is all that will be needed and change the logic
> so that a return of 0 (which means the pattern matched but there were
> not enough capture spots) is also considered a match.
> 
> This will ensure that the memory use would be bound to the number of
> concurrent matches instead of the number of patterns and therefore
> reduce the impact that recent changes on the way that the frames used
> for matching are allocated might had brough since 10.41 was released.
> 
> For cases where threads are not available, just keep it working in slow
> mode as done before the workaround was reverted.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  libselinux/src/regex.c            | 108 +++++++++++++++++-------------
>  libselinux/src/selinux_internal.h |   4 ++
>  2 files changed, 64 insertions(+), 48 deletions(-)
> 

Thanks for writing this patch!  I notice it hasn't been applied upstream.  Is
this still being worked on?

A couple comments below:

> +static void __attribute__((destructor)) match_data_thread_free(void *key)
> +{
> +	void *value;
> +	pcre2_match_data *match_data;
> +
> +	if (match_data_key_initialized <= 0 || !match_data_initialized)
> +		return;
> +
> +	value = __selinux_getspecific(match_data_key);
> +	match_data = value ? value : key;
> +
> +	pcre2_match_data_free(match_data);
> +
> +	__pthread_mutex_lock(&key_mutex);
> +	if (--match_data_key_initialized == 1) {
> +		__selinux_key_delete(match_data_key);
> +		match_data_key_initialized = -1;
> +	}
> +	__pthread_mutex_unlock(&key_mutex);
> +}

This function is used as a pthread_key destructor.  But, it's also marked with
__attribute__((destructor)), making it a library-level destructor too.  That's
confusing.  Is there a reason for that?  I would have expected these to be two
different functions.  The pthread_key destructor should call
pcre2_match_data_free on the value passed as an argument, while the
library-level destructor should delete match_data_key.

>  int regex_match(struct regex_data *regex, char const *subject, int partial)
>  {
>  	int rc;
> -	pcre2_match_data *match_data;
> -	__pthread_mutex_lock(&regex->match_mutex);
> +	bool slow;
> +	pcre2_match_data *match_data = NULL;
> +
> +	if (match_data_key_initialized > 0) {
> +		if (match_data_initialized == 0) {
> +			match_data = pcre2_match_data_create(1, NULL);
> +			if (match_data) {
> +				match_data_initialized = 1;
> +				__selinux_setspecific(match_data_key,
> +							match_data);
> +				__pthread_mutex_lock(&key_mutex);
> +				match_data_key_initialized++;
> +				__pthread_mutex_unlock(&key_mutex);
> +			}
> +		} else
> +			match_data = __selinux_getspecific(match_data_key);
> +	}

Since match_data_key_initialized is checked without holding key_mutex, can't the
above code race with the below code in match_data_thread_free?

        __pthread_mutex_lock(&key_mutex);
        if (--match_data_key_initialized == 1) {
                __selinux_key_delete(match_data_key);
                match_data_key_initialized = -1;
        }
        __pthread_mutex_unlock(&key_mutex);

Perhaps deleting the pthread_key is just not something that should be done at
all?

- Eric
