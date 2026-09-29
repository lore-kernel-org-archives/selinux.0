Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F82D7DC6
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697181; cv=pass; b=LSG34M3Q+98OvDJS2NkPCPQW+wmg9LATp1zfcrLaCevtRYdXjaEuw/YaauLABSmw8Yj5RxqwaJhJ/rMaVKeZFGtEsfrq2yBEIWaUqGCcZoZcbvRwWS2cSp3HyTqUBHaOiFAPDpQfrqUMemmy0wNlTfLoeSWHG0rpsSNNER3kNoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697181; c=relaxed/simple;
	bh=AQCGEaXnVmlV8zp1bwWJu50U0QnyIiblIFblhAEZKvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p00ZDIuDrlpCJ7/EDnaxk6npeCp/bWWTXwgN5/0tl/PGYDYSCcglmFbYMryKUSRHg4g5ZhknQ3uyU3ZogvdlD0uE4HiCyKIsvFy79y+Gns3g5VBFPEHyn7hisE3lLN5f4n7VBi1fgbUY96L0miBGOAhDjP8I2acjDMoN37EDk4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ15ygjJ; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ15ygjJ"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab441c70f2so6905357b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697179; cv=none;
        d=google.com; s=arc-20260327;
        b=C1iLPoHYffDvRpctTuO6NmvOnSU9eUApyyTsmE4k+6jrg1cMj6VvGmIBK7GctS8IXO
         KWubSZQjmoyvVM5o/0Qhg5IPGzmv5Xzximw94p4wrl8m2fPP8rWIi2OJbGV1HXiyrxxi
         akpcIsbyO3Q0RXtpxLI+JOqZdO0VMXHeBAa/xG6ZorpCzVK2UhUrZp6aUJ0nyfKf0rLM
         8QgxQfKKgdtBP6NPpxa3yUshjKxfYFpWiAmLLTpHQMi1ydOGjMS1UDemSaxhoeKBLLwg
         4z5N6F2yADJLuhyCoCsx/iuQIsForjXIBYv5e/231xM4hUgI4qeQVkpdPOF3PNnMP2Ep
         b0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AQCGEaXnVmlV8zp1bwWJu50U0QnyIiblIFblhAEZKvE=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=m6Kacf/wMVMIlfZlzPe6Jhia6+4hpWNgHCkE8uwuYH/cLLmxatlMrHMPVQCTL9Go9w
         79itXk1Nd1SLhyh3r3b4TITc+1aia+PjxU481NH+rTRoOyYeDGk3VNe788YgeCx8OsjZ
         yLrddd8KPZ0mJSR/ETzq78bJEWqReVkjXK2HM3MJNi7IrXOsORW91kbbnebdQ6qLoM6T
         qcXA+HW8OkfEHAzL6hdg51RfuLPChYg5OtFc7tVbCOXIHuuAlqOxOcOFJR0NFTwmA7nL
         EQJRpYXl8wqeMJNv5rCpnt+zCpQKdM4DwLz13gJofoiFe4kukNvlQawII0IA6xyZGSpl
         7LSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697179; x=1791301979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AQCGEaXnVmlV8zp1bwWJu50U0QnyIiblIFblhAEZKvE=;
        b=lZ15ygjJI1ZCReWL1kzglGTINH9jQS1hhfTxUIexZscAfheqHZxhmQs8OhHw9VqBkb
         ewE2y3YbDvKgyKrtbKu5x5VUORuu5OIiApFKxKCMdbyYt84kWmhr+HIo6wtbL9TZmZvr
         /0ZmDx8iEoNNEDmreBzkmr8iRzsRlRCL/etAHiMRcN6GyoOO+zN9d0BfHsc7b8Ei1Ce2
         oIptmvuHSHfgOWLqYA3sSgIWemSn4ib+fAI1R9fQ18wYXXtSlHJSv/0dOTPKj3SLY5WK
         Vr7x3MPKIf3V9HEePJo0h/jw6eESftheuiOdD/khVvv0kNp0c7d//+fN6J/SRVLykLy+
         W1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697179; x=1791301979;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AQCGEaXnVmlV8zp1bwWJu50U0QnyIiblIFblhAEZKvE=;
        b=0c9dfw8LBlFhkIfh3cFh4wWo8kpbCucVkzR1yyTf4MiDF6V/vLa5cLhyJ3HrMF1UWG
         CK74UIH8UkmJH7PIGLhK7HiX8B4tJGA/G/d9OiznkEtXh727V8Ms3uD2FC8NFi3Zhj3o
         qrU/DQAbNhsS9reZZOohdaIqkLSYowU1Da+3UBceo1MEEz/FY/mWHN8FBsO5vbGlP+Kd
         fiQiZpr+aRlGSYzod6Or+3t5UYjf0Oi8eJEIICd2+iNUi2WIvB6ofwt04TaUEw1EHlZq
         QJDdWsy7zdxnIH+p1QSEOZI0rHqypMbA279H6xamgtywZtwoNQCsaATM8e5xgameDrQE
         V4Ow==
X-Gm-Message-State: AFq9FYIeMrtf2gSYkSDjPG9hx7PQC188u6hKXb5JVmYxJFUtzuCHjGgv
	D0wXJcMEXQgL8IicerozHDC5uv1Yiyl3dN5QBUlxFvOs/ao3bRgNOYb5tMjJMHNLGdl1Ngfqfoc
	4FBDVP0czD8ZJrISVzhh7nqV7kBbnXtoEujSy
X-Gm-Gg: AYBFou0+9QrIeRDy3Tu/KyJO7vntZmQl4hmHW8BLHk4OAQaRjtoeTVZ8nSZJLwfMKRU
	nsVqfXffNPcUrEoFaKAsWKNjaAGC4ghG0qwWnxbiGw8edfPk28rebi/1H+JTi4D4ml9DUdBkW77
	GjgB4qL3wmS+LkXI3A5m8eZRZG2pZ4dyRutPGkMuuhWNsd47yIkpgJoYFddCCJYrA0CDgmnaxsQ
	FgxXiMDj0qLFlF/lBGyfK+3Ktu7Il7vAr/2GXIHFIdGeisBz9QCjnxBQR2yI3cna5i8MwyTnc8S
	rkpL+fj4hRca2JUvIPK68LtmQ5FbNw2CwkME13rrZCH7sBEiD2ywuEU=
X-Received: by 2002:a05:690c:4:b0:873:5bb2:6bfa with SMTP id
 00721157ae682-8a64d4009e7mr82537307b3.36.1790697179035; Tue, 29 Sep 2026
 08:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-20-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-20-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:52:48 -0400
X-Gm-Features: AclHuK-8ayR3A1COE8Rg3E7mWxZm9p3DrVBzErPlDtOut8BNkhsW802YqYwcsoA
Message-ID: <CAEjxPJ6j7JOknwOos8oh8_K6MVmYV6UBTZv-vYTa24GVhCFhrw@mail.gmail.com>
Subject: Re: [RFC PATCH 21/32] selinux: simplify mls_context_glblub() and mls_context_equal()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Drop a no-op goto and a dead initialization in mls_context_glblub() and
> use mls_level_eq() in mls_context_equal().
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
