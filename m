Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565E21B9FE
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184814; cv=none; b=dDsa+ffhNvgmuqlVqlR7G6Gba0KSxXe6qML505Ngd3Q9COmNt0UAApRRiu9L+5Y9qgsyK+jrvS8VIoG7zSLeLy6wYiiPcpl8swIoD2F1PJilhJ4mojI91mzBPog8RkhwfofHygAFLeE4y0QlvFKVkSw5I2ZBtLwDd8FsvAdm4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184814; c=relaxed/simple;
	bh=VBGC9g6IsM9yCYZsVnp0EdvDwk1S1mB3o84Z813FX8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKPutWq/N4N0UA3OdJVGQyunKjEiiqs5rc3QvozNtzxVq3Y/XyqmwChHVhU69GeJUIIdC5LwwfT4Hcr6cMpjZn3m7yTESxdCLOWCJ9ujjhpWNkNPgOBA9Cab829I1gdzIngCjbc7MwyLaQ0YUaLRAC1o2DAQ7qq41zm4uv+3f08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvv0tLvp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvv0tLvp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e5a623so1030023a91.3
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755184812; x=1755789612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ss/r2lDBVFqKDmN9JRqhvkKuGn7dX/oqdFcKCwC3iw=;
        b=fvv0tLvp1Pi1eiMkrBneINVze0ywvEAfsdHFE7BaC4it9Qra8nFOZxV9YuHz5XrsoV
         WyAvLFgbEjXPPLrRzd9EfIWU1OhkM9k9C7rf8TeuwdxdeLvZMAHdlVABjqFVWAZCLVFL
         nXb1zfIoiGrXrNTTqIEBo8Y/O4snnSzHiewnBoJTFbgJIGRKjyxPSWc8Qx3VBb927F/0
         zwiruaq8xt1gIyw9FJCCuCcze13eRzex1acnf2hTsTFikJGozcwbX0IY9iztA8J3GLYF
         yAjsqyjXi62wu40wkngRdMzGAbYygnmFcq3sMNmqJ3FyGm8+YVLh8mVqYkoKT3PmXuhq
         /R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184812; x=1755789612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ss/r2lDBVFqKDmN9JRqhvkKuGn7dX/oqdFcKCwC3iw=;
        b=mL6orADtBXFi/e8L84Vphj56ASjDUjwjGSg1JTlL6pzTlHepD1vV6NVtZj0qPUrQjw
         G7YaPcTl1UcCyPpz4eXpTL6iVdxiYi/4HiFKegcAfmZ0iYUNpNi/X5j5MoZEDnDjB1n3
         qSzWg1gXSbDgcBOOp+SLkIgdFcTNl2xIbPOTsrdpQOwb3/SPTV9HJORdzvQlYLHtZEKH
         zkOLzqEBvg3A4JrgtIJ9NjM00El5s142lN6jPCgW6mGryoQ1cX1H1fbNzTdRaMeb9Lx3
         fOnBNHdqIBz2ohd/7+7CfKg1QC4cifu6PSTO/A9FKKlAEsvN+prwdfGSWBqconPKSRL4
         joAw==
X-Forwarded-Encrypted: i=1; AJvYcCVDIGJUXwQzsH0xy8bhT+te/S2wHg6PlgYNTkbCx323ZgXTfPCZf6PXLp/cloNmL1MnmW22PI4H@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyavmMoIrV+e7o7FZ19ud6Q03Kf5F+EXstbF5OE5loyNDVb1G
	50aJHZpNB+0Rs/XD139qM69u8egbhXiH64aS8qVcrRxFtnFxDJ8wARVITxeKXaaavWjLm+I9AC3
	WJkB2zK9+xroIpYeNNMU2xAgVui/2Pfr+5p1V
X-Gm-Gg: ASbGnctqfEzfn/qJUP7DeKkb0G8fyIREwDwC2czAlb0MFAG7ap22XTYRkyKq38rNmu6
	QRQaDSveqyjTxPq9vstzmN/JamkVxTAxVhKG3W3+HatoGTPPllRncsy+XT/1MpgfuDxaBqHScNb
	BHfzdnFjr7JW5WiFHSqahwMsePPT/VaB6MN3q4ixKVMkrnBuSFL5rimAAEYZnRWwOk43kmRK/DW
	ksqGXE=
X-Google-Smtp-Source: AGHT+IGp1bk38QgyF7/S3eq2/ZzXPPbzwCzdpaRe0wc6ODMYqs8W8tTCWQGRZUISkxEWSiJo9i7rStvtYfsmvSLonRs=
X-Received: by 2002:a17:90b:38ce:b0:31c:3651:2d18 with SMTP id
 98e67ed59e1d1-32327b32d46mr5568651a91.16.1755184811741; Thu, 14 Aug 2025
 08:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
 <CAEjxPJ4MPBmjfr_e6x94XmDHUhZR+EJ0_Gqyjn8mbALL2HNKJw@mail.gmail.com>
 <CAEjxPJ4Xk81Tc=o532SvqWeeig4wt-oOt8Np0DubUBbfFuVLnQ@mail.gmail.com>
 <CAHC9VhSck4zDgsBtdBJhJ0qYtNz-tFYjj=3=as+4yX38JNTOGQ@mail.gmail.com>
 <CAEjxPJ4gAOXFShde9focOFpO747UaNMcxa9+-YJHT_Yu0GwETQ@mail.gmail.com>
 <CAHC9VhQLhJBYnnQTNamiQNBSBC8ynE=Cd50mVwuF_86B+PLepA@mail.gmail.com> <CAEjxPJ5Sn=4Z8Ck8mAbJNJe2f02PSgy4_=O88d70nymYSAc7Vg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Sn=4Z8Ck8mAbJNJe2f02PSgy4_=O88d70nymYSAc7Vg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 14 Aug 2025 11:20:00 -0400
X-Gm-Features: Ac12FXwkJWaMMD4VNiBEcXS_D7yYY5-_FRS_rjvWct6IP1_HjzLhXPYhhx43ijg
Message-ID: <CAEjxPJ6PPkGVMshrvB=Gav+-YDxCqD1=ktwnA3mAwH25bPt-Yg@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>
Cc: ericsu@linux.microsoft.com, danieldurning.work@gmail.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:12=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 11, 2025 at 4:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Aug 11, 2025 at 2:13=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Mon, Aug 11, 2025 at 1:47=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Thu, Aug 7, 2025 at 9:46=E2=80=AFAM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > Also, since you are introducing new permissions and a policy
> > > > > capability, please include instructions in the commit description=
 for
> > > > > running your testsuite, see
> > > > > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Sta=
rted#add-new-permissions
> > > > > and
> > > > > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Sta=
rted#adding-a-new-selinux-policy-capability
> > > > > for instructions and links to example previous commits.
> > > >
> > > > I think it's fair to simply call out the new permissions and policy
> > > > capability in the patch's description along with a simple explanati=
on
> > > > that the new behavior is gated on the new policy capability.
> > > > Including instructions on how to enable a policy capability is
> > > > something that I think we can consider "an exercise left to the
> > > > reader", with documentation located outside the patch description.
> > > > The unfortunate reality is that there is no single right way to add=
 a
> > > > policy capability to a system, and those instructions which are dis=
tro
> > > > independent are likely to also clash with the distro supplied polic=
y
> > > > packages.
> > > >
> > > > Unfortunately, while the process around adding policy capabilities
> > > > have improved somewhat over the years, it's still and ugly thing to
> > > > have to do and I'm not sure a commit description is the best place =
to
> > > > document that process.  I still have hope that some of the new poli=
cy
> > > > work will improve this somewhat.
> > >
> > > My request and the linked example I provide in the wiki page is to pu=
t
> > > this information into the testsuite patch description, not the kernel
> > > patch description ...
> >
> > Your request was attached to the kernel patch thread, while you may
> > have linked to test suite documentation, I think the distinction was
> > unclear at best.  Perhaps one could put forward an argument and
> > highlight portions of the discussion context, but I'm not going to
> > bother to argue that either way; my comments stand with respect to
> > kernel patch.
>
> Ok, fair point - sorry for the confusion.
>
> >
> > > The instructions in the linked example are distro-agnostic and just
> > > leveraging a CIL module, so nothing specialized there.
> >
> > I suspect there might be issues relating to the distro provided
> > packages, but I'll leave that as an exercise for those with more time
> > to play with that, and my Debian VM is in a bit of a broken state at
> > the moment.
>
> Yes, that could be true. I suppose a better requirement would be to
> provide sufficient instructions that a reasonable third party could
> re-create the conditions necessary to exercise the tests.
> That could just be providing the steps that the patch author took to
> run the tests themselves.
>
> > Since there is some documentation on policy capabilities in the wiki,
> > perhaps it would be good to provide some actual policy capability
> > commit description boilerplate in the wiki?
>
> Good idea - will do that.

On second look, I think the commit to which I link there already is
sufficient, but I did add the following text to the wiki under
Submitting a Testsuite Patch:
"Provide enough context in the patch description to allow someone not
already familiar with it to replicate what you did to run the tests,
including citing any requisite dependencies for the kernel or
userspace and identifying any new policy capabilities or permissions
required. See https://github.com/SELinuxProject/selinux-testsuite/commit/02=
3b79b8319e5fe222fb5af892c579593e1cbc50
for an example description."
