Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8504207679
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042454; cv=none; b=oAdxzii4QEm5HTpCjgIXE16gWz1fPE2dAUbX8vh9p3UbSPMJ2XNImXN/Ct8sWdulw2VSgATxdL537pja2rliivOTLeydffhfHofgRvZMS90v/9yhCh+xha6cyMQPl9slJTzKDi0U2kslNx0per1C9mAF9QOnqDzsfQ8IHxvbXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042454; c=relaxed/simple;
	bh=ba4cbq2g5wPFESyAlw1fnlwATywqt14hm75Tiz895w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbHau7AJ6Aryy/4KTTQaY2DrZ4VlTc+rcjKjpXV3K3Fzx7cXsN2pNb86a/ToF99G6iKS+hbkl89cO3cLVVCdiZIehkP+J9aqOfeaZUJdNqCV79122/H8XyKWcJD8HBeP08If4nr+wG4ZhZe+Y9qodMCvHvETpIZPjgsfqAx6kiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db4TFfwS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db4TFfwS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30384072398so3488119a91.0
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 09:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744042452; x=1744647252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFaFA8RuUiGQa9opfinWxHWh0Nbk9Ov83Ahk5M+UKnc=;
        b=Db4TFfwSszMWPJQoV/UFWa5Cf87JKy0wPFw0qhTER14HH8NZ8AQ++nz6srofX7jYHL
         LxapyIdY1Lakklvy31DfQA3ATvWtuXagMwYtb+b8vM6ARuc76FPOEFr8+kmmGlnIdzvq
         gGVTi6R3BK0mOpPOmF36TV+3vlmjfjy7j0QvijLNopr0OPx13iHJsBxZJiQiqJO6Axg1
         f8tF6UzesyXFZriBKrgEaCVwxmSLWXQp86CoSj8JnVFi2gDjkol//roAaUQ2mNnUuxPQ
         wDtgXORMc0zAWdIOk3tNPI4XRgjBkklqNlwseUvNxxecYIK8hi5im7HQqQZjhMUiuHKd
         GGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744042452; x=1744647252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFaFA8RuUiGQa9opfinWxHWh0Nbk9Ov83Ahk5M+UKnc=;
        b=W68M9beY2s+ZlrTPyHZVfGH2Ryzbdn0sYxUFsrd1s7O0msg1z3xyV1oK8IMKKZS39G
         VVirbjarzjGLvTLAE7+00B7dW9csywDtHmpYKND61CYAH7RgiKiK469CPkvSbzDtrCau
         4LoG8aslfSQoT9OKtX0nvOgRYx6Knl/Erh2aOG2WVXyU4dqyfWP1AOfkksRHFOd/nQLR
         eVFi/KFDnXsI9TYylhlNJDwJeVBfaPiNUbmfU5YexROgAk8WPaazDV8esy4WksA8b9jX
         4aK2Lh4P5dHxzybhlRTSoiJQv3kUQow/alN27J5UVYrUXqDWDIr6o2bu3gdc3FQTz9Iv
         omjg==
X-Gm-Message-State: AOJu0YyXrtbTLE0JcY0tPpMJw/QOrXCyEw8kRaQMhf3aj1By5ANtqX7o
	TPIYrGVExG5m8wj/bHyPYyJ+QpfX3SdPq+P4E5oT2SlgFkHf1z2a40jLlWmMdmSEPrc/2j1GiNp
	BWKr7F699IkB2xPhFUxgFT7W5Dz13pQwy
X-Gm-Gg: ASbGncur+b0WRKZSGwEm8iYJXyiV/50bW3oOGfkT7wiFaxGqxQGqC0RCm2O8BdCpXO4
	SXOsj+h71oHvkk/RF1YLKFkluHcEAnRRhTLeJDRzrtUfNNs3eCwKq6VXmioJlQQG+VrzroyfrUA
	dXXdOjkNNFJNPGcp7O7QII8b2N6A==
X-Google-Smtp-Source: AGHT+IFPpJfocufkxvqaoI3pvVGMjo8NWg8InSxPhVVrTkHoXQFknt9UN9YlXWShC4Dch1odsfTiuseR4iXgrrk27oc=
X-Received: by 2002:a17:90b:42:b0:2ff:7ad4:77af with SMTP id
 98e67ed59e1d1-306af73c3e2mr11864609a91.20.1744042451924; Mon, 07 Apr 2025
 09:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed009068-754c-428f-8ef3-3b79dc9ec8b3@o1oo11oo.de>
In-Reply-To: <ed009068-754c-428f-8ef3-3b79dc9ec8b3@o1oo11oo.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Apr 2025 12:14:00 -0400
X-Gm-Features: ATxdqUHeXecXFHtQZZt_1JFNw1myi6D0aEXopEq3B1BlwB1z71Wfb5UaE1TE46U
Message-ID: <CAEjxPJ4333bqBye1iV90hopdqwzzXQ4Mn0rBP41qUocBSLPBfQ@mail.gmail.com>
Subject: Re: AVC reclamation strategy questions
To: Lukas Fischer <kernel@o1oo11oo.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 10:54=E2=80=AFAM Lukas Fischer <kernel@o1oo11oo.de> =
wrote:
>
> Hello,
>
> I am currently trying to understand the AVC reclamation strategy.
>
> The code and old discussions and patches I found [1][2] seem to indicate =
that
> this used to be LRU-based, flagging recently used nodes when they were in=
serted
> and accessed, and clearing that during reclamation. The `lru_hint` for
> reclamation is also still there.
>
> To me it seems though, that the `lru_hint` is currently only used to cycl=
e
> through the buckets during reclamation, wrapping around at the end, as th=
is is
> the only time it is changed:
>
> > for (try =3D 0, ecx =3D 0; try < AVC_CACHE_SLOTS; try++) {
> >       hvalue =3D atomic_inc_return(&selinux_avc.avc_cache.lru_hint) &
> >               (AVC_CACHE_SLOTS - 1);
> >       head =3D &selinux_avc.avc_cache.slots[hvalue];
> >       lock =3D &selinux_avc.avc_cache.slots_lock[hvalue];
>
> Since insertion chooses a bucket only depending on the hash value (based =
on
> ssid, tsid and tclass) without considering or touching the `lru_hint`, I =
don't
> see how reclamation is still LRU-based. To me it seems like a more realis=
tic
> description would be that reclamation starts in the bucket least recently
> reclaimed from (one after the one reclamation stopped in last time), whic=
h might
> still hit the most recently inserted items, if the hashing happened to pu=
t them
> into that bucket. This message [3] from last year though states:
>
> > The current logic prunes the least recently used bucket
>
> Which in my understanding only works if "used" means "reclaimed from".
>
> Is this understanding correct or am I missing something? I tried to find
> documentation for this, but the specific functionality like that of the A=
VC
> seems to not be included in the SELinux Notebook or easily available onli=
ne, so
> I turned to the source code and the mailing list archive.

I think you are right. Apologies for mis-stating it in the previous email.
Patches to improve upon it would certainly be considered.

>
> Thanks,
> Lukas
>
> [1]:
> https://lore.kernel.org/selinux/20090212195043.25599.80206.stgit@paris.rd=
u.redhat.com/
> [2]:
> https://lore.kernel.org/selinux/1234534359.24702.22.camel@localhost.local=
domain/
> [3]:
> https://lore.kernel.org/selinux/CAEjxPJ7QqEG+wyQfuPeDu0JqvjRCvbtVzZ6qtzwc=
-YwGz=3DmLjQ@mail.gmail.com/
>
