Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987442AA3
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851427; cv=none; b=pqrhN85kY2GbCvuCv6KsWZTnOBhvF7E4vUDjVHNj8umZESByYHqSwxHHb1Dh/NZegxmGTUnJiJWTPivypGHapiHjUM/Es3Ew7juY6KdK56e6cSz6wn7148y0Nkq/6cjeegF5b1IGq8gL+nz7bgPSjRue2P6g2giOWYyCxMDeH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851427; c=relaxed/simple;
	bh=H+Ttyc3FEvXMjQtHq/me5qnvVLQ1QMM6b7kLyeaz4Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN/r9FjN/iz4R/vZBvpSZ3KflfKatCNj+4i2MR1XQM3U8IA2MvnUr63LuNBvKCfotzHLgIMBLn+pujZOTSBW7xKud5zXbO9EE39J4mxUuNH+M+WSbLT+ip8PeQOfgZI5ritkdJXu8n2ebQ1BVwU9CJuUr5o/po9P+EPzKlrQrac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMHFLNAS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMHFLNAS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-273a0aeed57so94477125ad.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851425; x=1760456225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+Ttyc3FEvXMjQtHq/me5qnvVLQ1QMM6b7kLyeaz4Y4=;
        b=JMHFLNAS3cXEmRw+RR90qgfKiHOwPS802ScE+sWh5sXhBfCltSv4uDWxuqW48iO21b
         NHXbh38MzjnV3uyjcPrewCUBgySjVuSu9zswBpCGJsucvKXCz02yTNJH1K9EDlII3U5W
         EymHz+4tvL/1EEu/YcSCH5CNESE9/LKaNroGJ00jBVJuNfHXv6hs3IQ1V3WL6ig3BUxN
         jbvxBQQncJol8IuzhQMGd4182bdKrgltYLb0Ef0ihb4+vQDdeJ/0TNfD6AG4JEiQq5iQ
         m73o+pmATjEzL2CaCfmfsre3qMpkor9M0uHLouPvJ6gbEhaQn6taDv+HTq04L60niXse
         KiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851425; x=1760456225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+Ttyc3FEvXMjQtHq/me5qnvVLQ1QMM6b7kLyeaz4Y4=;
        b=RxcMQqpOYgRv3TuSC/SxLvzQg8Q1x3NnsPLxc5t9an8oauRllqLMTMxImgaz75h+Gm
         MMWQPAqeSIyOKmYGzLcZZ0BWoAVo8xhjgymG57PdovDrpgRLA0ltLZ+r+9uQlL1n2Lqz
         JaOoKpp//0Ga0JA9daXtBaup1HTn56ywU6EJH9tFjrqK6BVskppEO8X69kWO2O1wq1br
         9zDopzY7yGkV0jjDiSYtuP/8c2Q8EAsPqFb9hCSTi+RJzV061DnIChTdL5mE6BUo9pUS
         lUuO46+6zBW0WwhBv/9UODmxprDaUDhnWhB+yZz06IXDwIG+PZoPcf9EV7vZdMRfGlg1
         4vEA==
X-Gm-Message-State: AOJu0YzVXpX4bJu5xZbMY9MzVPhwJoGM/ZVMVvc2u8Ad050kbj53OC4g
	RVwgedCchL/VUgrXi/D6prbcK8XdSJARdWeaDypH6Z97g+/c+0s2nH50UI+mfqaqGkhJF+HGT+I
	CriM2cwelfvxuOrGqRdUNjsNKPaRY+HSxTg==
X-Gm-Gg: ASbGncv5A5mySRtAhyvFCWeDWBmfvIG5H14KkhIQgEPI/6V2J6SxVUqaKNqq9yybds1
	2qxvDkmjzOORhPyFVBIYmiEHdFaxF0oamOfHKknfM5SJZ3w5IDbtgJKn1CFx5j6x42tDuGTf4pe
	zBktWcLYukO/ch9mEsUjtuw2z6W0Y3pw9jvccGB57bgNttDcxfhxjeVN1+3YHo3i3uGqoeSnlPS
	NR1Klv2T+iJH+ybIa2W4vLWDpG8IQ0/Y1Ys6uBFSA==
X-Google-Smtp-Source: AGHT+IH/kNzi/M58m1LFB2U1vzQPe+h26SIUrGbrtuM9JXqEwHYsqfcX22jUoxHAcq2xafuhTCFJDAU8cxbNAKWg4ag=
X-Received: by 2002:a17:903:286:b0:26e:7ac9:9d3 with SMTP id
 d9443c01a7336-28ec9c97670mr52989265ad.18.1759851425145; Tue, 07 Oct 2025
 08:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731171706.1079400-1-nvraxn@gmail.com> <CAEjxPJ7L7K1=1JE0+h28uRt3fySF5RgW1wt_k352_Wv+qr9TUg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7L7K1=1JE0+h28uRt3fySF5RgW1wt_k352_Wv+qr9TUg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 11:36:54 -0400
X-Gm-Features: AS18NWCJkbk1RUKhjZLZ1Ipzcy5ZXA8Aya8fE5VkQvznEyCxJQ2AZS5jwlLB4Co
Message-ID: <CAEjxPJ69ie4ySVkeaA_MrygLPpz9UEQe2pCEFU4rR21R8ZwXFQ@mail.gmail.com>
Subject: Re: [PATCH] seunshare: always use translations when printing
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org, Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 11:26=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 31, 2025 at 1:18=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Some errors previously were not using gettext for translations, hence
> > wrap them with the _ macro.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Obviously this will require updating the translation files.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
