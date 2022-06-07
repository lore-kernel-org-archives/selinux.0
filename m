Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D3ACCA48B
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 00:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiFHAms (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444024AbiFGXBh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 19:01:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B21E27CD42
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 13:10:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso10062319wmn.4
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PLD8bMvN51Cij4xdm7K//UbBPopjl8IHgVt7TPHocZY=;
        b=i2kaYQ6j5Q8SFA4O5Y3knelSOyr95qvMEWqsg29kMrTB8PQiNOrW1HRsCY0v9REmUA
         MNnKCXpGrmr8D7QexF3moz6L5iuMd8l0FTkbqhLRp9QxBQGVBe5LGE+DngOXpbQ4nww3
         Wqj82xBn8bye0OsYOcmrN7MAU43F5L73GrSpnM9BEnREQ3yUW7+Y4RtVEJvawoK1TVmG
         KDlhsp2EQmehusDg2ubUvtXKe4RhIwrl2QTJWx3/Ak+80wjoOQjkOY4jdj+2Ft54GtSK
         m6l5rpqDgdvNoh0XKRLtkEBAokvaVGkzqAgRX8uGk/gxtUkMhKVTqvkK/W+JyI4JYSJY
         L63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PLD8bMvN51Cij4xdm7K//UbBPopjl8IHgVt7TPHocZY=;
        b=R37y4Gh68xTd/snbdlvwwwJlpv0j9V16yuf4VRLv+obEAVlo61RhVDZ/IvlwWoHRAB
         UPZVwhlFoSBjkA4wmciDWWzijZskT2vIUe0OsZvgktW+o5U+0nZV0Rc8pFjmzAWS/RGy
         CNT5GpLMWN/sAcU/wf4owQPxPAqIpI8G6g9QH/cYJAII6T8WkDp4gFNYDrTSA3P0HE3F
         xkAlV0No1UC2iSyK1jDK9RFDd0W5qLKN59l1eDaxTcak5T2Kh096YcGVw+aE9rXzZWbN
         78m3vEYIA2M8IzEjxRsteSzTuHl66TFTODcMEsMegaFtn1sEG3o0u4rjEhUhhm+2n+1d
         SUqQ==
X-Gm-Message-State: AOAM530SiSBGoYdb+euibkKzxpdN6wq/0qDF6lczZyaIyNJ1xqbhF6Mf
        5d/jugcqW8SE2a13fB2IU/51/GabncxFhsbnrN96
X-Google-Smtp-Source: ABdhPJwyFkl5Wu37OltnZgyQnBX2dD7guis4PxRqva+UdiTXRjPsIzjBlv+N77/IeKSH93JcMAUzMvIjfEltCOeIf0g=
X-Received: by 2002:a05:600c:414e:b0:397:55aa:ccc0 with SMTP id
 h14-20020a05600c414e00b0039755aaccc0mr61318457wmm.51.1654632638942; Tue, 07
 Jun 2022 13:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220125143304.34628-1-cgzones@googlemail.com>
 <CAHC9VhSdGeZ9x-0Hvk9mE=YMXbpk-tC5Ek+uGFGq5U+51qjChw@mail.gmail.com>
 <CAJ2a_DeAUcGTGm_fk8viVbeFXr6FLrJ-oLw-abwFND6Kv0u0gQ@mail.gmail.com>
 <CAHC9VhRRBrLVtvmbJSTZ7fOkD-8AN4iM0WRmeL4ND001d3viJg@mail.gmail.com> <CAJ2a_DeT6AG0jp4gTdsEy7nh=s6cLR7QCsYXAz2+3vsdRKxddg@mail.gmail.com>
In-Reply-To: <CAJ2a_DeT6AG0jp4gTdsEy7nh=s6cLR7QCsYXAz2+3vsdRKxddg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jun 2022 16:10:28 -0400
Message-ID: <CAHC9VhQXdNieG8_uWBfCCFSow6AVaxNBhB3GNU8ea1j5rjgZiA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: create security context for memfd_secret inodes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 2, 2022 at 9:45 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Thu, 17 Feb 2022 at 23:32, Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Feb 17, 2022 at 9:24 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > > On Thu, 27 Jan 2022 at 00:01, Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, Jan 25, 2022 at 9:33 AM Christian G=C3=B6ttsche
> > > > <cgzones@googlemail.com> wrote:
> > > > >
> > > > > Create a security context for the inodes created by memfd_secret(=
2) via
> > > > > the LSM hook inode_init_security_anon to allow a fine grained con=
trol.
> > > > > As secret memory areas can affect hibernation and have a global s=
hared
> > > > > limit access control might be desirable.
> > > > >
> > > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > > ---
> > > > > An alternative way of checking memfd_secret(2) is to create a new=
 LSM
> > > > > hook and e.g. for SELinux check via a new process class permissio=
n.
> > > > > ---
> > > > >  mm/secretmem.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > >
> > > > This seems reasonable to me, and I like the idea of labeling the an=
on
> > > > inode as opposed to creating a new set of LSM hooks.  If we want to
> > > > apply access control policy to the memfd_secret() fds we are going =
to
> > > > need to attach some sort of LSM state to the inode, we might as wel=
l
> > > > use the mechanism we already have instead of inventing another one.
> > >
> > > Any further comments (on design or implementation)?
> > >
> > > Should I resend a non-rfc?
> >
> > I personally would really like to see a selinux-testsuite for this so
> > that we can verify it works not just now but in the future too.  I
> > think having a test would also help demonstrate the usefulness of the
> > additional LSM controls.
> >
>
> Any comments (especially from the mm people)?
>
> Draft SELinux testsuite patch:
> https://github.com/SELinuxProject/selinux-testsuite/pull/80
>
> > > One naming question:
> > > Should the anonymous inode class be named "[secretmem]", like
> > > "[userfaultfd]", or "[secret_mem]" similar to "[io_uring]"?
> >
> > The pr_fmt() string in mm/secretmem.c uses "secretmem" so I would
> > suggest sticking with "[secretmem]", although that is question best
> > answered by the secretmem maintainer.

I think this patchset has been posted for long enough with no
comments, and no objections, that I can pull this into the
selinux/next tree.  However, I'll give it until the end of this week
just to give folks one last chance to comment.  If I don't hear any
objections by the end of day on Friday, June 10th I'll go ahead and
merge this.

--=20
paul-moore.com
