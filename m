Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50098C433F5
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 17:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3730F61090
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 17:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbhIWRPj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242621AbhIWRPa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Sep 2021 13:15:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956B9C0613EE
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 10:13:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g8so25649827edt.7
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=moyQHAXFsEWkQTSeR+QwttAi//JsAcJ9MwD7pPn60J0=;
        b=6SuFaPpSttis5h/NPr3G3LiA3lXCFrN3pGb9QxTzu6R0D/0Wuieu5/pZ6Nh40h39X7
         5lw5I/jpCVFd4VZ07B0Htw1/H8GVl7Vc7GK8S1etKIAl2dKczLJyaeSjx8gEuuLYFhCU
         NeEdAxPrhEcycGgTrpkKK2fUG3ayBib2b6SaDoTAbQCiQoBfIh7piANfu32+hc9tLrW7
         bFaiFkvG9imxJWRw0BDqnlKQGjeUykbGOEJUMg134Fuzw1xDZnCZP5LeL35JBi+KXrXd
         YJUdpWs2gOP3UvAXgrJZ7zzZMXWrexQqD4ErmGlIKoBphoeplte1XtScQojjjrJqi2v5
         /oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moyQHAXFsEWkQTSeR+QwttAi//JsAcJ9MwD7pPn60J0=;
        b=OCB6IOM2+CE94z/QHaiypvynhfkCwgaDoqK4IeRVSuE1X6yOV3Smr9wKUfY5VIOy4B
         Hj/6RIUY1jipCWL0koM+Je8MTBJBxJrM3kT08hr9dism1ILwa+6n0hp7r6fZZL5YFmWR
         Vj4DTDplBzwENeuRdH6jY//rX436gjugaQPGQxqCMQKSlvsGdYZLEzYaJ0vJsboSymfV
         YDCKKWg8VcL32vNWUhXReFJX12G5UBSrCMCJPLmOMxTUsE7TJbH8v/2PgPDJ/YmwbSYo
         Gv1h4291uljWc1+34I6WZyyaNV+YXca0sY/xLS1gE/H5Bfh7OPk9fe+QMr/vTcbils0n
         w9mQ==
X-Gm-Message-State: AOAM530fns8TAIzHh55rWf1ONPQcP+hsRhkBzLU97eWoZ037i1wns9Jw
        uF3fr9YqW8+ZFUKuT46kapd9zUk0mm2S7JHhi7ghSjUm9hQy
X-Google-Smtp-Source: ABdhPJypE6DfFR6lPWO/hvONHMTprcqME1sjRRuc+g49CTkuS98ah3V2NClNkyntVi/zIm4svekOxzqpZDd8UlhD6vw=
X-Received: by 2002:a50:e10d:: with SMTP id h13mr6813705edl.77.1632417228001;
 Thu, 23 Sep 2021 10:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
 <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
 <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
 <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com>
 <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com>
 <CAHC9VhTtz_aNY6MOCM6ypbz+SHvS30hx42PWjXJhG1Z=t5jpBw@mail.gmail.com> <CAHk-=wivxthY49NPyPG0QG302dmH_hrioE7NdDKMR1Fus0GHow@mail.gmail.com>
In-Reply-To: <CAHk-=wivxthY49NPyPG0QG302dmH_hrioE7NdDKMR1Fus0GHow@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Sep 2021 13:13:37 -0400
Message-ID: <CAHC9VhSgG9wRJk9pyUnz90Th8MLfJ9LAMsFKyFMZMjK097+ZXw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 23, 2021 at 11:53 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Sep 23, 2021 at 8:43 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > However, we have the LSM framework because there is never one way to
> > solve a problem,
>
> The thing is, the lockdown patches were merged because they were allegedly sane.
>
> As far as I can tell, this is purely a SELinux internal bug.

I'm not sure why that matters, but sure.  There is a problem, we are
working to fix it.

> SELinux did something wrong. Stop doing it.

We *are* trying to fix the problem.  Please stop pretending we are
not.  You can certainly disagree with our approach, but I'm getting
tired of the chastising where you imply we are actively trying to
screw things up or do bad things.  We care about the kernel.  We care
a lot.  I care more than I probably should, and probably more than is
healthy at times.  You can disagree with the design and/or
implementation, but making claims that we are "thinking it's ok for
SELinux to just do bad things." is just plain wrong not to mention
insulting.

> Stop sending patches to
> then screw up the generic security layer, and violate the rules under
> which these patches were accepted.

*Sigh*

There was plenty of discussion about this patch and the previous
drafts, no one was overly upset about adding the caller context/cred
info.  The other LSM folks were okay with it.  We've got plenty of
historical examples of the LSM hook evolving over time to adapt to
LSMs adding new functionality, new LSMs, and new kernel modules.  So
let's look at why you are shouting about "screwing up the generic
security layer", but let's try to keep the focus at the LSM interface
level.

Prior to this patch there was one relevant LSM hook for lockdown:

  int security_locked_down(enum lockdown_reason what);

... the patch in this PR changed it to this:

  int security_locked_down(const struct cred *cred,
                           enum lockdown_reason what);

It's become clear you *really* don't like passing the cred pointer
here, presumably based on a very specific security model for lockdown.
At this point there are two thoughts that spring to mind: 1) how else
can we enable the SELinux model that we want to implement and 2) why
is the LSM forcing a single security model on LSMs for the lockdown
hook?

Let's deal with the first point first.  If you aren't going to merge a
change to the LSM framework that allows for the context credentials,
would you be willing to merge a new LSM hook that is used in place of
the existing lockdown hook for callers that are not associated with a
user task?  Both hooks would take a single lockdown_reason as the only
argument and would look something like this:

  int security_locked_down(enum lockdown_reason what);
  int security_locked_down_kern(enum lockdown_reason what);

There is already precedence in the kernel as a whole for LSM hooks
that exist solely for kernel (non-user tasks) operations so this
wouldn't be a big stretch.  LSMs that don't care to make a distinction
between the two, e.g. the existing lockdown LSM, could set the LSM
hook to point to the same function (in the case of lockdown this would
be lockdown_is_locked_down()).

However, if the above doesn't fly, let's move on to the second thought
I mentioned above: why is the LSM forcing a single security model on
LSMs for the lockdown hook?  If the lockdown functionality is really
going to be restricted to just a single security model, why is it
implemented as a LSM and not as core kernel functionality?  The
original motivation for the LSM was that the kernel needed an
abstraction layer to support multiple security models and we've seen
it do just that over the years; SELinux may have been the first, but
the number has certainly grown over the years and the LSM framework
has evolved right along with it.  Putting restrictions on the LSM
framework so that only specific security models could be implemented
is not something we have really done, and at this point I think it
would be a major mistake.

--
paul moore
www.paul-moore.com
