Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B78237B030
	for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403618; cv=pass; b=ng+lhw+B1DaW6+6E7oBy1aAbSjjzmiP3TReD144zd1X/nix43I3hns2eQYrAZtEdSFarLB8S0N4OpcvujVtvvoaywdcApHrB7WXuoyD3scv93be3F4KCjBCRjqDGo0ruiO80p4QRKkWMh9bVGDmzgbVdY8sMQEHcyJv3IroqkXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403618; c=relaxed/simple;
	bh=agsr2jSOniKtJMF+X0oXwibByddxXJqtF6YncOKFIEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcK2qWTKP4G81i9awPTP0WMEztCNHYp52umsVUF5BvdR6eWe8pk20+IRtzjLqtXMOdrHc95yhXPQq9CWsSXSDZXV0tZlMq+Y7Iv7TD3Pr5ors53wKEWTwk6KTpuy1omX7xoq9OQY1hDJQ6mE3+wECnwkm0agYtl4vcD+y/2ZiNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QvSsjVPq; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QvSsjVPq"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8453f568e84so2769282b3a.0
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 09:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782403616; cv=none;
        d=google.com; s=arc-20260327;
        b=JzKomWOEB397XCAkiisyUpE56ulhM5uuks4nW3/q8TnjccW7gBX4H/Bn2Ks/15/EfE
         A/fU9ccmaunO8m8687NQnLmj3hRauafvRo/+GYlCmsiidW90hR2SY0+w/YCbSicM54Ot
         byPnICUqMUhUEKNttuG6La02onF/4Ww6lIpCXRh7I0d8Iomivk8gamQNOFbcFqHPfXjd
         eu128FRXboicEkGRe3UUFpNg5CnfORtQAM4/e/t7da5EzodD0zngNXYA/8FQWWh+hyC2
         xiQVIvPN9wOztPBQu+Y7nqhW2U3dHh4fxhZWy0EC4xOGTdiIFtUqcdG+fOfReUfwdOKK
         ihSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tj5Ca+YrVkSkclVchnHXzQO8ttUEujxWnJ/JyckdB0c=;
        fh=KaoX3g2jmz8Z2G5eXRfxM55mMux1stXD3L1sstUeONI=;
        b=Vm6SAHvH0ZL5Ae21sYaFL7k56bP/lvjk+2LsiKA1SAEUC6RGixEpVjs67FvrzWzM2Y
         h5o3JDzsh3mReyezl2UsXWpj+a3Fyih/I6Z91NYRpnl7d0gOJFRxqwQDki5HL/PczihR
         Zrf7ce1t8+04kYnJYBoqwKbN6F3WjUzNFNYHnqvMdqpRO4McUp3GxTD2/b2/4JXo+zFq
         z+9q3SYpCQXmCzWrN4Vc3JWtAiZsxxKaxjblkGXHvPpgPua/9kyIvATn0kp2/otSDuKD
         pdqUzdZ/F16nqp2IHR+PEm0VPMorZbGviOOnCBGvLHCTKwfdaFPhjpKKc+c66V5xeUka
         Ogcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782403616; x=1783008416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj5Ca+YrVkSkclVchnHXzQO8ttUEujxWnJ/JyckdB0c=;
        b=QvSsjVPq3M1JY0gxDJT0dGWAhQEabdh6KoWw3JBpzBtI3rtnb3lWRsn8ta0q85U6l4
         Ua9fc9jZSlTlQCTuDpP5pl3PJpzmygJREv8s5m4jjU/kpKu1yQeSbGs6Bu+QQmxV2ezi
         e6NPDfevXKkBchG/zqVyPXc/kFOhBiI2W3jBrwdKpT5ZZaWOTSIRUKTJNjQJ0AbZcUec
         vgdp30jAhElXeS5k7V28unI7eOz9LvmVrSUmQlBIQCVGaSXpNXiOqN/qFRoYC/XGgKOC
         9iAuA/CZaq2dfEavbG5gNF2LFQUOsab5a9SZvIIiNeh6NvKgnQyIElT7hrMSadP+7MFu
         n1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403616; x=1783008416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tj5Ca+YrVkSkclVchnHXzQO8ttUEujxWnJ/JyckdB0c=;
        b=Ry2LwOaLpul5Ub+Qbvg3ZOZYPEvjgz4mmro1ZZA79dg4zmI54djlLWV7/YvBKq/U07
         ee/IKBTwSoXoxVvv8obVoNQmaOjwEusLsRMj90TJxL7iaYyVORixqbaiPrJBzDSYjaAq
         IT/Tt6tHrG8MDTEzYmIjjFTKdC3eOI7D8s2YHhz7wWOhbPxnXR8vzgnr+byd9k0t7qSN
         matVvuuact5QsQNl7grHtU2ynlHEIVmdmc6+LJYSQ7HCFk2iMZ5x6DFiLWAZtjmc+YfW
         FIfiVotWtNaq/tuxtitLNlItDwLu/Pu8SYFCIU7GA3tyfwM7Dhe74WELQazhUiKoPlHQ
         5S6g==
X-Forwarded-Encrypted: i=1; AHgh+Rr4zNApeslIkru0yhKu34GL+04I8jZRjMl7eHpdj2DhdtwBJhFqdW1neIK0f+XFTGKYduD4j52u@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZvwIr4LpVoIDtVXmCntsoch1iVvEQsONbzJt/3aeH+12ca0+
	AYEPPGhmRCwNG6xzxZZAPrSo2QGx+gEk0TcExl6F0VtYMBSvN8tmz+t8V5JeUi1fz0oroygCVWF
	015VGb1hrEF70vqVgU6d1/9PwQfbLqw+ZDAgJ2Vp1
X-Gm-Gg: AfdE7cnSEjtjHKwYbbIJexubYTWqPU/Jyi9VaOMpleF1SLY7g8xJMXDb2kDJMo3pxwo
	wiQiErqs7sO6o2c/VYgzBNAcL4Q0W9indsZRjzjIdCl6MbxB1YnUd1zCINZ3ULzpum73J0zuQKj
	rJMifZXFJo2I/uF1+fCRp+9ciNdcLtS4s21i8Wdf/t/FAxYVT58qfjnZeg0pjNufuXTsTA1NLC8
	yyCKvr03fc9US3hsYhcVdK2KTSrhELh7JvHPF1g3Zy1j2kgUaJlwpiHzGG5YpiYa8Pmjb6d
X-Received: by 2002:a05:6a00:1a8e:b0:81f:5037:a317 with SMTP id
 d2e1a72fcca58-845b39d39c6mr3865503b3a.11.1782403616175; Thu, 25 Jun 2026
 09:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
In-Reply-To: <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jun 2026 12:06:44 -0400
X-Gm-Features: AVVi8CfVp_1nha_FxdKkksJCUmgb3NBLBVh62tn1q5iqee01wbI4MgNkgsJUBlQ
Message-ID: <CAHC9VhSP54b9UZLJ5RRaWfnV5J6mD4iLCFXxwwv9pFqDrCAH3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Christian Brauner <brauner@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 10:23=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> >
> > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically s=
et
> > > xattrs via the inode_init_security hook using lsm_get_xattr_slot().
> > >
> > > The inode_init_security hook previously took the xattr array and coun=
t
> > > as two separate output parameters (struct xattr *xattrs, int
> > > *xattr_count), which BPF programs cannot write to. Pass the xattr sta=
te
> > > as a single context object (struct xattr_ctx) instead, and have
> > > bpf_init_inode_xattr() take that context directly. Update the existin=
g
> > > in-tree callers of inode_init_security to take and forward the new
> > > xattr_ctx.
> > >
> > > A previous attempt [1] required a kmalloc string output protocol for
> > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs =
to
> > > provide xattrs for inode_init_security hook") [2], the xattr name is =
no
> > > longer allocated; it is a static constant.
> > >
> > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > restricted to lsm/inode_init_security. Restrict the xattr names that
> > > may be set via this kfunc to the bpf.* namespace.
> > >
> > > Link: https://kernsec.org/pipermail/linux-security-module-archive/202=
2-October/034878.html [1]
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D6bcdfd2cac55 [2]
> > > Suggested-by: Song Liu <song@kernel.org>
> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > ---
> > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++++++=
+-
> > >  include/linux/bpf.h               |   1 +
> > >  include/linux/bpf_lsm.h           |   3 +
> > >  include/linux/evm.h               |   9 +--
> > >  include/linux/lsm_hook_defs.h     |   4 +-
> > >  include/linux/lsm_hooks.h         |  16 ++---
> > >  include/linux/security.h          |   5 ++
> > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > >  kernel/bpf/trampoline.c           |   3 +
> > >  security/bpf/hooks.c              |   1 +
> > >  security/integrity/evm/evm_main.c |   8 ++-
> > >  security/security.c               |   7 +-
> > >  security/selinux/hooks.c          |   4 +-
> > >  security/smack/smack_lsm.c        |  27 ++++----
> > >  14 files changed, 166 insertions(+), 38 deletions(-)
> >
> > I have a few specific comments below, inline with the patch, but I want=
ed
> > to make some general comments too.
> >
> > The kfunc additions really don't belong in the VFS kfunc file, please
> > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add the
> > kfunc code to this new file.
>
> We expose a bunch of VFS heavy operations for various security modules
> and this is really not different. For xattrs we have it all centralized
> in the VFS and in general all VFS related bpf kfuncs should continue
> living there and be registered there.

This is really LSM specific code dealing with more LSM bits than
anything else, it belongs in security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
