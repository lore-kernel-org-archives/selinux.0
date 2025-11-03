Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BF3168E7
	for <selinux@vger.kernel.org>; Mon,  3 Nov 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187488; cv=none; b=siy1rNUc7LCXIaT2+1Ev4+Jeima/ZKmruAMHSXHvTko6CKP0eiVFa4oIarJarGj8d0vF46JRtY77h5aaxnAdH+8y7y0d6UQDFWPx+wgv+nWMzXTHxsUp7lQTJONcbZlY3/9eIy+GEClS+HYJ0fZx2jBdbIu3ScX7aetEnD+eAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187488; c=relaxed/simple;
	bh=id3Mt2FbuGQq0l7enrfRyxzF8TdAC4J73ChPqHXFOMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nk4MUxzWHsjlY93C72ZjEWmdMd0zXbjk2XgFIRnClPR9gvjT7BOwrgwtKNC+kxFD+uR+pvoeOELyydV4bHdvceqEYkBZFyokm3zwZm1xVEOwUPIlZNECRDkvHSSZvRY0NXI/0IfuymPpmkAeiqdNCHhorn09U8k+3o16Ywt4UAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA8EidNd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA8EidNd"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-592ff1d80feso3614312e87.2
        for <selinux@vger.kernel.org>; Mon, 03 Nov 2025 08:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187484; x=1762792284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id3Mt2FbuGQq0l7enrfRyxzF8TdAC4J73ChPqHXFOMA=;
        b=jA8EidNdCa+F8ISPZ9n0qWjMQ1ApvT8592UcSr/WOwr84CfvPJPKQ9gz86k/0cNflN
         3o8vhDLnDUf8eZzgzgy37ymuYCv6PjCvq2K33EjG+DnYJVeaKI10E2vHZl+TyWwMKQ+j
         vooK/YMKTWCIVnxt9SX9PXSOCx5O1Ml38pRSMZ2gXNUVwIRXiDTt/bprWopSUwn7xOIG
         4u8GK2O1IGH2JXVxupWuoW9ECnsB18mVwJZTSNFPOayF1fbcsNPzc234B68xXtbNfetW
         wUSWR737+K9srb7GLMSQqh49Ba9X7Rb3YHNuzIjFYYFmb7Q/XLVhEod7yzIV/ARVk6FK
         zEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187484; x=1762792284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=id3Mt2FbuGQq0l7enrfRyxzF8TdAC4J73ChPqHXFOMA=;
        b=HFregi/VXz6h63KO+Dx4PESBUaP8sBBXee6DHYDOxaOM4Iatkvstc+53NQDk3LsV+P
         Jlce0+pPKI7NCD8KVrTt3Y5VRYmx7S/sujNCcDxomN1fJn94gc43d2GxBUZ3S55BjU4B
         sV+HbE5afGXT6Ixx5U9772p2SyooCjfI55jiQvrZlPiKKN1OZ55gshk5S5yTJOlmG3A/
         YOTetDMv9puD781SJ2OOr1eS2yZ07n+G0KQIMmOx7WByaqt4W1sjGE5SH4KUznJex0wA
         bAADZp1E6xhpJbvJBE7Y32zxs/ofDO4/I4A7ocUCfLD6TPu3Z91vpBcrqmrXUDazpFSL
         dlog==
X-Forwarded-Encrypted: i=1; AJvYcCVM9mQANWUP56nF54QiyE7oesIHJK1mYqgSkmHLUosqeKTKvqC9KB+3eRB4ad0rE3iSXJJcVtxN@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSsSd2m4X9jfvf6ecksBN25AWHHInIcptyowrvj9g2zXFjNF4
	q3YJ+mjbA8Fno2A5U58+tT9wCGCGEXpPQD8BR8xEHNB1iKhgZvyjOmIrz7Psm7KgBL+fCexKJPt
	LdHkf+2gnnebeetzSEcIi8eaI5tpCF6o=
X-Gm-Gg: ASbGncvwaHpyxfsOVV7Iamy2iTW1q6bVZzUDCkLZc26CfBE3sQqY2I88pL0cZif+I7r
	BqBMu28PBBicUrPnbgQaMjktI+Ucuz3Mr6r5UNDegfiw+u+CK3Zl4Q5pmYviKOPZPqiKAW11VlT
	TfIHfoo93ejsguogdsaTE62YvbSdHc4V4Jw6Pi/K2S3G1Oke9PKszekazMFfokxHKaWr7XelySS
	NbFY9quQ1X1QU5hV5yHMj7zNdcq58DpRbzfUjBFLIJSOj0nsV+L6SeuQJEsi9pgapjRnw==
X-Google-Smtp-Source: AGHT+IGGjdfLABnJOq384CpiOclx+SVShb3YpYY2Rz9uJbdaXWjJZBpYE8Hs8CdWzDKANeqlcZqq5LJee91dniHTQRc=
X-Received: by 2002:a05:6512:61b1:b0:591:c2f8:9a5e with SMTP id
 2adb3069b0e04-5941d549a65mr3911650e87.48.1762187482580; Mon, 03 Nov 2025
 08:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9bf87e7a-17e7-4c74-bafd-885752dfe045@linux.microsoft.com>
 <CAEjxPJ5SX-9OyMPQF9B9wr4ixdaG9jxSmG5R7Ozev+KVztWoWg@mail.gmail.com> <CAHC9VhQjEo57SMp49A+iXMUiyEXkpMUOnHkSJ3cspTHGUFXdUA@mail.gmail.com>
In-Reply-To: <CAHC9VhQjEo57SMp49A+iXMUiyEXkpMUOnHkSJ3cspTHGUFXdUA@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 3 Nov 2025 10:31:11 -0600
X-Gm-Features: AWmQ_bkgvK9Vj_ojsTroKe9beEUg4gWJdgHSzDr5r_cYTnyqz-3GAdSqjw9iEYA
Message-ID: <CAFftDdr58R+9qGd8MYxyyxzY0wCRo7vSDKLMX78sm9dc7QMUUg@mail.gmail.com>
Subject: Re: SELinux documentation repo licensing
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 11:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Oct 30, 2025 at 9:02=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Oct 29, 2025 at 5:19=E2=80=AFPM Daniel Burgener
> > <dburgener@linux.microsoft.com> wrote:
> > >
> > > Finally, Creative Commons seems like a fairly standard option. Howeve=
r,
> > > we have decisions to make, since we can specify different CC variants=
.
> > > Something like CC-BY gets us a more permissive MIT/BSD style license,
> > > CC-BY-SA would be similar to the GNU FDL (but of course mutually
> > > incompatible).
> > >
> > > My initial preference personally is for the CC-BY, but I'm happy with
> > > whatever license the community chooses.
> >
> > I am fine with CC-BY.
>
> Same here.

FWIW, same.

>
> --
> paul-moore.com
>
