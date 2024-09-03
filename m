Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A072AE66
	for <selinux@vger.kernel.org>; Tue,  3 Sep 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375545; cv=none; b=Fo6tKm1qJT2r6l4LsL/jW10l+FfFWnrBp7ota3wrhcEzlIrjnfHAJou/KJpbuJxhXRlPY6aSjSVv7MEVLYSxuvNFfeL90FCm1HYH9W70p4s8C119HzheWYV2pB5ozFbLMiPK5PI2iuJBV2OY9sttqJic+mUlsd5LU6aZXtagN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375545; c=relaxed/simple;
	bh=HNufLMQ8bqMZCxAGz4LhQT3K3ea6nIzmsw74c7kayRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRv6th2x2bRG610/pUGpeZED9IoeSTF7/bnQhQug8iH2pvDASmw2UtwewdxVN8G8pdpnjs6yXGUfNWHj0gzcqa8ug8GGpPB/sSsi5kQAATPeq9bTxtC0yEa2mBeHCMfp64ZJG54+QO1E18nM7OYagipfQhHVe1ZHgWsOF/8sjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM0hSeL0; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM0hSeL0"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-70b2421471aso3037864a12.0
        for <selinux@vger.kernel.org>; Tue, 03 Sep 2024 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725375543; x=1725980343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDYcD650PDVYL2H99+iImPDuN24bXg/jKSDwye8l5qQ=;
        b=VM0hSeL0xDSIYrUHkTeWcburztLwKiWFs8RjljDVp3ncJVCsTfr2auUYcbekxJnYZs
         uBRmvicMBH9XXIEzMWPAleiBYYvKIuRC+2TY5SiZEiAmeriKIXaGzwI0LvulFReVMph6
         agySl9sj841Qew7KeR5OSZb/LfP/9u4UlxwumJvulao76qQE17SCS+snNQ2zBQ6ikYyq
         gtxXAeO0vGmJ1ooI6TCCcVXruuxGZt6kEl1JMYIo87W3S+rkP1E27FuRPsFpdloJF/Sv
         liBdAFD6Vig7oabqu3/LVO0yjp8lK4wWt5DQvs++psmX5rMRUfjFTP41vWqQGe7g/EEn
         M4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725375543; x=1725980343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDYcD650PDVYL2H99+iImPDuN24bXg/jKSDwye8l5qQ=;
        b=ngBsGxNYJUe+5Hw+1Q1IZnianzNoEVpGuhgBdU7WDU8Hb+o0xjQBOUSGHR+fNhCmV/
         5gZSyfN8X/KbS6dnf8/96FBG3KV+DeecuUmSjlkiIU2ZuNak5gomK/Z+8csIetghXzln
         dEaR7LEyXrRP+c5vS7eYcgNyo1zeBV5vx6EXLRzxhGR7sU5kZmGvLGQwiQQqHuoiZN6q
         lsdzDE5i4VCavZQEoVYHfDzvv6gYDS1rBIW12N1AojcIbE0LdTi74S9TyTkAC6L74ZDR
         NkSwLyeBdGdU4AhmkJRMxw1HAKdMr9chrh5SiDEWpHB5vfGYec9xXEHjrtksVUuROMq5
         dAOg==
X-Gm-Message-State: AOJu0YwoXTt1FCzJTrJdpdOkuLQgSaNHkKjEDMqrRehqR09BSEVJJ4fm
	zspHpDRHTLJ2/C5LGN1ENUUD2Kd6Upzps67pUY/x3L3La6ScqDxad6jFI9EyZlk/rTTdnQPzSrM
	tLEAdeBdwiSj+5itI7UpGH+TueBsYanWg
X-Google-Smtp-Source: AGHT+IFaVRYtBoA99rCi/KjYzKeNgVwFeIgYZgq5dWxUMyzGtDCnTSfzhGUR8HNNTajy0y++aTT2hiPc4EpE3sIysKQ=
X-Received: by 2002:a17:90a:6fa1:b0:2cb:4c32:a7e4 with SMTP id
 98e67ed59e1d1-2da55950c60mr3548728a91.15.1725375542441; Tue, 03 Sep 2024
 07:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com>
 <CAEjxPJ758jx7X5Tauz=xQXsmWcZhx_V7AkU=PtsH6S3S9CUCbw@mail.gmail.com>
 <CAEjxPJ50ADVSOys58eYUktv4sjYYnEDroxA9Wnt6HiY9ySk=gg@mail.gmail.com>
 <CAEjxPJ6QsYR-Kj8k0C=54cix8rdpBsCphDV5_QnjGONDuOm+ew@mail.gmail.com>
 <CAEjxPJ6p3oD99_aTEeSCx6FMob7BH8-2vxdoT69c8sw11oHuEA@mail.gmail.com>
 <CAEjxPJ5jup5o9piVPuA97_radSzvshpnRB1CdBde8sV3ZXVc2Q@mail.gmail.com>
 <CAEjxPJ7UtCjQw=v1--6ZWXo-bbkndGbwfXhcT8RkX_cddjCqkQ@mail.gmail.com>
 <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com>
 <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com>
 <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com>
 <CAEjxPJ7C41QdEgAFYVdTyZE=TjGq+pyzCmy7BbHMss7=njvJmg@mail.gmail.com>
 <CAHC9VhRDF0DBAWM-=ynks1=Zm5LcQYq0_4xfQy4pKvHfW6FoBg@mail.gmail.com> <9aa53afd-efd8-4552-8239-14f99ff7a1b1@schaufler-ca.com>
In-Reply-To: <9aa53afd-efd8-4552-8239-14f99ff7a1b1@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 3 Sep 2024 10:58:51 -0400
Message-ID: <CAEjxPJ6vyDjmwxEpwnb+JYKiWXYFo5g_suZiUZb6L+aepHxZiA@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:02=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 8/8/2024 1:53 PM, Paul Moore wrote:
> > On Thu, Aug 8, 2024 at 7:59=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> On Wed, Aug 7, 2024 at 1:02=E2=80=AFPM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >>> On Tue, Aug 6, 2024 at 12:56=E2=80=AFPM Stephen Smalley
> >>> <stephen.smalley.work@gmail.com> wrote:
> >>>> With these changes applied, the following sequence works to
> >>>> demonstrate creating a new SELinux namespace:
> >>>> # Ask to unshare SELinux namespace on next exec
> >>>> $ echo 1 > /sys/fs/selinux/unshare
> >>>> # Unshare the mount and network namespaces too.
> >>>> # This is required in order to create our own selinuxfs mount for th=
e
> >>>> # new namespace and to isolate our own SELinux netlink socket.
> >>>> $ unshare -m -n
> >>>> # Mount our own selinuxfs instance for our new SELinux namespace
> >>>> $ mount -t selinuxfs none /sys/fs/selinux
> >>>> # Load a policy into our SELinux namespace
> >>>> $ load_policy
> >>>> # Create a shell in the unconfined user/role/domain
> >>>> $ runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/=
bash
> >>>> $ setenforce 1
> >>>> $ id
> >>>> uid=3D0(root) gid=3D0(root) groups=3D0(root)
> >>>> context=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> >>>>
> >>>> NB This new namespace is NOT currently confined by its parent. And
> >>>> there remain many unresolved issues.
> >>> A couple of additional changes pushed, one to fix a bug in the inode
> >>> handling and another to introduce support for revalidating superblock
> >>> SIDs and updating them as needed for the namespace. With these
> >>> changes, the selinux-testsuite filesystem-related tests appear to pas=
s
> >>> within a new SELinux namespace. Other tests vary - some pass, some
> >>> fail, some hang.
> >> I think before we proceed further with the SELinux namespaces support,
> >> we need to decide on how we are going to handle SIDs since that has a
> >> significant impact on the approach. There are (at least) two options:
> >> 1) SIDs are maintained per-namespace; this is the current approach in
> >> the patch series since the existing SELinux SID table (sidtab) is
> >> actually a mapping from SIDs to security context structures, not
> >> strings (with the exception of undefined contexts with the deferred
> >> mapping support), where the structures contain the policy indices for
> >> the relevant user/role/type/level.
> >> 2) SIDs are maintained globally, e.g. we introduce a new SID table
> >> outside of the security server that maps SIDs to security context
> >> strings (hence policy-independent). This would be more akin to Smack's
> >> known label list that is also used to assign SIDs, and would provide a
> >> stable pointer for context strings that could be cached in the inode
> >> security blobs without needing to maintain per-inode copies of the
> >> context strings.
> >>
> >> I started with approach #1 because that was how the existing SID table
> >> works within SELinux. However, approach #2 has a number of advantages:
> >> - It matches the LSM hook interface handling of secids, which assume
> >> that secids are global identifiers and allows kernel data structures
> >> outside of LSM to cache and pass secids back into the LSM later, e.g.
> >> for audit and networking.
> >> - It avoids the need to revalidate and re-map SIDs in the object
> >> security blobs prior to each use since they would be global,
> >> eliminating the complexity associated with
> >> __inode_security_revalidate(), sbsec_revalidate(), and doing the same
> >> for all the remaining object security blobs.
> >> - It would remove the need to instantiate the network SID caches
> >> (netif, netnode, netport) per-namespace.
> >> - It would potentially allow for a global AVC (currently
> >> per-namespace) aside from the question of how to handle the policy
> >> seqno and when to flush the AVC (e.g. introduce a global policy seqno
> >> that is incremented on any reload in any namespace?).
> >>
> >> Given these advantages, I am inclined to switch to approach #2. Though=
ts?
> > I agree.  I gave this some thought when I was thinking about how to
> > handle persistent storage and I think adopting option #2 (global SIDs)
> > would help simplify things significantly.
>
> You can achieve a significant performance improvement as well if
> we change the SID interfaces to use pointers into the SID table
> instead of SIDs. v39 of the stacking patch set included a struct
> lsmblob that would make this easy. Alas, there remain some networking
> interfaces that will require u32 SID interfaces for the foreseeable
> future, so SIDs can't be abandoned completely. I also question whether
> this might be the issue that fully brings the security server layer
> into question.

For those following along, I have pushed a commit that introduces a
global SID table [1].
It does not yet change any code to start using this global SID table,
so that's next.
Rather than introduce yet another data structure, I reused the
existing SID table structures and code.
For the global SID table, we only use the SID and the context str, len
fields for all entries.
If we later decide to optimize the global SID table more specifically,
that can be done easily enough.

[1] https://github.com/stephensmalley/selinux-kernel/commit/9a36707bbf26aea=
ac39fed27cd0419949241317d
