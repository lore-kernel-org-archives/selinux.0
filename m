Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9919259CA4
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792613; cv=none; b=BSaolQdX6kHomdoU97L25/x7C3j9zDpb5e0qenGEo2ffFx+33aX3WslJql3o7MFOWpRjNMb6OZINsOb4B6kNYOAISeEG2b9Bjlb7mwgo+8eSvA7BkFDDPGj93juiLi6BxB0v3r/TwIETtCtLoredshVZRoPs90HYD/hrC5xFG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792613; c=relaxed/simple;
	bh=dt/nZ8s0AqLsHabRP1E5nPo1f23VxEUY2vYeeUkxwC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dd97tjqTeee7iZ4bmm99I2VI6hpPIzgSy4SaBFaNxsyl04VX74pcFjBLkpsDystl5EOCQzaFkWEqgyGGveDqE1IenMEID8mXfkxVnLBk6R8vIppfJjCvgTohcv58AdNMzVBN+VRcQt86iFft4p1j83bs72EJ8Du+KoN6EislvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/dfNCYA; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/dfNCYA"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8ec399427so47137776d6.2
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741792610; x=1742397410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVfhDkvY+CHdgs6GWyKp0WDDDYXVUUHHXpNMICHKqUQ=;
        b=K/dfNCYAYkw2dxykMCQsVUyAFZCwm1H6VuDujWAngPlTyfL+jGvH7jbdKjvANIyCco
         99FnUdeILAGeqDSxcK2Sg/W11Uo1Evfo40NClhjKJhhCS6hrd3A7mBjhWuruFespu/sg
         kZKZj+yBQq91p2Kf1TzbLbbzRupvV2aPqNiz4QqV/kZDBT0RNXgywwAuQH+cYsVQx80c
         neGKIfko40lIkA9bWtCgBB0emV9/TQ2zj7NRET+24Cud37pGgEWDO5wL0bzk4aPQvchD
         v6F2ctKckaPQAdTE8H9lKo/rE94i+6x9ptdeSKZAMN1LMDl8Monjog4FmO7ACWBNQeq+
         aEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792610; x=1742397410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVfhDkvY+CHdgs6GWyKp0WDDDYXVUUHHXpNMICHKqUQ=;
        b=X4PipI7hlwvMB+uB/BKJO/iQB91V8DVZPUbWcPwDp9uz3a19Uj5NS/Ro2SBSo+wCvI
         KsjVvswv7CoxjV5pdBP8RuwmyQOvdsQXAxSanfmLmVRmS6R87yghgEbPKAgrt3iydICL
         cOhe2opsKEXWQPMriGtF3/pGBc0gA2iDVbBagqwPQUYhtLP9cE89a6+gZHA3rgFSTwRN
         0Y3DdlnWEjwNZ6g5kSkNLVCs0MHryviVE75ihLgp+0V2fH0oZ40O29+5XYrX0WFe/lO1
         cUEHUj9tnmv8Y4E+nH/rev04Z91QNudIbkPd526XLa+zQHOjwtuNt7ndNu9I3oMCisEO
         YHwg==
X-Gm-Message-State: AOJu0YwlgDZuKhzSU5gQGaaFjQ94q5A9w1YiPxQrhc+4uIuHYfXuxeIi
	TRC7Y/gFOSqEQZC/Sj04s/SWbkVs/jHd7xx1xacnXaANWVxfcKy8v3L8TGk7+tRD7zj14WFDwSE
	R8cdrWtOVk4lTL5g1K4vFzuTbuUL3NjGg
X-Gm-Gg: ASbGncv7wLof7OblH2RN/1UtLe8E3EWiPmNsWAykIACBvDbKNc+GJw+mDNEU6SbvOX9
	8A9ebWWihKx442gQUbyalLdXj7kPD3MFMxy3qm8RW3SvjBMPNxSWyv3+8KbJmE9Mh8CvTQCgCDY
	NLVRhD0JWsDZImDKBjqJQbvEc=
X-Google-Smtp-Source: AGHT+IFuKfUzD2p6Bk0MM2QwuG8iHACs18UqqWLu5bg6STANR5spfZq7vzXoELhjpYzvZfxv9SI+MJQ4niBx/v5L4d0=
X-Received: by 2002:a05:6214:226f:b0:6e8:ddf6:d122 with SMTP id
 6a1803df08f44-6e9005b6623mr319531936d6.3.1741792610285; Wed, 12 Mar 2025
 08:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131175556.21836-1-cgoettsche@seltendoof.de> <20250131175556.21836-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250131175556.21836-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 12 Mar 2025 11:16:39 -0400
X-Gm-Features: AQ5f1Jq1h5JD66-cFTKTOKH-RE4E1Qa2IlD188ycAg8TJbDmnwOX19z4J0YIHGs
Message-ID: <CAP+JOzRuKz5rwa8TUrjDGuYKhk_XWD0KL_Q46V+_cD=tn54rUQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] libselinux: use local instead of global error buffer
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 1:03=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Use a function local, and thus thread-safe, buffer for error messages
> instead of a shared global one.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/label_file.c |  4 ++--
>  libselinux/src/label_file.h | 19 +++++++------------
>  2 files changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 56e20949..85d42ff2 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1662,7 +1662,7 @@ static struct lookup_result *lookup_check_node(stru=
ct spec_node *node, const cha
>                 for (uint32_t i =3D n->regex_specs_num; i > 0; i--) {
>                         /* search in reverse order */
>                         struct regex_spec *rspec =3D &n->regex_specs[i - =
1];
> -                       const char *errbuf =3D NULL;
> +                       char errbuf[256];
>                         int rc;
>
>                         if (child_regex_match &&
> @@ -1673,7 +1673,7 @@ static struct lookup_result *lookup_check_node(stru=
ct spec_node *node, const cha
>                         if (file_kind !=3D LABEL_FILE_KIND_ALL && rspec->=
file_kind !=3D LABEL_FILE_KIND_ALL && file_kind !=3D rspec->file_kind)
>                                 continue;
>
> -                       if (compile_regex(rspec, &errbuf) < 0) {
> +                       if (compile_regex(rspec, errbuf, sizeof(errbuf)) =
< 0) {
>                                 COMPAT_LOG(SELINUX_ERROR, "Failed to comp=
ile regular expression '%s':  %s\n",
>                                            rspec->regex_str, errbuf);
>                                 goto fail;
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 60ebbb47..ad7699e6 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -388,16 +388,17 @@ static inline void sort_specs(struct saved_data *da=
ta)
>         sort_spec_node(data->root, NULL);
>  }
>
> -static inline int compile_regex(struct regex_spec *spec, const char **er=
rbuf)
> +static inline int compile_regex(struct regex_spec *spec, char *errbuf, s=
ize_t errbuf_size)
>  {
>         const char *reg_buf;
>         char *anchored_regex, *cp;
>         struct regex_error_data error_data;
> -       static char regex_error_format_buffer[256];
>         size_t len;
>         int rc;
>         bool regex_compiled;
>
> +       *errbuf =3D '\0';
> +

I know that this will never be null because there is only one caller
of this function, but since it is in a header file, there is no
guarantee that it won't be called from somewhere else in the future.
Can either let the caller deal with it or add a check here that errbuf
is not NULL.

Thanks,
Jim


>         /* We really want pthread_once() here, but since its
>          * init_routine does not take a parameter, it's not possible
>          * to use, so we generate the same effect with atomics and a
> @@ -435,9 +436,8 @@ static inline int compile_regex(struct regex_spec *sp=
ec, const char **errbuf)
>         len =3D strlen(reg_buf);
>         cp =3D anchored_regex =3D malloc(len + 3);
>         if (!anchored_regex) {
> -               if (errbuf)
> -                       *errbuf =3D "out of memory";
>                 __pthread_mutex_unlock(&spec->regex_lock);
> +               snprintf(errbuf, errbuf_size, "out of memory");
>                 return -1;
>         }
>
> @@ -452,12 +452,7 @@ static inline int compile_regex(struct regex_spec *s=
pec, const char **errbuf)
>         rc =3D regex_prepare_data(&spec->regex, anchored_regex, &error_da=
ta);
>         free(anchored_regex);
>         if (rc < 0) {
> -               if (errbuf) {
> -                       regex_format_error(&error_data,
> -                                       regex_error_format_buffer,
> -                                       sizeof(regex_error_format_buffer)=
);
> -                       *errbuf =3D &regex_error_format_buffer[0];
> -               }
> +               regex_format_error(&error_data, errbuf, errbuf_size);
>                 __pthread_mutex_unlock(&spec->regex_lock);
>                 errno =3D EINVAL;
>                 return -1;
> @@ -624,9 +619,9 @@ static int insert_spec(const struct selabel_handle *r=
ec, struct saved_data *data
>                 data->num_specs++;
>
>                 if (rec->validating) {
> -                       const char *errbuf =3D NULL;
> +                       char errbuf[256];
>
> -                       if (compile_regex(&node->regex_specs[id], &errbuf=
)) {
> +                       if (compile_regex(&node->regex_specs[id], errbuf,=
 sizeof(errbuf))) {
>                                 COMPAT_LOG(SELINUX_ERROR,
>                                            "%s:  line %u has invalid rege=
x %s:  %s\n",
>                                            path, lineno, regex, errbuf);
> --
> 2.45.2
>
>
