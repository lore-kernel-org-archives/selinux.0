Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703E2C433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE5B22B4B
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="j6396XlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgH0Oti (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgH0N6U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 09:58:20 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0955C06123E
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 06:57:47 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q4so5022068eds.3
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 06:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNTIDmlX0DR1QA3OnP5TJjnDfZKAtrEuFqc1gc/HksA=;
        b=j6396XlPr9+O3RiDZkU8gxEdslMFazLq9328ZrkkI53onf7TEdgbtSyc0PUPzwuBEb
         4IiRufk5oau/cF4qa5Y1Myq7S7SDAbU6X7jRq3GLYEln78/na+VsvDrl+axx4l9adhYb
         r6jJ1buLop3OVlTIjdFH/+VpFDtSJPRs7r5gxpsxTJohHyGkunUpnTL9qrFwB8Sr1Vz5
         jOCrQux/ntf8l/teeZ88nqMXXYzb6iDWcVGa2vevrBLrOkr6WC0e5KNcjab7G96ATzf0
         6+TV5LBUbzWt55yTUYG5QUtCyBtfvbEyBhK6p4T/q1U4+aIC/DsLcZf9i6EC3G/avq8X
         T5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNTIDmlX0DR1QA3OnP5TJjnDfZKAtrEuFqc1gc/HksA=;
        b=s+q9EB2I559/6puhJsQ/f/YpyyAml4A66swrmlcYQXN1LoRK1pdpaxaTQZz6KbbKjo
         qmLjJ4h+Rwm3NX/G4bffriwDIdwXbygRVsVKC3yJDBfm6SHpYw0XQj+mXPPL5pM45Z7I
         vZu6VR1UyCgV3JZRzjX/DIveu5xTvyH5cNdZijM5OCHgXLUeva1AoCUpiP5DQyLkKYb7
         bP22utW3xR9WOdR6CnNJugg4Y6qDMbfMUNCQ+2F8tbJMbnNPdD75KA3sR8on8aFWW1yP
         J3i8FQD+VduB3jj9CHZB+9KVK6lwK9kI2eYEjQ1wShkAzhyrb6fcFvOTcgcfxwkL7aD7
         En0g==
X-Gm-Message-State: AOAM5316EDUH/gD7JTpoa5SDc8Ijb0WgCi+Qdxt2ZoDv9/wyEo7FNhqi
        4PV6H3vKg406M58AMSFGeKhzfGsJHrFa+MWKCMSv5CXHRw==
X-Google-Smtp-Source: ABdhPJxNjUE9kDbi/KC1AGooEqxF/sZdyJkPTTxImSrGgQLJay93z+4k7vBPHnR+sWE2UlxIaNP8y31/QsSqV7DQUVM=
X-Received: by 2002:a50:d809:: with SMTP id o9mr19349616edj.12.1598536666287;
 Thu, 27 Aug 2020 06:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200826135906.1912186-1-omosnace@redhat.com> <20200826135906.1912186-2-omosnace@redhat.com>
 <CAEjxPJ4LL022dtKyqs+YB-gKVuJqRNQu0dafjgzZLqStqn-zSA@mail.gmail.com> <CAHC9VhTOTuscseVrLEj17y2ULG9rWjLrxT+PorakT8EGk4dhTA@mail.gmail.com>
In-Reply-To: <CAHC9VhTOTuscseVrLEj17y2ULG9rWjLrxT+PorakT8EGk4dhTA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Aug 2020 09:57:35 -0400
Message-ID: <CAHC9VhQxmtT33u5jootPf1PZEbqWXzP_phSC_ejgmUb-44uXGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: simplify away security_policydb_len()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 27, 2020 at 9:56 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Aug 26, 2020 at 10:05 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Aug 26, 2020 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Remove the security_policydb_len() calls from sel_open_policy() and
> > > instead update the inode size from the size returned from
> > > security_read_policy().
> > >
> > > Since after this change security_policydb_len() is only called from
> > > security_load_policy(), remove it entirely and just open-code it there.
> > >
> > > Also, since security_load_policy() is always called with fsi->mutex
> > > held, make it dereference the policy pointer directly and drop the
> > > unnecessary RCU locking.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > One comment below but nonetheless:
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > > index 8381614627569..7cc2f7486c18f 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -3912,11 +3896,17 @@ int security_read_policy(struct selinux_state *state,
> > >         int rc;
> > >         struct policy_file fp;
> > >
> > > -       if (!selinux_initialized(state))
> > > +       /*
> > > +        * NOTE: We do not need to take the rcu read lock
> > > +        * around the code below because other policy-modifying
> > > +        * operations are already excluded by selinuxfs via
> > > +        * fsi->mutex.
> > > +        */
> > > +       policy = rcu_dereference_check(state->policy, 1);
> > > +       if (!policy)
> > >                 return -EINVAL;
> >
> > If/when my patch to move the mutex to selinux_state and use it in
> > rcu_dereference_protected() lands, we'll want to change this one over
> > too.
>
> FWIW, I felt the mutex move was more significant than this patchset so
> I merged it first.  Ondrej, would you mind rebasing this patch and
> making the changes above?

Oh, just in case it wasn't clear from my comments above, I think this
patch is fine :)

-- 
paul moore
www.paul-moore.com
