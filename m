Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24971C433E1
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 15:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19B7207C4
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 15:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZtRK/Swu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgESPtC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgESPtC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 11:49:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0825CC08C5C0
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 08:49:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h21so12365972ejq.5
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXqsFaZYUrWPd8g8P+NBtNmPnuSPuWvOF7lOsApZicc=;
        b=ZtRK/SwuNl6/rR6kmVGmz5gmyiKW/e0rylOykpwOFS+EchcY5m7kiWjFgOV1b5zTnq
         tcQeuGUFPO4gl7l6MuepBuflEzi/IWfkS/39lUqPzueqwEXOiWcKz/4i3dwxMuzVlNNJ
         EjYRRRcvd0ac2Ha7tNdAk8c4Izx/gfIcbugf5IDisNb5SAvxwr5Yl2WB8Zpw2MzE50vJ
         FDKBTKMc4HonHVf0IdW7b8bDpfnXipAjwtGrvziSkF8M3E4PyZWTxgM8msWSxLz9azU4
         ZdpO/++jzm1REsiwZh/JSwdSG0k6yHDnzkjjc1uLFaaOL0RtsjLTJC+/nZZl44iAHobn
         htYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXqsFaZYUrWPd8g8P+NBtNmPnuSPuWvOF7lOsApZicc=;
        b=UHmJH2yEEOJB+TbERTvR+RpDy4HBwlrwgCoeVHHspDCLbGsRy41lyDEEEeKVROwc01
         IojWvqRAlC1nVL75fTK0/zyovxJS4qD0Z9iNnyw65PF6cgDVcSlexUP6zbV8AJmFwTi3
         J9IOVW+eNr/MU0AOErry/BWY1t6wcYSQhKmX3u1iBSWiE8nynZQLHw4LvLt789akrsOV
         7jAWsqgWxQ6L0lmNMJDn59GHy3CMpnhwtTMRSkQxoJEhoC8Rb3QCNCvG6sHNy9HfGobj
         lS5kVGuy74iII9nVfZU7je5poREM3Anay27IFVxi/7uD39nPih57LxvSDD7U2kUhx7pV
         BO9A==
X-Gm-Message-State: AOAM531lapKGBDH+RCMrxhZaGdESN2jm+A0Tj/DrGgjT82UVSltH/4bL
        Bxu6qSpIZG7hZFVjmJs+1xf63j8YnpL6rs5Nw9O/
X-Google-Smtp-Source: ABdhPJwNdUnc0T4bpKK1FqwyPy1M/CPbyb/M8IJ2ellHqIqSh1o8ijGRW/1DbacfIW8CcfyCmJ66V3nNr01mTEEzS9s=
X-Received: by 2002:a17:907:b13:: with SMTP id h19mr1164608ejl.488.1589903339426;
 Tue, 19 May 2020 08:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200514221142.11857-1-casey@schaufler-ca.com>
 <20200514221142.11857-21-casey@schaufler-ca.com> <CAEjxPJ67cA_A-Oh72EGgmCrP6k9x0PuaU2q7UL9eOc+J6Do0zQ@mail.gmail.com>
 <9cabbb54-69e6-91e6-88f8-e76d53da2a77@schaufler-ca.com> <CAHC9VhRGopG0=DbEZArz2X2yfEQ1pOqoSLRMn9ABe5JYZB2Y8Q@mail.gmail.com>
 <774a37e3-3469-d606-a468-a57892b44645@schaufler-ca.com>
In-Reply-To: <774a37e3-3469-d606-a468-a57892b44645@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 May 2020 11:48:47 -0400
Message-ID: <CAHC9VhQOVRYTvjp4kmJx-rziSqeRb-=XSKYMBeN_o-ioJp7JNg@mail.gmail.com>
Subject: Re: [PATCH v17 20/23] Audit: Add a new record for multiple subject
 LSM attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 18, 2020 at 8:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/18/2020 3:21 PM, Paul Moore wrote:
> > On Mon, May 18, 2020 at 4:43 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 5/18/2020 11:02 AM, Stephen Smalley wrote:
> >>> On Thu, May 14, 2020 at 7:30 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>> Create a new audit record type to contain the subject information
> >>>> when there are multiple security modules that require such data.
> >>>> This record is emitted before the other records for the event, but
> >>>> is linked with the same timestamp and serial number.
> >>>>
> >>>> Reviewed-by: Kees Cook <keescook@chromium.org>
> >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>> Cc: linux-audit@redhat.com
> >>>> ---
> >>> With this patch, I see userspace audit records like this one:
> >>>
> >>> type=SYSTEM_BOOT msg=audit(1589816792.181:103): pid=789 uid=0
> >>> auid=4294967295 ses=4294967295 subj=? subj=system_u:system_r:init_t:s0
> >>> msg=' comm="systemd-update-utmp"
> >>> exe="/usr/lib/systemd/systemd-update-utmp" hostname=? addr=?
> >>> terminal=? res=success'
> >>>
> >>> I'm guessing that userspace is appending the second subj= field when
> >>> it sees subj=? or otherwise is missing subj= information?
> >> I haven't looked at the userspace code, but I expect you're right.
> >> It looks like there will need to be some change in the userspace
> >> for the multiple LSM case. The "completion" shown here isn't correct,
> >> because it only fills in one of the subject attributes, not both.
> > Wait, didn't we agree on a a "subj=? subj_selinux=XXX
> > subj_apparmor=YYY subj_smack=ZZZ" format?  It looks like there are two
> > 'subj' fields in the record above which is bad, don't do that please.
>
> That's not something that's coming from the kernel.

Yes it is.  Well, sorta.  With audit *everything* must come from the
kernel in order to meet the security goals that audit tries to
achieve.  I know you already know most of this, but I'm mentioning it
for others who are following along.

The record above is an audit user message which is a message that is
generated in userspace by a trusted process and written to the kernel,
the kernel then generates an audit record based on this message and
inserts it into the audit stream.  The text string that originates
from the userspace process is placed in the "msg" field; the
UID/AUID/subj/etc. information is supplied by the kernel (we don't
want to trust the process any more than absolutely necessary).

On my system, running a random but fairly modern kernel (a 5.7.0-rc5
variant) I see the following for the SYSTEM_BOOT record on my most
recent boot:

  type=SYSTEM_BOOT msg=audit(05/13/2020 14:19:23.983:89) : pid=633
    uid=root auid=unset ses=unset subj=system_u:system_r:init_t:s0
    msg=' comm=systemd-update-utmp
      exe=/usr/lib/systemd/systemd-update-utmp hostname=? addr=?
      terminal=? res=success'

... pay special attention to the single "subj" field ;)

> I'll check again, but I think that everyplace in the kernel that
> produces a subj= has been trained to create a type=1420 record
> instead.
>
> >>> Then we have kernel audit records like this:
> >>>
> >>> type=PROCTITLE msg=audit(1589816791.959:101): proctitle=2F7362696E2F617564697463
> >>> 746C002D52002F6574632F61756469742F61756469742E72756C6573
> >>> type=SYSCALL msg=audit(1589816791.959:101): arch=c000003e syscall=44
> >>> success=yes exit=1056 a0=3 a1=7fff9ccc98a0 a2=420 a3=0 items=0
> >>> ppid=773 pid=783 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0
> >>> egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="auditctl"
> >>> exe="/usr/sbin/auditctl" subj=? key=(null)
> >>> type=UNKNOWN[1420] msg=audit(1589816791.959:101):
> >>> subj_selinux=system_u:system_r:unconfined_service_t:s0
> >>> subj_apparmor==unconfined
> >>> type=CONFIG_CHANGE msg=audit(1589816791.959:101): auid=4294967295
> >>> ses=4294967295 subj=? op=add_rule key=(null) list=1 res=1
> >>> type=UNKNOWN[1420] msg=audit(1589816791.959:101):
> >>> subj_selinux=system_u:system_r:unconfined_service_t:s0
> >>> subj_apparmor==unconfined
> >>>
> >>> where we are getting multiple copies of the new record type, one for
> >>> each record type that had subj=?.
> >> While obviously wasteful, the type=1420 behavior is consistent with
> >> the subj=? behavior, which is to duplicate the subj= value. I know
> >> we've got enough hobgoblins in the audit system that we don't need
> >> to add any more in the name of a foolish consistency.
> > You need to provide a bit more reason why we need byte-for-byte
> > duplicate records in a single event.  As it currently stands this
> > looks like something we definitely don't want.
>
> The CONFIG_CHANGE record already duplicates the subj= information
> in the SYSCALL record.

Yeah, let's not get started on that discussion ;)  Thankfully that
isn't what I was talking about in my earlier comment in this thread.

In the audit event above we see a number of records all part of a
single event (they all share the same timestamp:
"audit(1589816791.959:101)"), and in this single event we see two
identical records of type 1420 (the new record you are proposing).
That is my concern, I would expect just a single type 1420 record to
be added to this event.

For those who may not be familiar with audit, this is what a typical
audit event with a CONFIG_CHANGE record that adds an audit filter rule
looks like with an unpatched kernel:

  type=PROCTITLE msg=audit(05/13/2020 13:55:25.598:10349) :
    proctitle=auditctl -a always,exit -F arch b64 -S bpf
      -k testsuite-1589392525-yPWwmHYp
  type=SYSCALL msg=audit(05/13/2020 13:55:25.598:10349) : arch=x86_64
    syscall=send to success=yes exit=1088 a0=0x4 a1=0x7ffc93b8c910
    a2=0x440 a3=0x0 items=0 ppid=2650 pid=2659 auid=root uid=root
    gid=root euid=root suid=root fsuid=root egid=root sgid=root
    fsgid=root tty=pts0 ses=1 comm=auditctl exe=/usr/sbin/auditctl
    subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
  type=CONFIG_CHANGE msg=audit(05/13/2020 13:55:25.598:10349) : auid=root
    ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
    op=add_rule key=testsuite-1589392525-yPWwmHYp list=exit res=yes

> I just maintained the duplication. You're
> right, it's silly to have two identical type=1420 records for the event.
> I will have to come up with a mechanism to prevent the duplication.
> with luck, there's already a similar case for some other record.

-- 
paul moore
www.paul-moore.com
