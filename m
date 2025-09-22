Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D328853A
	for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544459; cv=none; b=rPuc4hIHBHSzCkshWn9Wk/xUq5H93ZvzzsbscyrKNRnCBznR8TvEyLDshrJcs0wbKhob1ZoQYAkMGRng+DvYDA1I2A5heA1eGQH6ehZj64TUQEJHNfhjgj44ekRinc4t0w05xFskyi6Ps1UgkUWjQ0+IBQY71HXZvtNsxDjbags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544459; c=relaxed/simple;
	bh=ys4IEoI+fdLVxLUuxJrPv2vA1+IDivHuaUVkT1Fa8W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDUWDj+/tD6H2NUObAjn8E7dS2XyWW075igNUeyeY3gCxViFX73myvhwmnRXYD2B102KSgU1/fKmXljKeCLydyndA3ug238XB8mDgPNSAuhR1Bpi6Y5RC32PEg0+jc2gMG5DcnDM2ILy3HL+1NqRPlrtAJ1ui6ALbUshF6yTONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnKWf3f9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnKWf3f9"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so1237451a91.0
        for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758544453; x=1759149253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNq/C59VuTgRCn+nlqpjLe4b5aVpPSyRTgdZcEzYFpA=;
        b=NnKWf3f9JLbhDurAKtmSidZidQLjQDmIWh+dkaIsYa/dr6Ymul0jwcB94JBDpEIan+
         PzuxSyqXjGbc+8N9tvXJh5MN+aYar/g4CZBRuuTlVAKQq5oMsA1ap6zjJT6oWLZLmvr5
         KKkhYDYkBirLrmp0ZTGls6VGKDjesUzZksbbMTfibz5B8xgXgQL0wT9gRZxRUbowi6cT
         MhptO8yyTVzP5sJaSddSAMbAn3lAxL0C4eH7frcttexo3ZAinW9hpHq7tm0kEtokp4Cg
         rx3XZiwqEU8nHyHdmDj9R3tc3M36uyGN9Tpqpsq8qJSR20YxwjoDY5GohLiCQgNWV3yH
         +UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544453; x=1759149253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNq/C59VuTgRCn+nlqpjLe4b5aVpPSyRTgdZcEzYFpA=;
        b=R6ut1rXflfIxt41tDODAVFyoVYN3Mlh7cP7vTgDjeSBvEqiTxZBElc+BE3zLjpGD7D
         9lozXRna6MwLar9gP/0gJhMyzjnx+yYu7Yn5u5iWOo8xmSNUBPL0k0Qr10kmmptb+mrg
         5nqZMkCgNfYt2Bl2G8JDmeuASWEFNofXd4QbL2HsIx8RzKHmQIhFsXUjN2GGVHJiHKGt
         gVPEFHCn+Ch5/2ZnP7r9P3jlwwAlNI6A2HzvHji1qxlmOb+bBZeQ5GPXdvQJcr1fIAiC
         P+vcgUuf8ixO70n4Oc/+lGX3z7f4WgVceCLGYO+0xLWEGpDewCE3ODVcUaZV5vKR1GK0
         D7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJkXMASLWT8fJjZU6NmAAX3l564kz4MqG5iEMbXRvX3jtyRCBd/uQ5WESV8YE+HyzawkAJrdRV@vger.kernel.org
X-Gm-Message-State: AOJu0YwPlT7jl5gV2OBItpvQLtjkHenDtusNIc3r8TjQMPhDuj+91QQf
	3RwYsslAOM9cZqBoUnARJDBjbLOhaaZE2NZ6M55jBzbBA1bZt8nltSPsG2Z7UBILJnql9qZLvke
	uxoaHgLo34ds0NeJdVIryLYkfVUs49XE=
X-Gm-Gg: ASbGncs6PUp1Pxhe+HPzx38WuMN2Imtsf3JrUW5ifNoZipy1Z3vQ4Sfhtjdf1Cl9EPl
	zvJRLQJ0F3FZjSMXbs64SXz0krXrY6E3Ov37Jm7SN+SiW93MZ3PB0t67MCHPqIhKuiSjF97K5LP
	1V8FKZ3xuNXXywi+MdFHOR3v9+nDp1AsPIzXDEwe+fHzjfjo8UKuzGPlkxDKVEUeEguYsJk4Da9
	yOZD/I=
X-Google-Smtp-Source: AGHT+IEPnzETHfIgVe8rbYGpffEitkgUY5tbApm7qiaC9l5Nc8ofRpUyTQPO48qxBeA4pIWC06Mh2wcCe4/H5YFHFPg=
X-Received: by 2002:a17:90b:3d0f:b0:32b:dfdb:b27f with SMTP id
 98e67ed59e1d1-33098246affmr18469898a91.17.1758544453556; Mon, 22 Sep 2025
 05:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920074156.GK39973@ZenIV> <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-31-viro@zeniv.linux.org.uk> <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
 <20250921214110.GN39973@ZenIV> <CAHC9VhSJJ5YLXZbB-SvQket-PJCv81quM6XLrBDc7+erus-vhA@mail.gmail.com>
In-Reply-To: <CAHC9VhSJJ5YLXZbB-SvQket-PJCv81quM6XLrBDc7+erus-vhA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Sep 2025 08:34:02 -0400
X-Gm-Features: AS18NWDPYNiBNGWS7nxHqJa1sonTvXEysr_U_r4l4cLpOAIMmTBrwipP0XT2NVE
Message-ID: <CAEjxPJ4Ez1oYXa4hEcSLSrO+ikLN0kgrWQc+2n2K7wWoy7a7pQ@mail.gmail.com>
Subject: Re: [PATCH 31/39] convert selinuxfs
To: Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, kees@kernel.org, casey@schaufler-ca.com, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 10:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Sun, Sep 21, 2025 at 5:41=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> > On Sun, Sep 21, 2025 at 04:44:28PM -0400, Paul Moore wrote:
> > > > +       dput(dentry);
> > > > +       return dentry;  // borrowed
> > > >  }
> > >
> > > Prefer C style comments on their own line:
> > >
> > >   dput(dentry);
> > >   /* borrowed dentry */
> > >   return dentry;
> >
> > Umm...  IMO that's more of an annotation along the lines of "fallthru".=
..
>
> Maybe, I still prefer the example provided above.  The heart wants
> what the heart wants I guess.
>
> > > > @@ -2079,15 +2088,14 @@ static int sel_fill_super(struct super_bloc=
k *sb, struct fs_context *fc)
> > > >                 goto err;
> > > >         }
> > > >
> > > > -       fsi->policycap_dir =3D sel_make_dir(sb->s_root, POLICYCAP_D=
IR_NAME,
> > > > +       dentry =3D sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
> > > >                                           &fsi->last_ino);
> > >
> > > I'd probably keep fsi->policycap_dir in this patch simply to limit th=
e
> > > scope of this patch to just the DCACHE_PERSISTENT related changes, bu=
t
> > > I'm not going to make a big fuss about that.
> >
> > Not hard to split that way.  Will do...
>
> Thanks.
>
> > BTW, an unrelated question: does userland care about selinuxfs /null be=
ing
> > called that (and being on selinuxfs, for that matter)?  Same for the
> > apparmor's securityfs /apparmor/.null...
>
> That's an interesting question.  The kernel really only references it
> in one place after creation, and as you've already seen, that's easily
> changed.  It's more important that it can be uniquely labeled such
> that most any process can open it, otherwise we run into problems when
> trying to replace fds when another file that the process can't open.
>
> I'm adding the SELinux list to tap into the folks that play with
> userland more than I do, but off the top of my head I can't think of
> why userspace would need to do anything directly with
> /sys/fs/selinux/null.  There are some comments in the userland code
> about not being able to mount selinuxfs with MS_NODEV due to the null
> device, but that's the only obvious thing I see while quickly
> searching through the code tonight.

Is there a reason why these patches weren't sent to selinux list in
the first place?
In any event, yes, Android userspace (in particular the Android init
program) relies on /sys/fs/selinux/null at a point where /dev/null
does not yet exist [1]. Hence, I don't believe we can drop it since it
would break userspace.

[1] https://cs.android.com/search?q=3D%2Fsys%2Ffs%2Fselinux%2Fnull&sq=3D&ss=
=3Dandroid%2Fplatform%2Fsuperproject%2Fmain


>
> > If nobody cares, I would rather add an internal-only filesystem with
> > root being a character device (1,3) and whatever markings selinux et.al=
.
> > need for it.  With open_devnull(creds) provided for selinux,
> > apparmor and whoever else wants to play with neutering descriptors
> > on exec...
>
> With the ongoing efforts to push towards better support for multiple
> simultaneous LSMs, we would likely need to make sure there each LSM
> that currently has their own null device would continue to have their
> own, otherwise we potentially run into permission conflicts between
> LSMs where one could end up blocking another and then we're back to
> not having a file to use as a replacement.  Not sure if that is what
> you had in mind with your proposal, but just wanted to make sure that
> was factored into the idea.
>
> --
> paul-moore.com
>
