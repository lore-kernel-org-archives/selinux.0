Return-Path: <SRS0=yfq3=WM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C9EC3A59D
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 16:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A101F21721
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 16:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FWoV0ATs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfHPQ3W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:29:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33639 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfHPQ3V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Aug 2019 12:29:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id z17so5866920ljz.0
        for <selinux@vger.kernel.org>; Fri, 16 Aug 2019 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pb1dJnMcCuUxqNlEH74lTDGdrP8RS3vLcKTgQoY3yZQ=;
        b=FWoV0ATs5FGV4ZBl8oQJ/yknE0+N+PGT7v0iE5Ro42XrtEZle8i+DYwWT/ou09MbhF
         TMShCE9s0yl4vkYMkhVeDsmUQq8hxHyolqQfd9pWEx5FOYhHy8UkMHCbeeMqOc65Cxtg
         +s40PJdTcOz7M2w3cigXXDLvL51ivCvvmKa5ADm9JWhlNA2dZkQudT2f/p8ba7qH1r3F
         dXDc2Gb/H277NFrKD49ECjh49cmWL/lfwZe19yhi9DNKA9KyGLRMwltd9jCNJbv2AdpX
         /sZcC/CVc4Z0yJgRQn2NFNko7Mi/s5jUlWH7GZG8OiuGG2c2gE6gpVh2wnE/tjAAw3/f
         g/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pb1dJnMcCuUxqNlEH74lTDGdrP8RS3vLcKTgQoY3yZQ=;
        b=Or30HybEX4sv4EYoo6DXPDT4H1znffeN1tE5srEuaNBsVWQy3TrleHaJ9qg5N4JA1D
         HOL3mLV831rTvlsjPn/zRpucvO2Nqkq1kxbbv4JuYnQ6nVQl/H2kRBM8whyA8RrrRvMl
         dqQJVGfSz5oxtbZsWw7Irh8SBCQbnYG616oCQ1CsmaNvEF/fUog4jmKV04L9EgQcfZme
         s346SrlWHP8hTHZEVsp5CSGF2I0iCyASAVL76hEJvpyy3lz9s0/5gSXys30pbrQ6I3tm
         K9Avhw5UgVzuHnW8Xoqn+SI0NA36FjSeMJMa/W6sbzh0HKkHuaDKkK3ggLfLtZC9ZmxX
         +3qA==
X-Gm-Message-State: APjAAAU+tCgwnmpj7k/qbJEdS+85Zf/Lc8uZhGMSguWmgC93O0WZVchL
        k25ehyeRR7A2TgNji9KiYsifrL5Cw5uPdj4Ut6qO
X-Google-Smtp-Source: APXvYqwTo86pc3wtjSRNvwvaVvPzQk1GNxxqKZk/bJrUwU1pnmgHD+hdoXWEmocncfzZBvnR92VFb0IdWgE43DMpiIc=
X-Received: by 2002:a2e:834e:: with SMTP id l14mr6010790ljh.158.1565972959608;
 Fri, 16 Aug 2019 09:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190801144313.1014-1-acgoide@tycho.nsa.gov> <CAHC9VhTSWiz45vh+M+sgu+ePwgFPZ4Mr8GmRZQjsGWQSzkjbLg@mail.gmail.com>
 <b79617aa-2b40-40bf-9f35-0f5be8e34d3f@tycho.nsa.gov> <20190813212710.wimxgfunrijqwuqt@madcap2.tricolour.ca>
 <CAHC9VhTWY4vtsmCn8X3TjR1HdsB1-wqBLs03vZVv0SmWQ-Ab2Q@mail.gmail.com>
 <b47e07bc-1b01-c5f0-305d-e6fe014b00d8@tycho.nsa.gov> <CAHC9VhRzz52bVwMikM7C65vCCSLb0=y1HtB50o-H0G3AMHqRNw@mail.gmail.com>
 <cb2833ee-3a12-9c7d-6c5b-c7944e74b3e9@tycho.nsa.gov>
In-Reply-To: <cb2833ee-3a12-9c7d-6c5b-c7944e74b3e9@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 16 Aug 2019 12:29:08 -0400
Message-ID: <CAHC9VhT-mmTyHij0MJHBWRjf6YmPBX9LHHaZ0H1sWx7v0O8jPw@mail.gmail.com>
Subject: Re: [Non-DoD Source] Re: [RFC PATCH v2] security, capability: pass
 object information to security_capable
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Richard Guy Briggs <rgb@redhat.com>, mortonm@chromium.org,
        john.johansen@canonical.com, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>, luto@amacapital.net,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        Nicholas Franck <nhfran2@tycho.nsa.gov>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 15, 2019 at 9:11 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
> I'm looking at how to enable LSMs to selectively turn on audit
> collection. So there seems to be two key points: audit_alloc() and
> __audit_syscall_entry(). Would it suffice to define a single boolean
> hook that takes the task and call it from both functions, to decide
> whether to override an AUDIT_DISABLED state in audit_alloc() and to
> override a 0 audit_n_rules in __audit_syscall_entry(). In audit_alloc()
> if audit_filter_task() returned AUDIT_DISABLED and the hook returned
> true, we would change the state to AUDIT_BUILD_CONTEXT. In
> __audit_syscall_entry(), if the hook returned true, we would set dummy
> to 0. Obviously, we could have a more general hook which lets us return
> arbitrary audit states, but, it isn't clear how we would reconcile
> conflicting results from audit_filter_task() and the hook for any
> situation other than AUDIT_DISABLED. We could also potentially use a
> different hook in __audit_syscall_entry(), though I don't think that we
> want the LSMs trying to interpret the syscall number or arguments.
>
> Do you think that is sufficiently general or would you suggest something
> different?

FWIW, I think treating the per-task audit switch as a boolean is fine;
I don't think we want other in-kernel callers to have to worry about
the different audit states.  From their perspective it is either "on"
or "off".

However, I think there are two parts of the greater LSM-enables-audit
discussion, and we're only discussing the first part: collection.  The
second part is the actual audit record generation, and I think this
part is going to be less clear.  While the changes to audit_alloc(),
etc. are necessary to be able to do any meaningful audit later on, I'm
thinking introducing some granularity and LSM control to what gets
generated in audit_log_exit() might be very welcome both from a
performance and log cleanliness perspective.

Some random thoughts on this (some may be way off, but I want to start
with some expectations):
* The LSM should never be able to block collection/generation of audit
records, just enable additional records.
* The LSM controls should only affect what we call the "syscall
auditing" bits, e.g. the stuff in auditsc.c.  Audit records that
happen outside of this should be untouched, the AVC records are an
example of a record that exists independent of syscall auditing.
* We should be able to have the LSM set a per-syscall audit enable
flag which would be checked in audit_log_exit() (or
audit_free()/__audit_syscall_exit()).
* It's not clear to me if we want to provide some granularity to the
LSM regarding what records get generated in audit_log_exit(), for
example do we allow the LSM to request just PATH records?  I'm
guessing we wouldn't want to specify record types directly, but
perhaps record "classes", e.g. "file".

I'm not sure if any of this is going to be a good idea, but I think we
need to discuss it a bit before we start duplicating things in
lsm_audit.c.

-- 
paul moore
www.paul-moore.com
