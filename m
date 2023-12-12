Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnNHHzrs"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E528F
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 06:24:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bfd3a5b54so6494444e87.3
        for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 06:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702391080; x=1702995880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MMRp2fkczAHbvS35YR1/LZAw92tizQKNc1g3fGU3oY=;
        b=SnNHHzrsQqAnEb7/+QKMvXQem7Mh4eZOABYlnmkpu7UULAamEfVsAdtWa+bILpNHjl
         hVEown4+k1o3jUkyAlErH0rgUK56oBQKOBS/HwMHVUPu99kPC6hJ6FNvk2AKG5mkeg0M
         btSEhKXC+JNQ9U4bSxF98OkhCGwQBihOZOYzuxLPphjxxDUWI7B+mFy1QwAlWdFCsbVd
         Pk2U8HG8o3zgkqlfISAZIaGCcuLiGSW8IdXHzz9r+Jq5LW7tIiJT5miBwGzElPFsVs8D
         1qqQdmC9j5VmRq9Tl8+Av+wt1hi4j0Jtj8M5dtyNa4qjDqfQZNDR6KcyrZOY08pgVYml
         pNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391080; x=1702995880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MMRp2fkczAHbvS35YR1/LZAw92tizQKNc1g3fGU3oY=;
        b=MjJRsisBhef8CmV2gJ8rqr5gLR/jDR6MNNQhVvGhuUGhgYd1H/R1WmFvfiyaxlnKeR
         UZDK3sMnW1rIMkIBNV+WV/V+WI4DYcri7Dyb8OtnegCZ2/xccOgsn3KZ8zrHVMpyfwH6
         JrQNfItnkSpJA6l4iiRTQ9dprcpWblk85KMg4p3AZuMoUCcfIy+tB7WvQvfW4k3HLDAP
         bBqPs1G0QN+YQyhZpvQvViNEAyw53MPfzxZv1ADdoUO/thnODlYjanYuxFLMzG+k043C
         F8kjLb788ZGCEg5e2d2P+sNuGeyGAXrXQT79HISW2aNcifDEAoSsUcJWZh4D0rWz878t
         BHVg==
X-Gm-Message-State: AOJu0Ywx+mQnlzB4wz/FBBLJrmYHKFpEACnO5amqu6d9a10lHdG4bBaO
	e4JBTLRQM24dusNNDZkhqEQcxIadYteMqDGzyRetOhK6364=
X-Google-Smtp-Source: AGHT+IFhVCmpwQapWAzJC8hdwfmzlfi2D9L21IvJLMgan5ptJ6m85aOPWhn5TQ2Q8HZRGT8EhJFUuw/RZzhZbl6cAGY=
X-Received: by 2002:ac2:4e50:0:b0:50b:e625:245c with SMTP id
 f16-20020ac24e50000000b0050be625245cmr2204355lfr.47.1702391080274; Tue, 12
 Dec 2023 06:24:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211150031.127850-1-cgzones@googlemail.com>
In-Reply-To: <20231211150031.127850-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 Dec 2023 09:24:28 -0500
Message-ID: <CAP+JOzQ1YHRwKb1JD=sS-M=JK9xZdnkbsBdBsk90hWTAXyhJpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: update const qualifier of parameters in
 man pages
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:00=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add missing const qualifier to parameters in the man pages to align them
> with <selinux/selinux.h>.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/man/man3/getexeccon.3          |  4 +--
>  libselinux/man/man3/security_compute_av.3 | 32 +++++++++++------------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/getex=
eccon.3
> index d6222a4f..9cc24e8c 100644
> --- a/libselinux/man/man3/getexeccon.3
> +++ b/libselinux/man/man3/getexeccon.3
> @@ -11,9 +11,9 @@ rpm_execcon \- run a helper for rpm in an appropriate s=
ecurity context
>  .sp
>  .BI "int getexeccon_raw(char **" context );
>  .sp
> -.BI "int setexeccon(char *" context );
> +.BI "int setexeccon(const char *" context );
>  .sp
> -.BI "int setexeccon_raw(char *" context );
> +.BI "int setexeccon_raw(const char *" context );
>  .sp
>  .BI "int setexecfilecon(const char *" filename ", const char *" fallback=
_type );
>  .sp
> diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/m=
an3/security_compute_av.3
> index efa4baf3..6c82eca5 100644
> --- a/libselinux/man/man3/security_compute_av.3
> +++ b/libselinux/man/man3/security_compute_av.3
> @@ -7,37 +7,37 @@ the SELinux policy database in the kernel
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
>  .sp
> -.BI "int security_compute_av(char *" scon ", char *" tcon ", security_cl=
ass_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
> +.BI "int security_compute_av(const char *" scon ", const char *" tcon ",=
 security_class_t "tclass ", access_vector_t "requested ", struct av_decisi=
on *" avd );
>  .sp
> -.BI "int security_compute_av_raw(char *" scon ", char *" tcon ", securit=
y_class_t "tclass ", access_vector_t "requested ", struct av_decision *" av=
d );
> +.BI "int security_compute_av_raw(const char *" scon ", const char *" tco=
n ", security_class_t "tclass ", access_vector_t "requested ", struct av_de=
cision *" avd );
>  .sp
> -.BI "int security_compute_av_flags(char *" scon ", char *" tcon ", secur=
ity_class_t "tclass ", access_vector_t "requested ", struct av_decision *" =
avd );
> +.BI "int security_compute_av_flags(const char *" scon ", const char *" t=
con ", security_class_t "tclass ", access_vector_t "requested ", struct av_=
decision *" avd );
>  .sp
> -.BI "int security_compute_av_flags_raw(char *" scon ", char *" tcon ", s=
ecurity_class_t "tclass ", access_vector_t "requested ", struct av_decision=
 *" avd );
> +.BI "int security_compute_av_flags_raw(const char *" scon ", const char =
*" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct=
 av_decision *" avd );
>  .sp
> -.BI "int security_compute_create(char *" scon ", char *" tcon ", securit=
y_class_t "tclass ", char **" newcon );
> +.BI "int security_compute_create(const char *" scon ", const char *" tco=
n ", security_class_t "tclass ", char **" newcon );
>  .sp
> -.BI "int security_compute_create_raw(char *" scon ", char *" tcon ", sec=
urity_class_t "tclass ", char **" newcon );
> +.BI "int security_compute_create_raw(const char *" scon ", const char *"=
 tcon ", security_class_t "tclass ", char **" newcon );
>  .sp
> -.BI "int security_compute_create_name(char *" scon ", char *" tcon ", se=
curity_class_t "tclass ", const char *" objname ", char **" newcon );
> +.BI "int security_compute_create_name(const char *" scon ", const char *=
" tcon ", security_class_t "tclass ", const char *" objname ", char **" new=
con );
>  .sp
> -.BI "int security_compute_create_name_raw(char *" scon ", char *" tcon "=
, security_class_t "tclass ", const char *" objname ", char **" newcon );
> +.BI "int security_compute_create_name_raw(const char *" scon ", const ch=
ar *" tcon ", security_class_t "tclass ", const char *" objname ", char **"=
 newcon );
>  .sp
> -.BI "int security_compute_relabel(char *" scon ", char *" tcon ", securi=
ty_class_t "tclass ", char **" newcon );
> +.BI "int security_compute_relabel(const char *" scon ", const char *" tc=
on ", security_class_t "tclass ", char **" newcon );
>  .sp
> -.BI "int security_compute_relabel_raw(char *" scon ", char *" tcon ", se=
curity_class_t "tclass ", char **" newcon );
> +.BI "int security_compute_relabel_raw(const char *" scon ", const char *=
" tcon ", security_class_t "tclass ", char **" newcon );
>  .sp
> -.BI "int security_compute_member(char *" scon ", char *" tcon ", securit=
y_class_t "tclass ", char **" newcon );
> +.BI "int security_compute_member(const char *" scon ", const char *" tco=
n ", security_class_t "tclass ", char **" newcon );
>  .sp
> -.BI "int security_compute_member_raw(char *" scon ", char *" tcon ", sec=
urity_class_t "tclass ", char **" newcon );
> +.BI "int security_compute_member_raw(const char *" scon ", const char *"=
 tcon ", security_class_t "tclass ", char **" newcon );
>  .sp
> -.BI "int security_compute_user(char *" scon ", const char *" username ",=
 char ***" con );
> +.BI "int security_compute_user(const char *" scon ", const char *" usern=
ame ", char ***" con );
>  .sp
> -.BI "int security_compute_user_raw(char *" scon ", const char *" usernam=
e ", char ***" con );
> +.BI "int security_compute_user_raw(const char *" scon ", const char *" u=
sername ", char ***" con );
>  .sp
> -.BI "int security_validatetrans(char *" scon ", const char *" tcon ", se=
curity_class_t "tclass ", char *" newcon );
> +.BI "int security_validatetrans(const char *" scon ", const char *" tcon=
 ", security_class_t "tclass ", const char *" newcon );
>  .sp
> -.BI "int security_validatetrans_raw(char *" scon ", const char *" tcon "=
, security_class_t "tclass ", char *" newcon );
> +.BI "int security_validatetrans_raw(const char *" scon ", const char *" =
tcon ", security_class_t "tclass ", const char *" newcon );
>  .sp
>  .BI "int security_get_initial_context(const char *" name ", char **" con=
 );
>  .sp
> --
> 2.43.0
>
>
