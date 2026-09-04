Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EBA36F434
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534745; cv=pass; b=CPSqzHe6gbU/hw3MO/7p4vg0rKhTvYeizHJtk2/d4TUIv0QgCQCT6UfVoIiDrMdkBWWVWUJaMQC116W/+UcoNw/yFGr8y3h5icIF0X4jrdjACzgMj7IkqgPOUo5OD4VfbUXeYsx76ufKtRSLIDHR9auD3Y7cz8pCxnuxpalGQRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534745; c=relaxed/simple;
	bh=K536AGw37HU+LsVlcHfRf3fogSMf3B5drq9ToqDXS5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljGMKMQ3uPTCRAwS5ALp2Gg7SwJllu8SCt7ivVWr77uPgUZqYrlWEVwGMQNEU3bpSlsLGjBxB9NS7pxYGgzqOTxkbgXt1a/ncI1yitTnYUYXf3KNp3UrDtW6b31nk/r0PWru2ua4mHZUNwfGVdEhRpXdvr0v+LqBKC+zcJJifkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNtMEBOK; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNtMEBOK"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-46ac530ba95so768167fac.0
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 08:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788534742; cv=none;
        d=google.com; s=arc-20260327;
        b=OxEMPu7TiA7AyurDz2380j2VEaEgUQsTDY3Mlyc3KbYlrIkOgUHXt3Qcokcr75gK9C
         tJXQ5o/IgIMo06sm+QaLZ7F6uZL8e7bpHPW9b6PPBKk9pZSWGG7/zGNO8thgzhdZBXND
         lewaPgVG83n5GU5lAZ/4xAM4lat3/QYOMAQAsdQQQ984jl22okOgEm6vKp3pCokARZD5
         EepTwAgeYLPa4mvi9SH9gV8RJtHb4/5lJwoba5mNoy2DUbhk19qhZwUVUkbKSQalawmq
         JDPVZKYbLiXhSRXHHfi4jPbmUr+k7szr1ar0f2jl7CpLdto5VMAt34okNeaqPkQdKFbh
         NJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K536AGw37HU+LsVlcHfRf3fogSMf3B5drq9ToqDXS5s=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=sAtGTJm3KHT8EhOGg6DwDWv5E8oU/SxWb+6bXJtXiyoXpqZAdWi7S261rVJvGDGaZg
         jKBZRPuFLrhzTLUxitu5zI+8SWVNOdxcsg3mMQVhn24u9BpKc+gRZQhYAaqAi1iTum09
         6vfBBsMZCwdcLWsZJScIXFAz+bT6mEURhU9xXhu3lcA5ET+Ru4yUC7d1xZuUyOnbwUIx
         pYrKtihl+dbyAXFgz6VOJztKC7jtPI5EYXPm4062nsNoBoHIVmdMq4HGufG62iO2RipP
         9eQeO1p/XDbZOeBWR0T3Yq8xp7c+2e3HVarOKs9mkFp3Bw9Uz/oQasJKMlrrLcjq+leI
         Jqvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788534742; x=1789139542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K536AGw37HU+LsVlcHfRf3fogSMf3B5drq9ToqDXS5s=;
        b=PNtMEBOKTxZMF2fPljrD1OqUspwjCt7KbNw6yPpUE1WkZIhfOhIgamfs5gko0oCS+Y
         dOQAlld7Z06UffzxXVGYXGviJCEDHwNhQs2yKuqsHXmECQXglYuR76DmEnmxaEPLusIu
         b/DtL8P/D9Fx1qd55YwnCckMoafBhQZtA+YGTby2QeNUBOKYL/IlPMv+iOwR+SiMRuOl
         dOLxWkIz5fMKqa3M5LPqoV/b0+C1wMVPN6inIEIQk4q1da+n/cHXzofcVoNtGRZvCv/n
         iodhgcRJ1e55KM3pKsz3vfnYixcV/TzmidQVNqfJRNEWdSiABrktLQ5NS13QuctqG+zC
         /7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534742; x=1789139542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K536AGw37HU+LsVlcHfRf3fogSMf3B5drq9ToqDXS5s=;
        b=Ic+Fb3RVISFAV423FT+u38/J5TVJWKFSDOWSPI9x9VmKfyxLhWXUM1ihdWdQKUqgsF
         2pzs3jszivdj+kO4EOJtwwSwnmyTmc4PHeXA/pMyIgV0f5e9NLeYaCrMwtPBum0BatEr
         nv3W8QTUTHGk6vKv0HEbSmA2G4kN8LcHUvgagNoBThUaCaBA8jgUR+YCBQ8xcPMukos4
         fOWUFz1esEKSTjkdbhsgZXHPj+QHf8WNNXavNICCJlU6MCkJVAdR4yiDAPB9Bb8bnSgj
         8mlym5xznGwK563hKu6hWw6LWWVs7OiSfNo/OdZ3WD8WilyovaGzfNOAPjYyRWGFlrPH
         tbTg==
X-Gm-Message-State: AFuF++mbuEorqhDMShWEele3PiHt3Gc6Cvg5Gr2t9P3XJ6+dY5+pTijG
	/dw8o4Xjr08w/mFbVbX2EBwXYNcscBRjJcGvW4xQfXJC6uAEgFwgU+lFwW3ICqlgC6x0Re2TMzR
	WP8Me67zteOkFw99tpx+bKucSFVnOqB2PNQ==
X-Gm-Gg: AYBFou16hsvST0FbD4ZKAo6Zss1he4s4wVvg2PDRjirffb3qfrfAqBa5bcXbhTQws0L
	N5VmKD1qDrrbhCvfAl5P68F8adk1of9pjrujd8ATdmBuCS4vL9GqyyT/AN135DLILd/h7+tANfm
	gAV1RiZG993J5Q7rfj4kjOk7y1oQ5uCgyJ4vPY2AD1R/1yCPfunkGAjgqndvV08473gW2slziDH
	y3nIldEdWqJNhUPD0sA/XYWACVCVkN9FC8gqZWKWZGTcLaASVR1MeIQkyj2Me8Xdk8W0Zgzdu7t
	fjjtZwvyVdANtHpVGpXfdU+rDHIzPId1qG6Z26rGvs0L
X-Received: by 2002:a05:6871:73a9:b0:466:d80c:8b75 with SMTP id
 586e51a60fabf-475534f576bmr6266315fac.14.1788534742136; Fri, 04 Sep 2026
 08:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903201323.138212-1-jwcart2@gmail.com> <CAEjxPJ59X1fEk=0bgRQvXbUg4=i65-ZbpXMczQwUuGAiqf0SGA@mail.gmail.com>
In-Reply-To: <CAEjxPJ59X1fEk=0bgRQvXbUg4=i65-ZbpXMczQwUuGAiqf0SGA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 11:12:10 -0400
X-Gm-Features: AcwNN1UEeSrINblpar6CLxZWTBkOpXEvgQ9Szwf9MKsQS7J8iBZwZI1kI7QjrZY
Message-ID: <CAEjxPJ7HM9wmyyZ9J1VVK9vJyVfwaFhOahk6crEQEsdF-MLGYQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Improve validation of scopes
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:18=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 3, 2026 at 4:13=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > The validation of scopes can be improved in several ways.
> >
> > For non-kernel policies and excluding the commons scope table, every
> > key found in a symbol table should also be in the correspondeing
> > scope table and vice versa. To validate this, verify that symbol and
> > scope tables with the same flavor have the same number of elements
> > and then check that each key found in a scope table can also be found
> > in the matching symbol table. The function scope_read() in policydb.c
> > also checks that scope keys can be found in the symbol tables, so
> > remove that check to consolidate validation.
> >
> > The commons scope table is always be empty for all policies, so fail
> > validation if it is not.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
