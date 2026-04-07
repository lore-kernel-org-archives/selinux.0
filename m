Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F1145FE0
	for <selinux@vger.kernel.org>; Tue,  7 Apr 2026 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589620; cv=pass; b=ZArZxvYzX03qw86bc349AFvX7wb7KjOW2t3Lsqg3+san9NiLR3HgX9lU6KhqMlzVjdYJo0N8eWHJXhyNEUcJYHUYf/K7rLiXufEbr43oBVlZXLxL7SFzPAZTjMNQ29G0Ve79XHKU2uvdBLhn8bDVuxlE5SiJmtpA/Rh2n5uaDR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589620; c=relaxed/simple;
	bh=i6c6Uhklk6n23W8x1AxzLaFh13KM9OwbxJ2yYTpwf54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frpL8aoP3Sp0uM7x0the83Nfx2Z3ULomVtbE6GI/m1TfZ14+XX4Y1hLRjeZa1qTN9HSQDeamtYPI2iRDJtW7x/kC3Jd1dvwSCwGgV9D2SZaKVi4TJcbQyRafFvrv7MXxfpzU0+8UBNuhQSYyYzdT9Agi5U25DobfRgVWFOSDvAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyZUiWWI; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyZUiWWI"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so4734055a91.1
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2026 12:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775589618; cv=none;
        d=google.com; s=arc-20240605;
        b=dJDPSx8+Elex2JFOlWEtZvP/TqNEgfftxAY1zd15YSstK55Tj8T+pE/VucQzgGOFFl
         pejUb3K6mw44DaotSZdTjbRxKRrFwLdl/fpOWjECNmJB2EQTk0JkmaPRsoz09PLWgyLa
         TqKS7r86Z6/SqKWsDll+jHeMad1v8/56FFowQX++htwu7CxWl9467c5u3LD2nQlA+/Qv
         bYffjkCu6s7PT7GZ1++WzhVzoedDGYPdaTW5PQwW8qziPJFQ5dY/wQXfOL0OS2nIxWph
         mYIF+PyW8sx2L5iyUXzii8fFPpSXUHIwVIx/F0wEDkNHrwOkUiuz01SqboubvPLA7PDU
         mtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        fh=DJPKXC55W5v1VIvEPIDmFFi3uoWxaCrDA0lB1MqzY70=;
        b=J+3MM41kbKyVe3E1wQQAcYnvKAG2rDEINsjYQPSV8G8z6ti6afEw6c/MUcWuNkcv6p
         jvYhbRU8e/KjqSjUZcUWiMkAwprjVprB6kXoGSLxumQ65/2M5EhgPSWyc7BcnwukI5fD
         i+5aFI1//nQQfl9rsWMsTRRirs5ElYHmYSwOLd8fFNyrgG/OSvtP9neYuH1c6sLyIYx5
         vTKR2YBsmrdPr90GJ9mcoNDvKYj2MSQYjNRe6/lb68TsuxuAZwlVW3XVYZfcI5VjdEWc
         TdHYx5lb+yQi+WP7sgGhhAxV54YlgT1UgN5WNETp279rBcqNrf5jaJediQt2HLyi02H4
         ltBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589618; x=1776194418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        b=eyZUiWWILQVMtoM7LN+je344gEOI2bb+oTPGGw49fR/pLvre5XwIY3Y0OQq9XQlglO
         v7pGURmjkXPNSZujNTn/TSK1p3EfZ/5/ErzUyGBS8vgxDCfTWo2s7mBUKa7HRTzS4mZD
         mSGaa+mqRr4mLpoltEgg53+qacArS0qWR0T6VJl1GsbYJRLQal2fit2uyn2S6BBWurER
         dl7wceAy/RmA6U3CKIUbd+We8HdJbAsRml8wBQpatHpRcpBJwpwMU2h4gY9rF5Tpo8My
         FeXEc/FKtXPEp+Sp+foOWr+lrurKCZtmaOIbqepRdcZN2SZ9n0VdOOPEOdLrT9IB7QBy
         WkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589618; x=1776194418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        b=G9pPe/4ERLTUuWh0kn5p2nmJr0JHT7aUduX4Wf18qIb4nyYElC4O9I7ESUpX0wxBfW
         4vPIf6tBBJBRA7i3ZCO3886M4/ynK3HRzI5UFldiOb3S44iDBm3tF48S+zExP1HyxO2e
         8jZKIfUstBomdLDN0B9hnUJ6ob9uw83NiCgGyyHA4fcvedLmsIEYxJ6+osqLHyEHXsPP
         i7YAUSWSxr5Oo0Q49Q0XnOHjpnQE8sWc953YrQt5YLtAFKGOeu86icC/v5uSo0nTz/1m
         k5X2RH7fFZWBqdT5XbuxoXvaHLEB9+OIez4bSZ28L7AnIL1HtAwcYDkIY4wiwqV+Ublm
         2pHg==
X-Forwarded-Encrypted: i=1; AJvYcCVITrWYjcoyUGC/YnWMLhn1Gk8qS+ZZbFSzvlFtSJh1F6MQvvwkzxgjBF+Xl0aaJAweAOPS4kNt@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/cHgRBL/VzutplPBJTNOWI56pQ8gKxbh2INxsro1neGzDlBS
	hp/ZO8POTrUtgz2Xc30gnva0CRoEOF+RIxGF0xnX74LVZbrH6GeoHqZ6BHfg8KNho2GNEljS1Fi
	YknRiLXghLPIYDChVwewYlb8WN1LVu9w=
X-Gm-Gg: AeBDietiSP6Yud4vBtt85o/DMX0fCD2QjrgwNc8FaLZHUii9EiN0iRzmBxKWb68o82B
	wfIOpbg9XGx0uJ7kDelX4gpWGP8ONkIhzJLsKlfL7KjNYwo6VYYLSk/O5SRqzhkBsXQwpwh+hQz
	tu9XK6+qD36cMhMp1Hr+3faprbxPKVpHmFk+4sfDGunVQetU9D/iQtmnHdMiQf0rO3xJywQSqeO
	446S4JPVtU/ZkSWa1A3BFAbQ/FBmliv2FUXGFyywZt6vpjGm3rVKlk0LnXbsSG42yhr7QCate2Z
	itcu9+0=
X-Received: by 2002:a17:90b:3d4d:b0:35b:aca5:db39 with SMTP id
 98e67ed59e1d1-35de67ee6bemr17005316a91.9.1775589618190; Tue, 07 Apr 2026
 12:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com> <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
In-Reply-To: <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Apr 2026 15:20:06 -0400
X-Gm-Features: AQROBzC7o3Va4ubfSL9DMqzx-1hfP9_BswdLqwBtMsXc3haoHViWO4Xh57-I6OU
Message-ID: <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > The existing SELinux security model for overlayfs is to allow access =
if
> > > the current task is able to access the top level file (the "user" fil=
e)
> > > and the mounter's credentials are sufficient to access the lower
> > > level file (the "backing" file).  Unfortunately, the current code doe=
s
> > > not properly enforce these access controls for both mmap() and mprote=
ct()
> > > operations on overlayfs filesystems.
> > >
> > > This patch makes use of the newly created security_mmap_backing_file(=
)
> > > LSM hook to provide the missing backing file enforcement for mmap()
> > > operations, and leverages the backing file API and new LSM blob to
> > > provide the necessary information to properly enforce the mprotect()
> > > access controls.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Do you have tests for these changes showing the before and after (i.e.
> > failing without your patches, passing with them)? I tried running an
> > earlier set from Ondrej but they failed.
>
> A few months ago I sent you and Ondrej some feedback on those early
> tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> I've been using a hacked up combination of the existing tests, some of
> Ondrej's additions, and an additional debug/test patch to ensure the
> labeling is correct.  It's far from ideal, but I didn't invest time in
> test development as I assumed Ondrej would continue his efforts there
> (unfortunately it doesn't appear that he has?), and I wanted to focus
> on getting a solution as soon as possible for obvious reasons.

Ok, I'm happy to look at even unpolished tests - just want something I
can use to exercise the before and after states.
