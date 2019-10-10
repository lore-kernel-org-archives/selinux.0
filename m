Return-Path: <SRS0=2qaZ=YD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDDAC10F14
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98D42190F
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 18:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MkZI6eTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfJJSbR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:31:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34252 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfJJSbR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Oct 2019 14:31:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so4212612pgl.1
        for <selinux@vger.kernel.org>; Thu, 10 Oct 2019 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5puI+DUvR4/SJReC5iWNrRC5yb0UPaNESP/3e3cTv9c=;
        b=MkZI6eTmS3La1zAMkWRZvmhyLoKc8C0+QmWj2WdxWBkcUPahTXnkJlLPusjh9To197
         Hxat8zlCruXGtldcp5C/WsZQH5HG4bC8HTDy2RnmbNhwPa8yf3YSc2sVn3C2G5qajDHa
         oXuyROsSnNXl5J4LEDKbBlaEsdpJkyB4rtjxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5puI+DUvR4/SJReC5iWNrRC5yb0UPaNESP/3e3cTv9c=;
        b=Il1lj1TezDPYXBmg8I3xxczq8wTFMconA2N0b35rfGcaaLxQLdebWQ8PWmjuenw44B
         3NcUPgsH+DeyE2wYBqWy6GVobcK/QnFYft3cqWDUhc5qWVimvftQgaiHxf7pHeSUdQ2K
         rRY4v2a268Vzd4GrlfSqoWeFv4C+bebhYZXl3+9RNjjdXcnXIa4LxV1HD0C7XkQGRNMq
         ebGRAlf6NbclrWbygDxzoJiepdyZ+4J0XGxWZDMuYfE54k+z/Y4tNors9vkmwIonF4Hk
         /jJ0AyYKxVRvDJ7FdvI5SHTVe6EcCK69N3SLNGpC57YL4sN98Fk0pZy56BYn/YwRMYnw
         xTqQ==
X-Gm-Message-State: APjAAAU070U0rNPbI/8sb2l+pCSJwo/ROPMSfcJTrwjseqPmLYHzYasB
        vHalYovnalYZf6w3wawPhYul1g==
X-Google-Smtp-Source: APXvYqzqTVWSe6JvJ/kb/6wa/aaxIFE0i30wB0mnU8oqMEc087kPg9LcojT5gjbi73mMECLQXOK+Cg==
X-Received: by 2002:a17:90a:c389:: with SMTP id h9mr13255162pjt.11.1570732276108;
        Thu, 10 Oct 2019 11:31:16 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id ce16sm5637648pjb.29.2019.10.10.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 11:31:15 -0700 (PDT)
Date:   Thu, 10 Oct 2019 14:31:14 -0400
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
Message-ID: <20191010183114.GF96813@google.com>
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <20191010081251.GP2311@hirez.programming.kicks-ass.net>
 <20191010151333.GE96813@google.com>
 <20191010170949.GR2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010170949.GR2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 10, 2019 at 07:09:49PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 10, 2019 at 11:13:33AM -0400, Joel Fernandes wrote:
> > On Thu, Oct 10, 2019 at 10:12:51AM +0200, Peter Zijlstra wrote:
> > > +static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
> > >  {
> > > -	return sysctl_perf_event_paranoid > 1;
> > > +	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
> > > +		return -EPERM;
> > > +
> > 
> > Here the sysctl check of > -1 also is now coupled with a CAP_SYS_ADMIN check.
> > However..
> > 
> > > +	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
> > 
> > >  }
> > >  
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> 
> > > @@ -5862,14 +5859,8 @@ static int perf_mmap(struct file *file,
> > >  	lock_limit >>= PAGE_SHIFT;
> > >  	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
> > >  
> > > -	if (locked > lock_limit) {
> > > -		if (perf_paranoid_tracepoint_raw() && !capable(CAP_IPC_LOCK)) {
> > > -			ret = -EPERM;
> > > -			goto unlock;
> > > -		}
> > > -
> > > -		ret = security_perf_event_open(&event->attr,
> > > -					       PERF_SECURITY_TRACEPOINT);
> > > +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> > > +		ret = perf_allow_tracepoint(&event->attr);
> > 
> > In previous code, this check did not involve a check for CAP_SYS_ADMIN.
> > 
> > I am Ok with adding the CAP_SYS_ADMIN check as well which does make sense to
> > me for tracepoint access. But it is still a change in the logic so I wanted
> > to bring it up.
> > 
> > Let me know any other thoughts and then I'll post a new patch.
> 
> Yes, I did notice, I found it weird.
> 
> If you have CAP_IPC_LIMIT you should be able to bust mlock memory
> limits, so I don't see why we should further relate that to paranoid.
> 
> The way I wrote it, we also allow to bust the limit if we have disabled
> all paranoid checks. Which makes some sense I suppose.
> 
> The original commit is this:
> 
>   459ec28ab404 ("perf_counter: Allow mmap if paranoid checks are turned off")

I am thinking we can just a new function perf_is_paranoid() that has nothing
to do with the CAP_SYS_ADMIN check and doesn't have tracepoint wording:

static inline int perf_is_paranoid(void)
{
	return sysctl_perf_event_paranoid > -1;
}

And then call that from the mmap() code:
if (locked > lock_limit && perf_is_paranoid() && !capable(CAP_IPC_LOCK)) {
	return -EPERM;
}

I don't think we need to add selinux security checks here since we are
already adding security checks earlier in mmap(). This will make the code and
its intention more clear and in line with the commit 459ec28ab404 you
mentioned. Thoughts?

thanks,

 - Joel

