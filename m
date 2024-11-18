Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951719DF64
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961015; cv=none; b=a5jJBYL6MRR/Qvp+0fpd6HO5xVKCa25dPnMvKuGez5o/W9Qw+rRQDA21r3Bc2AHw6fxWXyONWb2JOqVcIdH9aqdPlc9DUYDEtGKORMqoceHMERheWpKGzrhP+4l1Md1p5mZJ+Swbv0z9H1a/TvB1oCC2EUqJSczDeDvYDMYsa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961015; c=relaxed/simple;
	bh=ihoOkcgHmqhaoPaIbtag1I8P9UZ1U3KV4lXc6+XZEbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QD4ehkdeAD99ahmo6jWEolRYBOduTZ2fSsag/eps/PYpsUFO5pwge7yxWJhzDMj9pxzwc23zriYXIX+jEJBdRt7gju4Ihf6FApH0T/aAzmuIP1INVPbLzO2QZrTdRw1W74QqYh4Vd5GNCtWA01M8qOM9D5JbOahZPaxuKGqtg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrFfFIW8; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrFfFIW8"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7181a8af549so161773a34.2
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 12:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731961012; x=1732565812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5LiQw4PeVgw7ztsxI54hSgKP7zrrsO1CPhzynRmlRY=;
        b=lrFfFIW8B90P/PJCTmQVyBqcQd/V/Q4DrzOVVz4O7247QU0brViUTH47I4M4H6rNRy
         g+d/lZzVzs5GrRb27++FT5c0Btoat2DemXi5O+Lq+bsxePpd0ZHnAeT00Ij73dWSJgJX
         n4RjHyvfhr15T/vUbLpUP7XLRyjk9ex4NAhr0uHMpM599zYBWIkYuXbBSfsTBmB+prRu
         x9HlRvK07iGzHt7B4nZHQWZEcSCVpw2b49Us76NZafu+xe6yjgoMKSfyjUMr0B49nTo+
         tIKu2za2L3WujNnV8SU9bC6p1ohh3ogHHZak1QAtDeyiyI/hJjiBkO4xmIy2N6+1fDth
         GaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731961012; x=1732565812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5LiQw4PeVgw7ztsxI54hSgKP7zrrsO1CPhzynRmlRY=;
        b=hdmZYjioobvHMGR99+N8ver5+6ybghg4xtu2tOKuJImfKGbxc+YgF1hW35pJ/V+rZu
         /Lmoi/0Spy40oEse7wxiXdEbVRXgNA5MZUFhcCsSJJIo0kj1Rw6UUmvP8AU26Y2hT0Ca
         AY/AE7qW3edBb10vq5h9DMFhl0ucre5JuvWL6TUnANj2nIKrUvUq+y035rY5/fFAxf0l
         0y8vACtbBSbjOyPAowmJzxjybhrSCCpQ1z0yjFVhM3I7qr9cw2qNSQEKHyxO4JTojSAj
         xiEcB4O4EHnv8iGoTgQisgL4jl1C85rW4SPcZpOFGbiXDQ5NPKd1SGcpujZHItKYBrwL
         xzRQ==
X-Gm-Message-State: AOJu0YxGine6bCtqfPb6iir76eBhOur3MksQA530QBnzPXJkgYIDqhYR
	B09NJl+oDKsXhe2rgNyG1AqBebypINrrPQPKszCv9k+K5838TPQeKbfzeZT+m/8X/KWIx94dwKc
	vir+clW03dcbm7Y/znjvWJ0amLfM=
X-Google-Smtp-Source: AGHT+IHZDMhpDw8kFC3Q9NhQC2ggo32GWG1onm7+bLR+WiQ6elDpSBLxdHbuPeOJXTgJteUQ9ftgBK79XZwecQuePc0=
X-Received: by 2002:a05:6830:6b04:b0:718:685:8f4 with SMTP id
 46e09a7af769-71a77a09459mr10298901a34.24.1731961012686; Mon, 18 Nov 2024
 12:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113130206.1417824-1-lautrbach@redhat.com> <CAP+JOzT_qOFo7b0xroSnK35YjAF9=tuQj74+w_eiTf_3nOyjqw@mail.gmail.com>
In-Reply-To: <CAP+JOzT_qOFo7b0xroSnK35YjAF9=tuQj74+w_eiTf_3nOyjqw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 18 Nov 2024 15:16:42 -0500
Message-ID: <CAP+JOzTLwgEB_4MKbTM+52XEE58+oEiVhZ7itWkgOq8uJ=oYow@mail.gmail.com>
Subject: Re: [PATCH] fixfiles: use `grep -F` when search in mounts
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Christopher Tubbs <ctubbsii@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 9:47=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Nov 13, 2024 at 8:15=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > systemd escapes luks uid so that mount points contain '\' and grep
> > should not consider this as regexp
> > Fixes:
> >     $ cat /proc/self/mounts | sort | uniq | awk '{print $2}'
> >     /run/credentials/systemd-cryptsetup@luks\134x2d6d1f41e6\134x2d5538\=
134x2d41a0\134x2db383\134x2cd41c2ddcacaa.service
> >
> >     $ sudo fixfiles -B onboot
> >     grep: Invalid back reference
> >     grep: Invalid back reference
> >     System will relabel on next boot
> >
> > Suggested-by: Christopher Tubbs <ctubbsii@fedoraproject.org>
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  policycoreutils/scripts/fixfiles | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts=
/fixfiles
> > index cb50fef3ca65..b7cd765c15e4 100755
> > --- a/policycoreutils/scripts/fixfiles
> > +++ b/policycoreutils/scripts/fixfiles
> > @@ -45,9 +45,9 @@ FS=3D"`cat /proc/self/mounts | sort | uniq | awk '{pr=
int $2}'`"
> >  for i in $FS; do
> >         if [ `useseclabel` -ge 0 ]
> >         then
> > -               grep " $i " /proc/self/mounts | awk '{print $4}' | grep=
 -E --silent '(^|,)seclabel(,|$)' && echo $i
> > +               grep -F " $i " /proc/self/mounts | awk '{print $4}' | g=
rep -E --silent '(^|,)seclabel(,|$)' && echo $i
> >         else
> > -               grep " $i " /proc/self/mounts | grep -v "context=3D" | =
grep -E --silent '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo =
$i
> > +               grep -F " $i " /proc/self/mounts | grep -v "context=3D"=
 | grep -E --silent '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && ec=
ho $i
> >         fi
> >  done
> >  }
> > @@ -55,14 +55,14 @@ done
> >  get_rw_labeled_mounts() {
> >  FS=3D`get_all_labeled_mounts | sort | uniq`
> >  for i in $FS; do
> > -       grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --si=
lent '(^|,)rw(,|$)' && echo $i
> > +       grep -F " $i " /proc/self/mounts | awk '{print $4}' | grep -E -=
-silent '(^|,)rw(,|$)' && echo $i
> >  done
> >  }
> >
> >  get_ro_labeled_mounts() {
> >  FS=3D`get_all_labeled_mounts | sort | uniq`
> >  for i in $FS; do
> > -       grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --si=
lent '(^|,)ro(,|$)' && echo $i
> > +       grep -F " $i " /proc/self/mounts | awk '{print $4}' | grep -E -=
-silent '(^|,)ro(,|$)' && echo $i
> >  done
> >  }
> >
> > --
> > 2.47.0
> >
> >
