Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4597E38889B
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941799; cv=pass; b=TRyfEWA8DJF/SqPngjMxjFRNN8hKbZBo6KWxDpP0i3BPco3fNVLu5CqwbrB+EHHQSQoWQzWOvZmAKqjxFeTawXKiET62yZ16zF9m+xhF9BqVPrNcmTUI8W6lzldzmvCaWiYmGso8IbWDbxunocjZW1k49MUXS44mljtBECoeEkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941799; c=relaxed/simple;
	bh=PBAoFcpcmSBK96Ljr7rtV8AV42TxagWMSbIBRhms2SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvJIbujYqYHTKPQg1ElL2tRrDOC9oTHiBQgbbuNAluS9piV9n+z4Vlfa9IbqOCCQcNZjbfRO8lB5unpZsLc56u0zvOlStdy6Hjp6ehYmhRed7qpDXTEaVpoD+JL0z3l/OHhcs/XmsxeQL2RySypkZtjMp4FD399tldaZRZGfK2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HT1JjRqI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3WNSIiE; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HT1JjRqI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3WNSIiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785941797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlzmfJ+qpAJTj/D0AiiLyDaREtARWihisd2tkd+YxG8=;
	b=HT1JjRqICmwOfcY6KhqoR2PWppGuP2nGWYg4Rb5Xgf0iuW1vv21UI9pBZY45P0hqyO5oeR
	tuclpsnWXeiFye+2fjd7NN/xjD/ugINBVrwf2BKZj20aF209xRgyZ2SfPljMEQL3VsfjyZ
	lGNWRnwZcygjGfJ13MV60HUV20Nk4G8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-kjSH-aobOxOOYcHOtEFykg-1; Wed, 05 Aug 2026 10:56:31 -0400
X-MC-Unique: kjSH-aobOxOOYcHOtEFykg-1
X-Mimecast-MFC-AGG-ID: kjSH-aobOxOOYcHOtEFykg_1785941790
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81bee860fb7so37239347b3.3
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 07:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785941790; cv=none;
        d=google.com; s=arc-20260327;
        b=rjDfoFA7qp8MaqNfZR1XfrjS31czLkxDxPvV8U2/864OcyG8vIex9g+GA5ij49x+Os
         gD6ln5fy7oTB/qRss0u68nFfZvq4q5VnfZb8dxGpYghVEcmU+VdHtffGK+rRdkUtrjD8
         NXreFyMkWC/VBt2lmhIRSG1bVeu8tz18qUKv9Q1VBBiwaBFZRrjVWp20orYhqyo6PtFj
         Rq9H8zuRETgsqxODoIYnZ/rX8BFYVKTaj2J0SDDK+uncVIp/kKJYzOUiX8sO8dauROad
         f3pxLiYuYqziCKVPS/ZdDyf3bPo9PKHU1bNPzQLS/+t3BP3Cl+wwtAOZWfyyATfgcOht
         spdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IlzmfJ+qpAJTj/D0AiiLyDaREtARWihisd2tkd+YxG8=;
        fh=NKcOKCkJomIoBLUEt50i21NW9dLX52xCGggDV2VKcac=;
        b=UxQFI6IaCQvxNHdsJlLQ5FmEnjnWJ9lAN36MNXj7GcCzqqZlxUx4kQxTDGerN/KXy0
         nMkfZcitYHJzL2n7P6lYeZe0Yp4gWiBGnMpDd7WlYUz1uB5n/mmum18h+/YJTfHk/YUx
         ofF6kJUJBkdZAckGGVTQBQS3POd0lixe4iKiV6SbEjTaiBZLlB4c8FdIu41nvKtR52GW
         jT63mfnBaSndmCpA8OBrwm/laiVVV9lKtQQHyi8ot/L8cbnk/1dPXonyhOvbjB5PsJjP
         p3Om0zn7yXmIA9O8OuHSqxqU4xO8+9mUOz4Zd6wpwvAErh72wq/ynHRFz/OAljGrphTJ
         Ne9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785941790; x=1786546590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IlzmfJ+qpAJTj/D0AiiLyDaREtARWihisd2tkd+YxG8=;
        b=F3WNSIiE7DukmEiA2Q/72l2ib8ja/WADsgu57+i8NArLHZvFwqayu8+n1ZgjPFKw+H
         Cl1JPu75XGAY9RQsKjw2hX1C7tWOtKlGw+0/Gwf/OfBpNWntKY0OLYToueEDONrbKwpP
         Cd20iLWZC9/2Rd6/LCUZ+5O/p02dr5oMpUKHHu1c5k1Wec6HZQcEtHk32o4Pv+XSa0fC
         s/uWriNjadHfXxrA4RErOLGmRLLnt2yQHVXgd8SJgVE0LYG0cXuw0zYN5c0qlBs0Lq8Q
         FDfaUPnfw3qrWpAfDOn2cLGKdJQ2qKsq+lO6njBLWRrq7y5bLMWPW/Vbc2gfsToNp0zI
         NZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785941790; x=1786546590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IlzmfJ+qpAJTj/D0AiiLyDaREtARWihisd2tkd+YxG8=;
        b=fw0W00C33KPNW0ZLLcDraywkVib9qNr5qQCz55EaBi24zBhsVW5HmOq6QjLcXSDI8H
         MQdammWvOtYnsKBqoj7+ZZIRE6UGlaur3k0GeC+o44CBWZ79wR0xa2DtLAZtxYj9vHpm
         Mu/k2ew2muKV+y7WVz7MfZ3xvsdyFeLZ0xzelW7TOws/NkYgs3ePMPK6hhXzEM8JvoMA
         QiGeVO5yhzmTPhdkwL0y/tWyw2XQCiBKIuP8w0egC69+JtcIzsshl4Ch5y0XR9E6jmhe
         4FO6hHWp2pn41WYv7DgyHbjUcxkLjxvlgZmj+f8spiO1gBJKyINya2ttdOg9ZkSVXVeu
         YJaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQM/kLOy7JLKvOhZKNG3bph3vptMrCQcuI6+xWI0806yvekk/aru8jxut49adj0PlgZGS6HflL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sEYGnSO6wpnX75eaWYgMX+G2k/wzrXaXgbDrOFiOfpefO7b1
	w7mmB2BGM31XYU87oIuUj77Ln2yoqm7J2a+z2ifNl+3DL22Uj7Gyc7h71XM4y+7DAyxqDL1+r1g
	yzBXG7+CTbg5VH6L8FEvF/PGXzzAsa1bDSYnswMXEOkC+c4VE4vb6PvV04Q/NKprOWuNWo/xl9B
	2SpDPMY/fA9XoJmAlLIUsl84CQYA3eL8MYcd7mo1DWJw==
X-Gm-Gg: AR+sD12KnvXNqum4Y3Hzsoau+zMGu9iA7NWU6hVvgpGoPrEyJ8i01QvV0yNf5azgt9X
	McWGd37RZc46WdTdN7ctJWXAc4wqTeT4NZu/zJx/qhf5K7c5TmaIq3vjDkPTMElpDRVwxoCT/Pq
	jpOrVk98puB+Pw7M2vaZZF928rQO7XwVBsvNEBRj7qy/kP9AiSOW1qhXFo
X-Received: by 2002:a05:690c:4a01:b0:7dc:f7b3:8e08 with SMTP id 00721157ae682-820224e0ee3mr39966417b3.23.1785941790389;
        Wed, 05 Aug 2026 07:56:30 -0700 (PDT)
X-Received: by 2002:a05:690c:4a01:b0:7dc:f7b3:8e08 with SMTP id
 00721157ae682-820224e0ee3mr39965337b3.23.1785941788558; Wed, 05 Aug 2026
 07:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804135700.3713-1-stephen.smalley.work@gmail.com> <8335d7b97813e178446e4e8b37e8e961@paul-moore.com>
In-Reply-To: <8335d7b97813e178446e4e8b37e8e961@paul-moore.com>
From: Jiri Vozar <jvozar@redhat.com>
Date: Wed, 5 Aug 2026 16:56:01 +0200
X-Gm-Features: AUfX_mzeToO3iq193waVqZklnLsUqLfHt2CsL0WTCgIJBZwxIZRnyxiarMzEqDM
Message-ID: <CAMgFczBaRgj=aH4A-Bd9Zw12Kmt2ymtMQwpaUW7rOk3FpDJenQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: check level category sets once at load time
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, jhladky@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
thank you for the quick patching. I tried the patch and the
performance fully recovered.

JirkaV

=C3=BAt 4. 8. 2026 v 16:57 odes=C3=ADlatel Paul Moore <paul@paul-moore.com>=
 napsal:

>
> On Aug  4, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > As reported by Jiri Vozar, commit 7edea6e8c8e8 ("selinux: beef up
> > isvalid checks") introduces a new loop in mls_level_isvalid() that
> > causes ~89-94% throughput regression in System V IPC message queue
> > operations (msgsnd/msgrcv).
> >
> > Move the expensive part of the ebitmap checking to policy load time
> > instead as the reporter suggested.
> >
> > Reported-by: Jiri Vozar <jvozar@redhat.com>
> > Link: https://lore.kernel.org/selinux/CAMgFczCi2Z011dNf84Amc0Q-qnTt0+VU=
jWY+Y7zPyXdaH35Jvw@mail.gmail.com/
> > Fixes: 7edea6e8c8e8 ("selinux: beef up isvalid checks")
> > Suggested-by: Jiri Vozar <jvozar@redhat.com>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/ss/mls.c      | 24 +++++++-----------------
> >  security/selinux/ss/policydb.c | 23 +++++++++++++++++++++++
> >  2 files changed, 30 insertions(+), 17 deletions(-)
>
> Merged into selinux/stable-7.2, thanks everyone!
>
> --
> paul-moore.com
>

