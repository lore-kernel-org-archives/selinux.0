Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD22FE56A
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638116; cv=pass; b=McRyO7PQ7pFp1lSR8rXkBGgXoKrJEpALcgQu3a6WD7X08/RiaGm/JTxwaZudllbkXsSbjOiNMmlFy5W+lHKLHS9lvl7DD3+wx8FylzqF9QoKtrAlmZsKY7BBKJXwfDow/qEOc5kPkA5os7ZIh8Hf1lfNSM5PJZDR1/gt+EIW1lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638116; c=relaxed/simple;
	bh=FGT6LcbFQik9SgDrrBLcA4KIjDNy5EOIAesxTP1Nl0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyZ7dHC/isM1+DGI5oI8GaRqI7zu9VLsHqERQVMnnGJMlRPsqfmSk8yWyVPixz9+jXpNqCNp3ZQhW60IJECkJEmUE96p6ODLqKiP2WFabLlTD8yRDlCC38IHpD1FcRkdn0WN7tzWMsYcbOa97mdEX9/g/wCHiLRQcGbe5Ql5ckc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tN34fPTx; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tN34fPTx"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so73100575ad.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638114; cv=none;
        d=google.com; s=arc-20260327;
        b=GwAc8vOxX5L8oh8A6bVhHDen530fhf7Pml/smGO1WuZW6sI1YKFmobTM8uwe+EeWzC
         S13ySR/8a43Pd8v6FeD4XDWPaUC595diMj/ImED23MkGPH3BwwcHlhTpe/SYarxEmZsb
         LXh2lLa6CMWxMB3uj/zVStLRmPfDpL5I7HxTZoYCJ5mYlThl9XVAWHcOVsSgq8TIMCME
         jHCOBpAG8256XmLm8pPFLhjjoqeAdEEWM8jv+OpOgEEC5XAGrpHliIbeCzgOkbQQADob
         aPqKgAmR4tI/J7IGWvoLi0mggzW5MBHNOK24nO97m1k7fskE+8Rc9reaBByUWsVYyEPx
         DWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4vzlWwNm9QIfyK7dVflQjFgeCpu+aD+5q+oVUSeRMCw=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=MoNJg6cPjU9PJLYktUsbm00ozP4t/XQzv13hpIsxMtKJnBk2ZAZ667OtMJknvQ4H4p
         QaDC6o38n9y31zDBWFpiTT0v24LcsfxsmNzLO1c1FzzGdce9pXpSJsd0T8Ncbvh99EFQ
         wcosQg76cf8UR1wQGpcbW6sKZu2w6tEqdE/vphYX24j/V8LhliVPbCrtF8yKmQqslM5T
         ueiPGXOKknHrr9yXGWJo8PiiJK2ymtj+c0DZmcZQmpVPCoGurBghPeT6hASTDy3rSB7H
         n85jDcJx8UjcWkzM24woVRdYdbWjbw+Z/tKjKR7ppP+pOMsRoDYoXIvqpl8bXIBjDHTi
         xO6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638114; x=1785242914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4vzlWwNm9QIfyK7dVflQjFgeCpu+aD+5q+oVUSeRMCw=;
        b=tN34fPTxrYIFo73s+DpmBSmS0rQ9tizwstRBfnuDGJ2QS/XHKYzr7IxwXOeB904PKz
         SkAUJ29SRhTD0jjjRrke1MNIifYn6MUpdFSZj0N6W890+r9Ur988azoxAtLKiTIh5MOK
         op3oB+z/Ae762Xchm6X+uTStCYZrVqYNngzKlUCt/nT8TaRN+TXQWFj83cZYCa5tmPRH
         eYTtuQ2ANxsS1XrkJ5ykoy7eIE4jUCsnflHlTcbVnTCKzRjhS/etJFJU4WQkr7c67ASk
         gu0uCF/nCZ2HOZpJqgM3PbUNimkTtPnzSzTIKhZHSdkdg2mnyqtj8ahHiZR7mFOTMppZ
         /AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638114; x=1785242914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vzlWwNm9QIfyK7dVflQjFgeCpu+aD+5q+oVUSeRMCw=;
        b=bEAgrloxxHiIIcAdwSJixJWIyntY4P7Lhek4CCrNRxHcOrzHVi1wHhL4kq3ZIpMJ/e
         qv33fcm7b/7wgx4cpQM2DkyEWG5S5ztJkL+7vo0yPST/FysX/91hIXW+3RJUngaw6vhN
         wMFMgRhK2Z7mBz2sZ5diU2mB7jsXf6wP7Bhrrshje5a/trQ6CwKmsEoQBK0jMdbHEw0g
         gwxYrQ0ScyLUkJlZllzG+9CDAsOKGNnnIJxYuKPUCZbHCTy0RhZYjnjYkfWk5PWD7i4C
         4YM6H0Cwj03UmJ8umFvIGtmU3XriwpxaZjdHs8+xH4D+eGicgzK5XdXSDdAxcdzR7KOD
         5Wkg==
X-Gm-Message-State: AOJu0YzVDOOAktJ8NbiLiYmS35n8kqWA4YlPUPVIGPxCpm/3pyb72/MJ
	7vHszJb7CYRXKz+r9MIeXu2tVFKG/aGuq6jIvErMMEt13EK+1nkDuv1W4W3JJipYWxHH7C9PVc/
	jIzzcOTj5tVeKXKCiysjvZG9LSe+U205BeQ==
X-Gm-Gg: AR+sD10LXT4Am99I+tXdaxjKVeiyZcz8K/EvL2NbVuGLgbzoZ594E0cqKh57Gp1u7Mz
	feDHBiXLdZDmckKnJYmUoHEdOEV4wRROancsRj27WwAK4vm7ABlkAqY7sXX5BdCBCeLOL+5Ecka
	a5vBGrQVwuoq3S+BibFLim9E1xdirwxIFNfyBTSjEF+6zwalQzo6knXgtEf4fwktmL9P+68lqiK
	9kRFtk85FFjubxtLa5P6EvWDmFN4/i6k35m1nILvQ0IqjDe4Mxqs26ReeE/yYVYKuR7oH6F
X-Received: by 2002:a17:902:ce04:b0:2ca:52ce:6f91 with SMTP id
 d9443c01a7336-2cf3496b2ffmr221283505ad.27.1784638114360; Tue, 21 Jul 2026
 05:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716125249.6872-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260716125249.6872-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:48:22 -0400
X-Gm-Features: AUfX_mzw3dys5DC-LbiSEjeJcqgAuZbyaQMfLGgHwVxPxZh4Eypf2cWuJQH37Ps
Message-ID: <CAEjxPJ5CF8kFFvMzdk1G-uAfRnXgRfXkPnEUkNBnGzfFs3C2GQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mcstrans: defer SIGTERM cleanup to the main loop
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 8:53=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> sigterm_handler() calls cleanup_exit(), which walks and frees the
> translation and color tables and unlinks the socket. None of that is
> async-signal-safe; a SIGTERM arriving while the main loop is inside
> malloc/free or inside finish_context_translations() during a SIGHUP
> reload can deadlock or corrupt the heap.
>
> Set a flag from the handler and let the top of the poll loop call
> cleanup_exit() from normal context, matching the existing SIGHUP
> restart_daemon pattern. poll() is not restarted (SA_RESTART is not
> set) so a signal delivered during the blocking poll returns EINTR and
> the loop rechecks the flag. The narrow check then poll window matches
> the existing SIGHUP handling.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.

> ---
>  mcstrans/src/mcstransd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
> index 5bdaadb7..3db58a17 100644
> --- a/mcstrans/src/mcstransd.c
> +++ b/mcstrans/src/mcstransd.c
> @@ -58,6 +58,7 @@
>  static int sockfd =3D -1; /* socket we are listening on */
>
>  static volatile sig_atomic_t restart_daemon =3D false;
> +static volatile sig_atomic_t terminate =3D false;
>  static void cleanup_exit(int ret) __attribute__((noreturn));
>  static void cleanup_exit(int ret)
>  {
> @@ -407,6 +408,10 @@ static void process_connections(void)
>         ufds[0].revents =3D 0;
>
>         while (1) {
> +               if (terminate) {
> +                       free(ufds);
> +                       cleanup_exit(0);
> +               }
>                 if (restart_daemon) {
>                         syslog(LOG_NOTICE, "Reload Translations");
>                         finish_context_colors();
> @@ -442,11 +447,9 @@ static void process_connections(void)
>         }
>  }
>
> -static void sigterm_handler(int sig) __attribute__((noreturn));
> -
>  static void sigterm_handler(int UNUSED(sig))
>  {
> -       cleanup_exit(0);
> +       terminate =3D true;
>  }
>
>  static void sighup_handler(int UNUSED(sig))
> --
> 2.55.0
>
