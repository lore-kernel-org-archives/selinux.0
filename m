Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731BA3B8BDA
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997596; cv=pass; b=DzFSxnYDIJZwEbAFtz7rSfvCT9IR6SmObPZoPKGRpCLp8jbqvp1YodeTEB+Zc3prpJx7mCFuzJafdsQ/AEU/KuPyEmnIKtzf3vpNF+HKqC5wkgaWqrFqBXrj70eakXYxSoaodRg/ThLCTvRGeVrqvFZ7iGHmiDDU/vCbo0z8Ku0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997596; c=relaxed/simple;
	bh=Psz0aRTZsWw7HjsJJxumy7O2zijEjX2uSipxejdrlYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egiwpW+khlqdP7F4hWEk323Z4Uj4w+6wR7OE1cMnZHSDiuTQE30fcdqdy8tuk29/tcR6Ya4v+riWA4zUd64ChOGYBd7BOxL4xEGD+szWRkgENSkB7NqZIz5a2eiQerARb+Od+eTBBf8LP99r6Ze6wWh9QSP9CFuGtbMkakYn5NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnK744Od; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnK744Od"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6acbf97e9a1so2697857eaf.1
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 13:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786997594; cv=none;
        d=google.com; s=arc-20260327;
        b=rYV2Wfawz7YjrJ2sSksNRGnrZ0INbDi2L1BoxlztbPUs8s3hUE1S9smyU3HK6PtoQc
         YIxTEUgOalBraxBPg753iMd23ujjHEnQjJDzKHxP09NKbL0FHgFHBNKeEiYG0mM949o/
         7P8wgtibHBn5yZloFPeXrKhvHZTLy6EtjVqtatu32TR7+Wbt3wa3aeEWJRw4r4rPb81J
         SEnvCB324Nm4RsXUiQLkuH9p+/woyfC9oeYxnX4uinznYL+liHZOsaQb/sfZeeRwMjvN
         20ELRLPkj417mGyuBkgTDPLYKUOFAYDSr8rl3rvIY6WMmequXInGCBEz1UG/GjXBuAkx
         TwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lf/aztCgjFOIyIFT3gj7faVs8EY0CA9RQ3dgm7mRFCU=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=FFzssx02P9CNlJ/yXfTG7z7F+yhLJ2Y7UBH7ysEl8j3SaWsCSOKbhLslH8lh1YYRET
         8VVpoofPw6n0KAITJalbfXQT2tRfzPS6mfHv3wd8+FbRCQblXzoKCDdnDq8nmvHzxMrt
         qQh27ZrI6jALjDrJKbMGozqUFJ6zhKkHLJZLNJj4Wv7Pi4Ian9rg9ujlUuKiKkJ5gr6b
         fneVKPdvFHPojXkH2pyRJ2nwE9PCXj3zJd99Jowt+RDqc/QiLTL/c0t8geVOJAQsj82v
         zt3rquTNdwTbAK+XpdfZQPqFzbjHGwWNPlZC7IlvdllzeRT7v2X0mpGy+i1LKhW5H1eS
         ziuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786997594; x=1787602394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lf/aztCgjFOIyIFT3gj7faVs8EY0CA9RQ3dgm7mRFCU=;
        b=pnK744OdxDib45p8o0oKnkcAOC+Cwe6RgFG9P65QKYRglk6Lb9j0n/QLHLQ+4KUyPr
         wriS7YG/WsN4fGSKG9t5bikgPQL/FkZ9QfR7ZrdyxOB6gBHWofJVgmA/7LCvnKIpQ+Sv
         uUwLcRf1z1Bo8eL44ej3C9C4UPwPbqFvE/VkqRNvsuhOuvpN3D8Qop188XWskwcdTBRX
         7LwY9K2F3Hso/KLVHprM9CaI4kK8WiGrrWmQsyuz2+gxGGz2GvA27lBt43qPHoxQsyvT
         H0lkXQso/5yXyNQzrUCX0L1koxzykWu0uD+X6CdD+UfsJ3klTQa2ao6dkxSAYOovu07R
         0yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786997594; x=1787602394;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lf/aztCgjFOIyIFT3gj7faVs8EY0CA9RQ3dgm7mRFCU=;
        b=Ez4Fgwrm6KD3+TTHuYEY4kjbVmZtFyOTL0XLJrDPOU4g/SZySKFc/8UWv/I2JA4VAe
         SEJ58/E5vUQW0eOEkNqthw3Vi6qoi+qykcQ5uJSrlxYZUu+xfJd5wXkM7NvG59/QV8ca
         TqC1tf0pu+DpWuXUykXXl2eJH569jvSWLKY7uSwpbXNfax6rIDMKa9pFWpWCQBcYPUpI
         WwXne3fxrGhtDh83tdaLUpO9meorrKaOUnSBOJw7CaZxaDT60c4fORFrusUY0NPmgMGj
         kE8qL7B1cRkWELQuVP7tL79hQ7PW4mgibtbaG7OzXTzw/5cP+ef9qP8AWSsZRKUalgp/
         iB9w==
X-Gm-Message-State: AOJu0YxeKRiA+BammPe7shdnYQUuHdb7Y6iqKSLbxUog+PfwHoz4r8En
	7Z6e2RYdV4FZIxg21K9HLh/5RbOCRDvEVuGiE6llJwZE9ywrFcFmTrqqCLGNF069ZaPFc+yS1Yr
	agqY0Td+80AttAB5B3Jtl5RR1XSbjUGs=
X-Gm-Gg: AR+sD10/W3UJcietSiMZRc6l0LRrhEu5MA6B0kRodd/tnqAtcnU1pS2Yx4A7gupuvBR
	4y1axCk+VxxV++fsNkI5TsPzVdGa8P65oWnNBOntFwOiwBlxGkP70gbbQlA5kN1rWjZr+eL7gI3
	NI9+5coCc2jkehMOrPPp3FKh6uhDL67IRomVufP+1J3kNlJmAmo65V2/XSbdd+YFY0syluHZlfQ
	5QP2lwqTOi1vXaCJXimm19bNj+Uh3AsHMSDX6J3C71Rr0wQus3DWGN2NcOtNdRO1mphum5n4zA3
	X0q+Ww05ld/58H/VI6pYarTB+iWiOoEuc4HvGPeOOd5HDJXS6vSSIg==
X-Received: by 2002:a05:6820:1799:b0:6ae:4d93:cdc2 with SMTP id
 006d021491bc7-6b0d5ff7068mr25557985eaf.5.1786997592847; Mon, 17 Aug 2026
 13:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813184113.186092-1-stephen.smalley.work@gmail.com> <CAP+JOzR9S4Gpn-Q1Q3KVDT5o9qPMv1ayjSgBLBJYW2bQUL3b0Q@mail.gmail.com>
In-Reply-To: <CAP+JOzR9S4Gpn-Q1Q3KVDT5o9qPMv1ayjSgBLBJYW2bQUL3b0Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Aug 2026 16:13:01 -0400
X-Gm-Features: AcwNN1Xlq78RmZBCE_D0jcez7GrZI-FNxBdp7iL7e6vWhyKNm36x43hWeDQsuwg
Message-ID: <CAEjxPJ4zPXxsvVYPiKL+4q85my7f06HjD44CShs0waivAwUziw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: treat module data as bytes in the Python bindings
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 10:35=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Thu, Aug 13, 2026 at 2:41=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > semanage_module_install() / semanage_module_install_info() take a
> > (char *data, size_t data_len) pair, and semanage_module_extract()
> > returns (void **mapped_data, size_t *data_len). In both directions
> > the payload is an opaque module blob (.pp / bzip2 / CIL / HLL), not a
> > NUL-terminated C string.
> >
> > On Python 3 the current SWIG bindings get this wrong on both sides:
> >
> > - install()/install_info(): the SWIG default for a bare "char *"
> >   only accepts str objects and UTF-8-encodes them, so a .pp blob
> >   cannot be passed at all, and even for CIL text the separately
> >   supplied data_len is wrong for any non-ASCII content since
> >   Python len(str) counts code points, not UTF-8 bytes.
> >
> > - extract(): %cstring_output_allocate_size turns the mapped buffer
> >   into a str via UTF-8 decoding, which for a binary module either
> >   raises UnicodeDecodeError or (with surrogateescape) yields a str
> >   that cannot be fed straight back into install().
> >
> > Add a (char *module_data, size_t data_len) input typemap that
> > accepts any object exposing the buffer protocol (bytes, bytearray,
> > mmap, ...) as a single argument and derives the length from it, and
> > apply it to the (char *data, size_t data_len) pair of
> > semanage_module_install_info() as well.
> >
> > Replace the extract() output typemap with an explicit multi-argument
> > typemap that returns a bytes object built from the mapped buffer and
> > then unmaps it, so extract() -> install() round-trips.  Drop the
> > now-unused <cstring.i> include.
> >
> > The Python signatures become
> >   semanage_module_install(sh, data, name, ext_lang)
> >   semanage_module_install_info(sh, modinfo, data)
> > There are no in-tree Python callers.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/502
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
