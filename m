Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0B48662E
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523588; cv=pass; b=qYaxd34TfWWK4z97DRyHcz8GFhsdKhKcn61Jw4fBrClqEuH+3ylHu+awnTvQDcQESsTN3AUto9QzVOLN5nNO9HUNx1m+7JWcIXFJ0YG6f5Qf1AeNxUoDs4UAmGQ96HG+zeOw1Cv0iyE9bc+miN3oKW48qKbzx/XrSWkIy+EJdhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523588; c=relaxed/simple;
	bh=/AeZ5rCR9zsOGaiFUo45vrJMpBsddJVJX9SycBkr0hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRALvVsdgkr+G5M+qTYwytrhVM92xSZ2E/QKg3faEVYMpc9qn/xKNEWidn5P2E16VoWQAD49/Cs+XkAvYSXJ/X/bIOkoLI2txYhTUwHWn0HJ2UPIZwWavpSxVOdWazwYd3nbm8wbmL7Khm+CENmwL1ALQubMgLkjbhaztKgRoiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6/bDcFG; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6/bDcFG"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-467a6834028so515702fac.1
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 05:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788523585; cv=none;
        d=google.com; s=arc-20260327;
        b=h71Snpp/w42zklp6oUopAr/BgqnwR3kJ73MAoqYxnHeVsS7YxfpG94/5VNc3ktlNZz
         UM5FJOGmDc065oEsLaToh6ZVUlPghSiI7gsOdjH5KcKVDex2+PqYekgjOFZ1siyQK5BK
         odMYR9/QEVO82Z9lW86vWgZVsN6PGyfuudJDFMUKTsUrDWi/+vCzxdEXzVbx4epyUWaI
         GIcdfYsxLbAJQztgRfR8rYnm2lZHWN8fa/DcNsRqBxsfVS4kAB2mOCcsV+HUqRldZ7SI
         HTqPYOc8DJfT2D6B+di5I36o7LCrfLy0+gC2chkY+p/8gnPmorg5ds64zjeH74SSgNhr
         YY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=danSfKGCPHn7nLgWvTk69Kf4oSlEhbFFKnkyqkeRwEQ=;
        fh=AQnnUcjcUYpWlp25yduSBOrX2TDQdvMOewmYwjwwoqA=;
        b=imCns3PXgNz4X4FdM+aMs54JIsGK7/WivRmc8Fb8ccF7Zlb+sJytoHFFYPo2FQLWp2
         zmO0HlTHqO+aW0TRBqPEh4PZ2ys5JszxCGZ/9SWUNTnJTsDqwrd4zpiUFDpeH2yspOMB
         DFKHMIKP3nSKzNyraG/B6S1Q5v9RhnXqUWmdMF4M42c4TVv38AoW27BapqYiO4Fb4QMn
         MhiIntPb4mQkmZ99i5zFYRD1Hkl5n/K3cr8im0it/cjp9Vwu1cnImYcbQUjwkrkoq8xW
         NXquP0y+4b02cqA7V56TEfzk60HJY/LGZgZ922J3N3w9Z2zdJyGiJM9kD71w/eFYoFXz
         mLGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523585; x=1789128385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=danSfKGCPHn7nLgWvTk69Kf4oSlEhbFFKnkyqkeRwEQ=;
        b=I6/bDcFGtsJUQM/LT8AtjZPN8rPNEpUQW8xI69qgOgaZdh9ryaUvea0WeuOornENNQ
         cLqRaPxHraolTdTJMyJFOZNmBEfPEMJEb1dDICGnUWG6vQRMONVvsB3HGpEn5WXnGisW
         9B9uWHZ6IYzPb41V5jQSei5khH6nW/77VNkqlNTREXfhfMjbpaDaOuPZsDbUctnX5Ty+
         fRjKxymH2Fo7w/S2W8L8NH0UOiyFmiW7TSriUuAt6wGhAJda5rL56wEDMDlES09BWgef
         LRTaTYL5kkUeRKxGV6BOjYgZBMjQmmLS+mGyfSaqf9aQ8fvDkJVtn8iaiVSzsP+7Rgpy
         aMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523585; x=1789128385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=danSfKGCPHn7nLgWvTk69Kf4oSlEhbFFKnkyqkeRwEQ=;
        b=IPnif7GcRt+6Dz8kzXfIyc9UIbaHRY5y1xCScS+aybYiPwnc2iOqsaQVlSWpwiJQTK
         HP6T7ZVs7IAkUuoos3UkWST/xKP6dDmwo07n/5DGKmwREaXHoojO9rbrpxtHGNjtsL9U
         pzMu5FUS4LGu1+ds4ldqFGPq4ceZcNd6F7r4K/XHA5CjAzJoXyYutWYl3ZfFPpjV0cIS
         3AmlSu2ILmP9/EuaxvPvfcjcjSdgiVBivaul0Jjf2+tqZN3TOqGfwBi+YZZt8rU4ATSy
         YdJbXe71ZPMuzJpusR1uGSbtuyT/K8b/ANvJEHgXVy2rcsdN8xNw7tNBSaK9gs3TY/ws
         uNAg==
X-Gm-Message-State: AFuF++kLH8+5EzxHLBql3Fh7rffM5DV/3jye+hYj/9tpr0fUtNO2G3/m
	bi+mIR0I68hNGau739vB5ZH2HwnEh4rsdGjsBO85t6fIwDEKbusC3EYxB9vd74FePpsPQbFUIyr
	HWmKLFuONqwXxGmqbIG39HnbvLUcPkvI=
X-Gm-Gg: AYBFou3xBApVv2Zvhezq+6XcD9D5G4g+AeUCV+rhaL1OmAF2vowQ9IWbdpv10mK/qR7
	ZhVZLkNrNH7utKrqlz1Q/clYo4g7P4N61Vjj9InNuyUC/CG7y5VtqQ0+qpAdieLWLIm1TW5sXkW
	28QZnALk7kWslcoVezTiabN51uexCrwX/CSwo28QtaR17qUPwLVZ9Iz9jv47gsJfQscGfih/KIF
	+uMtp1csTEi3j6KpixNA0PvcJ5eViTCXnIs3QEls3TYg3lg7j+fBO8+/42UK4cyThwJCketZ6w9
	T2Zo3FeDZVhX/rgdJkB1semZkPzWNjEfOPpwLw2jqSWEA+8e5VxSQmGC
X-Received: by 2002:a05:6870:a08f:b0:442:e783:8b2d with SMTP id
 586e51a60fabf-47553c4c602mr5483474fac.17.1788523584408; Fri, 04 Sep 2026
 05:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903151347.1513631-2-lautrbach@redhat.com>
 <CAEjxPJ7isYB2FekKMubJrDgdCuaRc27w6Rwfo9==BPe0GY4iyQ@mail.gmail.com>
 <87o6ed1glz.fsf@redhat.com> <87ld9h1ew2.fsf@redhat.com>
In-Reply-To: <87ld9h1ew2.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 08:06:11 -0400
X-Gm-Features: AcwNN1W-GZw8j06W2YN_BgNGXxzxBq7K0cJfR6VXBBpmyLPb4EiJhGz4rtzpEwo
Message-ID: <CAEjxPJ49x+98-zbRofd1KJCauhM4YRTpzMUeixdFG+HFzb8gGg@mail.gmail.com>
Subject: Re: [PATCH v3] Add support for UTF-8 in file context labels
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 6:37=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Petr Lautrbach <lautrbach@redhat.com> writes:
>
> > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >
> >> On Thu, Sep 3, 2026 at 12:00=E2=80=AFPM Petr Lautrbach <lautrbach@redh=
at.com> wrote:
> >>>
> >>> - libselinux to be able to read UTF-8 spec entries
> >>> - libselinux to compile regexes with UTF strings
> >>> - initialize locales in setfiles, sefcontext_compile, semodule
> >>> - semanage_exec_prog to execute external programs with LC_CTYPE set t=
o
> >>> the current environment
> >>> - disable UTF-8 support build time using DISABLE_UTF=3Dy environment
> >>> variable
> >>>
> >>> Fixes:
> >>>     # cat unicode.cil
> >>>     (filecon "/opt/=C5=BElu=C5=A5ou=C4=8Dk=C3=BD(/.*)?" any (system_u=
 object_r user_home_t ((s0) (s0))))
> >>>
> >>>     # semodule -i unicode.cil
> >>>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/fi=
le_contexts:  line 2145 error due to: Non-ASCII characters found
> >>>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/fi=
le_contexts:  line 2145 error due to: Non-ASCII characters found
> >>>     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Inv=
alid argument
> >>>     libsemanage.semanage_validate_and_compile_fcontexts: setfiles ret=
urned error code 1.
> >>>     semodule:  Failed!
> >>>
> >>>     # semanage fcontext --add -t user_home_t "/opt/=C5=BElu=C5=A5ou=
=C4=8Dk=C3=BD(/.*)?"
> >>>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/fi=
le_contexts.local:  line 4 error due to: Non-ASCII characters found
> >>>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/fi=
le_contexts.local:  line 4 error due to: Non-ASCII characters found
> >>>     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Inv=
alid argument
> >>>     libsemanage.semanage_validate_and_compile_fcontexts: setfiles ret=
urned error code 1.
> >>>     OSError: Error
> >>>
> >>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> >>> ---
> >>
> >>> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> >>> index d6b5bf0252ba..f632a87275d4 100644
> >>> --- a/libselinux/src/regex.c
> >>> +++ b/libselinux/src/regex.c
> >>> @@ -96,7 +96,12 @@ int regex_prepare_data(struct regex_data **regex, =
char const *pattern_string,
> >>>                 return -1;
> >>>
> >>>         (*regex)->regex =3D pcre2_compile((PCRE2_SPTR)pattern_string,
> >>> -                                       PCRE2_ZERO_TERMINATED, PCRE2_=
DOTALL,
> >>> +                                       PCRE2_ZERO_TERMINATED,
> >>> +#ifdef NO_UTF
> >>> +                                       PCRE2_DOTALL,
> >>> +#else
> >>> +                                       PCRE2_DOTALL | PCRE2_UTF,
> >>> +#endif
> >>
> >> This causes pcre2_match() to validate the subject as UTF-8 on every
> >> call, which in addition to incurring
> >> overhead on every file
> >>
> >
> > Would you prefer NO_UTF to be default so only distributions which
> > enabled this would be affected?
> >
> >
> >> would also cause regex_match() to return REGEX_ERROR and
> >> label_file.c:lookup_check_node() to fail the whole lookup with errno
> >> ENOENT. Thus, restorecon on a file
> >> whose name isn't UTF-8 will error out instead of falling back to
> >> matching /.* and labeling accordingly.
> >> If you add PCRE2_MATCH_INVALD_UTF to the flags, then pcre2_match()
> >> will instead treat invalid bytes
> >> as "cannot match anything" but can still match literals and character
> >> classes and will return REGEX_NO_MATCH
> >> instead of REGEX_ERROR.
> >
> > I was not able to get it working correctly using filename with invalid
> > utf8 symbol even with PCRE2_MATCH_INVALID_UTF.
> >
> > PCRE2_DOTALL without PCRE2_UTF matches anything on byte level for
> > '.'. The problematic are wildcards. e.g. '/opt/=C5=BElu=C5=A5ou=C4=8Dk=
=C3=BD+'
> >
> > I'm working in a patch which without PCRE2_UTF but which would allow to
> > use '(*UTF)' sequence directly in file spec:
> >
> > # semanage fcontext -a -t etc_t '/opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE+'
> > # matchpathcon /opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE=C5=BE=C5=BE
> > /opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE=C5=BE=C5=BE        system_u:object_r=
:usr_t:s0
> >
> > vs
> >
> > # semanage fcontext -a -t etc_t '(*UTF)/opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=
=BE+'
> > # matchpathcon /opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE=C5=BE=C5=BE
> > /opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE=C5=BE=C5=BE        system_u:object_r=
:etc_t:s0
> >
>
> Another option would be to document that in this case, it's necessary to
> use '( )'
>
> # semanage fcontext -a -t etc_t '/opt/=C5=BElu=C5=A5ou=C4=8Dk(=C5=BE)+'
>
> # matchpathcon /opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE=C5=BE=C5=BE
> /opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE=C5=BE=C5=BE        system_u:object_r:e=
tc_t:s0

That seems fine to me and cleaner than the first option.
