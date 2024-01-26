Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4A1802A
	for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263929; cv=none; b=IiTQX1w2+MTYbbdxXoj4NZN73+3Wst0l878VlDvuZduXft0Ewn1azBrMRE7uKLt8TJ+dUYeM2CacBJ01du6CJTbZ2/maSDikj4KL3KWCDoanaXqBnKUEUEuCAC9HsRaxhwFtifN41e54PX1K0R109MwrCtz8CltgV94g9tGuRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263929; c=relaxed/simple;
	bh=rOhDAuXWPfvEqHD+8xwty+ywtK4foQm5Tilv/QiCRVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAIZjGAKi6mZqcomwjXkFrJlDN61scU8oFJhrgZXLhyHJKxvXYaa5YIYySZUi/YneSvDbl7k69zEjlgBNhISiQoSTuBNvPJfCxJpKR15gw5pZu9tEXadICxiUwLF7rAkGXbJjyb5cepHGDZgf3/c4TKfj1raZvjivahGvLVnIp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DI4rRR4j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DI4rRR4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706263925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+ZcWiMYoKvFxgIikTkf/nODnFpcRPPlosghtgRXwFw=;
	b=DI4rRR4jfPtjy2LawyBDHazhVgMiITHEwzbMoAorDip1f551CUlq5c4Eqhnh7jaKr//JjF
	GmZgjVh1/+bqAM9cxvey+NwrHCMMAeqFNpcGGEunCLLTDdovJ5bt/rxQOJ4NtFoj231ava
	M8+vUprQp0wTYWJvuYc+yJmnJOlycyU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-qHAV4fgTMraw76I50hjZvQ-1; Fri, 26 Jan 2024 05:12:03 -0500
X-MC-Unique: qHAV4fgTMraw76I50hjZvQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ddc1b3042eso376825b3a.0
        for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 02:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706263922; x=1706868722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+ZcWiMYoKvFxgIikTkf/nODnFpcRPPlosghtgRXwFw=;
        b=CN4jDmBfQPOfjYbKhpqpNuhxtRgF594BBZjG+/q5hKpnbjt8E4965Iai4N188GExl0
         tQp3oPJVKXmmGayMn0SW2SDlhxVhUvkhQKse0TkUuCMTHG3OjG60fqDQlPN44P4is7S2
         sQGFyzNWY9XybsqX7RwvzHl7Qul606KPioubidYX3rGFZXVfsH2KRnZIjSBsFu1H3q5R
         0mjVjkOpw9yooLggw8jEgQxpFpnbehqRFQ3hfzhcJnuLEIENWO4K02caUdnH2OnpFUUS
         FClBUvprN3QN0Ll4N+4Ht+52HcTShXrJ6Q9OBCh/1NcyZin8BD9uoS9KPyK84Xa4IYxI
         IbkQ==
X-Gm-Message-State: AOJu0YxKaXLYU/hvoXlR4kHewTOzcmv89F4PJcqIRfTvMQZwcYaoLqnd
	VTOkXlbOYVvAeotLgbW/TyKZa++zVgptfcYfRGAzTjaFKzHkppzuD4LoZRp0uf+46FBPmvqm137
	fGOvi9vC3P9iJ4XTzoB2NzWiA4gm5aJladKvzQo32n+w6v365y1OP14KBw9LosJu5G3N6FuQcBY
	fJcIDcGIgOy8jFL9BeJO5pPwjZ7Oe3Vg==
X-Received: by 2002:a05:6a20:3cac:b0:19a:602e:e491 with SMTP id b44-20020a056a203cac00b0019a602ee491mr1101945pzj.106.1706263922274;
        Fri, 26 Jan 2024 02:12:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6GR/gvK+a0q+Ppsns7mWFUKWVvhbKkEmqtPKh5jrfASa1ijI6RWOSQw0hzKylDrGmnEf8VTZ/i+Qg8JVHwYU=
X-Received: by 2002:a05:6a20:3cac:b0:19a:602e:e491 with SMTP id
 b44-20020a056a203cac00b0019a602ee491mr1101942pzj.106.1706263922009; Fri, 26
 Jan 2024 02:12:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
 <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
 <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com>
 <CAEjxPJ5_SQDmR9b-+0woBLg25omtERSLBKawTV9AqLpZAHFvcg@mail.gmail.com>
 <CAHC9VhT_zOjJpg-JOaJQ4s9ybArfq2Ez_OiFAk0siPiqEC0KiQ@mail.gmail.com>
 <CAFqZXNvSn-Ct04ghSxiceKkRBgfyUeWJc3J0tjnU-Mm8mfPtAg@mail.gmail.com>
 <CAHC9VhQ4hopKwh6y=M2kZfgM=cdcWvqAbGAD9HMRhDDj88R_xw@mail.gmail.com>
 <CAEjxPJ4LvVr8w3bPLXrB7Aw=RS=CVnVwH0q7egQTP+F1Qzq1jw@mail.gmail.com>
 <CAEjxPJ4FxSe2RqLbnN0brsj32LspZ2Gh6r4GPWixv==X3X0oag@mail.gmail.com> <CAHC9VhRTfUO_b+dfWRNtFBPUCnk5iRCkCfT4PcNBt+b856t-iw@mail.gmail.com>
In-Reply-To: <CAHC9VhRTfUO_b+dfWRNtFBPUCnk5iRCkCfT4PcNBt+b856t-iw@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 26 Jan 2024 11:11:50 +0100
Message-ID: <CAFqZXNuqHKAJUdZ-3VL64Be0hp8jPjztk2NaUv4+XFcgUe23CQ@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jan 25, 2024 at 10:59=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > So as a side-bar is anyone running ./tools/nfs.sh on a regular basis
> > or has it been wired up into the automated testing by anyone? If not
> > and if we can get it back to a clean state, that would be good to do.
>
> I am not as part of my kernel-secnext testing, I should, but I haven't
> had the time to configure that as part of the test run.  Building and
> testing on Debian in addition to Fedora is still higher on my
> kernel-secnext todo list, and I haven't made much progress there.
>
> I believe the IBM/RH folks are doing regular testing, perhaps they
> have something in place?

We don't currently run the NFS-backed selinux-testsuite,
unfortunately. Looking at my unmerged branches, I can see I tried to
add it over 2 years ago, but the note I had left for myself says
"doesn't work yet due to NFS bug", so presumably it wasn't passing
even back then.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

