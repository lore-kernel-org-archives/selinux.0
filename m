Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A661514D1
	for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566477; cv=none; b=cwrJOXWdEMp7c/unr1gNxg6ArX6LfW/4jy2gayPubGkY6sV418r1INqiW1Pe1Mrkt7jJEM4HCfVpDE+ZpePpLFkTig+DGLE5xlrfzr2bMth9BT70BvkMIsdhevcXZxIufbZXUolSnUQkcTCRDaOJXVsemoYO8R74wk7QU9qgsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566477; c=relaxed/simple;
	bh=rX8bJAJlWtQb9za+TVSbAx1jnWvcZZB7sZCqFLgfs2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5Z6maDZUD4wMtbnBm0ILvyWLtuYRsS5caZiZq2d+/oUIgXSy4hdMNhaJY5LfNjGZzsX57wRMCT4omkX11+1dySB2w/tJKJ5AEVDV51ysZDmhGtg6cGCd5lonwPhshUFW7EnnCLHNGBq1qaUqf/g7wgRDtzIzzidVm3Il/KK33Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep0ezpiA; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep0ezpiA"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc236729a2bso151418276.0
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566474; x=1712171274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dx/kHEKE1w/dleGiLbpSrHOD3qQNQS+wo6GVYnJL17Q=;
        b=ep0ezpiAtH/K2c15Q4hna38DkYeBv8wkyeGE0ku1pO05ETYxvhrnkKXC0hIprl14lT
         J+1KpIYSTMBmQLCIGylFhv5lv7ElFLvB5AmHieZsxkKeFMAZgsWYsJ6LWjkJbd23Qx3P
         8mH3oZJeyVRJAvVwDeKS5D/qtnnAs8eRES3CIhTkKkhF9y3A7TO7TzZnz9hQFOZ8UdLy
         1sB3YxJ7N0FfQh2AulhY76Rr7uYddGmwk14jHDj6PzQmiga+ZuWLWvPzQXb8TbxoAZt0
         1SAgLvoM+JT0CPkPs9k0WFKODOsZy9QslaAyBzCDqeN7eBGelziOGh3giGajBqtS5UbC
         9r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566474; x=1712171274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dx/kHEKE1w/dleGiLbpSrHOD3qQNQS+wo6GVYnJL17Q=;
        b=tgBhYupe6HEwDRHVDELDD2b+f0WhDT7KnxLUB/l9ONTlIJNBMUyx35X8QUl074uASW
         VYW8TEZmEuHcU+7UPsZxOIyps8GefjkwLObVHGkyBqTNU9P0oyZPlp278nex5pfoK1Df
         dhY/UWHdS4l8sDlINSfgD4N8MNXyo/bYeVoMueCi8t/kbeiPV4eonuCkQcadcCtNpOEf
         jYrObEBrlFV0C3JNoVWktlXUwUE6xzkQLTXdxs7b4Pa4xHVDisSNSoifSg7dZWYkwwDt
         +UwEAuIfBCa//w+96492S7XTXwFz7kIRxVawfHs0cKoxGd93+9HcuzcQHr2yy3YbywSe
         mTsw==
X-Gm-Message-State: AOJu0Yznq/+IdvxTJ/gwH0KCtIDl169VffAjeYZFUh4CgXNL4TXaa88r
	/iG65kjMPA5Evnu6bbtjAsiHnBaMNo8+bJzpaSGzXdASy3Ld0FQWFNkq5NSarW8SEqDJ47GUani
	8Cg0K0ZKHwysQFOCBjkEpQg2Kk3k=
X-Google-Smtp-Source: AGHT+IEm6a0vloiAejFkXulJZKvZZrhgzIseGZWvcl2JGltQUnSTWH9DcCnG/kwjd905w0+aEwiT2mzojSa9MWiRkEY=
X-Received: by 2002:a25:bf89:0:b0:dc7:46ef:8b9e with SMTP id
 l9-20020a25bf89000000b00dc746ef8b9emr781685ybk.29.1711566474632; Wed, 27 Mar
 2024 12:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322145049.60340-1-cgzones@googlemail.com> <CAP+JOzQH0gLqUTmYq5Ou2qt_P9nzvaQY6gscTuQpsU_Mg5rz7Q@mail.gmail.com>
In-Reply-To: <CAP+JOzQH0gLqUTmYq5Ou2qt_P9nzvaQY6gscTuQpsU_Mg5rz7Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 27 Mar 2024 15:07:43 -0400
Message-ID: <CAP+JOzT8XBJAxss=M_DVbM6zQZEY3XMaTpSwAzKRV+=JMdzgjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: use YYerror only when available
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 1:13=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Mar 22, 2024 at 10:54=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The special error value YYerror is only available since bison 3.6
> > (released 2020).  For example the version used by oss-fuzz does not
> > support it.
> >
> > Use a special token in case YYerror is not available.  Only downside is
> > a duplicate error message, one from the manual yyerror() call and one
> > from within bison for the unexpected special token (which would be
> > omitted by using YYerror).
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_parse.y | 1 +
> >  checkpolicy/policy_scan.l  | 9 ++++++++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > index e0103502..1b275ebc 100644
> > --- a/checkpolicy/policy_parse.y
> > +++ b/checkpolicy/policy_parse.y
> > @@ -153,6 +153,7 @@ typedef int (* require_func_t)(int pass);
> >  %token FILESYSTEM
> >  %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
> >  %token LOW_HIGH LOW HIGH GLBLUB
> > +%token INVALID_CHAR
> >
> >  %left OR
> >  %left XOR
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 1926129c..c4d8e937 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -308,7 +308,14 @@ GLBLUB                             { return(GLBLUB=
); }
> >  "]" |
> >  "~" |
> >  "*"                            { return(yytext[0]); }
> > -.                               { yyerror("unrecognized character"); r=
eturn YYerror; }
> > +.                               { yyerror("unrecognized character");
> > +/* Available since bison 3.6, avoids duplicate error message */
> > +#ifdef YYerror
> > +                                 return YYerror;
> > +#else
> > +                                 return INVALID_CHAR;
> > +#endif
> > +                               }
> >  %%
> >  int yyerror(const char *msg)
> >  {
> > --
> > 2.43.0
> >
> >
