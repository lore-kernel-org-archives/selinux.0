Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96937B02D
	for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366440; cv=pass; b=h2DUwr7osdONbRyiK9VcwN3YqKcs4pwTKBGt8x27u62LdqWELNe3pSFXSi35AD8F2Jft0Es14p5M97LIgBZHVCaZePMCg/E+9U64DkHi8o5djIXY4c/8NgffyeWnc3ZWwN5ke0cJHrDYMNM5/y3PPDh4twUv3KSvoy1O0jApJoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366440; c=relaxed/simple;
	bh=qO88eWqExqcDjzk/JMMn2dlKvWPHgffue0oSBCceMdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noHj4VcoK9tLGtsLM4N/jhBAQ/M8J/AQkcS0RKKEMxaAhIjMNsYBbUT7fkOVgfUcXomqQqn67qUgKd3/9A1bJ2NVO0GtPpGZU391qOWklKK+JTdd7d+wWREDkb6kmE10Z19jtnVMvhea6rtuSfJcPX2FBiKT6xiMG1ZuRzQibis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJBZI7+h; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJBZI7+h"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f0167e59a3so924029a34.0
        for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 05:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366438; cv=none;
        d=google.com; s=arc-20260327;
        b=pvKrmjZDCcKCmzYzTYDDrcjTvIWLoYXTv4jKqeu7hyZ/5iCwwnt+4WtW6HOAa8Oiu+
         qVOiGKkW8LgxVtMn0PPet26TrrA2ZsGqX9OeG51SitTKrSI4qR18buHUkkm7hFeRfs7C
         pbWkyT/qtsndW54+j9MrI6ZaytpH9xX2aKzjL6xX9aXtHjgUxHvcNlVGSrfRGERfh2B/
         aAwvo7mlATYxoBFwbx7io8J0y1whAYsklHZE8AUG7NLRinKr6m0wjLmTeBl+ba/Xr50F
         pG6WbAPXfBF1x/DUbnl+UIqIFKJ5wswl36e3hYUz6Q7YAA9NdSu3pPfEv6WKLfZUkp1e
         PngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qO88eWqExqcDjzk/JMMn2dlKvWPHgffue0oSBCceMdE=;
        fh=ecuOsZoGt6vuZEKZNuBiTtf3g/wDPftyWKphKeU+u8k=;
        b=LFrtrj0bSRQ0cRgx1G+cl8Oeu63qVr7zW/vTpmFDY661LnVO90wNXjHEfDXWN+NFEh
         czOCONQi2TkAlmRG5q7KsRjSC56B+3J2dfM3gyxQmi27oOUuMBBp2l275Agshnh3IYCv
         5YHoUwnbAnV9Y6Bx9vFNxhfFp0dmyobQ7r5dGZ9fbjxrocdA+7UEFy1tps8YHss8tBEL
         5P/GbHlS2sGTIErilDYLNdUIN1P6WrkAOajMjXXMdO/MYSjCEAjbY2IEJ0XD3LuT4ZJa
         so0UgDwAOO9JrHYTrjwEkbEUWMVMTn+W02MTFo/+8ZAufm9xnEdJK/PDZJwKlsFuVad8
         O+GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366438; x=1786971238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qO88eWqExqcDjzk/JMMn2dlKvWPHgffue0oSBCceMdE=;
        b=HJBZI7+hkD99JwrLTphpBX1tzH4adPo0TT3lfv5AhRhfH3b/VjQEno9WkpbLC1VIsg
         b/ZONT3GB0YAiUFGTVTcBLym2gboNBvrVI3LAhGO7lRJJBZVynRR15WDgCQupuxFl4HO
         hhJu7k9KFhWxZq13qUu/swhbIg27g2QsXaFA0QXAfqkP5FzlqaO/nGXHHBKtLpT+rMuU
         ne2KWUxhV3vtbFt9+GGviarv6X1VC7KueCHylPJ18GDqqmpMBZKZv5+6V1zDWBGqPxqV
         YCeeFMN745yUu11zaaix2R+qhUhYXo0Y8SIX8Tj65SxF8ENPcvGhmTgqSZu5Vqs0++92
         vVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366438; x=1786971238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qO88eWqExqcDjzk/JMMn2dlKvWPHgffue0oSBCceMdE=;
        b=kkTKZzROTlmo/Br+jamX756WfecC2VNSzNWfcDpHXk/uwzdX5B5lRIsvzgHjwg06HC
         wxm8FAe0lkIHfa+IAYH8KvwgH/wwRPEKf3Xjpw7xsaDy7pEUd6IwM1th/iGQwCRGxeDH
         4vay7Oq0oMUqsPKdBJpnA9dKUPZY1zyZAChgzPJdvz43066BfxdaepcVFDy0XLXafERr
         tfYYQ+C9gGxvnNBUPEB0oenJ9ohziZ7aKVz69mfjKT1EjaV+u+fltoBVjMuRcu9lGWs9
         Adxfc/D8qUfpbzZTDekpmIl9l3l06oFr0nj0192lCZhqR0WY7OT+bU464Ib7qD3VWv5U
         0Fkg==
X-Gm-Message-State: AOJu0YxeyI1a7jGhRr7/xCLCsvzgCDn+3AlYBsBGb3IHyz/FCbdKzixx
	2PTQTfo4MudarU5epLEmbC9VsDyuQFfYUAuXqgAOQgcJfPZqczNHCQj1sd00c1l5VBcIA+MAKN1
	lKx9DVp6re6dGGKZzinH0mk/zLRnqRNY=
X-Gm-Gg: AR+sD10gG/WVutIAsCuXYp/DZs+QuIpYwgL3MQ3J9D8+zHqc6lcBj/Xr9afclI+KLMw
	NxfqRyQYZzxcpwQlgm+0faUNCavJ2xS5KqIBn1ixUEqJbWqThzvU3B7z81eVNfa1bZZEXl/q6gM
	RFVHB6r1qHTTMjci5Mf7kAqJGLXT1Ar9l3GJYP4OmbdSN9GXc4suvLGFrzMDjVF/9GFBYGpB7W4
	AomNqjpnLozsNRSC0SJvq1YO/HJQMI35D4AhZWwd5o8ExsgteLjng79xF/D2wuqg1cELlyaLtMp
	4rBIGjLjEXJTVzCOgONPxkrPK+arpflSygUaG9MkRmtF
X-Received: by 2002:a05:6820:2913:b0:696:836e:ba2b with SMTP id
 006d021491bc7-6b041f7b0a5mr10280714eaf.11.1786366438043; Mon, 10 Aug 2026
 05:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803173951.46352-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6a6d3+SDgq+9BV3Z7in0odjWxdZ7_c757yRY_EU4HMbQ@mail.gmail.com> <87mruucnno.fsf@redhat.com>
In-Reply-To: <87mruucnno.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 10 Aug 2026 08:53:47 -0400
X-Gm-Features: AUfX_mzensOORz7cLxcBNQowr8YM9M88zspEohW4R3YW_w-fbCJ_hDYMVEUc28U
Message-ID: <CAEjxPJ6YdHk9RwEPtoe57JPLAhOpOX2CDuLJuPRTKitaDBx-iw@mail.gmail.com>
Subject: Re: [PATCH v2] SECURITY.md: Codify the maintainer process
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, omosnace@redhat.com, 
	jason@perfinion.com, paul@paul-moore.com, jgsegitz@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 5:47=E2=80=AFAM Petr Lautrbach <plautrba@redhat.com=
> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Mon, Aug 3, 2026 at 1:40=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> From: Jason Zaman <jason@perfinion.com>
> >>
> >> Since security issues are quite rare, best to codify the processes so
> >> when they come along we can fall back to this and don't forget any
> >> steps.
> >>
> >> Signed-off-by: Jason Zaman <jason@perfinion.com>
> >> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Thanks, merged.
