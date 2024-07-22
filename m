Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB104C7D
	for <selinux@vger.kernel.org>; Mon, 22 Jul 2024 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629306; cv=none; b=JTwXsfNdVWGcdmliVJtfdMOERCaoGa8WZHZFoYd6F4tACU5Hxht2rx0ubwy2I6TjSI7fYx3lesz4uJFZqupe7u6mwI/Zo9YzxXjBtSwNNfH4Ampvfp6utHFG89J1oGcmu0RLYBb2YUztf1jdrzLzREMTlh0AnzlXbYPrjP1Ii4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629306; c=relaxed/simple;
	bh=ad/2j7lB4CubF7adhe7Zb4ERf0b7u2D8BHbp839qJtc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bBNFNkjDk9DtCV7xxJUAMEaulMEnjTSg2ehCQLlelauOAWQylaA0TOtMkgWvxxyX2DGtitK1adFtV0tp0bV9DdmKuVTbnygaZYtB/uOFqTsNSg52GQoeQAQMeqoLLxL3GyDMliHBGH1uuMsmduIEDcQNJN6qVPZWcyeT6JJZ+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpwKsrA8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpwKsrA8"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso3223801276.1
        for <selinux@vger.kernel.org>; Sun, 21 Jul 2024 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721629303; x=1722234103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LnEbcX9X1CIinsMg0GG7qx0fPkNngHTDh6GA/r4M+K8=;
        b=dpwKsrA8WicvThJ5XXLTVf5QUEfmFSmZ65962HvLOtUszrt3M8+AB5IxbIk9alyiDb
         iyic3YgjMYTU5NC8jupUelPJHVIoAXbtL4ErDBA6fb3c2AnIRf2v2WyiySejETeE5I6T
         Z/1e9FaBQBPydJGXEZ2YFXJI54olBswFK2RoY7xebCKxtDTnTO0ypniRWg8b0+zio0EI
         v1l9Y28yJiuncUJz3ZovP5XU+gYR0ZyWjoLbCYu6CSsjG3TqELaFUjKNev/PAa0sdH8B
         N9/8z66ectfEkp+cmLiyH3QR35B/l7SfHtx0wBC5ilZ384HKYQppoqbuMvyXFCmqyZm+
         5NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721629303; x=1722234103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnEbcX9X1CIinsMg0GG7qx0fPkNngHTDh6GA/r4M+K8=;
        b=RbFzKA7RYoWQb54AD/fqEQyc+1c+V5attxkh7R/ylqRzW7mdFVzq7mTcQoPypy/7dy
         zHK9XBQyPyopL8eX7r68Sir2uRrGJElfXmKfkX8w1unW7orrcSLK8s+jYlpJOm5faQWP
         fyQWeGyowsbiZzAuOOSYwSyxIAMR5alPvomvpy7nr/leCVJoJB8PZgqJ1MSsaLVXGGS0
         M3D59vVkWMihoF9XFUoIdYGGRCwqNeLFpv50nFjb/6UceUnCVnYGhwa22LbQuajIisFw
         pdIwPOrCifwgYxAoPxZymWFHJG9m3pNLX5DQHFDgPsTUCoN6IR2t4UQGHDGAToLEcbhq
         8nPg==
X-Forwarded-Encrypted: i=1; AJvYcCXwJxnWQpsCQFb7kq56VvIrUQSjFR8HO8eiwG9pYNHh0HzK9ORwvUrY9Mxn7bYGAJcvntNYc4f1Lguyqo4llR/2L/zZ+hvC8Q==
X-Gm-Message-State: AOJu0YyR8D2zR8nc55ZGjjJjX+0XeWD+u4wL0rmLD2FgsZVIM3lXuKAn
	inO6yDVUDN4OuAR2Zk11tSBq9xzwl0ztrfMzJFTcfKjrDAI8EHNAfIMG2Q+H0Eyr2WHOIvg5Fg=
	=
X-Google-Smtp-Source: AGHT+IH6WB6w5yIZVg0N4QNIhc8C1CVUFMUPD9OMHEY8GJfnWYlg1DbeTGZDUwbEW3mjnTjZLIl7J/gdAQ==
X-Received: from tweek-syd.c.googlers.com ([fda3:e722:ac3:cc00:b7:3870:c0a8:26])
 (user=tweek job=sendgmr) by 2002:a05:6902:188e:b0:dfd:da3f:ad1c with SMTP id
 3f1490d57ef6-e086fd1c0eamr266704276.4.1721629303483; Sun, 21 Jul 2024
 23:21:43 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:21:39 +1000
In-Reply-To: <CAHC9VhSFAj5Nr010pURESOX13kfAuj3NYGmG3Xt4bCRPYuJuiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHC9VhSFAj5Nr010pURESOX13kfAuj3NYGmG3Xt4bCRPYuJuiA@mail.gmail.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240722062139.1740728-1-tweek@google.com>
Subject: Re: [RFC PATCH] selinux: Add netlink xperm support
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: paul@paul-moore.com
Cc: brambonne@google.com, jeffv@google.com, sds@tycho.nsa.gov, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"

> > > > Reuse the existing extended permissions infrastructure to support
> > > > sepolicy for different netlink message types.

(Following up on this patch).

> > > >
> > > > When individual netlink message types are omitted only the existing
> > > > permissions are checked. As is the case for ioctl xperms, this feature
> > > > is intended to provide finer granularity for nlmsg_read and nlmsg_write
> > > > permissions, as they may be too imprecise. For example, a single
> > > > NETLINK_ROUTE socket may provide access to both an interface's IP
> > > > address and to its ARP table, which might have different privacy
> > > > implications. In addition, the set of message types has grown over time,
> > > > so even if the current list is acceptable, future additions might not be.
> > > > It was suggested before on the mailing list [1] that extended permissions
> > > > would be a good fit for this purpose.
> > > >
> > > > Existing policy using the nlmsg_read and nlmsg_write permissions will
> > > > continue to work as-is. Similar to ioctl xperms, netlink xperms allow
> > > > for a more fine-grained policy where needed.
> > > >
> > > > Example policy on Android, preventing regular apps from accessing the
> > > > device's MAC address and ARP table, but allowing this access to
> > > > privileged apps, looks as follows:
> > > >
> > > > allow netdomain self:netlink_route_socket {
> > > >         create read getattr write setattr lock append connect getopt
> > > >         setopt shutdown nlmsg_read
> > > > };
> > > > allowxperm netdomain self:netlink_route_socket nlmsg ~{
> > > >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > > > };
> > > > allowxperm priv_app self:netlink_route_socket nlmsg {
> > > >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > > > };
> > > >
> > > > Android currently uses code similar to [1] as a temporary workaround to
> > > > limit access to certain netlink message types; our hope is that this patch
> > > > will allow us to move back to upstream code with an approach that works for
> > > > everyone.
> > > >
> > > > [1] https://lore.kernel.org/selinux/CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com/
> > > >
> > > > Signed-off-by: Bram Bonne <brambonne@google.com>
> > > > ---
> > > >  security/selinux/hooks.c       | 24 +++++++++++++++++++++++-
> > > >  security/selinux/ss/avtab.h    |  1 +
> > > >  security/selinux/ss/services.c | 23 ++++++++++++++++++++++-
> > > >  3 files changed, 46 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index e7ebd45ca345..a503865fabed 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -4662,6 +4662,28 @@ static int sock_has_perm(struct sock *sk, u32 perms)
> > > >                             &ad);
> > > >  }
> > > >
> > > > +static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_type)
> > > > +{
> > > > +       struct sk_security_struct *sksec = sk->sk_security;
> > > > +       struct common_audit_data ad;
> > > > +       struct lsm_network_audit net = {0,};
> > > > +       u8 xperm;
> > > > +
> > > > +       if (sksec->sid == SECINITSID_KERNEL)
> > > > +               return 0;
> > > > +
> > > > +       ad.type = LSM_AUDIT_DATA_NET;
> > > > +       ad.u.net = &net;
> > > > +       ad.u.net->sk = sk;
> > > > +
> > > > +       // nlmsg_types comfortably fit into a single driver, see RTM_MAX in uapi/linux/rtnetlink.h
> > > > +       xperm = nlmsg_type & 0xff;
> > >
> > > This seems like a dangerous assumption; obviously not all netlink
> > > users are rtnetlink. Even if all existing netlink users follow this,
> > > nothing prevents userspace from creating a netlink message that
> > > violates it AFAIK, at which point you will just silently discard the
> > > higher bits. If we think we can get away with this restriction, then
> > > we need to enforce it here (i.e. return an error if they do not fit);
> > > if not,
> > > then we likely need to support multiple drivers with a simple mapping
> > > of the upper bits to driver.

Agreed. Mapping the upper bits to the driver field would work. 

In this case, AVTAB_XPERMS_NLMSG proposed here would have the exact same
implementation as AVTAB_XPERMS_IOCTLFUNCTION. An option could be to rename the
AVTAB_XPERMS_IOCTLFUNCTION constant (for example, to AVTAB_XPERMS_PERMS, and
similarly moving AVTAB_XPERMS_IOCTLDRIVER to AVTAB_XPERMS_DRIVER). This is
describing more how struct avtab_extended_perms is being used rather than
focusing on its original meaning. (That is, the driver and perms fields are
historically related to ioctl, but they have their own meanings in the xperm
implementation).

The alternative is simply to have that new constant (AVTAB_XPERMS_NLMSG, maybe
renamed to AVTAB_XPERMS_NETLINK_MSGTYPE, to be more explicit?).

> >
> > Looks like generic netlink puts the family id into the message type
> > field, with the actual command in the separate generic netlink header
> > in the payload. generic netlink family ids appear to be dynamically
> > allocated, with GENL_MAX_ID defined as 1023. genl-ctrl-list on a
> > sample Linux system reports ids from 0x10 through 0x1f so those would
> > fit but there isn't anything in the code to prevent higher ids from
> > being allocated up to the max. And if someday you want to be able to
> > filter generic netlink messages at the per-command level, you'd
> > further need to deal with the separate cmd field.
> 
> There is also NETLINK_AUDIT which currently has message types defined
> up to 2000.  The netlink message header format allows for 16 bit
> message types (look at the nlmsghdr struct) and I think it would be a
> mistake if the SELinux netlink/xperms code didn't support a full 16
> bits for the message type.
> 
> As far as NETLINK_GENERIC is concerned, yes, that's a bit of a
> nuisance both with the dynamic family IDs and buried message types.
> On the plus side, there are existing kernel functions that will
> resolve the generic netlink family IDs to a genl_family struct but
> those are currently private to the generic netlink code; I imagine if
> there was a need those functions (or something similar) could be made
> available outside of the genetlink.c.  Once you've matched on
> NETLINK_GENERIC and done the family resolution, it should just be a
> matter of doing the generic netlink command lookup in the context of
> the family, which really shouldn't be much different than looking up
> the message type of a conventional netlink message.

I can see how the resolution for cmd can be done, but I am not sure how the
family should be handled. I don't think it is ok to not correlate the family to
some data in the policy. Otherwise, it would be possible to reach a different
generic netlink family (with the same operation number of an operation granted
for a generic family in the policy). This means we should at least match on the
family name, but I doubt we can use the current struct avtab_extended_perms for
that.

For now, an option is to fallback to regular permission checks (avc_has_perm)
if the class is NETLINK_GENERIC. (This would mean that we don't make a call now
on how NETLINK_GENERIC should be handled, and keep the options open for a
decision in the future). In this case, an error would be raised if trying to
load a policy with extended permissions for that class (as nlmsg_type has no
static meaning).

