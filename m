Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F472566D3
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183457; cv=pass; b=iH++E513ATxUP/jPQk0bH1x5V9OzI32OLVOIarFSG3taTjlTr3oheQOUznPKBqFofEKFwfnUA2KOioB2c6RUYpb0CswaN0qpW1cTbhbg518sWikmiX2BverKZOtjirmxfU0223t+TDFKmVR1VLj0QzuYwzbNfONVSVjRmtsSETY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183457; c=relaxed/simple;
	bh=SH9z+vzGZdKIWBt98xoErDGf4Cr4N9ltdjG2W22kg6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH+loiUfvQ/lEAnvsnt1p4m2ZRs8t9xAu0TpDebCxH5ZHOHx9dD0P2Vd/uxvVQ3RU/5c+eL/wHe930i275UC5mCwo6zbSnG5CLHlJvzbmNiKO8DlGOlDMSfcOuxWti2b6Dzgo6d9DexgxMWOo5rs8DcUYGfCe1OdjsPz76V0aOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRBDvJGE; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRBDvJGE"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-456d267da8cso1304610fac.2
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 13:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785183455; cv=none;
        d=google.com; s=arc-20260327;
        b=swnOLd0pHzFA0k6BIQq1ffJMv7yZxs+miKVmmiTnU2WrviHYWtby/lN9aRoUaojCxw
         wnCyh1qbyy0+jEqMbijYY2F85By4B1yJq0qMUpb03z3faULWVeMuKeaX4SbObSiBRUy0
         ST7r8mKmjD4AurcEk5iKmXat/rM0wIt3gY4szyCbXotWGsgsepPyYTxVUoxoZQlPz6Mu
         xeFDs8Vqrc1R0+xPrGZnd4btOhNl8AvIOLcxnSynMYD5FXLOylqNKiBO3UKinwNsvTJw
         i4AWcKmJHknMPu7nhQUvPKPY38etDwqKbd7iNSwLVD0L9L7KLN5Zw0+UKqpBGBk2wBJf
         2Uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SH9z+vzGZdKIWBt98xoErDGf4Cr4N9ltdjG2W22kg6E=;
        fh=jjoluU1iVsRnYHxsE6Al65y4TtWykGIbcKFmaorZ4Mg=;
        b=U7XIsaoSh471LxzVddQZ6KHA2NhOa1KzK0pGvpJASDSpi7umFJ0QxzcpoqXoI2mm/i
         H6Oik+1tTi0Cqxd08IxdAiuNlBpCBsGwTxFYdy3VbnzBt6pvZxrdhDGQBe/yA9ppetRP
         zLpUsdlVg5acEB+CviKydir/YccDu+cPhpD4GS5TAhcvfikhe1miN7i+O77MA5aMxeKk
         b5CVpbbQunQ0xdKqC91jsyeGwnJCzbyul4F14l05wNAmLJ1OJIaJb+pR5smhPW36thWE
         2CCxg+E8qzSHGi5mWq91827HGpzfPVzhCu0HpGUxvLjfvZ9Q33c4RMlOqkjEqGMqqUKH
         LXxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785183455; x=1785788255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SH9z+vzGZdKIWBt98xoErDGf4Cr4N9ltdjG2W22kg6E=;
        b=GRBDvJGE3RUt0jDn21d0keKm/f0bgAKB6fUnWmJt5ATXxuRNUhOdofA8EHZet3OmTM
         Kqf4BsvJKADNm3Mplk8025HX+wcraM26Jdy1GUO8dOHzDinJfRFc2IiKedVvnr9Tby8s
         V20jSp5WD4qz7LDzcc3GwCqnn8pYZ+YGC6r9/xJ57czYa3lyeTyrNoQw8qzcj0YaANMW
         9ktzWwLXEaJpK6Vxv8kghDVxE1dUsXZ0UcdRHHcCL2e7F2XVU6bQtMTi8QlNtlE/RzW6
         tkeyQzVYJ0v00NyoE4liCr7rbx4bFGNkYfRdMYQoNrOr7p0QLLbanyoNEEttrgKx+cYQ
         zqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785183455; x=1785788255;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SH9z+vzGZdKIWBt98xoErDGf4Cr4N9ltdjG2W22kg6E=;
        b=VnuEHCpmovua9AcnARBUW9Deas137oAeRJXcbuKMioPIO3BtNNVE9cfVM/Vkav4E6w
         V3ue951NZnbt9Dqklp1e2JqtEfWcGZrRS2jl/yFdzd8B1CyG1HNeHIP2mLGZOPyMh2vM
         A/vJUL1IXCxgPxx3SepBR4R+2eKJFvh34hLr0bx8FdkorJL+9wJqOry0c/xvWMaZ7CNl
         VLxpYvVj9iHWhhpjOe78ooxiUJFzca/NtwLnNJdDqKjmEySsi95pD0kEvitGSqMT5ICo
         qLCNiomrtoqreOT3IV30/JGVS9Pz9Du8Mr6fs4pRAwla5wYX7sA1CvBCTp0oYg8GroEs
         BwdA==
X-Gm-Message-State: AOJu0YyP+OKEwKj4JUNeheF6DaLCmnEHB0wSAGpthz7BTqlou2VfuyH7
	4aGcGjnPnIzglFZ6NGpdj66XRhivDSJFujtDN9PvGX94fIP35GmsWz7xdR+frYFiojPrJ8GyKuv
	hiS8ArujSn0AaKR4N9045X5WsDBbjBgc=
X-Gm-Gg: AR+sD10sW3zd6p7HFgCs1zOyug2PFe9e8SloJj3VWFWpFkmdlTmlA82h3PwIMvN9nQI
	84h3B66clE1gYanObuiclNvyl5RD0y8CEZ3hBzIS6NkPUn2flsO3vSolVcDkcbBcaBHz2kDC3h1
	QuQmHGyjy34O7BfAsft+2fH4cT42DJDui0LDWMjLyFGQ97XAplBp5k9BlKWDXuVKw3bzz3KCykV
	4AKrJE9cnnDNt2jaqu/TRhEz9jGyDDN0fG1GOnLnhp5yQGxdX3VVfENiM7RjA==
X-Received: by 2002:a05:6870:64a8:b0:455:a205:fcb4 with SMTP id
 586e51a60fabf-457f26c629cmr7857569fac.20.1785183454879; Mon, 27 Jul 2026
 13:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727135957.85523-1-stephen.smalley.work@gmail.com> <CAP+JOzQ5nqo=ZuO0KogwH-+ez1UZpF4oOmPWYRmSPcOZpxwEGg@mail.gmail.com>
In-Reply-To: <CAP+JOzQ5nqo=ZuO0KogwH-+ez1UZpF4oOmPWYRmSPcOZpxwEGg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 16:17:23 -0400
X-Gm-Features: AUfX_mwgUgY8F43hhaltSqH0ixj_x9h6qZRwLO52XfV2TXl-JxCM6eY-77ZjPcg
Message-ID: <CAEjxPJ6rXp4-zKFtNJFakT2ES8qZPZFSZ+ifRDCcmfz37tdD-Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: cap max depth for __evaluate_classperms_list()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 12:53=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Jul 27, 2026 at 10:00=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > __evaluate_classperms_list() is called recursively without
> > a depth limit, which can overflow the stack. Cap the depth
> > to avoid such overflows.
> >
> > Reported-by: oss-fuzz (issue 479899924)
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
