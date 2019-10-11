Return-Path: <SRS0=gpZQ=YE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD94ECE58C
	for <selinux@archiver.kernel.org>; Fri, 11 Oct 2019 15:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DAD2089F
	for <selinux@archiver.kernel.org>; Fri, 11 Oct 2019 15:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DSwaEoz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfJKPrh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:47:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43967 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfJKPrh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Oct 2019 11:47:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so4640353plj.10
        for <selinux@vger.kernel.org>; Fri, 11 Oct 2019 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L8nfwXCisRm1qePDK4SMx1pjknBpWa94Qxj1sS8u5kA=;
        b=DSwaEoz+bD4qFKZIKz/Konam440PIDOX1fNFO3xJHi77xdNlftLPxyfvp0UwWKgZ+4
         HI+lCnFhy2XKfM4ammZOptEEr8v11ae+4A9A04ZH8cEH5w9V2o08IDcb5lTnT0n7li0f
         KJJwrWCiiZDuDfS9eMbKCAn2qytH5+UyHaXoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L8nfwXCisRm1qePDK4SMx1pjknBpWa94Qxj1sS8u5kA=;
        b=hcoe90+bZo+gtiDP9QwFCePcJBMxvDl64Pa3VqZqX8yKOEPjNLADeo0rNqt6lfMs3G
         L4DA3gqleTaw9nsM/LoA6yfhgh0PLCixrZ3SidJPm0Hn72JWAspnMz3CXlNiyvyfZPCC
         dURQHgq77+Q3zAHYkp2wze10xRIH0uUwMMrg6jAntQ/1fS9UcKBWW+eCBHIqTRY6HjlS
         MhRjd/U3CX7XkIqHe+oSD12EmvvbqJszNcfd17gtWlXR8YQjAnnrlI6k4kfmFnhpjIiX
         5JsIDrOhQ0dVOeoSkUfEXShQi1ssi+xQ+YtnvhudtX27WcS61BguquOR2SVIg5lUTCOC
         7OzQ==
X-Gm-Message-State: APjAAAUr/LiyXxqwGISBvqfVCMvk5BO/zblz/cQjwPLqrvhGpTsxGVPG
        Pyzyte+jIWz6Q8EL4U+jhcau6Q==
X-Google-Smtp-Source: APXvYqyZB1iwpECmMrQ/nKWm2V0v/043bP3KVsuGonJdp/o/3FFZ2TVnzLm6gdCdqIIWB8mQFahKJw==
X-Received: by 2002:a17:902:a985:: with SMTP id bh5mr15414239plb.184.1570808856657;
        Fri, 11 Oct 2019 08:47:36 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u65sm3019972pgb.36.2019.10.11.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:47:35 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:47:34 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191011154734.GA105106@google.com>
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <20191010081251.GP2311@hirez.programming.kicks-ass.net>
 <20191010151333.GE96813@google.com>
 <20191010170949.GR2328@hirez.programming.kicks-ass.net>
 <20191010183114.GF96813@google.com>
 <20191011070543.GV2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011070543.GV2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 11, 2019 at 09:05:43AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 10, 2019 at 02:31:14PM -0400, Joel Fernandes wrote:
> > On Thu, Oct 10, 2019 at 07:09:49PM +0200, Peter Zijlstra wrote:
> 
> > > Yes, I did notice, I found it weird.
> > > 
> > > If you have CAP_IPC_LIMIT you should be able to bust mlock memory
> > > limits, so I don't see why we should further relate that to paranoid.
> > > 
> > > The way I wrote it, we also allow to bust the limit if we have disabled
> > > all paranoid checks. Which makes some sense I suppose.
> > > 
> > > The original commit is this:
> > > 
> > >   459ec28ab404 ("perf_counter: Allow mmap if paranoid checks are turned off")
> > 
> > I am thinking we can just a new function perf_is_paranoid() that has nothing
> > to do with the CAP_SYS_ADMIN check and doesn't have tracepoint wording:
> > 
> > static inline int perf_is_paranoid(void)
> > {
> > 	return sysctl_perf_event_paranoid > -1;
> > }
> > 
> > And then call that from the mmap() code:
> > if (locked > lock_limit && perf_is_paranoid() && !capable(CAP_IPC_LOCK)) {
> > 	return -EPERM;
> > }
> > 
> > I don't think we need to add selinux security checks here since we are
> > already adding security checks earlier in mmap(). This will make the code and
> > its intention more clear and in line with the commit 459ec28ab404 you
> > mentioned. Thoughts?
> 
> Mostly that I'm confused by the current code ;-)
> 
> Like I said, CAP_IPC_LIMIT on its own should already allow busting the
> limit, I don't really see why we should make it conditional on paranoid.
> 
> But if you want to preserve behaviour (arguably a sane thing for your
> patch) then yes, feel free to do as you propose.

Ok, I will do it as I proposed above and resend patch today. Thanks!

 - Joel

