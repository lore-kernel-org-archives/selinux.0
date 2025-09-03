Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA9275B12
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903809; cv=none; b=CtD9phex0xglpExDX1fmbxH2R9k0wWrV9SmoPKtxcxy3EfooM4wnmeQR9abLxtjdX54mgZgHRMLF2Sn/ugL7rv/Erz5g+GCB39X2jD+EhxzIyIco+DH5V3OHl6TLUq5u5tWAaHICC81dcUlLismb4NT1gosMhMuPwIFGvjj86+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903809; c=relaxed/simple;
	bh=R/4v6xOtVysSjhZsWLTZuA5spdI96uL+tKyB5nJ5uCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1KXI2x/PByESOQhpSpuBzXoRGKXIvA/fbYu+VEe+NFTM9daZbnHi42a1H4LXhd2IH6beKucsGeNFHLPuIWo6H+VTkQYddD4khAD0WJmT+QkQkRsXOdCqw+PZvhpOW/GVI7qli6+vcR7GXisYWbbLR13rRFTsgv+EdlzcCqf9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA0LeXHR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA0LeXHR"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4717543ed9so4105033a12.3
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756903807; x=1757508607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm41AWfuWUPDSnKfrBo+/YKznTzPGF4qpgJqGRZ59f0=;
        b=SA0LeXHRgOUlndTfZb6sywG/rBiVWWPfcAO85n9l6xe1SGqGi3L/+X2MaWf0cygyS1
         FHV8Jm5q/8YhWLEABM0Mxk3w8WoWl+7NOO2JEU6sTejDElBLIvcyHOmal2F8NW0yad8q
         Z0dJVk+BkROJ3dAxaQMMfcMF7ue2eUiTjdNmDVMVQA2jJZINJTMgzA6X1wgE82y/7gUZ
         uG3EYFOt/EA1SGpJdhp+7sN84KFUuHizoU8GrvmbJUZjjmplHQFTQle+yAEqn+0VZVeJ
         ZcW48F6oTT3qDEgfn5F4u5sy8tQYaxI44u0eDH2lCk7URv1MkjPlaYbBE9pzZyZaIPC6
         fC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756903807; x=1757508607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm41AWfuWUPDSnKfrBo+/YKznTzPGF4qpgJqGRZ59f0=;
        b=EUn9zIqFaZv/9Sz9cUI4xypzUZSDVx00/Z6wGnN8GnhXQkgDElqBIHPad3iLwoYYPO
         0QUKcfHkSGq8NhppZFfqxc5uqguZBePb7ATcNCcVV2rY+ZEwnVM6plLK+jQTgarPY/Qx
         PlBdeQqAcFJ5Nlb3zQJkyncGlL0AEvSQg0xI2IJqdWzra+1vdwWyMPzrF+SVc2i3tD9U
         rkSWYr4Uqn76JtuFtd+0Wdy+MFLs9Vi/lW8/oQqF3cp8BpjtkO2VW7+nDUGtwDOEFnlZ
         J5NpRG/vbozcPCxBPO/H5qGGCwD69LxD73fk2xgXlqSlPK+21ucfE0vTjt0NhjVOiEgJ
         uRKA==
X-Forwarded-Encrypted: i=1; AJvYcCVGqOdb+xdUx2FDKIw19iACvtPS3A5TWubdXZ+Q95/6ktD8mQbyemGq9296cXTq5bour3whkpAq@vger.kernel.org
X-Gm-Message-State: AOJu0YxM75h1pCSloAYa+pfEYcqrB6+JwwueI0EGB7N4uYgrHf+FT70t
	4pz6lOxzLSLMxcs1bH9CP58to8Gw9/tZElNClcBcVsc1oWqsdN2I/qZ4wWzJ/gXlg7xCEoShpYT
	aKxNjaQM/AIT0tecwRZQHni2ykshD9H0=
X-Gm-Gg: ASbGncsWMEmN1aU0hdoPn41aOtPaQJqy/DypPTHRjEqFAhlOB+tqLWhAnhWwvEWYQ++
	acqXS3+TnRfFpVbJxGgEpISqDSTEBevt4o2H+SUmk7kTimO+TBeqSCKtrj+fKruhvrvtqPxBmvW
	/EAGZ8oqLt1x8XzOzL4kPzRAcRF/CE0ShGRhQ2+jpVyPSlT/r6P2jWTgYu4ZGrtnQZ/k0UIgaTG
	dgcuUA=
X-Google-Smtp-Source: AGHT+IED+ybVL600yVcQC5NyN5tC7o3INivpcy8kb3yAZ3yDUqmxx7UxKpTlGR/6CfGl/AJEvgldphigD/ZbuW7WBac=
X-Received: by 2002:a17:90b:1a8f:b0:325:ce00:fcb4 with SMTP id
 98e67ed59e1d1-328156e1719mr15878549a91.31.1756903807408; Wed, 03 Sep 2025
 05:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902055401.618729-1-tweek@google.com> <CAEjxPJ4UzRUKkWgoO80hpPF6HhkPM_DUq7BV4+Nh6RhRAdpP7g@mail.gmail.com>
 <CA+zpnLdDjWK9Bz82moHrgEL4vtAkXvujPmj+JZcrk=TKidnpeA@mail.gmail.com>
In-Reply-To: <CA+zpnLdDjWK9Bz82moHrgEL4vtAkXvujPmj+JZcrk=TKidnpeA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 3 Sep 2025 08:49:55 -0400
X-Gm-Features: Ac12FXwfeFCQINWPyRR5ofkUf372xMtSPnf7xWdZYyA_mbYLt0QlKzM9EiSxgIc
Message-ID: <CAEjxPJ6pVpbMscEy-u+OBpaWe5JeO8H7xQ9MphpKxWQ3b7oTtQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy,tests: add tests for memfd_file class
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	James Morris <jmorris@namei.org>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 12:02=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> On Wed, Sep 3, 2025 at 1:08=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Sep 2, 2025 at 1:54=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> > >
> > > A new class "memfd_file" is introduced to the kernel in [1]. This cla=
ss
> > > is only used when the policy capability "memfd_class" is set. Add tes=
ts
> > > to validate this new class:
> > >
> > >   1. Validate that memfd_create() requires the "create" permission.
> > >   2. Validate that fexecve() on a memfd requires the "execute_no_tran=
s"
> > >      permission.
> >
> > Thanks for this patch. Do you have example CIL modules for defining
> > the memfd_file class and memfd_class policy capability that we can use
> > to exercise these tests without needing to modify the base policy?
> > And corresponding sed command for updating
> > /usr/share/selinux/devel/include/support/obj_perm_sets.spt to define
> > it for use by the test_memfd.te file?
>
> Thanks for the review. Here are the changes I added to the tmt
> configuration for testing:
>
>     # Fix the current policy.
>     semodule -c -E base
>     sed -i \
>       -e 's/\((class user_namespace (create ))\)/\1\n(class memfd_file
> (execute_no_trans entrypoint ))\n(classcommon memfd_file file)/' \
>       -e 's/\(anon_inode socket\)/memfd_file \1/' \
>       base.cil
>     echo "(policycap memfd_class)" >>base.cil
>     semodule -X 456 -i base.cil
>     rm -f base.cil
>
>     sed -i.orig \
>       -e 's/\(define(`all_file_perms'\'',\)\(.*\)$/\1\2\ndefine(`all_memf=
d_file_perms'\'',\2/'
> \
>       -e 's/\(class file all_file_perms;\)/\1\nclass memfd_file
> all_memfd_file_perms;/' \
>       /usr/share/selinux/devel/include/support/all_perms.spt
>
> I've pushed the complete tmt configuration I used to:
>
> https://github.com/tweksteen/selinux-testsuite/commit/6920c02f6d78a9ddd19=
0c62479df3b7569c694cf
>
> I am not sure which part is suitable for upstreaming, probably the
> policy update similar to nlmsg?

Thanks, with those commands (which i would encourage you to add to the
commit/patch description if you re-spin the patch), I was able to run
your tests successfully in enforcing mode and also confirm that in
permissive mode, 2 of the 4 test fail as expected. I don't actually
know about what is expected for the tmt configuration - will defer to
Ondrej on that since he created and maintains it.

> > Is there an actual policy version dependency or is that just
> > cut-and-pasted from prior examples?
>
> cut-and-paste, I'll remove it. I assume the check on capability is
> sufficient here?

Checking for both the class being defined and the policy capability
being enabled is probably a good idea since nothing ties those
together currently (that's a longstanding open issue on the selinux
userspace, https://github.com/SELinuxProject/selinux/issues/55).

> > And then lastly, please run ./toosl/check-syntax -f to fix up
> > formatting issues with the C and perl code before submission.
>
> Ack. Thanks, I will run it for the next version of this patch.

Thanks, happy to add an Acked-by once that is done.
