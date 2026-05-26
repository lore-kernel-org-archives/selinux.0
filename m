Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB428A3FA;
	Tue, 26 May 2026 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822146; cv=none; b=L7xm2rdmOLwyPzdEPWI0pskRYXek3JSUlyeK4kRLjql1q71OOPWoMVW7xHRG8k3eTIkV5jqYjUwm3lv5FabmWRky8/sN7MYLXtGQd1dgJY5GjyIc1MimW/YTdtz/Zz2R90v4V4H0y6t+XX1b3fA3BnpLDTvbliSFbxS/Ep+hxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822146; c=relaxed/simple;
	bh=Dg25kT/nldcEh4mtki/4UVWoKJniYzPKsYOYb9IHb6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfU00UsSvdHeF1sDrjGdGE/zK3rdDBJBCFUl09MMyrp+RkkUbxYT49k9qPdX18AXuYKm/M35t8C6wHKDK/2+eA1zgSp0jqciOyb/8zdPDwR5g4d16K0Eorsajdr0uccZ4+gePLy+4eOkNjwZvJUHsoAM8GuHtG9mYGyZjCkGmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=SbeF8Lh3; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="SbeF8Lh3"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received; s=oak1; t=
	1779822140; x=1780686141; bh=Dg25kT/nldcEh4mtki/4UVWoKJniYzPKsYO
	Yb9IHb6U=; b=SbeF8Lh3UU5RWqR0JADOdVy+Eslse5/aPQhwjXnkgdBTliOI0jF
	F1WX7PELbSS/jd/EUXwHQarswb6yyVOCq/zwza8yL1ajp2/lXhpsngWe7BuoZV35
	y+MiPqWPTUb8HT7IWCW1mTDkVP7WCKq2mZ8Gu9C46e6apD4EKJHy+2V90uVxk6Zi
	68Mv8z8XcjwzdbMXxrCqWabkxZJczm4ZHkPib3aheEFKGotwm9B/+W19D2X80n+k
	N1GoUVg1qrvT6VZd1XZy/L3RAxWnmxS/kpNGGybk0+7kpRvunDyy6P0GfB7LRqg2
	9UmEMi+lidg8yeglMn3kwnebb2ErtpXdIcw==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Tue, 26 May 2026 21:02:20 +0200 (CEST)
Date: Tue, 26 May 2026 21:02:18 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Masahide NAKAMURA <nakam@linux-ipv6.org>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v8 14/14] xfrm: add
 documentation for XFRM_MSG_MIGRATE_STATE
Message-ID: <ahXuOr8Wz4CMcZXu@Antony2201.local>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-14-4578fb016965@secunet.com>
 <agHSPUBZg0tHezM-@krikkit>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agHSPUBZg0tHezM-@krikkit>

On Mon, May 11, 2026 at 02:57:33PM +0200, Sabrina Dubroca wrote:
> Overall a very document, thanks. Some comments:
>
> 2026-05-05, 06:34:55 +0200, Antony Antony wrote:
> > +    struct xfrm_user_migrate_state {
> > +        struct xfrm_usersa_id  id;       /* spi, daddr, proto, family */
> > +        xfrm_address_t         new_daddr;
> > +        xfrm_address_t         new_saddr;
> > +        struct xfrm_mark       old_mark; /* SA lookup: key = v & m */
> > +        struct xfrm_selector   new_sel;  /* new selector (see Flags) */
> > +        __u32                  new_reqid;
> > +        __u32                  flags;    /* XFRM_MIGRATE_STATE_* */
> > +        __u16                  new_family;
> > +        __u16                  reserved;
> > +    };
>
> Thinking about the UAPI a bit more, maybe this would be a good time to
> start introducing a "proper" netlink API for XFRM? Instead of having
> the main properties in a fixed struct, and a few attributes as an
> afterthought, use attributes as the main way to exchange information?
>
> Then we can start adding the attributes as alternative to the fixed
> headers in some other ops, and later start deprecating the current
> API?
>
> (for some reason this thought only popped up when I had the html
> rendering in front of me, sorry it's so late in the process)

Interesting thought. However, when adding selector support I considered
this, and realized it would require introducing several new XFRMA attributes to
cover the fields currently in several fixed struct. That is a larger
change and out of scope for this series.
In general I go back forward on this.

> [...]
> > +Flags
> > +=====
> > +
> > +The ``flags`` field in ``xfrm_user_migrate_state`` controls optional
> > +migration behaviour. Unknown flag bits are ignored.
>
> Maybe better to reject unknown flag bits (as well as unknown
> attributes beyond XFRMA_MAX), so that we can fully control their
> behavior, and not risk incorrectly migrating an SA if a "too-recent"
> userspace passes attributes we don't know (then if we fail to handle
> them in the kernel, the SA may not handle the traffic).
>
> (Steffen and you will have a much better understanding of the security
> risks here than me)

Good point. Done in v9.

Unknown flag bits are now rejected with -EINVAL. The extended ACK message
reports the specific unrecognised bits, e.g.:

  "Unknown flags: 0x4"

A new UAPI constant XFRM_MIGRATE_STATE_KNOWN_FLAGS is added to
<linux/xfrm.h> so userspace can validate flags before sending:

  if (flags & ~XFRM_MIGRATE_STATE_KNOWN_FLAGS)
          /* flag not known to this kernel header version */

Note: this constant reflects the flags defined in the header userspace
was compiled against, which may differ from what the running kernel
accepts. The documentation is updated accordingly.

-migration behaviour. Unknown flag bits are ignored.
+migration behaviour. Unknown flag bits are rejected with ``-EINVAL``; the
+extended ACK message identifies the unrecognised bits (e.g. ``"Unknown flags:
+0x4"``). Userspace can use ``XFRM_MIGRATE_STATE_KNOWN_FLAGS`` (defined in
+``<linux/xfrm.h>``) to validate flags before sending; note that this constant
+reflects the flags known to the header version userspace was compiled against,
+which may differ from what the running kernel accepts.

>
>
> > +Migration Steps
> > +===============
>
> maybe add:
>
> Userspace is expected to:
>
> > +#. Install a block policy to drop traffic on the affected selector.
> > +#. Remove the old policy.
> > +#. Call ``XFRM_MSG_MIGRATE_STATE`` for each SA.
> > +#. Reinstall the policies.
> > +#. Remove the block policy.

The section is restructured in v9 into Outgoing SA and Incoming SA
subsections. The outgoing procedure is introduced with "To prevent
cleartext traffic leaks, install a block policy before migrating:"
rather than a  mandate - userspace can make an informed choice
depending on the AEAD in use. The incoming section explains that no
block policy is needed and advises being liberal in acceptance to
avoid packet loss during the migration window.

> > +
> > +Block Policy and IV Safety
> > +--------------------------
> > +
> > +Installing a block policy before migration is required to prevent
> > +traffic leaks and IV reuse in counter mode.
> > +
> > +AES-GCM IV uniqueness is critical: reusing a (key, IV) pair allows
> > +an attacker to recover the authentication subkey and forge
> > +authentication tags, breaking both confidentiality and integrity.
> > +
> > +``XFRM_MSG_MIGRATE_STATE`` atomically copies the sequence number and
> > +replay window from the old SA to the new SA and deletes the old SA.
> > +The block policy ensures no outgoing packets are sent in the migration
> > +window, preventing IV reuse under the same key.
>
> Does it matter that the copy is done atomically if we expect userspace
> to install a block policy? (without the block, I'll have to recheck to
> convince myself whether it would be safe, and TBH I'm still a bit
> confused by patch 8)

The Block Policy and IV Safety section is clarified in v9. The block
policy serves two purposes: (1) prevent cleartext traffic leaks during
the migration window, and (2) for AES-GCM, prevent IV reuse by
ensuring no outgoing packets are sent under the same key.

The atomic copy complements the block policy for outgoing — together
they eliminate both risks. For incoming SAs the atomic copy is the
primary mechanism: it ensures replay protection continues without a
gap. The block policy is not needed on the incoming side.
>
> > +Feature Detection
> > +=================
> > +
> > +Userspace can probe for kernel support by sending a minimal
> > +``XFRM_MSG_MIGRATE_STATE`` message with a non-existent SPI:
> > +
> > +- ``-ENOPROTOOPT``: not supported (``CONFIG_XFRM_MIGRATE`` not enabled)
> > +- any other error: supported
>
>
> xfrm_user_rcv_msg
>
> if (type > XFRM_MSG_MAX)
>         return -EINVAL;
>
>
> Userspace will hit that on a kernel that may have migrate but not
> XFRM_MSG_MIGRATE_STATE, no?

Good catch. Fixed in v9: three cases are now documented — -EINVAL
(kernel predates the message type), -ENOPROTOOPT (CONFIG_XFRM_MIGRATE
disabled), -ESRCH (supported). Probe uses a non-zero non-existent SPI
to avoid conflating the SPI=0 validation -EINVAL with the
type-out-of-range -EINVAL.

>
>
> [...]
> > +Error Handling
> > +==============
> > +
> > +If the target SA tuple (daddr, SPI, proto, family) is occupied by an existing
> > +unrelated SA, the operation returns ``-EEXIST``.
>
> All this happens under xfrm_cfg_mutex, so if we did an initial lookup
> for the new SA before starting the operation, we could ensure there's
> no dupe, and the mutex would guarantee no insertion. No?

Done in v9. A pre-check lookup is added before cloning when the SA
tuple changes (new daddr or new family). If the new tuple is already
occupied -EEXIST is returned while the old SA is still intact, safe
to retry. The install failure path comment is updated to reflect it
is now a safety net only.

-antony
