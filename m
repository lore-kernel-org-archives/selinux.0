Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A401C28E
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134656; cv=pass; b=SjFVrp63uydNW9uHehToIaJ3zxJyFeSMwj6A4i12u4X0ePnD8kWzURSH1onAxkqwnptw1yDLgZhe74ChXHl8139W3MA1/wu0HZIxZYCWyvBNrUZ1aZ1v7HQ6llRk424ra4eCnLTn+ReT4oMf9kAZYPbhB2hBhsYVrj/9rYUwf9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134656; c=relaxed/simple;
	bh=TB1jyx517hJMfzVOiz6ureBqMeipv2MCTpgICKZHCBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBGZr10HK518yIAcI0zV/xjmqqe9m+ozh6g/q08tkhELT+TzzqXjybr2icbFhxTAiWUfuHTJqsnq9cD7wtU3AWIvNVN3m+W0TXxu8ibOOeta7AtqRU/Lyv3csb/1QaIQTIfzw6pLTN1WUgNWjLEe54zIDmTFl0pHP+h9NKm03co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUeJfwSt; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUeJfwSt"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82faf871346so2126477b3a.0
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 13:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134654; cv=none;
        d=google.com; s=arc-20240605;
        b=LmDeLVVHMiHkucQMS1LtIaBjCHCKbKQcMd0VnGH3Z+I/S6HkKEAhr6G6b0lOwDVl4t
         OKTfSViBGNMqok0my38Rkzpm2AmBC/4t7U1ZPrG5XmqCYehT8FM7rHcurzL67z9XZdN7
         JW70zfHPnA9BXWvLjhXX5C/O1zJNNfLHqW1zOyTtxRD/unVLAuzG5uFLaBThIjs2ON/F
         eTD2NynVCo0vmnKzjwfpOUUOUyMM6Tpw4jYklUdlqCD0TDdMAk2TTL6oRXquYwQ8Bxi/
         5eHLR04HbIz3WBML0Zvpz+vaSBWLS6N6vK06RVcCoCabyxiKEC02B7uQGNR2W4/ghwhX
         Wp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=72rLIMWsOipytxuL56JvaRc3kvj5YWKNwWgrIoP0PoE=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=i2QJ6y3BHaOP7mUA48j5fJyBBCFPJ1dsaJpb/hwF0JnOUbEw8mPD0xeh3tG5UB6fJZ
         BcPpyJTPt2PfWfhRXN7aGCJCUDY6Xl/KBJTlNb7aE0MwgKky6eVeRg2oWpOfYHrYIVtr
         Cx5enuyXx4mq1dk7BZF7fzIDo9MIxnLo4Chg7Q++IGLrEgCT3XpDdOD9ipypjAhuIOnj
         3dG+kCLKrFAxMSKV58HXxIE71vw1DrIn+m2o3GUMSl08j1/78n0zal8IdadE6WxvJg0o
         QnqI3y7O27Ujm9Z8kY+d1a9ugEt6pOqg+ZlqH9tbn/RNSVwjagtriJ/1PTBWRyDBQLTt
         xngw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134654; x=1779739454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72rLIMWsOipytxuL56JvaRc3kvj5YWKNwWgrIoP0PoE=;
        b=jUeJfwStMWW8nPGfNqwjBssNpcxAv1lGJjXipkPK0A5Uuh7tx+P20IYdBx0vj7Ww1a
         9F7dpAioRywuf0NWihbZ76EOZyifLiUDsexMy8cfN5H0lFS1E6pkhfj2g7VjPbyT6PfB
         +ILEJA8fbWTGsbizZObTmDvZ3b8dPr12+wUSM/NYZI/DoWaQNryMKyAr5PVUiAZvhEWb
         gE8kjf93aVdLZgpygQt44fphO2QxZ9MwY4I48cXLrvXcGtt8o5XzOkz3nYX5GiqUFm/g
         qzhH/q1yo3DorOHX/JRzgDh2Zdfu9K5X5aMX2++A/m3l8D/sM0802Lbwq+fxIOFvEd6p
         9Djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134654; x=1779739454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72rLIMWsOipytxuL56JvaRc3kvj5YWKNwWgrIoP0PoE=;
        b=PYLobvyz9tyTWKenLI9VJEhzZDkUEj+MFDoS9BXmdsQEO2AyRsFIFF3WwETX/xCLf0
         eucL6YWsRy4y6eemszKk4QkyihaHPIeHCgpDKM+d49hFf4OLUv0HwP/wOkwooNANp+Bj
         7PhTm38mkeIRiX/j0Xl80tkeiUEzHgyk0xKPFfQYVqvQDfmyK14gvUeEoR4n9CuZKozf
         tQg7YaiUpILEJSByGNQT2gVGHFu/fPsKkLMOMTnWM+pyF/p+tf9V3N+ccr3mSVlfYKf/
         Zt2qV58CIjdJzqRAtCam9h9TO3uZgfdDchGoibS6+pNw5Ry8udj7i6rfoUa26S1UgGr4
         Kq5g==
X-Gm-Message-State: AOJu0YwSh53CcnfJqUZDuSKsC6OZeiaparGZ+kM5AKXhZi4J9Eho5WWw
	w6XE3CXDUOzvB5zs0yn8BVHmiNFKMUxIL+TcEkG5l48PPdPgxD5cfMzkFNuLm7oMFM40lW9H8ef
	qxG4GIyjpBkPpM9So/lYKOa8MnRsSEI/GaQ==
X-Gm-Gg: Acq92OEMSDDKwBcxuDyNPHmcrX+KNMWm17lqMQak6NduS1XIhO/6mylOYEP5qZRoDXn
	VnhimuipuGwU3jOZEkriy1CoJikN2BCrgL/w4wqWxqECnTebzUYwvpUFDGuq+N/F5ZMbKid5T2C
	wvmoSqxi+a80gJOPzxiRd6uTXMALMI5AS+SlRUj8AUsy2aUFQTt9c0cVHSRIy5AZuY2QqWI0KdG
	pB6sB2AGoyiIw5ErtndO3YVIm/CGa7MIC8I5suGQogZ0zUK8OmzqkiNOh+jzX7AlP+VRNcVBafl
	0ZfelrjOlVjITJi11A==
X-Received: by 2002:a05:6a00:4b11:b0:835:405a:7e6c with SMTP id
 d2e1a72fcca58-83f33b2fa99mr16532308b3a.15.1779134654140; Mon, 18 May 2026
 13:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515151439.66307-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260515151439.66307-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 16:04:03 -0400
X-Gm-Features: AVHnY4LUckWUNTL5T4DloMOUUYsILVA3W2FyRA3jioHx1_r5dy-NtGhG3UcUg3U
Message-ID: <CAEjxPJ62DRsBhRZBONQ5a+t0cNcaHRzFx2ra4Lk_a01pp4Vr5Q@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: check owner in seunshare_mount_file()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 11:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> We currently apply an owner check on directories prior to
> calling seunshare_mount() on them. Do the same for
> seunshare_mount_file(), but this has to be done inside
> of the function since we do not open the source and
> destination files until then.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  sandbox/seunshare.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)

Merged.
