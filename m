Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5247DC433E1
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 18:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306F6204EA
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 18:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE/0Ovwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgESSKT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 14:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSKS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 14:10:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC2C08C5C0;
        Tue, 19 May 2020 11:10:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i14so446875qka.10;
        Tue, 19 May 2020 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iwpPJt2yMen3dAchpxwcGWHXokS5E7NEgrzxrlcQf0A=;
        b=LE/0OvwgoiDM/Oive5tQoDLGIRnxacncryO/pATHoLjnUjGAOqLPmP5OQOEY51kKs5
         g7PsAYSt/56Q2G8d9dcbQeYHoVTJWmmir+c474IxG/dLY5wAMQ8qFu/sCHEt5+K+RFBm
         bab8xFa8Wd014U843wb4QI9yqpbBgy63VuiVYuEDGC2obQ4FdQunK6cguzIh3LRwFsM/
         penA6cEzIlo4TlH1J3E1JgR3vWLYeNGv6htysp4m4vBMWtvZXHd/07OIpzFm+4LQ90SV
         tcK+ak6BjtFxezO2eh2Oa1I+ohBrbCZWsQKuHfcpHgriH1O0a6/RsCNhK3npaP6aF0pK
         MmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iwpPJt2yMen3dAchpxwcGWHXokS5E7NEgrzxrlcQf0A=;
        b=qvO4+Hb7V0++ZB3pFQ0D65A88A2QxapqctgOYipv39IeIjGshAlueGhog3Wus61jNC
         zbxdvkUGODVsXCtkeY6NGbmyVZ6plD6B1evxJ8WLAG3A0Hcd+UJXdVCcEdvog1T3sNck
         FW7KpQXeyxpPYUeU3Gqeb3GtNdxJbxoZ4f6wl1liuBVA13stJV70ZNyrfsX0r/9lbKS8
         tEQGbFl7lh7M5zXt/sCQaFGcXvIkICcCLY5RIjZKfZT+zfvEjd7JfaxH8Ba2lZE0LW71
         Unb18gQR5meCFWnnb66tMn3HvAFA6WHu5qLB0xxJCLuC/ojkNcvUC+jpHuCexI928mLZ
         Iopg==
X-Gm-Message-State: AOAM533MAl5xDUELOdjcyVb971duE2Cj88LV9lA0gEh/nUY4F0MjU7Tl
        5Yp3KBlgyWYuU5kdRzjBkik=
X-Google-Smtp-Source: ABdhPJzLYumTZTo5mjr9Ku5onVV55vuLLLIO03w35YZTTQjKxEO8buyxCwBzRdYjR+vORcMmnvSTcw==
X-Received: by 2002:a05:620a:747:: with SMTP id i7mr712123qki.346.1589911817366;
        Tue, 19 May 2020 11:10:17 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y140sm207197qkb.127.2020.05.19.11.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:10:16 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 01B2240AFD; Tue, 19 May 2020 15:10:13 -0300 (-03)
Date:   Tue, 19 May 2020 15:10:13 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <20200519181013.GA28228@kernel.org>
References: <0fffd9e2-1f22-a0c2-c2e3-cb7f4bb89d66@linux.intel.com>
 <819338ce-d160-4a2f-f1aa-d756a2e7c6fc@linux.intel.com>
 <20200518155843.GF24211@kernel.org>
 <d10fd4b0-d516-cf16-4379-c5299d0c5cc3@linux.intel.com>
 <74f8d079-39ef-756e-7e43-ba4c897fd441@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74f8d079-39ef-756e-7e43-ba4c897fd441@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Tue, May 19, 2020 at 10:34:18AM +0300, Alexey Budankov escreveu:
> 
> On 18.05.2020 19:43, Alexey Budankov wrote:
> > 
> > On 18.05.2020 18:58, Arnaldo Carvalho de Melo wrote:
> >> Em Thu, Apr 30, 2020 at 10:15:57AM +0300, Alexey Budankov escreveu:
> >>>
> >>> Implement selinux sysfs check to see the system is in enforcing
> >>> mode and print warning message with pointer to check audit logs.
> >>
> >> There were some changes in this area meanwhile, so I had to apply the
> >> evsel.c by hand, when I push this please double check everything is ok,
> > 
> > Will do. I appreciate your integrating effort.
> 
> Checked at tmp.perf/core branch. The message looks like this:
> 
> [root@nntvtune39 acme.tmp]# tools/perf/perf stat
> Error:
> Access to performance monitoring and observability operations is limited.
> Enforced MAC policy settings (SELinux) can limit access to performance
> monitoring and observability operations. Inspect system audit records for
> more perf_event access control information and adjusting the policy.
> Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> access to performance monitoring and observability operations for users
> without CAP_PERFMON or CAP_SYS_ADMIN Linux capability.
> perf_event_paranoid setting is 2:
>   -1: Allow use of (almost) all events by all users
>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >= 0: Disallow raw and ftrace function tracepoint access
> >= 1: Disallow CPU event access
> >= 2: Disallow kernel profiling
> To make the adjusted perf_event_paranoid setting permanent preserve it
> in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
> 
> Edited patch at security.txt didn't apply cleanly. It requires white space
> prior tab in the first block for wake_alarm etc till perfmon:

I see, I'll leave it there then so that it applies cleanly to those
policy files.
 
> ---8<---
> diff -Nura a/policy/flask/access_vectors b/policy/flask/access_vectors
> --- a/policy/flask/access_vectors	2020-02-04 18:19:53.000000000 +0300
> +++ b/policy/flask/access_vectors	2020-02-28 23:37:25.000000000 +0300
> @@ -174,6 +174,7 @@
>  	wake_alarm
>  	block_suspend
>  	audit_read
> +	perfmon
>  }
> 
>  #
> @@ -1099,3 +1100,15 @@
> 
>  class xdp_socket
>  inherits socket
> +
> +class perf_event
> +{
> +	open
> +	cpu
> +	kernel
> +	tracepoint
> +	read
> +	write
> +}
> +
> +
> diff -Nura a/policy/flask/security_classes b/policy/flask/security_classes
> --- a/policy/flask/security_classes	2020-02-04 18:19:53.000000000 +0300
> +++ b/policy/flask/security_classes	2020-02-28 21:35:17.000000000 +0300
> @@ -200,4 +200,6 @@
> 
>  class xdp_socket
> 
> +class perf_event
> +
>  # FLASK
> 
> ---8<---
> 
> ~Alexey

-- 

- Arnaldo
