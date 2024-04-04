Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC81D554
	for <selinux@vger.kernel.org>; Thu,  4 Apr 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247712; cv=none; b=L3EXTiQgMTcZg/sSWdulLKK/Nv03KNlQOj/oRdWSj/x+cxyHzy7cvkUgwcR6fUTrzQy4AhtTPr/fx80nSSEGDKqRTWwaa9TQAQCfCrJCihcf/IOnaKWVFwJmB2y8/7htzvLL7l7lMl8Bl1bIrU2J5ej6d7oF5oYmcg9xhLdIkEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247712; c=relaxed/simple;
	bh=WXFxxMAFtNZ89X5pfOK9Qh2YfXtWSfuxfMf7ZSsRyv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CerHi6X3Wm9WxrGwWBFR7QIbv6dUulhzU0kUq6iKph731na5QJWYsDOcqXxAdu/KcAwi33nwmiR+p48mBoe9R8u8N5Zf/7t9NoOKK241IQemmXP8zGsBkzL7tNy+TgXM8B9ojl32vWpYX+Onre/Xs8Ag+Z+smVYgIWF8DEtHWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK/qltXQ; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK/qltXQ"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4766e56ccccso516688137.0
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2024 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712247710; x=1712852510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M83L16hf9Ko95XoZdOlLdmq7c3gF5jdynA3c+E90VOA=;
        b=VK/qltXQapuiwOVEUURXn0XlJI43qA8LVB8nd4xlhBCVbXbHtZgBg6k/NT1ekuhtHv
         TiwFMRf7jLqe1sG1Gmab5gbYcnkvTKhqJ/mhU7ZtNZZOEVvY00TDcLEcd8O0GWQOMOOb
         FEqcHf8d3itp+8aRXi5J+N20EOfmWje17S51uVvPdNIrivzGxFhkUdKi0TT6uoK8ymDf
         D3Y2HB5ISGmEbiMdJXYIJUMtgVKcVwxXtJm4nZrZoPlcPUrwGFTJvZEfcxG5aghUgkUu
         zi3+hhBBoh8ejJsFQsO9AWzRJAu403PJz0rTNWNWWukVWGauZfOhj/9JjU4LPOs3hvD1
         7sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247710; x=1712852510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M83L16hf9Ko95XoZdOlLdmq7c3gF5jdynA3c+E90VOA=;
        b=KVMriSYhzZtnmX4iee0AxEhS8WiU+ohCvpkeQJJ/SuX/WTjRX7I50abz4y+LKBhwY8
         d4hRxUkHluG4irb2BCwTZNwsPhiFOFZOwZUUrTOImitHZntQImTYPQ9rI0p6G6UhhEW0
         9P+Yz1bjFdQ7XkWsCBPoOc0hPPim6Nj/DjkAZHwnmEB7uARbrdotaTYcPGDWeLTw76hv
         dx7kK8oagDnY0RXvKe2+/+thJRDbe5wl1sn9p6NmcOMHQL69t248u11FrQQDINAuV8J/
         uO6LlrBjwDHcveBIK/c0cVXHGSFEj5Nj3tET7ivil1b2s+XfijYtfOiRXWEe2Tc1BC4t
         4IQA==
X-Gm-Message-State: AOJu0Yy7EKPozHW+Gp8E47uYwFAxrouhi7iA3pUTj4k4PoR+PFgyqYbq
	q9nTtlRl+XTlohN4VRCMXi9+GsGZg/Im9W/8v9RWBm8Llz4o51SyDMot9Ziujr5KdL85ns+1msT
	WFolg3pJcIRDlpTO13T3IZHjwWcON8Uw+
X-Google-Smtp-Source: AGHT+IGoUEaZw/wA7pfzVFbtWF30jAod6k2ICzc+0dAJn5PXWBoeRKbBTIPcmPlpscGmhjQORiJ8mjlJIIm9fLzcxvw=
X-Received: by 2002:a05:6102:944:b0:479:d726:dfb7 with SMTP id
 a4-20020a056102094400b00479d726dfb7mr33011vsi.5.1712247710068; Thu, 04 Apr
 2024 09:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330133502.72795-1-cgoettsche@seltendoof.de> <CAP+JOzSbXFWTTft7+pM+WueX+rx+SH9hJ6Y150QEdadYJC4i0g@mail.gmail.com>
In-Reply-To: <CAP+JOzSbXFWTTft7+pM+WueX+rx+SH9hJ6Y150QEdadYJC4i0g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 4 Apr 2024 12:21:34 -0400
Message-ID: <CAP+JOzQREoh7gKproPYZNYv3DcPUWddaJqK9bVrPWCiF55NP2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: free identifiers on invalid typebounds
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 12:52=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sat, Mar 30, 2024 at 9:35=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Free the two identifiers on an invalid typebounds in the error branch,
> > similar to the success branch.
> >
> > Reported-by: oss-fuzz (issue 67700)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>
These two patches have been merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 0cf938ea..92d1e5f2 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1477,8 +1477,12 @@ int define_typebounds(void)
> >         }
> >
> >         while ((id =3D queue_remove(id_queue))) {
> > -               if (define_typebounds_helper(bounds, id))
> > +               if (define_typebounds_helper(bounds, id)) {
> > +                       free(bounds);
> > +                       free(id);
> >                         return -1;
> > +               }
> > +
> >                 free(id);
> >         }
> >         free(bounds);
> > --
> > 2.43.0
> >
> >
