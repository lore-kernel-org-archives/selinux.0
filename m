Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E802D1901
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988157; cv=none; b=AiUKaBRenrJ6ZCoySUfc3evxaD7mcj872I4w1kPdpiMl5GF5OWpBVV5tc+WKqVwWTafQQYcfqYcQK/44Fz5NfhEtSg6/spzT01fXd+Za7XnAsRs69f35A76OBNgqF8EAa5yMe64P0djlbNAIMO/jAhjkcOOhxj5GhH56eIR9kjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988157; c=relaxed/simple;
	bh=umZ857QeuIIQUUqPe4gSdyB7ETX65pLAn2ZcuUZtFE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpDEpaJ/MvPfgmaptO9rlL7TZOOVq8WJBi4SkAYSvh0GtG04x+Z5LRh2Br+SluYWZPihiQmEhYYxjp01TAnMaFguPI4y4PL3w5iKWHupF6ZLtwmrIYDfhcT8AvTh7zCWFWE8nIDbT7rIUhPLzZ+ll+jWsBxPEJ6wIedRO0bvq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RbqGEYWA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RbqGEYWA"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33badfbbc48so5911021a91.2
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760988155; x=1761592955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXSjkwnG8Cy2vSuisj9Mg3o4cb7lSzCYpfE+yrCbTp8=;
        b=RbqGEYWAmcb7Jg1BWkb1xm8A/yIbo6PR8TcyqZQ9Jee4hWRk+ZCClrna6eFEu6ZJlT
         8HhsmKpnHXxW6tHy3CRQSFJ8PgCh87Iu53/SkyaGJjvxXVIzuO8PEPyHo2djWOCh6SfT
         GC2azFh5uJNlMpMmdEcigmXX71mcSX/fGt3rB8XTsnLHzxI4Dwnz6v1W5hKVmPFPRjCs
         0g+vcbkIbOJ3o3NFCz/iAm1EFg2kiZ9zocvdsBWwHXEoBUyb1EVWJKoBhP29+X1CnnL0
         6wK64SQntHt82CRDmZVwewRaRRK1s38HM40bGthYDQ01NdURmbGX1uFub8lOLguU57SO
         UbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988155; x=1761592955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXSjkwnG8Cy2vSuisj9Mg3o4cb7lSzCYpfE+yrCbTp8=;
        b=PB+hN2UfP3RIYPB2f9j1kjbKQDzu51aApsEq+omYS8OEeHNC+KN5Oh+X8tT44TVhJ+
         S8OuL4X5qMgM+h8MDc08Kzkmvy9MND+ySGD27TYyIdpYbH/ATiJgCZ5xfE0iHEBYkS+4
         Cp8ZjZJlqvJclUB5HtekiryAYNF1ofWdk74qBWBuzNkW7a8wCxga+OYlcs7by6K1Er0+
         zSSCZyGD3R2UmOc3g9aAjQSywnbQyBLWZ2y70sCuC8O/Eun8F7cap9ACBLUgxcZVTpgq
         Nnzgkv/KON2cg6YKJajXwStG/xxn0payte2BQDH605KIpRzwyURvWVapzaRJYldOYZlR
         8qWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb8odCdPFslVoGSbNC6tLa+WejDr0qI8cVzNK1mYzvTt23Jwq3eCzy3/tkxv/EAt0Z7kt604wx@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0OTyEuZFHM80xCszD7/uSdKmiFBXBj+k0N6F8YBHVD62WAiM
	X489d5hSkfn1ppyntNyPSQJMe7n+PtGXNvFFwZyZ0JdgEcrCOu8H0oMyGHIZH4Wmp/iZOdsIUDM
	yzgLYb5hQz8+7EaHZKsWCituVWcSGDBCrxMIFO5f7
X-Gm-Gg: ASbGncvbPt4HiwDcVMyEOAXSY19Gb8mCbGIIzg1Aekxy1xchk+81MPdhUgrD0VHfGW+
	k2cqGlEwOV7srdarVoMvrxnH2jzhtqafM/J8y6DK5eDu5JOJq3g8ewMO/FbmxdCXPr8CbYrz6rz
	GSfXxRCk/j2BqwwUoObR+4Y8DHHOWFaXKxWp9Ym385+X7jMhYbONhASb8Dc07fDqvf9sNyna6bT
	Vh4oOu+kJzxyEQCKQNxQbzbK98+UOiNMxE8+mqUpH7aDEhaiui36gzLdv20YfYJKCDy7x8gkCOZ
	z3kgwg==
X-Google-Smtp-Source: AGHT+IFSiHOTUDXYpFNI+OFkM6wdZC9V5vzg+BHgaKVj7iXBx06hRGe7eu82SnindZ5rZ6l1EtKLHfi8m3vUHWu1hew=
X-Received: by 2002:a17:90a:e710:b0:32e:8c1e:1301 with SMTP id
 98e67ed59e1d1-33bcf93f784mr18159001a91.34.1760988155257; Mon, 20 Oct 2025
 12:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d849e8a98bf88bd12fd13a8f6b6e84290dcaaf6e.1758859391.git.zhanghongru@xiaomi.com>
 <b30e8d56703dfd84778fa73845eaa1ec@paul-moore.com> <CAEjxPJ5CYtyfMPcaM2ugyMJQ2d+YQz4oXVBOcm7=gHsOk-2sRg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5CYtyfMPcaM2ugyMJQ2d+YQz4oXVBOcm7=gHsOk-2sRg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Oct 2025 15:22:23 -0400
X-Gm-Features: AS18NWDeWQWRVRVN4vI0aAwunYxaLBao1DfrZHcW6WRNO1RLsNCVYZgwwhSGgqQ
Message-ID: <CAHC9VhTz48LOy5E7ywAFYjp=OK43y4MndV6V9HjLC1CpUCJ0xQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable
 during boot
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Hongru Zhang <zhanghongru06@gmail.com>, omosnace@redhat.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 7:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Oct 16, 2025 at 5:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Sep 26, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:

...

> > I would expect the number of active AVC nodes, and AVC churn in general=
,
> > to be very policy dependent; some policies and use cases simply result =
in
> > more AVC nodes than others.  With that in mind, I'm wondering if instea=
d
> > of using a kernel command line parameter to specify the number of AVC
> > buckets, we should instead include an AVC size "hint" in the policy tha=
t
> > we can use to size the AVC when loading a new policy.
> >
> > Thoughts?
> >
> > I think it would be important to consider it strictly as a "hint" as
> > that would make life easier, e.g. if the previous policy hinted at a
> > larger AVC we may not want to bother with reducing the number of bucket=
s.
> > I would suggest starting with an implementation that uses the hint as a
> > power of two for the number of AVC slots/buckets, with a value of '0'
> > indicating a default value (512 slots, e.g. '2^9').
>
> So, aside from Hongru's points about this requiring a change to the
> binary policy format and compiler and introducing possible
> atomicity/locking issues in the AVC code when accessing the number of
> buckets ...

I know you've heard me say this before, but for the sake of those who
haven't, "because it's a lot of work" isn't something that I consider
to be a valid excuse.  It's fine, and good (!), to explain the work
needed to successfully make a change, but I have an almost allergic
reaction to those who use the amount of work needed as an argument
against doing The Right Thing.

> I am also uncertain that this is something that is fully
> determinable from policy alone.

Agreed, but if we are going to make this changeable, I'd rather see it
as something that could be changed without requiring a reboot.  Not
wanting to add yet another selinuxfs node, and seeing *some*
relationship between AVC size and policy, adding a AVC size hint to
the policy seems reasonable.

However, as I mentioned in my reply to Hongru, we may be able to solve
the immediate problem with a Kconfig tunable.

--=20
paul-moore.com
