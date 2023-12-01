Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqPk25TI"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D76F10C2
	for <selinux@vger.kernel.org>; Fri,  1 Dec 2023 11:53:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bc501081fso3733718e87.1
        for <selinux@vger.kernel.org>; Fri, 01 Dec 2023 11:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701460389; x=1702065189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+8FeZzXeBazpSVRAdPhvvU2U5XJa5OZkBDnxgtiTpU=;
        b=DqPk25TIIgbt44UE0r015Fzv5S7G18lA9X1JfhhN2zWGA0LgQLOLb/fr2CE5aIPHKP
         qyi1aIurXYrX4AsR2YBJkZH6SxkPZ0SStYPRXSnmFAw1AseZXZ4Dv7mICpygSCkS+zlq
         iaM0v32okdIQBQrxCA3SP4gV2ai//v9TwOxSOwapqerIJdesHsIuhaU/peGONAl72ikR
         9GN0MQjjhl38lbjiVT/KMiK8XqavsFejXamWfO3Vzkk4M8fBD53yd0NIDJQYt+ep91uq
         tGpcvIoAaSO/RxG5QX64e0MFSQFGpEAPMdzhgq3xFhUS3wcSYCIVBd+6nfRD2k/rqSO6
         cGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701460389; x=1702065189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+8FeZzXeBazpSVRAdPhvvU2U5XJa5OZkBDnxgtiTpU=;
        b=ccLPkS67BM51ALApqdBQJVwrRWIzTSZpbqzWHGcs+D4gzI3QGbpJY76Nz2EY0WkQgy
         s1frsT7FwpcAfZIvrWUqstZWPhimtdYEDnEkxdpISsg1GlcZQ160STmmU5TfSmgi+an3
         MYgpWdT5gEqMC0B7RX0sUSzqeeC4c5T46mBiMKl36+nWJTlru/+wqcaVRnFxmtYe69Rf
         r+16uOHX2SuTSWZfDuY4TPBX4EWRwhIFTFbv1CTYgeLCnr6zO+jdrBnq4RRj+FFBKp/s
         /ypWUJby9kT/129uorUTiRwS1TbyqJvaEt0XNzpAkhHIYbFk8dpzPe+B5bMJ7KdgTpQI
         cq+g==
X-Gm-Message-State: AOJu0YyoKJZGa3tMITHchwFURrH+fPLEpov9UI52HBdB5MX2/dwEHcia
	Fx1JpJTg4TeNXE7tNerQJZWq59RMR76rHwh3wf1bjW4UUeA=
X-Google-Smtp-Source: AGHT+IFj1wHauzx1OdzD4uFH1O0w8Jrc1OCDDqPAhOzcPVewZXgb9/17sHVYxcAwixfdCZRYPt4Uyg+OX/9m+g9rQzE=
X-Received: by 2002:a19:7016:0:b0:50b:d763:fe49 with SMTP id
 h22-20020a197016000000b0050bd763fe49mr1140509lfc.100.1701460389151; Fri, 01
 Dec 2023 11:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128182334.57740-1-cgzones@googlemail.com>
In-Reply-To: <20231128182334.57740-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 1 Dec 2023 14:52:57 -0500
Message-ID: <CAP+JOzTv8z-KNJ28iqNddSp3rajQi8X8RmLoO-2by+Xv=_RvUQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] libsepol: validate conditional type rules have a
 simple default type
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 1:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Similar to unconditional avtab keys check the default type of type av
> rules are a simple type, not an attribute.
> Since extended permission rules are not allowed in conditional policies
> this check does not need to be performed.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For every patch except for patch 4.
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 8b87675f..c2f19fa0 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -885,14 +885,21 @@ static int validate_cond_av_list(sepol_handle_t *ha=
ndle, const cond_av_list_t *c
>
>         for (; cond_av; cond_av =3D cond_av->next) {
>                 for (avtab_ptr =3D cond_av->node; avtab_ptr; avtab_ptr =
=3D avtab_ptr->next) {
> -                       if (validate_avtab_key(&avtab_ptr->key, 1, p, fla=
vors)) {
> -                               ERR(handle, "Invalid cond av list");
> -                               return -1;
> -                       }
> +                       const avtab_key_t *key =3D &avtab_ptr->key;
> +                       const avtab_datum_t *datum =3D &avtab_ptr->datum;
> +
> +                       if (validate_avtab_key(key, 1, p, flavors))
> +                               goto bad;
> +                       if ((key->specified & AVTAB_TYPE) && validate_sim=
pletype(datum->data, p, flavors))
> +                               goto bad;
>                 }
>         }
>
>         return 0;
> +
> +bad:
> +       ERR(handle, "Invalid cond av list");
> +       return -1;
>  }
>
>  static int validate_avrules(sepol_handle_t *handle, const avrule_t *avru=
le, int conditional, const policydb_t *p, validate_t flavors[])
> --
> 2.43.0
>
>
