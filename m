Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133F3D6475
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226749; cv=pass; b=HHXDdLezYXtxtloWxaRKnq3330J4xwT2lefwfbrwmHHGV4K1kjazoczViEKFhlsuZpvUSThgzFx0in1tRTZohzAd+rjRsg+LWabxEQD/Lbr5sGzWRZ1EUMBnn5kLFsQ9iu4ddPAmHgUW+9eEayIlwJUnxTwajVgU90Wn4AfIIzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226749; c=relaxed/simple;
	bh=IlTfewzKiLTM03j6JDVXasYAefH7U5/Qt2c3rbT0GZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgCgIhYj/yQpdXCiAdwJHNAlsPecanNBsEXrXvD4rrXp1MnAbxNUV30FLl8x61FnZwuaYZ7lmfcbLDVeAp1IoYXdUwIULw9LnwP+2V3+ZvXyKa5bNK8m8uFJwKi+CR2MG+FPC120CR5hRV+0PUXDLkE3q3PEIWx87bkMnHNIpZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbuq8haD; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbuq8haD"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so2244511a12.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226748; cv=none;
        d=google.com; s=arc-20240605;
        b=N1U3qX7fjviGiYoEHhYqaHzXzu0parN/p72EtDNbE/Z8cCsuW00rbmiJRATlDQo8dO
         Wx67QQq/dwG7LZFQ0Wy27iaoHfM+sqGpFYYuXaPqK5Zc00r+wqdxnaO0+dxJqFqRFFyJ
         w76P48AjrxjRjqon13IiM8nf4VqeBDNLWPG2D33gFVAcM7uoYSuIhX5uJ6RGRg06iOZ+
         Bie8fwTIN4/2FeEDjZLqj5x2bjJK474P3oUH8UnkZAaqWpx5dtUHlHmFlO2iYju5HcbY
         BS7voDM5sZNgx5WWyzQktVfTlltCltu+rCJY8Fm+uNU85ojEfIV9zpDHpdNedhh4W7lg
         /Hvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZmBUZ+UtdWl8R8ORErHEjFqXOzNXMlZpHr8W8Rmrho=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=dYxJWHg8q7cQI2IseueZiQMTsZt6KLEyWTWJUkTRem6syQViKTMZcCLEe5SEkrLHcN
         sgbanGBeP8BFjjt5/3Z+9nsGSc2tEx8372uUSiHkhIxkeNjpBn6fIsWhaZpLJwGUgzev
         LiFaA2DwZB3NntZXtulTXehGDX7WeLN3N7AVxCA4DfN7LOuXa9j6H51vsIX33BiYAbz4
         yDfvMA1WnCwLgQnx3maK6wqu59zbkmuOYvIhEQ0fPihFzWa4bXh0Z6dyQXxJLSSE6Lw9
         Y9HmyrypSTIFm2ssmlvW+/f8vPId8cHMQlabHlJTTz5zwFh1lmZ2L2hESyj18V1QhbHD
         pBwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226748; x=1782831548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZmBUZ+UtdWl8R8ORErHEjFqXOzNXMlZpHr8W8Rmrho=;
        b=cbuq8haDkjJlcdNe3/tYZcbEIMBTNoDEysaUpyhqODrckatOSpvNP3c0KH5a1y1KfC
         l4cuCpovZghf//JIA5P6M0YixIXRCh3tRckFveK69XwK8V0YGfHi5ogQekr/I0HwlLh8
         aX4y/H7uy5R6Eb7IddNLBKD1qkA8cWkfuKwMjcoCCQXcA8kK9NBDh+GRb8bBeA7iRWA7
         4O36LMlerfhdn7snBN/s+ptvwofDD5/dRGUq5oqcuZVZ0Rts0z5NyHuorwgbKm/OQMvm
         jaXLrTBxPmvvK9Uk3AxF4r2i2xMRgTABvriRN+BgLUbkImGvkm/8PyNP7AkqewreZN5M
         DBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226748; x=1782831548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZmBUZ+UtdWl8R8ORErHEjFqXOzNXMlZpHr8W8Rmrho=;
        b=eCRqrO88uT3cYvUNAaJTQIfyYCVCYDcNS5/VeFSPe7vIi2meGvdwTkFiBodK2wlQI+
         f0PqhwZlLH5XQ2NWfT8qIVTZTp1GzZRiAG49uhMHNlNL2EXuve3qyoGgiMlcLeCjLy42
         tPiN3Yjey13c+1WNAA25KVBmG/h3CiOEdARfwD/8FUYzuLyHBLhOh1smvcns6ZKKZ/2k
         6xdWshCndRvw1kSGNltzWhHeHH5wN5/8jqX5VOMdg7HVKeuXuXCWPU0uc3RxYjtLhv1d
         DiNWo10t36V+UlHc7LsJxZKfd7+RRVeE0GSWwCnXsSDRp7oYxERoPc7jWGFuU7L1Jf+o
         Z2OA==
X-Gm-Message-State: AOJu0YyYFAQg/5u77CqRT9daj8prkCGzXdHzPFRnOQf5jWOuGWYYtNJN
	bksFK+yd/crraxf5ywOYrMtz2ExnHkrRwPnCUr78K28zQj0KLxC6pk3LaliyW2BbxGmDtljXrrp
	lLX+pwB7lMN9dRD/1LeO8/gqTY0gdoAE=
X-Gm-Gg: AfdE7clcowrGqpf1GKoMZkFRHaWpman9RvCcAhBfYo7PR16k6aMG4Ut2BPdc+QMO/Bm
	zVz0PrUe0qRsG7Axt3DoEnqw/aTnaUT1F1mj3qDcVt5DcSBy35a2Vr4QBpHuizZaUcs4i1rTqXX
	ItNrLd4HjBltysZ4mEOyEcb9l8qG2f1FCthyxGxfkUXSpO8ZOkmhzMS5pIyM8nYgGQfUSE0YMzg
	qoEnXTHytxfZRljJMPMaVu5fDR3StNII3qTp9eCc6qBrewC1Ep6qaOGfLjlrxC5gUPBJejtj9EM
	SBE+Jrw=
X-Received: by 2002:a05:6a20:3d22:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3bc5420cd6bmr16756675637.46.1782226747400; Tue, 23 Jun 2026
 07:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 10:58:55 -0400
X-Gm-Features: AVVi8CdsZU2cLHgDQYS2vO0_vowrkPEeD0JQM9TBLXEDgFNPAN8LVGdCUk6UiRA
Message-ID: <CAEjxPJ5Zsvou+KMrqBjZ7ys5MN6ebAgyGfVX4VJ48S0+my1qEQ@mail.gmail.com>
Subject: Re: [PATCH 04/24] libselinux: drop undefined fflush(stdin) calls
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> fflush() on an input-only stream is undefined behavior. The six calls
> around the interactive prompts in query_user_context.c served no
> portable purpose; remove them.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Not sure if anything is even still using this code today.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/query_user_context.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/libselinux/src/query_user_context.c b/libselinux/src/query_u=
ser_context.c
> index c2196de2..0267e49f 100644
> --- a/libselinux/src/query_user_context.c
> +++ b/libselinux/src/query_user_context.c
> @@ -21,10 +21,8 @@ static int context_menu(char **list)
>
>         while ((choice < 1) || (choice > i)) {
>                 printf("Enter number of choice: ");
> -               fflush(stdin);
>                 if (fgets(response, sizeof(response), stdin) =3D=3D NULL)
>                         continue;
> -               fflush(stdin);
>                 choice =3D strtol(response, NULL, 10);
>         }
>
> @@ -47,10 +45,8 @@ int query_user_context(char **list, char **usercon)
>         printf("\nYour default context is %s.\n", list[0]);
>         if (list[1]) {
>                 printf("Do you want to choose a different one? [n]");
> -               fflush(stdin);
>                 if (fgets(response, sizeof(response), stdin) =3D=3D NULL)
>                         return -1;
> -               fflush(stdin);
>
>                 if ((response[0] =3D=3D 'y') || (response[0] =3D=3D 'Y'))=
 {
>                         choice =3D context_menu(list);
> @@ -81,10 +77,8 @@ static void get_field(const char *fieldstr, char *newf=
ield, int newfieldlen)
>
>         while (!done) { /* Keep going until we get a value for the field =
*/
>                 printf("\tEnter %s ", fieldstr);
> -               fflush(stdin);
>                 if (fgets(newfield, newfieldlen, stdin) =3D=3D NULL)
>                         continue;
> -               fflush(stdin);
>                 if (newfield[0] && newfield[strlen(newfield) - 1] =3D=3D =
'\n')
>                         newfield[strlen(newfield) - 1] =3D '\0';
>
> --
> 2.53.0
>
>
