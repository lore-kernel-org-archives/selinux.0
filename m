Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A88B23DE8D
	for <selinux@vger.kernel.org>; Tue, 10 Dec 2024 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825779; cv=none; b=ftfGZLjYpmNFxmRng8I6XU/TwVk1xou8lATC9vaEA3Wr85KlioqOBmQfoPkSosAjWyvZBu752x+LBNfRAHd0e5xJHS17zKCqZ/OpIt8cUpjpnLP1tQsacZMW5eK6zwT+LxPPvTWAm8dKX7JkpCHVXPEjAMje5TnNUh9gexXT6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825779; c=relaxed/simple;
	bh=2Lu/GY8PDY5J+XfpKt/HSYa/CCrDyp0smPPebTedyIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGy7oJ/1VzicyB8oPsyPYPwTp25sBMCfMIOQKA+WZ8vsn2FnbcjNmAPcxlC1lyWwXd3hkrJXxUL7uCwzI+0nivhyPM/bgDh34hR5Tz+w9o61mvnwL6gbBfxmGkpkCUUUYrqX8StWTUlj+RcofVRPfA82gjd0UuUQUn+S5heaAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H1CQcXuf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H1CQcXuf"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30033e07ef3so40090301fa.0
        for <selinux@vger.kernel.org>; Tue, 10 Dec 2024 02:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733825776; x=1734430576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Lu/GY8PDY5J+XfpKt/HSYa/CCrDyp0smPPebTedyIk=;
        b=H1CQcXufUyAo6BrwEWLmdjekCVYiNjtvkU1/KTyfbwK44M3b+oBCYpriQNFEe1OVVk
         ujqkfsJstQ2ny5aewJ8oU0kCArT6EXMozCiMNrup0t0/LajTtBh01Cb2y6Ekc3SGYnvp
         bnnGfZpaP6RvWoggGkMnCjJYuYKLSB+xVWWwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733825776; x=1734430576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Lu/GY8PDY5J+XfpKt/HSYa/CCrDyp0smPPebTedyIk=;
        b=qtvFHROCz8++FLkt8ZUpKYW+uQ6G6hW3yg/7ZkKOCOUJ9oP0OyuQppsmjFUcMNsIYZ
         w6ffAlZykpb1PwLnnJ/B6otd6xcc/vPLbOgopbsTrJxPvRadcaNwifhUZgBQk0OzYqJF
         NkLe7fbSN2fB6Smb1XpDxwweaIO+J7DzcM35OWH++ZMycs5szBkXQ5UbT6zPRDBUSFpk
         wKCVS3eYe8qB8NX9beWaIrwrfW0xI9uTsiwLmcGBKA1KNjkCsYGM6n89n97mSyINO2Yq
         TV3VYtu+MxAY20WxRd3izJKeMmdlKFqRk4cFlcECX5Q6Hi1T1KeyARRabN/HlZDaiTZu
         oUtA==
X-Gm-Message-State: AOJu0YyZQEVFdlPZRPb1himH2saYsfxuItd7YSiyc6KXK/L8F89q3Q01
	uF/bW98FklDQq/3TTkqnN4esyHmAZcf/dXzcuyEnU4R1/LZ8gerRBPzIY9L7S0d+6wfagTm6g1W
	MigpGN4RFEltUY3ZXzpnNRmYkXABpp+XaT/Q=
X-Gm-Gg: ASbGncsmyJOVs/kN7I46B3v3SWdC+Hk0rWuYWvcbiOJkYi2KyPouFiNlS2F09ZXwUtk
	4/eDOThWW+05r6xeCFxFm3L6LWEBAamp/zyHx6hCdVRhq1q+uWmUXQPbS0oruchXh
X-Google-Smtp-Source: AGHT+IEdkGs0Ioiu2A7f1YI8SmfxItz3sFYGZYeuO0ZPnRWAUf2z3Bq35yvriAMb28qgzMPfl7jJBuWnpOrRrrLx69A=
X-Received: by 2002:a05:651c:1556:b0:300:324e:34e2 with SMTP id
 38308e7fff4ca-3023286f516mr9061571fa.16.1733825775714; Tue, 10 Dec 2024
 02:16:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6dmxzcooYYya5kH=KwfhhKUJSq9LYVKiwxj1sxsDB3h-w@mail.gmail.com>
 <206b1563-c3c3-4e6c-b7b8-da1d44640772@googlemail.com> <CAH9xa6ct0Zf+vg6H6aN9aYzsAPjq8dYM7aF5Sw2eD31cFQ9BZA@mail.gmail.com>
In-Reply-To: <CAH9xa6ct0Zf+vg6H6aN9aYzsAPjq8dYM7aF5Sw2eD31cFQ9BZA@mail.gmail.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Tue, 10 Dec 2024 19:16:02 +0900
Message-ID: <CAH9xa6d95PQk-aL_OOrkXYDswkNhWuBG-p4oJYJ1ewQ0nU3xKQ@mail.gmail.com>
Subject: Re: [RFC] genfscon wildcard support for faster sysfs labeling
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, tweek@google.com, nnk@google.com, 
	jeffv@google.com, Junichi Uekawa <uekawa@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

I'm sorry for being late, but I reported the incompatible behavior I mentioned
in
https://lore.kernel.org/selinux/CAH9xa6eFO6BNeGko90bsq8CuDba9eO+qdDoF+7zfyAUHEDpH9g@mail.gmail.com/T/#u

As for my RFC of this thread, I'll turn this into a decent patch instead of a
RFC, and send it to reviewers for further discussion.

Thanks,
Takaya
