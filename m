Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182830E852
	for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750367943; cv=none; b=Uw41YI/Zaz8gbYWsZKyNAC0C5vw/HN7534bi15BQvAmnsIUrEC0eiOm8lhYIVp8Hh1ZEmcEDOOO4Bh/tzDbo8X49YPYSvy6uIZOzdlasIHYiHT4HPHdS/6xOBub3MSEHLT/dsdB7OW0QJ44bQY6P4hKZsWSNE5wtHiUB0us5DeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750367943; c=relaxed/simple;
	bh=43N9xSLqG8Mvf1evULiPV3dhUbzzkfegXMMlVgJmLmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIsvIGMXvW6VJic9vL4wJ3v94v+b8b0kUNEpMej2jah+oTe6woi2shRJu2Ro18x8MhtOpUVI297bd71yq1GfzTK6b8GOYM5SFRWsfYETM/QSVN2DsNY4CWAVZWjNtlPk3whSka1ys6n4rKtlokH4mihbRNEn1q1NNu0Bw8tzrP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E+cJDysw; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E+cJDysw"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e81f8679957so1131479276.2
        for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 14:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750367940; x=1750972740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7reZQjMhm+dclXhsOljn44+uNt88uw72bwAiTZN+zs=;
        b=E+cJDyswwCd3O1ohVQNJiyY5eOa0jtJG+bh6ZhltL81dbG/GCbHysWF05E4h1ERuRy
         5m2LKxrLUkSDOCU4dYry+AJq2deT5henQP2QO7rE1MdJgkvzeKRraS1rHCfYuEqOeyl+
         Hjlc5RK+v4pBI25h7GsrGJLHLw0QRMB/XjYXeFZlNnTt63ug9uX7HYVvVmv3Kx3LgCdA
         77CKL4E6RMTbTmX2PRTgA4aski0Xm2/BJ+oHVAsTk140fbd0RZ1UrH+RiBIPT9d6L24d
         KOOFetthlX5SvcTG4XH1ARSDK6BjU5zdRU5XNwSfv9oZOpqzmC3ML9AyGmBjlXX2yJpY
         ZeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750367940; x=1750972740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7reZQjMhm+dclXhsOljn44+uNt88uw72bwAiTZN+zs=;
        b=Wy4c2oS/4lPXKFjxFyuaPiCYRA0DZ1tHzRst0c6LEzlxon7A7yFcCKoBnGF/S26+wm
         7nHuSEMUlM9pA7wTlSLSvyJd8qxHcPwUctfiIEQ7UGvdpqhG9lotNsubdSxVmdEnaSPq
         ghr8tqASGRz+JsQaEVME+DfBCSsea/VjK/FnIrWtRycjjmJNSnKDofeTOpVoWsw7Qwtw
         WmNA2POhKxoE3noOjBa0Mb+7ikMZmtCPf8elkmFgW7iwhC7lrQjxppe5KsKBi9q8Q6+P
         uRwiojOC07TlDPIwnTPkxy9PHqKU9+tpoznVT2P+CwSqSk2KT8ufQd4k+BvPr1MByNuT
         hyuw==
X-Forwarded-Encrypted: i=1; AJvYcCUWCVnlHPd4mDuc7oTZH7oZcF3hmclQVTD4uLTZpCOquY0d2G2LGhRUHXob70YRF0QfDEIEtFX9@vger.kernel.org
X-Gm-Message-State: AOJu0YwnytgrpA8BtsfjxFDM7fyv1x8aQgkpNoFeiqr0qznnwyL5oTVy
	hNafqDA+e61c8o4OLz9JQQhH5wgELaZFu+k5uwK/dv0Ig406PxWsCRa7GbGySmgGXevuWk6aj0Z
	kJvFcljwVKIHuT9EJTn3Bo0w8yUd4ewECx34cMGNg
X-Gm-Gg: ASbGncsW+f3/m5D6RvIirNnvt5vo9VzJ+PxRZl7y9S+8Jtg78fwhlZu9n1COo5Y1/0A
	2jtk3KcDeDFVhsTxCJA5uQOWkdzfZlPVzda7gCP+XXPwZog7em3/PO55N7Io6JPl19DizPVZZaZ
	cUIlwXoxED82YRxDhiuy9nk1YgzpT8mF898qvUjiHu630=
X-Google-Smtp-Source: AGHT+IGuYWqaT27fYmWdeDZ9lvr/78HUoiTAJ+pb8mrK6LB7RxNHDSBjtW66gCKrmHYUPLvXFfpMQPNhl/c9KrbuTKM=
X-Received: by 2002:a05:690c:610f:b0:70e:1aa1:63b4 with SMTP id
 00721157ae682-712c65125d6mr9891227b3.38.1750367940400; Thu, 19 Jun 2025
 14:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
 <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com> <6797b694-6c40-4806-9541-05ce6a0b07fc@oracle.com>
In-Reply-To: <6797b694-6c40-4806-9541-05ce6a0b07fc@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Jun 2025 17:18:49 -0400
X-Gm-Features: AX0GCFu9kjUfnfMnqfxH4agmkNzznUIDL4onDD-B6Nh-8MzRljESBgn1ZFaZ0Ts
Message-ID: <CAHC9VhQsK_XpJ-bbt6AXM4fk30huhrPvvMSEuHHTPb=eJZwoUA@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 5:03=E2=80=AFPM Anna Schumaker
<anna.schumaker@oracle.com> wrote:
> On 5/20/25 5:31 PM, Paul Moore wrote:
> > On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >>>
> >>> Update the security_inode_listsecurity() interface to allow
> >>> use of the xattr_list_one() helper and update the hook
> >>> implementations.
> >>>
> >>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.s=
malley.work@gmail.com/
> >>>
> >>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >>> ---
> >>> This patch is relative to the one linked above, which in theory is on
> >>> vfs.fixes but doesn't appear to have been pushed when I looked.
> >>>
> >>>  fs/nfs/nfs4proc.c             | 10 ++++++----
> >>>  fs/xattr.c                    | 19 +++++++------------
> >>>  include/linux/lsm_hook_defs.h |  4 ++--
> >>>  include/linux/security.h      |  5 +++--
> >>>  net/socket.c                  | 17 +++++++----------
> >>>  security/security.c           | 16 ++++++++--------
> >>>  security/selinux/hooks.c      | 10 +++-------
> >>>  security/smack/smack_lsm.c    | 13 ++++---------
> >>>  8 files changed, 40 insertions(+), 54 deletions(-)
> >>
> >> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
> >> folks I can pull this into the LSM tree.
> >
> > Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some ACKs
> > on this patch?  It's a little late for the upcoming merge window, but
> > I'd like to merge this via the LSM tree after the merge window closes.
>
> For the NFS change:
>     Acked-by: Anna Schumaker <anna.schumaker@oracle.com>

Hi Anna,

Thanks for reviewing the patch.  Unfortunately when merging the patch
today and fixing up some merge conflicts I bumped into an odd case in
the NFS space and I wanted to check with you on how you would like to
resolve it.

Commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
security label")[1] adds a direct call to
security_inode_listsecurity() in nfs4_listxattr(), despite the
existing nfs4_listxattr_nfs4_label() call which calls into the same
LSM hook, although that call is conditional on the server supporting
NFS_CAP_SECURITY_LABEL.  Based on a quick search, it appears the only
caller for nfs4_listxattr_nfs4_label() is nfs4_listxattr() so I'm
wondering if there isn't some room for improvement here.

I think there are two obvious options, and I'm curious about your
thoughts on which of these you would prefer, or if there is another
third option that you would like to see merged.

Option #1:
Essentially back out commit 243fea134633, removing the direct LSM call
in nfs4_listxattr() and relying on the nfs4_listxattr_nfs4_label() for
the LSM/SELinux xattrs.  I think we would want to remove the
NFS_CAP_SECURITY_LABEL check and build nfs4_listxattr_nfs4_label()
regardless of CONFIG_NFS_V4_SECURITY_LABEL.

Option #2:
Remove nfs4_listxattr_nfs4_label() entirely and keep the direct LSM
call in nfs4_listxattr(), with the required changes for this patch.

Thoughts?

[1] https://lore.kernel.org/all/20250425180921.86702-1-okorniev@redhat.com/
--=20
paul-moore.com
