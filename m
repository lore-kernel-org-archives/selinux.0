Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0D390C82
	for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787715; cv=pass; b=shefb5MqewgOLZAffGhRkMtxLGHdh5VFOaDY6/4fiZ9/DFL88zFyQqdvb7HF8Q5QCRFRvNLK61OjwXaG85tkgh5u/lrHciASy+cVZg6Zs0i9IVu5KQnJjvFvh0ADpby85QbqkDFrJb5OHvK3AkznqbNB9jEtXxBHYfslwwdzjyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787715; c=relaxed/simple;
	bh=j3i5g4rVItTiyArBRZJih30Re1T3Q03DmVsRwkbHCRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWeH9zG7Tn5Q7rMSFUuzCEVYFPkm8qP5aXwqFzCWb4JBtHDTQKjQUTOiQpyPgWYF3B3F18miK4NsLjX7I9Q4C4PtoY/fvaRr+0cYkpbE3Y/WeN81vxRgpESoyFntWZ+i8Oj68qS2YHthBspfb1GmCGzZl+t8XW+ywrZ7NZ3jNv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ta3XAP1i; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ta3XAP1i"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5091ed02c54so131151cf.1
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 15:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773787713; cv=none;
        d=google.com; s=arc-20240605;
        b=OJG2XnObGANZ/hzskUZsFZcH6B3CFSRc1opLrb6jGdWt0ebM0py/eTXKJ2ULr1cIki
         8lA09VurBkGaFPtv05vV2WGGnASnbr0KJPPACSVwynU0HYHOKVn13fa6/QNgxNMSPfM0
         ZuYUHAlhDbI5D65Ck/LLRApxd0+scukutW329lq+RYWQ/Id/1DOE+ncLXxoj0Jx6GNI1
         uuEG9F4eacYkBInQvL0ox2lS4CYTiOLh+FpUrD0GbKL1eh2F2aY6e/pqDIU+7kXEIoq2
         tWA34Mro2tY+kNRj5JR/vob/3sYhSillLziw0GPxlDR+3oy+V8VleHR0EPf6dGlZMgnv
         4NNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qj0EK2jXR9SGpqlW9u17Lt+6E/7lPN0qKJgj7KHpbjM=;
        fh=EAauZRWJxIar+jfH9lVLlSgawo0y/y2iG68eUz6wxGw=;
        b=a/1azSNRD3TRWQxolXrXcDWzUsoxAO6C9sA7onlzjTLduLGdydqzXUgRAt3M1MXxKx
         8HGWdHO4K/Xp008JYsr+I4x0toOCZ+1p6rIiKTb7JfchD987vyscNHKzcPOmOKSYEtjC
         yMH6qKKoWIM9v8deWNUYq8/sF/eoHdlTNVC+3+B6cARQQLYwuw5d6sCL157QsnaCLE0j
         GQe5GA0KdCLVOj5ITthmxeH5/SIoholjbR+j8UcTagpJbt5Hs1P7JogFQJQ6Gb0LDdz8
         1YjqRTN9dVlHtMD2glpWYc0uwKv18/Xcx32EVII89t/nNZLaBeCsMBSq1Lg4NZf8kRMm
         /JRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773787713; x=1774392513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj0EK2jXR9SGpqlW9u17Lt+6E/7lPN0qKJgj7KHpbjM=;
        b=ta3XAP1iChFhc2QcA6po84Yz/pOHfQnIwHMBjC21FqIQY8ImsowIZH8Rg4OTueQva9
         7Jb2hB3D+ZhB8+tVRCBn1HxKi2Zt6ZMnoGIJq7rd1Yy/MuGt+TUTN7bV6flyxyp1V+dE
         7/YAooJnkKrAU2FOd2ZKkrWOBGZSKfCZdkW3TN13OXKZvVlEQtxG9BPGvb0voCE98KPo
         +dvyDDIjADVptPiJSDh67kD5/B65cKfDuMym4ZY/5hHTFS4IHylxraOeYHfuBe38S7Io
         wHdrJcrtvd/Nv4MOZyp8TKQkL4ZtwGWTiur/pEKYLi20ebdIB/os3EzwZizysT16WJuX
         Wevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773787713; x=1774392513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj0EK2jXR9SGpqlW9u17Lt+6E/7lPN0qKJgj7KHpbjM=;
        b=JoM3vZ/G9hZZ4Yzh9zBXNsk9f+sgiRRVTM30L/nmJki5HeN1IQ3paCxdSerDRCp4C/
         DF8ulRmm5QiJSRcYkZfywO3c30iw22LJI8jPB/kpkyeCpkB5ksH45BWRZFDdr7u4pIQP
         6k6klaYaBXpi3CJpZufWnEqgehxa6i4Uj3PcEH1ogu38t42Ooee43gQtqtmexZD3RqXt
         aZJx0ibDaQhMAWpoQkokNvbva2JfNywEXS/HuHCGqjV8ZJzsz9JWWiY2orKQi+ucZLyj
         i95cFhpExfEAMTFV2yzbuYXkWx1wbRKqopZM0A9veddmUqrj3nKJgQTpVV6oOkg3MlXB
         PnVQ==
X-Gm-Message-State: AOJu0YxNBjE1rnIUvW3juCTd8Sxu6QqjpBKaEQEyibXuLEvOYEqyV5rT
	5wjApjqyNZHARC5viyux3oVEC9XkDEmftGXCACKTJtss6Hu+sCip+nEKbRYkZqLVkdpHuGcXaMU
	zqz1Hms5EHD9w/DecQJoV+OKEKv6SXZzdug9xTvkQ
X-Gm-Gg: ATEYQzx46jGMUJ3qbzBEtqpB36xthtlmM1bXZrnw6nLM02Nzo1HPF4Mt2a5a3Ek4urp
	ZMypOmeg5Mq0cii4od7S4VBQPDDkuoTOPaxgMkfZMnJ9LiU4SBptrBf3rNXLONLNQsJ1ZQnV+xG
	GC/YyZRM9R7Q54IzyKSeaLC4sEaM58pP+RFC4Q6SaXfKxoGhSvCJ3AU9hCGUz0yN5KsFUfA9tdG
	HOlQFO506Rdiiz5YfbUof0rPcyEf0FR6pzMZTv6cznJ1tYhEzsXoWDMQFAX9cir4EY52VQvttDx
	ex6xvS0Mb8KyStTaANoKCsphx4Qe3TPPELo=
X-Received: by 2002:ac8:5847:0:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-50b15c0f0e3mr3004041cf.5.1773787712967; Tue, 17 Mar 2026
 15:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310015453.1978412-1-tweek@google.com> <CAEjxPJ4LyCvazGuviyuPw7rVrzNdugQEukK=WMo2=SXdF4gRzw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4LyCvazGuviyuPw7rVrzNdugQEukK=WMo2=SXdF4gRzw@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 18 Mar 2026 09:48:14 +1100
X-Gm-Features: AaiRm52GwBq59uRRbfNxwcIGt06jtX4WJDqM8aFVl_UP2nuRHpjvtSK1ajdMM7s
Message-ID: <CA+zpnLc6=7_nPE+K2bEkCeA+cA=WVBDBxq8aEuLi8HYwrMYLMg@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] Add tests for selabel_file backend
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	James Carter <jwcart2@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 5:39=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Mar 9, 2026 at 9:55=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
> >
> > Add basic set of tests to validate the behaviour of the selabel_file
> > backend. The parsing and usage of file_contexts is confirmed, in the
> > following scenarios:
> >
> >  - selabel_open with no options,
> >  - selabel_open with a NULL SELABEL_OPT_PATH,
> >  - selabel_open with a valid SELABEL_OPT_PATH,
> >  - selabel_open with a valid SELABEL_OPT_PATH and SELABEL_OPT_BASEONLY,
> >  - selabel_open with SELABEL_OPT_VALIDATE and known types,
> >  - selabel_open with SELABEL_OPT_VALIDATE and unknown types.
> >
> > Validate that substitutions and local customizations are loaded
> > according to selabel_file(5).
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Thanks, applied.

Great. Thanks for the review Stephen.
