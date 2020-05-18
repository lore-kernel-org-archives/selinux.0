Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B61FC433E0
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 18:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002C320671
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 18:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgvf9FdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgERSCk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 14:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732550AbgERSCj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 14:02:39 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4914C061A0C;
        Mon, 18 May 2020 11:02:38 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d26so8873083otc.7;
        Mon, 18 May 2020 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V96esMl9kY8PDjjxARiIacJ7SwY1HHwKiiG/ZCJEGVA=;
        b=Fgvf9FdKbxaPuugdIADekNGJZqF0csYp+OjW7vuo9X9myIJ6fqTek/Kl74LmwNNpf+
         2429bzkGIQx6y6JFEul1j3rvvJXVvRSnTtrdl3EZnZq5462bLEUTUgMnxuxnwiZLbRv9
         tqHM34j01C8TffrYyaDYIUwdjXwc7oOpHropkFJuKeTEE16RuO8Q5wTj0bsrGpCcmfFF
         HByYn9GkkcuuiusD+cCmgHlcWpblMSl2dQuLvQ27OsTt21H28228EbnYq8otr5RcQMJR
         lbNJMHIxpnwJOrbWAuuxt5+wAYKkXhsff6a+Jh4xpxUD1QRr55czSaHbZucUbdaxqN9+
         994w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V96esMl9kY8PDjjxARiIacJ7SwY1HHwKiiG/ZCJEGVA=;
        b=YqP9EGZtIXULUxk0ANZrCrvEYXoUreYmLSkPDh1xvGOfhDFD7dZf1poEoc1GYIQWqM
         a/Vx2YCsem57j0JnmU548AayNYf6C+52Ef6gRpZFQnOJefQHYnuLljADjHhywecKuIm8
         dlqmJ8AARc4nBmkr5j6yHzcovXT/rDQuZ6wzAAdQMFBCk/N1kk1hsjm8IBGIEJOTPzTp
         TxRat5uSbVCC8hLXlF2dDd4oQpYsAY4Ue00Z5aPAybWc3msJMEZ/enbhBQOqFO1e8an9
         WdXYN166U21t+UL2EM4bdTmQfIrThqpwjBUsIL2+d80wP8lAccZgtCxA8RbxsPHfzxFN
         FopQ==
X-Gm-Message-State: AOAM530L3KvymOus4FVk2z9WrOiSnuFgcioOf/bRt46xA1mneo93gj2a
        Ntj574D1FrwBH4yHxxQ9MoO6bbDA/W41cB1e/sU=
X-Google-Smtp-Source: ABdhPJzYIskN4JjoiUhXsYSRAVez668ir0Cpz2K5pJyR4ES1G2z6OZgaOH8xjQbCK2NX2Q0owFhVd5xdBxkvcCgiSsQ=
X-Received: by 2002:a05:6830:158b:: with SMTP id i11mr3663509otr.135.1589824958083;
 Mon, 18 May 2020 11:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200514221142.11857-1-casey@schaufler-ca.com> <20200514221142.11857-21-casey@schaufler-ca.com>
In-Reply-To: <20200514221142.11857-21-casey@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 18 May 2020 14:02:27 -0400
Message-ID: <CAEjxPJ67cA_A-Oh72EGgmCrP6k9x0PuaU2q7UL9eOc+J6Do0zQ@mail.gmail.com>
Subject: Re: [PATCH v17 20/23] Audit: Add a new record for multiple subject
 LSM attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 7:30 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new audit record type to contain the subject information
> when there are multiple security modules that require such data.
> This record is emitted before the other records for the event, but
> is linked with the same timestamp and serial number.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-audit@redhat.com
> ---

With this patch, I see userspace audit records like this one:

type=SYSTEM_BOOT msg=audit(1589816792.181:103): pid=789 uid=0
auid=4294967295 ses=4294967295 subj=? subj=system_u:system_r:init_t:s0
msg=' comm="systemd-update-utmp"
exe="/usr/lib/systemd/systemd-update-utmp" hostname=? addr=?
terminal=? res=success'

I'm guessing that userspace is appending the second subj= field when
it sees subj=? or otherwise is missing subj= information?

Then we have kernel audit records like this:

type=PROCTITLE msg=audit(1589816791.959:101): proctitle=2F7362696E2F617564697463
746C002D52002F6574632F61756469742F61756469742E72756C6573
type=SYSCALL msg=audit(1589816791.959:101): arch=c000003e syscall=44
success=yes exit=1056 a0=3 a1=7fff9ccc98a0 a2=420 a3=0 items=0
ppid=773 pid=783 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="auditctl"
exe="/usr/sbin/auditctl" subj=? key=(null)
type=UNKNOWN[1420] msg=audit(1589816791.959:101):
subj_selinux=system_u:system_r:unconfined_service_t:s0
subj_apparmor==unconfined
type=CONFIG_CHANGE msg=audit(1589816791.959:101): auid=4294967295
ses=4294967295 subj=? op=add_rule key=(null) list=1 res=1
type=UNKNOWN[1420] msg=audit(1589816791.959:101):
subj_selinux=system_u:system_r:unconfined_service_t:s0
subj_apparmor==unconfined

where we are getting multiple copies of the new record type, one for
each record type that had subj=?.

Not sure what it is the audit folks want here.

This is with multiple LSMs enabled; need to confirm that no change
occurs if only one is enabled.
