Return-Path: <SRS0=BxL9=6H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D968C54FCB
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352272084D
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 13:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV6aRByS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgDWN1i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgDWN1i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Apr 2020 09:27:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BD1C08E934;
        Thu, 23 Apr 2020 06:27:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 20so6283845qkl.10;
        Thu, 23 Apr 2020 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PBO/huwjMgg9NnrGSfkA1Ck3Vxe5Dau0BkIUNgPRhxE=;
        b=LV6aRByS0/NKmV185YEDPXdiDtbivnTwqfmJouFe8IxgAJE+z4jQW2cfV+y5iiH9OO
         Tg4t3sMjHFfneJ2+7pZSoA9Lfz8FgrA98+sO2Ei1ZhFnfVGxYnh/m+Pcp/m+bR+nlgDi
         TU62x0veRql012jdd9qvVV1NjNu1FZc1Nc+KLIYOxkOrOIq57mRltosgIK0f/uylmuI6
         3K6wDcig7lcqqG+jQdnmWS2Fs/rXtooUuJS8CKwp5prgDB0sI8VJz4QnZBiCoXhBCSoD
         INRByZxsFz6ZkXfVcqWtVuBU0WqW6nJaiLDCCrF4nzCEcceT3oMD5+fZgF6Z5JC4mQmp
         X02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PBO/huwjMgg9NnrGSfkA1Ck3Vxe5Dau0BkIUNgPRhxE=;
        b=AGO7jV2uMghcZvJzsLKYNZy6Y9+V74lxtPSKfoWf6ri/djC8gU7d97SpjLgPlVmL8H
         srohSxdRTdiD+PyZii+ljQBF3d/L8Ghy/2IneXwi1p1JH040R47I8mAVYmCLVXuWfNqr
         qePknMyooAm+3zCByHHSM6l4yo/6T5oLPJ78N9WUZlojPaFRrNSEA32p3pAY7AnHaEdW
         wkhMaiY7bkB45gi3UtdChknjlZnyv0cwnWlLyRPDOJHi6OrfhnDYoRafUEv6xFXpQUE8
         6Qw9N/DCZLMZUCJbSAQh7eYHdV5YgdC9SkzF7gUvdqQ0+jGMjnLeW2A4lARUE8/G+iYv
         T+Ew==
X-Gm-Message-State: AGi0PuaDAb8jAwwPG+A5A1W58FsHZRBN0+MbnYME5pefp/4HdcWvxhrz
        VqmAadGQ4H8PK2qolytqiPUGjLTWBoI=
X-Google-Smtp-Source: APiQypJn93NmNkcmfJ+58vnwklwfEHHiRtLig5NvBMRtXxVXK3rVk8GVLq4gz/4gx8gQi9EwKfmEEw==
X-Received: by 2002:a37:67c4:: with SMTP id b187mr3712421qkc.296.1587648456625;
        Thu, 23 Apr 2020 06:27:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h23sm1505818qkk.90.2020.04.23.06.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 06:27:35 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F48C409A3; Thu, 23 Apr 2020 10:27:33 -0300 (-03)
Date:   Thu, 23 Apr 2020 10:27:33 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] perf tool: make Perf tool aware of SELinux access
 control
Message-ID: <20200423132733.GC19437@kernel.org>
References: <66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com>
 <7459371d-2ec8-4700-13b6-09b73998cc7c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7459371d-2ec8-4700-13b6-09b73998cc7c@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Wed, Apr 22, 2020 at 05:45:34PM +0300, Alexey Budankov escreveu:
> 
> Implement SELinux sysfs check to see if the system is in enforcing
> mode and print warning message with pointers to check audit logs.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/cloexec.c |  4 ++--
>  tools/perf/util/evsel.c   | 40 +++++++++++++++++++++++----------------
>  2 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
> index a12872f2856a..9c8ec816261b 100644
> --- a/tools/perf/util/cloexec.c
> +++ b/tools/perf/util/cloexec.c
> @@ -65,7 +65,7 @@ static int perf_flag_probe(void)
>  		return 1;
>  	}
>  
> -	WARN_ONCE(err != EINVAL && err != EBUSY,
> +	WARN_ONCE(err != EINVAL && err != EBUSY && err != EACCES,
>  		  "perf_event_open(..., PERF_FLAG_FD_CLOEXEC) failed with unexpected error %d (%s)\n",
>  		  err, str_error_r(err, sbuf, sizeof(sbuf)));
>  
> @@ -83,7 +83,7 @@ static int perf_flag_probe(void)
>  	if (fd >= 0)
>  		close(fd);
>  
> -	if (WARN_ONCE(fd < 0 && err != EBUSY,
> +	if (WARN_ONCE(fd < 0 && err != EBUSY && err != EACCES,
>  		      "perf_event_open(..., 0) failed unexpectedly with error %d (%s)\n",
>  		      err, str_error_r(err, sbuf, sizeof(sbuf))))
>  		return -1;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 9fa92649adb4..82492ca12405 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2514,32 +2514,40 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			      int err, char *msg, size_t size)
>  {
>  	char sbuf[STRERR_BUFSIZE];
> -	int printed = 0;
> +	int printed = 0, enforced = 0;
>  
>  	switch (err) {
>  	case EPERM:
>  	case EACCES:
> +		printed += scnprintf(msg + printed, size - printed,
> +			"Access to performance monitoring and observability operations is limited.\n");
> +
> +		if (!sysfs__read_int("fs/selinux/enforce", &enforced)) {
> +			if (enforced) {
> +				printed += scnprintf(msg + printed, size - printed,
> +					"Enforced MAC policy settings (SELinux) can limit access to performance\n"
> +					"monitoring and observability operations. Inspect system audit records for\n"
> +					"more perf_event access control information and adjusting the policy.\n");
> +			}
> +		}
> +
>  		if (err == EPERM)
> -			printed = scnprintf(msg, size,
> -				"No permission to enable %s event.\n\n",
> +			printed += scnprintf(msg, size,
> +				"No permission to enable %s event.\n",
>  				perf_evsel__name(evsel));

This removal of a newline doesn't seem necessary to this patch.
  
>  		return scnprintf(msg + printed, size - printed,
> -		 "You may not have permission to collect %sstats.\n\n"
> -		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
> -		 "which controls use of the performance events system by\n"
> -		 "unprivileged users (without CAP_PERFMON or CAP_SYS_ADMIN).\n\n"
> -		 "The current value is %d:\n\n"
> +		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
> +		 "access to performance monitoring and observability operations for users\n"
> +		 "without CAP_PERFMON capability. perf_event_paranoid setting is %d:\n"

Here we need as well to check if the kernel/libcap supports CAP_PERFMON
to provide a better error message.

>  		 "  -1: Allow use of (almost) all events by all users\n"
>  		 "      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK\n"
> -		 ">= 0: Disallow ftrace function tracepoint by users without CAP_PERFMON or CAP_SYS_ADMIN\n"
> -		 "      Disallow raw tracepoint access by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN\n"
> -		 ">= 1: Disallow CPU event access by users without CAP_PERFMON or CAP_SYS_ADMIN\n"
> -		 ">= 2: Disallow kernel profiling by users without CAP_PERFMON or CAP_SYS_ADMIN\n\n"
> -		 "To make this setting permanent, edit /etc/sysctl.conf too, e.g.:\n\n"
> -		 "	kernel.perf_event_paranoid = -1\n" ,
> -				 target->system_wide ? "system-wide " : "",
> -				 perf_event_paranoid());
> +		 ">= 0: Disallow raw and ftrace function tracepoint access\n"
> +		 ">= 1: Disallow CPU event access\n"
> +		 ">= 2: Disallow kernel profiling\n"
> +		 "To make the adjusted perf_event_paranoid setting permanent preserve it\n"
> +		 "in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)",
> +		 perf_event_paranoid());
>  	case ENOENT:
>  		return scnprintf(msg, size, "The %s event is not supported.",
>  				 perf_evsel__name(evsel));
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
