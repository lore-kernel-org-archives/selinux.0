Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7694A2E3C
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334077; cv=pass; b=Lnz+9efM8GkiHicMNJrWCrVp5fkWGyGma7mzszJ9XlD6I0I9Nm1QceuGpyzHlPFP8UqT6PP0Uq+GxitBTb7pB9LoDRfjSxCSe4F6zOxvANQnCmaLVZzj3Z5+uEQVtjbFarCxYsCzsCIMSbhQvqEvz14fKNqAGY4IwPIhakzch0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334077; c=relaxed/simple;
	bh=NZX9KQSi4t6JLeFDvNO8DNVfRGm3PsFReX0dShpHTgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1hAKbX+rb574nb0MoRrdQwjA7ZP2j6tAgEDNyoLvRuhw1LWe4dZywNuaL7SK9Ub4kqKCPprv9NW6cs7rZJAXZD7kmObjlbPjQXQwcxt+v1v8UBVK+LrK0psWJNp1FZyqHlKkus5vNLnQhxgEEuWsghiqwdEQ7MWqJD2f9V84Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U13fdE+C; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U13fdE+C"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-456d267da8cso421168fac.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 07:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334075; cv=none;
        d=google.com; s=arc-20260327;
        b=NbgAS5OwqmXhHbrenPtIBafX3k2dRbYIeQZyq8laZmysInI60PDhAcfogJeeH4qtHY
         rVBFz+rpil8/1QkFK02MmBwTU7mGf6BiZ5quifE8dG1mC0q3hCv6AQgrBoHdNRNvXbLZ
         PAsxGBT1bqyRgL/AwL3CFH1MH2C2UScimVapjFZMg+G9TJRH+UPlEGoWLSKW4ZaB4D5l
         FQTy82zLR+2OGYpIMyQWZt1UQDg8YZrrUs5UZqZ15Wn6J1NQSrMRKGabWmWAPInlp4Va
         oP0Mo8nFI0V3bU8yIWtSFNs/xg+e5pj/xcqp2gS6w4+NxXPkV58RWneLo/v6iBqOEpDL
         /BzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZX9KQSi4t6JLeFDvNO8DNVfRGm3PsFReX0dShpHTgQ=;
        fh=AcM94OJIMGJviAbdHqCshDJFM8mO58vuyET3wz+AzuA=;
        b=mq5sgOZrl4lMCMDjZv11jahk7QJNltGZSQn8A3xNu5p1FHNFQ+zf8LAbdBvzZDeRYR
         gpxaSF1zBQ0qAzJOOPNq7eCPMqOLEFFT6hRgUblkhsge+BjpZmiHC1QBVU2UGBhXRYCL
         h43Wll1dCaGxBhwwF5Rz4TotMS23u1+fOqWFU1pNQaUx2W6BEkS7mihCxHPvv5AJ/rj+
         pqxAsV2p6s9h4ODcjUUya+eZQvvdX4aCZ4NSTmwh/m79SNgbYA8+Q3/VHkH5ZS8SVv09
         bunzn10PlJpKbctDUw+YZi5hi8vfSA9qpJtBv4Dz55mtRPMUWRS6/5ySfRGPhnQ+xZhz
         KiTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785334075; x=1785938875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NZX9KQSi4t6JLeFDvNO8DNVfRGm3PsFReX0dShpHTgQ=;
        b=U13fdE+CB7yzyTge2pPnDDNgctGqQ1/79yBONlNBOm2UR0J4wtN8VDwFjVjilflhrP
         OV5WBCNbMGKDActWp6Q+MyPaMIBE+xKN2dUCCcAo1TljPpnv8PfSReKCQFOWC8l8XUMs
         6RpOvA5PTLtGycjM23dJ0ep6cvy5x9n7GCOnOwMDo/xFlZNLkCUdbrYJ9NrYd53ylRAp
         1KSagM2Wp98W9sVtb5xUZUZSjlxhT6ZTLu+jmgxQOol9WeMchIq2ECf0w7BOBA5E2gzY
         Yihtv/vUuHDC/b/jVzvu7tMdj+06B5ElC7UERrlVrWDp81PQzrPIUdFSMRFCse2entNz
         w29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334075; x=1785938875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZX9KQSi4t6JLeFDvNO8DNVfRGm3PsFReX0dShpHTgQ=;
        b=mDihuS2uLvPPm8xeYrazENYrik2CO4YscVJdFR57Na0IW42flXvIIV8cGbxrmQ37+0
         reBpfREA4Zu32JpiF5hdm90rU8iQ2NuHkBG8ig2Gbs2oR0Pnu6Ss2qI/dfxYjqb5P6Sp
         qhJoLpjBHBtX7PeLBnLmle2TXwnaQH2RNVQh59sNnO0YdWsRGi6IQvdCZNyYeSXwDBF6
         QmMup8BNfw+ej4eELufEUyI6aIVjIpSee47JlMjfqozERiAihXcXl0Q8hKAu4akMAedm
         Bgxt5Ady8D/SyDDoLCdnwxWrBFBb1enmNFINGUUrvfjyoomrY+sq1mvlOJRXOUxLf4fZ
         /Q3w==
X-Gm-Message-State: AOJu0YzNSkHc8rmJRYxQ1Q+LlSaj2V5ET2bPGDvq0d87tKjDwC8kiovA
	DH16Xv8gAyyIZo3KdWhymjoZWQObyliQQcyYa40zACpV5iRDhAM9vb4U2vyD5CyUIiU4UnWqajq
	8LiZHvwepfP31JjvsUaIm7oAQP38Cox0=
X-Gm-Gg: AR+sD13kQmDPvXPnkTKZcsCJ716Jz9j2kJUPOPvhGtoPNjDCxv0Zw/VNaiyHcgbGr/F
	2uy1XvhhBcbHDU6lZHLJU3Bk2/+JafC8xNKqtIPdYoz9YBq4VGZtTLzWDj7eP2DVTUSsuV2KwWK
	L/4AI9HbPJezcXgf4G4tOkBS2y/z1mU3vILWWYXopl1a7kipQHqIgjD4KBSwiXOwGmAKZ6Lovd8
	aTqOatcDhNR/0SahRux61tz+FGifQZiznSpsksla+yIRCzAH64yJ4uuG9VFsm8IdNjtUWypC0BR
	q9uNV0OT5ptpz9b5Z6PdWMcJoJGe69CA4NyvWH/qdOKaWZpLA/latRw=
X-Received: by 2002:a05:6870:658b:b0:456:b44b:a287 with SMTP id
 586e51a60fabf-4586cf82ef9mr3901756fac.29.1785334074690; Wed, 29 Jul 2026
 07:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729131203.53945-1-stephen.smalley.work@gmail.com> <CALAjPzH8EVi_f27kpONesg=KP7VqmShxJByXmg5-7j_+8zH-LA@mail.gmail.com>
In-Reply-To: <CALAjPzH8EVi_f27kpONesg=KP7VqmShxJByXmg5-7j_+8zH-LA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 10:07:42 -0400
X-Gm-Features: AUfX_mw95Y2NwiehAJlND6KjYOvkwtt_is9xOf3mChpslmWQ6RFTs5P8yDrvAjA
Message-ID: <CAEjxPJ7tyeUgPEERV+y7w8rEuD0ypHoT71ZWeC2x54-cvok=UA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: selinux_restorecon: avoid triggering
 auto-mounts unnecessarily
To: =?UTF-8?Q?F=C3=A9lix=2DAntoine_Fortin?= <felix-antoine.fortin@calculquebec.ca>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 9:38=E2=80=AFAM F=C3=A9lix-Antoine Fortin
<felix-antoine.fortin@calculquebec.ca> wrote:
>
> Sorry for failing to provide an update earlier.
>
> While implementing patch, I found out my initial analysis was wrong.
> autofs entries do not have the seclabel attribute. This was not the
> right cause for the automount.
>
> What I found out was, there was a second mount on XFS with the same
> path, and the seclabel attribute.
> restorecon was therefore triggering automount while reading info on
> another mount with the same path.
>
> In summary: restorecon called statvfs() on the pathname of a hidden
> seclabel bind mount listed in /proc/mounts.
> Because that pathname is covered by a systemd autofs mount, the
> pathname-based statvfs() resolves to
> the topmost autofs mount and unexpectedly activates the corresponding
> NFS filesystem.
>
> If we would like to avoid restorecon triggering automount, the patch
> solution I initially proposed has no effect.

Thanks for the update. Ok ignore my patch then.
Not sure if there is any easy fix for the situation you describe.
