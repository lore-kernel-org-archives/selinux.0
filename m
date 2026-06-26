Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6513A2C11FA
	for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492681; cv=pass; b=TriZExGWV3KO9eezAxQFY1JpAYCKHjSYKa2vCXXgq6c3BgFcgfj4GJ9AbwHDIucCRfJeLBIoRthHJrpwv0BjgntTXS7r9D9sCVy/XsQNy7snaAnbRDiD/C3YM66kWv9eLsgr7wf6y7vLqTvCKA6VxiDgDSF6VEqsRmGowuZ3pAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492681; c=relaxed/simple;
	bh=/a6jqXQ2Eby6DbPWC/Yu3EtZw/H7we28nK18Ok8W03E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=c3jraOjriCpiUPVtR20XspmL18Y7/ytUXOVh0w5OxMQw7JXTCRD9buLrzCSzOQw4BBwDbPw3XANTo/s5lx3zpEIv5VzOhm+LSGliqKpT8GcbGVGSOBFlvKpxoNNEeq88ct962NTGBzxy8PTqcL8IUGwzlot5Pu0C0XcuX8FbfRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QGQcg1hQ; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QGQcg1hQ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so549128a12.0
        for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 09:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782492679; cv=none;
        d=google.com; s=arc-20260327;
        b=bNbduhhekxr+KbjAIrgLOGzG9sk0PcNIZSi7VYdab5LdIGHYgsv8FKUJ7BiSPbtDBS
         /4+H1EWDUhXF3TK8uJIH0qJMiRKm0ZKDsD1GhEiK9AVgncsZRFmP5FVl/DbU+94dzY1l
         nQfOYST6Pa3T8qcvrxGmO2XRAHlNHqXPZK+djXTD8NnJzf3UyK0bhFJ+wWuLHz31DwdP
         iyj148OiCHi95lnyDAkyQQ2M4iwMqSdqr1SoVqyGvG/V7Zg6zil/vrVzeB9bICqaBjBk
         48IbRFryMHDxVjWxhqvc8t+xeKoS7YVqOcPiaZmklYMtKx0TeoS5y8t76WRQm9YuMYO+
         tTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bMNAG7v1r2X+wcZQVAuRR1By/m1IteDdb8giSnrO7eY=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=U4EeZ6zoKbSmUt+Ze7NSdMkiJFzMYz94yugwvYP/AC8PNV0a1DA8mkTaqsYgjzqeKI
         U4DK3rHaf9sVMBbCBscdfGOWc/YwQdS9GAJ82ljY0nkNUtdp4BBLi/1/LRYwp0HXIEtg
         7GbMnk646QCVnFAaGqnJKFYCdNBhxknca90ORjgseB5r61Lmb/w3fZjULsjqO5v7jex7
         9t2+IcRU2vlhGERYwbeE5iHU8ubUfGHaBpRr+Zf93AIPLK0lyWCjPUAZg9MdS+ZXSC2I
         nynO4HiIRWvYjgZuchREQDJEGYqP/tysRySV+32XaeSYY+e0WtzPuxL/klZYybNVVFse
         73Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782492679; x=1783097479; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMNAG7v1r2X+wcZQVAuRR1By/m1IteDdb8giSnrO7eY=;
        b=QGQcg1hQY0z7HEAuhwrIWhvwOyzSjtBIT01k20y0NRUSf43Lx87M1fwk1KZOw6SsWm
         MF2MzLxxyj7LuWD82kp2Glw7vfSSZ8lfmZrRB2io3uNXq/ua7hjWjP+3MGrL7LOTf9m6
         oTj0jey1dr2fxMK6c339vhsO83rF7kHDfjh4JNaVUy5KveeewItjVg42rRn4r69fxk5Q
         9JTkOEu7Vkn8YIH2I5E9uVKF1KGvbcaeRCeN7E6HGdO+Gi/5sBE3d7A9dvGQi/OTkVpH
         VUJni2AXcBZA0SdLhthsjS4bFZoAKZhjmCHm7mxWtOYgPgg7ErVcH4gvDGwYSxjfoyu5
         dVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492679; x=1783097479;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMNAG7v1r2X+wcZQVAuRR1By/m1IteDdb8giSnrO7eY=;
        b=EraLCo8of1kSGpW1+G6dnTS6R85E/A8GQl0Wel+Vwvw3fis39IYklEM7kFGDdi+Lhu
         ZtT7Mq0aYDXtC6/V78OfX8GBkS7ckxarlSkb1ZvpNDHY6gKpp15dG8sLb+skmHuq6k+P
         QEYdIX23EtT1xkUF7nYCFUevEs6dpdxQhZUZ4MHHXySEniRppUKkjV8LFgvOT1/ov1Pe
         dmefUIeGARS3S8fUS84wJOCrzhWad2x90je4vQWirZ5KMzjZtbYSWAG8vlwyVtJTbjqf
         l1sXhQRGBn5P3l0qSX9+2bbucvhoOCzCZXicw3vQ4x2d2OJGqJMkNAvO7VXtDUls+/1K
         ElIg==
X-Gm-Message-State: AOJu0YxSt3h2DTaVUf/EjvSBge8iAIt1usXtxxwnRv3fDdMOawS0z9qp
	hodR1bmF7yLqpSWXcboPpqWvG8FRqCMt8P2ryVEIqWzecnUeuASX3YHZVRzoKSo6AK39OduDfVs
	xlyXOjv38HXYPHYXIE1tzPTN9HWJ/U01ND1M9CpXBHGRb4+1A95QKDQ==
X-Gm-Gg: AfdE7cmOic8LStCyzkx6DgGexpW/n1LGSyVTvUk78/caD4L6yWZl49mlm1mNW45QHBp
	7SqkjzDOfn0fmaFz9geJcM8xK33V44EPx29d3vuIfal54f96welXrDaBu5mnCaA45TAc9XOtTh1
	pXLm28aYEKAWBLllDRzJxJs2WOX65ovFbuHZISlY5jpAsZ766YzvgAXQOXruKouSsGDfgTr/Uq0
	f9cBehTn/4IeST3gv4Ljocz9XGRBn7WgO/Z5QZ0kUeA7HEQBtL4cdB+IXSGc4QXGKnmfzisZaM/
	cmOpY78=
X-Received: by 2002:a05:6a20:734c:b0:39f:59c8:f302 with SMTP id
 adf61e73a8af0-3bd4aeb2b8bmr8026806637.37.1782492679454; Fri, 26 Jun 2026
 09:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTCXEpJVnWuy36_XzKjmkBRaqwjDPfqZFiWd2aYcEntgw@mail.gmail.com>
In-Reply-To: <CAHC9VhTCXEpJVnWuy36_XzKjmkBRaqwjDPfqZFiWd2aYcEntgw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 26 Jun 2026 12:51:06 -0400
X-Gm-Features: AVVi8CelGaSMRqQ916wwykxZSHNtTrbeBTPcQAS8SYnd8_fWsgef8bPlsO6BcXw
Message-ID: <CAHC9VhR52Nit5DqGsfL8OBsw_oZ4-pUgJiQS1EqydE1z1SdQsw@mail.gmail.com>
Subject: Re: ANN: Sashiko reviews coming to the selinux mailing list
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> As some of you may have noticed, last month I enabled Sashiko reviews
> of SELinux kernel patches posted to the mailing list via the
> sashiko.dev instance (link below).
>
> * https://sashiko.dev/#/?list=3Dorg.kernel.vger.selinux
>
> Now with a better understanding of the review results, I just
> submitted a PR to send those review results directly to the mailing
> list (PR link below).  The results will still be available via the web
> UI for those who prefer that interface.  While it is hard to guess
> when this change will go into effect, it seems reasonable that we
> should see reviews on the mailing list something within the next few
> weeks.

Just in case you haven't noticed, the changes are now live with
sashiko.dev sending reviews to the list.

--=20
paul-moore.com
