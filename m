Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC235965
	for <selinux@vger.kernel.org>; Mon, 25 Aug 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138142; cv=none; b=G/LZAeIQxnQcoSuhqium2GBRiA9u0CyuhaLKhYMFc0Y5HvO79vMDn7W3z+CDTVxk0sRA6cQ5PZ9lAJyNSoGh2G7IQ93RKSr7xI+BWo3i4IpIHIisMR24UeOJi4Lfp07BB3ACiPMU/XdDU1IyTjT05SCw7dzuYa25HASDcZPgjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138142; c=relaxed/simple;
	bh=cGAwS+u+5tSMWjaESG7UG2EyF4eZ33+ipaFxJ1uXn0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6UBYCUtYvQClqTyEf4TqcvelbR0e9BzppYsLP73fH9slWTdPa1m2cfTwnzHoOBLBVs83RqoHbu/dnSg/i9PpqVa+9WsxBmFH+/tlkYuDMCtG/3bjlMRKQKPPBWjdJubv9WzJGVPdCcyzouAJJDwc+BXF0N1Xy/d0IILj9xTfcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ4eY5Op; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ4eY5Op"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-89018e97232so1505362241.0
        for <selinux@vger.kernel.org>; Mon, 25 Aug 2025 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756138139; x=1756742939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO5l3AOCdClqohQVsWwFvd+muidfX3hSPlnoFMCUV0o=;
        b=lQ4eY5Op2k8BYTNohOJRJVHlPKTfUT3HEq+W5uj3QRDgSLV20cRU946XRyx3oeGZHd
         p5wAyEuAUrsitu/bS36oQjSditmXNUr3QKOUtsSqqBdYZqUvWTJcOlvJbFRjFJi2CBMk
         dgeln9Jvu4dm5nHi7Ec+95MGt7zSAt5c9/9sYO+KX5EDKrkhXThoJSlpNpH4mvCASlTP
         6N0UB0Uvrzj8v4x/LH2bICdaWdLfcNEIVpUUROnK2FUeNCSP3QpxLdGjRFF8xcIGf5+r
         mb0qZzAcvoBGHSJR6VdlsqCBFi700yqhHuubp31mbEkuHQewUf4xVECDOW/b4NwPuR4I
         IV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138139; x=1756742939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JO5l3AOCdClqohQVsWwFvd+muidfX3hSPlnoFMCUV0o=;
        b=bunEzjpExp2/miZx7X52JQeJlrB/nQUEZutNrb85SOS4YNvxbRnpuNS6XfYR9Sfv+I
         xKPyfaEMOYvFPkVxXpWeex/rIWuJGp8k4StPYlOxmHASp0ssHZLugnlaKIsbnqbcvDQm
         hHIc1bu3kUXDEm0dbzU6BR22StH/lvofRS0G1ryFf+XoRnz9dTt4OvP+wWoQZNZlJw4n
         vasQBpH39etTghjds8hY7MKFc5rMKirye6706nXnQnRnC5+oJ2Qkv3WMBPlJtKbPDCoa
         ZW9HpzYWr2aw66U0pQnH6x38HQL50TPcH+IkErPYKtGlxVe+7PQaX4gmyzfEAcycs38H
         svCg==
X-Gm-Message-State: AOJu0Yxcr/kh3KKZq9Wbxl3p10mcPjAilsiVlw9rXOP8M8Fsa/VULBf3
	G/urFBNXxAfIa/bT26yeShJZmTObatTDKPjyunoMV39tOYj4zv7ygx9O7xa2mMjABQYkIYX9gae
	RVNbKh9E0A7sg5m6jK/u1shqkUho0HjY3RXfW
X-Gm-Gg: ASbGncuBtH64DpccBCKcP6RHYXkBY908KonZvFAoQ5Y+etxtytdIyJ+VMkQDNmk6HQm
	iwRs9ScqalR8UampbMvUBmroF6zBmuWuLrH1p4mNFOnL3IDbS2UorOj9cXCHWYhE1kDNyBjbGvU
	/iKuaup4JMPijiA6FxeahsdKbOOcTvuY6JuUdCkyu+AGk3tJe/H71Vz2mMRLIK+f61t4rDMgSm1
	wC+
X-Google-Smtp-Source: AGHT+IHMHpmw3oNwfGFeOw04XZ/f/HMSEqH1zWrGF2Rss33aZgjb/MrssUDMAXBGQsgK88ABpHNO1eLUC3qVS0T3mXc=
X-Received: by 2002:a05:6102:1489:b0:4bb:eb4a:f9ec with SMTP id
 ada2fe7eead31-51d0ecbbc75mr3864766137.16.1756138138635; Mon, 25 Aug 2025
 09:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sehiyuh3.fsf@defensec.nl>
In-Reply-To: <87sehiyuh3.fsf@defensec.nl>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 25 Aug 2025 12:08:47 -0400
X-Gm-Features: Ac12FXx2osJzj-qR_Z7BPkJ6NOVCGlN3HzMKAj3-EPmdRWWkcBFCPqND2lR_b4o
Message-ID: <CAP+JOzR8YGou8Y+GsLfeR4aG3KB+arNW5X-_cr+Xw24vQnUU6w@mail.gmail.com>
Subject: Re: fpp cil-policy
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 10:37=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
> Hi
>
> Someone on IRC asked whether there is a project that can convert
> refpolicy to valid CIL and leverages CIL features such as macros,
> blockabstracts, class maps and permissions etc.
>
> It reminded me of FPP. I could not find the code anywhere. Is it still
> available and if so, where? Also wondering what happened to that
> project. Were there any blockers?
>

I have not done anything with FPP in a long time.
You can see this email for a posting to the list back in 2011.
https://lore.kernel.org/selinux/1299608758.24687.19.camel@moss-lions.epoch.=
ncsc.mil/

A lot of the code lives on in selpoltools
https://github.com/jwcart2/selpoltools
but not the conversion to CIL.

There is a Refpolicy linter in selpoltools and a program to convert to
a new language that I was working on called smpl (SELinux Improved
Policy Language) which I created specifically to be automatically
generated from the Refpolicy. [I think I had to resort to just
identifying certain problems and hard-coding the output.]
There didn't seem to be a lot of interest in smpl and I never finished
the smpl to CIL part.

FPP required a number of patches to Refpolicy for it to work.
It could not handle generic m4 defines (like "basic_ubac_condtions" in
the constraints file or "can_exec" in misc_patterns.spt)
It could not handle defines in an ifdef
It could not handle labeled booleans where a boolean name is concated
with a path.
It could not handle set expressions in an interface ("file_type - $1")
It could not handle an else block for an optional (yes, this occurs
once or twice)
It could not handle undeclared types in an interface (usually an
interface that is not used and would be removed anyway because of the
unfulfilled require block)

While FPP did retain the interfaces, it did not create blocks or use
class maps or anything like that.

Jim

> Thanks
>
> --
> gpg --locate-keys dominick.grift@defensec.nl (wkd)
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
> Mastodon: @kcinimod@defensec.nl
