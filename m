Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8D2222A9
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802632; cv=pass; b=ZGJXbUUA4Ssa51JRvZZim4vD+7y6ph4ARxrq/EiGGG36/V0R4GIXLAmvTcUAQLSPIFJsEvNpJfJ9LBQNu0lEhThykX6KpafZbs9o76vLRcI7jFfZ0jObhNsAKZDsuW5iWvWAhyiygrHscbZnnZ07Q0p76Z2829x9Z0De3YHrlfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802632; c=relaxed/simple;
	bh=8vAcKWaB8kHYHuaTTkvcQzdpnVqF8Njqna2EbO3p1SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2+oY3VlBOonQSJyirRa9HGPC7eWToO0kQna2VqZ5TIFDHFfystKSMQe3lzUrvJ8iVOQrGDXx3dn3H1JsjacPz21jMA0EoF/d9Vwqovy11ZWi8rMEZvT8MHMqbwlnfrdGT/2Rtovkr6enz4eKGTvc3i9SBXep7qCqAmtkfGSCng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5TkPmYA; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5TkPmYA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so110775305ad.3
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 06:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779802630; cv=none;
        d=google.com; s=arc-20240605;
        b=dlSA9V+gODxqsI/VdHdQW/MOAJ1F64ooOBla+P7U2dHz2HzCOGONXkuiLrtbmrCt8R
         nVFUjHIncDOnLu5x1Atf2/xpIo6HoiFevPMrm6WOX6kPH5aqilaOPaZLtpUYXWfz6fGu
         0RxTQgY3jznQiFAcyoRCS22fVvR19aHpbI4lFuA0IZI3aVQZ18vAn85I7LbvfSv9r+6K
         3LMhcs2qDyHSkAWGz9GCAGFbw6uPsRoZUNdHblW6ozZfGu/A4Ie6ms/PS6wZIxI0hRua
         xCzH7dLu0Ir0ndW/iiCjSQHyy8uv167F+XsEBYRztzTZ5E00dRvUW8f2frywQl8f/fcn
         Ri4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Eph5XDNF9vaxHsLf4WfutgizpcB75U+S2ZyXrU+fZA=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=G12oXrmpSG2XYSN0RCbA/QRWURNyWjPbx63h6VGLdg/wPSEatqNAYVW6jxHN927mCP
         51MQFJjFhRs8zTTOVYwIrTn9CwN1EnVszOLD47Y1RB8dHGlhscxOSWh5HKo7rWsueKd9
         rN4bC6lQi05RmtrtB4q6BuvevjN16dp7p6W34x8NHXp+5Nq7lCG8BbTxBlEykHBTHG2Y
         GLoZl7dmUDRXJz8yaNkqCLoTJzJZ8jSpgQsrPCiXFMKVerJNaMRC8x5qUhlMXvAEE47B
         OVULGPELSQsVC6aG/edPcciiGg8BEblZ6MzfMzOef+xIyQX29dLVoWD6aa6DrNR880Wp
         R63w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779802630; x=1780407430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Eph5XDNF9vaxHsLf4WfutgizpcB75U+S2ZyXrU+fZA=;
        b=N5TkPmYA0zQ9j3Gke/dWlhZhObqQot6Y/K57tTIcIL1DMPvHDlelHPzsLowhNHAkUJ
         itdi4uLQvbQIWxDHvby+Ti+dx5sS7JkKZ9ESuSzk3NQiNhaIInhg8N+2DcqLK09V5OrB
         5xsskKDQvPv9K628Ku5yKkCI0XlKchWZDvA7Kw3kyVtM6SP8NFe1Pw7w8aIDY4KsEmqY
         YEgVyw3AB8jKLZmcaOOEDuNSgs+By2aJ7BzIlTCiIorE8Rjr7PeHZugE9t7TrFddYBVI
         u0VHDPwq25zbjYiJyTblR3Z2Zxc9h/7y7zsh4WNMWjr3ODlmLiaKIArkGoe7fCMEO+6R
         7mOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802630; x=1780407430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Eph5XDNF9vaxHsLf4WfutgizpcB75U+S2ZyXrU+fZA=;
        b=h+cmT3hFzBRq5x7Oe3h4Tstmh2GqAsWSQP24MvhJMSzUZMeDZwDSV9Axh8b2CZfJHS
         E/x7nSwnOj4m69RjZQknmznvzHMeA3l43J/8m44wQPrsC8AAhDGGWW3wJ7ZwFNukjOe9
         YajapzEkUnGm6EsdaMa02PbGR3fhMsflgxlf16Rn53Re58pG48eUbruHYbnMXa8h1ExM
         V7W3rjOSFGOa9dMfUusFll8g2KNnQGNeXhC0Qiw7ph1TmCJFvz49iUaPA3/TwK7h6SLR
         fVU572/nJSjTsX53IiCBNn2+sr9AsI9B+F9tNLGY0nwpV2p0z0ziCBVY2bRONA3TT06k
         A4wA==
X-Gm-Message-State: AOJu0YzL9B0TxprVNRKxmk8vdcGGdPhVEJ4GDpe/jQQgF/1C203Q+ih+
	Jb534CQs2/PUbGFA7Odx541jYAA3TFn4QLyTYehjdE6ToSpDngGBfMCTJS76MqDz7FDkE+WB3Ui
	dBsmhB8c0rPhgJHYq7vvb2V2T2IMHsCk=
X-Gm-Gg: Acq92OExvwUKHPKLFwhnb8SfBTGUuzyXxBn3cIK9lwHqthGefNBzxzkV2fI3XfTRQtS
	gp//MG+OBWjMfIfGi0Mz1JD7rCl6Ze0WvY29dLvR4mby946H0bbsxa61reI7CPayNoHQJOT1dgY
	g10UGrBGdfvS30qJVn8yW4+MnKr56eh/tXH35BMynz5xt7A6sAUemgUwR2v6AXl0U0JipZyUyVN
	JqDOompvkNLUhP8fbdH2OkQ0RIKdsw5pqmd4Cz78XcGcT4A42nxPJxsauwf7ik/fejhX1v1/nO7
	fIizuFo=
X-Received: by 2002:a17:902:da92:b0:2bc:db02:d1ed with SMTP id
 d9443c01a7336-2beb06738acmr189441855ad.38.1779802630189; Tue, 26 May 2026
 06:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525161704.228092-1-lautrbach@redhat.com>
In-Reply-To: <20260525161704.228092-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 09:36:59 -0400
X-Gm-Features: AVHnY4IKf1e5CNIJ_KA_6Zjl7SNEJ1swA-TMp7mFdCmvLC6ocLhQTP3UDa_OMgw
Message-ID: <CAEjxPJ4qTxikR_RrMMwnG2YJv1qtOtQpu3UBNCRPN6xbM1x7GA@mail.gmail.com>
Subject: Re: [PATCH] restorecond: Do not unlink pidfile if not used
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 12:17=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>
> With -F or -d, restorecond does not create nor use pidfile and therefore
> it should not try to remove it.
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Is there a reason we are using 0 instead of NULL for pidfile despite
it being a pointer?

Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  restorecond/restorecond.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
> index 36f82ae5e9cb..6353b3b72798 100644
> --- a/restorecond/restorecond.c
> +++ b/restorecond/restorecond.c
> @@ -217,6 +217,8 @@ int main(int argc, char **argv)
>                 if (daemon(0, 0) < 0)
>                         exitApp("daemon");
>                 write_pid_file();
> +       } else {
> +               pidfile =3D 0;
>         }
>
>         while (watch(master_fd, watch_file) =3D=3D 0) {
> --
> 2.54.0
>
>
