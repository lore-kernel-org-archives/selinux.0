Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DAD3DCD84
	for <selinux@vger.kernel.org>; Thu, 19 Mar 2026 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932053; cv=pass; b=igs/o9GSTgWGaawXyj8fci4aPLCi0D8HZpofjGdZ2Ij/uTwPqmmOG3Thi/81Sdat/NS/qAuaTWrzty6hVdPmFMgGFZ4Lk0M0aVFgmcqhcGt4LUGZA4XhpdjeEgQ6OcOTsC+uhYohmaRJ14Ys/yZfgtiMFZuIhyFKt4YJ+MVLOrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932053; c=relaxed/simple;
	bh=UmN42XIFxWPA+oc5RV+ztiTu/o/KFtkvvg5unw0jZ4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/FCYFgUS824D62nQQFD38bTTguftdLP/Maq5/cwAV5jTAuYyKAjnf16XXlLyw4UKX2hOqu97aJRhR63TZFjXswAvECOYBtP06QWmZVsNll3S2KqmdJDfAgkkC/SjqYJT/Hhm7ETfvpkInwqW1a8R1LiinF6Qa1jXTZFMOKOhvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXdDk7A7; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXdDk7A7"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so1564155a12.1
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2026 07:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773932050; cv=none;
        d=google.com; s=arc-20240605;
        b=df7PnPbC2RKyxZJUP0AMSfE3Y+gUEqsktyEZtP7CWf92vpxC4CKxRMHLkYk4NmMQw+
         cAKwaDTsIGxxd23YhmNMcKb9e8akTyBNuo5mQXnOwidk9PFQH1U61SZ1aOuFJwP3AW3P
         r7prm7dIx9sdy+ZUBvf2H6+8BuwrJjtCanVRqzJIOATpXl9gyME2LVgOVz8kghB7DxHV
         8ADqdm4tEaez23L5ow41OuZtdLbCavT7HoGaP53jtpfD6Ee0tuF+xI8rRMyvvjFEAh2n
         wYyjIrzcZqeaBYS/Z+SlhpVd+RZwwsqlOzDF46m9EK99kg8cJDQjtHMfAEeM9YxKOZ+k
         fb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        fh=vj75KuC9FvISZXup1xlWeZsmjA4acY2PwNai0MiF+mw=;
        b=iGzS+ln1OG1HX9+Gja2E9EAXKfUBem3Mb5LsQXZXrPQb932gttFcqotgGPAetc0gVU
         eFRp5Q0Xi3NhZeuRlVYdnHW+ERBXYi9VHvlTTwwDZmc/+gPmR5enLe/CIEDBWal2eAzk
         BHN4tvam4E+270MkZ4e+ROvSIKtAsLEbLkGyBFZaR+Ka4jTOg9m2BROp6vldCbacYNBh
         T4YuTXC7pBINp/Jb/r8OU/ee/ANtV5Vi+pd6Crzielc/vVLzM8DdsuKGeyKgqI6eHYlD
         H42/Am72X74IyjPER34YGgjg6BT8lmJiUxDTVw1hP5XtUcyzfUHBiDQY9Zq1LuRYR+no
         X29w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773932050; x=1774536850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        b=hXdDk7A7vGYw3Zx6tF71xgZ7WwjEnaSx5y641xv65jo7qeQ8m8GRnNgGYdbd7kyl6R
         jJrYRxgyKtVCKK4gWldoBp3Tvv5JIfA34Qk+AUM+Tc1yNVtKuQOzEjlcqKADPmBmdM8w
         Abw0s9L2n45ICgImp7PJzWtFr3S9gAQrMEjvGWASPn8mFsb6ObKzNoAMwTU0IXbMD2wE
         RqECz/OvszbdyuC1gWzGfiUkUSZgpXR6vJXzxNUgUd6dbCF/7aJ293WWUo3p4R/57EBl
         UZcoxF6Zh44ecjSgAzXPCdgTQ7czPzt94DSczCXot4iFxD9ZleUU1yD7bhYc660LKoOY
         FQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932050; x=1774536850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jw0GH/4mNtxvnbd70gE+2uTwAn5ypE+g4jyg0EIdEpQ=;
        b=c7neywNNJ9jnhCyRX5muDAx8ZNYpaZvZ1F+TsBMjYghIyVqLp2BGfyi9oVI1/w/DBO
         +NbCqfLTCUQdBu17E7J3jbkeiB5aMmvIpZ0TsekUUTUqPwex3/cGbO2XveFtCZV+rirn
         MCvqlz7a7D3pNG0yTRLDRzJTqvujxIdp5JpiTjK2Wjx0omlxIXKt038vggaGD6TXSMaT
         8u3AcBGbh0MbpPRdalg1FLzOlY3nlp8icjQeAGGyRQDGZn7tkb1OfWv3/AaYO1/hIey0
         nI+bPTQo0OBCUtNSpHEQylOFQ8Z06vISFhrq7+jLT4qsBUfYm/Jhj54ODuF8kWLzHZ4q
         9SJw==
X-Forwarded-Encrypted: i=1; AJvYcCWreC7VdUiMMu4oDdOOYuacP5uic0vQlib/18YLkiCOCN5fRpLJE9vWjFkZxteCogXAGi5Jsrgi@vger.kernel.org
X-Gm-Message-State: AOJu0YxdH6mx/+c6l/3zSOZPJlcBSNMF+ZDuyDNO8mVIE9yrQ6dlct3y
	pf2HH6OUYO37DsjukdKz1Z9EMhJI34GpYWCL0hW4f7kFa4PGLEdbSBIukbHI8FPH1nCFS+y26oa
	Op4kGxGTkKDqvNVPBey2ZID/jGYjnfNg=
X-Gm-Gg: ATEYQzzI9XWgTpQ4ua0pxxwXyS6EC3xH72xHTidnUMRnMAOW2OD6GJWABqtuc/PZV8V
	XoE6ZdXw7owYlR3tfscW93gsVQENoT8QcMhUTSrJcYtBa+tSb8HKuJyvmRXjtxMA+itvTZpACnA
	Zu5cl0n639G6RZqjIJM+j6dzLUvoK9AMOyBqV4wnXrv+XO+AUDBCrjoN541R6Cp+Z/kQERCPvGP
	WCuoPMwqoQSb+gu/tZT0qZbo2GKiGi7GIBFPbHOOy/euOaD1qPgPIPSn15CfpPl3qIECiKyz77+
	qO1HOxg7ZSx5u9dYabPUKltj/SdHuYFoK6WmvBeheTHY71Cxwqnx
X-Received: by 2002:a17:906:945:b0:b97:d76f:3790 with SMTP id
 a640c23a62f3a-b97f4948e4dmr422735566b.24.1773932049652; Thu, 19 Mar 2026
 07:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318131258.1457101-1-amir73il@gmail.com> <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
In-Reply-To: <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Mar 2026 15:53:58 +0100
X-Gm-Features: AaiRm53ob940soSsJtP2tgmiMXVCsKvszmwMYDw08PfOi4CUawSVTSX4zhGKxzI
Message-ID: <CAOQ4uxj8SZqaFbrVifw0uw7skbUvJP1_nLWj4PYCeZuaLy5t_A@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 12:47=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > Instead of storing the user_path, store an O_PATH file for the
> > user_path with the original user file creds and a security context.
> >
> > The user_path_file is only exported as a const pointer and its refcnt
> > is initialized to FILE_REF_DEAD, because it is not a refcounted object.
> >
> > The file_ref_init() helper was changed to accept the FILE_REF_ constant
> > instead of the fake +1 integer count.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Christian,
> >
> > My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> > Here are the changes you requested.
> >
> > I removed the ACKs and Tested-by because of the changes.
> >
> > Thanks,
> > Amir.
> >
> > Changes since v5:
> > - Restore file_ref_init() helper without refcnt -1 offset
> > - Future proofing errors from backing_file_open_user_path()
> >
> > [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore.c=
om/
> >
> >  fs/backing-file.c            | 26 ++++++++++--------
> >  fs/erofs/ishare.c            | 13 +++++++--
> >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
> >  fs/fuse/passthrough.c        |  3 +-
> >  fs/internal.h                |  5 ++--
> >  fs/overlayfs/dir.c           |  3 +-
> >  fs/overlayfs/file.c          |  1 +
> >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> >  include/linux/file_ref.h     |  4 +--
> >  9 files changed, 103 insertions(+), 34 deletions(-)
>
> Still works for me.  I'm going to update lsm/stable-7.0 with this
> patch so we can get some more linux-next testing.
>
> Tested-by: Paul Moore <paul@paul-moore.com>
>

Paul,

As you saw, syzbot found a nasty bug in this patch and it is too hard
to fix it without introducing more hazards.

Therefore, per Christian's request I am withdrawing this patch.

Please see compile tested alternative solution for selinux without
intrusive vfs change at:
https://github.com/amir73il/linux/commits/user_path_file/

Thanks,
Amir.
