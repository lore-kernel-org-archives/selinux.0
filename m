Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741437CD5E
	for <selinux@vger.kernel.org>; Thu, 16 Apr 2026 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329852; cv=none; b=E10ibTNhPfjL7oIyzvRXt/5saKTBQYF3xO55dRT49/SnJlWOuUiJbSAY82ScBgzvuuaarA7rNLOWyKUfVOamnupjD6YAW1p/92NzzehnFnvEei3bz/DYyLWg/sp6QnbesUfz9Z93W6hSqkdcdkqwnCAmOvJc0pC51bx4oNvAcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329852; c=relaxed/simple;
	bh=6Vi7gJvzHAKMNbsTab+2WH5kbTyQdmC5dz9Bv5JvpzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdtkaR5MuGu+WqqL8hcoqlzdYl942GcqPWBrvAUl5c47pbf3h0T9MxI4ZQnCmv3FNirA6485V7NoB1xSBwwtRUIAS4pcbGJx6WRm8ACA/zD7TydF+ycHkoDsSuwxs2Nyrbfw+thHYFv+Uk8IfdHYEQ7Yboe2wkZQbmS9wDxujb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDoFXs6H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDoFXs6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5399FC2BCAF;
	Thu, 16 Apr 2026 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776329851;
	bh=6Vi7gJvzHAKMNbsTab+2WH5kbTyQdmC5dz9Bv5JvpzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDoFXs6HUgegn55n7DdlERiHYZQXkQm1HzgMAWEP7HtYGPCLc6c/EwuSLKCug/84y
	 99jUZEgf1oWxZOxS0uD3EhwcFDN9KNP6vcZ/h8NIZ308ZCZA/rQhVc0DI47ZfrMeup
	 DkXlDvE+3Tsx5Za9oqb3qKF4R3D6RZ+2hoy4CG+jj0Z9oKpsaywDhKw0DtpO2a1e/I
	 XhjkRz8r/xZpKzu3MSfbWzebFeRoZ3EwDL3WXZYrfCbq3eMN78ZMPAgWPLUpCnjrMq
	 aZ6xHafkXAzq+GPaVlPqqXUleVo43OKG7taOGfUlPUUNtpyD/ojsWAgs1j/4cVJnqY
	 7cCO/UbIiBeqg==
Date: Thu, 16 Apr 2026 10:57:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, 
	paul@paul-moore.com, omosnace@redhat.com, mic@digikod.net
Subject: Re: [RFC PATCH] selinux: implement namespace_alloc and
 namespace_install hooks
Message-ID: <20260416-unkultiviert-aufnimmt-0f4df73f7015@brauner>
References: <20260330193100.3603-1-danieldurning.work@gmail.com>
 <CAEjxPJ6eWtRyLpVQ1WvMC=pfddqjmouH+kb-i=sdaHMmAw+A1g@mail.gmail.com>
 <CAEjxPJ4a6=wcUvr=N4rz+P0Qq129tjTrQ00vKB-mZLLYoO-q7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ4a6=wcUvr=N4rz+P0Qq129tjTrQ00vKB-mZLLYoO-q7g@mail.gmail.com>

On Wed, Apr 15, 2026 at 08:04:27AM -0400, Stephen Smalley wrote:
> On Tue, Apr 14, 2026 at 12:54 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Mar 30, 2026 at 3:31 PM <danieldurning.work@gmail.com> wrote:
> > >
> > > From: Daniel Durning <danieldurning.work@gmail.com>
> > >
> > > Add implementations of the namespace_alloc and namespace_install
> > > hooks for SELinux. Corresponding permissions are defined for each
> > > hook (create and setns, respectively), New security classes are
> > > defined for each individual namespace type to allow granularity.
> > >
> > > In namespace_alloc we check the caller's SID against itself. When
> > > a namespace is allocated the SID of the caller is saved in the
> > > namespace security blob. This SID is checked against the caller
> > > in namespace_install. We fall back to SECINITSID_KERNEL if
> > > ns_common is pointing to an init namespace, since these are
> > > created before policy load and will be lacking a security blob.
> > >
> > > Requires Christian Brauner's namespace LSM blob patch and
> > > Mickaël Salaün's LSM namespace audit data patch, which are
> > > the first 2 patches in the series linked below.
> > >
> > > As an additional note, the namespace security blob does not
> > > seem to be freed when a mount namespace is marked as anon
> > > in the kernel. The free_mnt_ns() function only calls
> > > ns_common_free() (which ultimately calls the namespace_free()
> > > hook) if a mount namespace is not marked as anon.
> > > This is causing a memory leak. This issue would need to be
> > > addressed in the original LSM namespace blob patch.
> >
> > Assuming that this gets fixed by the change suggested by Christian
> > Brauner, we can drop this note from the commit message for this one.
> >
> > >
> > > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > > Link: https://lore.kernel.org/all/20260312100444.2609563-3-mic@digikod.net/
> >
> > Otherwise,
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> 
> One aspect of these hooks that I hadn't realized until I exercised the
> tests is that at least for mount namespaces, they are sometimes
> created automatically as part of other operations (e.g. fsmount(2))
> and hence these permission checks are triggered by more than just
> clone/unshare(CLONE_NEWNS). And since mount(8) has been updated to use
> fsmount(2) followed by move_mount(2) internally, these checks are
> applied for "ordinary" mounts even within the current mount namespace.
> Not sure if that is what we want.

I think what you're referring to is anonymous mount namespace creation.
I think it's a benefit that you can hook into this as well. They can be
distinguished from actual mount namespaces by their namespace id which
is fixed.
