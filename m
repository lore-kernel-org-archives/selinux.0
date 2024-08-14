Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30A1BC06F
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656999; cv=none; b=JqInRblQM7KxDUoRX28st9s/HSw9YxiWCRQU2kHqtevXFL3XoolMlzy2jy+OnojvvW6H8lh50+vML43YzPsNDOinrNZww8PjlgDgCS82lcQeqmuURDN9aN/73u9Qpbff27Bzj7/ia3ZYBKUhgZ7+wadVX63EM4U8tJY+y/5ukqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656999; c=relaxed/simple;
	bh=j5zfVOOJv15WtPA0XDPAjeNMVpd1e9s1SSYbKyhiyIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9TlBOfcXuF1a5emqwI/0HT/9QnDGAWjVgBk46VKkjShY+dgiWeC1GWIKIIB5JveJKm0cfYBrZazmM0bVEHyQkK3gBUWE3jEShUlu1hB/Ku72iHgElVkLdZKFH5m/VH+BFDZK+QBPEdpqOaj6ahCNMIZQigHBFbd6F8d9VT/IIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcqL2oM7; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcqL2oM7"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-81ff08e24f8so24033241.3
        for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723656996; x=1724261796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sSRqQDTRnco/4RIzcXPm7FSDkNAfr/+bSx+9y2tdj8=;
        b=fcqL2oM7dgEaljnvZDV6XkLx7u54bI+egRlmvkp9RyZsiR8JVSqjKXuMihiPMXY/A9
         0ESyrafYwKn/zXeJamxddSXscg/2MXhewhhAVdqmmQ0FmNwGuUzmKebpOFdkGZPfAs5y
         2GLYUZFhMGGbpsRN+TBqrRSeQ9HGnbXPtd6SheHczw26KQzNNV8rLFrrLffjHUHHeeI8
         e+kEmNeft1OmWzbnFPX/iOKjWD0YG40Cx33L2UygUqy0sRYnSrtoBqIbj7e1G1t8DWdP
         aU3yucS/Uiqn7rVKORrY9Z+qFyy16DArr3egWq+umTzLIblll4BvtF0MIiKhHvudXFK4
         JGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656996; x=1724261796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sSRqQDTRnco/4RIzcXPm7FSDkNAfr/+bSx+9y2tdj8=;
        b=NiFKCQKsyTqd26IpWicoVgME0DF+HgF2ZVtQ5xCfcmMSfFoW2MgC72w6SdfPqDYLi0
         vNC7nvMs22CGGTPWeSe8hq+07jwYzONWLryOJRExnWYuJGQNQREf8yN0tqou/CKsLgr0
         nDpkK+2p/8NC2WkuX4bF332Zuyeixe9Fjeb9aDssrUUQMaT4WhCLXnfxLqIsG7JvxXCo
         LzBHnbNVwwWoeRyL86aH1G9ps0YqAg2Hugk8K+HlOlA/otxTiqoJdr58RPLHcaevCW4J
         Xj6N8PnWnS7WgV6zbAfk0dlXW+GpIRcIqJeXVpc8vAX+OyELpzi6XLuS8Gw4GmtBRuTg
         PLJg==
X-Gm-Message-State: AOJu0Yw8GhTF7hzKSEkTO2NQsfd0knc71l7tNZ9VO3scvAVeQ7dbHsHx
	9KBDtBFQamYsZx5fmD/NVP1zyjM60rxJ1TNfEnlcjTKQMM4sWKMr6VLSk4UjSMYHBLadStWNEmk
	3fzU8aNElgFQDGNH6QlfRT3/M/Ac9mw==
X-Google-Smtp-Source: AGHT+IGmOvG+xskzo1BMQ7r6U468BgTh8rT3ukHr+OQH87e5Bb4Ha92Qn3BK1Wul5F3duPU+UTr+wlaEp5sP6Trm6z0=
X-Received: by 2002:a05:6102:b11:b0:48f:df11:5f28 with SMTP id
 ada2fe7eead31-49759738cdcmr4734313137.0.1723656996364; Wed, 14 Aug 2024
 10:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801193241.1627605-1-dmitry.sharshakov@siderolabs.com> <CAP+JOzTSHd5uwVLfjH9e7cACCkFcm92=F1HhAET+V=byLiV+4A@mail.gmail.com>
In-Reply-To: <CAP+JOzTSHd5uwVLfjH9e7cACCkFcm92=F1HhAET+V=byLiV+4A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 14 Aug 2024 13:36:25 -0400
Message-ID: <CAP+JOzQN=AYCRJEPqHx4NGkHauEB81f+_DTiBsZYRXCqv9tT+g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] sepolgen: initialize gen_cil
To: dmitry.sharshakov@siderolabs.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:42=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Aug 1, 2024 at 3:35=E2=80=AFPM <dmitry.sharshakov@siderolabs.com>=
 wrote:
> >
> > From: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
> >
> > Avoid errors when adding comments to CIL output like in audit2allow
> >
> > Signed-off-by: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> >  python/sepolgen/src/sepolgen/refpolicy.py | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolge=
n/src/sepolgen/refpolicy.py
> > index 2ec75fba..32278896 100644
> > --- a/python/sepolgen/src/sepolgen/refpolicy.py
> > +++ b/python/sepolgen/src/sepolgen/refpolicy.py
> > @@ -1217,6 +1217,7 @@ class Comment:
> >              self.lines =3D l
> >          else:
> >              self.lines =3D []
> > +        self.gen_cil =3D False
> >
> >      def to_string(self):
> >          # If there are no lines, treat this as a spacer between
> > --
> > 2.45.2
> >
> >
