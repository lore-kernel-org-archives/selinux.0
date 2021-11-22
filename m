Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03816C433F5
	for <selinux@archiver.kernel.org>; Mon, 22 Nov 2021 23:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhKVX3D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:29:03 -0500
Received: from mail.hallyn.com ([178.63.66.53]:52654 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhKVX3C (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 22 Nov 2021 18:29:02 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 656B9AAB; Mon, 22 Nov 2021 17:25:54 -0600 (CST)
Date:   Mon, 22 Nov 2021 17:25:54 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() ->
 security_current_getsecid_subj()
Message-ID: <20211122232554.GA27944@mail.hallyn.com>
References: <163294304032.208242.9097581875096098591.stgit@olly>
 <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com>
 <CAHC9VhREpJ3bkcU+cOz_Cg7KaF=QokngvXyhCpus--=d8HSP_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhREpJ3bkcU+cOz_Cg7KaF=QokngvXyhCpus--=d8HSP_g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 22, 2021 at 06:12:19PM -0500, Paul Moore wrote:
> On Fri, Nov 19, 2021 at 5:52 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > The security_task_getsecid_subj() LSM hook invites misuse by allowing
> > > callers to specify a task even though the hook is only safe when the
> > > current task is referenced.  Fix this by removing the task_struct
> > > argument to the hook, requiring LSM implementations to use the
> > > current task.  While we are changing the hook declaration we also
> > > rename the function to security_current_getsecid_subj() in an effort
> > > to reinforce that the hook captures the subjective credentials of the
> > > current task and not an arbitrary task on the system.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h         |    3 +--
> > >  include/linux/lsm_hooks.h             |    8 +++-----
> > >  include/linux/security.h              |    4 ++--
> > >  kernel/audit.c                        |    4 ++--
> > >  kernel/auditfilter.c                  |    3 +--
> > >  kernel/auditsc.c                      |   10 +++++++++-
> > >  net/netlabel/netlabel_unlabeled.c     |    2 +-
> > >  net/netlabel/netlabel_user.h          |    2 +-
> > >  security/apparmor/lsm.c               |   13 ++++++++++---
> > >  security/integrity/ima/ima_appraise.c |    2 +-
> > >  security/integrity/ima/ima_main.c     |   14 +++++++-------
> > >  security/security.c                   |    6 +++---
> > >  security/selinux/hooks.c              |   19 +++----------------
> > >  security/smack/smack.h                |   16 ----------------
> > >  security/smack/smack_lsm.c            |    9 ++++-----
> > >  15 files changed, 48 insertions(+), 67 deletions(-)
> >
> > I never saw any comments, positive or negative, on this patch so I'll
> > plan on merging it early next week.  If you've got objections, now is
> > the time to speak up.
> 
> I just merged this patch, with the AppArmor tweak suggested by Serge,
> into selinux/next.  Thanks everyone.

Thanks, Paul.

-serge
