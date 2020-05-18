Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A49FC433E0
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 15:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445FD20758
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 15:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVRvxKl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgERP6t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgERP6t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 11:58:49 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07368C061A0C;
        Mon, 18 May 2020 08:58:48 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p4so4926887qvr.10;
        Mon, 18 May 2020 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OGseh1WmE4yHPQBjGT/4Noc+y/RejACL6yehkzUajtg=;
        b=cVRvxKl+ZBJMZc5eSA8ibKdLoeH8350FaVNIyvsv2hnrlXuMpdqED+Lj0M1bTofkaD
         reU17UtaaYtRBCZc+cPvXApZgPYv+C4za2YrSX9RpEfIIIphZySKZyZ62ehs+Bcw4sq0
         wgwOoLKGvNSLEVTxHOLRFTO2oQWoQAsz3l+g7IotCaFtYDb2KCFKbLfutaF2LT9XSMM6
         fCZpM2FvgdUuFbnlgEY2ih81dDcDuj87/FfbBbSP/qwHvDzZklTXtnQzAv55+fId4xF+
         ivsCGhUxxFRcgg1BStRSt+DxMlLH9ki8wfCAN1xqZmxqmNY1ZIh23ygmfOWncPvT1l39
         fKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OGseh1WmE4yHPQBjGT/4Noc+y/RejACL6yehkzUajtg=;
        b=eOfcfpq89KvFKBD55miXWZBxCP5c8Rn8GAZbgC27uaUU4FeJe/saQU835Csb+dCY6a
         BFmc+4WCA+jKPDXOhrbfKHGuvCnl95Wk1UshcjAjfZelJMcn+M9pCrVULvf5CZvux8Tg
         3PPUnAp7ijTiRrq1blKK6vi8HRuC1LL83KVJwizYrNi3zQomfmrPWg4DfFOcTXw42mcK
         qe01G5vfngfxxZIO4Eza5p7yI7DAZAxSghji8akB99qyciA4gUglkQi56c5O69x4CSpc
         Qcdh7Gah7U/vcJprcN491h7W/f0zHxvMdk941OyzsrK61jr+VJzipBOEcPJFmGm81Qlu
         oreg==
X-Gm-Message-State: AOAM532zqH1L2g6AZQFFecYBB6COVfPqgl2mJeyrNVRCZRnvd3x4HYH1
        sNmmmbmxLzi5mNsSJvqz2dw=
X-Google-Smtp-Source: ABdhPJzgKX5VdmBlBGPoyWSjnBf6ARFVrtEtHrfZU5TIU1eCvV0O5wfe/AkkaRnxkfVhozLrUDxOZA==
X-Received: by 2002:ad4:588b:: with SMTP id dz11mr16163461qvb.226.1589817527046;
        Mon, 18 May 2020 08:58:47 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o16sm8761611qko.38.2020.05.18.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:58:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B1FD440AFD; Mon, 18 May 2020 12:58:43 -0300 (-03)
Date:   Mon, 18 May 2020 12:58:43 -0300
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
Subject: Re: [PATCH v3 2/3] perf tool: make Perf tool aware of SELinux access
 control
Message-ID: <20200518155843.GF24211@kernel.org>
References: <0fffd9e2-1f22-a0c2-c2e3-cb7f4bb89d66@linux.intel.com>
 <819338ce-d160-4a2f-f1aa-d756a2e7c6fc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <819338ce-d160-4a2f-f1aa-d756a2e7c6fc@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Thu, Apr 30, 2020 at 10:15:57AM +0300, Alexey Budankov escreveu:
> 
> Implement selinux sysfs check to see the system is in enforcing
> mode and print warning message with pointer to check audit logs.

There were some changes in this area meanwhile, so I had to apply the
evsel.c by hand, when I push this please double check everything is ok,

- Arnaldo
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/cloexec.c |  4 ++--
>  tools/perf/util/evsel.c   | 39 ++++++++++++++++++++++++---------------
>  2 files changed, 26 insertions(+), 17 deletions(-)
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
> index 9fa92649adb4..bf437c059c2b 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2514,32 +2514,41 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
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
> +			printed += scnprintf(msg, size,
>  				"No permission to enable %s event.\n\n",
>  				perf_evsel__name(evsel));
>  
>  		return scnprintf(msg + printed, size - printed,
> -		 "You may not have permission to collect %sstats.\n\n"
> -		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
> -		 "which controls use of the performance events system by\n"
> -		 "unprivileged users (without CAP_PERFMON or CAP_SYS_ADMIN).\n\n"
> -		 "The current value is %d:\n\n"
> +		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
> +		 "access to performance monitoring and observability operations for users\n"
> +		 "without CAP_PERFMON or CAP_SYS_ADMIN Linux capability.\n"
> +		 "perf_event_paranoid setting is %d:\n"
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
