Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837491D5CDD
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933546; cv=none; b=uRvNWPhpXAwNVEdGr+TkR33IgeO0rwMZiif2V02PKqCFIsD8Aunh9euv5/mgYNs+UfEHXRBwVKgxJcqw541hkcDp5iwaHC/rU3ZQN1lzPahVNoLxDQ7/3QmwTyE+lepYCvcyPKjPWCGpjp9QOEFAIWlNlMNJSpMHuqKhBk1rsSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933546; c=relaxed/simple;
	bh=x8+I5qAyUOO5t9kF3+Pe8JETjoa3HTW5/j4+z7zPHYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tinYZqMZeKWT41QLTLdKvqgfH9HiPqdGTii43DjKR4w8+LfqPnXNODew5sjKD9N7lTc+Oi6mvOG0VKZGuUM/MUWKujI8t6KjbzHBSYPqL9PGTJCQieaZKsxz8p6a1MKM8j9o6dk1GygqiDqEfj4XPW7IC4gtHA6GOfLWeQA23CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay2VlwVZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay2VlwVZ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6c70220f7so228899785a.0
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 08:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733933543; x=1734538343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guqRkONuADPwFf27Ro22bfpU4KQ80TRbMmtVd7H2ZYo=;
        b=ay2VlwVZSEa3cKNgZy0XoGn6UcreVWVwWS/zjrvkTv9oPeSHKY48+ya1+o7DQ+tJZj
         HjsRGJALSfDzPyFnUET6o/vpLvgFhZkPEQZ67dpZnIft1FWmvQVM3Q8NIc/45HGKo/Cs
         ewjAoiagK6VKJbKu5+95a1YxvUKk8RePlDh4PcTo14LAp5PqxnWly98Q9l2EoN8bDJCR
         stxS2XCu+u3npXJDg9+9l0eOGFPr3wHavtWEqjmqU3HluiY8u2TugaMUFn/95LsefSPo
         0qSYG5xhstvxF3EoJ5nhLEYpJmSOkcADyBi/2zQXAKJslCNMlzDVeKebTBg/hhIYuLJS
         jJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933543; x=1734538343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guqRkONuADPwFf27Ro22bfpU4KQ80TRbMmtVd7H2ZYo=;
        b=WIABW0gUk1v/KbJEr7oOL0BA81mQqB/huxrwrdQcJKuuqTI20GarKTsZIz4TpF/ngn
         dB1oXUdqxWiVgaYrqiNl5SPwWNJFB+iI8VLiz4ZXNpD9AgcHs/5jswHO1PYIfUDl20yt
         JMOEFsBfSSJTUgU4XAVMyYhEOs9FVTjAFNg7RM8X9ZRwK7pvWPX5UsfjnkOKGhGXmTco
         PVh4Px780wNfAxmungIutal6jUq7Nm2vpvwWie/J4JUnD2jSF0WF94NzepBlPLWNaaw+
         AYypJDoDZnijEF6umyU5NqhJrf5AkT50lGNi9vIMPQWIqjEIwQF1uKpxJFgEXHRihbGf
         rEsw==
X-Forwarded-Encrypted: i=1; AJvYcCVXYqtzX0i8RwmkElTSZDFsNrn3v1zEl4PqGAkSG4xJF+7ztH+WjT3o9nai42Ry3qzeElRk7Xzb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6+GmUS/6u51/dz2dyQhG1YqIn5TQAJ448lClv4xZMhdaiwVSz
	AX8+yOlehXaY81FZoyEGnUvN5RDztRc0w2iiZmQTsdEdlewSCs3N3dCqFrGQiR5K+3jVd0RGi1D
	OdNTelbTNTr0uqGsAGr1j5044TEM=
X-Gm-Gg: ASbGncsIoyBfJyoTHHQs00vYCU3rV1j0TkbVAa/Ug2hu/JCdWpjiUwLvasyJrdgtcRG
	WdKkOMoMZhlTbAqnn0QLhtkNkvd8WnbzgaSQ=
X-Google-Smtp-Source: AGHT+IF2x/YqPRdM3G1AZb/3dJNgVeEb++xBbjdc/6IbwbIuErWjVv0fp7dlTMtkaO7CuIlUXItozFCTKLYjx8dNHNs=
X-Received: by 2002:a05:620a:262a:b0:7b6:7970:6522 with SMTP id
 af79cd13be357-7b6eb50648cmr572173685a.40.1733933543270; Wed, 11 Dec 2024
 08:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6eFO6BNeGko90bsq8CuDba9eO+qdDoF+7zfyAUHEDpH9g@mail.gmail.com>
 <CAJ2a_DcWjVFkAysPtuswuQ_7BExcBHrrS_783CK7WoL_VugVCA@mail.gmail.com> <CAH9xa6c=jKj-0pwCT9sx-t25ZkN_g6nUmi85KYd-wRSTt5SVEA@mail.gmail.com>
In-Reply-To: <CAH9xa6c=jKj-0pwCT9sx-t25ZkN_g6nUmi85KYd-wRSTt5SVEA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 11 Dec 2024 11:12:11 -0500
Message-ID: <CAP+JOzT2YFKcvga5dM3XoRseGSVKs2MZ2ZijPZ8b4N0vekHF+w@mail.gmail.com>
Subject: Re: Incompatible file_contexts precedence in 3.8-rc1
To: Takaya Saeki <takayas@chromium.org>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org, tweek@google.com, nnk@google.com, jeffv@google.com, 
	Junichi Uekawa <uekawa@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 4:10=E2=80=AFAM Takaya Saeki <takayas@chromium.org>=
 wrote:
>
> > Thanks for testing and reporting.
>
> Thank you for investigating this as well.
>
> > > Before 3.8-rc1, when multiple rules matched a path, the last matching=
 rule in
> > > the file_contexts file was applied. However, in 3.8-rc1, the rule pre=
cedence
> > > has changed, and the chosen rule is no longer easily predictable. I t=
hink we
> > > should keep the older version's precedence rule to avoid breaking exi=
sting
> > > rules.
> > >
> > > This is a real-world example from Android:
> > >
> > > > /system(/.*)?              u:object_r:system_file:s0
> > > > /(vendor|system/vendor)(/.*)?  u:object_r:vendor_file:s0
> > >
> > > Before 3.8-rc1, the second rule was applied to /system/vendor because=
 it was
> > > the last matching rule.  However, with 3.8-rc1, the first rule is app=
lied
> > > instead. In 3.8-rc1, the rules appear to be sorted by decreasing rege=
x string
> > > length, leading to this incompatible behavior.
> >
> > I can reproduce the behavior.
> > The precedence logic was based on the common and (in my point of view)
> > standard SELinux file context order:
> >     Order regular expressions based on the length of their prefix stem
> > (non-regex characters).
>
> I double-checked the behavior of 3.5, but the precedence rule was not bas=
ed on
> this; My previous explanation was a bit simplified. To be precise, it fir=
st
> looked for literal rules that exactly matched the path, then applied the =
last
> matching regular expression rule based on the order in the file.
>
> > The precedence logic was based on the common and (in my point of view)
> > standard SELinux file context order:
> >     Order regular expressions based on the length of their prefix stem
> > (non-regex characters).
> > See support/fc_sort.py in the Reference and Fedora Policy,
>
> If I understand correctly, this means the libselinux behavior was changed=
 from
> using line order (and exact matches) to this new stem-based behavior, ali=
gning
> with Fedora's policy order? This seems like a breaking change for non-Fed=
ora
> libselinux users.
>
> For example, this change breaks the Android SELinux policy, which relied =
on the
> previous line order and exact match behavior. Now, many files are not lab=
eled
> as expected.
>

We can't break Android, so I think we will have to revert this patch for no=
w.
Jim
