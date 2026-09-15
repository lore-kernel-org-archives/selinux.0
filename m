Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA283B9D84
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477288; cv=none; b=e2qgg5VmyVVQPOf8lrjZQ+IttZcl4pPWwxmYcdXk58wRwCaqsG8OuAHiUDf0qWlVVH8pVae0g0BsvgxUbK4MZISJpBW9vLcbV3LFK7okRdtaGDPVotwVMOU5CEnyfNKOANlvWjaRg0TC7U3kklEgvmvkNgtznICrjOJuCcCiMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477288; c=relaxed/simple;
	bh=u9EMmW4d80T4kgzc00ZHqoMm6AtQoGvSZp9Up4pL338=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRJN5Eg+lmjzYavnITxeGhwOfqkEQfo5uONtrFGZ4aOgnlHF0nZjL0dLEOrY0Z9ZNEkhRP0vjP+BIRg8oHuZsJtc6r3wZv/3f0V+KyyehAs//srOFF7lkUaJNU3psUMCEXM/KebN4FQdhL7XwSoxrixjtATcD8L1iDakp0/K62c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikHSxzce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikHSxzce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C4B1F00893;
	Tue, 15 Sep 2026 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789477286;
	bh=r602xYTlG7onBkcXCwIL5OBfxAtV8Uv4SxMrZfgmbHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ikHSxzcepd1QLqKzCnHb4eptOcajDHq23EuCSi1lDU6ZsjfPoFl/gVELJSh+H9C1m
	 R7wiM/jzbmD4uAWQ+1zPi+RekkDVAq+/f0WllSuy88WGbppxbuqD47ctbN3dgZ7sr7
	 FO1ub0Tj2ja07odVs5FPTdf3eCK7xiB2ijYL5cyGVYc36xXI20tjMIz3qGGl5/mtl5
	 WtsikwAAIMsSOVAhGLEb8RKKeXg+g9GhIfiUbrwP6boKnzHLgICIETP6uB0vhzQNDh
	 GI58ojESOmJcupz5IWMQEmjB1tjZ1VotygAIhH6NQGnIn3XJ8hkRVMeh4bguUBQfj7
	 +6hn/7HAJ3SUg==
Date: Tue, 15 Sep 2026 15:01:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, omosnacek@gmail.com, ljs@kernel.org, 
	jannh@google.com, cgzones@googlemail.com
Subject: Re: [PATCH v3] selinux: mark status and policy inodes as immutable,
 drop status mmap write checks
Message-ID: <20260915-reitz-anklagen-resolut-7a034824c91d@brauner>
References: <20260911163734.22981-2-stephen.smalley.work@gmail.com>
 <CAHC9VhS-TiBkOZWR7xgCrPnpxozjzM+y5vpgbPU9=R_C3Ta2WQ@mail.gmail.com>
 <j4p63tm4s6ipdlphfo7u4zg7dirgp2o2wfsxvicbdxwwdkxfit@6lyk76wfnysl>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <j4p63tm4s6ipdlphfo7u4zg7dirgp2o2wfsxvicbdxwwdkxfit@6lyk76wfnysl>

On Tue, Sep 15, 2026 at 11:15:43AM +0200, Jan Kara wrote:
> On Mon 14-09-26 17:17:39, Paul Moore wrote:
> > On Fri, Sep 11, 2026 at 12:38 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > The selinuxfs "status" and "policy" files are read-only interfaces
> > > that are also mmap'd by userspace. They are created 0444 by
> > > simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
> > > O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.
> > >
> > > Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
> > > tests IS_IMMUTABLE before the DAC / capability checks, so all of the
> > > above are rejected at the VFS layer without ever reaching the file
> > > operations. Since a writable file can no longer exist, do_mmap() clear
> > > VM_MAYWRITE for MAP_SHARED mappings on its own, and the
> > > sel_mmap_handle_status() write/mprotect guards are dead; drop them.
> > > MAP_PRIVATE writable mappings become permitted (they were previously
> > > -EPERM) and CoW harmlessly to a private page, matching how
> > > sel_mmap_policy() has always treated the private case.
> > >
> > > The sel_mmap_policy() VM_SHARED guard becomes redundant for the same
> > > reason; leave dropping it to the pending "selinux: reject writable
> > > opens of policy file, drop mmap shared/write check" patch so that the
> > > patches do not conflict.
> > >
> > > Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> > > cc: ljs@kernel.org
> > > cc: jannh@google.com
> > > cc: jack@suse.cz
> > > cc: cgzones@googlemail.com
> > > cc: brauner@kernel.org
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > v3 implements Jan's suggestion to mark the inodes immutable rather than
> > > implementing open-time checks.
> > >
> > >  security/selinux/selinuxfs.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > I'm mildly concerned about marking these files as immutable when
> > neither of them is actually immutable.  Yes, userspace shouldn't be
> > able to write to either, but the contents of these files *do* change.
> > While it doesn't look S_IMMUTABLE should currently pose any real
> > problems, I do worry about the future and an innocent looking VFS
> > change causing problems with one of these files because it was assumed
> > the contents of a S_IMMUTABLE file wouldn't change.
> 
> S_IMMUTABLE bit is about permission checks. I have hard time imagining
> some VFS code would do some assumptions regarding data based on that. But
> maybe my imagination is just lacking :).

Said code would be rather buggy...
