Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F5EC433F5
	for <selinux@archiver.kernel.org>; Fri,  7 Oct 2022 15:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJGPWz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGPWy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Oct 2022 11:22:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5782BB0A
        for <selinux@vger.kernel.org>; Fri,  7 Oct 2022 08:22:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so3938510pjl.0
        for <selinux@vger.kernel.org>; Fri, 07 Oct 2022 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygfk3NZcFT3W7ILpimBiMyDlhSwVidfkM9wZGkRwpak=;
        b=lKufXdPkp/yQuA8cV5hHtxgmFXi8rHoe0YSFOdvfo7wfQUZ05uUfnRii/kSUyLnsTQ
         jnmZa/mDWUHkJrY7rcLbw4ln3dqZWiUWzWfciVArElYsDO1A841TUP0yCBcUg0ir2q+B
         8YSls1H0oSRZ4nnu+gfGDhUCK1ZnBwzvgkXzDH/+S0s4Ybb8Vi8GwV9B2VgNZTRUJuzc
         pcuzrboDlLY2trZJaCY2lwO8Zpv1+39PwVpzANCEdsMJgw2e6e6gHAiO1/QHWL6dyggc
         txSL9AuToKZosynRdSzJ2emmtgrzPO1wPyGdx+BbUXlTiLwb3HSAslKGmtWilDGOndGt
         tgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ygfk3NZcFT3W7ILpimBiMyDlhSwVidfkM9wZGkRwpak=;
        b=tlc+C322G7xTo0MKAifsJtlMqhp6UFsimk26P2K+INg/jH6APX7TuZZHOfX4aHixoH
         7DSmjOUCBkccK3KuXFdW0OETDRAFMuaOCocjfrxisxpOOcEaTg2lXmj6jHpZeuwjLMu6
         JvYBzosITa69vTgGy0kUT+5BNaNg0FA5CCcf90aLj8Bp8SZvS/39zd7duEOkHtgnxYaJ
         vX6KfOG86i0+xQjNuW4yh1rdZkLvzG3LPOqpF8h1BuTwjxvaDJ/INGzfxGESi5iQGo93
         Sz7iJzUYWJtEEBT1oogxQ2MPM+WJ2E82VFNR3Gxwfdx4urRAyFrKC1XZ0Ym8gmADEzYD
         9chA==
X-Gm-Message-State: ACrzQf2u/nClE0srzw9CjKcQ1ZQbJwphGuZ+qKQHM4ICv6RVsi3El5AK
        KUvUPmc2sIxnOet+5ipzFQh3FwosWABBLsDr3Kg=
X-Google-Smtp-Source: AMsMyM4WKUMHaZIt6kd+SX+f2gmU93/oXNAYL9NLfjmbipoOAAKynIXN0IC+NjXE2St1Lz4dOqSnOrkFkWFzOcFCCGk=
X-Received: by 2002:a17:902:d4ce:b0:178:1e39:3218 with SMTP id
 o14-20020a170902d4ce00b001781e393218mr5200866plg.144.1665156172033; Fri, 07
 Oct 2022 08:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <87ilkwxbde.fsf@redhat.com> <CAEjxPJ6hQ3-_6_O2LxQPLD14Xzrcs6NfmqLRpe9arbEppU711g@mail.gmail.com>
 <87fsfzyc31.fsf@redhat.com>
In-Reply-To: <87fsfzyc31.fsf@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 7 Oct 2022 11:22:40 -0400
Message-ID: <CAEjxPJ7ysEaFOCsCJQU5p61y3dbkOLKjrRhytsV-HRmjCVHX6A@mail.gmail.com>
Subject: Re: unnecessary log output in selinux_status_updated
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        Mike Palmiotto <mike.palmiotto@crunchydata.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 7, 2022 at 9:53 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Fri, Oct 7, 2022 at 4:54 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >>
> >> Commit 05bdc03130d74 ("libselinux: use kernel status page by default") changed
> >> selinux_status_updated() so that it calls avc_process_policyload() and
> >> avc_process_setenforce() and both functions call avc_log() and avc_log() logs to
> >> stderr by default. So when a process like `rpm` checks whether there was a
> >> change, it gets output on stderr which previously wasn't there.
> >>
> >>
> >> Before this change:
> >> >>> from selinux import *
> >> >>> selinux_status_open(0);
> >> 0
> >> >>>
> >> >>> selinux_status_updated();
> >> 0
> >> >>> selinux_mkload_policy(0);
> >> 0
> >> >>> selinux_status_updated();
> >> 1
> >>
> >> Current version:
> >> >>> from selinux import *
> >> elinux_status_updated();
> >> selinux_mkload_policy(0);
> >> selinux_status_updated();
> >> >>> selinux_status_open(0);
> >> 0
> >> >>> selinux_status_updated();
> >> 0
> >> >>> selinux_mkload_policy(0);
> >> 0
> >> >>> selinux_status_updated();
> >> uavc:  op=load_policy lsm=selinux seqno=2 res=11
> >>
> >>
> >> The calling process could set its callback but it seems unnecessarily
> >> complicated just for selinux_status_updated() which is supposed to check whether
> >> something has changed or not. Also processing events in this function seems to
> >> be unnecessary.
> >>
> >> It looks like the reason for the new code added to selinux_status_updated() is
> >> that there were several avc_netlink_check_nb() calls replaced by
> >> selinux_status_updated(). Given the problem described above, I don't think it's
> >> correct and I would like to change selinux_status_updated() back and use another
> >> mechanism that would help with the replacement.
> >>
> >>
> >> So what do you think about it?
> >
> > The goal was to switch the AVC and all of its users (e.g.
> > selinux_check_access) over to using the much more efficient SELinux
> > kernel status page mechanism for setenforce and policy load
> > notifications on newer kernels instead of the SELinux netlink
> > mechanism (which imposed extra syscall overhead on the critical path).
> >
> > Understand your concern but unsure as to whether we can just change
> > selinux_status_updated() back now.
> > Would require an audit of all users of selinux_status_updated(), both
> > direct and indirect, to ensure that none of them are relying on this
> > behavior. We can obviously fix the callers within libselinux but
> > addressing external callers is more problematic and is arguably an ABI
> > change. Would need to look at all users of the AVC,
> > selinux_check_access(), etc.
> > This change happened 2 years ago so I have to wonder why it is only
> > coming up now?
>
> Nobody has noticed it.
>
>  83         avc_log(SELINUX_POLICYLOAD,
>  84                 "%s:  op=load_policy lsm=selinux seqno=%u res=1",
>  85                 avc_prefix, seqno);
>
> There's missing '\n' and so this message is sooner or later overwritten by
> something else, see
> https://bugzilla.redhat.com/show_bug.cgi?id=2123637 and
> https://bugzilla.redhat.com/show_bug.cgi?id=2123719

Ok, regardless, we need to ensure that changing it won't break
systemd, dbus, or any other userspace object managers.
