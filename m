Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9AF9E9
	for <selinux@vger.kernel.org>; Mon,  3 Jun 2024 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440539; cv=none; b=LdkXHe7QWDm9favehMD9ZRGEeTig4kWO/lCr/xWVkJDmY4oJxRk9blXIMzD92geWo5qg+ZeH+V7VzJODg/JF1ofpXk2hX4Xgtkd8wwbIq8ynGN6dyiRptXNzskS4ypQVWE6I5RYe/SUVAt4nrI2p3xEwxisBitZQ8iOZtb3TheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440539; c=relaxed/simple;
	bh=ZtCb4IAuyYITbz5NiRYhMuVCpXS3Q4Y5HGFqKjTmBCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkYr52GtwbweixEnswVV1NHOfrQtClZqgbq/WUZkBpdyPPJFrdA57fa7Yt5CvbH6CgXBWbFiNFOUJ7fKjhDe6d7jMQGgd1KUG48nFg7eOjt7dYy3YYlkMkeev3vrfCjRxDIlr0Mb7AXZGzEUp/kgixJlX2BeCDRG4AF2ZwDI4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEIX3lda; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEIX3lda"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a50ac2ca1so2561515a12.0
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2024 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717440536; x=1718045336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqYFAmQZlaMPv8+XtD9MlDeAvshduLvxqdZaKFTxT6E=;
        b=ZEIX3ldazWB9uytj4+5KZ8Hj39XUwxWM0ppRHUq18LddiGfZDY3kO+ufGNCpOXQ0Qd
         2+bYQiqOELWNPjZ/8Llsvov+mrrd7PBlATDE5QNccIxhCLDbJb9fFsGhF3BS+HNrFQlq
         sDSUHIZ9aiEhOIw9ZIQMWHFTp+wPNp6zL2iNKpQYLtLljE3cFpCfVFSBivlcRZtrk9ZK
         ds0mMMPoPbY+EDuwB9614fovBZSTlh5XXozQpZGoixQ5CrpvDD8u2NlW/WUAcswCgkVG
         gfu+N5jAbOIu/H7Ed8PMHzkR0SlMCmeS+wwl3SSObCvcSQDbILBdCc0Y2IauU7UdeyGA
         NC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717440536; x=1718045336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqYFAmQZlaMPv8+XtD9MlDeAvshduLvxqdZaKFTxT6E=;
        b=S+D8dimBVDvG34pqbwO5pVLgAuf7J8rH7qlnOthoMlgAIk49mIuAGDpqOezU++n0U7
         JbA1cEsAVt26GBX14zlS7sD2VCS7M6vILjnIMNNb2iKeqZRPTqFaHQs2pafXgHsPNyJL
         E2vvL23eBQK9mPgdKktjmE/iStOL4YHri4by+xWq9SqFjETezuZvy3lirGTIHYx/8W2o
         W5aIUqlNNZEL38AIzA58SAMgNIQlwCl+KGlQl99o0bzw9lgFuKNd9r/bMVoDaSb9I5nh
         mMgceokIyVD/7znKQMA0UN2pCxvBilf5kdTwMvgLyoUQxdOf4KjL2V3yKRF3xerc+GK1
         dZEQ==
X-Gm-Message-State: AOJu0YwPJUQB/ncJJGSdt7hUFkjCHmsY2Be9i+SeD1oDBrcRbv50jsoU
	TZ4vytsSeHB5hngzhUYpjzkCFt4kIHJqEG/bG3oJTZYBZNaVvko0qgmwMqiT662uXavQO9f0b/j
	HVRbW7/7+LCi6UTk5ep+8f5RrMs/XZD30
X-Google-Smtp-Source: AGHT+IGHwdnZCNUYTlcRfcHS6DdcvVPuAQ+V6frmKC4vU4KPz0T9WWtJ3ZGAJGHQkynaTcNXucYVH1u7vQoV2ZRIccQ=
X-Received: by 2002:a50:aad3:0:b0:57a:7633:9634 with SMTP id
 4fb4d7f45d1cf-57a763396fbmr922118a12.11.1717440535908; Mon, 03 Jun 2024
 11:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514105651.225925-1-lautrbach@redhat.com>
In-Reply-To: <20240514105651.225925-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 3 Jun 2024 14:48:43 -0400
Message-ID: <CAP+JOzQzQ6SCqRWSe0qEvF6c+ieG7egWFBkSC-hTX-yNLNpA1w@mail.gmail.com>
Subject: Re: [PATCH 1/4] sandbox: do not fail without xmodmap
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 7:25=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  sandbox/sandbox | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sandbox/sandbox b/sandbox/sandbox
> index fe631a92cecd..c2ae4de69128 100644
> --- a/sandbox/sandbox
> +++ b/sandbox/sandbox
> @@ -479,7 +479,10 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T te=
mpdir]] [-I includefile ] [-
>
>                      xmodmapfile =3D self.__homedir + "/.xmodmap"
>                      xd =3D open(xmodmapfile, "w")
> -                    subprocess.Popen(["/usr/bin/xmodmap", "-pke"], stdou=
t=3Dxd).wait()
> +                    try:
> +                        subprocess.Popen(["/usr/bin/xmodmap", "-pke"], s=
tdout=3Dxd).wait()
> +                    except:
> +                        pass
>                      xd.close()
>
>                      self.__setup_sandboxrc(self.__options.wm)
> --
> 2.45.0
>
>
