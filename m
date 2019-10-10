Return-Path: <SRS0=2qaZ=YD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D497AC10F14
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF49F206B6
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 15:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JDqRmA/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfJJPNh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:13:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46269 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJPNg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Oct 2019 11:13:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so4080734pfg.13
        for <selinux@vger.kernel.org>; Thu, 10 Oct 2019 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VXeYBQAM8h1PaL67Bf61gIW65uw4eLRIRvHFtIpEQhY=;
        b=JDqRmA/dj97Eh+82JlJ7S4i+CfdlJn6XhjAl+rM29OqBccgZJHcpuLQi3eydE8QPru
         y1wnnMHIZTrTS0K7h7GzTEBMRAYEaztShrmEZf7Z6n/KVlomGMl0k8oApxadE04OX4qz
         Daw6e8YITBd6KZ4Zl3hz3mM9SV7SwYMrngXQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VXeYBQAM8h1PaL67Bf61gIW65uw4eLRIRvHFtIpEQhY=;
        b=drVNkILAENkRjC9hPPw5+I0elud7vCu+cO8e//VXHriiyNSmv1uU+f+oGy7OeClZRh
         h2mfnljqjSgfrntHTbSY9xz4jKECrodNchQf73kirTIM+Ynhw3csUeJNPXjeWFjQD/v/
         D+Bgu8+H+qch5hxvGA9YeSc5BmT4SoNptCYNn0dVVRrtGFIWteVKsXgeKuAO+r1c/Sjm
         BzrWVEaRcIn+CVdmC4izkeiOEhbH9RCiFedegTb3xlMYK894Z7ZhNxIyDatOYRKJUZ6r
         x/khVNLb1A+374SmyVL0LeW1tefn0zE2hgwgX2V3FEbVqFuz4+qcptEjxZlhAAJOmMKV
         ulOA==
X-Gm-Message-State: APjAAAUYCeW23dpX20u6DdQ/HBAYmtmbmSy9gxuIOBzWkIBTetQ1a/hd
        vbK/qpX4ksabw49ulyr6zDU4xg==
X-Google-Smtp-Source: APXvYqz1PmBgMDm/CdysRGv040UaFtPAsTJvwhNOv7XvcrJNF2AXiquVL7MCJs6JaMbwwedghHcgMA==
X-Received: by 2002:a65:4208:: with SMTP id c8mr11471239pgq.230.1570720415595;
        Thu, 10 Oct 2019 08:13:35 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y10sm5561179pfe.148.2019.10.10.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 08:13:34 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:13:33 -0400
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
Message-ID: <20191010151333.GE96813@google.com>
References: <20191009203657.6070-1-joel@joelfernandes.org>
 <20191010081251.GP2311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010081251.GP2311@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 10, 2019 at 10:12:51AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 09, 2019 at 04:36:57PM -0400, Joel Fernandes (Google) wrote:
> > In currentl mainline, the degree of access to perf_event_open(2) system
> > call depends on the perf_event_paranoid sysctl.  This has a number of
> > limitations:
> > 
> > 1. The sysctl is only a single value. Many types of accesses are controlled
> >    based on the single value thus making the control very limited and
> >    coarse grained.
> > 2. The sysctl is global, so if the sysctl is changed, then that means
> >    all processes get access to perf_event_open(2) opening the door to
> >    security issues.
> > 
> > This patch adds LSM and SELinux access checking which will be used in
> > Android to access perf_event_open(2) for the purposes of attaching BPF
> > programs to tracepoints, perf profiling and other operations from
> > userspace. These operations are intended for production systems.
> > 
> > 5 new LSM hooks are added:
> > 1. perf_event_open: This controls access during the perf_event_open(2)
> >    syscall itself. The hook is called from all the places that the
> >    perf_event_paranoid sysctl is checked to keep it consistent with the
> >    systctl. The hook gets passed a 'type' argument which controls CPU,
> >    kernel and tracepoint accesses (in this context, CPU, kernel and
> >    tracepoint have the same semantics as the perf_event_paranoid sysctl).
> >    Additionally, I added an 'open' type which is similar to
> >    perf_event_paranoid sysctl == 3 patch carried in Android and several other
> >    distros but was rejected in mainline [1] in 2016.
> > 
> > 2. perf_event_alloc: This allocates a new security object for the event
> >    which stores the current SID within the event. It will be useful when
> >    the perf event's FD is passed through IPC to another process which may
> >    try to read the FD. Appropriate security checks will limit access.
> > 
> > 3. perf_event_free: Called when the event is closed.
> > 
> > 4. perf_event_read: Called from the read(2) system call path for the event.
> 
> 	+ mmap()
> > 
> > 5. perf_event_write: Called from the read(2) system call path for the event.
> 
> 	- read() + ioctl()

Fixed.

> 
> fresh from the keyboard.. but maybe consoldate things a little.

Looks great to me, I folded it into the patch. Thanks Peter! Just one comment
on change in existing logic of the code, below:

[snip]
> --- a/arch/x86/events/intel/p4.c
> +++ b/arch/x86/events/intel/p4.c
> @@ -8,7 +8,6 @@
>   */
>  
>  #include <linux/perf_event.h>
> -#include <linux/security.h>
>  
>  #include <asm/perf_event_p4.h>
>  #include <asm/hardirq.h>
> @@ -777,10 +776,7 @@ static int p4_validate_raw_event(struct
>  	 * the user needs special permissions to be able to use it
>  	 */
>  	if (p4_ht_active() && p4_event_bind_map[v].shared) {
> -		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
> -			return -EACCES;
> -
> -		v = security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
> +		v = perf_allow_cpu(&event->attr);
>  		if (v)
>  			return v;
>  	}
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -56,6 +56,7 @@ struct perf_guest_info_callbacks {
>  #include <linux/perf_regs.h>
>  #include <linux/cgroup.h>
>  #include <linux/refcount.h>
> +#include <linux/security.h>
>  #include <asm/local.h>
>  
>  struct perf_callchain_entry {
> @@ -1244,19 +1245,28 @@ extern int perf_cpu_time_max_percent_han
>  int perf_event_max_stack_handler(struct ctl_table *table, int write,
>  				 void __user *buffer, size_t *lenp, loff_t *ppos);
>  
> -static inline bool perf_paranoid_tracepoint_raw(void)
> +static inline int perf_allow_kernel(struct perf_event_attr *attr)
>  {
> -	return sysctl_perf_event_paranoid > -1;
> +	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +
> +	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
>  }
>  
> -static inline bool perf_paranoid_cpu(void)
> +static inline int perf_allow_cpu(struct perf_event_attr *attr)
>  {
> -	return sysctl_perf_event_paranoid > 0;
> +	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +
> +	return security_perf_event_open(attr, PERF_SECURITY_CPU);
>  }
>  
> -static inline bool perf_paranoid_kernel(void)
> +static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
>  {
> -	return sysctl_perf_event_paranoid > 1;
> +	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +

Here the sysctl check of > -1 also is now coupled with a CAP_SYS_ADMIN check.
However..

> +	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);

>  }
>  
>  extern void perf_event_init(void);
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4229,10 +4229,7 @@ find_get_context(struct pmu *pmu, struct
>  
>  	if (!task) {
>  		/* Must be root to operate on a CPU event: */
> -		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
> -			return ERR_PTR(-EACCES);
> -
> -		err = security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
> +		err = perf_allow_cpu(&event->attr);
>  		if (err)
>  			return ERR_PTR(err);
>  
> @@ -5862,14 +5859,8 @@ static int perf_mmap(struct file *file,
>  	lock_limit >>= PAGE_SHIFT;
>  	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
>  
> -	if (locked > lock_limit) {
> -		if (perf_paranoid_tracepoint_raw() && !capable(CAP_IPC_LOCK)) {
> -			ret = -EPERM;
> -			goto unlock;
> -		}
> -
> -		ret = security_perf_event_open(&event->attr,
> -					       PERF_SECURITY_TRACEPOINT);
> +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> +		ret = perf_allow_tracepoint(&event->attr);

In previous code, this check did not involve a check for CAP_SYS_ADMIN.

I am Ok with adding the CAP_SYS_ADMIN check as well which does make sense to
me for tracepoint access. But it is still a change in the logic so I wanted
to bring it up.

Let me know any other thoughts and then I'll post a new patch.

thanks,

- Joel

[snip]
