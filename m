Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8A3E7633
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340535; cv=pass; b=fB4ApnWmpPZeqRuNx8PdWJYjTXPFuYI7gC7BAxTetTUvoa0prNAFYWefvFPlGdB4in/Qu6VL5ns0raY+9c26meBWQIcOOnviszj3DhqL+W7yA7kJ8cu5q/B6fyLtDFI+fEcqQh2Fylp9mZ3XfI6v33SVljmRendsgZ/AAODGQWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340535; c=relaxed/simple;
	bh=fCD6wWEkT/yxPsKCWSjug1RNk3KS07dlkJtzyenA+DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeJuYueGp1Y26ONk3FdyPG6ZlcH45Bc1L6dSrK6ilfJQ1yInP8vEEuqjnLaHKWaMp5LpZMeyeXPi0bTWP+S8ULTpk0llV3VScB5evTLyJNTi1AC0milTY70hTPmGmcdxvHGbEE+7i2DgFdON5O5zM544LhDzdwj/Pa6Hv6Dw/W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rrBG9kFB; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrBG9kFB"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43bf9548df4so668281fac.0
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 08:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785340532; cv=none;
        d=google.com; s=arc-20260327;
        b=OHb0I1puKv9ucOi+TDfXShU3fYwVSZ2FSXih0WG1KVHKzAn4QeH+3P5M5ncHVZ/g2Y
         VtEO0k71fK264eLizmpduj5qmJ+Nl/9LN+yyvyuIQrdY1G+ecHcyeFWt5etqPCDBPIF/
         MqOYQdpyHnXlMBoHtVoQ+Ka9lvuADVLFFmfLjKcGMJ0LNFsThAM+SV1YWM/QSGmsBrRP
         zT0pN5zCget050pMiDDCMxTJx3mnrSOhmfcIL5Jdt6VgJLBMrbNHdG4yo34NhzN9KkhC
         q296iYRFBDLNP642w/3e1FG8asBsVIuemTqoKr/In4JTBfO/uxQEnAwnhNJ+pSbqBSnB
         sUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fCD6wWEkT/yxPsKCWSjug1RNk3KS07dlkJtzyenA+DY=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=oIminx35GXD1O1sbPvk6oLJv8ekUdreJ61a3Ru5OUmo4pVBXHyT2sufHyR18sM0tdW
         krLCcSzcFDoHy51TP2rgquV1FCmkq/sXMoPdipawT0SAJCTLm6nSC8xk2tCdqgLh/eRi
         JN15ldcho9hwaPeIjqBbbUR6vTNMSJsjux8YGWdIGNi0OaLpU/Kb4csIERAOcInBXq7A
         P2n7B4dePCSyi+3rwLvoCSX34z7tGInuw+hWM03hvF80tKon2nymvTKvf51o1xIIGnLt
         WhFTPJ3MW22WgypDm+XRTTuTNC/5xUKYW9J3dxb6ayVGVZ8PvXabb9I7J3qirkwhxHVG
         hQYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785340532; x=1785945332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fCD6wWEkT/yxPsKCWSjug1RNk3KS07dlkJtzyenA+DY=;
        b=rrBG9kFBaRvvaJzZOkvkLzZrwpHmVmquGLvLdsXpCfJQRxspkLfSwwcBh7wz3Dwozo
         lZ4Ft+D1fVd1eWC3RovwzF04x8F9wzowFHtd8f2NONbc6lVV85G699igH/xNlN+OFvTo
         dJSahJ+RqMENeZJ0eTyy5jgjxuyKOq1MOBLBHGyjsCnxwWc3FqI/WvoKAizKe0O2vS8U
         F5pcWutRWuWS1RxHagUhBUxsvtlGjTVo12NrNb91KyQbjC3OQkuuy6QRvVWCeV8ir672
         ExgzNEBvO0fu6WOI2BMOkiBlWUoJB4fE/2xWUwNo110697QSPhBeGvOeQHxsQYUc80UK
         ZQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340532; x=1785945332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fCD6wWEkT/yxPsKCWSjug1RNk3KS07dlkJtzyenA+DY=;
        b=n7ll9T9leg+FuFfGhyknSQ7DS6HnRdbcAqFGxxAl+h5WA/9+EKYhrx7GLwwlprSpEH
         gzNrgC3G2N4M3mHnl5UHAlMYl/cUkW74Q3LyD4MVdaD+lxwfjhHAbuy92sAe899rhnnL
         utQ8rydG3nl2Da+3GKCjm1NbcsTHv5XWcbJEAv71n0oG0iXh4qK+FF1y6bnlpSDT6wfW
         bi2j5ryJCZAXY562DElAIYiC5fOpheJyJNZYhANH8BPjOdCdDl52cmCtTPAJAHq7l/qz
         1h/9vGEe0SQEBngUaAtpyr08h6DKh0w6WQhLHGXod/f4xeoojMLqCXLS43XQnQ3RuOi9
         KIaQ==
X-Gm-Message-State: AOJu0YzViGH5bKKGWw7jJOYrQUSSzzsaKd2rvx3wspT2nFj1SMSH6J4W
	64fCOZ6RxHIJU6V9dOg2SBilx4hynx50fPvZs2jJX7HfSc3viZm9RWIBDdH7WxwoQJjABY9LJcD
	waR0Ms51I+z7w1ToUdn+T4CNE/1U6k+I=
X-Gm-Gg: AR+sD11UyZJH/N3OzI/morW55uELjVNspNl9QGN/qbt7PYPI6UrIa4h/ca6kwsYbNJO
	4u1gpeBBaA6gK3C63Dso7+m6sYJEraZMFkWEg/UrcraOPxPxx9n7c6bu5AeT8fTMCIzYddI7Rqa
	jC9iS9v00wM9y2wwn0Bcj1cCRQ2Jw763UacLpCTQ76AvLgjQnRnebfIm6x6rZESW8O+xUKFaDB5
	JgB4PJVvUAS0TXsOadQs3BhxFFiNfUkA7tv0jPdthfSerILyML4m7tzM85rNl0X4beKOMUdoBrh
	A67fpZPEEhMin9UCKCMTjS+JJfcUgnJcp6H6Mi39eccI3MDNzImRN4vv
X-Received: by 2002:a05:6870:a350:b0:448:558c:d82f with SMTP id
 586e51a60fabf-4586cb907d5mr4233113fac.40.1785340532607; Wed, 29 Jul 2026
 08:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729131413.1390890-1-pmatyas@redhat.com> <20260729131413.1390890-2-pmatyas@redhat.com>
In-Reply-To: <20260729131413.1390890-2-pmatyas@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 11:55:21 -0400
X-Gm-Features: AUfX_myD7XamaA-JGeO1NAvQ7pOL3OHNCyQOlPkQ3R5itxeokgbe30Mu2A4A7hk
Message-ID: <CAEjxPJ5HrRc1k7U9dRBLb4mHbipxigrAsySxov=UncHndpmKpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: fix infinite loop and missing errno in
 partial <<none>> lookup
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 9:40=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com> =
wrote:
>
> lookup_check_node() has a do-while loop that iterates over matching
> literal specs. When partial=3Dtrue and a matching spec has <<none>>
> context the loop body used `continue` to skip to the next entry.
> In a do-while, `continue` jumps to the condition rather than the
> loop increment, so `literal_idx` was never advanced and the loop
> spun forever.
>
> Fix by explicitly incrementing literal_idx before the continue so
> the loop moves to the next literal spec as intended.
>
> Additionally, set errno =3D ENOENT before continuing so that callers
> which test errno after a NULL return (such as the selabel_file_text
> fuzzer) see a valid error code. Without this, lookup_all() returned
> NULL with errno still 0, violating the expected contract that a NULL
> result is always accompanied by a non-zero errno.
>
> Signed-off-by: Petr Matyas <pmatyas@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
