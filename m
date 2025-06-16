Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D31DB377;
	Mon, 16 Jun 2025 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069877; cv=none; b=NG9caMOpt7PjpiKG63Q+gL7vwvKlJ5UgOw0qYX3pGJERIMGHS2FBLQGOZXC5wZ9lhnD9YTNYG3OlVyPDAbJF0iLFARDJaBA5kmP4mhXl0/SLoR6dmyLoBEOqWlkSHUryfvq9bQnOrUwX+ev4O45CetM+cPUQ1t0nrDZRDlYsgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069877; c=relaxed/simple;
	bh=cixuZ/hQ9DlkrS5H3ssN14pOTHtHki9epgo6a9G0qTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsIyvJhGmDzz0Zj+bUH93M3GgVvlVYSZxfHZ/cwhsLZP8Ect4Dnwr5akUqbX4z0DG7WUaXhUAaeJegOZj8MDd7iBgzIqIepipGigBwqBAJ3Z4/HQ6naIASnT8Ucpf5fvk4sBaITebYtzSBRc/xkMkNbY0UF+JDfZp3Oqdkx578I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgu1jJNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgu1jJNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D96FC4CEEE;
	Mon, 16 Jun 2025 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750069875;
	bh=cixuZ/hQ9DlkrS5H3ssN14pOTHtHki9epgo6a9G0qTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zgu1jJNE6NI5RB2I7yKCVhcDRJDIVy7OjbB5Zf9FQwOzmz77PERs1cLgRQ3jyMBOF
	 lOxvPyqxGaM9EoDzfUYebnommNampECbGRsCKfLln6S6diWMq037yEk+f9Ud2hMegt
	 UFQcseGMStZt2Cbef34g+7jayoUbuEUgcSFIkKORkj9fEBirQ4yjqjuwIkimU/SZp8
	 V5rQrCu0th/F7rCMYdtSieZIbRiQ7Xgj6AlWvlWu2Mazt9bCJ0tAH4T83gLK1SApwT
	 RIdhIkseKLjj14WLka/bsnD5JgFq4Jvf8RhUdic9WQVYsENywJeR6kL+1ukvHOqcLz
	 uQQfYFKTGd5iA==
Date: Mon, 16 Jun 2025 11:31:12 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 27/42] selinux: introduce task_obj_perm()
Message-ID: <20250616103112.GB23708@horms.kernel.org>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
 <20250610172226.1470741-28-stephen.smalley.work@gmail.com>
 <20250613141525.GG414686@horms.kernel.org>
 <CAEjxPJ5cZB1zz3dCUz7ix-WW4P6Q7QaeE02TjcU6zg+SOg8KLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ5cZB1zz3dCUz7ix-WW4P6Q7QaeE02TjcU6zg+SOg8KLA@mail.gmail.com>

On Fri, Jun 13, 2025 at 02:18:54PM -0400, Stephen Smalley wrote:
> On Fri, Jun 13, 2025 at 10:15 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Tue, Jun 10, 2025 at 01:21:58PM -0400, Stephen Smalley wrote:
> > > Introduce task_obj_perm() for namespace-aware permission checking
> > > between two tasks using the objective SID for both tasks and
> > > without assuming that either task is current.
> > >
> > > Convert the permission checks of this form in the hook functions
> > > to use this new helper.
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > ...
> >
> > > +int task_obj_has_perm(const struct task_struct *s,
> > > +                   const struct task_struct *t,
> > > +                   u16 tclass, u32 requested,
> > > +                   struct common_audit_data *ad)
> > > +{
> > > +     const struct cred *cred;
> > > +     const struct task_security_struct *tsec;
> > > +     struct selinux_state *state;
> > > +     u32 ssid;
> > > +     u32 tsid;
> > > +     int rc;
> > > +
> > > +     state = current_selinux_state;
> > > +     rcu_read_lock();
> > > +     tsec = task_security(s);
> > > +     if (tsec)
> > > +             ssid = tsec->sid;
> > > +     else
> > > +             ssid = SECINITSID_UNLABELED;
> >
> > Hi Stephen,
> >
> > Above it is assumed that tsec may be NULL...
> >
> > > +     rcu_read_unlock();
> > > +
> > > +     do {
> > > +             tsid = task_sid_obj_for_state(t, state);
> > > +
> > > +             rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
> > > +             if (rc)
> > > +                     return rc;
> > > +
> > > +             cred = tsec->parent_cred;
> >
> > ... but here tsec is dereferenced without explicitly checking if it is not
> > NULL. I'm wondering if this is safe, e.g. due to the call to avc_has_perm().
> 
> No, you are correct - this is a bug. Thank you, fixed via
> https://github.com/stephensmalley/selinux-kernel/commit/85e72ed549d01a2da407feef6493cbdeca324f82
> and will likely squash into this patch on next submission.

Thanks.

One more thing now that I look at this again.
Does the access to tsec above need to be guarded by rcu_read_lock()?

> 
> >
> > Flagged by Smatch.
> >
> > > +             if (!cred)
> > > +                     break;
> > > +
> > > +             rcu_read_lock();
> > > +             tsec = selinux_cred(cred);
> > > +             ssid = tsec->sid;
> > > +             state = tsec->state;
> > > +             rcu_read_unlock();
> > > +     } while (cred);
> > > +
> > > +     return 0;
> > > +}
> >
> > ...
> 
