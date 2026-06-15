Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BBE379EDA
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549227; cv=pass; b=eQDdjw4oiuJEVydcMMw0bPqxjtk8vl9CyNe4W9MEkMy3bvBpG48v1hnsROdWlLPRMuBaFQp6WkQLnfh6Z3ef2MBgOKSXN+8nzv2YRW7IUcn4rpcPma20praU86z3WpV80HBO+Vj9iiVbPJJTJH2W2gyXaZVSCbsAgS5Ar7hSgoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549227; c=relaxed/simple;
	bh=wSbZt9BJX0fNPrASseKvk1X1/UdOOaA+h35NOi/TDHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3Hmk4d2cEvG6bEGoZM6gBOYvWM41859+lEweewZ1uZY4dWaiN8neUWiL/QQHa23Q88h0J9bT6xpAKSFgmpDo7OU3h4K1stjT67HPcW82/hOe820oThWWrC/qWFIpVZbtBgupvs2mSr95cy92hz3lZeIUnM/uZiGiI+3XPYtEDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGYw5Mtp; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGYw5Mtp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso2319031a91.0
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 11:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781549225; cv=none;
        d=google.com; s=arc-20240605;
        b=LByI1rs23LEnaUHN1dkJEbUjmAcgh03iRlzBHvqrPMAKVCDyPdFmGWAA2K+17Te467
         gH4SFmTSFKarEsoNhBVnPhwv6pBKjoZ+esRc0GebqAC53ufk3pVhvuFB7EttdU05S/+z
         QO5IW29DFKZpXBuQaJr920GUs78AeoXoEbS//+vl8WjTboYD764utOKk9ldcA/28lsjx
         5yDxldCvMVriC2MaOUFTn7sGkJrC0qy62c4Abxzpq1c9xYSDJ16wXo/tk0GYpviEIp6w
         UedEARtXMW3jwAZAnddi0pY25CpN48tWpxgLS3iHujptOGZlNwBHALHFeofh3n1rp+dQ
         /LBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j/URNl9fW1LhjYm68MukWc4syba1ZK7iIKvC6EQzpvw=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=Ofmy17zJb2wmnDEjdlXqFzNKo9BDjQHrHzGVk6RFc/cvKAwBYdIpau+qsSPI7IbbHN
         Hydx+fbs9ix7RUPBAbiTio7AH77UmDCsc9Ju4jfI40Q1sys4Qb7CeJQsQ1k8kydH5O+U
         Ip69DbptkjB94UEQQYshHL4AiivEG8N8WDJKWCKLYCN2vriIiKt0tkdz1tBTLAg1949H
         goZIFyiul2HBoetXx/t0P/A8oPWaOcZeyhbWYYxcrWmuOxf5s6f7KVNFagTriE1Uf2Ku
         Jjup9p0beumZJr/+TVip0TvEZ2UUXBnSaHXOFctKtqUxdO+1/FFTI+mI6wv3NYUuyz8W
         dJXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781549225; x=1782154025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/URNl9fW1LhjYm68MukWc4syba1ZK7iIKvC6EQzpvw=;
        b=QGYw5MtpNyz4LQCsMZ7t5S46MqXWwhapr6/0RIRFzglphVEajnrZmTq3Afq1kPCsHQ
         KirxYH+i7GqwQSp8GUIktkvG27kCxNDR0AtJYHbCuOkfmfLddMdHxrXnSP2S08rwvYT8
         YmgRDZUQ0dQI1CeJTIgPJekDEKP+hMQXBJzQnBXsVegVZMDZRCl5b6N+Ex5U5ecoLbpZ
         UnHNRtidAnWw7NeI/96QlHhWs/Xa5+Ns2a7p5Yry0YJ6rrzFWQsSP0i7J257ur5uQSN4
         oDhec7r1/cLC7ZtNPm7dKu1z5l36YFjws6ATY9lv/X8alIm//e4J1bfjbYAPhYa9oLEX
         TwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781549225; x=1782154025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/URNl9fW1LhjYm68MukWc4syba1ZK7iIKvC6EQzpvw=;
        b=NghFOjFVJuJC9evSkNBevuuHTU+M9MfK1wOF4HMDF/oM7uL9JRNDDdKGih7NJMrqST
         zh0jH89muIQEyg/4ZBxF18lzlDXJG0XYQ0qzOTpgxM2A2NaMqgSuL+uPvbrkHG7GgANk
         gknEKbS5e5bx/eU2ggNkCBwtipHHIQuMwPQQjud6VKVX6LaxK2YRmwHS2U85Mk+nL43m
         pvctcb3MnOX5LhT0Xq6aGATjalbKnHQGiZIDXsj09gtmxC/58lWr1WL882XdzPyp3g+G
         AWfgP2e/wO6eMz05bPF3RYTLk7K2HQIgPzIdp2GRe+TwodYnfAdqWeo8757kUGosNwDH
         nEqQ==
X-Gm-Message-State: AOJu0YxeIufG9KtaIWR/DU4EYmJXG8BbZcz1y2xV2Y4hFtCXDFjQ+3uJ
	lWPDdQa425d7iu8CzQfSQlPMlaSO3S4U+//e0qh6+0QETxUOrUWwXz0KFIY249J2Uye+qG5RT70
	7iu5e7+sWMqkwXMEj+wXFo/Qj9BdotwdvGA==
X-Gm-Gg: Acq92OG1YmpCt5qhqamXxZyUAueJrj2CXwa8OsypaR/DpAqWf1Hs7GwI/b0U9HZfFOQ
	APAqvEIR75mcyW5akJXfJnCHmw+rY27whRfvae93lk8XCpm35z/zaJlP8ck4AYbrqqBzMJxz+Hy
	CJn9ZozgpWVzjhIXtQAdfGMBJu5A4XmoZnOcoULPM8TWT6bU7HAkQFlLz0ylCJp87c7Zf92NaFD
	fDSlBTvFvWvoolfoakYYYE3KTZFlvWWxzqhHx5x0E5OoBxNYFbW207liThfMhMcY0dF36FEDMU6
	SRdiGh8=
X-Received: by 2002:a17:90b:5627:b0:36b:9835:cf96 with SMTP id
 98e67ed59e1d1-37a01e2fbecmr15848694a91.2.1781549225315; Mon, 15 Jun 2026
 11:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615163937.38919-1-kalevi@kolttonen.fi> <CAEjxPJ6L3ip0q3ivXxEzbaDhPWFhcwMhYhUiHs_jJS=OpGgHvg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6L3ip0q3ivXxEzbaDhPWFhcwMhYhUiHs_jJS=OpGgHvg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 14:46:53 -0400
X-Gm-Features: AVVi8CfVWkFfz4Mcgp6bqHfA3OGtY7UChV3AQY4ep4UQlNOwFKaQSEtBnu4kcSU
Message-ID: <CAEjxPJ5uNQOy1MKmhB6Fw7XbYz6R+A0gFw130U6YENM-pRzRdQ@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: use sig_atomic_t and bool instead of int
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 1:04=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 15, 2026 at 12:42=E2=80=AFPM Kalevi Kolttonen <kalevi@koltton=
en.fi> wrote:
> >
> > Use sig_atomic_t to be async signal safe. Use bool instead
> > of int to make boolean intent clearer.
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

The entire series has been merged.

>
> > ---
> >  mcstrans/src/mcstransd.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
> > index 2d07b3af..5bdaadb7 100644
> > --- a/mcstrans/src/mcstransd.c
> > +++ b/mcstrans/src/mcstransd.c
> > @@ -2,6 +2,7 @@
> >  #include <errno.h>
> >  #include <poll.h>
> >  #include <signal.h>
> > +#include <stdbool.h>
> >  #include <stdint.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > @@ -56,7 +57,7 @@
> >
> >  static int sockfd =3D -1; /* socket we are listening on */
> >
> > -static volatile int restart_daemon =3D 0;
> > +static volatile sig_atomic_t restart_daemon =3D false;
> >  static void cleanup_exit(int ret) __attribute__((noreturn));
> >  static void cleanup_exit(int ret)
> >  {
> > @@ -421,7 +422,7 @@ static void process_connections(void)
> >                                 syslog(LOG_ERR,
> >                                        "No color information will be av=
ailable");
> >                         }
> > -                       restart_daemon =3D 0;
> > +                       restart_daemon =3D false;
> >                 }
> >
> >                 ret =3D poll(ufds, nfds, -1);
> > @@ -450,7 +451,7 @@ static void sigterm_handler(int UNUSED(sig))
> >
> >  static void sighup_handler(int UNUSED(sig))
> >  {
> > -       restart_daemon =3D 1;
> > +       restart_daemon =3D true;
> >  }
> >
> >  static void initialize(void)
> > @@ -551,11 +552,11 @@ static void usage(char *program)
> >  int main(int argc, char *argv[])
> >  {
> >         int opt;
> > -       int do_fork =3D 1;
> > +       bool do_fork =3D true;
> >         while ((opt =3D getopt(argc, argv, "hf")) > 0) {
> >                 switch (opt) {
> >                 case 'f':
> > -                       do_fork =3D 0;
> > +                       do_fork =3D false;
> >                         break;
> >                 case 'h':
> >                         usage(argv[0]);
> > --
> > 2.54.0
> >
> >
