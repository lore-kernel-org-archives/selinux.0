Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA725BAAD
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711093; cv=none; b=eFl30rDYtu5U8YpLXGjhVYJgABjV4Wz9l7P1ZLLoh7d162VVbqJ2Kz0J/mUgV3nrZ9lHPArNlPZGeNYZLiVtRd/0s4R9iDapfkQaD2ALxXj87rXyaAOQMtg/EVDVNuY4Yp8lt9u5yUaCy3c6fCxPoBzfEP66hIQ7uPGAdtR9t/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711093; c=relaxed/simple;
	bh=k/qqYE18dumnTrExg52yxnDgHqbEw22SqqHqyAXOR34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbyqtCaJuF910bgiV+m3j/qAlxLFaqKxRPfgQVsFtvhbhE1m/68LhDNwyxSpPiTRDTePO2Fbr5SlfJE+vXPSjQmaKYIDZkw2KB1UJRQd7TrJ1mS5w/aWh/RhvZNZR9ZWeV8Xaj1TPUhXa0KCe4vQDIfak83jYf6fZQbRpCkzR4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CcS3x7I1; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CcS3x7I1"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bf251025aso44530971fa.1
        for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741711090; x=1742315890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2J/hC01hBS+/+SHi16lHvEsy7aFLaWqMUUObIUNbiY=;
        b=CcS3x7I1Def8YQPhV2sP4D3Jaw73ir+Hqb2lRf8CvdOJs1E/ruu7l1w0x5BUpNd33x
         pnwTtsQQnnfAwAzfNiYVtiamjBPaE8N/N2OwTyRYsPDwJie3vdd6MOU6ZOjN5WnQUD8L
         NmGhhDt3lMKlpQYGGYJraQoCgcTYy3tvWD/lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711090; x=1742315890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2J/hC01hBS+/+SHi16lHvEsy7aFLaWqMUUObIUNbiY=;
        b=wMeCEEvVg56yPaPj+Ck1gdNHRYsSCCwTErzUENHhp81kJ2yNecgghB++2t43qH938m
         yJgOKW0YigigpzqYwllgNhasvuc5o/TtFOS50k03JgH1x7VHDUKmEpJy42P7AufeGR1p
         UwpTLpIyXafEplBEZ3lQyiU5z0f1eIiBdEUwars2pMsymOY9tUsM7DrMNCyjrpVBPJy8
         ruhNYxmb5JajC5nDuUEjPtkKHH/UoMR7F1Sanq1W5Hg6ztlMs6K/2OWMFgzHGpZQ7OpS
         lec52cKkR30Hv4bfIKWKW3ShaNfnaAOQSWToxB5aI2Wpy7Qdvdy+RCiKPGz27KWW9jvg
         nd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIF/MD7xxLNdkTvOdGX6vW+r9DqEY48zEaxH2aA82ZphkMTV12GLObKVt4ChgpQjW9XS98HctT@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzrv/yp24ANkrkbAecmNyKQ/4fJ9EfRZpZ6CRGq735So3YOtL
	0dRB2eT8e4pe4hmi8VBTDpJkk94FoqqXzRNeiOSdBVR8QbyrDHyvTPRUJeM8TZgEM6Kycg1zwkg
	BsIJiFuPOyW7cS7QqRnFlGAsPJsZEy542BpmQ
X-Gm-Gg: ASbGncuGFCA5PDXHWdOAODOgeP6UYqzsE7kkxuelZzRQGIE4eRSK3y/DfCpMD/J2jCQ
	F3la4UbIQjjkObz/5nM181pzcG03a6xfwjuv+EhJjVh9OPUip9seWt/vNVDXMrtQVw/SFiwPXN/
	ZERLnukdxCYjc6EH5AH+UPJaLmVrditkjjywhM
X-Google-Smtp-Source: AGHT+IE17lMcS87AcZdY9lwHljntIGFjrdX/tIws8/mMJWqlvfj4BKIje8AtAeZJAoP34LDD7scalOwGJSBgf3KZaUc=
X-Received: by 2002:a05:6512:118a:b0:549:4a13:3a82 with SMTP id
 2adb3069b0e04-54990e5db47mr6045073e87.21.1741711089888; Tue, 11 Mar 2025
 09:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303200212.3294679-1-dualli@chromium.org> <20250303200212.3294679-2-dualli@chromium.org>
 <CAHC9VhRiZS2Dh+0-GqHE+um7T05p4_=EXG7tOtC5pciWMteDDw@mail.gmail.com>
In-Reply-To: <CAHC9VhRiZS2Dh+0-GqHE+um7T05p4_=EXG7tOtC5pciWMteDDw@mail.gmail.com>
From: Li Li <dualli@chromium.org>
Date: Tue, 11 Mar 2025 09:37:59 -0700
X-Gm-Features: AQ5f1Jq-kymgLHVS7YmwSl159Xa7tY4tbyEsovgee_yrgxg5Hu6qlOytWyioff4
Message-ID: <CANBPYPhkYPYGSxhBWbJ2pMqf_iYqNE6H9=ND9ONuTxoPviW=3g@mail.gmail.com>
Subject: Re: [PATCH v16 1/3] lsm, selinux: Add setup_report permission to binder
To: Paul Moore <paul@paul-moore.com>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, 
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, tweek@google.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 1:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, Mar 3, 2025 at 3:02=E2=80=AFPM Li Li <dualli@chromium.org> wrote:
> >
> > From: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > Introduce a new permission "setup_report" to the "binder" class.
> > This persmission controls the ability to set up the binder generic
> > netlink driver to report certain binder transactions.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  include/linux/lsm_hook_defs.h       |  1 +
> >  include/linux/security.h            |  6 ++++++
> >  security/security.c                 | 13 +++++++++++++
> >  security/selinux/hooks.c            |  7 +++++++
> >  security/selinux/include/classmap.h |  3 ++-
> >  5 files changed, 29 insertions(+), 1 deletion(-)
>
> ...
>
> > diff --git a/security/security.c b/security/security.c
> > index 8aa839232c73..382e3bbab215 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1043,6 +1043,19 @@ int security_binder_transfer_file(const struct c=
red *from,
> >         return call_int_hook(binder_transfer_file, from, to, file);
> >  }
> >
> > +/**
> > + * security_binder_setup_report() - Check if process allowed to set up=
 binder reports.
>
> Please keep the line length in the LSM and SELinux code to 80
> characters or less.
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 0d958f38ff9f..2fafa8feafdf 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2092,6 +2092,12 @@ static int selinux_binder_transfer_file(const st=
ruct cred *from,
> >                             &ad);
> >  }
> >
> > +static int selinux_binder_setup_report(const struct cred *to)
> > +{
> > +       return avc_has_perm(current_sid(), cred_sid(to), SECCLASS_BINDE=
R,
> > +                           BINDER__SETUP_REPORT, NULL);
> > +}
>
> There should also be an associated patch{set} against the
> selinux-testsuite to add tests for the binder/setup_report permission
> introduced here.  My apologies if you've already posted one, but I'm
> looking now and I don't see anything either on the lists or on GH.
>
> * https://github.com/SELinuxProject/selinux-testsuite
>
> --
> paul-moore.com

Thank you very much! I'll add such a test, along with other binder
fixes mentioned by Carlos.
