Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F43770B
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759370; cv=none; b=dC2g++qpIDXXhdqqIt5yLFFFwVZjJasyBQiZDs9tKBAEL78PNXX7zk9aJH1PJVms2JLsDDubSKizwzZPvGtFvtPwzS9rJGBcx1pNYgxocyspTPyCoHNHN68S62bv26O/sDnna1fZKcU8HW6miHaXl9jqetdc23hoDj6IA0kQCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759370; c=relaxed/simple;
	bh=dt9/XNrXpT4ybygFVYrvpf2g7deXsNUPdWulGHqXGUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwPwr9LkYDMKFY7fUCaMbOTUIyHVke92I5kYIfKlucRHiFwdJnyl7PzfuiQYdjTzephOGcCZZ2OF9RQJ1bdGR0czQ2RpQ/xUrPIrKbq+D5d3MWgXpGJ67sWW8cOUDEpn772PMRY1I/v2xVoWBq+g47fi5oAUB6OYxcGw7M9NM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK7dxpS2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK7dxpS2"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b593def09e3so3667091a12.2
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759759367; x=1760364167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v7MXIKCUWaNCj7nY2V15W5Dqp7ZW7yWpwn20NFwOyQ=;
        b=fK7dxpS2UZiH1HWon1hYAibLaFhv3cayWEnVwmvUmI0wQ3YQqbpgTiNXd3syiOOdur
         74XhcBXdBJ3a/PoQIu/KjvkqybpNY+hzeERTlnQ0wZHDQluDS1N7fhHJ2vqfhXkszO7P
         CTxzjJXHJ+yT3KaUqMCIAuaRWLGnVmzfzG0EH26oZjZmij05BQV5sDcBKQ5AGIbxgYks
         96FOuKIgVwh6p+nBIpTPFeAD+LgvxzXgKsdwDyx875ciKXKF6Q5tUo2OAoSMxtUuVLQF
         Y0LeNJk6qB85zzUzTcaZ9nphe9ydVpUd/dMNOLJs8LM6g7ShdWnwxWrkBDIoe7Bq0MLg
         846A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759367; x=1760364167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v7MXIKCUWaNCj7nY2V15W5Dqp7ZW7yWpwn20NFwOyQ=;
        b=DzYxjwx4Cd0LGMhN18QxzBN6Sw+FTRmGIqoNkG4TTJ0y3yOitM5+s1G8sf7QMdcc3t
         zC+E2cyFMpWErvlH5merMzrxux1TOJw3RycwwtIsfvBejD8IIZrz9xsHjvgc3Gvfa5m4
         0+NouVUU/leYzHqnCsehW/tlxdpuPVSJziah1kb3Zllojy0vpzX05qGNzzp/rwD3Zq6O
         QnO9gyvFMF+XOkLs7E4CmrMuguFK3K4AIwmCqnY7N33kyCiEXg5Gc22/cv8SKlfjscTS
         Swpk++lkpvks9ItJQP8ZFNBXwotODvvl7zaQZ2F9OqFqoT0FU1PasXU8J6HgLD7VkXWr
         xhgQ==
X-Gm-Message-State: AOJu0Yxab+W1rjJ89f8Scg4ODhMKSQwZ4HmQi+SbPYKw2QzVf3CsURg5
	5kKE9g2I3AEBQZpSV5stSC5QRzHtB1vBKu6dfYhw7cZZgLpqWVfVKylFgKLlJgF9xxnC2ONTVe6
	1kO7/d0v7m0v54Jv47GUBjsBrf9spF5n14Q==
X-Gm-Gg: ASbGncsY2nuOATm6IH1BYiyhb0xog9/jRfolGffsYiEpu4k1sRb8H9ij8Rv4lP5sMc1
	HM1dRDzrO7oA3hk2l2BcHUhKuKGtO5CUaqn1xMdYtAS71AhHjTEXSniqXxtibSPrNWausVSa8Lf
	1MftwCUih/YCWabksaJayU500EEX135oH9XFydXzGbl7FM190CF/VLvyudXAVyS9OHpXkeVPnOI
	40g0Ud7KcIQfszJEcrMsWFrfGlKUpo=
X-Google-Smtp-Source: AGHT+IEmjB+x5qEK0PwUA3QD6VVNK1cczvnZupfcUGe67GwkaoOYtWBPWXHpFNEzT0R0crQHdc5HUkOYiFXqcVY/9+o=
X-Received: by 2002:a17:903:2ad0:b0:264:70e9:dcb1 with SMTP id
 d9443c01a7336-28e9a6fdf1bmr155988135ad.56.1759759366546; Mon, 06 Oct 2025
 07:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006132508.3430-2-stephen.smalley.work@gmail.com> <20251006132508.3430-4-stephen.smalley.work@gmail.com>
In-Reply-To: <20251006132508.3430-4-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 10:02:35 -0400
X-Gm-Features: AS18NWC5Hx52lCVK9IfkRdiA4ZRp7m4Fuxh8G3qkEC6fs-nY4tSDiMpH_IB0VqA
Message-ID: <CAEjxPJ7zHgiSnd8jTGvBQm=Z=Qr645poO51f1N5shMhCLnXVJg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] systemd: perform SELinux initialization again
 in a SELinux namespace
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> RFC only, this demonstrates the changes required to systemd to
> perform SELinux setup and initialization when run in its own
> SELinux namespace. Otherwise, by default, systemd currently skips
> SELinux processing when run within a container to avoid conflicting
> with the host.
>
> Modify systemd to perform SELinux setup and initialization when
> run in its own SELinux namespace.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes the error handling as per Christian G=C3=B6ttsche <cgzones@googl=
email.com>
> and switches from using a SELINUXNS environment variable set by nspawn
> to using the new is_selinux_unshared(3) API introduced by
> https://lore.kernel.org/selinux/20251003191922.5326-2-stephen.smalley.wor=
k@gmail.com/

Hmm..this doesn't appear to work, possibly due to seccomp filters set
by systemd-nspawn.
I guess that's one advantage of selinuxfs-based interfaces versus new
system calls, less likely to be blocked by existing seccomp
allow-lists. Will revert to using the SELINUXNS environment variable
for now.

>
>  src/core/main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/src/core/main.c b/src/core/main.c
> index 4fc870d6c0..f33d5609bd 100644
> --- a/src/core/main.c
> +++ b/src/core/main.c
> @@ -3124,6 +3124,22 @@ int main(int argc, char *argv[]) {
>                          log_set_target(LOG_TARGET_JOURNAL_OR_KMSG);
>
>                  } else {
> +                        int selinuxns =3D is_selinux_unshared();
> +
> +                        if (selinuxns) {
> +                                r =3D mac_selinux_setup(&loaded_policy);
> +                                if (r < 0) {
> +                                        error_message =3D "Failed to set=
up SELinux namespace support";
> +                                        goto finish;
> +                                }
> +
> +                                r =3D mac_selinux_init();
> +                                if (r < 0) {
> +                                        error_message =3D "Failed to ini=
tialize SELinux namespace support";
> +                                        goto finish;
> +                                }
> +                        }
> +
>                          /* Running inside a container, as PID 1 */
>                          log_set_target_and_open(LOG_TARGET_CONSOLE);
>
> --
> 2.51.0
>
