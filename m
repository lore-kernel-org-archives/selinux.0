Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7371422AB
	for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243384; cv=none; b=f+vfdqo6L0DvrD3eHVrxtGjkGnuY8rOi6ai0PacanGm72KgVHQ8AjDqdC6HJtnZyGyQuaup/MiR4nFp9/j0obDIw0sl8voVnTFP0PL2ZzVUHryBJsVliY/GTtX0082obKEc5uAABMHwWkZVPIOoSsG/69OI0AjVqldL2UtHMZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243384; c=relaxed/simple;
	bh=Ut4R8kljdeSHmBSOWlAz7KbZ3iGwHGKnHnQG8imaXEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsU7+lHS/HGhnZHvTB8bw8YqniMuLNmKTHDHwarOYCKzYSEs4p5yMQexwCw3cxw+fWgLRWC/row8bnOefTjPUNazyjFVDqqsi5LjO4W1BoxtK70+3jMaBH3plcHGLu6lI+ebPPTJn7oksBIB/1LJ4SKDpitd50t5xmevaGwZ+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gJ9ibmL8; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gJ9ibmL8"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so3855732276.3
        for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742243380; x=1742848180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USgnuXSkWNxVod9/HaDbRut81CKuV+cFsZQEm8UjkR8=;
        b=gJ9ibmL80IQ9qABlE1dQkHnDcDuveA635uyWZvzhXvPvTl0IG59CezzYffNiPZt44C
         Blu7oI4NMdEe4H/+U0z0P1PXXMd/umln69805LJEotfE5rO5yK1xugv/SVdVK8MuXx/K
         W+XhwH4TwPV+2NbYe120VZoN1HEsTWIKLi130DyEjsWkVdo+PvKN51MvxIulCMOv9tBu
         ctDI0abrmJfeoeixzZgSNLZRi0wrq8rDCwoYW9zDKN6V+n5COTDdu+NcSIlGXy8xvHJ7
         UogHFHTIXKmUTkqLdnxeGIibabUFW4oYCGxoW7TKr5bSHGNz0UERGMA3Oztt/qfkZcDW
         HDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742243380; x=1742848180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USgnuXSkWNxVod9/HaDbRut81CKuV+cFsZQEm8UjkR8=;
        b=RLRLdmz1qqf02+IgVBNG005MzOEfIW2md3YKzFXZu9+FbYMruBhDD++wXxsFdbbfV/
         fCkyCiO37I8PpE4r1GusL4FP5TmRpvPv04VwRmkvspcRx4RElP/mCrCvRz6LfOwF/J7t
         /IF6xSLIod3TQZE139PexqK9UI/m4FMRiXCSnSh6lH4eeZeUoHCeuc2PIUx3QVj0rw8k
         WHuqeEzC8p6Gi2K6QdAzD00IfRxdne5wjfxyu1zvkKNg2AyByo8hqCJSNMq51Rh9Hc0+
         n/LYEINxX3pGe5QmA88VUUR77X/j8pPK6bz9dmHNTVX4uRMKgRBefnI81cWjF2TdRw84
         g9Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWamUUnwHnqdixcRDefzhhk5igWRXaEwvB10AOkU7kj5HbSlSPAk6Zy1vmoxwvTPSZSm22B0OLS@vger.kernel.org
X-Gm-Message-State: AOJu0YzMycJ04IOSsyBsBSEfs+RNerKgFluxOrQV87bdnYvcoB6VlEGs
	07dfBMA1oDts4bKuJMPNAn3J8whLFiSkEmegdE/GVQsi/g7MNwps+JqvCUxmfpzIZDl8yphBnrL
	7PUuOVjR6aq/I43Lg2vRIWYCTREWAPBAqK4Wa
X-Gm-Gg: ASbGncsI2dOzMsLKhbybhZRoaPEs2in0hjp7YOWWaWxHsY7S5XIUguIETeZwydselkY
	iNwwUtgEo6rOyzMFngeyjTUuvqAGp96CYhi7/1ig+fkiZ8AHZN0HKNGZgVaX33+Hm7t3zRmU5o3
	T5r6R+oKwbmtymkrB7FZKn5Sx/Jg==
X-Google-Smtp-Source: AGHT+IG005odM+L3nZ0lzBU0FH3KHki2rwvxUv7HXNOHhJ56WVNlVSSQza7t2zYWnqB08g6Awj/gmcHcbRpvuS+mDVY=
X-Received: by 2002:a05:6902:1144:b0:e5b:1c0a:6cb6 with SMTP id
 3f1490d57ef6-e63f65c530fmr17573385276.36.1742243380228; Mon, 17 Mar 2025
 13:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312080055.8950-1-cgoettsche@seltendoof.de>
 <CAEjxPJ4MAaN7P8ZtCcDhRvNt44LNyzL9azc-xNE54=tkW_4vjQ@mail.gmail.com>
 <CAJ2a_Dc4pNdL8bp_wydmRmQ46GXkWhcA5jTVApF3E415stcA=A@mail.gmail.com> <CAEjxPJ5VuJpcZe-j5auXjviV=79jR2HzWfo-qPFAioRcw6Fi_w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5VuJpcZe-j5auXjviV=79jR2HzWfo-qPFAioRcw6Fi_w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Mar 2025 16:29:29 -0400
X-Gm-Features: AQ5f1Joo_IT04Wmd3GNHv71tlEj32g96RMZeEnFmFCn5iTMsWJuRb8OZGHLjHgI
Message-ID: <CAHC9VhSyEsj4jxKxkJUBLBqu6CXTwZTsraPL4tjosQV6Hv-8iQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: get netlabel_wildcard policycap from policy
 instead of cache
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Mar 14, 2025 at 9:01=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > On Wed, 12 Mar 2025 at 14:04, Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Mar 12, 2025 at 4:01=E2=80=AFAM Christian G=C3=B6ttsche
> > > <cgoettsche@seltendoof.de> wrote:
> > > >
> > > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > >
> > > > Retrieve the netlabel_wildcard policy capability in security_netif_=
sid()
> > > > from the locked active policy instead of the cached value in
> > > > selinux_state.
> > > >
> > > > Fixes: 8af43b61c17e ("selinux: support wildcard network interface n=
ames")
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > Do we have tests for this feature? I didn't see any.
> >
> > No.
> >
> > Is there a way to retrieve the context of a network interface without
> > actually sending packets? (Then one could simply use `ip link add
> > $name_to_test type dummy`).
>
> Not as far as I know. The inet_socket tests should exercise the
> relevant permission checks that use the netif SIDs.

Unfortunately, I don't believe there is a mechanism to simply view the
current label assigned to a network interface; adding something would
be helpful.

The obvious thing would be to add something to iproute2, but that is
going to involve some new LSM APIs to get that information as well as
working with the netdev folks to export it out along with the other
interface info.  It would likely be much easier to add something under
/sys/fs/selinux, and such a change wouldn't prevent us from doing
something in iproute2 in the future.

--=20
paul-moore.com
