Return-Path: <SRS0=BxL9=6H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1550EC54FD0
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 18:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E516520767
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 18:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4EUQ7yB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgDWSKg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgDWSKg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Apr 2020 14:10:36 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F035FC09B042;
        Thu, 23 Apr 2020 11:10:35 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v26so56005qto.0;
        Thu, 23 Apr 2020 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qPBEpYztacbVXAnXtHaabQP6rRHo96QuqAvZkwuZJto=;
        b=L4EUQ7yBDVooy2o3cEUID9EV6wJXZht1OM/OumQrg17mjL4U6kJ3+3wdpqagD8ubXA
         yxJRaNEBUPqdD8xRvkC8QEruzYVzwWrRgtFoYGXuiH7fSRBaJDRHnnIZNah/zHQQT+DM
         F37gTBIlutLG9InjqxXNeh7t6xbtL0fSbFnC9wWiSneqsAICpPT1GKY8m7yHLz5Q8Vov
         hfhldY0TPwAiKej2xUc2Wc/vGu5cu3pOv4D8XKjvTLgOXNSkd0MEAfncp2460uYPEjby
         z2zHZQiOjMEcx/YzqZKReN+/3zkWL5T/A2UL91kw6wOswuSipIA78vkNtAv2Z4Bpbv0D
         3SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qPBEpYztacbVXAnXtHaabQP6rRHo96QuqAvZkwuZJto=;
        b=YHF8fZjsYwJzUdfl+w+5ZAl1tEwkUUzBgfQFHzItZF5s4PJ6v1BanO4byEpvPX2+yq
         3kj7Ox1tpWIA4+Gjvo7EWA2st9q3FPchSnHUGE4xnbLsIjHX3ViG5Mu0l2GzlLSQazhw
         apsuGGUaZs5l1DDj8fJG8raK5d+VvXfaaF/lQCscqSnh9fZcm/Xi8pYhVTynBUBvqRnr
         l9PpJIIkSLfnf4xTwo9JQ8VO8LkNE1W2jwmBtki66myC9yPxfVtUUF/QS83MMzouQuy7
         znf6tDdxVYLimUZqUsG3G7SnbsNsV8Z/A516u0jr6ehdcNTro7SGiNvO2v2F2DdQAl9s
         S34A==
X-Gm-Message-State: AGi0PuahZ9zndBx04+I433pEL1mkM5/IFgsvxthsAHWmjQfAPsi92XQv
        7nVTMVeN0ZI1l56tGw5CW1c=
X-Google-Smtp-Source: APiQypLgGpRR9+KI9m0wrhx/bDA4BvwPsUvOnPo0dBZgS7bSoovpi9pkIB2JuG+EIiG33Dw9+aslrg==
X-Received: by 2002:ac8:2c0c:: with SMTP id d12mr5448806qta.284.1587665435149;
        Thu, 23 Apr 2020 11:10:35 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id k2sm2316868qta.39.2020.04.23.11.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 11:10:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C10A409A3; Thu, 23 Apr 2020 15:10:30 -0300 (-03)
Date:   Thu, 23 Apr 2020 15:10:30 -0300
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
Subject: Re: [PATCH v2 1/4] perf trace: substitute CAP_SYS_ADMIN with
 CAP_PERFMON in error message
Message-ID: <20200423181030.GF20647@kernel.org>
References: <66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com>
 <450d035a-c192-10e5-1c28-664ccae3e46e@linux.intel.com>
 <20200423132052.GA19437@kernel.org>
 <a775fef2-6d86-d43a-3a46-5b2d129c77dc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a775fef2-6d86-d43a-3a46-5b2d129c77dc@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Thu, Apr 23, 2020 at 05:49:32PM +0300, Alexey Budankov escreveu:
> 
> On 23.04.2020 16:20, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Apr 22, 2020 at 05:44:02PM +0300, Alexey Budankov escreveu:
> >>
> >> Update error message to mention CAP_PERFMON only. CAP_SYS_ADMIN still
> >> works in keeping with user space backward compatibility approach.
> > 
> > This will confuse users that build the latest perf to use in older
> > systems where CAP_PERFMON isn't available, probably we need to, in these
> > cases, check for the existence of CAP_PERFMON to provide a better
> > warning message, something like:
> > 
> >   You need CAP_ADMIN or update your kernel and libcap to one that supports
> >   CAP_PERFMON.
> > 
> > For systems without CAP_PERFMON, while mentioning only CAP_PERFMON for
> > systems where it is present, right?
> 
> Right, but this ideal implementation requires more effort, so staying with
> two caps in the message and letting users decide which one to use looks like
> a good balance already. 

Agreed.

- Arnaldo
