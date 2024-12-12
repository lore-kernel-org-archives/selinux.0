Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA876F307;
	Thu, 12 Dec 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013068; cv=none; b=IdgUzA//pB0j8wJNQf5MZzjcLMMYZAPsK/ch1RS6irj6lEgBmNwlTOdCtqIeGth7IROVEBdwYqrz53navrRZ5g7Ez0WILtBFAsLuHIJ2bL3rhCh+OYD+rsTZ1W9q0NqbJWXZbB0lAPPKNZHhsj7ckMaHIZL9s2NzSwP7Ml/kcFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013068; c=relaxed/simple;
	bh=lHbUfU4y2+BO7NIG5WB1RkII/mx8O/LypVpdrP4hAAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbH3gB/7DVqQDwJtJpWXnazFJ1bkN/1Ju/EalYxdA6ktkzLHfZGul+9BhYdduq58/5UggEejGtasxp7kq0vw6F8x+JBaMbU4jkzJovAccrcwCfjQK+iJ/dv3b383kP6qUcsfLMqIjKN218vfvBHPJNRpbTEpHJSDh2SVN9QO0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn5MJsc1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn5MJsc1"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725c86bbae7so585281b3a.3;
        Thu, 12 Dec 2024 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734013066; x=1734617866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGYw9nfrzbfYZOMxEgmfG5qBFYVP1Htt50/1ibbl19E=;
        b=Pn5MJsc1avRVW4ZRcsAwFXQpqg1VCmNwzKImlqZ5CTnbmAWIFogyfOdiRZ7H/sH261
         u/5jMaVvuyaVC3Gsl8kbArLvBqa2OM0snHqJmJkwKdIFVwHcpAbD7xIi/tgR/PeB12BP
         63JQgp1EA4t/K/qiye6IFjI/dzlHm6zohzlzwAhg7PNYAqho7tPXJDlREdlXbGc2qeVB
         Eh34+lAjm6PmC/QRYlloNGWswxdYHtPxo1CB9sHsJ0A7qAg9MnMn3riKcDeiBMgEIeDn
         OW/35c1xQ0kYM8NRsm2PHNSQKQZFzMBvBvhvdTt/bOUIwf5clBvGol7jb3OCva8cayAY
         EU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734013066; x=1734617866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGYw9nfrzbfYZOMxEgmfG5qBFYVP1Htt50/1ibbl19E=;
        b=G3vQHafgZDQSZtqGoHMWKE2pdEKOclIjDXTLEyxDeYNqWpIoc/6adSGQSmrYXRTZKb
         HwCoyQMdFgb1MtGS28J69q+IKJSYGAlubS07FaLte4loL+V/Y9Bl1QV7qYE4duFiWBmn
         II4xFZ0Ti+WZ02Lw2i89z6e6ZdleDv4oSlavleMpTiGXF07cZprW/1ebUO9ufQRhwtmU
         1Ho9ulAH1mQWWKUCkWqoWB66wgZ6ixstgwX8Y7bSBPSNbRpdOmRWNfcP0wNrb05rMZ8G
         Hg8ccII0qEPrGxtVddwx5pXIxcBw8SyDVaGMgXIrzEdDBD36YumfOR27UP0ThczFPQg+
         T4BA==
X-Forwarded-Encrypted: i=1; AJvYcCVdwWJpNmFMLNldO9TV+eGyLa4//megPu6onbk1WCcnDLGGa9ZIOeVfWsA6/yyI3gqbuBbUyoPVJMevXq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7qM/wZN0Ye0blbDLnl6lyyIK9BZbgFS+Mc8HfzoKSDWysvyL
	WKCictPFRoTlqbtiVmmQyI511RPwe5fog57SRnvnopkx0gAMt4anDISRNR0T/+hcsaeE+FXtvnp
	51SX7+V3Sxir1cL/ebOweVCbvyKk=
X-Gm-Gg: ASbGncuWA8h7sWDu0PN04KAsw8X6hpDDBoXdgujuUDObO1pEoSQ28XR9YmwLy2K6sEJ
	z1GugWrqfNwfYYqFbIGjy44xALX6v9Q0Www5B+w==
X-Google-Smtp-Source: AGHT+IG+KmHvYjgguramsPJOIZSFiKOXBRZKJaxnCkRz98fzxQ+EazTvZj+Eqt8FYfVvDbOgdJC6ZIC2xAkxkmZqcCw=
X-Received: by 2002:a05:6a00:3396:b0:725:b201:2353 with SMTP id
 d2e1a72fcca58-729069c8fbbmr636207b3a.13.1734013065898; Thu, 12 Dec 2024
 06:17:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405161042.260113-1-cgoettsche@seltendoof.de> <20241023152719.24118-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241023152719.24118-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Dec 2024 09:17:34 -0500
Message-ID: <CAEjxPJ4TXAEkOePLN48NaUYjCziJQcPOWkKDD-0Dek6t4U0rww@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add support for xperms in conditional policies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jacob Satterfield <jsatterfield.linux@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:27=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Add support for extended permission rules in conditional policies.
> Currently the kernel accepts such rules already, but evaluating a
> security decision will hit a BUG() in
> services_compute_xperms_decision().  Thus reject extended permission
> rules in conditional policies for current policy versions.
>
> Add a new policy version for this feature.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2:
>   rebased onto the netlink xperm patch
> ---
>  security/selinux/include/security.h |  3 ++-
>  security/selinux/ss/avtab.c         | 11 +++++++++--
>  security/selinux/ss/avtab.h         |  2 +-
>  security/selinux/ss/conditional.c   |  2 +-
>  security/selinux/ss/policydb.c      |  5 +++++
>  security/selinux/ss/services.c      | 12 ++++++++----
>  6 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index c7f2731abd03..10949df22fa4 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -46,10 +46,11 @@
>  #define POLICYDB_VERSION_INFINIBAND         31
>  #define POLICYDB_VERSION_GLBLUB                     32
>  #define POLICYDB_VERSION_COMP_FTRANS        33 /* compressed filename tr=
ansitions */
> +#define POLICYDB_VERSION_COND_XPERMS        34 /* extended permissions i=
n conditional policies */
>
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
> -#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COMP_FTRANS
> +#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COND_XPERMS
>
>  /* Mask for just the mount related flags */
>  #define SE_MNTMASK 0x0f
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 8e400dd736b7..83add633f92a 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -339,7 +339,7 @@ static const uint16_t spec_order[] =3D {
>  int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>                     int (*insertf)(struct avtab *a, const struct avtab_ke=
y *k,
>                                    const struct avtab_datum *d, void *p),
> -                   void *p)
> +                   void *p, bool conditional)
>  {
>         __le16 buf16[4];
>         u16 enabled;
> @@ -457,6 +457,13 @@ int avtab_read_item(struct avtab *a, void *fp, struc=
t policydb *pol,
>                        "was specified\n",
>                        vers);
>                 return -EINVAL;
> +       } else if ((vers < POLICYDB_VERSION_COND_XPERMS) &&
> +                  (key.specified & AVTAB_XPERMS) && conditional) {
> +               pr_err("SELinux:  avtab:  policy version %u does not "
> +                      "support extended permissions rules in conditional=
 "
> +                      "policies and one was specified\n",
> +                      vers);
> +               return -EINVAL;
>         } else if (key.specified & AVTAB_XPERMS) {
>                 memset(&xperms, 0, sizeof(struct avtab_extended_perms));
>                 rc =3D next_entry(&xperms.specified, fp, sizeof(u8));
> @@ -523,7 +530,7 @@ int avtab_read(struct avtab *a, void *fp, struct poli=
cydb *pol)
>                 goto bad;
>
>         for (i =3D 0; i < nel; i++) {
> -               rc =3D avtab_read_item(a, fp, pol, avtab_insertf, NULL);
> +               rc =3D avtab_read_item(a, fp, pol, avtab_insertf, NULL, f=
alse);
>                 if (rc) {
>                         if (rc =3D=3D -ENOMEM)
>                                 pr_err("SELinux: avtab: out of memory\n")=
;
> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index f4407185401c..a7cbb80a11eb 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -108,7 +108,7 @@ struct policydb;
>  int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>                     int (*insert)(struct avtab *a, const struct avtab_key=
 *k,
>                                   const struct avtab_datum *d, void *p),
> -                   void *p);
> +                   void *p, bool conditional);
>
>  int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
>  int avtab_write_item(struct policydb *p, const struct avtab_node *cur,
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/cond=
itional.c
> index 64ba95e40a6f..c9a3060f08a4 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -349,7 +349,7 @@ static int cond_read_av_list(struct policydb *p, void=
 *fp,
>         for (i =3D 0; i < len; i++) {
>                 data.dst =3D &list->nodes[i];
>                 rc =3D avtab_read_item(&p->te_cond_avtab, fp, p, cond_ins=
ertf,
> -                                    &data);
> +                                    &data, true);
>                 if (rc) {
>                         kfree(list->nodes);
>                         list->nodes =3D NULL;
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 383f3ae82a73..3ba5506a3fff 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -155,6 +155,11 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>                 .sym_num =3D SYM_NUM,
>                 .ocon_num =3D OCON_NUM,
>         },
> +       {
> +               .version =3D POLICYDB_VERSION_COND_XPERMS,
> +               .sym_num =3D SYM_NUM,
> +               .ocon_num =3D OCON_NUM,
> +       },
>  };
>
>  static const struct policydb_compat_info *
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 9652aec400cb..66d2472d3874 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -946,7 +946,7 @@ static void avd_init(struct selinux_policy *policy, s=
truct av_decision *avd)
>  }
>
>  static void update_xperms_extended_data(u8 specified,
> -                                       struct extended_perms_data *from,
> +                                       const struct extended_perms_data =
*from,
>                                         struct extended_perms_data *xp_da=
ta)
>  {
>         unsigned int i;
> @@ -967,6 +967,8 @@ static void update_xperms_extended_data(u8 specified,
>  void services_compute_xperms_decision(struct extended_perms_decision *xp=
ermd,
>                                         struct avtab_node *node)
>  {
> +       u16 specified;
> +
>         switch (node->datum.u.xperms->specified) {
>         case AVTAB_XPERMS_IOCTLFUNCTION:
>         case AVTAB_XPERMS_NLMSG:
> @@ -982,17 +984,19 @@ void services_compute_xperms_decision(struct extend=
ed_perms_decision *xpermd,
>                 BUG();
>         }
>
> -       if (node->key.specified =3D=3D AVTAB_XPERMS_ALLOWED) {
> +       specified =3D node->key.specified & ~(AVTAB_ENABLED | AVTAB_ENABL=
ED_OLD);
> +
> +       if (specified =3D=3D AVTAB_XPERMS_ALLOWED) {
>                 xpermd->used |=3D XPERMS_ALLOWED;
>                 update_xperms_extended_data(node->datum.u.xperms->specifi=
ed,
>                                             &node->datum.u.xperms->perms,
>                                             xpermd->allowed);
> -       } else if (node->key.specified =3D=3D AVTAB_XPERMS_AUDITALLOW) {
> +       } else if (specified =3D=3D AVTAB_XPERMS_AUDITALLOW) {
>                 xpermd->used |=3D XPERMS_AUDITALLOW;
>                 update_xperms_extended_data(node->datum.u.xperms->specifi=
ed,
>                                             &node->datum.u.xperms->perms,
>                                             xpermd->auditallow);
> -       } else if (node->key.specified =3D=3D AVTAB_XPERMS_DONTAUDIT) {
> +       } else if (specified =3D=3D AVTAB_XPERMS_DONTAUDIT) {
>                 xpermd->used |=3D XPERMS_DONTAUDIT;
>                 update_xperms_extended_data(node->datum.u.xperms->specifi=
ed,
>                                             &node->datum.u.xperms->perms,
> --
> 2.45.2
>
