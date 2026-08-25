Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9C3D25D0
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666962; cv=pass; b=pRpanLi7E12Ae2LM86bN8UO8E3PmYbDFgOXfBwr40YH222+eB1y+0CDhDBx3lp7+D2eoDpcHsps+XH7Kz9yFuJ/XoveDP604On0lxTLZx+nf2ZUMJzhiNQasO2RLMEG9eVhsGjxEq+BHnUG1vIcg4UOyVLCcshepQ3pH83TkQFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666962; c=relaxed/simple;
	bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyr7Vi7ca5FhlQRMm4+QWlWOTcDoGyILVOQFwXMUgXXFgYk7dQWjXQA4290ssf0DJA5LWMG2CgYF6QGNegxgJFIpNq+Xtpy8C47EZiA0gJ+LfEIPARCqePTgPpOMan7GMhV2j2WIUfxM+Mdq0q+5iso7R3OdtDTj7SvqUy+zexc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJLKBMn+; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJLKBMn+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d3b440b97aso107395ad.1
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 07:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787666960; cv=none;
        d=google.com; s=arc-20260327;
        b=iC0kWnIqr/vSA5wCKpMVce3ubKQZ1HPQeBByf2UHwsTKYuqQ4dSCQP4rIBPQXbEOhH
         uYopaagAkrwl82zWDMOdh7AA7dfN0t3pIwvfMrpKVpoEhoDYJsYv4xMjhr3Ajlqu1xAw
         vT3K0oISM+65eMulu2F6QkLwzcALYTk2KXdH52GwnjRbMq85Nj93q0g80TjkeqHxPajJ
         HIVPgNODR7mPwLVEuPKBxOsddZKm3VYd6QiOMv1/9dpdGwFQN/N+mSBvDtkVWMhJkQjN
         paneq1Rsn4ISXWUaopERdLMr8gW/RJdJbu2da1KwZGYm+wJ9VeEpnYCOoDAsWyXnFm/o
         SZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
        fh=hkSjV8rkpsiT3CbzB5t/YbfihkgvkuwssHJVXsAC+MY=;
        b=bwr/mzMDmejutKvdxapGFCMhvYyaRNwj795Sd7K25O+vtBwavdRZhb/qvRGIKL+dbt
         28eZYpAIoSaqDcsZrd3SXhxPXe4YsuGkxloARKOmywvC5E6Rg+Bmq7S5sTZBZqaweKzS
         U17KgH2FVl4IAWEIrDp3I2NCNh25Q0ojtHc6YvGHaEsfpXMQsM87pSkM8eVu1wx/bsXx
         QjxWgJbGf0laqZN6wtG5BCbP8phnrnWpolwuv6cyfpLEx85aCmlweev2WbDjtv/StTVz
         yUA1+rT95VuOLVZszvxEUAg2JcJQIPoTOAtxBbTxjqwWxSjIdCLLyE/t8QCsgFzqjT23
         L/kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787666960; x=1788271760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
        b=nJLKBMn+gbqeBXi6yW6UE/2QTPoaDNWSvx6T7SdOn/yYq8fLbj45nUOydbT8Qokm1n
         YMaZLzYl7hZGcQNu4U13RRqLucKw+z4dW0fYfqovPPaZ9QcnqL5RzE4Z5uKkH8mT8/65
         r+lzEhQYtuTM4HjQ97fb/bN/r2u3GuQcHdd+/4hyyeh9bpR+NrADxss7350OmM9fSppa
         K23QdQwkSx08B0W81dumVO8tSJqpZpJdYupiVEQImqknw242BRAA6Kx/5fx+nkOEkBI1
         QUtNxEr5APYXIunFN1J+9oozXKVq05KLGSYHOWV1R4V+4dzkiMZAuxEAP92toQ/AIhiy
         7jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787666960; x=1788271760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
        b=PFjoAYga5qzXZ0KcF17ChOi68EEGXcsPo+g45m6c9guElYskc71lG6q2jvuKyHBIfr
         8jbk0X2f1BaIE3q6NCp19Toa+3HTMuvy1LNfwQNTMGTem3PelGIe4HcYqCEOfS0XrdYx
         EC6E5TvRG5HhTx5JSBMMIsj4FQ3Ym/h5sGi3tTU5FLBqimxQO7NGRWR2utQnak2MNOrO
         WcMbJ459Tp1cHo11ZE7ICw1OlBk7UBj/blcbNbsX2PEILDrvxYYTVipifo4K6OJ61jP3
         sxx/Daha54lZIwayheFNhfHz8PiHQQZG77zdZPZqehfH0QvD413sKhqAZ+pIywl8fON+
         izhw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/G2WZOJwlm/B4qQFaYssknWcOeQBqS6WZL9zkbMEVt/0MsO6fYnUVdOhNX5UbS3tlhEwJUOMt@vger.kernel.org
X-Gm-Message-State: AFuF++n488Y2Yulu9uOPmvDAEUKVUVtIrT92re8P3TsD8FfR5fkWe73p
	SmYEwwsiAqF7CjWQYCoeMkjKT1JP/Wy+DYOWUzyvPCEWE2+exk3LNkqWxOy5bKRomvd2eBtW1oq
	JBeSZQQhojNKJeAtKWKpwv9zFjkL+Trnb5gUJAK4z
X-Gm-Gg: AR+sD13tRGuDsPPfA0Apy8NvSTVM4IFksJnjfz6cjPJ/g3qQI55LKxyyqmruvtAedIF
	YFRcyivJ6mHuUBc6wdk2I6I5nOUWUFBljqwOOyZRDagVQvukuv1ERLL1AVbCsOExWLO3SSkvquW
	72SG5NvXe5CGsWvuJTVO6T4OlQjb2skXeRNH3oGQu0GsexQaydzxYXBoVA43Nir3HTluEIZg8s4
	nOoG7LciJVrhUMP4/4k1rqSY+PrP1PzHFUvzCyEC/W7J+U7VU7QlhUiQiiLWltzNWBpMQoOy79t
	e1Dy03KLK6JXUU8h4VHFhWzDEcrX9NznVFDfgEOZBtU/EdMsLB8gO3pueMOU7n9ef6YaARFDTON
	nngqo1rCldxOlO/BUZEtHLQX1/7+xvw==
X-Received: by 2002:a17:902:ef4c:b0:2d5:db38:8010 with SMTP id
 d9443c01a7336-2d6f2f25ba3mr341215ad.15.1787666958726; Tue, 25 Aug 2026
 07:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org> <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin> <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
 <aox7tVIQBMuz-xFO@gremlin> <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>
 <ao2a33Xf3U0kQmM_@gremlin>
In-Reply-To: <ao2a33Xf3U0kQmM_@gremlin>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 16:08:42 +0200
X-Gm-Features: AcwNN1WtvUE6nvnD4lMNaCfocLK-DLM3bUJQe4WrdBFVB5gGe4Bk4AlrWw9e41Y
Message-ID: <CAG48ez00PjoaXt4xJn1DCNdZfmFn4faya++=U2EeW0_vcYXcqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:42=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Mon, Aug 24, 2026 at 07:43:02PM +0200, Jann Horn wrote:
> > On Mon, Aug 24, 2026 at 7:33=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > > On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> > > > On Fri, Aug 21, 2026 at 8:52=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@=
kernel.org> wrote:
> > > > > The sharing a /proc/mem fd seems like that's a pretty dumb thing =
to do in
> > > > > general :) but I guess you have to protect against that.
> > > >
> > > > Yeah, it's a kinda weird thing to do...
> > >
> > > Yup :)) but I guess we have to account for people doing weird stuff..=
.
> > >
> > > In this case (I do mention it in a reply elsewhere I think) it does s=
eem
> > > like perhaps you should separately check for current->mm !=3D mm of (=
what was
> > > originally /proc/self/mm)?
> >
> > I wouldn't want to do it for this access check, since that could lead
> > to "confused deputy" problems.
>
> I guess if it got the decision wrong somehow that'd be a problem? Or wron=
gly
> OK'd it on one level but then that led to the fd being passed on assumpti=
on it
> was OK to do it or something?

The problematic scenario would be something like:

1. process A opens fd1=3Dopen("/proc/self/mem",O_RDWR)
2. process A does lseek(fd1, <address of libc>, SEEK_SET)
3. A sends fd1 to privileged daemon B as a "log output" FD
4. privileged daemon B write()s into fd1

In this scenario, daemon B is just trying to write log output into a
file descriptor. If we checked the current credentials on write(), we
might enable FOLL_FORCE just because daemon B is generally permitted
to use ptrace.

This illustrates why, in general, the "ambient privilege" that a
process has must not influence write() access decisions.

For a similar historical example, see
https://project-zero.issues.chromium.org/issues/42450869 where we used
to do capability checks in the old expand_downwards() logic, which
could be reached by writing into /proc/$pid/mem. That made it possible
for an unprivileged process to map virtual address 0 by providing
/proc/$pid/mem as stderr to a setuid root binary.
