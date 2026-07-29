Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5430C158
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356549; cv=pass; b=EhC3QOTerMV6miqy8sNJt9jcBhuBnYyq/n5Tb2k6ymkWfM7sKASX46kY6+Jioqs6CoV7onanxwODoBvdqnxvuzjJrQFGlMqprynReJQfkDYcpsaFpUugb205CpMdSXrFAVehzD4eKmFW9TgPKBnzGWR8lNIaxDFfyI+chnMSZ6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356549; c=relaxed/simple;
	bh=lIATLDtIIrjoLitdd8lioe/tCabNLehXwBdbmaF30pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNDhdJ0uMwmFDLSXaiKf+4fAThyaRl3iKbP70+coqtbRKaF0f9Cwxvb1eH5EerX4ZnjoyQvW97FUxXkki/vQyUqHOl6UX5MpB8NxLSKuvQO1dEVHWND6VfYbJQdWUySO6kd+KQxGNqJiNedrjZ66vCuW8y+tDfJXMMEJwgV6gxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF3OZa0Q; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF3OZa0Q"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6aae5e437caso790940eaf.3
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785356545; cv=none;
        d=google.com; s=arc-20260327;
        b=i3r15FBp9x1c9yUcQ/omilpiDFUWZOQtq48uDbvMZKAvPclAjugfYt0+z9+J/9cG+z
         e4JNFZ8t2v9KOAA2DrwYgZuhjB1ZpCGxgeHQVDZziZMWlUGvbVxKIINPYFRq919WhFfC
         DkAkX/gVyJaMAHrVCzV6E1c984t4flihhJah61MlvNEJ1Hd7HyAs4LiNN1F0U0JpAAZy
         tk1YhBEhG9Y1f8xR4BqlqvLom/ji1uJBnb5/75IbKY+2X/bJk1xgfMKKJyqIOXW0ZgyK
         QjNDi78ZWuw1saZEahqr3T5h1aihe61f3EPQcvO32WQnjF20J0xLCaNujsjBxE6E3Gdo
         /i4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lIATLDtIIrjoLitdd8lioe/tCabNLehXwBdbmaF30pg=;
        fh=E51Jjr8Bz9WzQ+Ik80n9UcoRPIh3NakEhV8l9xr/qbM=;
        b=aJ095XIAJp7Z1grhakQzmPSlNHEzuMdKJeBy8p1/OqVzK4/74lcHwD2NM+aen2pggY
         tQ85hx+qO2B3uzRX3AY518WyREgvAzN9srxS9MwJ5hwu8GfGLyUjn4tKwk0296nkfuYA
         GgPLqykg7II9BZqgh//w19yXzAjr8YAuYph+wOdTbhwr5p0zh88oU3nrMXmOdsbx6a7g
         2YbGRcfGhKdDPxZP8+8ryufmmuFHoslJM6P047WbRbI6G79vbli8F/F32MR3TF3DUhhE
         /RgaymrvVqIwGXwTSjlFC5mMEQT9Ybtwie1XjoTxl3F9qG2xsXkgx5LYnRYcGuLFbYzs
         IweA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785356545; x=1785961345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lIATLDtIIrjoLitdd8lioe/tCabNLehXwBdbmaF30pg=;
        b=HF3OZa0Qis6nhGaUf5A1l6ntI7mw7WEAukAWP5l2OSP8rLjvrflB58zFDJpnlPECq5
         TcUhQ05o6SfcLmKE19s96Pon9p2Kph9LGTEiYJeuEAmhNzrNoawFKzhLwFUr/MNWDSqN
         u1JO3O5wP/QDfQPFEKDVeGsIuSLSxFu00+eskr2xTi3KE+YeyGG5u9R0KChmUeONuK4N
         cNf3T2an6rT5TLJEh0mBiHxFN1f6uiYbGT/ANNTG/3228zYzBBm/Cdx4hMd7j/hBArhk
         r+Zcc0EKSTQNbDIWaq5809LejYkAPxGxoWE9eAhyrkj+D+hb89QF04DTgoOtL6qeit0n
         U5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356545; x=1785961345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lIATLDtIIrjoLitdd8lioe/tCabNLehXwBdbmaF30pg=;
        b=LR7rVqQd8KXjwAL0OuQMVNLOhBWFZk6ow30Biq5OX4Dmv4kwlifOnegQMA6VKx2uFd
         0WanoggjO+68XRqIMi5cfCE7COHez54hrX0bjYHraGywWPw4FbTSDZDV6O3fhgjnkfm1
         WFFGD4XWrAZoZtZz+8pyLwAva1efxFBSfS3pEgfmTNG7glpcK6DV46GBJy6zhKj5kx1w
         8HXYLpHBYLCnG62xudC5PABBdmtEEWJdDLpSVkNGCVqQhnCVt/py4SlSVjrsMbOw+jTq
         VjxLFPbNqqx1Y/afDM4XutJ/hTfSBSPFXvnR85NyXOnV7iy8xhfxvJhtMCnbEe/1wx2O
         8FbA==
X-Gm-Message-State: AOJu0YzXvmEdoPyxJR2tfHSLuWCZlonWxe4GR3uZof8XKl6g/nddoNwe
	qohYOUHxwqYOCg+MQMyAG8YH3xOgVkqtj5bEbmBSymx1RKWtAJShktu73KWZBqBJ9HCYCNAmYtz
	rYXfPhuhTrZm3opTQfzQhNkfDwW7x/BToZA==
X-Gm-Gg: AR+sD134QM1zv4ddzGgf2/Dh7rP+J2Z7FUd5Q8S0Oqnm0UYrmO4NIhJPzKtvy2vAqVD
	o2UXGYN1O+/6iCqnoAbqxw3JgJsv+ClJAI4pjwwnyT1jUhgD/3xR5XyOmAgevLsmQc3ucT74rM0
	5DSTCS6qIHp1tN3xPC1fJEazkT/Pf4kTHl0aM9PrXmzKCpVRqAXa8mUqVty78ThWhAWRewdO4qe
	B02TJ29i6CiQiUfSCY8C3ovZTLNs+rT4KqWiHQoMB9eiBXoTxYpyeNoBF3p4eZTuUEQNa5e0cMw
	GvBLxcvAk2U2PX/jaWC9g3tFcHpRt2iPeK6ElTiQZ9fVMcg8LFUgWhc=
X-Received: by 2002:a05:6820:180c:b0:6ac:9658:b935 with SMTP id
 006d021491bc7-6acbb7f16acmr12751eaf.59.1785356545573; Wed, 29 Jul 2026
 13:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729145524.3882905-1-jsegitz@suse.de> <CAEjxPJ56f86q0+Yhyz6TQRqLKNUvMiwDzR29Se-MzfauWwmXwg@mail.gmail.com>
In-Reply-To: <CAEjxPJ56f86q0+Yhyz6TQRqLKNUvMiwDzR29Se-MzfauWwmXwg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 16:22:14 -0400
X-Gm-Features: AUfX_mzVKhpDO77IpE10mfZcIO8I3jHjVt44n9er5Azt-GqGLxIFieqPmIwc_fE
Message-ID: <CAEjxPJ46iSwE7GDjK515hdMNRJvbdnYqji4bCC23JQS0k6P_9w@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: harden systemd service file
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 12:17=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 29, 2026 at 11:32=E2=80=AFAM Johannes Segitz <jsegitz@suse.de=
> wrote:
> >
> > Start to harden the systemd services file with some of the
> > unproblematic options.
> >
> > Signed-off-by: Johannes Segitz <jsegitz@suse.de>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
