Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA1C433DB
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1686764DF4
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352914AbhCCE0h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Mar 2021 23:26:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51442 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348146AbhCCC4m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Mar 2021 21:56:42 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2AF6320B83EA;
        Tue,  2 Mar 2021 18:56:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2AF6320B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614740160;
        bh=LQVbR3Ju8sefFfbWWDkDUAv8pywdDxm2xZQxNKPduyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhdcTdwPawfMyIwq3hmtqPf2MuQCs984dblF3Dbui9dyma3RiSP4KlKkEsmXZ1TuH
         +TEnID7k6UpStwQbAVQXLEFpvZYwSpRBx6DHl7PSXEM9innhXFb1UDEjBH47WhDLNG
         PNcMfYnBmpaZprjkwK3JqJw7tJaRC+OVWq8488Ow=
Date:   Tue, 2 Mar 2021 20:55:58 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: don't log MAC_POLICY_LOAD record on
 failed policy load
Message-ID: <20210303025558.GH6000@sequoia>
References: <20210212185930.130477-1-omosnace@redhat.com>
 <20210212185930.130477-2-omosnace@redhat.com>
 <CAHC9VhQLJKjY0KSC+=f4b=8d8n-m29j_9J5r_VQ_1BpSY8WD2w@mail.gmail.com>
 <CAFqZXNuBYwAT2-vLaTM8_Zng=vh+XsY_EvnzPYM4Z=PoCydZ+A@mail.gmail.com>
 <CAHC9VhSzDVyipy2y8ONiR_Q0YG50FnCJxgHsoi9Nee09hN0WCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSzDVyipy2y8ONiR_Q0YG50FnCJxgHsoi9Nee09hN0WCA@mail.gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-02-28 13:52:52, Paul Moore wrote:
> On Fri, Feb 26, 2021 at 9:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Feb 25, 2021 at 7:15 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Feb 12, 2021 at 1:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > If sel_make_policy_nodes() fails, we should jump to 'out', not 'out1',
> > > > as the latter would incorrectly log an MAC_POLICY_LOAD audit record,
> > > > even though the policy hasn't actually been reloaded. The 'out1' jump
> > > > label now becomes unused and can be removed.
> > > >
> > > > Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  security/selinux/selinuxfs.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > > > index 01a7d50ed39b..340711e3dc9a 100644
> > > > --- a/security/selinux/selinuxfs.c
> > > > +++ b/security/selinux/selinuxfs.c
> > > > @@ -651,14 +651,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
> > > >         length = sel_make_policy_nodes(fsi, newpolicy);
> > > >         if (length) {
> > > >                 selinux_policy_cancel(fsi->state, newpolicy);
> > > > -               goto out1;
> > > > +               goto out;
> > >
> > > This looks good, especially with AUDIT_MAC_POLICY_LOAD recording
> > > "res=1".  However, now that I'm looking at the error path here, we
> > > don't display anything if sel_make_policy_nodes() fails, do we?  If
> > > security_load_policy fails we at least do a printk(), but if this
> > > fails it silently kills the policy load; at the very least I think we
> > > want a `pr_warn_ratelimited("SELinux: failed to load policy due to
> > > selinuxfs failures")` or something similar.
> >
> > There are error messages in some error paths in
> > sel_make_policy_nodes(), but not all. Those are pr_err()s, while in
> > sel_write_load() there is a pr_warn_ratelimited(). Could we just unify
> > the sel_make_policy_nodes() failure to a single message? (I don't
> > think the information on which part has failed is very useful as the
> > most likely cause here is a memory allocation failure, not bad
> > policy.) If so, should it be a pr_warn() or pr_err()? Ratelimited or
> > not?
> 
> My personal opinion is that the kernel only needs to provide the error
> details to userspace which can be useful in determining what wrong,
> and how the user can fix it.  For example, if there is a memory
> allocation failure in the kernel there is often little the user can do
> (and it is often transient anyway due to loading and other factors),
> so simply reporting that there was an allocation failure while
> attempting X is sufficient.
> 
> Beyond that, I think things can get a little fuzzy, e.g. pr_warn() or
> pr_err?  Ratelimit or always emit the message?  I also think the
> answers can change as userspace behaviors change over time.  If one of
> the policy load error paths uses a pr_err() then we should probably
> stick with that; it also seems appropriate as failing to (re)load a
> SELinux policy *is* a serious matter.  As far as the rate limiting is
> concerned, I'm not sure if that is an important difference here; if
> the system is getting enough requests to reload the policy, and
> repeatedly failing, such that the ratelimiting matters there are
> likely other, much larger, issues at play on the system.

I was a little surprised to see pr_warn_ratelimited() (from both the
KERN_WARNING and ratelimited perspectives) used in the policy loading error
path so I poked around a bit. The description of commit 4262fb51c9f5 ("selinux:
log errors when loading new policy") explains the reasoning:

    If the policy fails to be loaded from userspace then a warning message is
    printed, whereas if a failure occurs after loading policy from userspace an
    error message will be printed with details on where policy loading failed
    (recreating one of /classes/, /policy_capabilities/, /booleans/ in the
    SELinux fs).

This seems like sound logic and would result in Ondrej using pr_err() in the
sel_make_policy_nodes() error path.

Tyler

> 
> -- 
> paul moore
> www.paul-moore.com
