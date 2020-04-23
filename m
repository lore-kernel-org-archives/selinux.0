Return-Path: <SRS0=BxL9=6H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1425C54FCB
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 13:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC26E20781
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 13:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAZi2qsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgDWNVB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726753AbgDWNVA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Apr 2020 09:21:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD5EC08E934;
        Thu, 23 Apr 2020 06:21:00 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g74so6236351qke.13;
        Thu, 23 Apr 2020 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9jDk9uM72kgS9oe9Qc0OBhy8P+XuVro261CKYodI12Y=;
        b=hAZi2qsvxi3D9D5L2q0lMwkYhurG5da4gJ1QOn0YbYqSio7OT8o5b2okqoaCdtRxSR
         W2NKt4qwnQmmdtRht/T98LvgT6eZqDFyu4E/lG5i/ppaTPPpHRSODueIqbG1tbLoZU+o
         vmjCn6coOrnsJXBDlE3+QZJHJDrPQ7kWo3AY63e0Iyf9SAU/L6v8lmm/nBTMbOJygRcv
         k2nXcUoYIJNcRHkOt4e9KayLNapNU9Mh1VciCbQnhtl42lgwab2038oCuBeDV7HftV5m
         NJt4N4/g2/k1BqKflXCqReHHsg8zIpbwudW6vQzWhNFFGywHwfiIhX8CJG6fb4dmKTIZ
         yEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9jDk9uM72kgS9oe9Qc0OBhy8P+XuVro261CKYodI12Y=;
        b=ZrdROy/3lEYssZZLKJNN0diRY8HOjIlbAbfb8573nvr/Sa0kiRIxUQaWGuelA/c6WO
         s9a8PrhRQtmu/WfV0NIxD+wAslzjsF7tsmjhSTZ+cPvj0C7Haa/xmAnFAVodxTs4Vu9r
         qT3gDHeR+ONSAb2kVhDTrA6/oVJ9egV500kIDGcuAuBVL+W69iOEvpSA2I0Dw2TVFwgO
         5wndeUSfmOgtzMYccAFocNqgHaVytUCBdU4qqsQY/IuE7joCrVb2lEjB7HFXJLcHMKas
         0qBPaIglj6T8EOVkVApH+Wh0oiJNi6dnRtSk3pBBE4dDmRFvhXoupOaTvSlxCHE7/WO1
         tZHw==
X-Gm-Message-State: AGi0PuZaQi/ejIJPANQUKKcmrrM287B12sMVugNdrZUk5QdXzb0+QAiN
        wwJu83mD2VdsYg6vPF4HTPY4qsGoYiU=
X-Google-Smtp-Source: APiQypJgfBK85X65Dk/jAoq3zjAYB/+9U5ILNxpke+V621W7pE5tIJnaBVxucrV49HaWURu6y15D+w==
X-Received: by 2002:a37:a955:: with SMTP id s82mr3615351qke.45.1587648059092;
        Thu, 23 Apr 2020 06:20:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t75sm1480043qke.127.2020.04.23.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 06:20:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 34A86409A3; Thu, 23 Apr 2020 10:20:52 -0300 (-03)
Date:   Thu, 23 Apr 2020 10:20:52 -0300
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
Subject: Re: [PATCH v2 1/4] perf trace: substitute CAP_SYS_ADMIN with
 CAP_PERFMON in error message
Message-ID: <20200423132052.GA19437@kernel.org>
References: <66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com>
 <450d035a-c192-10e5-1c28-664ccae3e46e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450d035a-c192-10e5-1c28-664ccae3e46e@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Wed, Apr 22, 2020 at 05:44:02PM +0300, Alexey Budankov escreveu:
> 
> Update error message to mention CAP_PERFMON only. CAP_SYS_ADMIN still
> works in keeping with user space backward compatibility approach.

This will confuse users that build the latest perf to use in older
systems where CAP_PERFMON isn't available, probably we need to, in these
cases, check for the existence of CAP_PERFMON to provide a better
warning message, something like:

  You need CAP_ADMIN or update your kernel and libcap to one that supports
  CAP_PERFMON.

For systems without CAP_PERFMON, while mentioning only CAP_PERFMON for
systems where it is present, right?
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 55eda54240fb..39d43ad02f30 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -288,7 +288,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	      perf_cap__capable(CAP_SYS_ADMIN))) {
>  		pr_err("ftrace only works for %s!\n",
>  #ifdef HAVE_LIBCAP_SUPPORT
> -		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> +		"users with the CAP_PERFMON capability"
>  #else
>  		"root"
>  #endif
> -- 
> 2.24.1
> 

-- 

- Arnaldo
