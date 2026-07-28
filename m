Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E43914E4
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257688; cv=pass; b=ZayhT5NpCLMu7g8CxoeP3CvjkqiZI/lA6LiCRvmAA04iND1qZ5x66AtZGhwt/TLJqJcwANFW1TgRFzHXWeLMfN4okA6EsFZqFqEy0HI7xXY3g6FjV+e0OR9pmzMTufZ9nxGFHX45cITQSp2tNNIqgr+LiHToCTxr9Ryi03Lkt5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257688; c=relaxed/simple;
	bh=jnKol/JhnaKXF11EXvTTtOS3g9rVyyISXK4UFL3hC98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDkfv5ybH3flUP/ZthEV2mjZKn1qTeI2hNI0IC3d84TpRnAlojL8CzmNOVkbEYX7ycQJWrEbUtY1vqsq/bwQGDe6HKHnftqYhe8c7trhFZ5lInIjO8S/NSycr1WcLhOM1YuHKrACieFi2UmGjOKnRgSFdoXNEYDZL0hbjdxPEoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FItrzPkD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTA+mG4/; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FItrzPkD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTA+mG4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785257684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRZfJpCgnwFtk1rjxZHiySXCoUUtUtC4/xAChJ8EDlU=;
	b=FItrzPkDbuSM7sBzzdjEOtYoZzJatJy1qFo+M5uBNSPcvqES1iaw0dCcgw6sEs1gY6Xa49
	9QUXRrPsh+C2MsyS1siFl7UkrGlVvr3QU60ixN6YqYGmZ2ibcItCBqVeNPSO9enMysJt9P
	jPC/sCq5I9CQv8/iwEWe3lfNJlVRpa8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-FSk2mxJLPCiOg9_dpaCI-Q-1; Tue, 28 Jul 2026 12:54:43 -0400
X-MC-Unique: FSk2mxJLPCiOg9_dpaCI-Q-1
X-Mimecast-MFC-AGG-ID: FSk2mxJLPCiOg9_dpaCI-Q_1785257682
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca3673560so1449095ad.1
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 09:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785257682; cv=none;
        d=google.com; s=arc-20260327;
        b=Ab52sxOGf2msG0FgBlFM96+b2LLlC9G5zy3nPppxzUErVIgKp11EyOJFDhcapnyJhQ
         IxnG4WjYAhQ6nMTpQKp5Dpr7jsTXZV8kbg+1AZLxAoJm0eHttBABFRYGsGU+cVS0QHNe
         6Q0sVmFROgQka9255TLPty8uhQZNFF55NG6JoFODJBneZzhQW24GazXtvA6KkAlYKyWX
         DgF2YuxY1z7A3gDvlFzC5d+QWIr2P5RH3kzNMfbAhyvm1d+CFzamUhuKnI35WgFWEm5V
         nbi4RRuniQLxgT75hpNd34/71wNZuWVs7veK/B7psAxPofUIKlGNSZFo651VZdfUxqKp
         EzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRZfJpCgnwFtk1rjxZHiySXCoUUtUtC4/xAChJ8EDlU=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=X5+ySeiBwl1MPEJ5HWervMyPA507AmZPmAKZAsgxbZpb/kVzyyqSotIAvek2vsgFG1
         lJWqffyRVvRqMEwxK+z8vUbIMDJmz/Y1XYqXjExn8yIYq80dxAk7ICXQdAwryMlV+txa
         4SfWbxmyxOm4sNZBm04OUxTUk6xiM22su+y8fBZFo6/4ibfKLmWsU/9Bz4mBRP5Vx75T
         DKdd6JCp1re9lHaEXSOr4cIouiRwU7jeNvoN6pXxyLr3B0xPM4wiwQn7l8aSuMpzFSnJ
         HZUrQ3VoGNR92eMPtFDh3+D6G73TAm+Op1mtZiuRLGmyNMhfB3Y96g2Phz4jcpwO/Bou
         vakw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785257682; x=1785862482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aRZfJpCgnwFtk1rjxZHiySXCoUUtUtC4/xAChJ8EDlU=;
        b=DTA+mG4/LDOmFuayufFZtCFgsOPMv98gPiysKJK7xF2q5mS77s/HFndT424jqcqwtA
         92ewpF8a+OYbFIu+EUpF1kpeVlaaXtdUJShA6i3ACJtliaas3rqQR77HEX4wDDoH1czW
         /1GB9fM1u/BtdWhSo+UB3exNt6XQIENxI23Z8aEdWZNFspAylPhT1kmm0vLUMN+1Am0Y
         bPHN346gkcxFEMiI28Jt7KJzb5ubdRAOmJ+1syjnsPYh73lDZLs4XDCxEczWlQSDBL8T
         4IF6IpPz6UiWX/LTd1lxDsDNZM11piMeFCXMgvwnCYH/YId/KL4PCInJ5oQwiZfkDIpc
         y5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785257682; x=1785862482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRZfJpCgnwFtk1rjxZHiySXCoUUtUtC4/xAChJ8EDlU=;
        b=l3V8NE73Kugee9GI04n/kYuVMeqDBgPfuOCqp/HUhnKGLmq2Gdv6vVkByj4Xf7z0qh
         ndPiRg5Xb91YwevXJGOhfXLWpwvtJohQFeWWTC6wT6KV9uA8904n7V8bh7uuAqR+qiZ0
         ysHCxMfRPXn+bq6+Y5mCExi6aTpdGYwjah9hEdV6htP1VN7NUGyruGmPisFsFnWkVHkV
         FmlXcmDe4oWI30qvnHKYgQi/AP2LWc0KPy0ZGhStC2DYzjIosu9mDqjYLzQJHU5tWLvp
         ym5mAtAPH+Mmxqi087HMuQzyIteUQjRZjrvstZx6lG8tg6K0ioXB23gKXxtLvjSPkdYk
         6OAw==
X-Gm-Message-State: AOJu0YxV+0+9jMDjmC0HyhOoF3fR5ntsVGFuNywkbtYpkOgRkkXU8NiY
	rZnPjCpm4J+XJ2pzKdNlMT1GX3/n5/GMW/UBto8O1T2I0eAIg47dErXJ/Mexo2mnYWkuf+1YwFc
	+4E2IUiVMI3ySNGWTlR4ZeLyQju4TT0b7YX1cxhkLlH9Idz5/rgjRmadrtzJpesNypdMSORt3/d
	Lb3yFrZEDOWBIaIFCeh35HUGVT+aDy9fcCj6Ug8mQPdj1t
X-Gm-Gg: AR+sD10wk4aCg2RxJ7hkpAhVh99kdEGQ4kpPFpPEssdJQ5ihcmHJ3l7Dc3WcjSyeKGc
	lmH9iqSGYQEO2xi6EqMcatn4373FZNJj1upItqyfCyCAwPhCs6nDv0RtjA96d5KEx/2Fhrd0H8b
	WO+JsEHMlbvfhoF0xCYrYAAr/2tWsqvqgCt3mjPOJxX9bmN4PjAB/uZeQi0+mSfWllzeG58jawP
	CNfvN6nGEfp7gvM
X-Received: by 2002:a17:902:d550:b0:2cc:aa38:4df3 with SMTP id d9443c01a7336-2d015af4dcemr41610875ad.13.1785257682300;
        Tue, 28 Jul 2026 09:54:42 -0700 (PDT)
X-Received: by 2002:a17:902:d550:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2d015af4dcemr41610465ad.13.1785257681783; Tue, 28 Jul 2026
 09:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727223242.2507658-1-akkohli@redhat.com> <20260727223242.2507658-2-akkohli@redhat.com>
 <CAEjxPJ4cNnYyN=YSXYArpUwFBSf-CkSNcKNLFnBQ_fkedKPHFw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4cNnYyN=YSXYArpUwFBSf-CkSNcKNLFnBQ_fkedKPHFw@mail.gmail.com>
From: Akhil Kohli <akkohli@redhat.com>
Date: Tue, 28 Jul 2026 18:54:30 +0200
X-Gm-Features: AUfX_mz6mYM6Sb6rMBiJni757NJgm8QGX4gH5B-1p_SrJTpidDrdHaSnh4wwpXI
Message-ID: <CANu4e6OdUmFW5WRbeoNY3am=P9hzhOy6-0_qJJiRROM5CSghJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] checkpolicy: extend bad-data tests for type, role,
 and user errors
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry I missed that comment. In v3, bad_user.te
now has a require block and scaffolding so checkmodule fails on
garbage_token as the harness expects.

On Tue, Jul 28, 2026 at 2:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 27, 2026 at 6:33=E2=80=AFPM Akhil Kohli <akkohli@redhat.com> =
wrote:
> >
> > Add negative .te fixtures for duplicate type/attribute declarations,
> > type/attribute name conflicts, invalid type names, and malformed role
> > and user stanzas. Run checkmodule negative tests as non-root in CI so
> > the unreadable .te case is exercised outside root-only skips.
> >
> > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> > ---
> >
> > diff --git a/checkpolicy/tests/negative/bad_role.te b/checkpolicy/tests=
/negative/bad_role.te
> > new file mode 100644
> > index 00000000..3aae2719
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/bad_role.te
> > @@ -0,0 +1,12 @@
> > +module bad_role 1.0;
> > +
> > +require {
> > +       type foo_t;
> > +       class file { read };
> > +}
> > +
> > +role bad_role_r types ;
> > +
> > +type foo_t;
> > +
> > +allow foo_t foo_t:file read;
> > diff --git a/checkpolicy/tests/negative/bad_user.te b/checkpolicy/tests=
/negative/bad_user.te
> > new file mode 100644
> > index 00000000..e7460dd7
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/bad_user.te
> > @@ -0,0 +1,3 @@
> > +module bad_user 1.0;
> > +
> > +user bad_user_u garbage_token;
>
> You might have missed my earlier comment, but again:
> this fails NOT on "garbage_token" but on "user" because of
> the lack of any "requires" block to meet the grammar
> requirement for avrule_decls. Is that intentional?
>

