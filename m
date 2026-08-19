Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13B477992
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157685; cv=pass; b=scnLaHkdiFwZM7igV4VvJF39gvxvIdE5aDP65R2WCaVZP1l9JdMHWCuVkEvzQdUn7eCvJfZx5DeYAKrq/3rY20rfaaaOYom5IGWTtCat5+5gNHtuT/eyzF+Kumx5nACio7Ue9KOCiuMvoAj1oTTHFufDQ+3OVZoUJdI+9GX9/dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157685; c=relaxed/simple;
	bh=x3DLjoIrkMICzW71TjUXQimG/xChRAZuZNbVMP/YcBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hy4hHxOJFyOII37UClwvsdhCU5octIqHEfv/tC3hG8GHlQHQWEtee1XDc3JKF1j9mB5SBJE9K95hES2Fni+421aoUxeCjh0/nFHaESTbXXH0JgYOUsyO//Aaj1o+6ZC5+T0HThLzuIcb3IJqqsZ+hMZYVJGz9fbiPKEVD6q/5W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLePvXow; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLePvXow"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39f20d19895so9738821fa.2
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 09:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787157682; cv=none;
        d=google.com; s=arc-20260327;
        b=SkuG1CAgYi27k0QAbCFrBX1PeYN4HgBqg2AZWgQLGesOEgI1PUVRW6jkOZs4gkkLrY
         FBhclhu3vuhurc8IGmXpGpYuM1g1iTHcKWMi+OcEFvOT7NXvjcRsad27jFugvJgxSyHd
         eAINxiSUsWrXOyGD5Zq2GwcagZ6eNDY+5Thf0lC0hvTIVxfUIH/aP5+jbv/Yx88MCmq6
         quMPT1PiU2qzKGsgStsXG8BbViJ/mHMT1JQXFWcKr6hDmtf4gxDiOjt4Qp2lmjqy+Hwn
         1WimfH5kDB6oTTGbbyOOlo20/t2cw4GCZ8meSLL2uOh3kOxOECRNprcnw//jYphb0DKU
         E5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x3DLjoIrkMICzW71TjUXQimG/xChRAZuZNbVMP/YcBI=;
        fh=WVm0YlEoa+2jyKUBn55bKBdSAHoDnpBzEgSFf3VFGgQ=;
        b=q+05aGYGgE/S3IVf/7VCCjDny4s2P+6WZsJclBT7xv+bmtRzrszFeyl9y9MqgHt33B
         0osczXR0HNpsXRHGJegYgrGNBD1Xm0cFLOazSeWi2GDKgyO9uCufGRk3LgLq2NK9xl8X
         iCHEafe2XsxW7lQ0XzkiQ7n83Pgoi4ldevWap5rbee0qgavLFo3bNG92a1yW9m4/+wWQ
         JMSFSu4Y3sEonhghujqktWwe3XUZZK43I6VK3Il4jbuXTaop9nH0I/DmgcucUWDf3pT8
         I10eOeP7+eEBlhW1Rtc58ZxFWiLh3jwAiVcDkP7A1HJQkNLliZVOqNsa3J2KUaeerk5o
         tF0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787157682; x=1787762482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x3DLjoIrkMICzW71TjUXQimG/xChRAZuZNbVMP/YcBI=;
        b=YLePvXowRkrn7s2/QH7Q355ZjdaLeuWqqVfWlZHwdKsuhno7cbt0ck0YV61P7//7gD
         rpi+mPA+pAGZwZ8BKbgbs5m2Vj+XqN9tzS6t4HrG/VFX0lYkYfx8AJPdyY/PODP4SyCR
         OIJTrl5L6g4w+8o0gpuRBNvdO74p11s1ckgFcRq3lFMd4qdwmRXyZWtr4cIVZ8/H6n2U
         WYjNMSXfm1I605nJgrnjO1QsVpx6lPnH4sOhLbRpXvwhuGrZzJbsHVzsUtkIT+ELLgEz
         ZjgZkf5l6jDlrCX4G8sVityMY2gLjngZx6tGIA4RZ7bGC4VLLkH2D2Sh0sWAsHY/BOr8
         x+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157682; x=1787762482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3DLjoIrkMICzW71TjUXQimG/xChRAZuZNbVMP/YcBI=;
        b=d2U4JKOUQEdOeME3Ua3/1HvvTA0Ba4S9XubqUufSySmbz52PjWf3cepe/s63NyALJk
         xuAPDzM6e7MRv5QcDR0dqog1OJ9JkNTiwLC1pSAdVEGXR0hZQWmCbwkpr7zdgIoeBe1W
         ONeqqp5v5j82hlnEuu1F4PghpV+YAXkPD8s6uhJzA67IaO1ksXOISTriAIugoQqnM2gH
         7FLf0cpFjCxJU85cW4cF+B+8llrTG4CTXojeGQTYn1oDChbDzWpRmtssm6Zwc84XGBlB
         vdAurUXY2GbcjFzfZLXwxiLvxF2g2XWWOj9RE4nTksnqIaBGiXOtLW5cvtlkTvOg+mkz
         hBsQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6XwAJPTHf7sQv+B1D55LX7yy5vDLxlRYEFNPZPLLXaH3v++ULhHqehZYIcMs387i2VfYI2ek0@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZajEIPc0W5+B1rUyKGG24SIRyQC0Dnyn8OYSlipPbTgAFtRW
	ntyj1XtluP6lnyZ1jhy0G+2Wbo846ZwLMNoMuwArzJwCTeYQDh2zhH947wghBv7iq3GVaI6cTsV
	J41MEWlxkiU3CYrr/dFmOVL/WeiO2pn8=
X-Gm-Gg: AR+sD10+jcW+eK6+uPoaqYnMZOMxm31uCVZUMgi6f4Gc/CprEYci+Ah51CzaC7ocV9J
	52ZVxkCqn8cJiCJ8gVcwvdit7ZnOdTI0iTGeifWZzgcjahHPC2t2yS4XHS+prki986Eh7RmpdMm
	4VOgC8GcUCLxp6yLhKNajp60URtv03P0sIegMZg2lkrT6ybuvR5yvwwg6uRivTCbTsmFN8Bhumm
	Br44mRtBGcBjJqkdYGxEsvvU2ed9qBvfX6rWUyIkveak2UEz1KG/AvwW2MVPw/iO2aUQrzess8Z
	3RNGqzNdCqF/+d4kQhQ6pMDFF3EOoxR6bw9GHuTn3m62YEZgJuwR
X-Received: by 2002:a2e:a594:0:b0:39b:7cd:e1ca with SMTP id
 38308e7fff4ca-3a1899b123cmr15262171fa.9.1787157681402; Wed, 19 Aug 2026
 09:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818192340.119297-1-boeroboy@gmail.com> <20260818192340.119297-2-boeroboy@gmail.com>
 <CAEjxPJ59MhYLc1ivJWVKX9H_EOvwyGKyaEHvULRWkFq=Xc-Q5Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ59MhYLc1ivJWVKX9H_EOvwyGKyaEHvULRWkFq=Xc-Q5Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 19 Aug 2026 12:41:09 -0400
X-Gm-Features: AcwNN1UWE9LH10bm6tMvuu0tDL8UMhhLrXaSlE_5mDel5K1Z1HUKWeviqfweknE
Message-ID: <CAP+JOzQjN79NZC5E=SWGYE8q5UtJktadfiDVnk7ooijqsdyJhg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] policycoreutils/setfiles: reject invalid -T arguments
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: jboero <boeroboy@gmail.com>, selinux@vger.kernel.org, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 4:05=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 18, 2026 at 3:24=E2=80=AFPM jboero <boeroboy@gmail.com> wrote=
:
> >
> > From: Johnny Boero <boeroboy@gmail.com>
> >
> > The -T option is parsed with strtoull(3), which happily accepts leading
> > whitespace, a sign and, in particular, negative values: "-T -1" wraps
> > around to SIZE_MAX threads, which then fails a calloc(3) of SIZE_MAX
> > pthread_t entries rather than reporting a usage error.
> >
> > Factor the parsing out into a helper and reject anything that is not a
> > plain decimal thread count.
> >
> > Signed-off-by: Johnny Boero <boeroboy@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.
Thanks,
Jim

>
