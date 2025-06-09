Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D412F37
	for <selinux@vger.kernel.org>; Mon,  9 Jun 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479801; cv=none; b=hCG3KMdSG6As1xjMunLJDtRAb6iBdZUB85aISWT5mQvrfCzYjJGCp+nyBObTt9Y8Rcj9jGNRjy7x3wV12mHgt0m82zyL1OPc9RjQ9nRXFyd3LZbWMtSsTk4sDOxohiJQ8ssKhLM8WcN+42Szc4P5oQtR22ljynozYVUS/Royyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479801; c=relaxed/simple;
	bh=7grurnE0qTjPAouCK8AxwhVUtkrNyD7X8y6Wi1g1A0Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Axnn2iXNRXsDoiQ4ktNYL4iY2QMXoy82Gb9OvEd9OCv429KDRZqneZ5Y92CYxgEx+xG2A1YN8TrXhfQdzShBVq0Y6+JBW29UII/i+IBhU4FHZw5YpWpLyNjXn5qb5Ta9p6a2QjlbOwJexfiJT6jDF6GdI4fs6UGvjfsJeNcoFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=X2jU0fxp; arc=none smtp.client-ip=62.149.158.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="X2jU0fxp"
Received: from [192.168.43.2] ([109.54.140.89])
	by Aruba SMTP with ESMTPSA
	id Odc2uD9wf2QPuOdc3uahkO; Mon, 09 Jun 2025 16:36:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1749479795; bh=7grurnE0qTjPAouCK8AxwhVUtkrNyD7X8y6Wi1g1A0Q=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=X2jU0fxpdYWuVuUXq4QdygXYZsYVO0187HgjUScPuK9k0FJkJnM556zgHktsuh1R6
	 Z2+x5EwsKMdaJgJLtQBmdGrTPrp/D/9Gfp3m2MTTxXHAk8g/p5573C4GnHbw6oZLi9
	 TF45bOv4Atg+Bh0kwvNz4VOQbBYBEOJKpfdb1z2xFZLDs2oFiJfiUz55945Rx/wH0S
	 7nw+RyvU4VmOZ3F7g/5BKuCPU9USs+Q3pXeIZ7id76s+Kdw8r9iqe+87u3U2x27igR
	 aqSbcZsXBXLvjMH9n2P3BYVMmkzS/Jpp7lTMZIClNE9cGTyDLblpWZgHF2G0ahTxbk
	 iDO2eo4G+xqAw==
Message-ID: <1749479794.6137.4.camel@trentalancia.com>
Subject: Re: [PATCH] selinux: fix security context comparison on execve(2)
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek
	 <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Date: Mon, 09 Jun 2025 16:36:34 +0200
In-Reply-To: <CAEjxPJ4YiUQpFNwxhAix3CZnXF9Vkbn5Vbs8_Kp7zDxCoevouQ@mail.gmail.com>
References: <20250609065841.1164578-1-omosnace@redhat.com>
	 <CAEjxPJ4YiUQpFNwxhAix3CZnXF9Vkbn5Vbs8_Kp7zDxCoevouQ@mail.gmail.com>
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPGBcXKisEMhM3geyeVqLdHte9jxUO0kStQO1XWhIa1RTczIsRhOH1gT3nq/xTx1lmmljKbdd7VY1Of6dUUmpduTDD4GujdHzqLl9tPb0VKdcw+vNgAR
 hmUYioAcFpLFcGt//nUp49a3t3Ix8JUgJVKNf6gIBI4abmLydLLulBbGHFm09fzCPnObrv1JW+lyh1H64MepZrDuSb/ZLuMsRXqUBWuMu5ub14Zyc62Sx44P
 ZlpQxAaO4Ir5tjTnzfLRP91sHRM+iZBGRsuPIt4VPlphuEexzHKocL0LjMSS1FQuCdp0dgFUczbgaX4UGVQJGA==

I have created a v2 patch following Stephen's advice. It keeps the boot
process successful on sysvinit with the dracut selinux module enabled.

Can you please check if it also works on other setups ?

The patch has been posted with its original subject + v2 tag added.

[PATCH v2] Only set the initial SID for early-boot userspace tasks if
the policy supports the new capability

Thanks,

Guido

On Mon, 09/06/2025 at 08.45 -0400, Stephen Smalley wrote:
> On Mon, Jun 9, 2025 at 2:58 AM Ondrej Mosnacek <omosnace@redhat.com>
> wrote:
> > 
> > selinux_bprm_creds_for_exec() needs to compare the old and new SIDs
> > to
> > determine if the execve(2) operation is transitioning into a new
> > context
> > (where process { transition } and file { entrypoint } permissions
> > would
> > be checked) or not (file { execute_no_trans } would be checked). It
> > does
> > so by just comparing their numeric values.
> > 
> > However, after ae254858ce07 ("selinux: introduce an initial SID for
> > early boot processes"), we can now easily get into a situation
> > where the
> > SID numbers differ, but the context is the same for both.
> > Specifically
> > when the policy assigns the same context for SECINITSID_KERNEL and
> > SECINITSID_INIT - in this case when a process labeled with
> > SECINITSID_INIT does execve(2) without a transition,
> > security_transition_sid() will translate the unchanged context to
> > the
> > first matching SID number, which is SECINITSID_KERNEL, not
> > SECINITSID_INIT. Thus the kernel thinks that a transition has
> > happened
> > and unexpectedly tests for the file { entrypoint } permission.
> > 
> > Fix this by checking the SID equality more carefully, trying
> > context_equal() on the underlying contexts when it is necessary -
> > in the
> > rare case that the SIDs differ, but both are "initial" SIDs.
> 
> We check for SID equality elsewhere as well, e.g. file_has_perm() and
> selinux_binder_transfer_file(), ioctl_has_perm(), and
> selinux_kernel_load_from_file() to decide whether to check fd use
> permission, selinux_file_permission() to decide whether we need to
> revalidate permissions, selinux_binder_transaction() to decide
> whether
> to check binder impersonate permission, task_avdcache_search() to
> decide whether we can use the avdcache. I'm wondering if we wouldn't
> be better off just ensuring that security_transition_sid() returns
> SECINITSID_INIT when called with SECINITSID_INIT and there is no
> transition defined.
> 
> > 
> > Reported-by: Guido Trentalancia <guido@trentalancia.com>
> > Fixes: ae254858ce07 ("selinux: introduce an initial SID for early
> > boot processes")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/hooks.c            |  2 +-
> >  security/selinux/include/security.h |  2 ++
> >  security/selinux/ss/services.c      | 35
> > +++++++++++++++++++++++++++++
> >  3 files changed, 38 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index b8115df536abd..be95e6e83f1d0 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2369,7 +2369,7 @@ static int selinux_bprm_creds_for_exec(struct
> > linux_binprm *bprm)
> >         ad.type = LSM_AUDIT_DATA_FILE;
> >         ad.u.file = bprm->file;
> > 
> > -       if (new_tsec->sid == old_tsec->sid) {
> > +       if (security_sids_equal(new_tsec->sid, old_tsec->sid)) {
> >                 rc = avc_has_perm(old_tsec->sid, isec->sid,
> >                                   SECCLASS_FILE,
> > FILE__EXECUTE_NO_TRANS, &ad);
> >                 if (rc)
> > diff --git a/security/selinux/include/security.h
> > b/security/selinux/include/security.h
> > index 278c144c22d60..c3ed350718d1d 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -299,6 +299,8 @@ int security_context_to_sid_default(const char
> > *scontext, u32 scontext_len,
> >  int security_context_to_sid_force(const char *scontext, u32
> > scontext_len,
> >                                   u32 *sid);
> > 
> > +bool security_sids_equal(u32 sid1, u32 sid2);
> > +
> >  int security_get_user_sids(u32 fromsid, const char *username, u32
> > **sids, u32 *nel);
> > 
> >  int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
> > diff --git a/security/selinux/ss/services.c
> > b/security/selinux/ss/services.c
> > index 7becf3808818a..297317763f6d4 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1448,6 +1448,41 @@ int security_sid_to_context_inval(u32 sid,
> >                                             scontext_len, 1, 1);
> >  }
> > 
> > +/**
> > + * security_sids_equal - Determine if two SIDs map to the same
> > context.
> > + * @sid1: first SID
> > + * @sid2: second SID
> > + */
> > +bool security_sids_equal(u32 sid1, u32 sid2)
> > +{
> > +       struct context *c1, *c2;
> > +       struct selinux_policy *policy;
> > +       struct sidtab *sidtab;
> > +       bool res;
> > +
> > +       if (!selinux_initialized())
> > +               return sid1 == sid2;
> > +
> > +       if (sid1 == sid2)
> > +               return true;
> > +
> > +       if (sid1 > SECINITSID_NUM || sid2 > SECINITSID_NUM)
> > +               return false;
> > +
> > +       /* Initial SIDs may map to the same context, so do a full
> > comparison */
> > +       rcu_read_lock();
> > +       policy = rcu_dereference(selinux_state.policy);
> > +       sidtab = policy->sidtab;
> > +       c1 = sidtab_search(sidtab, sid1);
> > +       c2 = sidtab_search(sidtab, sid2);
> > +       if (!c1 || !c2)
> > +               res = false;
> > +       else
> > +               res = context_equal(c1, c2);
> > +       rcu_read_unlock();
> > +       return res;
> > +}
> > +
> >  /*
> >   * Caveat:  Mutates scontext.
> >   */
> > --
> > 2.49.0
> > 
