Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3CA2D058
	for <selinux@vger.kernel.org>; Fri,  8 Mar 2024 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709927591; cv=none; b=ucRILPx3RrbRkk7HFc/L8CR8jGkkeQjPFcpb5U3ufe1434ItvDAQHQ5UrC9BSw1FQ+pnJ88WvzZLeZmTwXorTxvzStIkvlRa0IuBPYjVdT8NZfuyZTCql439zAyMXUj73JhtJke++CmAqIFf8F6pL5M6SW0mCcEEYEkVw9XqATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709927591; c=relaxed/simple;
	bh=T2OgDUSQOxWf9PT03/lRRvpNToAxW8kDH1p785ZnnkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ebbyP9lcjePJzzMSgCwGfy6wBe2V6nHxeYi1MhI7yMO8A0XR+hz1SV+DhMVL8UXwjxiyyOG142ZSFkEkTisxseQnI09mMICCa/+FHPRXYvQXdR7Ukq45iygep6bfizbY96EYUrqktWNm31SB/kjEPJ+wFMSZgdOtkDCBFptKh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MEWOu2Zh; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MEWOu2Zh"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-609fd5fbe50so18669947b3.0
        for <selinux@vger.kernel.org>; Fri, 08 Mar 2024 11:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709927588; x=1710532388; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omkVB8lLvLwWIcd7eIyG5gC3PLlb6aK+yKdR7tXe1uk=;
        b=MEWOu2ZhkZSXKwmrIHe4xS6tTt9sINCXOWuD0LDCcHIomkSy6w0178qTbfBDRHsRvC
         PlZPvlW8rsWKKhpwZecATSoM0xKU+m9H2sgsSv7kSXGEdnefnD83sw4clJ0gI7hXKNZM
         vI4VrlayvNe0bpUMWe0Ltp4do+GxN2EVC2rUwNE72tuyPeCvzblE2WFChVSPsvCzYysl
         02HE5qbg+nDjHicP5UecHeWsmPJKKqBBjR0KmtRxmML2JvtYQnozvJsJl869dbfHdBro
         P37DgrAgTHVJLbIxnd8b6n9cu5kNuMO7kOj3d7LpXD8dYc8nPw+4bnVP8ImLHTBlhz81
         uBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709927588; x=1710532388;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omkVB8lLvLwWIcd7eIyG5gC3PLlb6aK+yKdR7tXe1uk=;
        b=AfR/M/wEqFnXJnkxs90xt9kXBuMUvhQm0ucs7fDPekddZ020KwpzTFBAYJzmrFBmCe
         w2d7KEFXIFQfxVlyj66T3K0Rgvzu0klvSvH8C0KpJKOHSCglrsTC9QI/eIB2oegDmvCC
         Rabk4PqaYc23T9OdIXaPAjy+lqqsbVKrVxHaFYg2v7WocNd2KxvjHkKz7XESZmfYbY7Q
         2RfflPaF3m/wakBsZrHNimiLTZLXGIMa4rsLEC70Juf0mURvWADhr633fE31PfsBSIl5
         uhkmtZ0KqhSVdx2KzbzOymwc1UrPII/PCPmIPmpoj0vEcYjjcCpjhNkYld7R4M5gt1vu
         spsw==
X-Gm-Message-State: AOJu0Yx41CT33IIXAf8MIstizkvppgItzHvq+LBAYCZskg5ENwpnlZc/
	E60dpH4kw2A86j4FMYSaq/oucwriJ/pSdM+cMXjyXH5AivJz0822vXrMdHipj7vIICjoKeqIFrr
	v/H0aKkEaI0IPcB8WMeopQzJ97S6Q4kk0f0wBDrY7UJt9ELkoBw==
X-Google-Smtp-Source: AGHT+IGDFInDk2WMboI5ULteirOzCMtcsON1v5I7eP3G12PMH2x5c1wLyg3FnxS4yRRmD/z+P0Q7DoMjvLLNzy6DBt4=
X-Received: by 2002:a0d:d416:0:b0:60a:8de:e606 with SMTP id
 w22-20020a0dd416000000b0060a08dee606mr222427ywd.12.1709927588369; Fri, 08 Mar
 2024 11:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305031221.492421-2-paul@paul-moore.com>
In-Reply-To: <20240305031221.492421-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Mar 2024 14:52:57 -0500
Message-ID: <CAHC9VhQdx66ZHmR1r4HUrhBPWt7d8YVPfomt0W3hK+624mW3Vw@mail.gmail.com>
Subject: Re: [PATCH] selinux: improve error checking in sel_write_load()
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Move our existing input sanity checking to the top of sel_write_load()
> and add a check to ensure the buffer size is non-zero.
>
> Move a local variable initialization from the declaration to before it
> is used.
>
> Minor style adjustments.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/selinuxfs.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)

I realized I forgot to credit Sam for the report.

Reported-by: Sam Sun <samsun1006219@gmail.com>

--=20
paul-moore.com
