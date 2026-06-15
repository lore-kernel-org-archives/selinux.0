Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907803F99F2
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540197; cv=pass; b=lI6fR+V6DZurX360OvahBYBNmyXrZh7xYY7JV/mXHOmVFUwT7l8JQPFN9h7CeWJd3q4pLISTgx9SjluavpKL0jdXZyNdNAH9bqIfMq3DTMn4GA1oMLfdc+EIG5h7Xquo3qdsNRfHfNO+c8aCmPUV9vKuYOiQ4JUVGk+vrrPMCYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540197; c=relaxed/simple;
	bh=c7p4MkOAFrU+gImuUPmB4qzC/l/dWWuy9CPnvXspxM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VH4QzWtLsch1Hm1IZ0Cl1vmIHj7OyM9ff/JDaicwR077fGyZ3FZ21pP57kgaNHnhZtnTe019SNg5PNLsVYpHmeHhSGmFTzL/qLj95TONDhcFpWP2Uxdu1r1qB4OlfpI4Np3aC6x0Q6jBjuDW5UEn0eCVfQiW34zJESKWNtElr/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPtqDGjt; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPtqDGjt"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8589498839so1469289a12.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 09:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781540196; cv=none;
        d=google.com; s=arc-20240605;
        b=TVkA7J47uisra0RUMqo8htRCiF44s9XB0wUtxtLg3qw+v3EXgriTojeVpc9ahuJC/N
         jSG8aXFwuDTShqPCIvl69ZBqcoWBLNKcOs4C/fTsOxnHEnKNzmfsXInxCA9PAIbWQNKL
         tOlD84dCcnZmzuE7/4eFCTyMR2nAjsEO8ruxKymwaD/E4aIsVhNI0ill/1rpMK4kkpeF
         v1giXhKMWDA5kEhFpE44enyr9Y9+DzvehYNlTX0B0PXbeDfbmWXFqM234GmcqvNVHHYZ
         jY8FQPJeLNwr9SQDqFbkWZoOf1u2Cjo1IANC71aMzqEiHPDHUJYUPhKCS7gox8EdFzbO
         awBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9VetuLsNU/jpt8Oq3flTvOTXYtuyCaD6exZScgNrMek=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=QPEwEfGg/SI+H9BfwZJVid6xulo3a45vg50zCIAMCO9VaSbWYm2N1QeUE+p4+8SVwc
         exwuRS5NkvHsWdqbGSEvzYGlarij3cFPbJbfP8x8fqD6i5annfI73tFRbV8Pe8PluCjf
         KwycM12ifhUWBq5DGtcof8vzHpKyOYFeWb+m6gdscAHsBAzsNDpJaLyQr7nfcmOr/1f/
         O2zFs2QZE+sX6jjsoh2khUg8PPalDstOsSrJSdBlwrWigwYZZed7dp3kw38Yhj7yJIkX
         H6xnt/NiL735cS4kLkKm3iT19EJCUjCyWxzlDDN2CQ4KwglcqOhR93dJREh6Tb8VH64+
         hOkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540196; x=1782144996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VetuLsNU/jpt8Oq3flTvOTXYtuyCaD6exZScgNrMek=;
        b=rPtqDGjtPYTLDFYXgsUslA7XAlLHpRIw4dnskdamvAYlkwcMibyuIIPMpQeXRmbXvS
         diQg39qxQh3BO86Syt5gNzaYTRiAUzM2F2FN8492RzjOXwwkuVR3yB79FyYbz986RhDb
         mgxqDlxeJzdf5XXuDqVdxGaaZVFBSMLypE7ONHHFj8/cc01gq1WkVjYP5y4mzINw7KBA
         oIiLrmN5D9LikojFiNdW6CAYIGvZWBr2ClF4GSWGmqGc27gNbQOQDFX4w76mi+5M9cY1
         CTfQRuJ7t/KiyioyQZP0zN7/CF2oV5EQ9jmXJEvSJYVplhap4miykwLPfHV4u/pE+Jo+
         QeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540196; x=1782144996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9VetuLsNU/jpt8Oq3flTvOTXYtuyCaD6exZScgNrMek=;
        b=kygc+PoyzttqORb/Q9kQAF+sVJ3DleuqIq2JwbZgohJf2RMcpgk74sbpE7TM8/js88
         N4ZeWeGb019kwL2q/Aov7CCIUATXipp9KnZwQVL4+TJUKoL7FLbczf/+KuRwE4z7RTn5
         8Rn5Wz/rJR17ob3Tb3+E4/vShcbYqIuZbqbc9b6CGnPEa+8epi+fk2zrYvYd6yaHqrtN
         qgIdKSf8lt8LsSVrTbbmepeJwdCni7gBxmEjgyubZI1n0oC1CZxr4wX2b5RqUHpJwi05
         bkPpxRmtkJwIZk70Z8RWMn+w8TIo0e2RC4vZhsujkPcdVmlbVG4EGlWXq9bG2iOv/YIj
         iIjQ==
X-Gm-Message-State: AOJu0YwZjp+TPlAFObtcKc2AWUEVvgA4fY46dGQNUqv1S5MsRvy3y6I0
	iFI4v2nMhekOdi5XGBCsuJi2dxycPANS2NfgYN+UW+FYrQaGdOTN5CKWUCLEhlPl6dWr6CdC6td
	gjk2doVUKW+C0zuOkZNcXWfFrsa5FqDDGeA==
X-Gm-Gg: Acq92OHfykwONJrnZVY8qqNjnwTBYyUV3afBikNiMFBIgp3dP3cs7TabgwGbLkpBX0P
	jKtD1e1Pleoy+o7dxS08ht75O9oz01zsX486jeOa9jwxA7y2pZlrj5YXtZGNbVA72G/KaXfyc0g
	eTTkP2Bs5nBFGO1fOt2dZZHh3Ubqk42AaHkpKU2RrWNpaMOo820w5BvB3pq8W2TNuRNbbKrLJBx
	tytFBDKCkrv9p+f5P3GQx2tIHLytu6YclgpInHiDdvC0OyqBu9NWpq515iDQ0ICiNpunIli5Qnq
	Gp+IQ3k=
X-Received: by 2002:a17:903:fa5:b0:2b2:5503:1b8c with SMTP id
 d9443c01a7336-2c6641634a6mr117416135ad.11.1781540195803; Mon, 15 Jun 2026
 09:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614171548.21200-1-kalevi@kolttonen.fi>
In-Reply-To: <20260614171548.21200-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 12:16:24 -0400
X-Gm-Features: AVVi8CfqopPrp2YxeVMXEYh_YYRaBePn5pwb8ZsZq0fogIU4Di9TOaRe5W_Cqg0
Message-ID: <CAEjxPJ53xXqyB0jhXLxkOZKjuaWidQTHdYKOHE6AbomX=bnTTQ@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: use bool instead of int
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 1:16=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  mcstrans/src/mcstransd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
> index 2d07b3af..f413e50e 100644
> --- a/mcstrans/src/mcstransd.c
> +++ b/mcstrans/src/mcstransd.c
> @@ -2,6 +2,7 @@
>  #include <errno.h>
>  #include <poll.h>
>  #include <signal.h>
> +#include <stdbool.h>
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -56,7 +57,7 @@
>
>  static int sockfd =3D -1; /* socket we are listening on */
>
> -static volatile int restart_daemon =3D 0;
> +static volatile bool restart_daemon =3D false;

I think this actually needs to be volatile sig_atomic_t in order to be
async-signal-safe.

>  static void cleanup_exit(int ret) __attribute__((noreturn));
>  static void cleanup_exit(int ret)
>  {
> @@ -421,7 +422,7 @@ static void process_connections(void)
>                                 syslog(LOG_ERR,
>                                        "No color information will be avai=
lable");
>                         }
> -                       restart_daemon =3D 0;
> +                       restart_daemon =3D false;
>                 }
>
>                 ret =3D poll(ufds, nfds, -1);
> @@ -450,7 +451,7 @@ static void sigterm_handler(int UNUSED(sig))
>
>  static void sighup_handler(int UNUSED(sig))
>  {
> -       restart_daemon =3D 1;
> +       restart_daemon =3D true;
>  }
>
>  static void initialize(void)
> @@ -551,11 +552,11 @@ static void usage(char *program)
>  int main(int argc, char *argv[])
>  {
>         int opt;
> -       int do_fork =3D 1;
> +       bool do_fork =3D true;
>         while ((opt =3D getopt(argc, argv, "hf")) > 0) {
>                 switch (opt) {
>                 case 'f':
> -                       do_fork =3D 0;
> +                       do_fork =3D false;
>                         break;
>                 case 'h':
>                         usage(argv[0]);
> --
> 2.54.0
>
>
