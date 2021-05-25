Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B44C2B9F8
	for <selinux@archiver.kernel.org>; Tue, 25 May 2021 18:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67DC61404
	for <selinux@archiver.kernel.org>; Tue, 25 May 2021 18:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhEYSZe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 May 2021 14:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232030AbhEYSZc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 May 2021 14:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621967041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iH7ebmDVDSm2wMH3drw7UCgrLcr2qZZSxIAy3UUgpik=;
        b=J4D78tPXCmeV0sTtCZR7hTAKGLTRWZLcz/vE19oAl9Xb8U8YkH88fAhsMFTaZLIG7Y9oqm
        dZFnqUgnGACdCLar1y40OaW1CCfeC6YGYqguIXLvLTvW1T439bzZkvPNRPBhpT/e0fdYqi
        mHmNCpEg+BTTgy590D7nSYJJkV67r3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-5NRibvkvMT22rXaLovsheA-1; Tue, 25 May 2021 14:23:57 -0400
X-MC-Unique: 5NRibvkvMT22rXaLovsheA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B51391019645;
        Tue, 25 May 2021 18:23:56 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C92EB5C1A1;
        Tue, 25 May 2021 18:23:54 +0000 (UTC)
Date:   Tue, 25 May 2021 14:23:50 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>, john.johansen@canonical.com,
        selinux@vger.kernel.org, linux-audit@redhat.com,
        casey.schaufler@intel.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v26 22/25] Audit: Add new record for multiple process LSM
 attributes
Message-ID: <20210525182350.GG447005@madcap2.tricolour.ca>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-23-casey@schaufler-ca.com>
 <CAHC9VhSdFVuZvThMsqWT-L9wcHevA-0yAX+kxqXN0iMmqRc10g@mail.gmail.com>
 <39d6ac53-d965-de64-266f-d0fa3139e52f@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39d6ac53-d965-de64-266f-d0fa3139e52f@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-05-25 10:28, Casey Schaufler wrote:
> On 5/21/2021 1:19 PM, Paul Moore wrote:
> 
> <snip> and trim the CC list.
> 
> > Okay, we've got a disconnect here regarding "audit contexts" and
> > "local contexts", skip down below where I attempt to explain things a
> > little more but basically if there is a place that uses this pattern:
> >
> >   audit_log_start(audit_context(), ...);
> 
> This pattern isn't helpful. audit_context() returns NULL in about 1 of 4 calls.

Ok, this rings a bell...  I think we talked about this on an earlier
revision...

> All of these callers of audit_context() get a NULL result some of the time.
> 
> getname_kernel
> debugfs_create_dir
> tracefs_create_file
> vfs_fchown
> do_settimeofday64
> bprm_execve
> ksys_mmap_pgoff
> move_addr_to_kernel
> __do_pipe_flags
> __do_sys_capset
> syscall_trace_enter
> cap_bprm_creds_from_file
> load_module
> __x64_sys_fsetxattr
> bpf_prog_load
> audit_signal_info_syscall
> sel_write_enforce
> common_lsm_audit
> audit_set_loginuid
> __dev_set_promiscuity
> ipcperms
> devpts_pty_new
> 
> > ... you don't need, or want, a "local context".  You might need a
> > local context if you see the following pattern:
> >
> >   audit_log_start(NULL, ...);
> >
> > The "local context" idea is a hack and should be avoided whenever
> > possible; if you have an existing audit context from a syscall, or
> > something else, you *really* should use it ... or have a *really* good
> > explanation as to why you can not.
> 
> Almost all audit events want to record the subject context by calling
> audit_log_task_context(). If multiple contexts need to be recorded
> there has to be a separate record, which means there has to be an
> audit context. The only case where an audit context is reliably available
> is in syscalls. Hence, a "local context" for many of the cases where the
> first argument to audit_log_start() would otherwise be NULL, either
> explicitly or because audit_context() returns NULL.

Ok, so in that case, I think I'd test audit_context() and if it is
indeed NULL then create a local context, otherwise use the one that is
available.  I should really go back and look carefully again at your
code to see if it is in fact doing this, but unilaterally creating a
local context if a context already exists is going to cause confusion
because there will be two events generated for one event.

Is it possible these functions are not actually generating records if
the context is NULL?

I'd be digging to find out why the context is NULL in these cases and if
any record is even being produced in those cases?  Perhaps there is an
active filter that indicates that logging is not of interest for that
process/task/file/syscall/perm/etc...

> Is there some other way to synchronize the "timestamp" without use of
> an audit context? My understanding is that this is the primary purpose
> of the audit context. 

What has been done is to call it with a NULL context and it would assign
a timestamp and serial number, but those are all single records that
don't need synchronization (obviously).  This was why I'd come up with
this mechanism to solve the need to attach a contid record to a single
record associated with a network event (or user record that should not
be associated with a syscall).  Those were the only two use cases I had
up until now.


- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

