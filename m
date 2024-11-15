Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E201DC734
	for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678369; cv=none; b=rGsf3OA4YbjWvzdc0ZJnAhqn9Z3qV0Z/XJM/ZkKgkg9Q0GWzd0tdOZnCj4oSVCFp1qpK8a8FF2P9XGF2AYWJ4xrrkKgeCnam1+NKeWvskj4VY5afk+gRK9sW1lmbG6xYM7KNqcZBYnx7ak8U5SUIssgsyWkmBhLc6TrkumHHGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678369; c=relaxed/simple;
	bh=++QcQUMOkENKgCi0RRk6dDtv6oLs5z66MyVQ4gJ1hes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heAGJyVoGdDjacy42Mnro3LZecooTS/BY36SkpymOBmzEWMbukcqESM21HM8hS9JlnEUfkeMZx17WmgouOk9eZmSXOLdGD+IAB7CwMQqytHKPWgVsS6lmNPIlTJfMfR1kiJr/cZKCJ/eZ6h7h/h3aMnHNJCJQSL2zR55Xxl2aTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWquuy8O; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWquuy8O"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7180cc146d8so909724a34.0
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 05:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731678367; x=1732283167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruWkUgBm3HX4Li2zU65ga9FsfiYwcpASrllqSCM7kX0=;
        b=WWquuy8OiBPsc3e8r4J9OOo2RmqHCptPAAklidbvfNBD5BqwGXASmEFK1Sd1z+NeqQ
         zn1xcwu5fZ58bs5olcCvKNOe/zrDKdmPk2dVlyY3QadEPZgaFbTO+pgtXzMIsYyFPf8G
         MkBkJxA4SMRR7WxOFsoOuwtjqIrssRuj1hG4oVxVXEEgwiQQZqFquMT2dh7pRwt+7nbV
         wfU+B1CksgLxNK+Hc3Fo9MTtPHSAf7oectTXcpY8gCwylP2WIQAGifE8cJg7PThfHx7E
         UzPhf0/FCDzeqUXXN6hjlJF4QEgrSpGZuOgttR2fc7jsJCioyJZ7lwgiuhiwm8sjOdK/
         S0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678367; x=1732283167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruWkUgBm3HX4Li2zU65ga9FsfiYwcpASrllqSCM7kX0=;
        b=phbWWot3XkNhNnBRUFlTuYU5zcl1XV4pO7FSog855ICCjnYAKtSi8c9eUToZ2lh1Fj
         razznWeCOZgULOaAHd3+1zg0U5hnkYZfTzGsw2hl+psAqKEezUIyyUZ7Vp0l1A4D+jrP
         mgF1GTtjHPtGJ8dsYFRJ10wtVr5vzH7WH0LCa276WDal6eeMpFbT8GXn/KvHngn6K/2p
         dniKifjVpItwhyNCDArqgl02ep/pNm3MVmJBWpCJCNJ2i54VyqQs+pTP8ArpQjPEIIMt
         K980AcXyv4zLvQ2nX8wSwDd52RW+A4L5ZRyQ6ICLtTyiarshm7peggqZgyAmAUiTF1ZX
         u/xA==
X-Gm-Message-State: AOJu0Yw1vE4XuMgi2pyQhnFMnD9tFfwmjJ0FwOfnqvQYnkIHZTVMZBHP
	R74BFHI2ZVMTDZlwzI+PoyxTNbndpiTfgxu79wC01JIOdO1pXk6899MQaHgiAfjPhPCopGiWgIq
	y0RgY1E7NKQYJDh8rV731fPFz34RyJs+Y
X-Google-Smtp-Source: AGHT+IFzZf8CK0UfF7mQKDcqaJHwI3zk+AWd3Bkrq8tCeZvs4JHMJ/UD4w+n+UW3o9iUoXLmJT0JhVo8MFgo43+rcuQ=
X-Received: by 2002:a05:6830:6f06:b0:718:b83:8fb5 with SMTP id
 46e09a7af769-71a7792169dmr3670506a34.8.1731678366680; Fri, 15 Nov 2024
 05:46:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024084816.40872-1-fvogt@suse.de> <20241024084816.40872-2-fvogt@suse.de>
In-Reply-To: <20241024084816.40872-2-fvogt@suse.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 15 Nov 2024 08:45:55 -0500
Message-ID: <CAP+JOzShz1aBwrgadZZM8nVV_dpK3vmz9DuZU9Ld_RS_m0xxHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] restorecond: Set GLib IO channels to binary mode
To: Fabian Vogt <fvogt@suse.de>
Cc: SELinux List <selinux@vger.kernel.org>, Cathy Hu <cahu@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:48=E2=80=AFAM Fabian Vogt <fvogt@suse.de> wrote:
>
> By default, GIO channels use UTF-8 as encoding, which causes issues when
> reading binary data such as inotify events.
>
> Signed-off-by: Fabian Vogt <fvogt@suse.de>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  restorecond/user.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/restorecond/user.c b/restorecond/user.c
> index 3ae3ebbb7230..7188c22e3119 100644
> --- a/restorecond/user.c
> +++ b/restorecond/user.c
> @@ -238,6 +238,7 @@ static int local_server(void) {
>         }
>         /* watch for stdin/terminal going away */
>         GIOChannel *in =3D g_io_channel_unix_new(0);
> +       g_io_channel_set_encoding(in, NULL, NULL);
>         g_io_add_watch_full( in,
>                              G_PRIORITY_HIGH,
>                              G_IO_IN|G_IO_ERR|G_IO_HUP,
> @@ -282,6 +283,7 @@ int server(int master_fd, const char *watch_file) {
>         set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
>
>         GIOChannel *c =3D g_io_channel_unix_new(master_fd);
> +       g_io_channel_set_encoding(c, NULL, NULL);
>
>         g_io_add_watch_full(c,
>                             G_PRIORITY_HIGH,
> --
> 2.47.0
>
>
