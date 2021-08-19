Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C65C4338F
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 00:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0CE60F57
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 00:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhHSAsR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Aug 2021 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbhHSAsR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Aug 2021 20:48:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3346C0613CF
        for <selinux@vger.kernel.org>; Wed, 18 Aug 2021 17:47:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gt38so8843299ejc.13
        for <selinux@vger.kernel.org>; Wed, 18 Aug 2021 17:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3118yHZBGo6DRzRXBqG3ftlGaa+KyJKRgYLmI/eYAI=;
        b=ODY/2RDrQWGsGpgT+Y2j7ZtLc8aOfrKuoS37Pp/TOPHfExYYe//wDgXm5uZEFPpNcE
         blOCp9cFdhz+h+xkHnF2WqBNLkRcASpltA6eapWAtov8YirRNCm01ODgKigeNrjcuqKL
         VZ3gvxXqcTLbziY64RDiO9PUXO8XM/rodECa1RBRIY3Qj8nUD7kUPo2tVHXtbKlqeeQB
         3plvVKmJDK2Hc9OGSjyld8qr91VZVtR+F2F8B1jX1hJqGfx8eBDUREYZhWIMjOSrN4md
         gAwo6QppkjT6UIU1WRoLqE4cdXjATrPzYEkC9vky3/aQ/d90PeUyEx1cM1eajc3rQy3M
         TvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3118yHZBGo6DRzRXBqG3ftlGaa+KyJKRgYLmI/eYAI=;
        b=Yxb8l2B2Juvs1E5mbecMZ86aZ5tzx/Y/Uo+sBHVyGzfR57pcuOnexewHtir8l1s9Ok
         LP3wrxXu77fFsc/IvegZBumO50JFkT7XIQVC2rYMMPEk65HaSJkwlxdW+pekKLFvXCpp
         kU00LyKmeEmfXnL6a6ZrjJYwitumqKmbDAs1eTFEuANOmtiC5hsiURMoLrCQU6ho26LY
         hi593FkvjdZH7XSNi5aTxJKAdErPAn+iLMuwtWXfGLVvYnG9kufWKlRKYXf1Qb+XgtXw
         ZefAfcsPfj5ZPx7VxYA8E4qC9n170XD1M47tMDJCWiRJw2CR6dQBLjqRxsUZ6RgvCFeT
         92iA==
X-Gm-Message-State: AOAM533d6/EVewZjj6l9joi2ee8pJLrjI0PhPng84mgjvxojdTncdHvP
        FxcbAqB+Cn9tzcdlsxd7FOLjZMIKc/m4jNFuRamQ
X-Google-Smtp-Source: ABdhPJxUhG6RMHG8hWBMBx9UdS8uXzdLCCmnu/rsRxmxhGzDLA3tVGwIkTsYw0JMOGWrJ57On2kUIZFxTiG1hRC+Pv4=
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr12347619ejd.488.1629334060204;
 Wed, 18 Aug 2021 17:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210722004758.12371-1-casey@schaufler-ca.com>
 <20210722004758.12371-23-casey@schaufler-ca.com> <CAHC9VhTj2OJ7E6+iSBLNZaiPK-16UY0zSFJikpz+teef3JOosg@mail.gmail.com>
 <ace9d273-3560-3631-33fa-7421a165b038@schaufler-ca.com> <CAHC9VhSSASAL1mVwDo1VS3HcEF7Yb3LTTaoajEtq1HsA-8R+xQ@mail.gmail.com>
 <fba1a123-d6e5-dcb0-3d49-f60b26f65b29@schaufler-ca.com> <CAHC9VhQxG+LXxgtczhH=yVdeh9mTO+Xhe=TeQ4eihjtkQ2=3Fw@mail.gmail.com>
 <3ebad75f-1887-bb31-db23-353bfc9c0b4a@schaufler-ca.com> <CAHC9VhQCN2_MsCoXfU7Z-syYHj2o8HaSECf5E62ZFcNZd9_4QA@mail.gmail.com>
 <062ba5f9-e4e8-31f4-7815-826f44b35654@schaufler-ca.com>
In-Reply-To: <062ba5f9-e4e8-31f4-7815-826f44b35654@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Aug 2021 20:47:29 -0400
Message-ID: <CAHC9VhT=QL5pKekaPB-=LDzU3hck9nXDiL5n1-upSqPg3gq=7w@mail.gmail.com>
Subject: Re: [PATCH v28 22/25] Audit: Add record for multiple process LSM attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 18, 2021 at 5:59 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 8/16/2021 11:57 AM, Paul Moore wrote:
> > On Fri, Aug 13, 2021 at 5:47 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 8/13/2021 1:43 PM, Paul Moore wrote:
> ...
> > Yeah, the thought occurred to me, but we are clearly already in the
> > maybe-the-assumptions-are-wrong stage so I'm not going to rely on that
> > being 100%.  We definitely need to track this down before we start
> > making to many more guesses about what is working and what is not.
>
> I've been tracking down where the audit context isn't set where
> we'd expect it to be, I've identified 5 cases:
>
>         1000    AUDIT_GET               - Get Status
>         1001    AUDIT_SET               - Set status enable/disable/auditd
>         1010    AUDIT_SIGNAL_INFO
>         1130    AUDIT_SERVICE_START
>         1131    AUDIT_SEVICE_STOP
>
> These are all events that relate to the audit system itself.
> It seems plausible that these really aren't syscalls and hence
> shouldn't be expected to have an audit_context. I will create a
> patch that treats these as the special cases I believe them to be.

Yes, all but two of these could be considered to be audit subsystem
control messages, but AUDIT_SERVICE_{START,STOP} I think definitely
fall outside the audit subsystem control message category.  The
AUDIT_SERVICE_{START,STOP} records are used to indicate when a
service, e.g. NetworkManager, starts and stops; on my fedora test
system they are generated by systemd since it manages service state on
that system; a quick example is below, but I'm sure you've seen plenty
of these already.

% ausearch -m SERVICE_START
time->Wed Aug 18 20:13:00 2021
type=SERVICE_START msg=audit(1629331980.779:1186): pid=1 uid=0 auid=4294967295 s
es=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=NetworkManager-dispatch
er comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? re
s=success'

However, regardless of if the message is related to controlling the
audit subsystem or not, we do want to be able to associate those
records with other related records, e.g. SYSCALL records.  Looking at
the message types you listed above, they are all records that are
triggered by userspace via netlink messages; if you haven't already I
would start poking along that code path to see if something looks
awry.

I just spent a few minutes tracing the code paths up from audit
through netlink and then through the socket layer and I'm not seeing
anything obvious where the path differs from any other syscall;
current->audit_context *should* be valid just like any other syscall.
However, I do have to ask, are you only seeing these audit records
with a current->audit_context equal to NULL during early boot?

-- 
paul moore
www.paul-moore.com
