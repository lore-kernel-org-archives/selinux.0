Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C2364044
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908939; cv=pass; b=FTVRZXcGopxqT+o2a6vp6oc9pkyXJggpj2T7HaSeCDLenw9wwGNhG7YfieymdtBt7aXYwkJd+HB8tD5zgM5kjVNwb100/9XDfzeHYm/j8pTJPrXv43Vhewpjg8MmUbr58nCTq0FfvlvYqjeUYt5hK6j7gk1Nag4k08VJNRclGWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908939; c=relaxed/simple;
	bh=go7c97jWIBlXogPXf3pq8xtdvnABDYpc0i63ZykiJeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNzJ7nF9KdeghpuZrx1hHJm5PxkA89gtflZKTPdDJLcqfalWwF6ktaiGqkrF7miTBAEIFjmp7kEw8xG0qfcm7YqxV5cPraC7QtqwMAK/EIlEhhXoN/RR6xYYKM9QokGhZB040XsQZHH653jnyVa4IVFYtFjDlS1sMGtZmzlTwcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQNewX16; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQNewX16"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c80167f5716so5231686a12.2
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 12:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779908938; cv=none;
        d=google.com; s=arc-20240605;
        b=jZJY56Yh1q/LZP0dQaA5ymgtii1F3mmkZfwzzYE4Gve8jAvJ3vfpLcewveobxFjaW3
         N0ebQRQaxyqQ7sqttbwDNxmcjJSkYql9ldNrM8ZQUHzVPeNs+vbGJivk/2S6Mk4CCoT4
         ugsU7whaGXk5/j2q8UwjDOm1MKOSuapRpH/C9i2id1iSDjRWyX2P02AtwFEUi7KuIlL7
         CYH8MSYEFJI9JhUovVu5XOTBrhsTBzPK7ut6aCqcZjgf8x5o0NjsEhFdlMOowSCuv4ML
         7HpIJFtn7lt4LAwMVVm708D0Pkjscv7PKhlsp+Ze3D+K1VbehyMxKaohFT5Nyw02oDGF
         HBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kCiNZpGJ/WbQFw4vROvlKBpTV0m7q9/zgfpIFolGl+4=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=AsfCj4dsFkaIwR3mDaAWUDy5b4acC94jKCmnizT1eztINd1WdFujVSqqBI+JuipuyW
         ZcGsIbhUTp98HheNnuAvQueTlAJ4M3Qc/mw3TNz+ld31MSDOmC5RzGo1dPKibpZXQ3Q5
         5hedlhFUyOC8OjjJRdKfp9mEUbMMolkHcrrAL+4sCBTCbmZmB8WWEHWrb4gyZoOSoF27
         9ywYrAScCllutb4B2AbHPp67ZAJjekHdr5GIVE472OPH7f2TvHrrEh9QTQnNyGg9kClc
         HE83irZWOyZte4fXnJIfQ1NyHHqllVwTjwGZ6pQ9QTMdWlfefTg0XLOA0D6DBz7AAKeH
         ZHyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779908938; x=1780513738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCiNZpGJ/WbQFw4vROvlKBpTV0m7q9/zgfpIFolGl+4=;
        b=DQNewX16+8X/YX1uQ4rXG+40FVhtrYoAzObnEWsXuCd4f4IwO8O6b1KtpK7vVXDN8p
         6ktaLNjH4U7FiNGJxIFYJp5wK6yh1vPdZ3WlPp+hCCrFdsQ7S9MCpjfhYQZ0mdRhbzNN
         ThpxvpHYNTYCAuYV0MuGisTNoDL0xjyxM4YPm4X1i+m/2F5fHI+LTY0qc2OI3MUj6tFc
         sxvXQNpBXfSlhxLzV9ZCq0MH9jjy5ZqEb3EbZYA0072CXJTIQGmBmAA5xs6ufO27Aitq
         d/aOoKdkbstrERHnqEtdt58/KqZGCokr55bB1VXkAPVbI+TDbpRmbveXTaojVpA9I1jY
         UAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779908938; x=1780513738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kCiNZpGJ/WbQFw4vROvlKBpTV0m7q9/zgfpIFolGl+4=;
        b=cZj8Vh9fV52XYgrCVZVLlWCaEAVa75tfQmvsYov0aXz2CHVmkm9++Zr+JunsWQM0O5
         7veoh2FtrYAgfP3l9NnqGO1EbDXBnNkYsvTN3Z1e8dCcRDjocBBS+i7/qLCPtPECHwdm
         zKdR5AwxdyIXGHwwTuzZJneV4F5nL/jZR2OQx82efgygV52XIDkM12O8VBnfxi+bHj/m
         JQAREvZmtWaSO6Kk5A5/6eOYM5FoyjQ6OuTR9OgvGj8vn8PEYbmCIi2qxajkzbHGxqXY
         uwX3xO8GzhGN4PAmvNrT4yeRZ2Lj3dAnXWQFBYikm/7/A4BCu/8G1XMp5n59FIOw6C/B
         VsSg==
X-Gm-Message-State: AOJu0YznlYULmvfhDkbT9ZiaUSDqrW1+gpo62+6lhCVpbvX8/OmA7H66
	K47b6xzHCuTsZ8EAzQjv00GREf7pESWEPdVRE07sc09lc17LBkG15y1OqA7P0eTRZ30m/ihzCAg
	jSD+JIM8ieNUbNl3oiD+UNGrTnxPUED9ezA/1
X-Gm-Gg: Acq92OHjTLGpfVZkwq6dA1ODSbftgupYWMuG4eWEkB8cAo2ay4PBp31MxMCKqMvAjVV
	at8paR5G/0VnigADsI7HLNbB9Pl7qrzxLl398p3FRAnxeXiioKDJR84bfLErKB41Qk9jlOv8Hdd
	fJFP6PongVUrI+Gj4a4QNzVqPGXCuJfWcJnxtLBSDGFfeZw9TyPaAik2D3XY52g3kSI6o6DVHW7
	6DIeD1HKEOOzZKm3dIloXYLviMCYIBmauDwL5j4a1ZWekMSElz77Mnu8Gx6mHC4Q0J7fu4rfTCr
	IalRDAvvxWYYfJ1zkw==
X-Received: by 2002:a05:6a20:244c:b0:3a0:129a:973f with SMTP id
 adf61e73a8af0-3b328fce9femr24176946637.52.1779908938049; Wed, 27 May 2026
 12:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527130429.26396-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260527130429.26396-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 May 2026 15:08:44 -0400
X-Gm-Features: AVHnY4Jg4CJCNAElkAeaKfBuMYGy4DRwbpnPQ4MVNZiiwAKIFC1ZfKOCLMxa60Q
Message-ID: <CAEjxPJ4pJMNz7wsLN+Pr+t4LdrEB6vfUAcGgKh_1P2=AZZyECA@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: continue on failed accept() or add_pollfd() calls
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 9:05=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Don't exit on failed accept() or add_pollfd() calls and close
> the fd if we couldn't add it to the poll set.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  mcstrans/src/mcstransd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
> index 42262e58..bda580d4 100644
> --- a/mcstrans/src/mcstransd.c
> +++ b/mcstrans/src/mcstransd.c
> @@ -307,14 +307,15 @@ process_events(struct pollfd **ufds, int *nfds)
>                                 /* Probably received a connection */
>                                 if ((connfd =3D accept(sockfd, NULL, NULL=
)) < 0) {
>                                         syslog(LOG_ERR, "accept() failed:=
 %m");
> -                                       return -1;
> +                                       continue;
>                                 }
>
>                                 if (add_pollfd(ufds, nfds, connfd)) {
>                                         syslog(LOG_ERR,
>                                           "Failed to add fd (%d) to poll =
list\n",
>                                                 connfd);
> -                                       return -1;
> +                                       close(connfd);
> +                                       continue;
>                                 }
>                         } else {
>                                 ret =3D service_request(connfd);
> --
> 2.54.0
>
