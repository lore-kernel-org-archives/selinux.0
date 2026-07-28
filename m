Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533A380FC5
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257722; cv=pass; b=BQIvEASc3NGIAS9hRIiAi7L230mTwYY/JbI395eEPRbqYGrPdvP6bYx6BxIm4OyRcVUEWKoGPyt+Eu8+N2wd7VsoqubqIPR6O9NjIsSx/XDLHIVCH7chKCOBifo8xZJlD1S/KBKNdnXnvu9eEO2UhbI8U/D4A1Wk1mYREWgAyKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257722; c=relaxed/simple;
	bh=4DYBoMmQLlodvQchjeNpDtuomnBN8rezhDrIPbkqI7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWJwNcHvqLdilGrC4OnP+cU7pzfuVTMMhcC8Z7pav4kAGA8qo4HqzOX8XX1BKO5WaG3ayNPhHa52IFfuUj6mFTH9ts05QnaFC6k7kfqVKCnSc3Rgk0u1wYg3TcBBPCYzJpROcGTdiIUXcuR/N5nZYJjgr1J/T5VO2V0S8zWrSuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ts0Wl/3c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=km9rfkt4; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ts0Wl/3c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="km9rfkt4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785257720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USde50Le8NEiMSJRi6Sx7gjL7qqZPX3pXMJCiAV7U0M=;
	b=Ts0Wl/3cnm7cKjW/T84ME8V2fGd1URQ+yvi/2V1YFvmEI7b1CXmOEAWJEvVJdizE+Zc8bx
	6/8dobBp8o90iJt689zIY4ubvPDAatqTJSOIK6LCeLNKbVkVMCyPuIlO8sCKKm2R9SAo3X
	K8d7QbG2gdQ2ax44V9VjGYXd76246Ik=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-O3fjfwiwNOOXMgPxyW7qEA-1; Tue, 28 Jul 2026 12:55:18 -0400
X-MC-Unique: O3fjfwiwNOOXMgPxyW7qEA-1
X-Mimecast-MFC-AGG-ID: O3fjfwiwNOOXMgPxyW7qEA_1785257717
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso108354a91.0
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 09:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785257717; cv=none;
        d=google.com; s=arc-20260327;
        b=lIuHCXSuB90ANgjGuwX0G2FtxYUBI9Zt10XrXaWZaE4lj970njNuqswlN0oauBsrv9
         I/QTRmP/d4AKf6UEOXGOOaRkoUFAWy8FL5nULCwar2dyS9jXW1/6gXlgOFncPSK+g6Mv
         Kv2PcKiXsegyFzeUHTVieoaL/KYbBCva2a1IZjq4xT6YTRdQ2YtVm+CkfOh4Mw7aSt6j
         e47/D0RjveTg7Xw5zzpV4LKDzFn8mSZTGS0scJQTtZt3CUvveyE6HsCDAMFqjhp5lXHf
         dNQixC6XeOzlxmzmAeaJcMPoT1YxNKkP4rKKg1nD00xy4MN1gZ3jbilZO6NxQD4sEswk
         0QXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USde50Le8NEiMSJRi6Sx7gjL7qqZPX3pXMJCiAV7U0M=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=joZs9vkyjE7z0YDQuthY+yX6eb70RW6YmS+4RkGWTKYt14sJcYIQp78EIK3XKmgn4q
         bqjUgudgtpeGDBR4KZuJMvVUl6g+Lcg8X0q8gs9miH0n0lkfKhOnBU8LbjiJvXwK2sqA
         wi81eCwgNioCyV2d/rfzxsD/vAPXkApBokBZvLuIIfM0TtzJljjsrLe9WOE2jbIL9M+a
         6VbZDZZ/gqKpiuqRI6/cS/M//Jylgqzj19tx2v8cNQW5sR2vBYRW54SWLCSkFPLFePmo
         q2mDGqSioW0m9FNf999RRzUfzBPxVLDVq4cIckudwUvcVWlddsBgFLKeyq1VAoIiiWYx
         tjBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785257717; x=1785862517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=USde50Le8NEiMSJRi6Sx7gjL7qqZPX3pXMJCiAV7U0M=;
        b=km9rfkt4LTx4qO7VDnFyl2YzXJOkq8UP9u2d67xswvFf0a4VR7AAbHGrrx5nMX4z5F
         IWPYAEkBmuFNC/Q2hKUh7R79JN3v40mA6t+qx6rFKazVMkgMXnB0g1Eb+YKpmaqeW1w1
         nLnTDKC8piievFAaUeZaEmMRiEapUIKP/bFnnyr1V/Qc9A6UimpzEiBGtMco0ALcw8gT
         /eYOj5h7iNnA4O2TKXH1jdnPmf6oTAnaazJuXcEF5bB+xCLhnhq0usaf69WNQoKv4z2E
         SDMG8M2VDR0bmAatOxR8PqdujYQpWb0YYo2gM9WMrgIrgIdGRPViuz04pycBFMRK+oM7
         gtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785257717; x=1785862517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USde50Le8NEiMSJRi6Sx7gjL7qqZPX3pXMJCiAV7U0M=;
        b=dKhM+LPC5keraK6zYd4ODSYgHdKmK4ipDeTv5zPEbqn417kME1YX68+EkAk9v7VbHa
         w7x4eXS3Lo4gW2rUYB3dlltbNm1hhM2UbBBSoh4DosTTU0cZBVhKfpA8z0CXjybaLfM6
         l0SNp/RZqah+fyoy8LyyPbV+FB8UPGcuLYRoVAXN31xZHxea/AQK0Z4UmJpFh8fJzhS5
         kaWwcaJ6XBhZdNYG4YMGruBZC3cbjgLt8N2AiNZpNBnYhw0uadZuFr4Qlodl8jCjpzgh
         JMq/+jDLzFZbgG2lHASEZiD46wYjB453q5EVEtygRBxV8FckxHNxWQF6p4EZ1BrSaeNg
         O2fg==
X-Gm-Message-State: AOJu0Yy9FcahiQRWZcLYPFq3kuywFrj10+yozdKXl+asTG77NFPZxeDz
	T/aQCstnL4VRSd7PbnkHx/ubThMdQIDsx2yu9K3KlJDhJfSiLmSYpS7PkAXj7nehKC4GVYhwNA+
	swTPovv664qZ3CxEgWr7oh3s4v6VFVT7gimzMTNPtFAa0BV3z3RBe1hkRU6B6b92WALG4YhNV6B
	Ji5eY9TgOOOVtlVVDDQovx7zS0XoSI9UNetCrfMv8+gc9V
X-Gm-Gg: AR+sD11oxd8YhYXbWT8/ETs8CBJmKW93imnzBdSGcSsrs0qLS5FLWABF8sghMfPWEiF
	vhzG93eMBsxuL2SUynd0v/9IFAq3fAD6BH36ZVXVTTKdJet8vDzgYmGKWCODmpSdEpk1JAs2iDW
	3YD8jT/qCcf8upmi6tY57PVGgmlkxLMV5Q6yT/a6q8DAPrv96AQ0olDeSHIM1BmWbvChPq4utnA
	edPSWFWU09N6j4S
X-Received: by 2002:a17:90b:2e0c:b0:38e:4482:ab15 with SMTP id 98e67ed59e1d1-38f6a51baa2mr3675726a91.22.1785257717384;
        Tue, 28 Jul 2026 09:55:17 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0c:b0:38e:4482:ab15 with SMTP id
 98e67ed59e1d1-38f6a51baa2mr3675694a91.22.1785257716837; Tue, 28 Jul 2026
 09:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727223242.2507658-1-akkohli@redhat.com> <20260727223242.2507658-2-akkohli@redhat.com>
 <CAEjxPJ4cNnYyN=YSXYArpUwFBSf-CkSNcKNLFnBQ_fkedKPHFw@mail.gmail.com> <CAEjxPJ4KKx1sktg8-A759JQiq+fca5gwe6pqoi4cpb5EPZV=MA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4KKx1sktg8-A759JQiq+fca5gwe6pqoi4cpb5EPZV=MA@mail.gmail.com>
From: Akhil Kohli <akkohli@redhat.com>
Date: Tue, 28 Jul 2026 18:55:05 +0200
X-Gm-Features: AUfX_mw8k4bZxmuJ4Ioq8lbCRrBRv1QRtDCkVJbcmif8CyE-uA1S-Mru1TmqfeU
Message-ID: <CANu4e6OvTDOZGiAxkE99KZegX95Ro85nugw97+NQ8rremrBxhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] checkpolicy: extend bad-data tests for type, role,
 and user errors
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed. The BASEDIR soft-resolve is now in patch 1/2 so that patch
passes CI by itself; patch 2 remains the robustness / large-input
coverage.
Posted as [PATCH v3 0/2] (and 1/2, 2/2) to the list.

On Tue, Jul 28, 2026 at 4:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jul 28, 2026 at 8:34=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Jul 27, 2026 at 6:33=E2=80=AFPM Akhil Kohli <akkohli@redhat.com=
> wrote:
> > >
> > > Add negative .te fixtures for duplicate type/attribute declarations,
> > > type/attribute name conflicts, invalid type names, and malformed role
> > > and user stanzas. Run checkmodule negative tests as non-root in CI so
> > > the unreadable .te case is exercised outside root-only skips.
> > >
> > > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> > > ---
> > >
> > > diff --git a/checkpolicy/tests/negative/bad_role.te b/checkpolicy/tes=
ts/negative/bad_role.te
> > > new file mode 100644
> > > index 00000000..3aae2719
> > > --- /dev/null
> > > +++ b/checkpolicy/tests/negative/bad_role.te
> > > @@ -0,0 +1,12 @@
> > > +module bad_role 1.0;
> > > +
> > > +require {
> > > +       type foo_t;
> > > +       class file { read };
> > > +}
> > > +
> > > +role bad_role_r types ;
> > > +
> > > +type foo_t;
> > > +
> > > +allow foo_t foo_t:file read;
> > > diff --git a/checkpolicy/tests/negative/bad_user.te b/checkpolicy/tes=
ts/negative/bad_user.te
> > > new file mode 100644
> > > index 00000000..e7460dd7
> > > --- /dev/null
> > > +++ b/checkpolicy/tests/negative/bad_user.te
> > > @@ -0,0 +1,3 @@
> > > +module bad_user 1.0;
> > > +
> > > +user bad_user_u garbage_token;
> >
> > You might have missed my earlier comment, but again:
> > this fails NOT on "garbage_token" but on "user" because of
> > the lack of any "requires" block to meet the grammar
> > requirement for avrule_decls. Is that intentional?
>
> Also, you didn't fix the CI breakage in this first patch, only the
> second - it would be better if you could ensure each patch passes CI
> on its own.
>

