Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A15C433E0
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 22:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA0E20674
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 22:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mdKc5/lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgERWVc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 18:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgERWVc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 18:21:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748ECC061A0C
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 15:21:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so10129072ejd.8
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/khCYfvJEp72aEqdH7BrT4a+JRMptLGYxJW5cDAT0VQ=;
        b=mdKc5/lt6jc7jl65wooikfiSNrnPAVvZK/fgJ6bNdceaZi7ZkmdhmCbkWtpB6a+o9p
         RAbIJWEnrDTAVAeLPIpTWggMMuHQDpWv4BwvDQXF6O8Ndi0ngJYqFnnv/MUCh3KktIi9
         i/SV5uA/CtkiAC+bjU+Y/mZKZ0aDH4cpUSDUl009leMDdXAqhpbfpHfDhPnfcjTXg15w
         y4q16h1tV+FU3UvY13CkXyhdTT4xJg7qtN4f2cqvsnQRYAFAEW2QRe6z8CxNB62orBrM
         m0cIELrUp0fBrlViJIVp2YQulGzYd969VSWGs+dkTGGneVdLpqRbi5SKUSnKrilh1gFu
         78dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/khCYfvJEp72aEqdH7BrT4a+JRMptLGYxJW5cDAT0VQ=;
        b=Lavh++bWePyNgd1TwHbqFzsoIkNwPOizNjzplasJDGcOt9yshdaKY/5ARFe2gscM/Z
         WvnVmrGToPdUns+xavCT/YDdm0W8VPmruXLpQ/qem596o5PCUg2/HHbYncUIbT6vstD0
         TmEkVkHH0oCEOPK6oYd0zk5YiaQ99E8CZS244JGS2ET5xVTTlnGd6sXMy7HSgZX1zy7Z
         q2T3gHNaVETe5N7Q9m0gQDb5NlFjaYj4PpdoEvZqX3pF2kow0Did7/PGkiH5sXG1BBLp
         UJcNGw2pPsBQ8eQXFFb8g8+wrA/X3J7JCf3vR8e03tFfgxPj4wEfnsy+q5YsAB6gZWhI
         b6wg==
X-Gm-Message-State: AOAM533qGUAoigTa+8f71+7kS9AxzDWs0JCWuJKAmNClxLMLRCZpSR4D
        gJKaWcJrcSOQgzc7yH5/jozC6qWmAJV6OzCcfQlY
X-Google-Smtp-Source: ABdhPJxpjFGQF2cDWV2Gc9cYzue2wCv56sWBwoEReBksaoN/La+DH2JVIYX9PtMKTN6q0RRPCdwNZZ45A0QmG28p/dI=
X-Received: by 2002:a17:906:b881:: with SMTP id hb1mr7547072ejb.77.1589840489057;
 Mon, 18 May 2020 15:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200514221142.11857-1-casey@schaufler-ca.com>
 <20200514221142.11857-21-casey@schaufler-ca.com> <CAEjxPJ67cA_A-Oh72EGgmCrP6k9x0PuaU2q7UL9eOc+J6Do0zQ@mail.gmail.com>
 <9cabbb54-69e6-91e6-88f8-e76d53da2a77@schaufler-ca.com>
In-Reply-To: <9cabbb54-69e6-91e6-88f8-e76d53da2a77@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 May 2020 18:21:17 -0400
Message-ID: <CAHC9VhRGopG0=DbEZArz2X2yfEQ1pOqoSLRMn9ABe5JYZB2Y8Q@mail.gmail.com>
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

On Mon, May 18, 2020 at 4:43 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/18/2020 11:02 AM, Stephen Smalley wrote:
> > On Thu, May 14, 2020 at 7:30 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Create a new audit record type to contain the subject information
> >> when there are multiple security modules that require such data.
> >> This record is emitted before the other records for the event, but
> >> is linked with the same timestamp and serial number.
> >>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Cc: linux-audit@redhat.com
> >> ---
> > With this patch, I see userspace audit records like this one:
> >
> > type=SYSTEM_BOOT msg=audit(1589816792.181:103): pid=789 uid=0
> > auid=4294967295 ses=4294967295 subj=? subj=system_u:system_r:init_t:s0
> > msg=' comm="systemd-update-utmp"
> > exe="/usr/lib/systemd/systemd-update-utmp" hostname=? addr=?
> > terminal=? res=success'
> >
> > I'm guessing that userspace is appending the second subj= field when
> > it sees subj=? or otherwise is missing subj= information?
>
> I haven't looked at the userspace code, but I expect you're right.
> It looks like there will need to be some change in the userspace
> for the multiple LSM case. The "completion" shown here isn't correct,
> because it only fills in one of the subject attributes, not both.

Wait, didn't we agree on a a "subj=? subj_selinux=XXX
subj_apparmor=YYY subj_smack=ZZZ" format?  It looks like there are two
'subj' fields in the record above which is bad, don't do that please.

> > Then we have kernel audit records like this:
> >
> > type=PROCTITLE msg=audit(1589816791.959:101): proctitle=2F7362696E2F617564697463
> > 746C002D52002F6574632F61756469742F61756469742E72756C6573
> > type=SYSCALL msg=audit(1589816791.959:101): arch=c000003e syscall=44
> > success=yes exit=1056 a0=3 a1=7fff9ccc98a0 a2=420 a3=0 items=0
> > ppid=773 pid=783 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0
> > egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="auditctl"
> > exe="/usr/sbin/auditctl" subj=? key=(null)
> > type=UNKNOWN[1420] msg=audit(1589816791.959:101):
> > subj_selinux=system_u:system_r:unconfined_service_t:s0
> > subj_apparmor==unconfined
> > type=CONFIG_CHANGE msg=audit(1589816791.959:101): auid=4294967295
> > ses=4294967295 subj=? op=add_rule key=(null) list=1 res=1
> > type=UNKNOWN[1420] msg=audit(1589816791.959:101):
> > subj_selinux=system_u:system_r:unconfined_service_t:s0
> > subj_apparmor==unconfined
> >
> > where we are getting multiple copies of the new record type, one for
> > each record type that had subj=?.
>
> While obviously wasteful, the type=1420 behavior is consistent with
> the subj=? behavior, which is to duplicate the subj= value. I know
> we've got enough hobgoblins in the audit system that we don't need
> to add any more in the name of a foolish consistency.

You need to provide a bit more reason why we need byte-for-byte
duplicate records in a single event.  As it currently stands this
looks like something we definitely don't want.

--
paul moore
www.paul-moore.com
