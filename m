Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A536CDFD
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682006; cv=pass; b=I2pUWMeP7asxrC2DS+3q+byw9/6fwZbFK0YsmnKzQh5X0ZoHZqKLig8ObnVd7SXEjTXKzjXg1xTbGra3JHy/nqjCsW3z/pWLgWYtf8Nuz9TMw7iVyYJVJcDnFYKPrtFZZ9UK3+IWtclLe6JXsXTR7lZzZxA8PO4G1hsIGxwpw8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682006; c=relaxed/simple;
	bh=vuaRNUKT4mkwJ3jeEDTfKLwKJCtjomMrljRW50hlO90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9GXzLfI+q0exh/BGK9GUtMELc6gPUu65OeTzhVNOrUL0dtbuzxXCo5heH8M/z3GBWJry+VQXpD9FeFyDDvphUPF/2LDu3rLxbHs/zJx+/jV8ig1N8gKfrLEHGIRw74A+uK/HMZRlQxYKhhDg5B04DuYkwgLUYznoR1O+NVZ6cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpd6dmxS; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpd6dmxS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8585c51f1fso1514141a12.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 10:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682001; cv=none;
        d=google.com; s=arc-20240605;
        b=TsQQ0p6NHR+/VYHroIyEmFP+i/rNCg3/Iq3vTu2O7IKdaSC9muK8paktEWMuDKXR5u
         zI65Wb5wESpwHiYghrcOMA42P++ozZIY364/wkjSU9Qmb4OfXBw11UtCho4He5C6crDG
         RDXEtB4utga1wgZPNy/7a4Izr9wqB7wE+k2zaWnt7U7a89zn3TAWcIYl5y/GMq7JWNhk
         mqcFlcfI3OFhlZzk7TZA/jPEMwN1X8vYjxymAA+5DEBH6v7Xbbkd0h7qURZi3buPN7a6
         kjUzvgPk5KEjLKSBlTLQlxg/Nal9f7dXXgqTlPhxagUOtwxisleMdL1HWSnyx9ZLb7mz
         LgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aLGwhIRItHqc76BDZNVCyvQsZ3yw7zD51MN8bP7EFk0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=UTjuHoueLmlRzh2pfBdlb/aOJif1dRosEZhbKp1CzyLIyjHNkI+QKsyUqYA4AfOqtt
         z8KJ+yJVLekAn+0V+0ibhJJgguIRfKvTo4bpI7Rhht6seOHi1qtxfFsfBl+S+C/5VjQ5
         eLZUOgJJ6ii/H/zfNVWKsQf3+UdEOuRr1IFu52ng7qjk8+su67buGSy6F29nlnFCy0fF
         aUgGil9CQv5zDn13K2zr+H3Y0keg29h/yxPJIG6iKiIyBuRZkB12vcsz3+NfwXLM9mNz
         jf4sqEXD68fwa7tElVEhWxAfi5I0oYlPuZK8i6Oc9Cxj7eB2CJEVt94bEBgxnt/IvD8z
         szeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682001; x=1781286801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLGwhIRItHqc76BDZNVCyvQsZ3yw7zD51MN8bP7EFk0=;
        b=gpd6dmxS7REnIB2p9L0t7q7vxi6M1PLQK/OfOCjyWiKQIbMtFozzUw8SpwZcMxbd23
         l+mry+yoIQN/MU60Fulc+UwecmoQqhejLlGgU+dgQXoUi6hGF9UTWgNeDBIvlVpp+mBI
         3Z+YEJ6JBO3HHvfxFJVfBLjKap01tctSFO6qZb+jbxWp2p0w+98aOgIPxYtQmR9dYdhW
         5hX8GG5O2LjApT7JgE+YpxZnNDOrIjwzPuR4ESRwlCB9hcLf2gvOt0b+31XYTG3rQxEc
         MqgoqfkRrzC5SsdqZBEj1yMg5FHGmOLjm9Xby1C4GYmLQCW02f8JCdpGqeoJHsRR3joR
         d0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682001; x=1781286801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLGwhIRItHqc76BDZNVCyvQsZ3yw7zD51MN8bP7EFk0=;
        b=c6vfpZpApBtV4mtpP8bVt9gTPuLiUxHGfF4CDscMbVVjoFN3JbGcp+xcpJ2FYWPlb8
         fKx3kiC9lmlfXwl/L9Lb6H3lgShU21InqyCQUkxvsf5zM62pOwOrS4SPDlnNJdvB2RAR
         k3F/A8u8nmkwTwMeg1lNzdqfPxRMhJuqkQAWS/vJYFCm+4v4vM3Kw7uwYw3aeWu3VK73
         m2yLOTERy/n2DOG71H2pyKicoF1kRbheCiw91TAGWoqD+W2SENCgNA6VnwNoMrK0CJeB
         KOqXQYWkWYUS56VuDZEzKwxTNXReyO1bA6pvQtE/HK1qiXWIxOEccduKOdwvd2S+FhtP
         jY0g==
X-Gm-Message-State: AOJu0YycFZ/Agotox5AiaSylxvypIMKaUuXfW+1nfFaaRje7n8voxrJG
	KJSHjxVOB9w+RN5pU+jaZWThTNO1B7104OHPthO+5TyX4O5HUDg6X7aye1+u5ff7exUFIkW/kAc
	mmqS+ahPqBPlC7LPXsvxPcE7CQ/V7rE0=
X-Gm-Gg: Acq92OFtN7ntIcNkfVb4DlVHN3NQKuA4Mzj9mI8hqb6a6ngWBwb6yLv6S0VfR2NlmT0
	3TjK7gwQ/hJb9F0CJdM+ePvL849LpkczqcfE+r5zErYsmkPlSMZ1O3Y+bte4+Ehk7iIDS5QnbDA
	KQIoA2SoRpvCQp+xzWpOFuXHmum+THuPjpM+cUhgFEqhLvKBrJFrPZb72A+8WNBSDuBwKZoK6Pe
	rRSACFxh1ujXGTknDw1BqHQDmGNvRlVxpYdM6SY8QGZSidY36Ah5PjjNW+PwXsCeWqhlPI9Sp5m
	DEguXtWOLxAUkbOKNw==
X-Received: by 2002:a05:6a20:db09:b0:3b4:6921:5665 with SMTP id
 adf61e73a8af0-3b4d3a50abfmr3589720637.9.1780682001287; Fri, 05 Jun 2026
 10:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de> <20260605172207.222382-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 13:53:09 -0400
X-Gm-Features: AVHnY4IxpktIXgGxVNoD1CXXPmPkHPAz3-IDBDq1aPuC_wYx1lBr6MsmRObzXiM
Message-ID: <CAEjxPJ454=A--cXcEcT2fLqXLJcq6DKVyiebjc1cOWgLxwdgnw@mail.gmail.com>
Subject: Re: [PATCH 06/11] restorecond: declare local variables static
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:25=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Variables that are only used inside a translation unit can be declared
> static.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  restorecond/restore.c | 2 +-
>  restorecond/watch.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/restorecond/restore.c b/restorecond/restore.c
> index c8437f4e..622de773 100644
> --- a/restorecond/restore.c
> +++ b/restorecond/restore.c
> @@ -10,7 +10,7 @@
>  #endif
>
>  char **exclude_list;
> -int exclude_count;
> +static int exclude_count;
>
>  void restore_init(struct restore_opts *opts)
>  {
> diff --git a/restorecond/watch.c b/restorecond/watch.c
> index 41497f49..8e1c36fe 100644
> --- a/restorecond/watch.c
> +++ b/restorecond/watch.c
> @@ -40,7 +40,7 @@ struct watchList {
>         char *dir;
>         struct stringsList *files;
>  };
> -struct watchList *firstDir =3D NULL;
> +static struct watchList *firstDir =3D NULL;
>
>  int watch_list_isempty(void)
>  {
> --
> 2.53.0
>
>
