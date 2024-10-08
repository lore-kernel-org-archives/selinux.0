Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127381D362B
	for <selinux@vger.kernel.org>; Tue,  8 Oct 2024 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394859; cv=none; b=N0D3QgjlDYy8bMQHtVhVC8nZUgK9fVvXt1uC2I+rd2yT/F1lQRF+2pDHON/S6ba29+jo2H+nNdEedRKeA/mzhiMWOtq+4RuJwoyYm9vMo6SM2CuACdbDByQpasEjylLfWfSjtIeIE2+m+LIrAM6SObIP2TzrlGLEvi3/m9Q3F5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394859; c=relaxed/simple;
	bh=08YU0YNnMO8H+dBPuEi8oXK+p2cD+Aq8KIEch6DVwco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHzAhZ5FGtfn37dQPzjmQlWCH+x5w2mtcA9Bx4nTlnmSk1i5Qnl/sqDYgR5anpltu0xX5o8iHa/iLX8dRVvR5T3XNi+BqtddYhbcxvfJ2Cp3JTOuX3aLbcjD9+gBig/spQR3F9P9eqHQaquS3YG+URqdpwmx8eIhEtvmQLlyVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NZPxvOTF; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NZPxvOTF"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e263920b6bbso4568132276.0
        for <selinux@vger.kernel.org>; Tue, 08 Oct 2024 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728394857; x=1728999657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO+1mqI5kWgnLXRRVFusLgoJMS9NHKgCg0l1GMdgWo0=;
        b=NZPxvOTFqt/lIaJvdJsP5a3H6SCY3Zbz1612LLY3g99dTSOExWNyvSs6bkiucw+3ES
         OKHti38vixStlG1qtpO5NkKPEWLBKEzeqJZxarwI1rPLD6RbeztcMFFZyd0bAFPUTCNd
         k/wc0YkEEsAUwzoB3IcUUtxM2mEC+IHuLWek2PkFRD7EbpjX1hc4MsKv9mXemiGs9HdI
         cjUhDdiW3KDystYGTCOQKmsQCBVl+x5akbZXUaWzLek1SF7rP3InkEu4GakXIsi+EbiU
         YLZNJ7zIcIShbVGeEaEugj49w6O/6M7NGpRunu+lJfn9ppMdb/qsunTbWDKpDxS5qM3T
         HPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394857; x=1728999657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO+1mqI5kWgnLXRRVFusLgoJMS9NHKgCg0l1GMdgWo0=;
        b=OJcPO0+H/Weevc+Qy9vil2sItq3+47qHlFiDCjj0gQNIOvG2VSIq3Q8P6NBkQkx+Jw
         VGghzDQKuQcp9ok/kE4DfXDKl72LGnG2ESmv7luzrETsZPziiBJewywi/pjo81nHvCOs
         9lyIBaH2XTDBPdQCpk6R04txntff2V07M8XMYItyXZdmv2fCCi8p36ECSvyFH5HxQE2L
         McWo7a6e88QtPuM2405RFmZxZNYEeVrcdoMTyFXtmImtAl+EfSSqhLf93SC/lwOX47Dq
         lyHbtGshL+3/lsxVbEcaswIC4Gmwdq2EtMuNuXoEG02N+1/18M34CWt47+QQEPEUl46s
         b7eQ==
X-Gm-Message-State: AOJu0YxAwZtJuGXRx98UBbX6xHracGZZerKg8UNfPVImSplvOLZAtLoK
	GS6ReGWbnWU9yOTONV72TIRkyVn89hsp1bfFDj+NDQZoZ5i9KV82OJ1+RvZHFigfKPklM4nbqPw
	yDuXjEc35VWsL+fWo3ZfTp3SyrGlaNrdHPdL5
X-Google-Smtp-Source: AGHT+IE90H9w4bCJARlJ2ic7CVY6nuz1U6CoCbh0GVbS7PlZKmBvR03rXaO2hgBkt2XT3iQzRjq5ilUhsydM/vVC5kg=
X-Received: by 2002:a05:6902:161d:b0:e28:a9d4:8328 with SMTP id
 3f1490d57ef6-e28ad6a379dmr8164141276.35.1728394856860; Tue, 08 Oct 2024
 06:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195755.19385-1-stephen.smalley.work@gmail.com>
 <CAEjxPJ4MH_r36Oy4K1Mcg4isGRQ+TC3Yr86DJV9fFOe3oddmLw@mail.gmail.com> <CAEjxPJ40boVZji2DZVzHn63KmNOf0MkjkS5h9eBU4CSptfSuNQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ40boVZji2DZVzHn63KmNOf0MkjkS5h9eBU4CSptfSuNQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 Oct 2024 09:40:46 -0400
Message-ID: <CAHC9VhQ5bEPw8Kmy7Q4XJpWN1q9z5HpKVnkU2RN6TBrYvEecWA@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy,tests: add tests for netlink xperms
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, tweek@google.com, 
	brambonne@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 9:02=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Sep 16, 2024 at 9:04=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Aug 28, 2024 at 4:00=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Add tests for netlink xperms. Test program is based on an earlier tes=
t
> > > program for netlink_send checking by Paul Moore. Exercising these
> > > tests depends on the corresponding kernel patch, userspace patches,
> > > and updating the base policy to define the new nlmsg permissions
> > > and to enable the new netlink_xperm policy capability.
> > >
> > > For testing purposes, you can update the base policy by manually
> > > modifying your base module and tweaking /usr/share/selinux/devel
> > > (latter only required due to writing the test policy as a .te file
> > > rather than as .cil in order to use the test macros) as follows:
> > >     sudo semodule -c -E base
> > >     sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" base.cil
> > >     sudo semodule -i base.cil
> > >     echo "(policycap netlink_xperm)" > netlink_xperm.cil
> > >     sudo semodule -i netlink_xperm.cil
> > >     sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" \
> > >         /usr/share/selinux/devel/include/support/all_perms.spt
> > >
> > > When finished testing, you can semodule -r base netlink_xperm to
> > > undo the two module changes and restore your all_perms.spt file
> > > from the saved .orig file.
> > >
> > > NB The above may lead to unexpected denials of the new nlmsg permissi=
on
> > > for existing domains on your system and prevent new ssh sessions from
> > > being created. Recommend only inserting the netlink_xperm.cil module
> > > just prior to running the testsuite and removing immediately thereaft=
er.
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Now that the kernel and userspace patches have been accepted, can we
> > get this testsuite patch merged please? The test will only be enabled
> > when the underlying policy defines the new nlmsg permission and
> > enables the new netlink_xperm policy capability, so it won't break
> > anything in the interim. We will need to separately submit a patch for
> > refpolicy and/or Fedora policy to add these.
>
> Any objections to merging these tests now that the corresponding
> kernel support is merged?

Not from me, although since the kernel support was merged less than 24
hours ago I might give Ondrej another day or two just in case he was
waiting on that.  If we still haven't heard from Ondrej towards the
end of the week I think it's fair game to merge, I would have thought
if he had any concerns he would have voiced them by now.

> They will only run if the underlying base policy defines the new nlmsg
> permissions and enables the new netlink_xperm policy capability so
> nothing should break in the interim.

--=20
paul-moore.com
