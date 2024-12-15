Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5001EEF9
	for <selinux@vger.kernel.org>; Sun, 15 Dec 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304836; cv=none; b=Dimpmow9TZnOrZ1X1raFpTI3KFN+HXxJaqd/m8oMPYLIRdBkUrEOjdsLNvUQbPjzwPHmMsR0Ulsq7IPliqe/Qvs/sqPlVxdtbaifAvA5Lr1XOXcRwpBQC4lBorltJ0Us93Y0oYV/vXdUS7yvK3kh/Yh0jaGAyEPTbEUFOVoSW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304836; c=relaxed/simple;
	bh=1Qza79ibSFWckcg66+F3faMgzzVZi0wlslADYxEa0Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cucMyYwkijkKTYR1+GGgVDFhivfSdi9nlABrrLu9SQ2qZgiurkrq34X+qT9XHZyqvYaX8P1Kgv2ESPGvzQLW/XlJxDVYg4Ua+3/DZ0ZKI2ww1zW9k/WrrZxsIXA3IgHypYm+CWy9nm9ZannlKBJ10fQtmZE2IdxCEZ8hjSlCa04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oaqwwHyg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaqwwHyg"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e44a42512so4051e87.1
        for <selinux@vger.kernel.org>; Sun, 15 Dec 2024 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734304833; x=1734909633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bXp13MSeoH89vMCinUupilO3k3UB8npqWLMdtt8HhY=;
        b=oaqwwHygK7R4IWwu3pGWAcYQSq6nPK9a5DmXkb4AhxqyBLT5lcs6ZkTloT08/W2Q8E
         GL8v1T+TAT3Rtj13djJuwoLYSaF9r1Uk7IV2Hn965bm7jjutJQPc9oWGB0wAW7NkHDJ2
         K265/fk00Sj4dMR5cU+xL5x41Pd8GzaskryAtmnss+zKZ2MgFmj1sR5Op+zlOH2aZfEB
         LTPjjxuY8fB3ZMDBKv2IUjFrn4/HYkUA5K1EU9r9i+peNYq2+SV00uZkWuiUSp+AVDzX
         FrBDM3FO/caABz8+NyVeBrood2+umpCxcZVH9pGzz1dnLqxNJ81qmUJKjxPYhy3IysZt
         kdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734304833; x=1734909633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bXp13MSeoH89vMCinUupilO3k3UB8npqWLMdtt8HhY=;
        b=AfVX0/rDOB/LvvohaoLAz8OS/DYB3Gv3W/N7jZAe9cARkz+4jjKuG45auWYYLbU3jr
         OcFdx0qDFxNYt04eIAa9o5MdY/+UQfHqCDYhg9Sem1GfshkyrLT6SGAL40d38Uzi0IJt
         PjZ7rx/n/7IKV9F/Ui05JWdJ2GB3KpIKLHowqM344lyLHFeXM4U3XJFIzB+CdztqqjxA
         h5sw+eZ69Pk/25oN/HNPsFt38sajEQpkNZGecBrZBeagu7x8sV0aJCIyiAAHAJcJVTSr
         ajtIl+fn5RVjFtfJji0cXySuSq3Opf/oPa0ZiIuBhxPjqgjCViwWMVK65XVq485xkXTp
         7JzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoFy7aDVlVUTCUKQmJuL2e7e907dqUcMjbPIEy9N8KIOC1XYFfjNJSlV4cs9ROrZRY8WEhB2ci@vger.kernel.org
X-Gm-Message-State: AOJu0YyEayMcKi8upnh2aTKA3iNATSy6n6O7pOnS1/kqXQ903B4ZsLVh
	JIKWMazLhDNO+w9X6PqY2USZ1viDxVQBz1KGQF64J4EnF53HPWNOvYiKvQx+93Qdn7qK4hKKimY
	zPQq+08bDMA+YmEzYGdnEi0TG3h+1qiMnYZq4
X-Gm-Gg: ASbGncsw8gNdHeHhwB9D7eKKpGdDc5L9berHX+vTdlvnGGyn6tyzafiJTAjmKmKQtZm
	whAXNy6afFp0N3zS9NushTIcFvOQjroAOxZ/THA==
X-Google-Smtp-Source: AGHT+IG/fTablPbzuHgpLWF7xJ/6GCWt0PM298eh5iLoY1D3IkqN149sFQ+twVLL6VSmwCdvVHTcrv3jC5f46eHW3Nw=
X-Received: by 2002:a05:6512:34da:b0:53d:f7a6:1319 with SMTP id
 2adb3069b0e04-541216a7e16mr116435e87.5.1734304832692; Sun, 15 Dec 2024
 15:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205012100.1444702-1-tweek@google.com> <CAHC9VhS=_ZExOUQAiYEwkTEnpT9xNJsj7g7L6HMH2odWX5GxUw@mail.gmail.com>
In-Reply-To: <CAHC9VhS=_ZExOUQAiYEwkTEnpT9xNJsj7g7L6HMH2odWX5GxUw@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Mon, 16 Dec 2024 10:20:15 +1100
Message-ID: <CA+zpnLd-HSmfihtNUii_NQjrW5HhpVi4s4OL39ARBF_827E8AQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add netlink nlmsg_type audit message
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 8:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Dec 4, 2024 at 8:21=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
> >
> > Add a new audit message type to capture nlmsg-related information. This
> > is similar to LSM_AUDIT_DATA_IOCTL_OP which was added for the other
> > SELinux extended permission (ioctl).
> >
> > Adding a new type is preferred to adding to the existing
> > lsm_network_audit structure which contains irrelevant information for
> > the netlink sockets (i.e., dport, sport).
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> > v2: Change printed field name from nlmsg_type to nlnk-msgtype
> >
> >  include/linux/lsm_audit.h | 2 ++
> >  security/lsm_audit.c      | 3 +++
> >  security/selinux/hooks.c  | 4 ++--
> >  3 files changed, 7 insertions(+), 2 deletions(-)
>
> ...
>
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index 9a8352972086..70444230e56f 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -425,6 +425,9 @@ static void dump_common_audit_data(struct audit_buf=
fer *ab,
> >         case LSM_AUDIT_DATA_ANONINODE:
> >                 audit_log_format(ab, " anonclass=3D%s", a->u.anonclass)=
;
> >                 break;
> > +       case LSM_AUDIT_DATA_NLMSGTYPE:
> > +               audit_log_format(ab, " nlnk-msgtype=3D%hu", a->u.nlmsg_=
type);
> > +               break;
>
> See my follow-up reply to your v1 patch.  Assuming no objections, I
> can change this to "nl-msgtype" when I merge the patch; is that okay
> with you?

Yes, please do. Thanks Paul.
