Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA9340404
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535431; cv=pass; b=T0KmSBcoCWBC4TWXAHVGfaZm+hnWaR/5qGZmpZX1bfa6Q/6I3MAq2Tt+EMrDaE95/krsQrmJMy7yTu4gMME4sRhIQcjOlUhnKyn/IPj9QpJPssfg/n4zfpdCxHQy080B/R7OqYJMxT9XxYrb8URtmB8oXjMOG85GlHM4itGdGjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535431; c=relaxed/simple;
	bh=+qcvrT1ARsbOgYNt7HIufChD5J1jmg/0CWKvBfJjmSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nr67Z5iCmCw4MVdqTF+qa5JrGWmE9p+txn9yzDYhM1XgvcFHTesfrS5j8EQ0peUdvrlvGXjW7aWo4N7EppfxxPLG78+0lu0kSPaCZAdhNVqC70lCvyFNBt7OdtWDQd2XOs1oTlHTXXJxdfxcnPjj3Y+1BMdtVIJ1eiU6iH82WBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pL9e8Ks3; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL9e8Ks3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so27467505ad.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 07:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535429; cv=none;
        d=google.com; s=arc-20240605;
        b=J7rAYUga9H8kUFcXXRqO//2VbRvGsTtDJm8vpVs6rMnF31AKwDWKRoO4M9Z17IOAv0
         alArtoD8hJxT1mqSn1fztiyQdAUmCD3ml3GG6u8JgOWUyOpFAq3zdNy2JRPi5I64A0AU
         kN6QsfjCFE3fbscSXA4mw0uZy85B9IxQ+HTrHtwprXQtEmA0MsQjrxSua4B/eOOCEAZg
         JI4Lt44traj9JCBUJ7U2C+l8AWhGslz+KrpsOqh9GfpdIxNOZJctTWqOE5QpQbpYucrX
         P3G2yOstvpmfmyaGzOo2f9lZLOrWVHOvM9aXu2za1QBiknbeah74mlXi6E3FlPbwnrAH
         oZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L1qQqXp5P2ISz3RRgHWW4I93RfhmxezWGjJxmbZi/y0=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=P8oNHH3wbkLwf0oG7XFxQHy5wh9cozSSqPV8NTxUBQGZm5qR1HRr5T6w3OFCXJB7oB
         sxfxzzuiBEaU3LVz5lLLAYEqdLYkHCjLBiV4SfnbF84Ybigzs/+NuP0+jUq4E8c5ZIVJ
         +MWb4kjNrVW7YdIVemk4uZvhUuBx7Hlf+6fCpk0yfBl1V2Eog5lNAGZVlJj5Z2+5vQ7Z
         iAr6roKm0UtnU+lO2orCU+/K9k6VWjKHdFdeIdvzAZtAKrOdtjIsattTTWcJXlUPYJs3
         4DdZ+NswGMm+C84KZPESC98OAvcIzcpOZ9WnvmDvZFPhSyfjfndBqcEWvgB4keWP0Q1W
         gzrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535429; x=1782140229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1qQqXp5P2ISz3RRgHWW4I93RfhmxezWGjJxmbZi/y0=;
        b=pL9e8Ks3Ln+2Tm0A2er1S/4h1YXTm0hGuY7SH95Ogi+2zwoPQX3WjFvOKwhuhvDJuS
         wLWWGCGfg3w5KacfobcCONvO8f0v1iJxf6JB3WpfbGXz21Wg2u0yYmsneRpjfNRHwzXu
         j6FHNFZedWUnFV3uQ+aT9Tu/pJGoT4pBMazC9m6TMZ6+OPWi5pKe0TZgJbuYIQgJd77L
         4SzFIcyKkyRJDSTjbX+Dnk+7RDXwlMisSOe1zdQ3peQzzdGfk/vAH5IrU1D26hlxbekc
         1myXSSZoAzlf++mGGr+X0B+PT9k06BVBdk1pgMfrDGgpdug/KpTtQ0G1gLWczreTd2pe
         Q8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535429; x=1782140229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L1qQqXp5P2ISz3RRgHWW4I93RfhmxezWGjJxmbZi/y0=;
        b=dLHiH/j9xW+SGl20tPsgMUqN0ZER5sZaVmRL0LTUK6E9UnzfGDBjz4nfbitq3gR8tA
         ee69LlgYRjuav7yln0lTT0BBCnLYKDIjAdf9flhvKOMlG0VeFVcgsdpcFwSiShe4qyg2
         mbdmujg4DfayHGy/l9BgnbirNmeyYqYupziCG59PURKuFbnDzyz2khXTx/8YAeKhGFHM
         y6aYm8TO+yRMMqiieGme54MxtEZyLQqAC9Q/EvZFzI5bS3IwJ6dPhqycGQvjsLBNyCgP
         M/gm0LIhXLk5q6eLy6+Zm4LcSdaOeYnkCogBmUGwGHiBBBo9ndvk/Fn2UF26ZqAOhxEX
         Fo3Q==
X-Gm-Message-State: AOJu0YyroQ1WM8FM9w4MVB+6A0VG2Q3120dIPX9eZ1QHKPBHF9w88GQp
	kebN/dZ6qmXIga32ek0/qLsQGmrltg67MB5ZMUQIgQlf0TrJf9H+5T2KVWetEHvDQ0YDrSk2ujx
	BbmJ0X+FlCzzTSrKNLtKYY1HsEd+gJOs=
X-Gm-Gg: Acq92OGwagier8nAOzGUtA604EOV/ATjkkhggpRLs5E0Wi+shJTIVb9TBg+gHNhyraB
	Q5Xksidw6SnuuzFqq9A2G/MHlL6AR9ABxc6cwDs9foULIDRcqsIOzFifG1hUzF/4eiLVfvces6p
	zLUiKf+U75ywFHWtBnvbipU0cnpyDHs0KFk/lcz4/2X5kLAvRAJ7bgVI7XIppbUJorxUdR2r+uu
	yT/KlEUy/iQGFgxcMh3jfJZTktmQlYXbf4hruZqLV2LgEbqUTlb8zOoDISd1WRR7p0B2xB6xsPk
	Eb2Ol2Y=
X-Received: by 2002:a17:902:d4cf:b0:2bf:77b2:8b2d with SMTP id
 d9443c01a7336-2c4130100a2mr162745455ad.30.1781535429373; Mon, 15 Jun 2026
 07:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614143645.55809-1-kalevi@kolttonen.fi> <20260614143645.55809-3-kalevi@kolttonen.fi>
In-Reply-To: <20260614143645.55809-3-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 10:56:57 -0400
X-Gm-Features: AVVi8CdTrXRdvo3SHrZtiH6LyD-NZid9djG3HA-64O57R_SLcSYZWA-jJ9I8dkA
Message-ID: <CAEjxPJ4sxCum_upKnfFqwcFuEhQyp65fWzxcA7SQZgVDV+R3ig@mail.gmail.com>
Subject: Re: [PATCH 2/2] policycoreutils: check strdup() failure
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 10:37=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/secon/secon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.=
c
> index 6d4bff94..48daf9d5 100644
> --- a/policycoreutils/secon/secon.c
> +++ b/policycoreutils/secon/secon.c
> @@ -516,8 +516,11 @@ static char *get_scon(void)
>                             " Couldn't get security context for pid %lu",
>                             (unsigned long)opts->f.pid);
>
> -               if (!con)
> +               if (!con) {
>                         con =3D strdup(dummy_NIL);
> +                       if (!con)
> +                               err(EXIT_FAILURE, "Out of memory");
> +               }
>                 break;
>
>         case OPTS_FROM_FILE:
> --
> 2.54.0
>
>
