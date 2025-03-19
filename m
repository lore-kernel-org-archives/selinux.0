Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BA1F5844
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394974; cv=none; b=Eq1lrVIoDBZBaw/OrwN2y1bEJhmetMj0qS/dL9hTn/Fj/XA1NNLeZnjyw75vpsU5Hm09b0Q4TQPihQ0SgExKCu+Jy3S3FkgmPQAQ4ulpbFtDYiZnibcXZtjK9Tl/sQ8n1u5VvfMk7gieTJBl8Wi14KWKracHNkj8hT0n2vjNAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394974; c=relaxed/simple;
	bh=ZNtQqg2n3jh5gNNuippBoOy4ZMJvFQDL34Wu668TwEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6zmXz5tbfOaVAN9u9x+v1KI660Rh5vSjNGqQP/v6RDbzX/lBMKOrIkq18ZBw9eG42adbW3OcgQ/UOPoImeX+VlMll5ZKvOmqONhZPvDai3STIR95lg/qG984Q4jwaQccRd2C4TphlWMFsRPWSW9W4a75LRwRYBza7bIUk9o5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/iG6zJs; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/iG6zJs"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5497590ffbbso7752856e87.1
        for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742394971; x=1742999771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNtQqg2n3jh5gNNuippBoOy4ZMJvFQDL34Wu668TwEs=;
        b=d/iG6zJsuzqym5RbAzHwNc3NMddNqir8AnAWtDN7BgzyWhax0Yffxir57GK0O+8Jtn
         FSLYLYPq/jbW1bd0upRb074+hQZ/HqUaA7gkL3Xd83URcQ5BpvS7csCarxdFF+0iWjap
         SLyCEwd+PvEWZ/xW6NQdz2guSoGK7GOQvPmlvRw38YykcsYYWnZ1QxRVd/yLFQUy/PIo
         61dUnyychm2DxCUf6/eqjwk8luONaBN7QyZmYS4tQSKh2qjwsxvVzk3wQbvtUXyeB/z4
         NguJkxCqn96ZZtEx7CN+VcxxGkoCztobdpbgMjuIHsZgDDQd6UFhCDg5MzEGjaKrK0xq
         YV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742394971; x=1742999771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNtQqg2n3jh5gNNuippBoOy4ZMJvFQDL34Wu668TwEs=;
        b=kIfzANouaAdm+W5+ego2AboNMwUg4nagIIL+/1wBJ0ZYBz97rO/jtzQl3UvfXPTsTe
         mcRXlDCS+/1Q2qF37arWMUosnLMxgpFwcv0wx4rqotxyrSv0MIAYmQW3FnpuHbfOjMti
         xuzCCuLCtdGPR4ICv1dkQHvJK2Z2RH5Ad7Fbf5H3lsCpfE8lk4yfL9spIr6OMvFCEH9I
         qCTFCVj20QeXaLSzeEXTwMegAPP1K4RMKqJQc+Hol6dd4HTgrqF1XtR5l9THt2nmWFm7
         zjphcxisLLydLIcD4YC3Wr378Y/JBJ0sjIffSHsEyKZH/n2Av7+LxC4LTp75dIES3GEA
         fDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvV1NUnwyOkWR3jqtA7+fs0jQiH98agfEOAlENbLGU2B3bTy+NVqzmyQXSg2/e7hv0O2T/nNOP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9QRlfT49t3ADDHtqkwZp2Ojplz/ghGOq2BIJ/RCggKnXLe2NZ
	Oy/erW6/1QnaxtgWaN5P+wA82UjssgULcs9YE3rZDPWEBxNbnA5pkqmnLGnQYX6WpTtkzPBXHKC
	skI7FEiIRdR5gWBnpbNzK5q4oSRE=
X-Gm-Gg: ASbGncuMVz27N70Tp7Kn0r37aA0ewPkow089pkaOLxGTLVyRMPNM72F0rsvVIAghICu
	iW/Wv7IALtIsrlg8iCo81SjyawAD9nMmRuCExTBXAhpNRUMx+zMmahwJ5VnK0ZZigQzClqQmiKL
	e8Rz/FOa37KhqyAEEbkkZEjoEu+61N
X-Google-Smtp-Source: AGHT+IFs3b5kpmrosBiwNCN1r7F+fWTg5hKIfOChamSbp+4gQrFLdj7oy0Mq8Kef2r2QodR1plLye3HnkCv82ay1NmQ=
X-Received: by 2002:a05:6512:4025:b0:54a:c835:cc58 with SMTP id
 2adb3069b0e04-54acb21def4mr1196079e87.50.1742394970678; Wed, 19 Mar 2025
 07:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de> <87senb7mt4.fsf@redhat.com>
 <8ca3a1ed-0f53-4da9-a86b-75699f306f8c@suse.de> <87plif7egm.fsf@redhat.com>
 <CAEjxPJ4DZs_1dPuO87UPpuvQL-PEq6zq9KA64SQvzsT1Mq8CqQ@mail.gmail.com>
 <87msdi7acy.fsf@redhat.com> <CAEjxPJ7Q8y+3S-kR6bKmRc8HW+ArDJb1z9D-=sRnWe+zYEW1eg@mail.gmail.com>
 <CAEjxPJ5rG5yfwB=8aH8iDFTXgo8W8JBmjLMA7A5q_eMbEJmgaw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5rG5yfwB=8aH8iDFTXgo8W8JBmjLMA7A5q_eMbEJmgaw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 19 Mar 2025 09:35:58 -0500
X-Gm-Features: AQ5f1JpBCZa1byv88qVYFq6JE3YykM_WcbPFgusPZYkB4QCvx3-BxzxUXVP6CzM
Message-ID: <CAFftDdqhoXSFzTGS4682apa+MtVWWEqnC29WVbQQXfsVqZ+svA@mail.gmail.com>
Subject: Re: Question regarding restorecon and btrfs read-only snapshots
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org, Cathy Hu <cahu@suse.de>, 
	fvogt@suse.com, selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:25=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Mar 19, 2025 at 9:16=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Mar 18, 2025 at 9:11=E2=80=AFAM Petr Lautrbach <lautrbach@redha=
t.com> wrote:
> > >
> > > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> > >
> > > > On Mon, Mar 17, 2025 at 1:32=E2=80=AFPM Petr Lautrbach <lautrbach@r=
edhat.com> wrote:
> > > >>
> > > >> Cathy Hu <cahu@suse.de> writes:
> > > >>
> > > >> > On 17.03.25 15:29, Petr Lautrbach wrote:
> > > >> >>
> > > >> >> You could use `-e <directory>` to exclude read only subdirector=
ies.
> > > >> >>
> > > >> >
> > > >> > Yes that is possible, but also requires a manual change by the u=
ser to set
> > > >> > this up together with the snapshot (same as telling them to add =
<<none>>),
> > > >> > which we would like to avoid.
> > > >>
> > > >> Your -relabel.service's are generated and so can be restorecon opt=
ions
> > > >> there.
> > > >>
> > > >> Fedora uses fixfiles -
> > > >> https://github.com/SELinuxProject/selinux/blob/main/policycoreutil=
s/scripts/fixfiles
> > > >> - which detects ro filesystems and skip them.
> > > >
> > > > We already have logic in libselinux/src/selinux_restorecon.c to
> > > > exclude filesystems that lack seclabel support; should we augment t=
his
> > > > to also exclude read-only filesystems to avoid the need to work aro=
und
> > > > this in all callers?
> > > >
> > >
> > > https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/se=
linux_restorecon.c#L238
> > >
> > > You're right, I didn't know about that.
> > >
> > > I think it would make sense to exclude also `ro` mount points.
> >
> > I think the tricky part is the case where the caller deliberately
> > passed those mount points to restorecon/setfiles. The current
> > exclusion logic IIRC won't exclude any explicitly passed directories
> > to avoid silently failing. But skipping read-only mounts on a
> > traversal of a subdirectory would make sense IMHO.
>
> Actually, maybe not. Scenario: Read-only mount on a higher level
> directory with read-write mount of a lower level directory (e.g.
> read-only / with a writable /var), and restorecon or setfiles invoked
> on /.
> Maybe it is best to just defer this to the callers.

You beat me to this, I had a draft sitting in my inbox. My suggestion
was to report that it occured, but not
fail and keep going if the return code is for read only failure.

>
> >
> > >
> > > >>
> > > >>
> > > >>
> > > >> > Is there a reason why these r-o subvolumes are not skipped by de=
fault?
> > > >> > Could they be skipped without a problem and it is just missing t=
he implementation?
> > > >> >
> > > >> > Thanks :)
> > > >> >
> > > >> > Kind regards,
> > > >> > Cathy
> > > >> >
> > >
>
