Return-Path: <SRS0=Q1y4=WJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7D6C32750
	for <selinux@archiver.kernel.org>; Tue, 13 Aug 2019 21:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD95620665
	for <selinux@archiver.kernel.org>; Tue, 13 Aug 2019 21:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfHMV1X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfHMV1X (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 13 Aug 2019 17:27:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9730308FB82;
        Tue, 13 Aug 2019 21:27:21 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-22.phx2.redhat.com [10.3.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 950D31F2;
        Tue, 13 Aug 2019 21:27:13 +0000 (UTC)
Date:   Tue, 13 Aug 2019 17:27:10 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, mortonm@chromium.org,
        john.johansen@canonical.com, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>, luto@amacapital.net,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        Nicholas Franck <nhfran2@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [Non-DoD Source] Re: [RFC PATCH v2] security, capability: pass
 object information to security_capable
Message-ID: <20190813212710.wimxgfunrijqwuqt@madcap2.tricolour.ca>
References: <20190801144313.1014-1-acgoide@tycho.nsa.gov>
 <CAHC9VhTSWiz45vh+M+sgu+ePwgFPZ4Mr8GmRZQjsGWQSzkjbLg@mail.gmail.com>
 <b79617aa-2b40-40bf-9f35-0f5be8e34d3f@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b79617aa-2b40-40bf-9f35-0f5be8e34d3f@tycho.nsa.gov>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 13 Aug 2019 21:27:22 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2019-08-13 11:01, Aaron Goidel wrote:
> On 8/8/19 12:30 PM, Paul Moore wrote:
> > On Thu, Aug 1, 2019 at 10:43 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
> > > From: Nicholas Franck <nhfran2@tycho.nsa.gov>
> > > 
> > > At present security_capable does not pass any object information
> > > and therefore can neither audit the particular object nor take it
> > > into account. Augment the security_capable interface to support
> > > passing supplementary data. Use this facility initially to convey
> > > the inode for capability checks relevant to inodes. This only
> > > addresses capable_wrt_inode_uidgid calls; other capability checks
> > > relevant to inodes will be addressed in subsequent changes. In the
> > > future, this will be further extended to pass object information for
> > > other capability checks such as the target task for CAP_KILL.
> > > 
> > > In SELinux this new information is leveraged here to include the inode
> > > in the audit message. In the future, it could also be used to perform
> > > a per inode capability checks.
> > > 
> > > It would be possible to fold the existing opts argument into this new
> > > supplementary data structure. This was omitted from this change to
> > > minimize changes.
> > > 
> > > Signed-off-by: Nicholas Franck <nhfran2@tycho.nsa.gov>
> > > Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> > > ---
> > > v2:
> > > - Changed order of audit prints so optional information comes second
> > > ---
> > >   include/linux/capability.h             |  7 ++++++
> > >   include/linux/lsm_audit.h              |  5 +++-
> > >   include/linux/lsm_hooks.h              |  3 ++-
> > >   include/linux/security.h               | 23 +++++++++++++-----
> > >   kernel/capability.c                    | 33 ++++++++++++++++++--------
> > >   kernel/seccomp.c                       |  2 +-
> > >   security/apparmor/capability.c         |  8 ++++---
> > >   security/apparmor/include/capability.h |  4 +++-
> > >   security/apparmor/ipc.c                |  2 +-
> > >   security/apparmor/lsm.c                |  5 ++--
> > >   security/apparmor/resource.c           |  2 +-
> > >   security/commoncap.c                   | 11 +++++----
> > >   security/lsm_audit.c                   | 21 ++++++++++++++--
> > >   security/safesetid/lsm.c               |  3 ++-
> > >   security/security.c                    |  5 ++--
> > >   security/selinux/hooks.c               | 20 +++++++++-------
> > >   security/smack/smack_access.c          |  2 +-
> > >   17 files changed, 110 insertions(+), 46 deletions(-)
> > 
> > You should CC the linux-audit list, I've added them on this mail.
> > 
> > I had hoped to see some thought put into the idea of dynamically
> > emitting the proper audit records as I mentioned in the previous patch
> > set, but regardless there are some comments on this code as written
> > ...
> > 
> > > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > > index 33028c098ef3..18cc7c956b69 100644
> > > --- a/security/lsm_audit.c
> > > +++ b/security/lsm_audit.c
> > > @@ -229,9 +229,26 @@ static void dump_common_audit_data(struct audit_buffer *ab,
> > >          case LSM_AUDIT_DATA_IPC:
> > >                  audit_log_format(ab, " key=%d ", a->u.ipc_id);
> > >                  break;
> > > -       case LSM_AUDIT_DATA_CAP:
> > > -               audit_log_format(ab, " capability=%d ", a->u.cap);
> > > +       case LSM_AUDIT_DATA_CAP: {
> > > +               const struct inode *inode;
> > > +
> > > +               audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
> > > +               if (a->u.cap_struct.cad) {
> > > +                       switch (a->u.cap_struct.cad->type) {
> > > +                       case CAP_AUX_DATA_INODE: {
> > > +                               inode = a->u.cap_struct.cad->u.inode;
> > > +
> > > +                               audit_log_format(ab, " dev=");
> > > +                               audit_log_untrustedstring(ab,
> > > +                                       inode->i_sb->s_id);
> > > +                               audit_log_format(ab, " ino=%lu",
> > > +                                       inode->i_ino);
> > > +                               break;
> > > +                       }
> > 
> > Since you are declaring "inode" further up, there doesn't appear to be
> > any need for the CAP_AUX_DATA_INODE braces, please remove them.
> > 
> > The general recommended practice when it comes to "sometimes" fields
> > in an audit record, is to always record them in the record, but use a
> > value of "?" when there is nothing relevant to record.  For example,
> > when *not* recording inode information you would do something like the
> > following:
> > 
> >    audit_log_format(ab, " dev=? ino=?");
> > 
> The issue this brings up is what happens when this is expanded to more
> cases? Assuming there will be a case here for logging audit data for task
> based capabilities (CAP_AUX_DATA_TASK), what do we want to have happen if we
> are recording *neither* inode information nor task information (say a PID)?
> If we log something in the inode case, we presumably don't want to call
> audit_log_format(ab, " dev=?, pid=?") as well. (And vice versa for when we
> log a pid and no inode).

Yup.  This record is already a mess due to that.

The general solution is to either use a new record type for each
variant, or to use an auxiliary record for each additional piece of
information.  The long term solution that has been suggested it to move
away from a text message format.

> > > +                       }
> > > +               }
> > >                  break;
> > > +       }
> > >          case LSM_AUDIT_DATA_PATH: {
> > >                  struct inode *inode;
> 
> Aaron

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
