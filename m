Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAc8o83t"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACEBCA
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 08:45:34 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50c05ea5805so6992752e87.0
        for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 08:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702399528; x=1703004328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zUwHp/rVfQ+WhN2xsrkbjhsNyTMlKs3VKwla38OAUg=;
        b=FAc8o83tyvYFRTgh7tH2D2el3wgSuXao5b09tBN16DQNXrqRqDRpmZwZLIldxjzz6W
         NTcAdRiTaJ6FnF78VpD/0Jc8PEewwcjLvIzuZSzIy2393ebye23Ke+GtkrZErxj5hmKv
         0Wxts7qhVBcAZdNR3xUb5CD+h6Y0AKhpIxvdTGR6RyloTOEECJYMU7J0P0ccoVQE8z2F
         HLrnOgUscrOMh5q9n9JbjBdrhjYYDHjY57zwiK3XwLBGxCT8shpkRM/c882WQ8o2wNkq
         ZSuUfxTKEVDe+NtDhqnFz2nENBuPWRzRAQK3y1msTwAbvMM0hVna+mwbCNoM2K/rOmE/
         jjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399528; x=1703004328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zUwHp/rVfQ+WhN2xsrkbjhsNyTMlKs3VKwla38OAUg=;
        b=GvOj3gnz4Fz6NYd0enw6JLMAuVvXc1u6t+SKC2M8FU96jd0SJH+QNkzrWXc64tDxdv
         2HoWT4oDtGkB9TwtjgZE+HAWo8kC2zpztelQWHdJSK2jtruzpevDbteIIVMhRJzLjXJb
         Qh1II9lfQr7Z9T6QfCsRvMeM3UvTuqN30dORD1gOaasWlX2QL9yRDHefoM8lXsAtKJpX
         Voi8r9LKr+ty9NIRecqStjioidNFxOnfFW+606fuxeZfryNxB8NkmF2VcYwVZt6WZmHO
         E/3iGnHG4m7ltjYLlOqUFSQRCuY0HJnh178bkJO+PmIz1glEhwKDk7AoLwJ2FN+I7Xmh
         c3Fg==
X-Gm-Message-State: AOJu0Yx9qriQUrVlS6xIHUSqitIoNQ9m5YvlIET/SqeupNtQ4P6ljSPp
	0BcCr8AKuxhQW7xZJK9EDWTp6zJW75rh130CC/M=
X-Google-Smtp-Source: AGHT+IHm+DMEGEPzQu5Fk0SegcGhX9YWl6EstZu4EGxN5AlGaJAXJ6jUCoud/+I0nepkP5x6r76Gc5MdFL+7N0iv1Bw=
X-Received: by 2002:a05:6512:3d9e:b0:50b:fe1f:4d35 with SMTP id
 k30-20020a0565123d9e00b0050bfe1f4d35mr3636151lfv.26.1702399528128; Tue, 12
 Dec 2023 08:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211150031.127850-1-cgzones@googlemail.com> <CAP+JOzQ1YHRwKb1JD=sS-M=JK9xZdnkbsBdBsk90hWTAXyhJpA@mail.gmail.com>
In-Reply-To: <CAP+JOzQ1YHRwKb1JD=sS-M=JK9xZdnkbsBdBsk90hWTAXyhJpA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 Dec 2023 11:45:16 -0500
Message-ID: <CAP+JOzQcT81K_Yb3fkVFb89Ebq3XfU2nzFgiyM5DB2HABuj-ug@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: update const qualifier of parameters in
 man pages
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:24=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Dec 11, 2023 at 10:00=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add missing const qualifier to parameters in the man pages to align the=
m
> > with <selinux/selinux.h>.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/man/man3/getexeccon.3          |  4 +--
> >  libselinux/man/man3/security_compute_av.3 | 32 +++++++++++------------
> >  2 files changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/get=
execcon.3
> > index d6222a4f..9cc24e8c 100644
> > --- a/libselinux/man/man3/getexeccon.3
> > +++ b/libselinux/man/man3/getexeccon.3
> > @@ -11,9 +11,9 @@ rpm_execcon \- run a helper for rpm in an appropriate=
 security context
> >  .sp
> >  .BI "int getexeccon_raw(char **" context );
> >  .sp
> > -.BI "int setexeccon(char *" context );
> > +.BI "int setexeccon(const char *" context );
> >  .sp
> > -.BI "int setexeccon_raw(char *" context );
> > +.BI "int setexeccon_raw(const char *" context );
> >  .sp
> >  .BI "int setexecfilecon(const char *" filename ", const char *" fallba=
ck_type );
> >  .sp
> > diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man=
/man3/security_compute_av.3
> > index efa4baf3..6c82eca5 100644
> > --- a/libselinux/man/man3/security_compute_av.3
> > +++ b/libselinux/man/man3/security_compute_av.3
> > @@ -7,37 +7,37 @@ the SELinux policy database in the kernel
> >  .SH "SYNOPSIS"
> >  .B #include <selinux/selinux.h>
> >  .sp
> > -.BI "int security_compute_av(char *" scon ", char *" tcon ", security_=
class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd =
);
> > +.BI "int security_compute_av(const char *" scon ", const char *" tcon =
", security_class_t "tclass ", access_vector_t "requested ", struct av_deci=
sion *" avd );
> >  .sp
> > -.BI "int security_compute_av_raw(char *" scon ", char *" tcon ", secur=
ity_class_t "tclass ", access_vector_t "requested ", struct av_decision *" =
avd );
> > +.BI "int security_compute_av_raw(const char *" scon ", const char *" t=
con ", security_class_t "tclass ", access_vector_t "requested ", struct av_=
decision *" avd );
> >  .sp
> > -.BI "int security_compute_av_flags(char *" scon ", char *" tcon ", sec=
urity_class_t "tclass ", access_vector_t "requested ", struct av_decision *=
" avd );
> > +.BI "int security_compute_av_flags(const char *" scon ", const char *"=
 tcon ", security_class_t "tclass ", access_vector_t "requested ", struct a=
v_decision *" avd );
> >  .sp
> > -.BI "int security_compute_av_flags_raw(char *" scon ", char *" tcon ",=
 security_class_t "tclass ", access_vector_t "requested ", struct av_decisi=
on *" avd );
> > +.BI "int security_compute_av_flags_raw(const char *" scon ", const cha=
r *" tcon ", security_class_t "tclass ", access_vector_t "requested ", stru=
ct av_decision *" avd );
> >  .sp
> > -.BI "int security_compute_create(char *" scon ", char *" tcon ", secur=
ity_class_t "tclass ", char **" newcon );
> > +.BI "int security_compute_create(const char *" scon ", const char *" t=
con ", security_class_t "tclass ", char **" newcon );
> >  .sp
> > -.BI "int security_compute_create_raw(char *" scon ", char *" tcon ", s=
ecurity_class_t "tclass ", char **" newcon );
> > +.BI "int security_compute_create_raw(const char *" scon ", const char =
*" tcon ", security_class_t "tclass ", char **" newcon );
> >  .sp
> > -.BI "int security_compute_create_name(char *" scon ", char *" tcon ", =
security_class_t "tclass ", const char *" objname ", char **" newcon );
> > +.BI "int security_compute_create_name(const char *" scon ", const char=
 *" tcon ", security_class_t "tclass ", const char *" objname ", char **" n=
ewcon );
> >  .sp
> > -.BI "int security_compute_create_name_raw(char *" scon ", char *" tcon=
 ", security_class_t "tclass ", const char *" objname ", char **" newcon );
> > +.BI "int security_compute_create_name_raw(const char *" scon ", const =
char *" tcon ", security_class_t "tclass ", const char *" objname ", char *=
*" newcon );
> >  .sp
> > -.BI "int security_compute_relabel(char *" scon ", char *" tcon ", secu=
rity_class_t "tclass ", char **" newcon );
> > +.BI "int security_compute_relabel(const char *" scon ", const char *" =
tcon ", security_class_t "tclass ", char **" newcon );
> >  .sp
> > -.BI "int security_compute_relabel_raw(char *" scon ", char *" tcon ", =
security_class_t "tclass ", char **" newcon );
> > +.BI "int security_compute_relabel_raw(const char *" scon ", const char=
 *" tcon ", security_class_t "tclass ", char **" newcon );
> >  .sp
> > -.BI "int security_compute_member(char *" scon ", char *" tcon ", secur=
ity_class_t "tclass ", char **" newcon );
> > +.BI "int security_compute_member(const char *" scon ", const char *" t=
con ", security_class_t "tclass ", char **" newcon );
> >  .sp
> > -.BI "int security_compute_member_raw(char *" scon ", char *" tcon ", s=
ecurity_class_t "tclass ", char **" newcon );
> > +.BI "int security_compute_member_raw(const char *" scon ", const char =
*" tcon ", security_class_t "tclass ", char **" newcon );
> >  .sp
> > -.BI "int security_compute_user(char *" scon ", const char *" username =
", char ***" con );
> > +.BI "int security_compute_user(const char *" scon ", const char *" use=
rname ", char ***" con );
> >  .sp
> > -.BI "int security_compute_user_raw(char *" scon ", const char *" usern=
ame ", char ***" con );
> > +.BI "int security_compute_user_raw(const char *" scon ", const char *"=
 username ", char ***" con );
> >  .sp
> > -.BI "int security_validatetrans(char *" scon ", const char *" tcon ", =
security_class_t "tclass ", char *" newcon );
> > +.BI "int security_validatetrans(const char *" scon ", const char *" tc=
on ", security_class_t "tclass ", const char *" newcon );
> >  .sp
> > -.BI "int security_validatetrans_raw(char *" scon ", const char *" tcon=
 ", security_class_t "tclass ", char *" newcon );
> > +.BI "int security_validatetrans_raw(const char *" scon ", const char *=
" tcon ", security_class_t "tclass ", const char *" newcon );
> >  .sp
> >  .BI "int security_get_initial_context(const char *" name ", char **" c=
on );
> >  .sp
> > --
> > 2.43.0
> >
> >
