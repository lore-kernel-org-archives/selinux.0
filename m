Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8547345EAF
	for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591908; cv=pass; b=inshjly64EmHZnjynmFZnI1NdLWp+qqQWdq4GRgmw6ppEMAfhldnRbYO61l4mjT0Mo4XH20HQjFFrjYJ7t8MlCnB7at2XkkwNZbs3k+Wzg1MQ76ugpv1WZa4Ns+PYoJ2SfBeiRsBlc8PCt+hrUVJphwaYGnqtLuwEad8s+5R/eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591908; c=relaxed/simple;
	bh=serqGqnhQOJKmR83TgtyVnBK/4uQ1gpqYK6HutXP+Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoxlNaxkIsAYqoVClPOqbivq2I5kAEJwPug6KHWTipmvTW8FNL3TR9AQiq/0DXGdKohnkbYSB+AB0xVd5tqc70t1U12sN63AfT15izri5SUiEoqxVIU3rmYZ3J+HVOPKM3UooxXLeGj8GgweLVrKRfcoVWkXzBcpQY5hVPmGodE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=elqDOT1W; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="elqDOT1W"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccdf36f63dso8595ad.0
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 10:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787591892; cv=none;
        d=google.com; s=arc-20260327;
        b=bLH1Tqnup7a/n5BFqqww28dh3ZJCtdWQT+yBhzz5GFH8+lrGrNWLy69QLfpS63QXWd
         n/hmEgVVb4hc+6gw82Zw/CGntk7lYnGR35RBXF9WxhittYL87SPnT1YZl3ou2mZ+z3Ps
         mRxecb4IfPK3oJc1/RMJ/IAL/LnyPx8dtdAr8JdvH+AuVa//gErSYk2aQHk7auOm+dTT
         2jp8gSap4sbsjdSo4190p7gpqWJr44LiX4PUMiqYWQ3Z1Xc2rgIigCxF7JNoguNMARO4
         ysaL24v1rUA6/x2q4x26NOfC9xvyaqkFNsltnmR49a8i25uMwhe1o6VXlrHkGO4oYzPC
         TJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ohGszV6/vVpjIqIrVyQqtCXHHbkO7EBoByFIi57pbG4=;
        fh=xIxVwx1XmZzimKWQqh2Hq/SbSOCwGqJLL+B+7wNBWso=;
        b=p8kY3PVI7fPWpuKEDMYwxMq1MnZ6T5copQ5sgF227d9GsMHcKRdzen8UCBJnVNM0WK
         FovHpEPioUBklws4ZCzL+112S0As+eA1P3qqsEuuAP2mZT9ghvnsnyE5GIipWjaaaA0a
         nCJ4xuyKrT6zmBt1Ugk9KP7CeFuAYkhmBduzwbnw579ZNScuKVTbajAOHQUfLFRMx9s8
         eK6niN38j3sjuNowzz1Kitls12B9l/toyzblh5uIgcuReSDGz+5e/UewsH/el5C0yURh
         X4dO8DU+a4Gbs6GeIXbpxDpVezE3E5IolcXXmpsi5c14G6NIFNAkj1jaZI39GOBAF2tW
         Z5Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787591892; x=1788196692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ohGszV6/vVpjIqIrVyQqtCXHHbkO7EBoByFIi57pbG4=;
        b=elqDOT1WJHok1OrUeSMqRj7eiFO4ujaXdBbaYs4kLvy55WJ0bTHg/Ysj289mj78kfE
         VtdP1KEj32nqcz5pq2CZPREePzBb4W4Smrhc4QOBmKSO7Fy8zkxyaUmCBvdaZ4Pt0UYu
         AdjKvYBEkmB2k/AOIr9WGVt6wi5abfY4M97Jee0TFFWUmORwltSYXJrNe6s0cuiz9w9g
         KQr7XzCep1eRpCQ+U1nXTHdSX1/9EgGeQrNpH25kF+TY58rXDt27KfGOi47xcKY4ah99
         dlkkZaULmDOwkjYczlDGn33y6VbpwhN8tc1WNz1L3rI7AGhsZLvTxrmOblfnhaxsQK4I
         1UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787591892; x=1788196692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohGszV6/vVpjIqIrVyQqtCXHHbkO7EBoByFIi57pbG4=;
        b=muLi1UPJYro6V3YZo0l1LNnAon8yjMG8xFhrW399nXX3n423nU9B8GnwB/EiIupn7x
         4B8UfGnX67Hk4UOtmgcWwuOfnLDhwvjYzOSQ7fb2SrEqZZMkq09K9cHYCVQUb9jJNhGz
         AScPiOHB3EoLhHPkCZi+4hFIkJDHPWz3VZW5ILvjR/08G6O7k5hUHXJkGyBoGh3B6ZPn
         zQidGr7HDIJsyGj9MmwUqybLxX6LST9AQ4oNturP86ZL92fVGCPe8YMSsVRfYL1Abtpx
         cv2nXvfVu46EHF7ZJmoRV1sAEe4g52BRI/Crnx9UnP8GF7IYkc/2K1K2/7N53SBr2s68
         93HQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOtaEQQG+p6ojwE1bmd4xf8elqcrYk8Reog9dZ1yRLLfAphzfcZLSDCWiJi8uFl1bH7KvZD7Ud@vger.kernel.org
X-Gm-Message-State: AFuF++nshIMDAY0hegEIf6EyWpXy/b/q/NciEa2azHLiv1er+7qhRe2B
	8vut0eqJ6TE8NrwpQxA9sx/bMVtpsJSWkNJbMwOP0ET4GS8/gypuwDc+ybl7L8QYoIRcP7uiKPk
	GA4M/m8M6yuLiB3rWjDwzbyzidhcnpCX1hnutuIT7
X-Gm-Gg: AR+sD12PRIk1CK+t4eSPHMIeziSRwK4AbWeIRhO6Owa3VLYocTX4moG1wb0+SOScenP
	yFzxYAIFc6lk4Ww5enr5gK46XgbSlJxNEwSJIF1BZetrMxSVCsMOrli/i9VaD4k9le9b3AtORF3
	eHp85P9xzJL6gmtPGRR06iZ3Zi0e0f/vYjxWkTyV0RzN5cXHJdFCEZjmF2E/24708s1FQOC8U93
	Tcy0TNq32/FO+4N7Q5v5STicT/fR9VLFIJseYuMk4Y8AMqi8Pi2gH7kfjBX6YNVj21LFzvqUNfw
	DzPyN8mdRQxu7qbiN/G0f6TjGiuWZL82VcnKxP2w2vrzvfQIkM6wV0tHYbMFfjmloi1aIHys1B1
	ALwty5Sgxfg0EBJXyOBLL5/8AcLCykuE=
X-Received: by 2002:a17:902:ced1:b0:2bf:1000:d3ac with SMTP id
 d9443c01a7336-2d673bdc43fmr10817465ad.11.1787591891683; Mon, 24 Aug 2026
 10:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <aoie0oyojqdHciKM@gremlin>
In-Reply-To: <aoie0oyojqdHciKM@gremlin>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Aug 2026 19:17:34 +0200
X-Gm-Features: AcwNN1WIA9RcA5rfP1casTlSYpI1XYrEXxEhaejdTW-7MsqouUyvqUL1sH-5Z8w
Message-ID: <CAG48ez05-BOK_SZCKimPuiP_WRB1dFrzvcL2bHmOR-bChEu+Cw@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:56=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Tue, Aug 18, 2026 at 09:51:07PM +0200, Jann Horn wrote:
> > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process=
 can
> > only create anonymous executable memory via /proc/self/mem if it has on=
e
> > of:
> >
> >  - EXECMEM (like for other methods of creating anonymous executable pag=
es)
> >  - PTRACE (like when using /proc/$pid/mem of another process)
> >
> > This closes a hole in EXECMEM enforcement that Project Zero has used in=
 a
> > remote Android exploit chain:
> > It was possible to use a memory corruption bug in a service without EXE=
CMEM
> > permission to overwrite executable code via /proc/self/mem, which made =
it
> > possible to load and run shellcode with a kernel exploit.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  security/selinux/hooks.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 18dd28b2bb13..905137c47321 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2157,6 +2157,32 @@ static int selinux_ptrace_traceme(struct task_st=
ruct *parent)
> >                           SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
> >  }
> >
> > +/*
> > + * Decide whether it should be possible to read non-readable VMAs and =
write
> > + * non-writable VMAs via /proc/self/mem.
> > + * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS,=
 and only
> > + * triggers on accesses that are not visible to selinux_ptrace_access_=
check().
>
> It might be worth mentioning may_access_mm() here, and obviously propagat=
e the
> suggested name change introspection -> opened_by_owner or fd_from_order m=
aybe
> even?

Ack, makes sense to mention may_access_mm() here.

Ack, I'll rename this to selinux_mem_foll_force_opened_by_owner().

> > + *
> > + * This allows a process to overwrite read-only code in its own addres=
s space.
> > + *
> > + * Creating an audit record on denial doesn't make sense here, since w=
e can't
> > + * tell whether FOLL_FORCE matters for the accessed VMAs.
> > + */
> > +static int selinux_introspect_mem_foll_force(const struct cred *subjec=
t)
> > +{
> > +     struct av_decision avd;
> > +     int rc;
> > +     u32 sid =3D cred_sid(subject);
> > +
> > +     /* Allow if the process is generally allowed to have executable a=
nonymous memory. */
> > +     rc =3D avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__=
EXECMEM, 0, &avd);
>
> But does it make sense for the shared-by-fd case? In that case you're now
> updating execmem for another process's memory right?

Since the existing check for PROCESS__PTRACE happens on open(), I
figured it would make sense to also check against the open()-time
credentials here.

(I will be changing this to check just for PROCESS__PTRACE based on
Stephen's feedback.)

> > +
> > +     /* Also allow if selinux_ptrace_access_check() would allow it. */
> > +     if (rc)
> > +             rc =3D avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, P=
ROCESS__PTRACE, 0, &avd);
> > +     return rc;
> > +}
