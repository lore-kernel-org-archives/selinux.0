Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C95C4338F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A0661214
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 14:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbhHXOqN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbhHXOqM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Aug 2021 10:46:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEE9C061757
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 07:45:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d6so32165475edt.7
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGYM+nSaUU+WoSwLMVnhosx4OKbywoUeevoN8omCjXI=;
        b=BxvjgvjbNilMABkl9WxzYlGQBlwXr04YXhsknOLaZtW6pJJWKhlCcsrKeXlX6fSSJA
         HmnzGLbBoN/mUhddbrF9ZyTKg3IIvRk/dM48HAHMvuubC6hYB6ZCivpS6gg8ZGbfmJzH
         kkv+V+3OZFj+AaKbrw5eJlufVExXMoBcfsf0TD/f6SZjjStYa2l5HQM2kkNcjOwb+Ydu
         vTBYWEtk2e2lsVq33id7zV8IYdrMZmAFtz3fokDHsvA5l/0PnXgHfhPD2TAqCYukDr0k
         1LDUhlyIjBfvrI8u8uHGVbj29n6den5MbS14s3q44VaQzjyR7HdfjkyYzwBJuiNtSA4R
         vqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGYM+nSaUU+WoSwLMVnhosx4OKbywoUeevoN8omCjXI=;
        b=OETkSdynfP8RlSeXDYdOiOb3GSw8TAxbelobbCVHw9m9kowrv5EkJMMgMB2St1GAzs
         GLKQjOxs90kgOrve9APHUct0dkWm9kgO0Uv1IzgRE6IY1YRCR6oel/GTl4wUDOtKk91U
         DJjI8VLovDlbr6xZiOo3EFTGJu1V5c5/rjyLVdraG14EHsKfH0LY9pNgoMUBRe7KfFaO
         7RX6G+H5qgxOROLQx2ZNH1ewENagv7Slpozr/b5W5SuXdkDT/ZPFvy+s5Ts3Qx2dnFQj
         asmu+TGsxKXsosRcj4xj112pi4rY7Sah+xyi3aUneOO+kTRG9pJ4tbR4eMBBjtjzVXVx
         82qA==
X-Gm-Message-State: AOAM531DQ7IYPGz5fHoMxUQvc+1k0Kpmnp1OhMUzh+yv/+SiCtySv5Iq
        4CcafFDsc6JGRfG/YhgzrloCM1zAceCYyjT3oDnwj+Lipw==
X-Google-Smtp-Source: ABdhPJzUQNFZ76OJidu5ZnOAPqidwPTAgucoSeldGoH3rBmrNnTDQK/YtmgsG9PpDDQGvmE36qPj2R6wKLqMgCCH3ZY=
X-Received: by 2002:a05:6402:1246:: with SMTP id l6mr43168604edw.12.1629816326536;
 Tue, 24 Aug 2021 07:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210722004758.12371-1-casey@schaufler-ca.com>
 <20210722004758.12371-23-casey@schaufler-ca.com> <CAHC9VhTj2OJ7E6+iSBLNZaiPK-16UY0zSFJikpz+teef3JOosg@mail.gmail.com>
 <ace9d273-3560-3631-33fa-7421a165b038@schaufler-ca.com> <CAHC9VhSSASAL1mVwDo1VS3HcEF7Yb3LTTaoajEtq1HsA-8R+xQ@mail.gmail.com>
 <fba1a123-d6e5-dcb0-3d49-f60b26f65b29@schaufler-ca.com> <CAHC9VhQxG+LXxgtczhH=yVdeh9mTO+Xhe=TeQ4eihjtkQ2=3Fw@mail.gmail.com>
 <3ebad75f-1887-bb31-db23-353bfc9c0b4a@schaufler-ca.com> <CAHC9VhQCN2_MsCoXfU7Z-syYHj2o8HaSECf5E62ZFcNZd9_4QA@mail.gmail.com>
 <062ba5f9-e4e8-31f4-7815-826f44b35654@schaufler-ca.com> <CAHC9VhT=QL5pKekaPB-=LDzU3hck9nXDiL5n1-upSqPg3gq=7w@mail.gmail.com>
 <f3137410-185a-3012-1e38-e05a175495cc@schaufler-ca.com> <6f219a4d-8686-e35a-6801-eb66f98c8032@schaufler-ca.com>
 <CAHC9VhSsJoEc=EDkUCrHr5Uid9DhsoininpvPVt+Ab6RsqieOQ@mail.gmail.com>
 <93d97b1e-d3ea-0fe0-f0c2-62db09d01889@schaufler-ca.com> <be20e3c8-a068-4aa2-be52-8601cf2d30a6@schaufler-ca.com>
In-Reply-To: <be20e3c8-a068-4aa2-be52-8601cf2d30a6@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Aug 2021 10:45:15 -0400
Message-ID: <CAHC9VhT-MfsU-azbV4QQ-asQFqdCG8fAeB-BOV3MKAdtSOW8Nw@mail.gmail.com>
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

On Fri, Aug 20, 2021 at 7:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 8/20/2021 12:06 PM, Paul Moore wrote:
> >> Unless you explicitly enable audit on the kernel cmdline, e.g.
> >> "audit=1", processes started before userspace enables audit will not
> >> have a properly allocated audit_context; see the "if
> >> (likely(!audit_ever_enabled))" check at the top of audit_alloc() for
> >> the reason why.
>
> I found a hack-around that no one will like. I changed that check to be
>
> (likely(!audit_ever_enabled) && !lsm_multiple_contexts())
>
> It probably introduces a memory leak and/or performance degradation,
> but it has the desired affect.

I can't speak for everyone, but I know I don't like that as a solution
;)  I imagine such a change would also draw the ire of the never-audit
crowd and the distros themselves.  However, I understand the need to
just get *something* in place so you can continue to test/develop;
it's fine to keep that for now, but I'm going to be very disappointed
if that line finds its way into the next posted patchset revision.

I'm very much open to ideas but my gut feeling is that the end
solution is going to be changes to audit_log_start() and
audit_log_end().  In my mind the primary reason for this hunch is that
support for multiple LSMs[*] needs to be transparent to the various
callers in the kernel; this means the existing audit pattern of ...

  audit_log_start(...);
  audit_log_format(...);
  audit_log_end(...);

... should be preserved and be unchanged from what it is now.  We've
already talked in some general terms about what such changes might
look like, but to summarize the previous discussions, I think we would
need to think about the following things:

* Adding a timestamp/serial field to the audit_buffer struct, it could
even be in a union with the audit_context pointer as we would never
need both at the same time: if the audit_context ptr is non-NULL you
use that, otherwise you use the timestamp.  The audit_buffer timestamp
would not eliminate the need for the timestamp info in the
audit_context struct for what I hope are obvious reasons.

* Additional logic in audit_log_end() to generate additional ancillary
records for LSM labels.  This will likely mean storing the message
"type" passed to audit_log_start() in the audit_record struct and
using that information in audit_log_end() to decide if a LSM ancillary
record is needed.  Logistically this would likely mean converting the
existing audit_log_end() function into a static/private
__audit_log_end() and converting audit_log_end() into something like
this:

  void audit_log_end(ab)
  {
    __audit_log_end(ab); // rm the ab cleanup from __audit_log_end
    if (ab->anc_mlsm) {
      // generate the multiple lsm record
    }
    audit_buffer_free(ab);
  }

* Something else that I'm surely forgetting :)

At the end of all this we may find that the "local" audit_context
concept is no longer needed.  It was originally created to deal with
grouping ancillary records with non-syscall records into a single
event; while what we are talking about above is different, I believe
that our likely solution will also work to solve the original "local"
audit_context use case as well.  We'll have to see how this goes.

[*] I expect that the audit container ID work will have similar issues
and need a similar solution, I'm surprised it hasn't come up yet.

-- 
paul moore
www.paul-moore.com
