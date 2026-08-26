Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD363AAF58
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772963; cv=pass; b=dWRmS39sM34mje5UCGhAZqja02jSKwjbLcsnsuaXZcjXw5rbgC8UlGf0zMp7+tc5KKXOF6vldgJ9Vto2iSFFMaGn9YThJuUOk+b7RPSD0e6nMuquesosBzwKVTqppbbKSiqbbfprvCRfnm+HxWPHIq7st1yun9hODMqz5mQuQzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772963; c=relaxed/simple;
	bh=PSoz09ezn01Bis18XwavZymJFvUpTnzkgY3ypMMU+rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTGxhegxjousvx9TyPqVwQKf4IKzNGyIbYWFk+XN1iZaapvUFr/AkFgUXdMXyMxpd6iER5iakU5+lVrNaarC3g+VhOsAi/uL4WZc17xdOBoWRNZOV/GSrbd0fFCQdJLvvkRSaGAG59z3V81S3900shrTz5Tsi1zXMvLBwDEFv6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4SyOpUL; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4SyOpUL"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a1f792efd0so11965881fa.0
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 12:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787772942; cv=none;
        d=google.com; s=arc-20260327;
        b=fE7uvca1sMU8kTLKld6Eka/ADrOgKFSptBn4dNvY+Ky0iWYHd7Yzh53P7s6SuNf+lI
         t4K9KrQNn94344gNpEf0sKRSJVog1WfnZrCBCH83lKouKgNb4NfuXfevwepuMtr+2mE3
         qJrAaH4dyrZHKaVB8a5AcFkRL196bjcscMuH16Rq7HOqlM4Bq4fln7FTbB7rLdomSXR6
         ltk0qjKHJW2Bu7WPC7K97Yl0vg1sSGJcoDabZdpUpPmFp1oL/gZSJ6m1AaO0FIaPEgAx
         ckQUpqtd71rajVianry7sJQvLONKswbEYX5huIYPaphS9E+43CxJ7c0w7CMaV8K39nwV
         F+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I520HFHHaJiEtcqZEy6I3lQ4jJxANw8YE6LiH+Fqw3Y=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=pqNRKQAN8Wqk2GrffMmuri1a0xHnSZ+cpZPncTQYzpZSbeOvCdoV2TxJnlJkZHoHKP
         b9vR9jtH043qujEkG3dXLxyDRVEbHXw7nPA9ouNcVhcmeK4mxuHLpxlITsMHtYEAaJmn
         FgutMC+W4h/k9FbJIyTpqjfAQG8M9kuHKzROzVUB/fGI107siYQTM+gvGfkGUHVkpzmb
         MaB4Iyiz7NGPNJD4bTcoJgw4FEzqGv+k2UbHtWzzIaPa7UimMgm7zj22F2af6erMDOBU
         LtFp5QAhkiJt/mz9ctFhoyzODHWBk1qbRF/RCoQqWZQc1uUyhebHCeUgxaAtIZOEUPxA
         FgtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787772942; x=1788377742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I520HFHHaJiEtcqZEy6I3lQ4jJxANw8YE6LiH+Fqw3Y=;
        b=G4SyOpULmOueBx8ZNEyQ5b3XiL2ln7OZjbKOO9D1+FIKJvof1ATWtQWD7gdeiRg/IL
         IOxdI1J3JcQwurpjBvgLx7g0gESFxq1auA+ng63hwP7HM+Cj/YGLhz0M5nujSM7BMora
         XHsMF/5SbhXvRi3u2Sw7t+ax/Vb65vss59DCDK/eLyFkKCu+GxfBYfzEjN/NHQVbcv6J
         43OlD2fDKbelEmU/5zECECdhkFOjHe1X5gbbowiip/lpdjKgp275sfBddLqu1ydW2pso
         le+ydQtxcTZAgYry9Sol+eyxOXgJbT5yBPY12V2kWEY6WhSRn/8kfL8ntBf1YWPCEd0J
         YfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787772942; x=1788377742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I520HFHHaJiEtcqZEy6I3lQ4jJxANw8YE6LiH+Fqw3Y=;
        b=LFKmEvxNgUMP2qXjl53BDuXM9TQLQy4yC5EkeMzyUGrP4geVi67Sx8ra17/ak2MGag
         VoJpXuIl4wUhErTfSMaZFt8rxg7JAtlAXwZeCzbCydjVdzC4kgrGuhcxcI3MKhtvJXDA
         cVuGaXgONvkkfdSM2lLbXhwSxraZTi6mpgb/6NP096I0P2QLiyvtCAsODiaLYUMC8iOO
         Gafp+5GRoVSnqGSz4XQ9S+62jr4jqc1nmDsDyedFFDy/PamnWeUmp9u2aT6Mx07zSAv9
         pXVGlEC0LQnuappzrCFYTDBmBWzGnXci/ppmM05PTwr8aIhhgj5buxnlxukd8fu99vex
         RHrw==
X-Gm-Message-State: AFuF++m8zw0vx4YTDQcyDIRWQ49tSLP8J3b+JtquU5M3ttX2se7gzKWg
	xnZc2/QM2phM75ddX7j/5I2XaaIy8DW/8vzXgqpRpFEjh+oV6md8F3fRok5///VgD8tkPEs3oRm
	HamIBSSNJc4WqEeM4NfcW/gCxMHNIrmo=
X-Gm-Gg: AR+sD12e341XGfzhTQ3tGcmSK0uz/+9OxyPUeWDdbNQYc9U6vJwEiJsqjQaM2ND20VS
	RriZJymquDhiOEUx27Zzz5/HHaxv9OYJM7LBNZQTPfzyVh8Q/4v+52GFQq1M4mEBPQ+KHSuTIzp
	5I5VdjyvzQ7iz+yuKctLrcu1lv4gnpI0Sj+fMf12nTXvzC2NemS/lAkezdH+8t9kRXBSF7eZOFx
	ppbA1PtzlU/2M6KafE36mSqPyhow0f9FNSlrNc80fVu9SqbtukBW2UMRHH5FSXKB7+0ncxDwS8P
	mVHUsUp3rqZzNiLw9OeDRtRrAKaK78eLbDfnElmLsg==
X-Received: by 2002:a05:651c:31c4:b0:3a1:8dd6:aaf9 with SMTP id
 38308e7fff4ca-3a1fd65bda3mr22887651fa.8.1787772942154; Wed, 26 Aug 2026
 12:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826142323.2504-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260826142323.2504-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 26 Aug 2026 15:35:31 -0400
X-Gm-Features: AcwNN1WyVveCS7yQMYqGRdu5lRaP7npdDw18KvO3cOLpqnzZGGTc6ABmGvlB10s
Message-ID: <CAP+JOzSyeas82szxmCs5uh+Zg6vfAyRCdhvzCtJCPbUMyUYbrw@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: escape literal paths written to
 generated .fc files
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> sepolicy generate generates .fc files with user-supplied literal paths
> substituted directly into the path spec field. Path specs are regexes
> so a user-supplied path containing any regex characters would be
> incorrectly matched. Escape any regex characters before substitution.
> Use str.replace() instead of re.sub() so that any escape backslashes
> are not re-interpreted.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy/generate.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepol=
icy/generate.py
> index f88d6852..78ba3f13 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -1092,12 +1092,12 @@ allow %s_t %s_t:%s_socket name_%s;
>                  t1 =3D re.sub("TEMPLATETYPE", self.name, self.files[i][2=
].fc_sock_file)
>              else:
>                  t1 =3D re.sub("TEMPLATETYPE", self.name, self.files[i][2=
].fc_file)
> -            t2 =3D re.sub("FILENAME", i, t1)
> +            t2 =3D t1.replace("FILENAME", re.escape(i))
>              fclist.append(re.sub("FILETYPE", self.files[i][0], t2))
>
>          for i in self.dirs.keys():
>              t1 =3D re.sub("TEMPLATETYPE", self.name, self.dirs[i][2].fc_=
dir)
> -            t2 =3D re.sub("FILENAME", i, t1)
> +            t2 =3D t1.replace("FILENAME", re.escape(i))
>              fclist.append(re.sub("FILETYPE", self.dirs[i][0], t2))
>
>          if self.type in USERS + [SANDBOX]:
> @@ -1108,11 +1108,11 @@ allow %s_t %s_t:%s_socket name_%s;
>              raise ValueError(_("You must enter the executable path for y=
our confined process"))
>
>          if self.program:
> -            t1 =3D re.sub("EXECUTABLE", self.program, executable.fc_prog=
ram)
> +            t1 =3D executable.fc_program.replace("EXECUTABLE", re.escape=
(self.program))
>              fclist.append(re.sub("TEMPLATETYPE", self.name, t1))
>
>          if self.initscript !=3D "":
> -            t1 =3D re.sub("EXECUTABLE", self.initscript, executable.fc_i=
nitscript)
> +            t1 =3D executable.fc_initscript.replace("EXECUTABLE", re.esc=
ape(self.initscript))
>              fclist.append(re.sub("TEMPLATETYPE", self.name, t1))
>
>          fclist.sort()
> --
> 2.55.0
>
