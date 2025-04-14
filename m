Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E771C6FF3
	for <selinux@vger.kernel.org>; Mon, 14 Apr 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665911; cv=none; b=kFtNSKmbZtJcd2uGOzYmEsM/MX7nntp7Lbdnz0mBoIiuaiIERhxhX0ostpF7BLZPPjStQGKaP7YJg3LY0ZJy/OE7eU3Rs9h8UG9IooPWa7eH57AVwAdCuts8mPEXwDAibBvh6erZaTwkDDU2vjI0dr91F/LEiP6T11sk9rBbcHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665911; c=relaxed/simple;
	bh=5oIbvRxF0USchrj14bSwUNNJ3s1SrhencSvPxyJGIJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2BnCKjMHH4GcqbFeujLO25NjTDXVBPTsXStZ8WkUR8FzLt7OItjFwzU/4jTYGU5Pv7DUNLzZ6vKh8S5XmkhZb5PeSA0PSPc4e4OfMUjcaqZnkaep0XIWetyjpiYyUx+zQ3ArMkB3frI6quF87Rbbi24KhYxDe4/v6CTDLVWwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bwttBaco; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bwttBaco"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e694601f624so3329428276.1
        for <selinux@vger.kernel.org>; Mon, 14 Apr 2025 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744665908; x=1745270708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j27ta8bBAhn6IQi1yy9ANtDwz6vKmTPJJfYR3WIMUbQ=;
        b=bwttBacou5gU3hwI3tt2I5KA/pwt1ew1NfwSQ4vrX0JXegl1WNwUn2NArym+jITFG7
         L+kwEQpa2pbVNHYEa5VMWRxfUnLDsrH0Zu967hzVUWj67ZB7a4US2o+TUltV8IeoBGYe
         73PPoHm6wXMV+4GfC3S9QvwhLYpSjd3oraGTimgQFcIGox8OgjKtbCL8+0B3O5vqMkTZ
         K1ek42rurRiyDZTeERMEbzwTEStoCjFQSgc7zgwkC7XKidM9DQXHiWaq/GH6oAkaGe4o
         h1Sml/cw3IDgR7X4xSUN1Ill9X4DSRFiqLDvKRMyNYFRxwIKQr6eUPTkdquUbmW/M0Ic
         uxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744665908; x=1745270708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j27ta8bBAhn6IQi1yy9ANtDwz6vKmTPJJfYR3WIMUbQ=;
        b=CzgDow7G7pYUXhzieMJyErkJ2YjOxAzzbt4aT7nzks7cVV7K0TdZc6gEp125+vnAyJ
         3wWz0nEFVQq+5XYOe/WDuCOb7DPb922MYHmOlnclBFO9QOxQSzoqpfbymoPNsz81EIHS
         iCMFPlzIgqU2Om7IvCo5y6ILBqjckE+3rLjgyrq9l2xvlSWqJbq1GOJdqCZKHV48pBpM
         kz6zBHYMD7GNCsQkpf7IO1dr557kOhicSlsAxUi+GMLVYlvr+X9C88eJzSWsiR+Zaye7
         td1KqiK4v3bxF4MpGw8bPLR2RjcYLKwnyyJxXfnMYmwfdbpwUJTLrOwE9UbhKLTBFERv
         9Tpw==
X-Forwarded-Encrypted: i=1; AJvYcCWWA8zWaKrmH0yt3GFOwCXB8Sanog95wbaXIC1QcEk7lkV4AICM2jzyrUnosaE1gTDAj+TOAKsu@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvl5LKjMsGIl1dQBM924E4/4NQ6rk9yHnYlc8ruhbwDZ4TOv/
	Rs3pND6kaDF5NRJOjZjc8kN2mofiyNELg93ZfTCLlr7sxm/Vuek+i2pE+z33JlOGVSoybC0b7AW
	ep65j/OFcX9Ka/2KGFDPTX/CgRqtyyf1euj7z
X-Gm-Gg: ASbGnct65dmi5ZfkHIIweUkD61c7G3yJB4C7cyPGTIV6bJ4NxvZEcz2eUei3e20mm7p
	NAKHwKHEVA/QA9ys6vsCLhD3fa1sPdTB9QGF0LlH9UYLllyobVX3K+q4rt3MOaPnP7t5JtWw+OV
	kS6l+8dYw5N/wxSkSS5QMylw==
X-Google-Smtp-Source: AGHT+IGl0TdqXW0b16XAp2chkawzwUgS7LaydCbIQklO9Q69WEz9Pb8N/MtkKMA2xzmwH4bTr27SA72y9m+KihNXjsc=
X-Received: by 2002:a05:6902:4888:b0:e69:192f:c778 with SMTP id
 3f1490d57ef6-e704de88c96mr22047504276.12.1744665908154; Mon, 14 Apr 2025
 14:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <8cf7d044-bedd-4516-957f-309f93b95f5a@oracle.com>
In-Reply-To: <8cf7d044-bedd-4516-957f-309f93b95f5a@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Apr 2025 17:24:57 -0400
X-Gm-Features: ATxdqUGEI0KraLnSMoBGg6LYbgdeYqRmKIaQ0UoYbAOiVmAQJDzx1Awjqxw_gBU
Message-ID: <CAHC9VhQy55d4Uptvs-6y1y9BvFA9zksvJkRH2BHk9QSo=T+-kQ@mail.gmail.com>
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Li Lingfeng <lilingfeng3@huawei.com>, 
	SElinux list <selinux@vger.kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 4:09=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 4/14/25 6:53 AM, Ondrej Mosnacek wrote:
> > Hello,
> >
> > I noticed that the selinux-testsuite
> > (https://github.com/SELinuxProject/selinux-testsuite) nfs_filesystem
> > test recently started to spuriously fail on latest mainline-based
> > kernels (the root directory didn't have the expected SELinux label
> > after a specific sequence of exports/unexports + mounts/unmounts).
> >
> > I bisected (and revert-tested) the regression to:
> >
> >     commit fc2a169c56de0860ea7599ea6f67ad5fc451bde1
> >     Author: Li Lingfeng <lilingfeng3@huawei.com>
> >     Date:   Fri Dec 27 16:33:53 2024 +0800
> >
> >        sunrpc: clean cache_detail immediately when flush is written fre=
quently
> >
> > It's not immediately obvious to me what the bug is, so I'm posting
> > this to relevant people/lists in the hope they can debug and fix this
> > better than I could.
> >
> > I'm attaching a simplified reproducer.
>
> It looks like the attachment did not make it through.

It did for me, here is the script:

>>>>>
#!/bin/bash

set -e

systemctl start nfs-server

for (( i =3D 0; i < 50; i++ )); do
    exportfs -o rw,no_root_squash,security_label localhost:/var
    mount -t nfs -o
nfsvers=3D4.2,proto=3Dtcp,clientaddr=3D127.0.0.1,addr=3D127.0.0.1,context=
=3Dsystem_u:object_r:etc_t:s0
localhost:/var/lib /mnt
    secon -t -f /mnt
    umount /mnt

    exportfs -u localhost:/var
    exportfs -o rw,no_root_squash localhost:/var

    mount -t nfs -o
nfsvers=3D4.2,proto=3Dtcp,clientaddr=3D127.0.0.1,addr=3D127.0.0.1,context=
=3Dsystem_u:object_r:etc_t:s0
localhost:/var/lib /mnt
    secon -t -f /mnt
    umount /mnt

    mount -t nfs -o
nfsvers=3D4.2,proto=3Dtcp,clientaddr=3D127.0.0.1,addr=3D127.0.0.1
localhost:/var/lib /mnt
    secon -t -f /mnt
    label=3D"$(secon -t -f /mnt)"
    umount /mnt

    exportfs -u localhost:/var

    [ "$label" =3D "nfs_t" ] || exit 1
done
exit 0
>>>>>

--=20
paul-moore.com
