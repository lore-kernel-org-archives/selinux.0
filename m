Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8D2628D
	for <selinux@vger.kernel.org>; Fri, 27 Sep 2024 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401557; cv=none; b=eFtiepJbgEeSbaAkAjFOSgYF7Lp8fNA/otgF6fjU7LghtU/teK4GXr9KJAWc2hQZyoh1jfbKdBKTsAftTaoUTlFsoaFKpdonDbU22kKpgTrE2lA2kz7E109gjqBXtmAg1K6xvSXbl2nsLLA5HNIKSKa+pntej2Kgwz++BAOsZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401557; c=relaxed/simple;
	bh=YuJ+sXF9f/pnc9KPRT4Py5Rel5OXlxI1dCz5w7BAeCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zozlr6DxEsWcWbWbyOGjLE1Pr+3+3f0kr+BxldHT9TU81r9njUN75CRNwLxgSCxtO0e8YFHPbsSqrqb8qCqeqZALWtuUJWMJwUXKEuumD33ZCgtlj7QbiuKGCzAlThnmLb6DQiEKeiDQbODUQ61Zi58ls5uxASjUfw/kl46s3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vNzwlvSu; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNzwlvSu"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-536552fcc07so7473e87.1
        for <selinux@vger.kernel.org>; Thu, 26 Sep 2024 18:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727401554; x=1728006354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vZ6lvHGrrTQCwoQAECNwIg9MJ8VboySHc0XOezfhC4=;
        b=vNzwlvSu7fSiUgBc00TzfVNqTTbga/qke0qo0imrC8zKWa3+99zWgmme/0POl2rHcp
         yU9X/9Eej//zmd/xseAkwUKm43BVbOW/tbHBhuMeZmqVLP9WHjQUxWoi3ChoCt+2GZ/I
         V4J82aCjHNGy5mo83BcfGuQmEyW7CgtjxBXtc1fsjMATMOh1ecZ/bip0s+6nxHD6BRSR
         sMXMAHR3UeFOPcO3OyJ2Izk235DfET26IsGmOaMufp8EE3Ci8kPDdjGmrMDrzpU57zPX
         WdzKY5yjIPksUkp9e522aEZUEeCCJzTqCppFrrMq/Hk2l6m/wKlfWQHMNj9jZTVzVAK5
         1Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727401554; x=1728006354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vZ6lvHGrrTQCwoQAECNwIg9MJ8VboySHc0XOezfhC4=;
        b=ImIdsYJU3R57nNIARqjP8dZ2TG008bzuD+FPUCHaQlVF9DzwBbyyALUvBEQWllSE/9
         9n93+/vuykwv6daU6t0Si1r4d9/rAGs6v6/DB/zEyn8r0SB65N3FdDOTTrUErHdK309m
         /j453zLL/MVl5pNc+xY4QoXf6Od7j2a8MA296ENU12FZbzjiCtIASZMVxBEw1tf/ve9m
         aXlg+Djzm2IV66zTiITKlaChsJXns4TpH1wErfLjvO4PyEqga8dFM5I22++bHsLs0J2h
         lW0d3rxQVCDKZAiuXOpFPxrVzzGhYm0zrQ9gMK9Z3gdk6jElxn9e8Uazq5cta95e4InN
         lj1A==
X-Gm-Message-State: AOJu0YyLlxJaVPdtjEue9PqZX0w/rwIeyEhuppNzSbMkX+kAJkwoLFUC
	n6VEVY68WFo3hwPVTJ/R7PIc/Ms7xnbhXB+fO84r8ymRqYm/K/8J7EBERz1/M9qVd9IGig/Xelr
	7qJ7V/2T63Vpx09K4Oy34s8UOvHW53b3X9m7Gx/FARdJK03tkobYb
X-Google-Smtp-Source: AGHT+IF67S2ESH2aM2GXWcryhC3b8uliki9QVFajCxWirQcAboQAKEzakQ6CnBTAX+UcZq/vLd5LrmS66XGeeSUyQmc=
X-Received: by 2002:a05:6512:ea9:b0:52c:dd94:73f3 with SMTP id
 2adb3069b0e04-5394ba864a1mr113728e87.3.1727401553969; Thu, 26 Sep 2024
 18:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925201106.16134-3-paul@paul-moore.com> <CA+zpnLceV4b0ittytzn3OHw+b4h2Wpa76LSyjsjZkz-xtoHhcg@mail.gmail.com>
 <CAHC9VhTSnK=E_HCFJbsWip35TpqDAMSbp6MhsFE1jNy=CfCA6w@mail.gmail.com>
In-Reply-To: <CAHC9VhTSnK=E_HCFJbsWip35TpqDAMSbp6MhsFE1jNy=CfCA6w@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 27 Sep 2024 11:45:34 +1000
Message-ID: <CA+zpnLcLGxUUdvOPzXeP5ZPWiXB+pUYq2pu+yBqsmu89zMtSww@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: streamline selinux_nlmsg_lookup()
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:45=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Sep 25, 2024 at 8:48=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> > On Thu, Sep 26, 2024 at 6:11=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > Streamline the code in selinux_nlmsg_lookup() to improve the code flo=
w,
> > > readability, and remove the unnecessary local variables.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/selinux/nlmsgtab.c | 90 ++++++++++++++++-------------------=
--
> > >  1 file changed, 39 insertions(+), 51 deletions(-)
> > >
> > > diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.=
c
>
> ...
> >
> > Should it be NETLINK_AUDIT_SOCKET__NLMSG here?
>
> Yes it should, thanks!
>

With the right constant:

Tested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
