Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4C4570C4
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946643; cv=pass; b=AUsTcknNSwfmMbHutkzLvhkKt6Qz0l3TThlcCY1Zp+RcDABDRD2O1Z4zk7jmplVfS7TNd8MvXTkU1xjEyQf4w4LFwAua9tSmNpiBcnoH8WYxiceCwAeuz+cg5Zw04pjXurnwNF6FP+R5o/GS5F5dtO3oQUcoLamtn0VzBIAvkHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946643; c=relaxed/simple;
	bh=GTMaB/2ygIhfywO9nroWd6vcxBUPXihEC/5Jv00yZTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5nwfplITA1bjoeMFlshUxC6U1rZDlbE7T1vw8yowKJkyfn180T4L3/8szvMxfa7QkKjGRj5ScWPk3qGv5MzJc0AhdihwpRYAhoCGXgud23uVy6+azAlAabOGnyIaPbh5nIEYads9Pt8J+SA/0rFNsxEAQsb3eGxjdzSXAAIi/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsW1+OwO; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsW1+OwO"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4513435cdd2so499392fac.2
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 09:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785946641; cv=none;
        d=google.com; s=arc-20260327;
        b=jvgosRCw+cU3x3i0UkuZ7nmqMG9IYTd6STppplVQqvdFAge2dkWjAQCAcWrrVYwSf5
         ItsnHPCiqswQX5Ai1tnq9BqvkA7R2FceWg4bCjnYfX+/i/H8yPquHDco7EX4HcfXcpOE
         efgl2EDxJA/qjSKaIybjAZ0cpuS10XrDICECLgf4mJFQBj9y5lbF129pWBkFJQAtRbtp
         vR5+UKayJkK8D2PURYCkprp8L8fHZNB1B+prQNchPALMiZqMFnIGx9ZYeULmpPYkQ+n8
         31B/xjgYd1ZIi1WbqFF9SWwiTNqEbtTcI8xzUDB+KyyFUR2UiDOU03VXrpp6LIk4Esug
         a87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GTMaB/2ygIhfywO9nroWd6vcxBUPXihEC/5Jv00yZTY=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=F3QSvPi14avPS+9TuCgBT7Yrx0k6H0GRTmtYeCFcZNLtc7HXbUg2ML4xKs1Mp5bsf4
         khLMzRRuTA7kkvSPt/ceQhZTrezmgHtoyzClrjZNB4dkyPJ9OY7Fox86q9NZ5yaqeQ11
         YF7rFyvd7YZLB0DMVjUD8aTr+Lb4MNTcdD0y0pbzZBNKPmxFe9z2XQDpkh//c+czeRVT
         +5pXY6WjIGj8ZrkB8WSvheATe4Mn/npO3yY37jr7ciDh0cEhmCs34MugOawKIaENTD4a
         KbR3yMZUTTcTnmvIg5bzUS8cJ81gtqW/1NWgJtnETqXtuGPq5X691OcupUp7DYLvmQSt
         OI3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946641; x=1786551441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GTMaB/2ygIhfywO9nroWd6vcxBUPXihEC/5Jv00yZTY=;
        b=PsW1+OwOYelg8k6XJZqDJrgohn47toT7iJSTBYNv2C3EhuJAxpeWMPYbk1IcZeGo//
         2YqL7oThq+VsoOSCu+KvyRpd+1gvuwvNC34X2q0hg3IK1m4JiHrInmQwL53kBgAiWXz2
         zdNxhSD35zlzpswiT6qqFqTqIfnFhMJiGTrr+/kvB+a7kZNhbXYUA7siQsl/rmJE5sVA
         kz+caFF9uGBw4y/oTnIrrZwqe5JoKPXUiN3iFLyX+TXhyvLCRFwC6SJl4MGq8LC4BmVW
         UUEJPviQ6egpcwT7zCYJMeF8kI7jKzTrQSD0onBip4qq37gE3x3ubiN5Gw48ihjRYqUz
         urWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946641; x=1786551441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTMaB/2ygIhfywO9nroWd6vcxBUPXihEC/5Jv00yZTY=;
        b=JXrj/wUxwVT+xlRyuqN/q2Ossl/pCkqqwraVWnTAvTZQO6oosg+D993OieNoB3E8Ow
         nXQtBdbOZhOTf0HE2EnEey3aM/BU8ctyu0eNNQrXlhLPBNicu0yg3shLx1BDKC+lWl5f
         ZRpTHLEYOCUky0yuHxE0w36sJp4Er3qpe8wfTcQftIEOyDQEo0axhLQHERsnA9X7xlRU
         TLpkYi4A3B9VkUbkmScQGFLItKjqBMd8MbVme9GUfCsFpvawTBEwckDzJ2PGljztsooR
         ef/rxuwEI3KQ138enGY1WpTWP+MI2yJZx/+mBEwbyM5cFnKoTosGBtUvGCIuTGIDYxLh
         j0Jw==
X-Gm-Message-State: AOJu0YyV9iLjKqpUHCk6HFcayHNDKp1mt5XVlQuf5wL+7FTOuNmk0W8X
	qvZbDmlkyslWohwU38Y5Pv9wjsthPe+lTTdoxtaznSrc+/78klmWC+qXNeK5u3Rtc37Io+oN41/
	Trl+loagPL08sI/R+pMgxPmnuwOxazltD+g==
X-Gm-Gg: AR+sD11rtV9jKAhWHtzvaicnQyt+OckKonruuZm4NxG4CDd3rYRTyo2wKCx6eMMH1wP
	ZlaosisvpTeBYc18lHpxN0Ju5pNBe3wUxIAkjSmeQLt7RqNds/U4jeOiiQ4tMzA/GTMMJXEbOgi
	x7CDtKm/OsloIeVjpK2rvaxNv4YCtQGe7LoT8t4sUiExFWiqi3Wg39OH3r419+f10vSJ9j1JWGd
	P+8tuCL6nFFigw1HbD18Tl5PMUYbE+FCNMwPGDNqYEAQWSSnwonVGGcozIzWwief0yMz3ZshS4G
	CG7AmwW9KEal9IPvqfIVRoIWnHPyqljWvMiS0Bb5bSzm
X-Received: by 2002:a05:6870:d40d:b0:456:55f3:b8b with SMTP id
 586e51a60fabf-4599ec98ec6mr4073034fac.5.1785946641237; Wed, 05 Aug 2026
 09:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804160806.21979-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260804160806.21979-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 5 Aug 2026 12:17:10 -0400
X-Gm-Features: AUfX_mx3R0ID7GWnmKCLIEAu6o_rJsc9Qw4fl-FgqrPbfegZYW2wAt1T8oQazmg
Message-ID: <CAEjxPJ5tQZ=bdaSe6+QyPnPP00xEj=WpzTs65QUa9O156ZZdVA@mail.gmail.com>
Subject: Re: [PATCH] README.md: add Check format badge and link
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 12:08=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Add a Check format badge and link for the Check format workflow.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
