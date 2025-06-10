Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C0284B39
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599424; cv=none; b=Y6TQlLnUjx3xUJtR/qyxP0yTXLDlujWOUqsO+GzDsj+PfGhW9+co1jkDVoeG/oszN7y4M2d/f+ysdvRSslXjUX5B4QwpwrC5AEacsBHJl0h3/jRmMPn2UCr9Ijcwc+xASqPnglsJZIPX0xtHpdPDFOYKpcGctATQ0DdPkqj1DAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599424; c=relaxed/simple;
	bh=5zpmeUIFplYcd16FCJTHwlcr+3eWOrvix0typRp9sog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNCGL0ZpvXNYA+RFsL+AYzelxnVJRIG5Hgno+xTUc8PrePxQpQihMAeX9P9JHS5cPmoiJ2an7OmduCTjmsjkFPmd+9V8mYRw2tRb4yOu9CE1YcLxwBgN4XO5xEYYAMgKhULlK/NZEBEDSLLInGUjr/fUsOGTGVfNUIRbKs13ROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FTOoNxL+; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FTOoNxL+"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso5456815276.2
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749599421; x=1750204221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9Qgp5oHl/0P+qqYYVFIyIBvDmKn+BX8RyiafClKsvk=;
        b=FTOoNxL+0vvlydxtSO2mI5yc5X1tjb179p+F0GAsrKx4xgmGahTCldcYS00Z3ViLIJ
         g0Y+/KMfpS/uwp//Kk5giFqvVPes7d1RHKOvnGNhAKNQiS3Zpi9aLKZH+WVdKR9v8pKk
         iP5Z/yMT64NpQZtKsEeF5dYsY2c6BfyLExb/jp4KkKkflgeqNk1ulDEGmNpOoruuNh4s
         PtB57wiRRix46OR4HDub/HRfv7VXBDVTzTgHgEUHk37pBFwzZgSUSmbqOJ07T2rAAUcd
         xlogZ+m14/YVu0Kq+f3U9z98WdBd48fUqjtkqASQPHLX2xgeTDAgHqdH3SrkzUdOpVeY
         eY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749599421; x=1750204221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9Qgp5oHl/0P+qqYYVFIyIBvDmKn+BX8RyiafClKsvk=;
        b=HpM6rHW0+GU1F5zi5J80AY+1v9S5SQt2hD3avZaQj3dLhYD2B3joI0nFGnMuA4ixDH
         NRUBhOk43ZM7KxERd8o8rcXQLRL/H3vS4fdHBGVN+c34t3JsDjZ9A8ciYPcp1ayd3HHe
         6HXCRpQfJEtBAwmOZPeKJl4Vk0m8pHK76GYfRiXZnf5+PUO5/oMuqgBhRn55bYV8/8G5
         zCJufvx1PiLu+QwQYEnvjYKF56xekf+kDKlC0cBGTNyk67uwJRbOzxJ5wDbsulQgXL4k
         k6aIK0AaKMJ0ZyiVnag68QeMK1QApbUBRQG+XpHqR86JbW4apJo9M8GpsfRF3kCBgK+z
         qG+w==
X-Forwarded-Encrypted: i=1; AJvYcCXTEAAr4i5muGvjD6WnzQppEztQqCcZCLkygs1sy2E+AEgP5Kb6kQiTPGHRW0Q4i7D550ODE3qC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6KQDCeWRhT+QxKzeGc8ywjxEufMOVVOB8gr+h25lQqrv34ep7
	T5flq0ikc+Ciy8WBqQK7nY38PFyujSi2/SspJ5Hvn8WLRtvlaWcg6N5vIfSiX375IjvYIKFe2Vi
	0S/X9a1I0idIVqlKeYi+tSr7wkeAzlzTHPGRQgrCs
X-Gm-Gg: ASbGncuZRPZw0U3lwrM4bCYBpIqkWhgCWqPfaSPtwG0mvRPj7nY+4lmjbYwJNy2kRzb
	LELOkY4CQCJDJ91DiHk2QL6g8UqnlJxnP7q4tJ5vJycYc3UsJWBNc56gKmmdLUKWK7pQ7E/Tlwv
	OoVCqcm9KSoz1zScpo1fWmROdvq7eFLV4JBcCtEbbmmLE=
X-Google-Smtp-Source: AGHT+IEvtteku/P1uiXxT4gbHUj7G2QQ+RMoFTyCSCZ3iBdan2K1TBvoDyo+Adyk8sCdrfVIToKGxMKUgGG3OtxF/+0=
X-Received: by 2002:a05:6902:72e:b0:e81:78f7:5521 with SMTP id
 3f1490d57ef6-e81fd92a3f2mr2148616276.6.1749599421291; Tue, 10 Jun 2025
 16:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
 <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
 <CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com> <87plfhsa2r.fsf@gmail.com>
In-Reply-To: <87plfhsa2r.fsf@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Jun 2025 19:50:10 -0400
X-Gm-Features: AX0GCFt95pxw11ngH9ypXcXXgINCY4mIRN7SWpVrAA3u5KTm4VBIfux35kFrlG4
Message-ID: <CAHC9VhRSAaENMnEYXrPTY4Z4sPO_s4fSXF=rEUFuEEUg6Lz21Q@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
To: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	brauner@kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, eggert@cs.ucla.edu, bug-gnulib@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 1:39=E2=80=AFAM Collin Funk <collin.funk1@gmail.com>=
 wrote:
> Paul Moore <paul@paul-moore.com> writes:
> >> <stephen.smalley.work@gmail.com> wrote:
> >> >
> >> > commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
> >> > include security.* xattrs") failed to reset err after the call to
> >> > security_inode_listsecurity(), which returns the length of the
> >> > returned xattr name. This results in simple_xattr_list() incorrectly
> >> > returning this length even if a POSIX acl is also set on the inode.
> >> >
> >> > Reported-by: Collin Funk <collin.funk1@gmail.com>
> >> > Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
> >> > Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> >> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369561
> >> > Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always in=
clude security.* xattrs")
> >> >
> >> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> > ---
> >> >  fs/xattr.c | 1 +
> >> >  1 file changed, 1 insertion(+)
> >>
> >> Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > Resending this as it appears that Stephen's original posting had a
> > typo in the VFS mailing list.  The original post can be found in the
> > SELinux archives:
> >
> > https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.w=
ork@gmail.com/
>
> Hi, responding to this message since it has the correct lists.
>
> I just booted into a kernel with this patch applied and confirm that it
> fixes the Gnulib tests that were failing.
>
> Reviewed-by: Collin Funk <collin.funk1@gmail.com>
> Tested-by: Collin Funk <collin.funk1@gmail.com>
>
> Thanks for the fix.

Al, Christian, are either of you going to pick up this fix to send to
Linus?  If not, any objection if I send this up?

--=20
paul-moore.com
