Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736E3F3289
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875718; cv=pass; b=VQc2TtkaJwGe0Tmkr1wrRUiBl3vzv0IrPi3vg77FoXh7eJVhGgVDeBEkP1mrfG5gn8NVUmurew+ifMg4yNEJR03+2sulVtQHk7W3YHtQ7BxTYnmA+zvnUEy20ahsnUWiPJrwjatwP7UpPk+22r3cjL/amoyz6MAn31/wrwfVHMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875718; c=relaxed/simple;
	bh=5zyQmArm+e2eBb6Ko1RIc9jGYr85urbzQJGaIxZC2sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpOVyPknZgbmN3CFh1/oTa2rRXmhIMHI3cP7OWoxO5psD0j/oVGHWUImArLF/ywT083dgleo8gvFtWHKDXuBW84YgN6DX8QC+LUj8zpf61QSTFi7QxmqF7Rqrv5NG8Uy/ehWWZP+gIb5lWVBzuUTqL2VTHEqJmA+pTN7e2x5mxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfE88aJ0; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfE88aJ0"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4566a5bc186so89777fac.1
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 13:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785875716; cv=none;
        d=google.com; s=arc-20260327;
        b=K0Tf2LoZTtZdxB27Zm3CVFZgimm2i3mbt25o0e6y4nOEG3rAfI9WwfzSDAeRyWQV9c
         ovhVV8ovfAz4BCVXx/mDCMcvhcqnU4Rbqve/YmyiXqWaaefUtrB2E84OzOC0awBIhZAU
         YBheAIOp8FZmDPBWRaEPVsjbsvGo6kWzHWdzlzog1HxIN6zUYX9fSU2fKbKmHYEF8rVw
         0W2xL+fU9y2oChpO2Ab3oCan+doTEJZ1mGHbR0BeP948qBUmw7m+cEwZ7s8NdS+oUhwl
         K5Gso0knxPCVH7HO57QdE3CEoTtQEWMVQFloGwlQ+Keu7W7i+iF3nZ8DuKbFJWnpGkVt
         bQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5zyQmArm+e2eBb6Ko1RIc9jGYr85urbzQJGaIxZC2sM=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=Y+DKOGsL1Z1IfENTOAK2frUNFmhr78eFaDVnHU3fUTpOzMr3xLXZTEWLzpQHJhjzbj
         ljRqTqoz5w+wgd24z4WtQ8jTV3DroNT5AlyCYVIJz9SpaYk40/m2JwXMLu/kDEigNc5v
         5xTc4KSsu4c7wYY6Gc0qipgx+Qj7j2SezPtlYW1iYf4cIJR/1lP4DPoTPeSmSbZW2Yy8
         9WVzNKZ6jCDcIUFjOwy8L4ZJx8Kpw37ZvfbU6j8YS1u5CvIqf1r4ZLcW0ovmaok7gmaN
         SyYGMcuVbY3LjZyvBSl39mJYkCziR2NMEQ5joWjIzi9OnyyWK2nI3v5LEEQUz/lYueZO
         hBvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875716; x=1786480516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5zyQmArm+e2eBb6Ko1RIc9jGYr85urbzQJGaIxZC2sM=;
        b=hfE88aJ0xvuYXbcDPc1UWEFN839z+LHFxD3yF5F6fJnJX/jt/iddOCPHLKR4EhYTVc
         p7qrs/PHnAfeGrR+xOU3eVSwFPZsQZ6g0QGHKhG1SJz9uA+dYcn8OlLPV0vYougnc322
         AKgti82WZFPd2rLtvy5IB1gtN2uMACFQRYF3BMtUgQJOnsFI9GRfYmIe4gyNB+l0gq35
         A/I1x0t52A44l0C02ZV3zNvL/ym2LabWbWVxpjLuZf2AWf0ni/PZscil6gZf2lFWo/uf
         KVYCd/uhNJaYW2f/r+njZt9mgJjw2rqyvKXpCAazaZCX191Ws90Vh5M8cHgpV+650CZ8
         MhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875716; x=1786480516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zyQmArm+e2eBb6Ko1RIc9jGYr85urbzQJGaIxZC2sM=;
        b=rWpvGJwlhohHTvYun7lAHFqOpXnDg05b43hVwlbPjiKc6BQVghouG5cmiBMHHq3j/p
         y+2FHegRzgugJ2qpVNyE8XeH6YkPyM8Yvrijvd5mFHYEv5DSsVsOO0qp84wCpL30F4jn
         Wi72Bq1Amq0Ph3jQDPqerKdoxVaAIax1YQZm0k0me4gXF9P6S0Jhcv60Q4AUPjyuPTFl
         HLsFPQgaJhgYAz8BgWy30Vk4heG8HyJeT6f79eK7Rg4yDzrMj6HEHF3VnQsatXKwgR/g
         jiay8nPqbjzYUqjgpGeyPob5MUt5AmKQRNk1Q4gsCMN7JOr5sjmUKpLdZmsrWWMFgQ8I
         9XKg==
X-Gm-Message-State: AOJu0YxMStrKI62uBd/D9ymyOrlvdjPjr8wxl/uXUC43iewvn4OJcX7v
	Ito+TUI8N+hRvrO0adaeeVCmN+E6rhpITPATP6Tji+DLFTmuuko9lGwncXiefb3rMWrh5xjIZic
	I6bnIjtJclgYWmTXq33xTDDsl6kKMXPc=
X-Gm-Gg: AR+sD13+oAa2lKm5pJQi7zw1QgKgOfOJyoMVKOLLCxnLyKjdxLha0GagLYCTGRbmefN
	4pwTaPeswCac1OohYERI2kfVmgfZXIBT1bNdEyY2DSeOBrIeFn/F99vnVl3J9IbvFvMRw+ITtR5
	NVaMbtatgWvyQyS2ciojkAmyMTxi9lY7Oy11t9k6X7nME0zUHFVOH0IuVaKyimggrG9Mi2+T221
	60VqoTPlm3FsB/0ROwoBKA3TgQ7V+n+Cs9zm53GkyrHJuxfyAAkKSb0olbZl5UFI3plJfSs5io5
	gZ4nM2k5dYvjEWnY3eoKoRElbor2dwqjgVv5EsBmX1pb
X-Received: by 2002:a05:6820:1524:b0:6ac:a175:fe66 with SMTP id
 006d021491bc7-6ae96ed3de2mr1032286eaf.21.1785875714434; Tue, 04 Aug 2026
 13:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803200935.49341-2-stephen.smalley.work@gmail.com> <CAP+JOzRDSvAdSO_i5nCUjqkOAPe=uyP0iYp0--qCV8PRwZGSrQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRDSvAdSO_i5nCUjqkOAPe=uyP0iYp0--qCV8PRwZGSrQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 16:35:03 -0400
X-Gm-Features: AUfX_myetA3Slzd6tU2-htXyiZ_ckMfZCEEz8Il8zYln1ABF6XbOi3RSe_9YoHg
Message-ID: <CAEjxPJ4ji5m7vZBUJMrV-kNX6NQZtiu2NXiXFkYW5SvYNxc56g@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: log an error if we hit the max depth for __evaluate_classperms_list()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 10:36=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 3, 2026 at 4:10=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Add a cil_log() statement so that we do not fail silently if we hit
> > the max depth. While we are here, introduce a #define for the max
> > depth and use it, and fix the comparison so that we fail immediately
> > when the depth has already reached the limit.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
