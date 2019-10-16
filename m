Return-Path: <SRS0=72Nf=YJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C5EECE58F
	for <selinux@archiver.kernel.org>; Wed, 16 Oct 2019 00:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862302054F
	for <selinux@archiver.kernel.org>; Wed, 16 Oct 2019 00:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="spCA93Ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbfJPAU7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 20:20:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37084 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389080AbfJPAU6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 20:20:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so13538582pfo.4
        for <selinux@vger.kernel.org>; Tue, 15 Oct 2019 17:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FArNhP5DErG1Ml8KyApc8sefVsVeEkXB1R/x3hburN4=;
        b=spCA93UaswCGNF4+9dxS76ppeuge4nCJObXdAVsO+DyOAjtvUhxuUh2UED/IGfCjRH
         93J+lDuNj0qTeQPUQjazdhSJGko8AmpP9WCUNFdRRKtKTeniyybLertUuZbphTNtzmt8
         WYxa7hSzDwEjn+pW9BaYyoCrx6LexNpNgsGvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FArNhP5DErG1Ml8KyApc8sefVsVeEkXB1R/x3hburN4=;
        b=CZlGFzjCTlR0R3VC/m3SY/bDFPoLypv725Qa8dZsTbH9y0eOH8OqstNiiiMpwa9WJV
         l9nFIfYlsoAzpOK3/xTr6Jo5wGtvZATV49Q30nK6gCi5gmJ6mOUzCgQOzyMtaWzuFzGq
         2/T6+LWka/Pt5krGOa3WdlY+DXO2EOw4uVzxI1Q6EfI+YUE+sf023dtqox1yV6am3v8k
         2pvOcN5tV4faIctltMdpc/X2Tb4KZxk68ZMnuytE98wf599o8+yADKldk/WMis6BxxLV
         cIP4ed6widN149v034UW99tIi57irxxFI7afIgzL5uL0usHD6w2s/D6iAzbEOBiMJKb8
         Tt6w==
X-Gm-Message-State: APjAAAVjznnAr/fcvYR167/AsYrqaCb/N0mE5PlEMlCMX0McOl6wRr9Q
        adfVHXzhzeSF+60XRX5B0S99uw==
X-Google-Smtp-Source: APXvYqwnNKZGQBVQ9WkrFfzzoKhdSRhtNpejOOtqBzrGnaay9GKfue6bErrPcPWL5kfbVlibvqVDKQ==
X-Received: by 2002:a17:90a:3608:: with SMTP id s8mr1480635pjb.44.1571185257717;
        Tue, 15 Oct 2019 17:20:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l62sm24553103pfl.167.2019.10.15.17.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 17:20:56 -0700 (PDT)
Date:   Tue, 15 Oct 2019 20:20:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, James Morris <jmorris@namei.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v2] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191016002055.GA176924@google.com>
References: <20191014170308.70668-1-joel@joelfernandes.org>
 <20191015083008.GC2311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015083008.GC2311@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 15, 2019 at 10:30:08AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 14, 2019 at 01:03:08PM -0400, Joel Fernandes (Google) wrote:
> > In current mainline, the degree of access to perf_event_open(2) system
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
> > 4. perf_event_read: Called from the read(2) and mmap(2) syscalls for the event.
> > 
> > 5. perf_event_write: Called from the ioctl(2) syscalls for the event.
> > 
> > [1] https://lwn.net/Articles/696240/
> > 
> > Since Peter had suggest LSM hooks in 2016 [1], I am adding his
> > Suggested-by tag below.
> 
> Thanks, I've queued the patch!

Thanks!

> > To use this patch, we set the perf_event_paranoid sysctl to -1 and then
> > apply selinux checking as appropriate (default deny everything, and then
> > add policy rules to give access to domains that need it). In the future
> > we can remove the perf_event_paranoid sysctl altogether.
> 
> This I'm not sure about; the sysctl is only redundant when you actually
> use a security thingy, not everyone is. I always find them things to be
> mightily unfriendly.

Right. I was just stating the above for the folks who use the security
controls.

thanks,

 - Joel

