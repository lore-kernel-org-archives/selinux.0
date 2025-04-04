Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398C1F03CD
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788007; cv=none; b=lIwdJXpqHfbdbww5Y6jd74rU46ckupEM13JRXgHlB3XHESAjIh5UddI37yzmdM/pW5pQ7gKsTntNRpraxvQJSRrUVXnzI7M9EfE5Zzj7MWkIpio1YHZ5bPNj3NkvpcAAmjmMHkx4TBiiDqtc+RMWyVUmLziDo/bGYGJImFwLHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788007; c=relaxed/simple;
	bh=mjUSYnC0qW2CxpL7xi4i1UGxWJwdqgyy5txjC5IcTY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2QeXI+UWb3H8CTyyTZNmPcULAWacmtLCy+iX3y9zBixyRQF8B9aOw7Ek00kTLcxLeNOHbX3B8tVWGVrgh6H8CthaF1CPKp4mZNwW08oNr2U5RKExaR9EACweVeytc22VhOHdzFJeQBw0efAlbKFjxXbKs1iQOcVv6w6nHIV2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KspZn8sW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KspZn8sW"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30384072398so1819509a91.0
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743788005; x=1744392805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvrePx7dE5QTdCu0yWRyr7GOQRqImEukaVJYeGhg+m0=;
        b=KspZn8sWkE3qF7r3KXkKhB7d3l6fN2o1+zKG/aul1aU4dCvprW6f7xUOsHI3KW8Y1d
         L7fAtMCbTnoQJTLf9wLMVkjtnoOJvDcdUGWsZMxr23l6Xbwfw/Z4HdXy+qrH9JLeN5Pq
         xaMbgflftF39xF9fjsBhcRRd+0LP/hrwXLLVN0t/Pi69YMl/d7c3FrhDbpAEZ+Pv/7DJ
         k19djgRdBfCBFu9dr5AfXOJylRMHSzF0wMpWjm/ZMMP6XLn0Rz/1+1fwqksCJHUPbjaf
         Zfo2VjWNVEcQFHN6Iq5QEdO2g+dICPULG+8qaFYKhDu4LgXJVsMUWoeHPYKGheVYZ6Kq
         63+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743788005; x=1744392805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvrePx7dE5QTdCu0yWRyr7GOQRqImEukaVJYeGhg+m0=;
        b=uU2ik4Lv/cdoAJZVAWoLbJnwM49F8xuRfiE1s9Q46qlnnx/iaHvbm9ym4M17suwTmu
         itjXBTWbof2o1ynakG8UypeP3BxK/bn+iIbN4cw/EVgekKS/+Xfq7CffqO+bKXjQDOOR
         jzbiWzBdK9TFufV+eB2Zg7IVIe6xNxzrBsN3ySfXVnRSN1IAmzAdGhIpXjIpo2RAMno5
         xoBZ47gxL+6SfZz7DyDLxtDgYKcomx1D27WER86uLuLoRprJiKCjwFIixNt5OCI4Lzlp
         C/tFp0ILtNRMaKuq6b2srnl67TUEgS2ql3N+fyou/Bo5KdZltwiTFoyHjjMDOogFKH+E
         1UIQ==
X-Gm-Message-State: AOJu0Yz7nU91nZmTZ1CP8IdcUpE6IxjzV1rVDtn5EeOn9gkQS9NTNvhW
	8L5xZJnLdSV5Nc+rzekz6YRxIC4KwafFcQ941H+JtNP59NrZH4widbNceiC8RCR6dCpaooK6pon
	rs5L3FhL7CewHZotiLkOsIprIORY=
X-Gm-Gg: ASbGnctzYbdbJP4IMI9TOcTNE5GeUwmpuHf1HXAjaDFc0CFBvSq/304/TCaXO1ZG1gJ
	VoG2szl5wryguCYTwvoKzRiJ4HFjTZPAQSVgczRzGfQvW+TZePH3kId51pLQBSBWhYIG89uDcJ4
	Z19hMAhicq59qqE5SL3lHCpiJyrg==
X-Google-Smtp-Source: AGHT+IGV0pzmHzbX5Ybh0BO3vZEWjT8xfeaDcbxRMRcZ/ygB57xKL4jTeFZo5tl5k44hvDd4adwm5Lhd7lzXdbGsgis=
X-Received: by 2002:a17:90a:d606:b0:2ee:c6c8:d89f with SMTP id
 98e67ed59e1d1-306af71d944mr343563a91.14.1743788005179; Fri, 04 Apr 2025
 10:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402203052.237444-2-paul@paul-moore.com> <CAEjxPJ7zEv5zt5i-fhrnytQKuu4YUEZSXUNjvZcOsbh6ETs99Q@mail.gmail.com>
 <CAHC9VhRG0nVUtpcmTUvuJaznhT+noVwtJWGgJ+0ZfOZj=uBoCQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRG0nVUtpcmTUvuJaznhT+noVwtJWGgJ+0ZfOZj=uBoCQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Apr 2025 13:33:14 -0400
X-Gm-Features: AQ5f1JrvOqFlbbe8moYM-378nbNihouhajx-S8tUKq9x5A4iWjWGQWK_9HcTqRY
Message-ID: <CAEjxPJ5ht5pPAeMWq6fX3KQ7ESUZNmKqF8VdEGUWRyO_ykJCbQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: reduce path walk overhead
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 12:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Apr 4, 2025 at 10:00=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Apr 2, 2025 at 4:31=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > Reduce the SELinux performance overhead during path walks through the
> > > use of a per-task directory access cache and some minor code
> > > optimizations ...
>
> ...
>
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 7b867dfec88b..df2bc01175b4 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > >         /*
> > >          * Before policy is loaded, label any task outside kernel spa=
ce
> > >          * as SECINITSID_INIT, so that any userspace tasks surviving =
from
> > > @@ -2406,6 +2416,11 @@ static int selinux_bprm_creds_for_exec(struct =
linux_binprm *bprm)
> > >                 bprm->secureexec |=3D !!rc;
> > >         }
> > >
> > > +       /* Transfer the AVD cache if the SIDs match. */
> > > +       if (new_tsec->sid =3D=3D old_tsec->sid)
> > > +               memcpy(&new_tsec->avdcache, &old_tsec->avdcache,
> > > +                      sizeof(old_tsec->avdcache));
> > > +
> >
> > Shouldn't be needed, right, since selinux_cred_transfer() will have
> > already copied everything over from the old_tsec?
>
> Unless I'm mistaken, the
> security_transfer_creds()/selinux_cred_transfer() hook only gets
> called in a bizarre key API (which needs work, but that's a very
> different discussion) and not part of a normal exec.

Sorry, I meant selinux_cred_prepare(). The point is that the new_tsec
is initially a complete copy of the old_tsec so you don't need to
repeat that copying for anything you aren't changing.

> > Should also reset the cache from selinux_lsm_setattr() with attr =3D=3D
> > LSM_ATTR_CURRENT.
>
> Not necessary, task_avdcache_search() checks to ensure that the task's
> current SID matches the SID used when populating the cache, if there
> is a mismatch the cache is reset.  Given how rare this case should be
> in practice, and the fact that we would want a check in
> task_avdcache_search() anyway, I'd just assume let the search routine
> catch the change and handle it.

It's a tradeoff between paying a small cost at the time of writing to
/proc/self/attr/current aka setcon(3), which is never
performance-critical, versus comparing against the task SID on every
lookup.
Your call but if you clear the cache on a SID-changing exec and
setprocattr, you don't need to do it on every cache search.

> > > @@ -3088,44 +3103,147 @@ static noinline int audit_inode_permission(s=
truct inode *inode,
> > >                             audited, denied, result, &ad);
> > >  }
> > >
> > > -static int selinux_inode_permission(struct inode *inode, int mask)
> > > +/**
> > > + * task_avdcache_reset - Reset the task's AVD cache
> > > + * @tsec: the task's security state
> > > + *
> > > + * Clear the task's AVD cache in @tsec and reset it to the current p=
olicy's
> > > + * and task's info.
> > > + */
> > > +static inline void task_avdcache_reset(struct task_security_struct *=
tsec)
> > >  {
> > > +       memset(&tsec->avdcache.dir, 0, sizeof(tsec->avdcache.dir));
> > > +       tsec->avdcache.sid =3D tsec->sid;
> >
> > Since we mediate any task SID changes, we can invalidate the cache
> > upon them immediately and then shouldn't need to actually store the
> > task SID in the cache or check it each time during lookup.
>
> I know I argued against adding some simple checks earlier in this
> email, but considering the impact of returning "bad" data from the
> cache, I'd feel a whole lot better checking the SIDs before searching
> through the cache.
>
> Yes, we want to improve performance, but I don't want to do it at the
> cost of making the code more fragile.  Maybe we can revisit the idea
> of removing the SID from the cache at a later date, but right now I'd
> feel a lot more comfortable leaving it as-is; this patch already
> provides a nice drop in SELinux cost, let's be happy with that for
> now.
>
> (Somewhat related to the incremental change above, I suspect we'll get
> a bigger bump by working to make avc_policy_seqno() faster through
> inlining.  At the very least, we're always going to need to check the
> AVC regardless of the SID check.  I spent a few minutes looking at it,
> but decided the patch was already creeping well beyond just
> selinux_inode_permission() improvements so I left it alone.  That's
> worth another look later.)
>
> --
> paul-moore.com
