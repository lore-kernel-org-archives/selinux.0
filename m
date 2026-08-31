Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DDD37AA95
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207345; cv=pass; b=Qyet7rFMICj0WId3X9CQf008jrzhbC8ibwGtWz+MXfbyJEyMtGVjAC5AZCPqYmb6o64IjrP1v0FnXjv1rqkTyqKb6sbJlWBMWqNPMP14H28iVVbKaAR5NKhZ/oTSpkRxju02ysRKGoDAbqSrw7LDUwJ/gj8IMpuj16aXv1oU7os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207345; c=relaxed/simple;
	bh=HzhZqmllyJXqUns5Ttlbet2gEmpDi4CPVeVqkKahPXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYy1VqWpDvSOvyVony75lb7x+MviWobfp3HhlnBiakhppYAYRBaadHwkXW/E+JouufxIwbSA2ZuO+Zma6e4YnR3A9yVCUiPDuQBccG93ot5vSj5Knb+4Q5FnavEAUCPh6cI5F3MyTg96j8xueZzUVwysreGpNluYOId5Uw3fX0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHirv6hl; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHirv6hl"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-467cefc56d2so2333469fac.0
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 13:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788207343; cv=none;
        d=google.com; s=arc-20260327;
        b=kWqiWXe7LKVzk2IogI061usRc73N+BZPEzx34PreS/91JHfdz0CupnIyqZuPdwvrjZ
         qy4sQWNEibIxhJ7C3G2GEEM/w4b5xeG5opV6hVKQS9978FYjveLEzBj6zV4d/Fkm4rUA
         Tt7FHDzmgoBEw0kMKUYz4hnrdPMdGCwbzn7TI954b80+So2Nfw2Hrkc0nDkouPyA3mg8
         27xpnbhl504yl5A4nVu3g+aRduXqLyykHuiW6Cd7YZ/emDZWsUSLStxkiB2JArZjHA3T
         ympS80OKtQ4s8Q98KgD3yvDOD/tgXgztnJEZb85ksfOcSQJgRcrfCUdDfn/Y0aDc8kL9
         IRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HzhZqmllyJXqUns5Ttlbet2gEmpDi4CPVeVqkKahPXo=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=fcngcPXmqpr+9lVe2QXFu81cSP32gpsdJtGvfaNK/X/KI7WyBDzE7EOnw3H4ZfGuLj
         GoTesTDw/vsW+FHTxrMKcwCAftc4w0n6d2MyZvZ4t0j0QDjKWmBuVj6931qfCBPFzG9I
         H4KW1LOstI46tJv+CP3caqP99whM+iHmvCi2tQqj+AnxdgLU2At8y+B4FiC0UO+GNC9C
         TdAv7QTQg14i92sCzVnP4hV4OOSEwahmeujmUFFqxodmiJaXKQeeDDbHzAgb52IVNtBh
         XHBkfSyuADRm5w9acQ4aI8OFYHrmDD6PRbNLs3hAZ+3H0hbzOLgH0t0zFtAxyT/S7UjZ
         kf4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788207343; x=1788812143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HzhZqmllyJXqUns5Ttlbet2gEmpDi4CPVeVqkKahPXo=;
        b=tHirv6hliWU3/+/dWR6vnq45MaQewb+98pbpHyVl3txOZq2w+MFmqYyTwXSrwYXZI/
         vn+KCeF9jyJm3Xw6QeCTNIILi1W8PyocLs8iTPlOVk8RRWlyTXH+w3caG8Cjvc+2lHSe
         /toqy0y2UYEPbjY58fgOH3tplnvJy/CAlIogJKLgOQsSHP9vH5cDE31aA1ODlEAkziG8
         pxOPaiteDaUOzp4hcJSvDCM8gt5t+SBk5dMm2zz4CmQzs+n6oqplwdZ8PdZUQGmRRI6B
         I5RY4HxKwPWL9d0iDNpFmISLoYs+weaPD05Wf+u1LLHKBji3LjMtA93bvc3YnH5rD93r
         /yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207343; x=1788812143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzhZqmllyJXqUns5Ttlbet2gEmpDi4CPVeVqkKahPXo=;
        b=Db0EBHIPuQ2JrlzHQ09yFlU7wGNx53Ac4Dcm2orJ3vWl1W3y4tDo8ckuEFvyeQGy3a
         Yv1igcePluDkTwoA/NHy6QrhRAXOi9BlHUsplu0gTSNH4JrFdggAFjUk853fDK1SOaD4
         5X+9Opxe1vW+md/olZ6qxIoTI+4qKprF6XRZ0QG1AfwPaNqtUOOy7Grk+EDwZdZHb++m
         AEKskpeH6dRFjIsEUrhDDPpPDhy56v5YMenHEp7L+wwGbH5QpHzaMTjaOUHRwxy9eWXO
         mc1nraCynPMchsdvJdYG+73HC7Y7WvZXoqffa69V8aOWAGr1TYcnHUQ50zJ862kYG4fS
         E53g==
X-Gm-Message-State: AFuF++kjdRvM5sqq2CYbV7BE7vUZtCqeMvaNm1SrQLdeU0/PuFw+b7x1
	BqHjRl2JHZJHaX1RMO1RfGuM+x+o4UwQ/EZCQmORsYBuJ5hD7O13vcZZIzokIVMolXxq2l7YAfs
	/tcnNsLTGKtefmM36Rw51Y/UgXWQvBrk=
X-Gm-Gg: AR+sD10lfTRDRAxIhzH77rezD5n/iHxxZwPoYQdt366oTDEo/6GhTUC/qVHtF78HsMQ
	R8etViHRgPmZlUxt75nX9Vs7yT816HHhqtIOtj19l/IvkIMazpZWOcuJjfxf+Mt8D32z9N/KOlO
	uUjW110Bx8lzAim92LsLlidzanGJxnxNJTtnjRtjhRXbthI0hsJZmMkrNid9pzQuoBrDRU4eWRF
	vP9bDcqYJu+csYoBX15aPSRBQ6Hqw5SEPvB6ANeDmVdjb7nmYVaDm66OduXNJUAe3vb3Ygim0Aw
	0OStHdPr6MMg9n2/fTQtAh+kgEYYjgK2iAfL/eL1lLvh
X-Received: by 2002:a05:6870:458c:b0:43b:6eb9:46a5 with SMTP id
 586e51a60fabf-468379a825emr29476402fac.13.1788207342873; Mon, 31 Aug 2026
 13:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831154352.49412-1-jwcart2@gmail.com> <CAEjxPJ7pvujwdMYoCxyiw=1F9jq2-66HFz_fyUkbDOuMKcaAww@mail.gmail.com>
In-Reply-To: <CAEjxPJ7pvujwdMYoCxyiw=1F9jq2-66HFz_fyUkbDOuMKcaAww@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 16:15:31 -0400
X-Gm-Features: AcwNN1XDZFgtblg0WJyODQfze19vikIVdz5LHb_UzLD7zXD6WnW_KEn1Tk50Pn8
Message-ID: <CAEjxPJ4w3puNiAA72Ebqeu9+hhbNaJHQmswaC6Y73s7CYPMJmg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: Check for mls constraint expression in
 non-mls policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 1:02=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 31, 2026 at 11:44=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > In a constraint expression l1, l2, h1, and h2 all refer to levels
> > and should only appear in mls policies.
> >
> > Return an error if a mls constraint expression is found in a non-
> > mls policy.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
