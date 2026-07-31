Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981D36196B
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528299; cv=pass; b=anvmFeobX8mkFGMcnkAmwIRu5pxZAsjdYbwRb5vjlC3N0c+NAuyB9c9Twe7yQg2O+MBfA6G9vx31ME5kkEofoo3U9zRXRPZPRqGwJyUapV0U6zW7sSMEqvKLwv+I90I7H0tfGHa3blRg1WVMcKgB5dQXbD9FXv798uOWvpYxJTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528299; c=relaxed/simple;
	bh=DcDa7+eFT0fnXInK43/dS+49fA56DyBBplSQMcIXzc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFGEkB9IPFCAJuWEeRRIZ37V0xa1FH5HlCyFwi625PfP7ara185dWq4AOz63YO0btIUj8zEzW7fgU+LZIpErC/igVKpyB3T3Jq/ptcDtGLyS04kI5DUKw8R1W2jOSOF+GMMvk71vegySAS2imUdJEEP9QiDJZ61Qnwo7SV4vxX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/y4qTVi; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/y4qTVi"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-44cd237446cso999060fac.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 13:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785528297; cv=none;
        d=google.com; s=arc-20260327;
        b=T8th5vYvRpfIArw7w51u5e27LXmatHj5BxYwa9388MmJnjD06Mw0dyFG//43a3L9lJ
         p2dYFTrnrifDstsu3gZ1Qe6EKE5MFfU6jw6+vf70NHJew3Vu85ph3o3E/5Dl9PkqTAJ8
         UgFMzOfvNj5areWgRBABui0gsRk107Zy5zchbJS+rAkxplHiZeNOUt2mLuvAO1hNQSEv
         R8WpeqhmeZKW9oipuZWwB8tn3ktnfsUkJP2kCeA/7EagOov554/EQh6yC6+ebvwjpCIL
         4Xaq+igz3Fvl9p5Fd0onWGKEca61NJz2letE7Qw5T46Jjwdmsv34TVF5SOMUSLeA7sme
         CxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DcDa7+eFT0fnXInK43/dS+49fA56DyBBplSQMcIXzc4=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=kkGyZUcwxBvfm1yoa5TrrN7OeO0e5I/F1YvXsdhaAjp8wNcVrS5NRjez8XzxiiAOSW
         eDQydxNrO7Rzv5E2UiqdZiVMyn/IcsaXVibzdbRqwPfuUudABSA7tNPexYUMuxYr6TU1
         QQJWRSNz9VTr6njALIype8FpoYnoW50iveBI+0YcdPzcZoipq9Vvp9jWERZDdR1ZgB2F
         Qu8xQctuqh66Q4lKz31tAknqZIMXvE8XapKLiG/5t3XoQsTIztpTjn6FGU/kUG1/NGFw
         8MU+L17TPCTx+EyVP7NhW9hTdDiC0HxadIfQTrEA3exHLYGJVGzgGVTaUiKkqlGV17jT
         tgdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785528297; x=1786133097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DcDa7+eFT0fnXInK43/dS+49fA56DyBBplSQMcIXzc4=;
        b=r/y4qTViMRrQaZNf9wt1bvJoHDHdSY7S7dXazo73WMwTHIMk49mn36w0RFwsfxaz6Q
         hPKmQFy4cc4Inol5mCAWBRtPjOYj8gfcj5HFBslXcYm4XmWqVjlIUFsnosG45CTIWnar
         2ofqmQgeF+HTSDN/L0MWUOvMtz8zcavyaTjjhElWGvKdxH1p2qTbXHROJSf+IPZrExTu
         Ek66mu+IgKuZxy+Mm/pEQcjxgYE++xm+2laHj+paAF2GvAI5JQRQC+zyekXwRRUWGaRy
         rMTpIJrVaJMGMPvcy7qkCoVHUZsS/n5ovHSXtsI/hFr+xPAmyg1Hyu3nNMv9kT+tkw7M
         m+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528297; x=1786133097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcDa7+eFT0fnXInK43/dS+49fA56DyBBplSQMcIXzc4=;
        b=fNBAnjjF+gIILaDPMGwxfJS1I6RzDLL5ksK/JEDY/5WztNaYF+fBdqpYzgaH6s+WdW
         k/j0ce/zOf9ISyQfNnkDy0TnrQWYVa1A5l3zgl7WTU4yrq6vGXns2twBRBlonXcxMzDZ
         fj86oA/xvs2sKfOBbipejvGQGV/5wX172MeWUjvyBMxMbPgKGf1Fp3eMdd65tk4xj72q
         wzrxTAiwWWqPPwnM7pipCJkdg+wfp8quZgyjUsS/7vgYiXBD/IFs8gYCy4mHRtWm+yVl
         vZJI4dqR1CkkgGLe+Mmyw00aKzJDkbrbqybsLi2+0ziz+fOUG7RCOZJvJkB0DHXoe/oI
         mc2A==
X-Gm-Message-State: AOJu0YyoSZqAQjOy7ZI/glbFS5LpGdILFLsGyTbFkD72u7JU2YxVmiMG
	auWsWQ4ho4GmNxbM3e4sYuW+uK27urc7NyLIj92jJOoxtBHJcshrWeRwlQcCjtxLX4WuAEgBeeo
	ILUzEf+AIW730UTUi9rtXLSfLfSQl+6M=
X-Gm-Gg: AR+sD12Kim1F6ht2XRTKwK/CHCUqIrBalRyZPGZjwbyS3VumG7LNk+Gj9fRxx+kFO0T
	eCT94JXUj5YE2yv3jdvHyTeJpN6pHtj9UUa69C4nGN998LLAxHIEPn83ipZBwoy7j4uWWH7t1oj
	kRTqqMLQM+N1a886gWl1HWjOKIKzGOEnwHZJuwXVcRPAJQOiEsI4LBs3xTMgCVdbJE1tkax6SST
	QmwaZgCXK4PTdWQT5WvbnUrrCghPCvtmJEZUR7cdMUGW+lE2X/Xfw8Vg6HXSSpy4L299G6M9BiK
	uQ4vdNQhphYz477lw2rayiWEAqf4xTZAo7ENs2l6VbFU
X-Received: by 2002:a05:6870:7258:20b0:459:678:ea08 with SMTP id
 586e51a60fabf-459067979a1mr1907321fac.8.1785528296757; Fri, 31 Jul 2026
 13:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731162033.19084-1-stephen.smalley.work@gmail.com> <CAP+JOzSGULoBDEv9unxpF8V7uj+DgJndA3Fsxi5e8=m_Z5Z6jA@mail.gmail.com>
In-Reply-To: <CAP+JOzSGULoBDEv9unxpF8V7uj+DgJndA3Fsxi5e8=m_Z5Z6jA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 16:04:45 -0400
X-Gm-Features: AUfX_mwDXyMsxhaGLNj33bb4FCJj_KTrpTCaR-aDTljJRmasYkugJ40UC_j-3jo
Message-ID: <CAEjxPJ7UF-H6pWdANUmEwgByh5q4c9jpdL2WK5zbWe9dqV77Bw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix direct leak in user_extra_to_cil()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 1:59=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Jul 31, 2026 at 12:20=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Free all the strings on the exit path.
> >
> > Reported-by: oss-fuzz (issue 539257834)
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
