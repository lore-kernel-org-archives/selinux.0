Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BF0378D74
	for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885303; cv=pass; b=mVDfV8us3sPiW50Y1xzLamU/JMSt0XeRrcgp/7gevjW2zawuskA3GznVDPJDcwXfs1DoyyVoUsMH7+LQe7Xy0p7UGE9nmyZIMN/DCHBuaviSkdkZ2gJe00sRigy85OopsuYCzkp1Rp4rNFIQFOVey9Q2LMQErmivYDyJh6TnWJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885303; c=relaxed/simple;
	bh=laA8fxKUOs+Cw7EhbSLmhA3l6QzLfOUFVFuQ38rQLqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+gG2TtzOz6rfFYo+cyttx0FETQWAJJeXmFBH37QMBi4pooxFXfiK4Y6XYj2p1sse5Gn/MPDupWMImuEBSD2LfohijpwCtG14DzBt7acF3E2iYBlCjqKNYbt5pJhAxwDQReTJYgSudSvbe5n9jzLfNL57Gx/ldoJexQjLjJh5Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CSZuTDLt; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CSZuTDLt"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35851eadc17so2726805a91.2
        for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 14:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771885301; cv=none;
        d=google.com; s=arc-20240605;
        b=CLHVHrGkOh/ESASTp2L6ZyT4TYTfi3OKvSp9ny3m4nG2+CZxsCeg/n31cclODEFhLl
         VFJnyTsoe6xBmSQs8P2qQEb/X5nu5X3+JQAbg6vZP7YxwwMVDjJBMSgGUxkuD/j/+uyt
         pdo217TnottlFoh86D0ger4UVOjEMoW8vRXvT3buXSA218OBmgni7THZrV4xCTHgkcrr
         4b1LSumCEc+S2s+YgQG9zar4YQwUtSJ7fiGp09Eu37raaKgyVvhVgG0dmvpIrDjRJbtp
         E7vqa2BMYLPhIk2pTTFP1al8dYDiCkL7lgM2Bi3+r9N7pqI8qos/UQUCHPKIVYcVgj0t
         /dZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k9ZYfImaDpyTe2L1+2pEtc6yTABcUBTwYO7vVYurX8o=;
        fh=uwfBbX4asEBojNmjZxypqUwI6Ij513eoL27uCYuHf1k=;
        b=dFrgO2qkUwuG/4lEeI4OrB0VG1Z6Qll1kLVhRH8BHuLIEGjt+cWjDnjYair9vPgfgS
         R8PMwzJ/APII0UN4rbI0Fa7I2cE5oeS6ylSALz/egwOTZpgNVua5mkGhXKlgPOSh0BG6
         +CKAaiz/sBtSA2UJVCmMSFUjMJKnB5XSaUwz8NabEHL5Tvas7yJiwGaFHKm8uRzCQpGh
         KyHUzt3OLMct+yaxP4yuLCCcQZ+E5TB3+nrzlZQulBWszOsD8V9ZDWb5rtRo+qYIldF1
         yOYvzBgo+3DLAg6nBCMcZYDDhB7jpWfYZzQZ6j5s9Mc8KwkmWjuioo0eyqADe+NZxEd0
         6Oow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771885301; x=1772490101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9ZYfImaDpyTe2L1+2pEtc6yTABcUBTwYO7vVYurX8o=;
        b=CSZuTDLt22UDdxVqNRHk0BvF8nUM5UfBRwe4Uxyi4a+mE/iwe803jR5iN3CHGpRJZR
         +N9/vcbV+OT/trIi/0KyeVgobl2NBvdBXSvNbkllMzXUp02ba7IyJmQEyQjfY4P8BmqL
         oK1qN8nlmBECXM02OXCowJ7hX8JrHqAi67bdM13E3SCXTu1VBoej2T49757ojsgWWbTi
         /xksj1wJqb9xAKaq9EfBKOWp37fuhfBxP92oo7hpP0uzdnBnhwrzaEWPEIcHjDo4hhDM
         lvhahe2Mei4ot98C0QgSdJn33e41ILmeDh5uGtsWQtxKZKEqO9aleiuB3aUKTp/d88Th
         4OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885301; x=1772490101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9ZYfImaDpyTe2L1+2pEtc6yTABcUBTwYO7vVYurX8o=;
        b=fMNJC0WOTKvrp6jUWj/SlE8QIr/AdAeHo0Oce2rSTu49nar0Y4dFDsmhuLt0eaX39H
         E2Gz5rSVS/cZeYmwLJjnh3Fp5fVbK/++Fzp+4ZdunRU2wCLRWLjsMzcsfzzX3gLO9PF0
         qBag+xzda3KDA3WaaGOOzEuThdcy7W933p8XM5PtsK8ZgcGuKztt/Rv5X5e72YKIap24
         hHmJF+VUGf2FxeDfr4PQmn+AXJbO8ht7oO1pUJLRp7YNl+ShWOVPkPpHt/dhjM3TT5XR
         NfuqR7rKl8sFuIqtgtOYB1DhvNRxzjv4cNgpxETxSSuCSkihmo4kIXDRIy12mHtwhCrq
         ggFg==
X-Forwarded-Encrypted: i=1; AJvYcCUNHo635G/WjaZCZwfwRWZ+jQOYR2uU46+ZLTxBntQAgGGESawBsW12A6DnYmmklzdS+PAJwJPQ@vger.kernel.org
X-Gm-Message-State: AOJu0YylM3xd9trqYJ+WcHvrPHLXVbDPN8UKRFD+uR4UQdQtaCG1wbUV
	qXFmyw0z/1zvtDXr5W1srSR32HEMmV+s9UNkGhkS4k0KfXUa8cdaeTTqA64qaooXB/VRR57Qu+0
	0/E6Zqu2AMFrGQwHssFp1fFz4lS5tNbJzUoQY0EIU
X-Gm-Gg: ATEYQzzN+LP/hVOWlh1EUkxDMDQVNDsYy9C7VoKHgSGc6Fyh4wixA5ZwhFehrDowfBK
	/Nhn6/b+7fduc/wxRpFk1WyzvytZQ6S6s0b9GxIqN1idZoP3AXgYg84dSAYjF1QEvBUAlfq0R3E
	SSaO9rXia6tYpmxyN+V4H1gpuKeamTNnwfLyPIA+sO1Do8vGaD9Mi5Px6vYfA8X/nRIJcWFWCJ6
	zC1zlbJsU9gBuIv0zOSY+tUXVEnWG84DCWEEAXsEvjlH0hKhndNdgVRLszIZhhOJMmjVKXelqXa
	e14U7CPvOxboTOMzNw==
X-Received: by 2002:a17:90b:3d46:b0:356:2fee:92cb with SMTP id
 98e67ed59e1d1-358ae80a6b5mr7566836a91.8.1771885301191; Mon, 23 Feb 2026
 14:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220195405.30612-1-danieldurning.work@gmail.com> <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com>
In-Reply-To: <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Feb 2026 17:21:29 -0500
X-Gm-Features: AaiRm52qgdM1-bPMDqdvit-s0syTJEbYBD7y07LXgBdLcQeQROdMVa1XCyRpsj4
Message-ID: <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
Subject: Re: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: danieldurning.work@gmail.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	stephen.smalley.work@gmail.com, jmorris@namei.org, serge@hallyn.com, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, mic@digikod.net, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 4:13=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 2/20/2026 11:54 AM, danieldurning.work@gmail.com wrote:
> > From: Daniel Durning <danieldurning.work@gmail.com>
> >
> > Move responsibility of bypassing S_PRIVATE inodes to the
> > individual LSMs. Originally the LSM framework would skip calling
> > the hooks on any inode that was marked S_PRIVATE. This would
> > prevent the LSMs from controlling access to any inodes marked as
> > such (ie. pidfds). We now perform the same IS_PRIVATE checks
> > within the LSMs instead. This is consistent with the general goal
> > of deferring as much as possible to the individual LSMs.
>
> Um ... ick?
>
> Sure, we generally want the LSMs to be responsible for their own
> decisions, but that doesn't look like the point to me. What appears
> to be the issue is that pidfs isn't using S_PRIVATE in a way that
> conveys the necessary information to the LSMs.

First off, consider this the annual reminder for everyone to *please*
trim their replies when discussing things on-list.  Everything is
archived on lore, we're not losing anything, and it makes things *so*
much easier to read if we don't have to skim over the entire email to
make sure we haven't missed any comments.

Now, back to the S_PRIVATE issue ...

I was the one who first suggested (it may have been on the SELinux
list, or in an off-list discussion, not sure?) that moving the
S_PRIVATE check into the individual LSMs was a way to work around the
issue with pidfd/pidfs, so please don't blame Daniel for this, he has
been doing good work trying to solve a rather ugly problem.

> > This reorganization enables the LSMs to eventually implement
> > checks or labeling for some specific S_PRIVATE inodes like pidfds.
>
> We could consider these or similar changes when that eventuality occurs.

To be clear, that time is now, that is just a dependency of that which
needs to be sorted out first.

> I would strongly suggest that this is a pidfs issue, not an LSM
> infrastructure issue.

I'm not going to argue with that, and perhaps that is a good next
step: send a quick RFC patch to the VFS folks, with the LSM list CC'd,
that drops setting the S_PRIVATE flag to see if they complain too
loudly.  Based on other threads, Christian is aware that we are
starting to look at better/proper handling of pidfds/pidfs so he may
be open to dropping S_PRIVATE since it doesn't really have much impact
outside of the LSM, but who knows; the VFS folks have been growing a
bit more anti-LSM as of late.

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 318253344b5c..4cec73b4cbcf 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -921,7 +921,7 @@ static int pidfs_init_inode(struct inode *inode, void *=
data)
       const struct pid *pid =3D data;

       inode->i_private =3D data;
-       inode->i_flags |=3D S_PRIVATE | S_ANON_INODE;
+       inode->i_flags |=3D S_ANON_INODE;
       /* We allow to set xattrs. */
       inode->i_flags &=3D ~S_IMMUTABLE;
       inode->i_mode |=3D S_IRWXU;

--=20
paul-moore.com
