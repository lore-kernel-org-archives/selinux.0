Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEB3B27C9
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997535; cv=pass; b=rbT7e3c+NsL8xu7KbKoF7gZmM4SJ9WwpU4jBQSxS8IO+/sju6qWy8O4LQSSyiRCQF/IHy/GvqpjnchjgdbFh8ySaesGUuwWZy37ey8noV+RgUwRdugjprZwa+afClsXPZKJ2Tyz529SA8alYuJ1qKnTeT9Dt+VC38hJPCV7VIZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997535; c=relaxed/simple;
	bh=iGhOqXdohRpPn6a66E9LJuPLMiG3wY5d0N39IbZBry4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGvH1oge+M5miPLw/hWUx8rpz0m8J7Ie902sss51O8Y5gtOKsoV4J3RUmdVhKnFIcubefMYHOcgXP7IRg455A+APpGK7k3sVRd0dfoTYnH0/fdqryP5FkHJugK2NCNrX7Cp1++QEAsTlOHJUybF4AqZRld3fM6PpNOhsxA6uiic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlCJOAVK; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlCJOAVK"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-45e6d266921so1541810fac.2
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 13:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786997532; cv=none;
        d=google.com; s=arc-20260327;
        b=np/9ww5UinE84DC0UXBcz5+ltfWOjjEeCcUsA4ie5XM82VfeG7ETpk9QTxmWBOhjH8
         Z2a6VMONXW4ce397rF9UmrHPItrx6qQnKonnvG9EBidCLFvzmbZH+E1xpBUQMLUtKCoL
         Dhwt/tn9hRigVwDjxi5cFc5sW1sM0nAAEP8KAkpNIaElEDKJ1dLkck0Mbr5/tBMNggUt
         l2DH4A4RZsY1t33VD/xtBPVHo/cTAdfJOxPDzQYWcVq/5H5YY52paoMYrP6/rIXqRtws
         +uEocrFWQZUJSlwCOPpETLMP7rq8bU77kPQbRFWuTbx6pkgAZLR2jxQPHvMryOXq8dnN
         4+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iGhOqXdohRpPn6a66E9LJuPLMiG3wY5d0N39IbZBry4=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=oGq/YrnbNvWSprv6tHzv7AYkklXSCcKhF6V5LFvSG8xJmeAa1hfVgdN6yus1LjcqyU
         mAApaY1fnIeKIBloyt0f85TFkAXAIdMlNsN8G+4tPl7EgiuVPed5pFw7rRR7Y51d9X2s
         7xRIRlSnoLQSnvdiqgmZI8oHVHbtvP0TOoZont3dj8uZ78wdbrmQZseGGQ5GPna7OAUe
         sV6LRjTcLIaU33g2EtwGW7BqOxxPj2JfXaG2vSC8ZLnG2c6lp6peOihEhybhdOJ5tcJT
         CAKGRXZwutUxS7MaF+2OLHt47ohlVUyQq3ExDo92JgayRCpn8ddsdiX8RH4o0sCVaRnk
         KXlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786997532; x=1787602332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iGhOqXdohRpPn6a66E9LJuPLMiG3wY5d0N39IbZBry4=;
        b=BlCJOAVKp1iosy6RdwU6QFWYhC3Z/xDVmjQfwejT0TmkFhqPxZtojXgRBrdTvrPNXz
         d+RNuquwkFVYAQr21dOlvOYi9SeKd+pVkPHhTUwUJ4GZyE4Ltce59HBQTlkkPDjOrA2/
         TrYI9WXxpL1dLnHj8IgWbqmzjgqDhdB27zkCSS3uZhBUkchGcc733ROYxzqZPWEGZOsw
         PofRxIi1isc9nbLsSruo7OmH6qogegZgFjrZ+USMqyS+hgDr/DlF17Q7g0jso+2+O7iI
         /kdlw8A52bLjRzWAJN/SxY6BJVR7adWJGXdEhzxlP3cLzlAW1t78F117Qsvgihxd4g6D
         Pa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786997532; x=1787602332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGhOqXdohRpPn6a66E9LJuPLMiG3wY5d0N39IbZBry4=;
        b=F3sL4yBBeF3pByKajFv69AVW87AxXmqD07u0uWyWiSg3toGENEHXURPAE1OwbjQhCo
         9o676ZS/ctAlNtHk87dBcndU75oYJooNNE3P+M7qVyiPginY3rZDz/w0Ywaga7Cgc75N
         vlzAUBLdVDp62R/HxzDGRz3gpvSV07N5ci5elJ+V26QqFwzRaxv4pJlbHie2pIJIaRkk
         gk9L5PPc7zBmHcPpLQJv0EFvwutbUiqGIqNzhA+/gt73rYPz9ILYzs4GQarpFXx9Fp+r
         xvcsauvB6d1pycEMTsJ81hRt0HkLUBC+uJCm2exA4QH1uZ/viDX63iBylqcSadlQR0Lx
         i0Cg==
X-Gm-Message-State: AOJu0Yz82taGZUPeWuyyHgsmHvOcgBVkPEZDKJG4Jjap9ofxfO9K9q1D
	H86Pmz1rBhRlr4aQl3o3XEsEkY2FNxH7RuCthrddyKyke5Ffn8UQVeTrnnITuqLCfyRq6BkYuOL
	WaVdcyonkXeUN6FE16OQ6OR+bDN8fYII=
X-Gm-Gg: AR+sD10J1LuKreOs6WHedj6hFOcQNivSM8QuVVrxbUmKBhRhcPCM3oY3KyyIzOz4uBJ
	ntdEZ0b2xxNV89b5bqQorTWZBLm2NFncR6vOC626v9/N0PsMenQczvNdcJZCGpXOZXKa8KLx7y7
	cfKtnp9wauGVgl61ViEQlH4O4ZqR83tKDt9p3mwkQjcbVWg1mrb2oof7NEuWnnF/cOyQH0pE1LG
	MDhhMDOOnzeHAvzaDZmOwxghCPZ/f7Q4nxh57S4x+W6fkGI2V/02Qd6fDLcraFqmHbiS6moAiox
	fRMezY+fIwP/e1VZEQv5zG+5g2wGuN9H/6nCrY0LW5dLIL6WZSNT04v94Ws1iRO/
X-Received: by 2002:a05:6820:1891:b0:6aa:9be1:484a with SMTP id
 006d021491bc7-6b11dce4eb7mr3180832eaf.7.1786997530749; Mon, 17 Aug 2026
 13:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813184042.185689-1-stephen.smalley.work@gmail.com> <CAP+JOzTUaOSwBfiEmCf-9aB9qZsSXknbGKqr31M6=vWj+NvVoQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTUaOSwBfiEmCf-9aB9qZsSXknbGKqr31M6=vWj+NvVoQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Aug 2026 16:11:59 -0400
X-Gm-Features: AcwNN1V5TTx7KrlyyyQSIAxHr-PPJTRdyvtzupmry6AY3gnMqd_rM8wasdNfYzg
Message-ID: <CAEjxPJ6=at=wqQjprxsEwg6=8mk1ew+nBDhrtR3z-_Mp0cM3iw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: selinux_check_access: fail cleanly if
 avc_open() failed
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 9:59=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Aug 13, 2026 at 2:40=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > avc_init_once() calls avc_open() but discards a failure result, and a
> > subsequent selinux_check_access() proceeds to avc_context_to_sid()
> > which now hits assert(avc_running) and aborts the caller.
> >
> > Latch the initializer outcome and have selinux_check_access() return
> > -1/EINVAL when the AVC never came up, so callers see an error rather
> > than a SIGABRT.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
