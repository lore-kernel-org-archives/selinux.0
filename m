Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1DD4C900E
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285387; cv=pass; b=KlYPws11ShbeqpWqTIzUDkBaCIpx6/oq8YhLUsvMRY94mRb9J6iM8vRGpKsBH2QKStrOqrZ0SudufRxU9ZebgCjwhp6qJrn2chXZ6ZSYLt774f9TJjZkhO4xh/wpZHOacqL2ZJ5RktO9TSPCdDWFZsnWmfaBehPeeQBSXY9n8Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285387; c=relaxed/simple;
	bh=Zo+A9dgWtbkLWwihIhLbsBJ5BLC6xH26OlfUYmZ/0Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okbfCBFHvolj/S/nFmj0atcxTQ4wb4fCjT7pPD2JCDgHToFk5dOkKtFLSVs+3NxUz+g2Pe8ftVQb0lk4JzrNzby8a7M1Q5JbWE3VyQetHHXr0hUYrhVqOjts2N2BwCahx/LPqSDg4D9/DHvD8JjcuKm8baICjSZBkW3A/nE+Ecw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YRKRqjGb; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YRKRqjGb"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5121bcf1aso134320a12.1
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 14:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790285383; cv=none;
        d=google.com; s=arc-20260327;
        b=S2KLIvYo5Ke3vn8PM8hj/sixEvmezlHU+IpxTR+22oQMTwQJChgBs95jWs7GK5JScV
         2ZMQlc1SV3qoV6fBvBiuMIl+l03fNXhhnX/KGHnhoguk95pMKGKaldv/28y44K8GXKTf
         s+/RM6VUI/rpVa1s2yN/2xtr0A9pyebTK1s+hZX+7QFCrilVEHwpQ8wPSUB7f/bCJFbg
         dSVt+xjNJSOzeDIn/QwKJYwh3Gw6pyZiXQJEbEaANLUoiprUVo1hxEBRZsBGiFyyUwxC
         82BtEEQlbPQxgo++AAsapjkf9xweSv0dbPC7tadTFrDuDbq+vW6A3VPYbXkqblBWGa72
         z0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uy4cXDH+T1+KnVgOqeDN0Sz5FRasgF2gAzJF9ejf0Zk=;
        fh=pWuW71YlnTzWTd/DfqNDelv3A9x8mcpzPoaQiY/22W0=;
        b=QDDWl+L3vKmvk8QzfA4E7HnU8xZ49FTmuYVewmn497ZXKiTMopXCt7SeXIWVCNaDdQ
         TJMCx+xo4aM3f50VaLaYAoGdqRPIvo9SFrMNlMernNZV9Ft8SDXuZ5NmDpw3H1Yk9dkd
         htfpuKPJ1aBqXu3EZ7jAZHOy5kuHc5TxSQ08uGKWdm9Na+eHCVr07LZo5RFLqZAd0+rN
         dc8wnPjlodkpdvRkaHp8OqgxZKxcCMwDJMHMx8YmGqhw5vOIBcvOa5rWxeJ/VkQ5Mpa2
         YyRs0niNHJ1ZP45+Vxb6ihWbSfH++bFI8JpgkAGCFvNe2zUsA9u71f2AFGIhlCoQnpoV
         NqWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790285383; x=1790890183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uy4cXDH+T1+KnVgOqeDN0Sz5FRasgF2gAzJF9ejf0Zk=;
        b=YRKRqjGby1GBwVjI+8pp2GPkez0bWus1N/1JYoYq5ae00aUvCXQ6ew4NiNFMe5kojb
         3rhcDex1QLxlkjoXWi52L9ZiF1aHbFSWoZ7oSYx6bbXXEVoCgqe3JGpXt/KuOa6AySbY
         nfcczCiuVzVMJtEy6udmTyJWETa+sTeicu6FKtM3vrKZpO9K58OPoaDyJtQJc8g0XPBk
         /KQxsHXufLAOSdLD/3Ga00MpxGzZQHGFOZ/2jkmiV6wZv2oqx9grHRKo3SvQW73nXVLL
         Nc9zf42uEjkFl7nr/yQDcFZcnGGlHhDGHZhzghUC3If6BkNyh9Dqyw3tICX5zx1BD8RG
         lNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790285383; x=1790890183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uy4cXDH+T1+KnVgOqeDN0Sz5FRasgF2gAzJF9ejf0Zk=;
        b=uXjB32YG31FAU4d1yWIFaMcXt7Cnk7+TUKdVUg0nDt2J5/C3dM8MxuJw5c4BYZaEwG
         Hneh/Yd4UNS9U4pAnTG+zbx/xL9X8ppHBw0pMqvydMIm+Yi/aqOMjGbOW8+8QqQJemru
         03kGTA2x6diE2ukv+G+rcjqhHCVgNipzAhkDoEs1OLcNVdE1PMUm8LigGpEsBaz5Fp9x
         M9V06sLZxowOVqxcl/nwSImJtf45aaHjSJ2szvmP4cscJ4vsB0+My3AGLpsK97HsalUH
         iV75U5ICIB8wh90+QNnVn/crJx0ZA6b4oCHhpWtbNZwfr0Y49aIm+IL8zByMoXuOlvD2
         Bk8w==
X-Forwarded-Encrypted: i=1; AKwUvBz6PtcinBnbl0TcMjjmKs6iavd4r/4kWGdMBE4Cpd+ZoSN1e9li6Qy8IxjUO1EfaFSQeAkbBUFb@vger.kernel.org
X-Gm-Message-State: AFuF++nOyva8e5zgiFpyqmUMBP5G88QjJti6CtNHH+rXNCp37Xzcin3K
	Bb3U0kbQX3UVXDinPr5R/HIIU62PTtkJGgRIcbz76ZIizF6uOqrqFICsSL39RZvvxt9RHAQehKL
	mkcqI33TZOwCDHNjnGnHvAg1RZgE7dhrqO/PJzy0z
X-Gm-Gg: AYBFou1SxjLJAscy9Jhh7W+5fi0VlvK73rpCCmFA0YXYZ3rexdBoUcJh/IhZ03V+CGy
	BOdGYvrrF6nmJ9zD5SQVL6C4RvUJ52stah7D4HUqmbJl1SJYfMMnYXkWKJsvUEkhI7nfHiWgIeO
	KQJ5RzdngHT4pC06Yhvpo+ZmQ2gCpHiKQF1uhTHH1OJX23PCl87AbnXO2DTz5/eNZm7oGK7D3JM
	VcDVBfj2t3PWulcfXYECvL9lRuuElhgOo9zIcciQ/5dt/jtmwWbv7Zx998eOAQPzqN03PmlRqA/
	ovnxpfVd510XwL5c2VIwL9GfqssS1R6K30gQcyvXQSoOuY5Nlejx4wUcYyFWvEFh2dufdTkAomf
	jNHrqyBdNa5zVX/CDm6ipig==
X-Received: by 2002:a05:6a21:9192:b0:3dd:85a8:cb82 with SMTP id
 adf61e73a8af0-3de0e89f90cmr3964374637.37.1790285382785; Thu, 24 Sep 2026
 14:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
 <20260903113538.72942-4-cgoettsche@seltendoof.de> <CAEjxPJ7Vhr0KYaZaDbUMTv6p+zvneE5fPN8uDUegsVKEb+-_GQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Vhr0KYaZaDbUMTv6p+zvneE5fPN8uDUegsVKEb+-_GQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 17:29:31 -0400
X-Gm-Features: AclHuK8ckecyrqcaPEPyNMgfwp2PZXVuhSJtLnknomZq-kLItdDB-E59oxuMrpo
Message-ID: <CAHC9VhSsFu6ah6gfgEBV1YqN1UcJnwhOUtwOqe42ktQOpO7+ww@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: validate permissive and neveraudit map types
 at load
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 9:54=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 3, 2026 at 7:36=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The permissive and neveraudit maps are read as ebitmaps and indexed by
> > type value, but their set bits are never checked. A bit that is not a
> > defined, non-attribute type is silently accepted. Validate every set bi=
t
> > of both maps in policydb_index() with policydb_simpletype_isvalid().
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/ss/policydb.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index efa8df26791d..c901a0148034 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -892,6 +892,28 @@ static int policydb_index(struct policydb *p)
> >         if (rc)
> >                 goto out;
> >
> > +       {
> > +               struct ebitmap_node *node;
> > +               u32 bit;
>
> I am not a fan of embedded { } blocks inside a function but defer to Paul=
.

Yes, let's please not do that if there is any way to avoid it.  Aside
from if/for/while we sometimes add {}/scope blocks in switch/case
statements, but that is a bit different.

> Otherwise,
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

--=20
paul-moore.com
