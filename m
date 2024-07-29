Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30F384D34
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280857; cv=none; b=PxzBUwkq7uVKRqh4TF9cgiAbYcAsE4MNmJtD1g13XBqwzAJUFIohyRZzRERNiTXo4QoAFct3r0sdSbfPjwHiCc0SRE9WY2OUG3buIumJ0eftFHS3FJMyQambpJEOgrq7X3J4qyJ/LAhqV+5XhToiN9Uieqws/e9nktp8lH5occ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280857; c=relaxed/simple;
	bh=jAVgo8OiUztzFeqSZNYshoc5u7ntyZ22yuZOy32KAyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epl304HvhDbAOuOF9k0d/mzgJaEAoTzT/G8W8/yuwPyC6WcgAuHFpLXxMA1CVNQNnl5Hjh6OYAaDZVSGij0GVsXpheok8DsTTNJxJXFJiD5g53zC0RzpJoVqch0Nmky/u5viVH36HziQQH/snZcS7KroPL9rHL7agDHgN5NwEes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+ROzlAY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+ROzlAY"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so2276192a91.0
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722280855; x=1722885655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAVgo8OiUztzFeqSZNYshoc5u7ntyZ22yuZOy32KAyM=;
        b=A+ROzlAYQPYKQ/AyRAgV77L+bhAu0JuegfIt5k0+mS5QSWLOyXFoyW2KnQzJBU+UEf
         GUaK8HbC9aSWdcM/JvOgFMpBF2QvYOzhl9H3uv6ax+JYL7A7uVDM6lp8ZnUs3ueeEvvN
         XnVJpsYTENdHTVT60A+hezrDlA5vJIN9b5DbnYvgiwIgvtEecjmLiAoNWosj/hf8uWEp
         fONcrOXSY+wjGMvT6GmAmspTs3aIKQKFYxThoLehlgBTYOAR4UYWrZP+WzHExfZlpVeV
         BootR2sdsj3MaK7J+3EK4DIzoxTXCgXbivLN1QA1O2RKiTkzP4aj9y9Gn1jPBl22lOCy
         /NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722280855; x=1722885655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAVgo8OiUztzFeqSZNYshoc5u7ntyZ22yuZOy32KAyM=;
        b=nXw5wZmxDY2oNANlF/8Jcbc7jNsXmJkBjvTmqYwWJr6Ug5Pfoyt+17ZwsLolDBsIoD
         qoCcTIDmj/qLY0L++AVW7bEulWmKdm06cjOFPyCEM11vYJAKrT7GbzWpVW6yNb51RZHW
         E6pzjGO98ulBXEJ1QRlApirYWll8qvJYABJR880Al/miUwyeYNLMouXqc9S5I1IUMwPW
         Qr1rrPSTdkEfuP+sqU6CpNJ8+tAgDvxHbx5VBzsztoWA1rsVAkU9RTxydyPedEzLoNg2
         UnOKUiSVoLn9UzpomVKq7ydstfsHtiGyiHAoj0gmY0FiKrMSHOD+s4WhCaaO5e0/dMez
         B7gw==
X-Gm-Message-State: AOJu0YygsI5d5JBWozgAaO9yremMgRLPwX4q58kfWrWdCiwl6QRT4/xF
	xUXX95R9mkHhLpQYutIYo6Oyxp26rnIOX15XE+O45eh0sp/sB98CSq1NbuTkSYOtDbBZXPZWSas
	XYfar8Nn8W4f49QclCQl7+EyHplez+A==
X-Google-Smtp-Source: AGHT+IG2CRzI/CVNCPqMusyofGGM993TJN/YMwdghZ17tgzZEzawz9CTGaMMG3rtroF5VCRPbfmEpYS4CC5Fq1sTaaM=
X-Received: by 2002:a17:90b:349:b0:2ca:2c4b:476 with SMTP id
 98e67ed59e1d1-2cf7e1c6046mr7564717a91.10.1722280855120; Mon, 29 Jul 2024
 12:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708165032.86647-1-jwcart2@gmail.com> <CAEjxPJ70EufOsd4O4E-Sc+KRGdv1Nhbac4GbkewAejp2GrMWBQ@mail.gmail.com>
 <CAEjxPJ5re4XGfN6hny1eir0oTnw4YhNDg=EiWo5KZbQsZ8H5hw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5re4XGfN6hny1eir0oTnw4YhNDg=EiWo5KZbQsZ8H5hw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jul 2024 15:20:43 -0400
Message-ID: <CAEjxPJ4v2fwZF1ZQX5BYAPyFdc3WhpS+9RrJ5JyoZG4hP9+Hkw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Check the right bits of an ibpkeycon rule
 subnet prefix
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:38=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 29, 2024 at 11:28=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Jul 8, 2024 at 12:50=E2=80=AFPM James Carter <jwcart2@gmail.com=
> wrote:
> > >
> > > The lower 64 bits of the subnet prefix for an ibpkeycon rule should
> > > all be 0's. Unfortunately the check uses the s6_addr macro which refe=
rs
> > > to the 16 entry array of 8-bit values in the union and does not refer
> > > to the correct bits.
> > >
> > > Use the s6_addr32 macro instead which refers to the 4 entry array of
> > > 32-bit values in the union and refers to the lower 64 bits.
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> One caveat here is that I believe this breaks building checkpolicy on
> macOS because s6_addr32 is non-portable.
> But it looks like a previous commit re-introduced the usage of
> s6_addr32 (we had gotten rid of them earlier to avoid
> needing ifdefs for macOS).

Applied. We may need to revisit though at some point for macOS.
