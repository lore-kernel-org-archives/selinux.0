Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D45229B28
	for <selinux@vger.kernel.org>; Mon, 28 Jul 2025 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742054; cv=none; b=P+4GRDWC8tO53oKiRArOwJnL2ecAHcaZdQ+wwtS5SSn2T2IjeS4XILOV1hUp08TwzpKGUTLlgdSkKL8bR0O1lkn++o8eWam+UBkQw2MdgZ2eS8oFUlRgsrNFcmtRITtKkHurAgZrdzAE5estX72lCHZiEbXCmZk4DFxMwB63fwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742054; c=relaxed/simple;
	bh=sPZcX5ETkRkiJ/sMnu035foPVHqPhbI57EiOWs7UoFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVVmLlruNOeTv+cgkNgZ3rthgXyre9Bs2p5D0zForLsuAuEYkX1W4xoGVpwsBdwZEZEaQeVdfBDkP282RELugLderu2waDWQNNG4JdH2JiO2z2p1sGVnGIArIk+E5EX1NlOAHCNosQRGDdbkYq98N1c9jiMr3kBQ4HqLC53DJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BAQQVvjo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BAQQVvjo"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8e03314c41so1898704276.2
        for <selinux@vger.kernel.org>; Mon, 28 Jul 2025 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753742052; x=1754346852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxvcUsNhJgTxupj821AHIcY8DElHclblBesN4OnHvqU=;
        b=BAQQVvjo4+r/Rzygo5DaWFjibtyvfNSBEIAvOD2YZAmRfCJgAeN5d92QtGcXCTMZB+
         uROPtj6URai/NAWG0JQSDJDQLGtA/et4nx9Vmn1jy55XccfERZE3BxWO11q4W7KYJnuN
         J+1g2FtiLFdLd16/YPnjLc8qB5rcFiVfcv14s64asdDcqEtQfg/puNFTDHhq4w43Ti4d
         P3f+M61dufnh4xi9zO/owE/+pAfi8HczuCxx1lAm+Mh84WJAGTWHFRvT7X90xCQRSJFi
         e1aPWQ2hOEZfzFcasZtid7+FQM8Hl1RBolkDguYNj2FeKSsQqULgt5oiwkYmQBDinJo0
         ZJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753742052; x=1754346852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxvcUsNhJgTxupj821AHIcY8DElHclblBesN4OnHvqU=;
        b=eWVRk74UU1kw16WrFuzryCS0sjG39JfQOjpSA8AlXL517XbB+/2gvgr9fd/yLzFoqA
         v5YSnYfvC1MkYakyz2KgibFs+fVMSGEKsCk7qfuQFlM+IRDpxToCCGcMi2FLleA63v6L
         KsCPAYrJsLxjroSqAjc5XrkNaNCe0vI5NaQkiU5D4AwaaETbuXlWW/Q4Vfw17h1VtqPy
         VZp5ce732PLgqYb+Fe9xP2PISshZt255em11slmLWB7gOWtIPEuBzAAlTM/eb/xXXg32
         POHWgqr0EWPRAB1A8RnGDSv/150uyKp9ZyWoanB2p4tLbFrx4eFUUNtWKUkwtI50RyS1
         7uOg==
X-Forwarded-Encrypted: i=1; AJvYcCUnNp6sB62uZTGy7s9acKiO8bfeGzJ20PFXzrP3u+V+RjxIGyeWNzISNWu8AHyAkmcRTKbhAlQw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12wDjL+d9vl0GQXNHaho1w7JXIwiDXABXAtYc/FOaaL+wcO2q
	GOPOzDj+pz2h+RM52yg0Uff4J81zBCEoPj66NlwaH++I19eNLw5yBgcU971eR5zNaYzH238lBhZ
	HbeAlwi6WaRTbZWYOiET+bvixsbBGPEivC+8rnpsb
X-Gm-Gg: ASbGncs6ROUBe7Zn+EW6Vph0hCAN3/I59qpRvlwNSs55puzjXlnVCUtUQcZ5zd9yNi7
	h3e/zY2C0yVAtUm9Agtd/keb/4+THkoKwWc7QvhoHHyW7bjL8TfPdlljjBcmqzd/WlijZbjZFmK
	movJWq/KMEIDM//Dtxgzbb6JL9dU66opjdhr/UGCu0n1y3Wcl66Yo55xWkAwcy8x8rkdMIYqwGy
	74EDC8=
X-Google-Smtp-Source: AGHT+IFL3W4827GDMXMSQDjasWXwEUHowvOtptVCyqMAy54udRGPNZxYAyTwlijvBSOV3qH587CqZUfiWhf0PRqfd18=
X-Received: by 2002:a05:6902:1704:b0:e8e:219f:a662 with SMTP id
 3f1490d57ef6-e8e219faa10mr3054599276.26.1753742051862; Mon, 28 Jul 2025
 15:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-62-paul@paul-moore.com>
 <5ff016adea8969e4a97387d4ed88a172bdc4b3de.camel@huaweicloud.com>
In-Reply-To: <5ff016adea8969e4a97387d4ed88a172bdc4b3de.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Jul 2025 18:34:00 -0400
X-Gm-Features: Ac12FXzQAYGZ-9s23WBgAfhFxpylH2DbTwTSk8I658l0CgcFmUXiJS_noueOtGo
Message-ID: <CAHC9VhTh1=Qh2_4YKsXyC8dT6BFyh3nVbhfexLFsAWh7wiUCjg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 26/34] smack: move initcalls to the LSM framework
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 5:46=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2025-07-21 at 19:21 -0400, Paul Moore wrote:
> > As the LSM framework only supports one LSM initcall callback for each
> > initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> > wrapped with a new function, smack_initcall() that is registered with
> > the LSM framework.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/smack/smack.h           | 7 +++++++
> >  security/smack/smack_lsm.c       | 9 +++++++++
> >  security/smack/smack_netfilter.c | 4 +---
> >  security/smack/smackfs.c         | 4 +---
> >  4 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > index bf6a6ed3946c..885a2f2929fd 100644
> > --- a/security/smack/smack.h
> > +++ b/security/smack/smack.h
> > @@ -275,6 +275,13 @@ struct smk_audit_info {
> >  #endif
> >  };
> >
> > +/*
> > + * Initialization
> > + */
> > +int init_smk_fs(void);
> > +int smack_nf_ip_init(void);
>
> I made the following changes (due to not having
> CONFIG_SECURITY_SMACK_NETFILTER) ...

Nice catch, thanks Roberto!

I made a slight change to use the defined(SMACK_NETFILTER) macro as
done elsewhere in the Smack code, but otherwise it looks good to me.
Casey, are you okay with this?

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 885a2f2929fd..3662d61bb32e 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -278,8 +278,15 @@ struct smk_audit_info {
/*
 * Initialization
 */
-int init_smk_fs(void);
+#if defined(CONFIG_SECURITY_SMACK_NETFILTER)
int smack_nf_ip_init(void);
+#else
+static inline int smack_nf_ip_init(void);
+{
+       return 0;
+}
+#endif
+int init_smk_fs(void);
int smack_initcall(void);

--=20
paul-moore.com
